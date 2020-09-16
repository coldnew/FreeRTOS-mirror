/*------------------------------------------------------------------------
                                                                       |
   FILE        : start.asm                                             |
   DATE        :  Wed, Aug 25, 2010                                    |
   DESCRIPTION :   Reset Program                                       |
   CPU TYPE    :    Other                                              |
                                                                       |
   This file is generated by KPIT GNU Project Generator (Ver.4.5).     |
                                                                       |
------------------------------------------------------------------------*/
                        


	/*Start.asm*/

	.list
	.section .text
	.global _start   /*global Start routine */
	
#ifdef CPPAPP	
___dso_handle:
	.global ___dso_handle
#endif	

	.extern _hw_initialise  /*external Sub-routine to initialise Hardware*/
	.extern _data
	.extern _mdata
	.extern _ebss
	.extern _bss
	.extern _edata
	.extern _main 
	.extern _ustack
	.extern _istack
	.extern _rvectors
#if DEBUG
	.extern _exit
#endif

	
_start:
/* initialise user stack pointer */
	mvtc	#_ustack,USP

/* initialise interrupt stack pointer */
	mvtc	#_istack,ISP

/* setup intb */
	mvtc	#_rvectors_start, intb	/* INTERRUPT VECTOR ADDRESS  definition	*/

/* setup FPSW */
	mvtc    #100h, fpsw	

/* load data section from ROM to RAM */

	mov     #_mdata,r2      /* src ROM address of data section in R2 */
	mov     #_data,r1       /* dest start RAM address of data section in R1 */
	mov     #_edata,r3      /* end RAM address of data section in R3 */
	sub    r1,r3            /* size of data section in R3 (R3=R3-R1) */
	smovf                   /* block copy R3 bytes from R2 to R1 */

/* bss initialisation : zero out bss */

	mov	#00h,r2  	/* load R2 reg with zero */
	mov	#_ebss, r3  /* store the end address of bss in R3 */
	mov	#_bss, r1 	/* store the start address of bss in R1 */
	sub   r1,r3	   	/* size of bss section in R3 (R3=R3-R1) */
	sstr.b

/* call the hardware initialiser */
	bsr.a	_hw_initialise	
	nop

/* setup PSW */
//	mvtc	#10000h, psw			/* Set Ubit & Ibit for PSW */

/* change PSW PM to user-mode */
//	MVFC   PSW,R1
//	OR     #00100000h,R1
//	PUSH.L R1
//	MVFC   PC,R1
//	ADD    #10,R1
//	PUSH.L R1
//	RTE
//	NOP
//	NOP

/* start user program */
	bsr.a	_main		
	
/* call to exit*/
_exit:
	bsr.a 	_exit
	
	.end
