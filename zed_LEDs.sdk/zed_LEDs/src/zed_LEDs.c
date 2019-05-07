// zed_LEDs.c



#include <stdio.h>
#include "platform.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xil_printf.h"
#include "xscugic.h"
#include "xuartps.h"
#include "xuartps_hw.h"
#include "xil_exception.h"
#include "xspi.h"
#include "sleep.h"


#define FAKE_DATA

#ifdef FAKE_DATA
void load_sawtooth_data(void);
#define SAWTOOTH_MAX_VALUE 100
#define SAWTOOTH_STEP_VALUE 1
#endif


//----------------------------------------
// for gpio
//
#define SWITCHES_AXI_ID		XPAR_AXI_GPIO_0_DEVICE_ID
#define LEDS_AXI_ID			XPAR_AXI_GPIO_1_DEVICE_ID
#define BUTTONS_AXI_ID		XPAR_AXI_GPIO_2_DEVICE_ID
#define BUT_INTC_DEVICE_ID	XPAR_PS7_SCUGIC_0_DEVICE_ID

#define SWITCHES_CHANNEL	1
#define LEDS_CHANNEL		1
#define BUTTONS_CHANNEL		1
#define INT_PushButtons		XPAR_FABRIC_AXI_GPIO_2_IP2INTC_IRPT_INTR

#define UP		16
#define DOWN	2
#define	LEFT	4
#define	RIGHT	8
#define CENTER	1

#define MAX_DELAY_USEC	500000
#define MIN_DELAY_USEC	25000
#define STEP_DELAY_USEC 25000

#define	INTERRUPT_MASK 0xFF
//----------------------------------------



//----------------------------------------
// for SPI
#define SPI_INTERRUPT_ID	XPAR_FABRIC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR
#define SPI_INTERRUPT_CONTROLLER_ID		XPAR_PS7_SCUGIC_0_DEVICE_ID
//----------------------------------------


//----------------------------------------
// for UartPs
//
#define INTC				XScuGic
#define UARTPS_DEVICE_ID	XPAR_XUARTPS_0_DEVICE_ID
#define UART_INTC_DEVICE_ID	XPAR_SCUGIC_SINGLE_DEVICE_ID
#define UART_INT_IRQ_ID		XPAR_XUARTPS_1_INTR
#define UART_BASEADDR		XPAR_XUARTPS_0_BASEADDR
#define RX_BUFFER_SIZE	30
#define TX_BUFFER_SIZE	1000
#define KEY_U			117		// keyboard 'u' for UP button
#define KEY_D			100		// keyboard 'd' for DOWN button
#define KEY_L			108		// keyboard 'l' for LEFT button
#define KEY_R			114		// keyboard 'r' for RIGHT button
#define KEY_SPACE		32		// keyboard spacebar for CENTER button
#define CMD_READ_DATA	0x61	// read data from tester - should be followed by
								// 4 bytes(unsigned int) for length msbyte first
#define CMD_LOAD_SAWTOOTH_DATA1	0x62	// load test data1(sawtooth up) into TxData array
#define CMD_LOAD_SAWTOOTH_DATA2	0x63	// load test data1(sawtooth down) into TxData array
//----------------------------------------




//----------------------------------------
// state machine bit definitions
//
#define STATE_LED_RUNNING		0x01
#define	STATE_UPDATE_CONDITIONS	0x02
#define STATE_SERVICE_UART		0x04
//----------------------------------------



//----------------------------------------
// function declarations
void PushButtons_ISR(void *data);
void advance_LED_state(void);
void update_conditions(unsigned int);
void init_gpio(void);
s32 init_gpio_interrupts(void);

int SetupUartPs(INTC *IntcInstPtr, XUartPs *UartInstPtr,
			u16 DeviceId, u16 UartIntrId);
static int SetupUartInterruptSystem(INTC *IntcInstancePtr,
				XUartPs *UartInstancePtr,
				u16 UartIntrId);
void UartPsISR(void *CallBackRef, u32 Event, unsigned int EventData);
void read_uart_bytes(void);
void send_Tx_data_over_UART(unsigned int);
void load_sawtooth_down_data(void);
void load_sawtooth_up_data(void);
unsigned int get_num_data_points(u8 *RxData);
void SpiIntrHandler(void *CallBackRef, u32 StatusEvent, u32 ByteCount);
static int SpiSetupIntrSystem(INTC *IntcInstancePtr, XSpi *SpiInstancePtr,
					 u16 SpiIntrId);
//----------------------------------------



//----------------------------------------
// variables
XGpio sw_gpio, leds_gpio, buttons_gpio;
static XScuGic interrupt_controller;	//instance of the interrupt controller

XUartPs UartPs	;						// Instance of the UART Device
// @note: why static?
static u8 UartRxData[RX_BUFFER_SIZE];		// Buffer for Receiving Data
static u8 UartTxData[TX_BUFFER_SIZE];		// Buffer for Transmitting Data

char running = TRUE;
char light_to_left = TRUE;
Xuint32 LED_delay_usec = 250000;
unsigned int LEDs_GPIO_value = 1;
unsigned int state = STATE_LED_RUNNING;
unsigned int switches_GPIO_value;
unsigned int buttons_GPIO_value;
unsigned int cmd;
int Status;
volatile int SpiTransferInProgress;
volatile int SpiErrorCount;

static XSpi  SpiInstance;
XSpi *SpiInstancePtr = &SpiInstance;
#define SPI_BUFFER_SIZE 3
u8 SPI_ReadBuffer[SPI_BUFFER_SIZE];
u8 SPI_WriteBuffer[SPI_BUFFER_SIZE];

int main()
{
	int looping = 1;


    init_platform();
    xil_printf("\n\nRunning Zedboard LED application...\n");

    init_gpio();
    init_gpio_interrupts();
    xil_printf("done setting up GPIO\n");

    Status = SetupUartPs(&interrupt_controller, &UartPs,
    				UARTPS_DEVICE_ID, UART_INT_IRQ_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Failed to set up UartPs\r\n");
		return XST_FAILURE;
	}

	xil_printf("  waiting for received UART data...\n");

//###################
// SPI
	XSpi_Config *ConfigPtr;	/* Pointer to Configuration data */

	/*
	 * Initialize the SPI driver so that it is  ready to use.
	 */
	ConfigPtr = XSpi_LookupConfig(XPAR_SPI_0_DEVICE_ID);
	if (ConfigPtr == NULL) {
		return XST_DEVICE_NOT_FOUND;
	}

	Status = XSpi_CfgInitialize(SpiInstancePtr, ConfigPtr,
				  ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test to ensure that the hardware was built correctly.
	 */
	Status = XSpi_SelfTest(SpiInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the Spi device to the interrupt subsystem such that
	 * interrupts can occur. This function is application specific.
	 */
	Status = SpiSetupIntrSystem(&interrupt_controller,
								SpiInstancePtr,
								SPI_INTERRUPT_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Failed to set up spi interrupts\n");
		return XST_FAILURE;
	}

	/*
	 * Setup the handler for the SPI that will be called from the interrupt
	 * context when an SPI status occurs, specify a pointer to the SPI
	 * driver instance as the callback reference so the handler is able to
	 * access the instance data.
	 */
	XSpi_SetStatusHandler(SpiInstancePtr, SpiInstancePtr,
		 		(XSpi_StatusHandler) SpiIntrHandler);

	/*
	 * Set the Spi device as a master.
	 */
	Status = XSpi_SetOptions(SpiInstancePtr, XSP_MASTER_OPTION);
	if (Status != XST_SUCCESS) {
		xil_printf("failed to set up spi options\n");
		return XST_FAILURE;
	}

	// Select the SPI Slave.  This asserts the correct SS bit on the SPI bus
	XSpi_SetSlaveSelect(&SpiInstance, 0x01);

	/*
	 * Start the SPI driver so that interrupts and the device are enabled.
	 */
	XSpi_Start(SpiInstancePtr);


	SPI_WriteBuffer[0]=0xAA;
	SPI_WriteBuffer[1]=0xAA;
	SPI_WriteBuffer[2]=0xAA;
	SPI_ReadBuffer[0]=0x00;
	SPI_ReadBuffer[1]=0x00;
	SPI_ReadBuffer[2]=0x00;
	u16 spi_result = 0;

	/*
	 * Transmit the data.
	 */
	while (1){
		SpiTransferInProgress = 1;
		XSpi_Transfer(SpiInstancePtr, SPI_WriteBuffer, SPI_ReadBuffer, SPI_BUFFER_SIZE);
		while (SpiTransferInProgress);

		spi_result = SPI_ReadBuffer[0] << 14;
		spi_result |= SPI_ReadBuffer[1] << 6;
		spi_result |= SPI_ReadBuffer[2] >> 2;
	}



    //###################################################################
    //-------------------------------------------------------------------
    while(looping){

    	//------------------------------------------------------------------
    	// if the LED display is running take care of next LED to
    	// illuminate, then delay here (update later to use timer and interrupts)
    	if (state & STATE_LED_RUNNING){
    		XGpio_DiscreteWrite(&leds_gpio, LEDS_CHANNEL, LEDs_GPIO_value);

    		advance_LED_state();

    		usleep(LED_delay_usec);
    	}

    	//-------------------------------------------------------------------
    	// a button was pressed so perform requested action
    	if (state & STATE_UPDATE_CONDITIONS){
    		update_conditions(cmd);
    		state &= ~STATE_UPDATE_CONDITIONS;
    	}

    	//-------------------------------------------------------------------
		// uart received data so find command and take action
		if (state & STATE_SERVICE_UART){
			read_uart_bytes();
			update_conditions(cmd);
			state &= ~STATE_SERVICE_UART;
		}

    }
    //-------------------------------------------------------------------
    //###################################################################





    xil_printf("done.\n");

   	cleanup_platform();
    return 0;
}
//------------------------------------------------------------


//------------------------------------------------------------
void init_gpio(void)
{
	//-------------------------------------------------------------------
    //Initialize GPIO for slide switches 0-7
    Status = XGpio_Initialize(&sw_gpio, SWITCHES_AXI_ID);
    if (Status != XST_SUCCESS){
    	xil_printf("error initializing switches gpio\n");
    }
    else{
    	xil_printf("success initializing switches gpio\n");
    }

    //Initialize GPIO for LEDs 0-7
    Status = XGpio_Initialize(&leds_gpio, LEDS_AXI_ID);
	if (Status != XST_SUCCESS){
		xil_printf("error initializing leds gpio\n");
	}
	else{
		xil_printf("success initializing leds gpio\n");
	}

	//Initialize GPIO for pushbuttons 0-5
	Status = XGpio_Initialize(&buttons_gpio, BUTTONS_AXI_ID);
	if (Status != XST_SUCCESS){
		xil_printf("error initializing buttons gpio\n");
	}
	else{
		xil_printf("success initializing buttons gpio\n");
	}
	//-------------------------------------------------------------------



	//-------------------------------------------------------------------
	//buttons and switches set as inputs, LEDs set as outputs
    XGpio_SetDataDirection(&sw_gpio, 1, 0xFF); //0=output, 1=input
    XGpio_SetDataDirection(&leds_gpio, 1, 0x00); //0=output, 1=input
	XGpio_SetDataDirection(&buttons_gpio, 1, 0xFF); //0=output, 1=input
	//-------------------------------------------------------------------



	//-------------------------------------------------------------------
    //Enable interrupts for buttons
    XGpio_InterruptEnable(&buttons_gpio,INTERRUPT_MASK);
    XGpio_InterruptGlobalEnable(&buttons_gpio);
}
//------------------------------------------------------------


//------------------------------------------------------------
s32 init_gpio_interrupts(void)
{
	XScuGic_Config *IntcConfig;
	IntcConfig = XScuGic_LookupConfig(BUT_INTC_DEVICE_ID);

	//Initialize fields of the XScuGic structure
	Status = XScuGic_CfgInitialize(&interrupt_controller, IntcConfig, IntcConfig->CpuBaseAddress);
	if(Status != XST_SUCCESS){
		xil_printf("error initializing interrupt controller config\n");
		return XST_FAILURE;
	}
	else{
		xil_printf("success initializing interrupt controller config\n");
	}

	//Sets the interrupt priority and trigger type for the specificd IRQ source.
	XScuGic_SetPriorityTriggerType(&interrupt_controller, INT_PushButtons, 0xA8, 3);	//0=Max priority, 3=rising edge.

	// Makes the connection between the Int_Id of the interrupt source and the
	// associated handler that is to run when the interrupt is recognized. The
	// argument provided in this call as the Callbackref is used as the argument
	// for the handler when it is called.
	Status = XScuGic_Connect(&interrupt_controller,INT_PushButtons,
							(Xil_ExceptionHandler)PushButtons_ISR, (void *)&interrupt_controller);
	if(Status != XST_SUCCESS){
			xil_printf("error connecting interrupt controller IRQ handler\n");
			return XST_FAILURE;
		}
		else{
			xil_printf("success connecting interrupt controller IRQ handler\n");
		}

	// Enables the interrupt source provided as the argument Int_Id. Any pending
	// interrupt condition for the specified Int_Id will occur after this function is
	// called.
	XScuGic_Enable(&interrupt_controller, INT_PushButtons);

	//Initialize the interrupt controller driver so that it is ready to use./
	Xil_ExceptionInit();

	// Enable interrupt
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
								 &interrupt_controller);
	Xil_ExceptionEnable();

	// Ensure that the programmable logic has all interrupts cleared before use
	XGpio_InterruptClear(&buttons_gpio,INTERRUPT_MASK);

	return XST_SUCCESS;
}
//------------------------------------------------------------

//------------------------------------------------------------
void advance_LED_state(void)
{
	if (light_to_left){
		if (LEDs_GPIO_value < 0x80){
			LEDs_GPIO_value = LEDs_GPIO_value << 1;
		}
		else{
			LEDs_GPIO_value = 1;
		}
	}
	else{
		if (LEDs_GPIO_value > 0x01){
			LEDs_GPIO_value = LEDs_GPIO_value >> 1;
		}
		else{
			LEDs_GPIO_value = 0x80;
		}
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
void PushButtons_ISR(void *data)
{
//	u32 buttons;
	xil_printf("entered GPIO interrupt handler\n");

	// 20msec delay for pushbutton debounce
	usleep(20000);

	buttons_GPIO_value = XGpio_DiscreteRead(&buttons_gpio, 1);

	// if button is pressed after debounce interval update state
	// and save desired change
	if (buttons_GPIO_value){
		state |= STATE_UPDATE_CONDITIONS;
		cmd = buttons_GPIO_value;
	}

	// Clear pending interrupts with the provided mask. This function should be
	// called after the software has serviced the interrupts that are pending.
	// This function will assert if the hardware device has not been built with
	// interrupt capabilities.
	XGpio_InterruptClear(&buttons_gpio,INTERRUPT_MASK);
}
//------------------------------------------------------------


//------------------------------------------------------------
void update_conditions(unsigned int command)
{
	switch(command)
	{
		case CENTER:

			//toggle variable indicating running condition
			if (state & STATE_LED_RUNNING){
				state &= ~STATE_LED_RUNNING;
				xil_printf("Running Stopped\n");
			}
			else{
				state |= STATE_LED_RUNNING;
				xil_printf("Running Started\n");
			}
			break;

		case DOWN:
			LED_delay_usec += STEP_DELAY_USEC ; //increase delay time
			if (LED_delay_usec > MAX_DELAY_USEC){
				LED_delay_usec = MAX_DELAY_USEC;
				xil_printf("Delay max at %d\n",LED_delay_usec);
			}
			else{
				xil_printf("Delay increased to %d\n",LED_delay_usec);
			}
			break;

		case UP:
			LED_delay_usec -= STEP_DELAY_USEC; //decrease delay time
			if (LED_delay_usec < MIN_DELAY_USEC){
				LED_delay_usec = MIN_DELAY_USEC;
				xil_printf("Delay min at %d\n",LED_delay_usec);
			}
			else{
				xil_printf("Delay decreased to %d\n",LED_delay_usec);
			}
			break;

		case LEFT:
			if (light_to_left == FALSE){ //only make change if LEDs were running to the right
				light_to_left = TRUE;
				xil_printf("run LEDs to the left\n");
			}
			break;

		case RIGHT:
			if (light_to_left == TRUE){ //only make change if LEDs were running to the left
				light_to_left = FALSE;
				xil_printf("run LEDs to the right\n");
			}
			break;
	}

}
//------------------------------------------------------------


//------------------------------------------------------------
int SetupUartPs(INTC *IntcInstPtr, XUartPs *UartInstPtr,
			u16 DeviceId, u16 UartIntrId)
{
	int Status;
	XUartPs_Config *Config;
	u32 IntrMask;


	/*
	 * Initialize the UART driver so that it's ready to use
	 * Look up the configuration in the config table, then initialize it.
	 */
	Config = XUartPs_LookupConfig(DeviceId);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XUartPs_CfgInitialize(UartInstPtr, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Check hardware build */
	Status = XUartPs_SelfTest(UartInstPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the UART to the interrupt subsystem such that interrupts
	 * can occur. This function is application specific.
	 */
	Status = SetupUartInterruptSystem(IntcInstPtr, UartInstPtr, UartIntrId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Setup the handlers for the UART that will be called from the
	 * interrupt context when data has been sent and received, specify
	 * a pointer to the UART driver instance as the callback reference
	 * so the handlers are able to access the instance data
	 */
	XUartPs_SetHandler(UartInstPtr, (XUartPs_Handler)UartPsISR, UartInstPtr);

	/*
	 * Enable the interrupt of the UART so interrupts will occur, setup
	 * a local loopback so data that is sent will be received.
	 */
	IntrMask =
		XUARTPS_IXR_TOUT | XUARTPS_IXR_PARITY | XUARTPS_IXR_FRAMING |
		XUARTPS_IXR_OVER | XUARTPS_IXR_TXEMPTY | XUARTPS_IXR_RXFULL |
		XUARTPS_IXR_RXOVR;

	if (UartInstPtr->Platform == XPLAT_ZYNQ_ULTRA_MP) {
		IntrMask |= XUARTPS_IXR_RBRK;
	}

	XUartPs_SetInterruptMask(UartInstPtr, IntrMask);

	XUartPs_SetOperMode(UartInstPtr, XUARTPS_OPER_MODE_NORMAL);

	/*
	 * Set the receiver timeout. If it is not set, and the last few bytes
	 * of data do not trigger the over-water or full interrupt, the bytes
	 * will not be received. By default it is disabled.
	 *
	 * The setting of 8 will timeout after 8 x 4 = 32 character times.
	 * Increase the time out value if baud rate is high, decrease it if
	 * baud rate is low.
	 */
	XUartPs_SetRecvTimeout(UartInstPtr, 8);

	return XST_SUCCESS;
}
//------------------------------------------------------------


//------------------------------------------------------------
void UartPsISR(void *CallBackRef, u32 Event, unsigned int EventData)
{
//	xil_printf("IRQ handler!\n");

	/* All of the data has been sent */
	if (Event == XUARTPS_EVENT_SENT_DATA) {
//		xil_printf("1\n");
	}

	/* All of the data has been received */
	if (Event == XUARTPS_EVENT_RECV_DATA) {
//		xil_printf("2\n");
		state |= STATE_SERVICE_UART;
	}

	/*
	 * Data was received, but not the expected number of bytes, a
	 * timeout just indicates the data stopped for 8 character times
	 */
	if (Event == XUARTPS_EVENT_RECV_TOUT) {
//		xil_printf("3\n");
	}

	/*
	 * Data was received with an error, keep the data but determine
	 * what kind of errors occurred
	 */
	if (Event == XUARTPS_EVENT_RECV_ERROR) {
//		xil_printf("4\n");
	}

	/*
	 * Data was received with an parity or frame or break error, keep the data
	 * but determine what kind of errors occurred. Specific to Zynq Ultrascale+
	 * MP.
	 */
	if (Event == XUARTPS_EVENT_PARE_FRAME_BRKE) {
//		xil_printf("5\n");
	}

	/*
	 * Data was received with an overrun error, keep the data but determine
	 * what kind of errors occurred. Specific to Zynq Ultrascale+ MP.
	 */
	if (Event == XUARTPS_EVENT_RECV_ORERR) {
//		xil_printf("6\n");
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
static int SetupUartInterruptSystem(INTC *IntcInstancePtr,
				XUartPs *UartInstancePtr,
				u16 UartIntrId)
{
	int Status;

	XScuGic_Config *IntcConfig; /* Config for interrupt controller */

	/* Initialize the interrupt controller driver */
	IntcConfig = XScuGic_LookupConfig(UART_INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Connect the interrupt controller interrupt handler to the
	 * hardware interrupt handling logic in the processor.
	 */
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler) XScuGic_InterruptHandler,
				IntcInstancePtr);

	/*
	 * Connect a device driver handler that will be called when an
	 * interrupt for the device occurs, the device driver handler
	 * performs the specific interrupt processing for the device
	 */
	Status = XScuGic_Connect(IntcInstancePtr, UartIntrId,
				  (Xil_ExceptionHandler) XUartPs_InterruptHandler,
				  (void *) UartInstancePtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Enable the interrupt for the device */
	XScuGic_Enable(IntcInstancePtr, UartIntrId);


	/* Enable interrupts */
	 Xil_ExceptionEnable();


	return XST_SUCCESS;
}
//------------------------------------------------------------


//------------------------------------------------------------
void read_uart_bytes(void)
{
	u8 index = 0;
	unsigned int commandByte;

	// loop through Uart Rx buffer and store received data
	while (XUartPs_IsReceiveData(UART_BASEADDR))
	{
		UartRxData[index++] = XUartPs_ReadReg(UART_BASEADDR,
					    					XUARTPS_FIFO_OFFSET);
	}

	//take first received byte as the command
	commandByte = (unsigned int)UartRxData[0];

	// check received byte for valid command
	switch (commandByte){
		case (KEY_U):
			cmd = UP;
			break;

		case (KEY_D):
			cmd = DOWN;
			break;

		case (KEY_L):
			cmd = LEFT;
			break;

		case (KEY_R):
			cmd = RIGHT;
			break;

		case (KEY_SPACE):
			cmd = CENTER;
			break;

		case (CMD_READ_DATA):
			send_Tx_data_over_UART(get_num_data_points(UartRxData));
			break;

		case (CMD_LOAD_SAWTOOTH_DATA1):
			load_sawtooth_up_data();
			break;

		case (CMD_LOAD_SAWTOOTH_DATA2):
			load_sawtooth_down_data();
			break;
	}

}
//------------------------------------------------------------


//------------------------------------------------------------
unsigned int get_num_data_points(u8 *RxData)
{
	unsigned int num_points = 0;

	// most significant byte in number sent first
	num_points += RxData[1];
	num_points = num_points << 8;

	// least significant byte in number sent next
	num_points += RxData[2];

	return num_points;

}
//------------------------------------------------------------


//------------------------------------------------------------
void load_sawtooth_up_data(void)
{
	int i,j;

	UartTxData[0] = 0; // initial array value

	// load the data array with sawtooth data
	for(i=1; i<TX_BUFFER_SIZE; i++)
	{
		j = UartTxData[i-1] + SAWTOOTH_STEP_VALUE;
		if (j>SAWTOOTH_MAX_VALUE)
		{
			UartTxData[i] = 0;
		}
		else{
			UartTxData[i] = j;
		}
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
void load_sawtooth_down_data(void)
{
	int i,j;

	UartTxData[0] = SAWTOOTH_MAX_VALUE; // initial array value

	// load the data array with sawtooth data
	for(i=1; i<TX_BUFFER_SIZE; i++)
	{
		j = UartTxData[i-1] - SAWTOOTH_STEP_VALUE;
		if (j<0)
		{
			UartTxData[i] = SAWTOOTH_MAX_VALUE;
		}
		else{
			UartTxData[i] = j;
		}
	}
}
//------------------------------------------------------------


//------------------------------------------------------------
void send_Tx_data_over_UART(unsigned int num_points_to_send)
{
	int i;
	// send the data array to the transmit buffer as space is available
	for (i = 0; i < num_points_to_send; i++) {
		/* Wait until there is space in TX FIFO */
		 while (XUartPs_IsTransmitFull(XPAR_XUARTPS_0_BASEADDR));

		/* Write the byte into the TX FIFO */
		XUartPs_WriteReg(XPAR_XUARTPS_0_BASEADDR, XUARTPS_FIFO_OFFSET,
				UartTxData[i]);
	}
}
//------------------------------------------------------------




/*****************************************************************************/
/**
*
* This function is the handler which performs processing for the SPI driver.
* It is called from an interrupt context such that the amount of processing
* performed should be minimized. It is called when a transfer of SPI data
* completes or an error occurs.
*
* This handler provides an example of how to handle SPI interrupts and
* is application specific.
*
* @param	CallBackRef is the upper layer callback reference passed back
*		when the callback function is invoked.
* @param	StatusEvent is the event that just occurred.
* @param	ByteCount is the number of bytes transferred up until the event
*		occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void SpiIntrHandler(void *CallBackRef, u32 StatusEvent, u32 ByteCount)
{
	/*
	 * Indicate the transfer on the SPI bus is no longer in progress
	 * regardless of the status event.
	 */
	SpiTransferInProgress = FALSE;

	/*
	 * If the event was not transfer done, then track it as an error.
	 */
	if (StatusEvent != XST_SPI_TRANSFER_DONE) {
		SpiErrorCount++;
	}
}


/*****************************************************************************/
/**
*
* This function setups the interrupt system such that interrupts can occur
* for the Spi device. This function is application specific since the actual
* system may or may not have an interrupt controller. The Spi device could be
* directly connected to a processor without an interrupt controller.  The
* user should modify this function to fit the application.
*
* @param	IntcInstancePtr is a pointer to the instance of the Intc device.
* @param	SpiInstancePtr is a pointer to the instance of the Spi device.
* @param	SpiIntrId is the interrupt Id and is typically
*		XPAR_<INTC_instance>_<SPI_instance>_VEC_ID value from
*		xparameters.h
*
* @return	XST_SUCCESS if successful, otherwise XST_FAILURE.
*
* @note		None
*
******************************************************************************/
static int SpiSetupIntrSystem(INTC *IntcInstancePtr, XSpi *SpiInstancePtr,
					 u16 SpiIntrId)
{
	int Status;

	XScuGic_Config *IntcConfig;

	/*
	 * Initialize the interrupt controller driver so that it is ready to
	 * use.
	 */
	IntcConfig = XScuGic_LookupConfig(SPI_INTERRUPT_CONTROLLER_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
				IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_SetPriorityTriggerType(IntcInstancePtr, SpiIntrId, 0xA0, 0x3);

	/*
	 * Connect the device driver handler that will be called when an
	 * interrupt for the device occurs, the handler defined above performs
	 * the specific interrupt processing for the device.
	 */
	Status = XScuGic_Connect(IntcInstancePtr, SpiIntrId,
				(Xil_InterruptHandler)XSpi_InterruptHandler,
				SpiInstancePtr);
	if (Status != XST_SUCCESS) {
		return Status;
	}

	XScuGic_Enable(IntcInstancePtr, SpiIntrId);


	/* Enable interrupts from the hardware */
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
		(Xil_ExceptionHandler)XScuGic_InterruptHandler,
		(void *)IntcInstancePtr);

	Xil_ExceptionEnable();

	return XST_SUCCESS;
}
