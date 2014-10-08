From: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
Date: Wed, 08 Oct 2014 18:21:51 +0200
Message-ID: <5435649F.5070908@c-s.fr>
References: <20141003164916.DBD631AAFA2@localhost.localdomain>	 <1412368198.13320.434.camel@snotra.buserror.net> <542FE1C4.7000403@c-s.fr> <1412640953.13320.502.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412640953.13320.502.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 07/10/2014 02:15, Scott Wood a =C3=A9crit :
> On Sat, 2014-10-04 at 14:02 +0200, christophe leroy wrote:
>> Le 03/10/2014 22:29, Scott Wood a =C3=A9crit :
>>> On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
>>>> On CPM1, the SPI parameter RAM has a default location. In fsl_spi_=
cpm_get_pram()
>>>> there was a confusion between the SPI_BASE register and the base o=
f the SPI
>>>> parameter RAM. Fortunatly, it was working properly with MPC866 and=
 MPC885
>>>> because they do set SPI_BASE, but on MPC860 and other old MPC8xx t=
hat doesn't
>>>> set SPI_BASE, pram_ofs was not properly set. This patch fixes this=
 confusion.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
>>>>
>>>> ---
>>>> Changes from v1 to v2: none
>>>>
>>>>    drivers/spi/spi-fsl-cpm.c | 9 ++++-----
>>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
>>>> index 54b0637..0f3a912 100644
>>>> --- a/drivers/spi/spi-fsl-cpm.c
>>>> +++ b/drivers/spi/spi-fsl-cpm.c
>>>> @@ -262,15 +262,14 @@ static unsigned long fsl_spi_cpm_get_pram(st=
ruct mpc8xxx_spi *mspi)
>>>>    		pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>>>>    		out_be16(spi_base, pram_ofs);
>>>>    	} else {
>>>> -		struct spi_pram __iomem *pram =3D spi_base;
>>>> -		u16 rpbase =3D in_be16(&pram->rpbase);
>>>> +		u16 rpbase =3D in_be16(spi_base);
>>>>   =20
>>>> -		/* Microcode relocation patch applied? */
>>>> +		/* Microcode relocation patch applied | rpbase set by default *=
/
>>>>    		if (rpbase) {
>>>>    			pram_ofs =3D rpbase;
>>>>    		} else {
>>>> -			pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>>>> -			out_be16(spi_base, pram_ofs);
>>>> +			pram_ofs =3D offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
>>>> +				   offsetof(cpm8xx_t, cp_dpmem[0]);
>>>>    		}
>>>>    	}
>>> Why is PROFF_SPI not coming from the device tree?
>> That's where it starts to become tricky.
>>
>> PROFF_SPI is defined in cpm1.h which is included by the driver alrea=
dy.
> Yes, but those values shouldn't be used.  It's a leftover from the ol=
d
> way of hardcoding things and describing the hardware with kconfig rat=
her
> than the device tree.
>
>> It provides the default offset from the start of the parameter RAM.
>> Previously I had the following in my device tree, and the last part =
of
>> the source above (the one for rpbase =3D=3D 0) could not work.
>>
>>               spi: spi@a80 {
>>                   cell-index =3D <0>;
>>                   compatible =3D "fsl,spi", "fsl,cpm1-spi";
>>                   reg =3D <0xa80 0x30 0x3d80 0x30>;
>>
>> First reg area was the area for SPI registers. Second area was the
>> parameter RAM zone, which was just mapped to get access to the SPI_B=
ASE
>> pointer (rpbase)
>>
>> Now I have
>>
>>                   compatible =3D "fsl,spi", "fsl,cpm1-spi-reloc";
>>                   reg =3D <0xa80 0x30 0x3dac 0x2>;
>>
>> First reg area is the area for SPI registers. Second area is the
>> SPI_BASE, as for the CPM2.
>>
>> On recent 8xx (885 and 866 at least) it contains the offset (=3D0x1D=
80) of
>> the parameter RAM. But on old ones (860, ...) it contains 0. Therefo=
re
>> we have to get the default index in another way.
>> What I wanted was to keep something similar to what's done with CPM2=
=2E
>>
>> What should it look like if that offset had to be in the device tree=
 ?
> If the offset is not relocatable or discoverable, it should stay in t=
he
> device tree.  If you have an old chip you wouldn't have
> fsl,cpm1-spi-reloc and thus you'd still have "0x3d80 0x30" in reg.
This index is from the start of the dual port RAM. It is 0x2000 above=20
the start of the CPM area.
In the DTS, we have:

     soc@ff000000 {
         compatible =3D "fsl,mpc885", "fsl,pq1-soc";
         #address-cells =3D <1>;
         #size-cells =3D <1>;
         device_type =3D "soc";
         ranges =3D <0x0 0xff000000 0x28000>;
         bus-frequency =3D <0>;
         clock-frequency =3D <0>;

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

             spi: spi@a80 {
                 #address-cells =3D <1>;
                 #size-cells =3D <0>;
                 cell-index =3D <0>;
                 compatible =3D "fsl,spi", "fsl,cpm1-spi";
                 reg =3D <0xa80 0x30 0x3d80 0x30>;
                 interrupts =3D <5>;
                 interrupt-parent =3D <&CPM_PIC>;
                 mode =3D "cpu";


The binding allows me to do an of_iomap() on the parameter RAM, hence t=
o=20
get access to the relocation index which is inside it.
But if the relocation index is 0, I have to calculate it by myself=20
because the calling function expects it in return.
The binding is also supposed to tell that the muram is at 0xff002000.=20
But I don't know how I can get this info and use it to calculate the=20
index of my param RAM ? I need to calculate the index which is 1d80=20
(0x3d80 - 0x2000)

Christophe

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
