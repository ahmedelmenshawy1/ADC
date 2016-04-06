# 1 "ADC_Prog.c"
# 1 "<command-line>"
# 1 "ADC_Prog.c"






# 1 "Types.h" 1




typedef unsigned short int u16;
typedef short int s16;

typedef unsigned long int u32;
typedef signed long int s32;

typedef unsigned char u8;
typedef signed char s8;

typedef unsigned long long int u64;
typedef signed long long int s64;

typedef float f32;
typedef double d64;
# 8 "ADC_Prog.c" 2
# 1 "DIO_Private.h" 1
# 9 "ADC_Prog.c" 2
# 1 "DIO-utilites.h" 1
# 10 "ADC_Prog.c" 2
# 1 "ADC_Private.h" 1
# 17 "ADC_Private.h"
typedef union
 {
   struct
   {
    u8 MUX0 :1 ;
    u8 MUX1 :1 ;
    u8 MUX2 :1 ;
    u8 MUX3 :1 ;
    u8 MUX4 :1 ;
    u8 ADLAR:1 ;
    u8 REFS0:1 ;
    u8 REFS1:1 ;
   };
 }ADMUX_Reg;
# 57 "ADC_Private.h"
 typedef union
  {
    struct
    {
     u8 ADPS0 :1 ;
     u8 ADPS1 :1 ;
     u8 ADPS2 :1 ;
     u8 ADIE :1 ;
     u8 ADIF :1 ;
     u8 ADATE :1 ;
     u8 ADSC :1 ;
     u8 ADEN :1 ;
    };
  }ADCSRA_Reg;
# 11 "ADC_Prog.c" 2
# 1 "ADC_config.h" 1
# 12 "ADC_Prog.c" 2
# 1 "ADC_interface.h" 1
# 16 "ADC_interface.h"
extern void ADC_VoidInit(void);



extern void ADC_VoidEnable(void);



extern void ADC_VoidDisable(void);



extern u16 ADC_u16ReadChannel(u8 Channel );
# 13 "ADC_Prog.c" 2




extern void ADC_VoidInit(void)
{
 (*(volatile u8 *) (0x27))=((1<<6)|(0<<7));
 (*(volatile u8 *) (0x26))=(1<<0 | 0<<1 | 0<<2);
 ADC_VoidEnable();
}

extern void ADC_VoidEnable(void)
{
 (*(volatile ADCSRA_Reg *) (0x26)).ADEN=1;
}

extern void ADC_VoidDisable(void)
{
 (*(volatile ADCSRA_Reg *) (0x26)).ADEN=0;
}

extern u16 ADC_u16ReadChannel(u8 Channel )
{
 u16 ADC_u16ReadADC;
 u8 Local_u8LowBit;
# 50 "ADC_Prog.c"
    (*(volatile ADMUX_Reg *) (0x27)).ADLAR=0;
    Local_u8LowBit=*((volatile u8*)(0x24));
    ADC_u16ReadADC=*((volatile u8*)(0x25)) << 8 | Local_u8LowBit ;


 (*(volatile u8 *) (0x27))=((*(volatile u8 *) (0x27))&0xF0)|Channel;
 (*(volatile ADCSRA_Reg *) (0x26)).ADSC=1;
 while((*(volatile ADCSRA_Reg *) (0x26)).ADIF==0);
 (*(volatile ADCSRA_Reg *) (0x26)).ADIF=1;

 return ADC_u16ReadADC;
}
