From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI controller
 driver
Date: Wed, 29 Jan 2014 12:25:20 +0000
Message-ID: <20140129122520.GY11841@sirena.org.uk>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ngzzM5pmpwpXLzY5"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390993850-9054-4-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ngzzM5pmpwpXLzY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2014 at 12:10:48PM +0100, Maxime Ripard wrote:

> +config SPI_SUN6I
> +	tristate "Allwinner A31 SPI controller"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select PM_RUNTIME
> +	help
> +	  This enables using the SPI controller on the Allwinner A31 SoCs.
> +

A select of PM_RUNTIME is both surprising and odd - why is that there?
The usual idiom is that the device starts out powered up (flagged using
pm_runtime_set_active()) and then runtime PM then suspends it when it's
compiled in.  That way if for some reason people want to avoid runtime
PM they can still use the device.

> +static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
> +	u32 reg;
> +
> +	if (!enable)
> +		return;
> +
> +	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> +	reg &= ~SUN6I_TFR_CTL_CS_MASK;
> +	reg |= SUN6I_TFR_CTL_CS(spi->chip_select);
> +	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
> +}

The !enable means that it'll only ever be able to go one way.  Also note
that the documentation was clarified here to make the enable flag be the
absolute logic level, not if chip select was asserted.

> +	timeout = wait_for_completion_timeout(&sspi->done,
> +					      msecs_to_jiffies(1000));
> +	if (!timeout) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);

This means we can only transfer a single FIFO of data?  I didn't see a
check on the transfer length.

--ngzzM5pmpwpXLzY5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6PMtAAoJELSic+t+oim9xHwP/2J4oRaYPuNiNN5+qJ4d/szy
5JWXyYZJ3Amd5h53/2mRXFWx00uQgzNa+OSmiVU+J84lYyhaxAdxSRans99DRbUo
x0Kr5PjKWh3X+RKDo4NRYci/1/1wWdEJsZtjH/vLPgetlauk3Wl0TngHuR3ntE8x
PYLvidrtLTppwX1WWe8NSBpzvkczG9U8nM7MMja/+LdHq2QUK/qgsWHZ1NNkCEiv
rYudJxSWBhgkY0IR9BjtQ9a4Z6WI5R3XtwTGzLEmu6mPp1jGo/VSy/CD9yHJJvz8
g6rPe50CHTM+z+8cu5VSQfYBtnb8X8WdguoZeE1b+jUPzg6ac25FZ8kDjmM8JgOZ
o11SssGUdwj7BIdqkPxYIt4Y3qlYhK7nx7LvHdD1sKwpTO7LJNiSV4rOMYpeod09
MOhE/NdzfCUIe4S6NzXE4Zp3IzXfRICJ+unztH5I+fmB1FfYnAx88uuHvGdOetIp
FqEPt3030Ii+np3SWvlIje3tdqdrVemlwH+9HrAhKbthuIsaRd6+5yerUExwjDcH
zDk4w+bfWRySWvmj6e6AX/XD6Q3CZHXsRQ9NH6qd0KL5c0s2b4QlAI87uErIMSXe
AAQt09N5aQ4p1QSjymsfi1nXtbI9SaBNdQrbVfvUdZNTCZq2+xAa39cNzLLlUH70
ZAswp5Id1OfEiWBkoh5q
=VL1z
-----END PGP SIGNATURE-----

--ngzzM5pmpwpXLzY5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
