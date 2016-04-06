/*
 * main.c
 *
 *  Created on: ??þ/??þ/????
 *      Author: ahmed
 */
#include "Types.h"
#include "DIO_Private.h"
#include "DIO_interface.h"
#include "ADC_interface.h"
#include "delay.h"

int main (void)
{
	DIO_VoidInit();
	ADC_VoidInit();
	while(1)
	{
		PORTC=ADC_u16ReadChannel(0);
		//Delay_ms_Max1s(60);
		PORTD=ADC_u16ReadChannel(1);
		//Delay_ms_Max1s(60);

	}
	return 0;
}
