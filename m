From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v6] Add Dallas DS1390/93/94 RTC chips
Date: Mon, 10 Nov 2008 14:49:17 -0800
Message-ID: <200811101449.17972.david-b@pacbell.net>
References: <4912B459.2020704@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4912B459.2020704-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 06 November 2008, Mark Jackson wrote:
> v6 (!!) of this patch with even more code tidying as per previous comment=
s.
> Also only a single tx/rx buffer is used.
> Now uses spi_write_then_read()
> Comments changed to include extra chips in the family
> =

> This patch adds support for the Dallas DS1390/93/94 SPI RTC chip.
> =

> Signed-off-by: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Although I wouldn't bother using the "wday" field at all.
Linux doesn't use that field, so trying to maintain it isn't
useful ... though it probably doesn't hurt, assuming the
chip behaves OK when invalid data is written there.


Also, in probe():

> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "DS1390 SPI RTC driver\n");

I dislike those banners in general.  Best to remove that,
since the RTC framework announces the registration.  Or
at least, dev_info().


> +	spi->mode =3D SPI_MODE_3;
> +	spi->bits_per_word =3D 8;
> +	spi_setup(spi);

Unlikely to fail ... but =


	res =3D spi_setup(spi);
	if (res < 0) {
		/* or do it before the kzalloc, no kfree
		 * ... likewise with reading the register
		 * as an "is it there" check:  do it earlier
		 * and get a similar minor codeshrink.
		 */
		kfree(chip);
		return res;
	}

> +
> +	dev_set_drvdata(&spi->dev, chip);
> +
> +	res =3D ds1390_get_reg(&spi->dev, DS1390_REG_SECONDS, &tmp);
> +	if (res) {
> +		dev_err(&spi->dev, "DS1390: unable to read device\n");
> +		kfree(chip);
> +		return res;
> +	}
> +
> +	rtc =3D rtc_device_register("ds1390",
> +				&spi->dev, &ds1390_rtc_ops, THIS_MODULE);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
