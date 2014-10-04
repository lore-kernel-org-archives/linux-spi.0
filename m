From: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
Date: Sat, 04 Oct 2014 14:02:12 +0200
Message-ID: <542FE1C4.7000403@c-s.fr>
References: <20141003164916.DBD631AAFA2@localhost.localdomain> <1412368198.13320.434.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412368198.13320.434.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 03/10/2014 22:29, Scott Wood a =C3=A9crit :
> On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
>> On CPM1, the SPI parameter RAM has a default location. In fsl_spi_cp=
m_get_pram()
>> there was a confusion between the SPI_BASE register and the base of =
the SPI
>> parameter RAM. Fortunatly, it was working properly with MPC866 and M=
PC885
>> because they do set SPI_BASE, but on MPC860 and other old MPC8xx tha=
t doesn't
>> set SPI_BASE, pram_ofs was not properly set. This patch fixes this c=
onfusion.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
>>
>> ---
>> Changes from v1 to v2: none
>>
>>   drivers/spi/spi-fsl-cpm.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
>> index 54b0637..0f3a912 100644
>> --- a/drivers/spi/spi-fsl-cpm.c
>> +++ b/drivers/spi/spi-fsl-cpm.c
>> @@ -262,15 +262,14 @@ static unsigned long fsl_spi_cpm_get_pram(stru=
ct mpc8xxx_spi *mspi)
>>   		pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>>   		out_be16(spi_base, pram_ofs);
>>   	} else {
>> -		struct spi_pram __iomem *pram =3D spi_base;
>> -		u16 rpbase =3D in_be16(&pram->rpbase);
>> +		u16 rpbase =3D in_be16(spi_base);
>>  =20
>> -		/* Microcode relocation patch applied? */
>> +		/* Microcode relocation patch applied | rpbase set by default */
>>   		if (rpbase) {
>>   			pram_ofs =3D rpbase;
>>   		} else {
>> -			pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>> -			out_be16(spi_base, pram_ofs);
>> +			pram_ofs =3D offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
>> +				   offsetof(cpm8xx_t, cp_dpmem[0]);
>>   		}
>>   	}
> Why is PROFF_SPI not coming from the device tree?
That's where it starts to become tricky.

PROFF_SPI is defined in cpm1.h which is included by the driver already.=
=20
It provides the default offset from the start of the parameter RAM.
Previously I had the following in my device tree, and the last part of=20
the source above (the one for rpbase =3D=3D 0) could not work.

             spi: spi@a80 {
                 cell-index =3D <0>;
                 compatible =3D "fsl,spi", "fsl,cpm1-spi";
                 reg =3D <0xa80 0x30 0x3d80 0x30>;

=46irst reg area was the area for SPI registers. Second area was the=20
parameter RAM zone, which was just mapped to get access to the SPI_BASE=
=20
pointer (rpbase)

Now I have

                 compatible =3D "fsl,spi", "fsl,cpm1-spi-reloc";
                 reg =3D <0xa80 0x30 0x3dac 0x2>;

=46irst reg area is the area for SPI registers. Second area is the=20
SPI_BASE, as for the CPM2.

On recent 8xx (885 and 866 at least) it contains the offset (=3D0x1D80)=
 of=20
the parameter RAM. But on old ones (860, ...) it contains 0. Therefore=20
we have to get the default index in another way.
What I wanted was to keep something similar to what's done with CPM2.

What should it look like if that offset had to be in the device tree ?

> Why don't I see any
> cpm spi in any device tree nor any binding for it?
There's one in mgcoge.dts:

             spi@11aa0 {
                 cell-index =3D <0>;
                 compatible =3D "fsl,spi", "fsl,cpm2-spi";
                 reg =3D <0x11a80 0x40 0x89fc 0x2>;

Christophe

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malve=
illant parce que la protection avast! Antivirus est active.
http://www.avast.com

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
