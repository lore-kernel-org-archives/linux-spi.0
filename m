From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next v4 3/5] mtd: spi-nor: allow to tune the number
 of dummy cycles
Date: Mon, 24 Aug 2015 18:42:46 +0200
Message-ID: <55DB4986.1000207@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <b0d8470fdd46e89ef692e27dc2600b880c1d5dde.1440410236.git.cyrille.pitchen@atmel.com> <201508241248.17466.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201508241248.17466.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Marek,

Le 24/08/2015 12:48, Marek Vasut a =E9crit :
> On Monday, August 24, 2015 at 12:13:58 PM, Cyrille Pitchen wrote:
>> The number of dummy cycles used during Fast Read commands can be red=
uced
>> to improve transfer performances. Each manufacturer has a dedicated =
set of
>> registers to provide the memory with the exact number of dummy cycle=
s it
>> should expect. Both the memory and the (Q)SPI controller must agree =
on
>> this number of dummy cycles.
>>
>> The number of dummy cycles can be found into the memory datasheet an=
d
>> mostly depends on the SPI clock frequency, the Fast Read op code and=
 the
>> Single/Dual Data Rate mode.
>>
>> Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables wou=
ld
>> only provide the driver with a high enough number of dummy cycles fo=
r each
>> Fast Read command to be used for all clock frequencies: this solutio=
n
>> would not be optimized.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>=20
> Hi!
>=20
>>  drivers/mtd/spi-nor/spi-nor.c | 97
>> ++++++++++++++++++++++++++++++++++--------- include/linux/mtd/spi-no=
r.h =20
>> |  2 +
>>  2 files changed, 80 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi=
-nor.c
>> index e2a6029dc056..869e098a6841 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -119,24 +119,6 @@ static int read_cr(struct spi_nor *nor)
>>  }
>>
>>  /*
>> - * Dummy Cycle calculation for different type of read.
>> - * It can be used to support more commands with
>> - * different dummy cycle requirements.
>> - */
>> -static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
>> -{
>> -	switch (nor->flash_read) {
>> -	case SPI_NOR_FAST:
>> -	case SPI_NOR_DUAL:
>> -	case SPI_NOR_QUAD:
>> -		return 8;
>> -	case SPI_NOR_NORMAL:
>> -		return 0;
>> -	}
>> -	return 0;
>> -}
>=20
> You can probably just soup up this function so that it sets the
> nor->read_dummy, no ?
>

Actually, this is what the patch does: spi_nor_read_dummy_cycles() was =
reused
and enhanced few lines below where you've pointed out the=20
"switch (nor->flash_read)" block should be move after the else block.

I think when I wrote the code I've chosen to move the definition of thi=
s
function instead of adding forward declarations of functions such as re=
ad_cr()
or write_sr_cr(), which are now called by micron_set_dummy_cycles().

>> -/*
>>   * Write status register 1 byte
>>   * Returns negative if error occurred.
>>   */
>> @@ -1012,6 +994,81 @@ static int set_quad_mode(struct spi_nor *nor, =
struct
>> flash_info *info) }
>>  }
>>
>> +static int micron_set_dummy_cycles(struct spi_nor *nor)
>> +{
>> +	int ret;
>> +	u8 val, mask;
>> +
>> +	/* read the Volatile Configuration Register (VCR) */
>=20
> NIT: If this is a sentence, start it with capital letter and end it w=
ith=20
> fullstop :)
>=20

done for the next version

>> +	ret =3D nor->read_reg(nor, SPINOR_OP_RD_VCR, &val, 1);
>> +	if (ret < 0) {
>> +		dev_err(nor->dev, "error %d reading VCR\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	write_enable(nor);
>> +
>> +	/* update the number of dummy into the VCR */
>=20
> DTTO
>=20

done for the next version

>> +	mask =3D GENMASK(7, 4);
>> +	val &=3D ~mask;
>> +	val |=3D (nor->read_dummy << 4) & mask;
>> +	ret =3D nor->write_reg(nor, SPINOR_OP_WR_VCR, &val, 1, 0);
>> +	if (ret < 0) {
>> +		dev_err(nor->dev, "error while writing VCR register\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D spi_nor_wait_till_ready(nor);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Dummy Cycle calculation for different type of read.
>> + * It can be used to support more commands with
>> + * different dummy cycle requirements.
>> + */
>> +static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
>> +				     const struct flash_info *info)
>> +{
>> +	struct device_node *np =3D nor->dev->of_node;
>> +	u32 num_dummy_cycles;
>> +
>> +	if (np && !of_property_read_u32(np, "m25p,num-dummy-cycles",
>> +					&num_dummy_cycles)) {
>> +		nor->read_dummy =3D num_dummy_cycles;
>> +
>> +		/*
>> +		 * This switch block might be moved after the if...then...else
>> +		 * statement but it was not tested with all Spansion or Micron
>> +		 * memories.
>> +		 * Now the "m25p,num-dummy-cycles" property needs to be
>> +		 * explicitly set in the device tree so the switch statement is
>> +		 * executed. This should avoid unwanted side effects and keep
>> +		 * backward compatibility.
>> +		 */
>> +		switch (JEDEC_MFR(info)) {
>> +		case CFI_MFR_ST:
>> +			return micron_set_dummy_cycles(nor);
>> +		default:
>=20
> If you do have m25p,num-dummy-cycles set for non-micron flash, you ha=
ve a=20
> problem here I believe.
>=20
>> +			break;
>> +		}
>> +	} else {
>=20
> The solution would be to drop this else {} bit here, so that if you f=
ail in
> the DT-based configuration, you fall back to this old behavior. What =
do you=20
> think please ? :)
>=20

Good idea!
I also add a trace for the default case of "switch (JEDEC_MFR(info))":

dev_warn(dev, "can't set the number of dummy cycles\n");

So the user is notified that the driver could not use the value of
"m25p,num-dummy-cycles" from the DT before falling back to the legacy
code.

>> +		switch (nor->flash_read) {
>> +		case SPI_NOR_FAST:
>> +		case SPI_NOR_DUAL:
>> +		case SPI_NOR_QUAD:
>> +			nor->read_dummy =3D 8;
>> +		case SPI_NOR_NORMAL:
>> +			nor->read_dummy =3D 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>=20
> [...]
>=20

thanks for the review!

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
