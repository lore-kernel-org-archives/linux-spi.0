From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] extcon: sm5502: EXTCON_SM5502 should depend on I2C
Date: Thu, 21 Aug 2014 14:45:49 +0900
Message-ID: <53F5878D.3030700@samsung.com>
References: <2048653519.580921408598869113.JavaMail.weblogic@epmlwas01c>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <2048653519.580921408598869113.JavaMail.weblogic@epmlwas01c>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Myungjoo,

On 08/21/2014 02:27 PM, MyungJoo Ham wrote:
>> Hi Geert
>>
>> Thanks for your report. I already sent a patch[1] to fix this build =
break
>> and I'll send pull request to includec this patch in 3.17-rc2.
>>
>> [1] https://lkml.org/lkml/2014/8/13/761
>>
>> Best Regards,
>> Chanwoo Choi
>=20
> I do not object to this patch or your patch[1].
>=20
> However, wouldn't it be better to add depends on I2C at REGMAP_I2C?
> When you use REGMAP_I2C, you assume that I2C is already there, don't =
you?

The previous REGMAP_I2C has not the dependency on I2C.
So, Greert posted following patch[1] to fix it.
[1] https://lkml.org/lkml/2014/8/17/27

Also, if I2C is 'm' (module) and some driver has not dependency on I2C,
build break happen.

Thanks
Chanwoo Choi,


>=20
>=20
> Cheers,
> MyungJoo
>=20
>>
>>
>> On 08/17/2014 07:08 PM, Geert Uytterhoeven wrote:
>>> EXTCON_SM5502 selects REGMAP_I2C, but if I2C=3Dn:
>>>
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_smbus_by=
te_reg_read=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:28: error: implicit declaration of=
 function =A1=AEi2c_smbus_read_byte_data=A1=AF
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_smbus_by=
te_reg_write=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:46: error: implicit declaration of=
 function =A1=AEi2c_smbus_write_byte_data=A1=AF
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_smbus_wo=
rd_reg_read=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:64: error: implicit declaration of=
 function =A1=AEi2c_smbus_read_word_data=A1=AF
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_smbus_wo=
rd_reg_write=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:82: error: implicit declaration of=
 function =A1=AEi2c_smbus_write_word_data=A1=AF
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_i2c_writ=
e=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:96: error: implicit declaration of=
 function =A1=AEi2c_master_send=A1=AF
>>> drivers/base/regmap/regmap-i2c.c: In function =A1=AEregmap_i2c_gath=
er_write=A1=AF:
>>> drivers/base/regmap/regmap-i2c.c:117: error: implicit declaration o=
f function =A1=AEi2c_check_functionality=A1=AF
>>> drivers/base/regmap/regmap-i2c.c:130: error: implicit declaration o=
f function =A1=AEi2c_transfer=A1=AF
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>>> ---
>>>  drivers/extcon/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>>> index 6f2f4727de2c..764f3a113e0a 100644
>>> --- a/drivers/extcon/Kconfig
>>> +++ b/drivers/extcon/Kconfig
>>> @@ -72,6 +72,7 @@ config EXTCON_PALMAS
>>> =20
>>>  config EXTCON_SM5502
>>>  	tristate "SM5502 EXTCON support"
>>> +	depends on I2C
>>>  	select IRQ_DOMAIN
>>>  	select REGMAP_I2C
>>>  	select REGMAP_IRQ
>>>
>>
>>
>>
>>
>>       =20
>>  =20
>>         =20
>>
