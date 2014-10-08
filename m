From: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1 parameter
 RAM
Date: Wed, 08 Oct 2014 18:46:11 +0200
Message-ID: <54356A53.3010700@c-s.fr>
References: <20141003125609.5BEA11AB276@localhost.localdomain>	 <20141003144420.GC24441@sirena.org.uk> <542F03CF.8010900@c-s.fr>	 <1412367858.13320.432.camel@snotra.buserror.net> <542FC8C1.1000707@c-s.fr> <1412641184.13320.506.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	Marcelo Tosatti <marcelo-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>,
	Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412641184.13320.506.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 07/10/2014 02:19, Scott Wood a =C3=A9crit :
> On Sat, 2014-10-04 at 12:15 +0200, christophe leroy wrote:
>> Le 03/10/2014 22:24, Scott Wood a =C3=A9crit :
>>> On Fri, 2014-10-03 at 22:15 +0200, christophe leroy wrote:
>>>> Le 03/10/2014 16:44, Mark Brown a =C3=A9crit :
>>>>> On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:
>>>>>
>>>>>> +config CPM1_RELOCSPI
>>>>>> +	bool "Dynamic SPI relocation"
>>>>>> +	default n
>>>>>> +	help
>>>>>> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be rel=
ocated
>>>>>> +	  without micropatch. This activates relocation to a dynamical=
ly
>>>>>> +	  allocated area in the CPM Dual port RAM.
>>>>>> +	  When combined with SPI relocation patch (for older MPC8xx) i=
t avoids
>>>>>> +	  the "loss" of additional Dual port RAM space just above the =
patch,
>>>>>> +	  which might be needed for example when using the CPM QMC.
>>>>> Something like this shouldn't be a compile time option.  Either i=
t
>>>>> should be unconditional or it should be triggered in some system
>>>>> specific manner (from DT, from knowing about other users or simil=
ar).
>>>> Can't be unconditional as older versions of mpc8xx (eg MPC860) don=
't
>>>> support relocation without a micropatch.
>>>> I have therefore submitted a v2 based on a DTS compatible property=
=2E
>>> So the device tree change is about whether relocation is supported,=
 not
>>> whether it is required?
>> Indeed no, my intension is to say that relocation is requested. Do y=
ou
>> mean that it should then not use a compatible ?
> The device tree describes hardware.  It doesn't tell software how to =
use
> that hardware.
>
> Based on one of your other e-mails, I think what you want to say here=
 is
> that the old binding didn't describe the registers needed for
> relocation, so the new compatible describes the new binding, rather t=
han
> requesting that software do a relocation.  Software that sees the new
> binding could choose to relocate, or just choose to read the current
> offset from the register.
Not exactly.
The old binding does describe the entire default param RAM (0x3d80 size=
=20
0x30). The relocation index is within this param RAM at 0x3dac.
So the old binding is enough to allow relocation.
The issue today with the driver (hence my first patch) is that the=20
driver reads the relocation index but takes a wrong decision if the=20
index is 0: it assumes that an nul index means that a param RAM shall b=
e=20
allocated, which is wrong. A nul index means that the component doesn't=
=20
support relocation, so the default param RAM shall be used. The functio=
n=20
used for that is supposed to return the index. So when the index is=20
null, I need to calculate it.

Now, it can't be the SPI driver by itself that decide if he has to=20
relocate or not. Because it depends whether I need to relocate or not.=20
There is no point in waisting another area of the dualport RAM if I=20
don't need to use SCC2 in a mode that overlaps the SPI parameter RAM.

Today on the old MPC8xx, a microcode patch is needed in order to be abl=
e=20
to relocate, and relocated address is directly fixed by the code=20
handling the patch (sysdev/micropatch.c). The patch loading function is=
=20
call very early in the boot process by cpm_reset() which is call by the=
=20
xxx_setup_arch().
I have two issues with the way it is done today:
1/ the address which in hard coded is the micropatch loading function()=
=20
is within the area for descripters for the QMC, so I would need to use=20
another address.
2/ for new MPC8xx which don't need microcode patch, I have no way today=
=20
to relocate.

I have the same issue with the relocation of SMC1. Today when we=20
activate SMC1 relocation microcode patch, the loading function has a=20
hard coded relocation area for SMC1 which is the area dedicated to the=20
MPC8xx DSP. It means that I need to change it as I want to use the DSP.

Would it be acceptable to define a fixed relocation address in the=20
Kconfig in which we select microcode patch (arch/powerpc/platforms/8xx)=
,=20
instead of having it hardcoded in micropatch.c ?

Or maybe it would be possible to select which microcode patch we=20
want/need via the device tree and which address shall be used for=20
relocation ? What would you suggest to describe it ?
>
>>> How about checking for the existing specific-SoC compatibles?
>> What do you mean ?
> Look for "fsl,mpc885-cpm-i2c" etc.  Or, if you didn't follow that
> pattern (remember, I can't see your device tree!), look for
> "fsl,mpc885-cpm" or "fsl,mpc866-cpm" in the parent node.  It's moot
> though, if the device tree also needs to be modified to describe the
> register used to relocate.
>
> -Scott
>
I'm not sure I understood your question.
My full device tree below

Christophe

/*
  * MIA ethernet Device Tree Source
  *
  * Copyright 2011 CSSI, Inc
  */

/dts-v1/;

/ {
     model =3D "MIAE";
     compatible =3D "fsl,cmpc885", "fsl,mod885";
     #address-cells =3D <1>;
     #size-cells =3D <1>;

     aliases {
         ethernet0 =3D &eth0;
         ethernet1 =3D &eth1;
         mdio =3D &phy;
         serial0 =3D &smc1;
     };

     cpus {
         #address-cells =3D <1>;
         #size-cells =3D <0>;

         PowerPC,885@0 {
             device_type =3D "cpu";
             reg =3D <0x0>;
             d-cache-line-size =3D <16>;    // 16 bytes
             i-cache-line-size =3D <16>;    // 16 bytes
             d-cache-size =3D <8192>;
             i-cache-size =3D <8192>;
             timebase-frequency =3D <0>;
             bus-frequency =3D <0>;
             clock-frequency =3D <0>;
             interrupts =3D <15 2>;        // decrementer interrupt
             interrupt-parent =3D <&PIC>;
         };
     };

     memory {
         device_type =3D "memory";
         reg =3D <0x0 0x0>;            // defined by U-BOOT
     };

     localbus@ff000100 {
         compatible =3D "fsl,cmpc885-localbus", "fsl,pq1-localbus";
         #address-cells =3D <2>;
         #size-cells =3D <1>;
         reg =3D <0xff000100 0x40>;        // ORx and BRx register

         ranges =3D <0 0x0 0x40000000 0x00400000 // Boot Flash
               1 0x0 0x00000000 0x08000000 // SDRAM
               2 0x0 0xc0000000 0x00008000 // Nand Flash
               3 0x0 0xe0000000 0x00010000 // DPRAM
               4 0x0 0xd0000000 0x10000000 // Periphs
               5 0x0 0xc8000000 0x00008000 // CPLD
               6 0x0 0x80000000 0x00008000 // mezzanine
               7 0x0 0xf0000000 0x00008000>; // DSP

         flash@0,0 {
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "cfi-flash";
             reg =3D <0x0 0x00000000 0x400000>;
             bank-width =3D <2>;
             device-width =3D <2>;
             partition@0 {
                 label =3D "boot";
                 reg =3D <0x0 0x50000>;
             };
             partition@50000 {
                 label =3D "env";
                 reg =3D <0x50000 0x10000>;
             };
             partition@60000 {
                 label =3D "blob";
                 reg =3D <0x60000 0x30000>;
             };
             partition@90000 {
                 label =3D "kernel";
                 reg =3D <0x90000 0x370000>;
             };
         };

         nand@2,0 {
             compatible =3D "s3k,cmpc885-nand";
             reg =3D <2 0x0 0x01>;
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             gpios =3D <&CPM1_PIO_D 12 1     // CLE
                  &CPM1_PIO_D 13 1    // ALE
                  &CPM1_PIO_D 15 1>;    // NCE
         };

         cpld-cmpc@5,0000000 { // Driver KNL
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "s3k,mcr3000-cpld-cmpc";
             reg =3D <5 0x0 0x10>;
         };

         cpld-mpc@5,0000000 { // Driver LDB (deviendra obsolete)
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "s3k,mcr3000-cpld-mpc";
             reg =3D <5 0x0 0x10>;
         };

         fpga-m@4,0000000 { // Driver LDB (deviendra peut etre obsolete=
)
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "s3k,mcr3000-fpga-m";
             reg =3D <4 0x0000000 0x60>;
             ranges =3D <0 4 0x0000000 0x60>;
             ident: gpio-controller@00 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x00 2>;
                 gpio-controller;
             };
             ver: gpio-controller@02 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x02 2>;
                 gpio-controller;
             };
             tst: gpio-controller@04 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x04 2>;
                 gpio-controller;
             };
             rst: gpio-controller@10 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x10 2>;
                 gpio-controller;
             };
             mask1: gpio-controller@20 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x20 2>;
                 gpio-controller;
             };
             mask2: gpio-controller@22 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x22 2>;
                 gpio-controller;
             };
             pend1: gpio-controller@24 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x24 2>;
                 gpio-controller;
             };
             pend2: gpio-controller@26 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x26 2>;
                 gpio-controller;
             };
             acq1: gpio-controller@28 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x28 2>;
                 gpio-controller;
             };
             acq2: gpio-controller@2A {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x2A 2>;
                 gpio-controller;
             };
             ctrl: gpio-controller@2C {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x2C 2>;
                 gpio-controller;
             };
             torin: gpio-controller@30 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x30 2>;
                 interrupts =3D <255 255 255 255 255 5 6 7 8 9 10 11 12=
 13=20
14 15>;
                 interrupt-parent =3D <&FPGAM_PIC>;
                 gpio-controller;
             };
             torout: gpio-controller@32 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x32 2>;
                 gpio-controller;
             };
             liens: gpio-controller@34 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-direct-gpio";
                 reg =3D <0x34 2>;
                 gpio-controller;
             };
             gen: gpio-controller@40 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x40 2>;
                 gpio-controller;
             };
             far: gpio-controller@42 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x42 2>;
                 interrupts =3D <255 255 255 255 255 255 255 255 255 25=
5=20
255 0 28 30 29 31>;
                 interrupt-parent =3D <&FPGAM_PIC>;
                 gpio-controller;
             };
             fav: gpio-controller@44 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x44 2>;
                 interrupts =3D <255 255 255 255 255 255 255 255 17 25 =
19=20
27 16 24 18 26>;
                 interrupt-parent =3D <&FPGAM_PIC>;
                 gpio-controller;
             };
             statpll: gpio-controller@50 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x50 2>;
                 gpio-controller;
             };
             srcpll: gpio-controller@52 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x52 2>;
                 gpio-controller;
             };
             etatref: gpio-controller@54 {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,mcr3000-fpga-m-gpio";
                 reg =3D <0x54 2>;
                 gpio-controller;
             };
             FPGAM_PIC: pic@22 {
                 interrupt-controller;
                 #address-cells =3D <0>;
                 #interrupt-cells =3D <1>;
                 interrupts =3D <6 1>;
                 interrupt-parent =3D <&PIC>;
                 reg =3D <0x00 0x60>;    /* Mappage registres FPGAM */
                 compatible =3D "s3k,miae-pic";
             };
         };

         PRES_EQUT {
             compatible =3D "ident-gpio-pres-equt";
             interrupts =3D <17 19 16 18>;    /* Equipt 1 et 2 */
             interrupt-parent =3D <&FPGAM_PIC>;
             reg =3D <4 0x44 2>;
             gpios =3D <&fav   8 1    /* Presence =C2=B5Casque1 */
                 &fav   10 1    /* Presence =C2=B5Main1 */
                 &fav   12 1    /* Presence =C2=B5Casque2 */
                 &fav   14 1>;    /* Presence =C2=B5Main2 */
         };

         led_pwr {
             compatible =3D "s3k,miae-led-pwr";
             gpios =3D <&fav 6 2    /* led multi verte */
                  &fav 7 0>;    /* led multi rouge */
         };

         e1@4,2000000 {
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "s3k,mcr3000-e1";
             reg =3D <4 0x2000000 0xFF>;
             interrupts =3D <8 1>;
             interrupt-parent =3D <&PIC>;
         };

         e1-wan@4,2000000 {
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "lantiq,pef2256";
             reg =3D <4 0x2000000 0xFF>;
             interrupts =3D <8 1>;
             interrupt-parent =3D <&PIC>;
         };

         GPIO {
             /* 0 =3D sortie initialisee active */
             /* 1 =3D entree */
             /* 2 =3D sortie initialisee inactive */
             compatible =3D "s3k,gpios-appli";
             reg =3D <4 0x42 4>;
             gpios =3D <&torin   15 1    // TOR in 1
                 &torin    14 1    // TOR in 2
                 &torin    13 1    // TOR in 3
                 &torin    12 1    // TOR in 4
                 &torin    11 1    // TOR in 5
                 &torin    10 1    // TOR in 6
                 &torin     9 1    // TOR in 7
                 &torin     8 1    // TOR in 8
                 &torin     7 1    // TOR in 9
                 &torin     6 1    // TOR in 10
                 &torin     5 1    // TOR in 11
                 &torout   15 2    // TOR out 1
                 &torout   14 2    // TOR out 2
                 &torout   13 2    // TOR out 3
                 &torout   12 2    // TOR out 4
                 &torout   11 2    // TOR out 5
                 &torout   10 2    // TOR out 6
                 &torout    9 2    // TOR out 7
                 &torout    8 2    // TOR out 8
                 &far      15 1    // BP Alt
                 &far      13 1    // Alternat 1
                 &far      14 1    // Alternat 2
                 &far      12 1    // Alternat Combine
                 &far      11 1    // Presence Combine
                 &fav      11 1    // Alternat =C2=B5Main1
                 &fav      15 1    // Alternat =C2=B5Main2
                 &fav       9 1    // Alternat =C2=B5Casque1
                 &fav      13 1>;    // Alternat =C2=B5Casque2
         };

         GPIO_CA_CLA {
             compatible =3D "s3k,gpios-def-ca", "cs,mia-far";
             far-id =3D <0 7>;
             names =3D "tor_in_1",
                 "tor_in_2",
                 "tor_in_3",
                 "tor_in_4",
                 "tor_in_5",
                 "tor_in_6",
                 "tor_in_7",
                 "tor_in_8",
                 "tor_in_9",
                 "tor_in_10",
                 "tor_in_11",
                 "tor_out_1",
                 "tor_out_2",
                 "tor_out_3",
                 "tor_out_4",
                 "tor_out_5",
                 "tor_out_6",
                 "tor_out_7",
                 "tor_out_8",
                 "alt_bp",
                 "tor_in_13",        // Alternat 1
                 "tor_in_14",        // Alternat 2
                 "alt_ucomb",
                 "pres_ucomb";
             codec =3D "Rec. In 1",
                 "Interco In 1",
                 "Rec. In 2",
                 "Interco In 2",
                 "Micro ITH",
                 "Audio OPT 1",
                 "Audio OPT 2",
                 "Micro Combine",
                 "Rec. Out 1",
                 "Interco Out 1",
                 "Rec. Out 2",
                 "Interco Out 2",
                 "HP ITH",
                 "HP 1",
                 "HP 2",
                 "Ecoute Combine";
         };

         GPIO_FAV_CLA {
             compatible =3D "s3k,gpios-def-fav", "cs,mia-fav";
             fav-id =3D <7>;
             names =3D "alt_umain_a",
                 "alt_umain_b",
                 "alt_ucasque_a",
                 "alt_ucasque_b";
             pres  =3D "pres_ucasque_a",
                 "pres_umain_a",
                 "pres_ucasque_b",
                 "pres_umain_b";
             codec =3D "Micro Casque_a",
                 "Micro Main_a",
                 "Micro Casque_b",
                 "Micro Main_b",
                 "Ec. droite Casque_a",
                 "Ec. gauche Casque_a",
                 "Ec. droite Casque_b",
                 "Ec. gauche Casque_b";
         };

         GPIO_CA_NVCS {
             compatible =3D "s3k,gpios-def-ca", "cs,mia-far";
             far-id =3D <1>;
             names =3D "tor_in_audio_1",
                 "tor_in_audio_2",
                 "tor_in_audio_3",
                 "tor_in_audio_4",
                 "tor_in_5",
                 "alt_pedale_1",
                 "alt_pedale_2",
                 "dec_ucomb",
                 "tor_in_9",
                 "tor_in_10",
                 "alt_aith",
                 "tor_out_audio_1",
                 "tor_out_audio_2",
                 "tor_out_audio_3",
                 "tor_out_audio_4",
                 "tor_out_5",
                 "tor_out_6",
                 "none",
                 "none",
                 "alt_bp",
                 "tor_in_13",        // Alternat 1
                 "tor_in_14",        // Alternat 2
                 "alt_ucomb",
                 "pres_ucomb";
             codec =3D "Audio In 1",
                 "Audio In 2",
                 "Audio In 3",
                 "Audio In 4",
                 "Micro ITH",
                 "Audio OPT 1",
                 "Audio OPT 2",
                 "Micro Combine",
                 "Audio Out 1",
                 "Audio Out 2",
                 "Audio Out 3",
                 "Audio Out 4",
                 "Audio Out 5",
                 "HP 1",
                 "HP 2",
                 "Ecoute Combine";
         };

         GPIO_FAV_NVCS {
             compatible =3D "s3k,gpios-def-fav", "cs,mia-fav";
             fav-id =3D <3 5 6>;
             names =3D "alt_umain_a",
                 "alt_umain_b",
                 "alt_ucasque_a",
                 "alt_ucasque_b";
             pres  =3D "pres_ucasque_a",
                 "pres_umain_a",
                 "pres_ucasque_b",
                 "pres_umain_b";
             codec =3D "Micro Casque_a",
                 "Micro Main_a",
                 "Micro Casque_b",
                 "Micro Main_b",
                 "Ec. droite Casque_a",
                 "Ec. gauche Casque_a",
                 "Ec. droite Casque_b",
                 "Ec. gauche Casque_b";
         };

         GPIO_CA_GW {
             compatible =3D "s3k,gpios-def-ca", "cs,mia-far";
             far-id =3D <4>;
             names =3D "tor_in_1",
                 "tor_in_2",
                 "tor_in_3",
                 "tor_in_4",
                 "tor_in_5",
                 "tor_in_6",
                 "tor_in_7",
                 "none",
                 "none",
                 "dptt",
                 "pt_ct",
                 "tor_out_1",
                 "tor_out_2",
                 "tor_out_3",
                 "tor_out_4",
                 "tor_out_5",
                 "tor_out_6",
                 "tor_out_7",
                 "cgc",
                 "none",
                 "none",
                 "none",
                 "none",
                 "none";
             codec =3D "Audio In 1",
                 "Audio In 2",
                 "Audio In 3",
                 "Audio In 4",
                 "Audio In 5",
                 "Audio In 6",
                 "Audio In 7",
                 "Audio In 8",
                 "Audio Out 1",
                 "Audio Out 2",
                 "Audio Out 3",
                 "Audio Out 4",
                 "not used",
                 "not used",
                 "not used",
                 "not used";
         };

         GPIO_FAV_GW {
             compatible =3D "s3k,gpios-def-fav", "cs,mia-fav";
             fav-id =3D <4>;
             names =3D "none",
                 "none",
                 "none",
                 "none";
             pres  =3D "none",
                 "none",
                 "none",
                 "none";
             codec =3D "Micro Casque_a",
                 "not used",
                 "not used",
                 "not used",
                 "Ec. droite Casque_a",
                 "not used",
                 "not used",
                 "not used";
         };

         IDENT_EQUIPT_NVCS {
             compatible =3D "ident-equipt-fav", "cs,mia-fav";
             fav-id =3D <3 5 6>;
             infos =3D "22",    /* nombre d'=C3=A9quipements possibles =
*/
                 /* bornes min et max, niveaux in et out en dB,=20
croissement TS, type casque */
                 "0",    "340",    "-27",    "-10",    "no", "yes",   =20
/* equipement 1 */
                 "341",    "420",    "-27",    "-10",    "no", "yes",  =
 =20
/* equipement 2 */
                 "421",    "502",    "-27",    "-10",    "no", "yes",  =
 =20
/* equipement 3 */
                 "503",    "578",    "-27",    "-10",    "no", "yes",  =
 =20
/* equipement 4 */
                 "579",    "682",    "-27",    "-10",    "no", "yes",  =
 =20
/* equipement 5 */
                 "683",    "804",    "-27",    "-10",    "no", "yes",  =
 =20
/* equipement 6 */
                 "805",    "908",    "-7",    "-17",    "yes", "yes",  =
 =20
/* equipement 7 */
                 "909",    "1016",    "-27",    "-10",    "no",=20
"yes",    /* equipement 8 */
                 "1017",    "1120",    "-27",    "-10",    "no",=20
"yes",    /* equipement 9 */
                 "1121",    "1232",    "-27",    "-10",    "no",=20
"yes",    /* equipement 10 */
                 "1233",    "1392",    "-27",    "-10",    "no",=20
"yes",    /* equipement 11 */
                 "1393",    "1523",    "-23",    "-1",    "no",=20
"yes",    /* equipement 12 */
                 "1524",    "1664",    "-27",    "-10",    "no",=20
"yes",    /* equipement 13 */
                 "1665",    "1786",    "-27",    "-10",    "no",=20
"yes",    /* equipement 14 */
                 "1787",    "1954",    "-27",    "-10",    "no",=20
"yes",    /* equipement 15 */
                 "1955",    "2194",    "-27",    "-10",    "no",=20
"yes",    /* equipement 16 */
                 "2195",    "2396",    "-27",    "-10",    "no",=20
"yes",    /* equipement 17 */
                 "2397",    "2556",    "-27",    "-10",    "no",=20
"yes",    /* equipement 18 */
                 "2557",    "2738",    "-27",    "-10",    "no",=20
"yes",    /* equipement 19 */
                 "2739",    "2966",    "-27",    "-10",    "no",=20
"yes",    /* equipement 20 */
                 "2967",    "3156",    "-11",    "-10",    "no",=20
"no",    /* equipement 21 */
                 "3157",    "4095",    "-27",    "-10",    "no",=20
"yes";    /* sans equipement */
         };

         FAV_CS_SPI: gpio-controller@dummy0 {
             #gpio-cells =3D <2>;
             compatible =3D "cs-fav-poste";
             gpio-controller;
             reg =3D <4 0x44 2>;    /* necessaire mais non utilise */
             gpios =3D <&fav 5 1    /* CS FAV */
                  &fav 4 1    /* CS Ident equipement */
                  &fav 3 1>;    /* CS FPGA */
         };

         POT_A_NVCS {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <5 6>;
             user-name =3D "pot_a";
             dev-name =3D "ad7923";
             io-channels =3D <&iio 0>;
             io-channel-names =3D "channel_0";
             dev-channel =3D "channel_0";
         };
         POT_B_NVCS {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <5 6>;
             user-name =3D "pot_b";
             dev-name =3D "ad7923";
             io-channels =3D <&iio 1>;
             io-channel-names =3D "channel_1";
             dev-channel =3D "channel_1";
         };

         POT_A_PO {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <3>;
             user-name =3D "pot_a";
             dev-name =3D "none";
             dev-channel =3D "channel_0";
         };
         POT_B_PO {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <3>;
             user-name =3D "pot_b";
             dev-name =3D "none";
             dev-channel =3D "channel_1";
         };
         POT_C_PO {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <3>;
             user-name =3D "pot_c";
             dev-name =3D "none";
             dev-channel =3D "channel_2";
         };
         POT_D_PO {
             compatible =3D "pot-miae", "cs,mia-fav";
             fav-id =3D <3>;
             user-name =3D "pot_d";
             dev-name =3D "none";
             dev-channel =3D "channel_3";
         };
     };

     soc@ff000000 {
         compatible =3D "fsl,mpc885", "fsl,pq1-soc";
         #address-cells =3D <1>;
         #size-cells =3D <1>;
         device_type =3D "soc";
         ranges =3D <0x0 0xff000000 0x28000>;
         bus-frequency =3D <0>;
         clock-frequency =3D <0>;

         WDT: watchdon@0 {
             compatible =3D "fsl,mpc823-wdt";
             reg =3D <0x0 0x10>;
         };

         phy: mdio@e00 {
             compatible =3D "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
             reg =3D <0xe00 0x188>;
             #address-cells =3D <1>;
             #size-cells =3D <0>;

             PHY1: ethernet-phy@1 {
                 interrupts =3D <2 1>;
                 interrupt-parent =3D <&PIC>;
                 reg =3D <0x1>;
                 device_type =3D "ethernet-phy";
             };

             PHY2: ethernet-phy@2 {
                 interrupts =3D <2 1>;
                 interrupt-parent =3D <&PIC>;
                 reg =3D <0x3>;
                 device_type =3D "ethernet-phy";
             };

             PHY3: ethernet-phy@3 {
                 interrupts =3D <2 1>;
                 interrupt-parent =3D <&PIC>;
                 reg =3D <0x2>;
                 device_type =3D "ethernet-phy";
             };
         };

         eth0: ethernet@e00 {
             device_type =3D "network";
             compatible =3D "fsl,mpc885-fec-enet", "fsl,pq1-fec-enet";
             reg =3D <0xe00 0x188>;
             local-mac-address =3D [ 00 00 00 00 00 00 ];
             interrupts =3D <5 1>;
             interrupt-parent =3D <&PIC>;
             phy-handle =3D <&PHY1>;
             linux,network-index =3D <0>;
         };

         eth1: ethernet@1e00 {
             device_type =3D "network";
             compatible =3D "fsl,mpc885-fec-enet", "fsl,pq1-fec-enet";
             reg =3D <0x1e00 0x188>;
             local-mac-address =3D [ 00 00 00 00 00 00 ];
             interrupts =3D <7 1>;
             interrupt-parent =3D <&PIC>;
             phy-handle =3D <&PHY2 &PHY3>;
             linux,network-index =3D <1>;
             gpios =3D <&CPM1_PIO_E 18 1>;
             PHY-disable =3D "isolate";
         };

         PIC: pic@0 {
             interrupt-controller;
             #interrupt-cells =3D <2>;
             reg =3D <0x0 0x24>;
             compatible =3D "fsl,mpc885-pic", "fsl,pq1-pic";
         };

         SIT: sit@200 {
             compatible =3D "fsl,mpc866-sit", "fsl,pq1-sit";
             reg =3D <0x200 0x80>;
             interrupts =3D <11 1>;
             interrupt-parent =3D <&PIC>;
         };

         cpm@9c0 {
             #address-cells =3D <1>;
             #size-cells =3D <1>;
             compatible =3D "fsl,mpc885-cpm", "fsl,cpm1";
             ranges;
             reg =3D <0x9c0 0x40>;
             brg-frequency =3D <0>;
             interrupts =3D <0>;    // cpm error interrupt
             interrupt-parent =3D <&CPM_PIC>;

             muram@2000 {
                 #address-cells =3D <1>;
                 #size-cells =3D <1>;
                 ranges =3D <0x0 0x2000 0x2000>;

                 data@0 {
                     compatible =3D "fsl,cpm-muram-data";
                     reg =3D <0x0 0x1c00>;
                 };
             };

             brg@9f0 {
                 compatible =3D "fsl,mpc885-brg", "fsl,cpm1-brg",=20
"fsl,cpm-brg";
                 reg =3D <0x9f0 0x10>;
                 clock-frequency =3D <0>;
             };

             CPM_PIC: pic@930 {
                 interrupt-controller;
                 #address-cells =3D <0>;
                 #interrupt-cells =3D <1>;
                 interrupts =3D <3 2 0 2>;
                 interrupt-parent =3D <&PIC>;
                 reg =3D <0x930 0x20>;
                 compatible =3D "fsl,mpc885-cpm-pic", "fsl,cpm1-pic";
             };

             CPM1_PIO_A: gpio-controller@950 {
                 #gpio-cells =3D <2>;
                 compatible =3D "fsl,cpm1-pario-bank-a";
                 reg =3D <0x950 0x10>;
                 gpio-controller;
             };

             CPM1_PIO_B: gpio-controller@ab8 {
                 #gpio-cells =3D <2>;
                 compatible =3D "fsl,cpm1-pario-bank-b";
                 reg =3D <0xab8 0x10>;
                 gpio-controller;
             };

             CPM1_PIO_C: gpio-controller@960 {
                 #gpio-cells =3D <2>;
                 compatible =3D "fsl,cpm1-pario-bank-c";
                 reg =3D <0x960 0x10>;
                 interrupts =3D <0 0 0 0 1 2 6 9 10 11 14 15 23 24 26 3=
1>;
                 interrupt-parent =3D <&CPM_PIC>;
                 gpio-controller;
             };

             CPM1_PIO_D: gpio-controller@970 {
                 #gpio-cells =3D <2>;
                 compatible =3D "fsl,cpm1-pario-bank-d";
                 reg =3D <0x970 0x10>;
                 gpio-controller;
             };

             CPM1_PIO_E: gpio-controller@ac8 {
                 #gpio-cells =3D <2>;
                 compatible =3D "fsl,cpm1-pario-bank-e";
                 reg =3D <0xac8 0x18>;
                 gpio-controller;
             };

             dsp1: dsp1@900 {
                 device_type =3D "dsp";
                 compatible =3D "fsl,cpm1-dsp";
                 reg =3D <0x900 0x30 0x3ec0 0x40>;
                 interrupts =3D <22>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-dsp =3D <1>;
                 fsl,cpm-command =3D <0x90>;
             };

             dsp2: dsp2@900 {
                 device_type =3D "dsp";
                 compatible =3D "fsl,cpm1-dsp";
                 reg =3D <0x900 0x30 0x3fc0 0x40>;
                 interrupts =3D <22>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-dsp =3D <2>;
                 fsl,cpm-command =3D <0xd0>;
             };

             tsa: tsa@9c0 {
                 compatible =3D "fsl,mpc885-tsa", "fsl,cpm1-tsa";
                 reg =3D <0x9c0 0x440 0x930 0x20>;
                 /* parametres possible : none, SCC3, SCC4 (ou SMC2 si=20
defini) */
                 scc_tdm =3D "SCC4";
                 /* vitesse bus numerique 4 ou 8 MHz */
                 data_rate =3D <4>;
             };

             smc1: serial@a80 {
                 device_type =3D "serial";
                 compatible =3D "fsl,mpc885-smc-uart", "fsl,cpm1-smc-ua=
rt";
                 reg =3D <0xa80 0x10 0x3e80 0x40>;
                 interrupts =3D <4>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <4>;
                 fsl,cpm-command =3D <0x90>;
             };

             scc2: serial@a20 {
                 device_type =3D "serial";
                 compatible =3D "fsl,mpc885-scc-uart", "fsl,cpm1-scc-ua=
rt";
                 reg =3D <0xa20 0x20 0x3d00 0x80>;
                 interrupts =3D <29>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <1>;
                 fsl,cpm-command =3D <0x40>;
                 gpios =3D <&CPM1_PIO_C 9 1    /* CTS2 */
                          &CPM1_PIO_B 18 1>;    /* RTS2 */
             };

             smc2: serial@a90 {
                 device_type =3D "serial";
                 compatible =3D "fsl,mpc885-smc-uart",=20
"fsl,cpm1-smc-uart", "cs,mia-far";
                 reg =3D <0xa90 0x10 0x3f80 0x40>;
                 interrupts =3D <3>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <3>;
                 fsl,cpm-command =3D <0xd0>;
                 gpios =3D <&liens 3 1    /* CTS */
                          &liens 4 1>;    /* RTS */
                 far-id =3D <4>;
             };

             scc3: serial@a40 {
                 device_type =3D "serial";
                 compatible =3D "fsl,mpc885-scc-uart",=20
"fsl,cpm1-scc-uart", "cs,mia-far";
                 reg =3D <0xa40 0x20 0x3e00 0x80>;
                 interrupts =3D <28>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <2>;
                 fsl,cpm-command =3D <0x80>;
                 gpios =3D <&CPM1_PIO_C 5 1    /* CTS3 */
                          &CPM1_PIO_D 7 1>;    /* RTS3 */
                 far-id =3D <4>;
             };

             scc3wb: wb@a40 {
                 device_type =3D "wb_scc";
                 wb_name =3D "scc3";
                 compatible =3D "cs,wb-scc", "cs,mia-far";
                 reg =3D <0xa40 0x20 0x3e00 0x80>;
                 interrupts =3D <28 2>;    /* scc, cts */
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <2>;
                 fsl,cpm-command =3D <0x80>;
                 gpios =3D <&CPM1_PIO_C 5 1    /* CTS3 */
                          &CPM1_PIO_D 7 1>;    /* RTS3 */
                 far-id =3D <4>;
             };

             scc4t: tdm@a60 {
                 device_type =3D "tdm";
                 tdm_name =3D "scc4";
                 compatible =3D "fsl,mpc885-scc-tdm", "fsl,cpm1-scc-tdm=
";
                 reg =3D <0xa60 0x20 0x3f00 0x80>;
                 interrupts =3D <27>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-command =3D <0xc0>;
             };

             smc2_9b: smc@a90 {
                 device_type =3D "smc_9bits";
                 compatible =3D "cs,smc-9bits", "cs,mia-far";
                 reg =3D <0xa90 0x10 0x3f80 0x40 0x9c0 0x440>;
                 interrupts =3D <3>;
                 interrupt-parent =3D <&CPM_PIC>;
                 fsl,cpm-brg =3D <3>;
                 fsl,cpm-command =3D <0xd0>;
                 gpios =3D <&liens 12 1    /* CTS */
                          &liens 11 1>;    /* RTS */
                 far-id =3D <4>;
             };

             spi: spi@a80 {
                 #address-cells =3D <1>;
                 #size-cells =3D <0>;
                 cell-index =3D <0>;
                 compatible =3D "fsl,spi", "fsl,cpm1-spi";
                 reg =3D <0xa80 0x30 0x3d80 0x30>;
                 interrupts =3D <5>;
                 interrupt-parent =3D <&CPM_PIC>;
                 mode =3D "cpu";
                 gpios =3D <&CPM1_PIO_C 4 1    /* SICOFI 1 */
                      &CPM1_PIO_B 23 1    /* TEMP MCR */
                      &CPM1_PIO_C 8 1    /* SICOFI 2 */
                      &CPM1_PIO_C 12 1    /* EEPROM MIAE */
                      &CPM1_PIO_D 6 1    /* SICOFI 3 */
                      &CPM1_PIO_B 14 1    /* TEMP MPC885 */
                      &CPM1_PIO_B 21 1    /* EEPROM CMPC885 */
                      &FAV_CS_SPI 1 1    /* FAV SPI */
                      &FAV_CS_SPI 2 1>;    /* FAV POSTE FPGA */
                 sicofi@0 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-far=
";
                     far-id =3D <0 2 3 4 5 6 7>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <0>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_1";
                     analog_in =3D "-2dB -2dB -2dB -2dB";
                     analog_out =3D "6dB 6dB 6dB 6dB";
                     niveau_in =3D "-10dB -10dB -10dB -10dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 sicofi_nvcs@0 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-far=
";
                     far-id =3D <1>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <0>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_1";
                     analog_in =3D "-2dB -2dB -2dB -2dB";
                     analog_out =3D "0dB 0dB 0dB 0dB";
                     niveau_in =3D "-10dB -10dB -10dB -10dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 lm74@1 {
                     compatible =3D "ns,lm74";
                     spi-max-frequency =3D <1000000>;
                     reg =3D <1>;
                     spi-cs-high;
                 };
                 sicofi@2 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-far=
";
                     far-id =3D <0 2 3 5 6 7>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <2>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_2";
                     analog_in =3D "-2dB 0dB 0dB 12dB";
                     analog_out =3D "3dB 3dB 3dB 4,5dB";
                     niveau_in =3D "-10dB -10dB -10dB -31dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 sicofi_nvcs@2 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-far=
";
                     far-id =3D <1>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <2>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_2";
                     analog_in =3D "-2dB 0dB 0dB 18dB";
                     analog_out =3D "6dB 3dB 3dB 4,5dB";
                     niveau_in =3D "-10dB -10dB -10dB -37dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 sicofi_gw@2 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-far=
";
                     far-id =3D <4>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <2>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_2";
                     analog_in =3D "-3dB -3dB -3dB -3dB";
                     analog_out =3D "3dB 3dB 3dB 3dB";
                     niveau_in =3D "-10dB -10dB -10dB -10dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 eeprom@3 {
                     compatible =3D "atmel,at25", "cs,eeprom";
                     spi-max-frequency =3D <1000000>;
                     reg =3D <3>;
                     spi-cs-high;
                     at25,byte-len =3D <1024>;
                     at25,addr-mode =3D <2>;
                     at25,page-size =3D <32>;
                 };
                 sicofi@4 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-fav=
";
                     fav-id =3D <0 1 2 4 7>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <4>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_3";
                     analog_in =3D "12dB -7dB 12dB -7dB";
                     analog_out =3D "6dB 6dB 6dB 6dB";
                     niveau_in =3D "-27dB -8dB -27dB -8dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                 };
                 sicofi_nvcs@4 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-fav=
";
                     fav-id =3D <5 6>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <4>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_3";
                     analog_in =3D "12dB -7dB 12dB -7dB";
                     analog_out =3D "6dB 6dB 6dB 6dB";
                     niveau_in =3D "-27dB -8dB -27dB -8dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                     io-channels =3D <&iio 2>, <&iio 3>;
                     iio-name =3D "ad7923";
                     io-channel-names =3D "channel_2", "channel_3";
                     iio-channel =3D "channel_2", "channel_3";
                 };
                 sicofi_postes@4 {
                     compatible =3D "infineon,miae-sicofi", "cs,mia-fav=
";
                     fav-id =3D <3>;
                     spi-max-frequency =3D <1000000>;
                     reg =3D <4>;
                     spi-cs-high;
                     spi-cpha;
                     spi-troll;
                     name_codec =3D "codec_3";
                     analog_in =3D "12dB -7dB 12dB -7dB";
                     analog_out =3D "6dB 6dB 6dB 6dB";
                     niveau_in =3D "-27dB -8dB -27dB -8dB";
                     niveau_out =3D "-10dB -10dB -10dB -10dB";
                     io-channels =3D <&iio 0>, <&iio 1>;
                     iio-name =3D "ad7923";
                     io-channel-names =3D "channel_0", "channel_1";
                     iio-channel =3D "channel_0", "channel_1";
                 };
                 lm74@5 {
                     compatible =3D "ns,lm74";
                     spi-max-frequency =3D <1000000>;
                     reg =3D <5>;
                     spi-cs-high;
                 };
                 eeprom@6 {
                     compatible =3D "atmel,at25", "cs,eeprom";
                     spi-max-frequency =3D <1000000>;
                     reg =3D <6>;
                     spi-cs-high;
                     at25,byte-len =3D <1024>;
                     at25,addr-mode =3D <2>;
                     at25,page-size =3D <32>;
                 };
                 iio: csfav@7 {
                     compatible =3D "iio,ad7923", "cs,mia-fav";
                     spi-max-frequency =3D <2000000>;
                     reg =3D <7>;
                     spi-cs-high;
                     spi-cpol;
                     fav-id =3D <3 5 6>;
                     #io-channel-cells =3D <1>;
                 };
                 gpiofav: csfavgw@7 {
                     compatible =3D "gpio,max7301", "cs,mia-fav";
                     spi-max-frequency =3D <2000000>;
                     reg =3D <7>;
                     spi-cs-high;
                     #gpio-cells =3D <2>;
                     gpio-controller;
                     fav-id =3D <4>;
                 };
                 csfavfpga@8 {
                     compatible =3D "cs,fpga-poste", "cs,mia-fav";
                     spi-max-frequency =3D <2000000>;
                     reg =3D <8>;
                     spi-cs-high;
                     fav-id =3D <3>;
                 };
             };

             dummy_pio {
                 compatible =3D "s3k,dummy_pio";
                 reg =3D <0xa980 0x40>;
             };

             dummy: gpio-controller@dummygpio {
                 #gpio-cells =3D <2>;
                 compatible =3D "s3k,dummy-gpio";
                 reg =3D <0x2 0x1>; /* necessaire mais non utilise */
                 gpio-controller;
             };

             gpio-leds {
                 compatible =3D "gpio-leds", "cs,mia-fav";
                 fav-id =3D <4>;
                 port_31 {
                     label =3D "favgw:red:1";
                     gpios =3D <&gpiofav 27 1>;
                 };
                 port_30 {
                     label =3D "favgw:red:2";
                     gpios =3D <&gpiofav 26 1>;
                 };
                 port_29 {
                     label =3D "favgw:red:3";
                     gpios =3D <&gpiofav 25 1>;
                 };
                 port_28 {
                     label =3D "favgw:red:4";
                     gpios =3D <&gpiofav 24 1>;
                 };
                 port_27 {
                     label =3D "favgw:red:5";
                     gpios =3D <&gpiofav 23 1>;
                 };
                 port_26 {
                     label =3D "favgw:red:6";
                     gpios =3D <&gpiofav 22 1>;
                 };
                 port_25 {
                     label =3D "favgw:red:7";
                     gpios =3D <&gpiofav 21 1>;
                 };
                 port_24 {
                     label =3D "favgw:red:8";
                     gpios =3D <&gpiofav 20 1>;
                 };
                 port_23 {
                     label =3D "favgw:green:1";
                     gpios =3D <&gpiofav 19 1>;
                 };
                 port_22 {
                     label =3D "favgw:green:2";
                     gpios =3D <&gpiofav 18 1>;
                 };
                 port_21 {
                     label =3D "favgw:green:3";
                     gpios =3D <&gpiofav 17 1>;
                 };
                 port_20 {
                     label =3D "favgw:green:4";
                     gpios =3D <&gpiofav 16 1>;
                 };
                 port_19 {
                     label =3D "favgw:green:5";
                     gpios =3D <&gpiofav 15 1>;
                 };
                 port_18 {
                     label =3D "favgw:green:6";
                     gpios =3D <&gpiofav 14 1>;
                 };
                 port_17 {
                     label =3D "favgw:green:7";
                     gpios =3D <&gpiofav 13 1>;
                 };
                 port_16 {
                     label =3D "favgw:green:8";
                     gpios =3D <&gpiofav 12 1>;
                 };
                 port_15 {
                     label =3D "favgw:yellow:9";
                     gpios =3D <&gpiofav 11 1>;
                 };
                 port_14 {
                     label =3D "favgw:yellow:10";
                     gpios =3D <&gpiofav 10 1>;
                 };
                 port_13 {
                     label =3D "favgw:yellow:11";
                     gpios =3D <&gpiofav 9 1>;
                 };
                 port_12 {
                     label =3D "favgw:yellow:12";
                     gpios =3D <&gpiofav 8 1>;
                 };
                 port_11 {
                     label =3D "favgw:yellow:13";
                     gpios =3D <&gpiofav 7 1>;
                 };
                 port_10 {
                     label =3D "favgw:yellow:14";
                     gpios =3D <&gpiofav 6 1>;
                 };
                 port_9 {
                     label =3D "favgw:yellow:15";
                     gpios =3D <&gpiofav 5 1>;
                 };
                 port_8 {
                     label =3D "favgw:yellow:16";
                     gpios =3D <&gpiofav 4 1>;
                 };
             };
         };

/*        crypto@20000 {
             compatible =3D "fsl,sec1.2", "fsl,sec1.0";
             reg =3D <0x20000 0x8000>;
             interrupts =3D <1 1>;
             interrupt-parent =3D <&PIC>;
             fsl,num-channels =3D <1>;
             fsl,channel-fifo-len =3D <24>;
             fsl,exec-units-mask =3D <0x4c>;
             fsl,descriptor-types-mask =3D <0x05000155>;
         };
*/    };

     chosen {
         linux,stdout-path =3D &smc1;
     };
};



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
