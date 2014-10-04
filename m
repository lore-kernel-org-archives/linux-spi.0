From: christophe leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Date: Sat, 04 Oct 2014 12:07:08 +0200
Message-ID: <542FC6CC.4000507@c-s.fr>
References: <20141003164917.397871AB276@localhost.localdomain> <1412365908.13320.429.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412365908.13320.429.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Le 03/10/2014 21:51, Scott Wood a =C3=A9crit :
> On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
>> On CPM1, the SPI parameter RAM has a default location. In order to u=
se SPI while
>> using SCC2 with features like QMC or Ethernet, it is necessary to re=
locate SPI
>> parameter RAM in a free location in the CPM dual port RAM.
> Please explain in more detail why it's necessary.
SCC2 parameter RAM is located at offset 0x1D00 inside the CPM dual port=
 RAM.
SPI parameter RAM is located at offset 0x1D80.
When using SCC2 in Ethernet Mode, the parameter RAM size is 0xA4.
When using SCC2 in QMC mode, the parameter RAM size is 0xAC.
Therefore in both case, it overlaps the SPI parameter RAM which shall=20
then be relocated.
On MPC860 this can only be done using an additional microcode.=20
Therefore, the relocation configuration is managed within=20
arch/powerpc/sysdep/micropatch.c
On MPC866 and MPC885 (at least) no microcode is needed. Therefore, if w=
e=20
want to relocate the SPI param, we must handle that outside of micropat=
ch.c
Since the SPI driver already handle dynamic parameter RAM allocation fo=
r=20
CPM2, I though it was the good place to do it also for CPM1.
>
>>   With this patch,
>> when "fsl,cpm1-spi-reloc" instead of "fsl,cpm1-spi" compatible is se=
t in the
>> device tree, the parameter RAM for SPI is dynamically allocated
>> with cpm_muram_alloc().
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
>>
>> ---
>> Changes from v1 to v2: using OF compatible instead of compile time o=
ption
>>
>>   drivers/spi/spi-fsl-cpm.c   | 3 +++
>>   drivers/spi/spi-fsl-lib.c   | 2 ++
>>   include/linux/fsl_devices.h | 1 +
>>   3 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
>> index 0f3a912..048ca5f 100644
>> --- a/drivers/spi/spi-fsl-cpm.c
>> +++ b/drivers/spi/spi-fsl-cpm.c
>> @@ -261,6 +261,9 @@ static unsigned long fsl_spi_cpm_get_pram(struct=
 mpc8xxx_spi *mspi)
>>   	if (mspi->flags & SPI_CPM2) {
>>   		pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
>>   		out_be16(spi_base, pram_ofs);
>> +	} else if (mspi->flags & SPI_CPM1_RELOC) {
>> +		pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 32);
>> +		out_be16(spi_base, pram_ofs);
>>   	} else {
>>   		u16 rpbase =3D in_be16(spi_base);
>>  =20
>> diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
>> index c3f7802..e9db4c5 100644
>> --- a/drivers/spi/spi-fsl-lib.c
>> +++ b/drivers/spi/spi-fsl-lib.c
>> @@ -227,6 +227,8 @@ int of_mpc8xxx_spi_probe(struct platform_device =
*ofdev)
>>   		pdata->flags =3D SPI_CPM_MODE | SPI_CPM2;
>>   	else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
>>   		pdata->flags =3D SPI_CPM_MODE | SPI_CPM1;
>> +	else if (of_device_is_compatible(np, "fsl,cpm1-spi-reloc"))
>> +		pdata->flags =3D SPI_CPM_MODE | SPI_CPM1 | SPI_CPM1_RELOC;
> Where's the binding and device tree update for this?  What specific
> aspect of hardware does it describe?
Well, the intension was not really to describe any specific aspect of=20
hardware, but to provide an easy way to tell the driver that we want=20
dynamic reallocation of the parameter RAM.
On CPM2, dynamic allocation of parameter RAM is the only way.
On CPM1:
* The parameter RAM has a default location.
* When the SPI relocation micropatch is applied, the kernel reallocate=20
it just after the patch, when loading the patch. This is not good for=20
using QMC, because it is within the part of dual port RAM used by the=20
QMC, therefore it reduce even more the number of channels that the QMC=20
can use.

The bindings for that driver are described in=20
Documentation/devicetree/bindings/spi/fsl-spi.txt. But it seems that it=
=20
doesn't describe anything related to those compatibles. The driver has =
a=20
match on "fsl,fsl-spi" only, and for using it with CPM you have to add=20
"fsl,cpm1-spi" or "fsl,cpm2-spi" to tell the driver that it is CPM=20
(existing code below).

     prop =3D of_get_property(np, "mode", NULL);
     if (prop && !strcmp(prop, "cpu-qe"))
         pdata->flags =3D SPI_QE_CPU_MODE;
     else if (prop && !strcmp(prop, "qe"))
         pdata->flags =3D SPI_CPM_MODE | SPI_QE;
     else if (of_device_is_compatible(np, "fsl,cpm2-spi"))
         pdata->flags =3D SPI_CPM_MODE | SPI_CPM2;
     else if (of_device_is_compatible(np, "fsl,cpm1-spi"))
         pdata->flags =3D SPI_CPM_MODE | SPI_CPM1;


Christophe

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malve=
illant parce que la protection avast! Antivirus est active.
http://www.avast.com

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
