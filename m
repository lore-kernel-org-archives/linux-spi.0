From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: davinci: add support to configure gpio cs
 through dt
Date: Thu, 31 Jul 2014 20:35:15 +0100
Message-ID: <20140731193515.GO17528@sirena.org.uk>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
 <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="87QXWO7lMBldenH3"
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406827995-30913-3-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--87QXWO7lMBldenH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 31, 2014 at 08:33:15PM +0300, Grygorii Strashko wrote:

> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
> +		/* SPI core parse and update master->cs_gpio */
>  		gpio_chipsel = true;
> +		gpio = spi->cs_gpio;
> +	} else if (pdata->chip_sel &&
> +		   chip_sel < pdata->num_chipselect &&
> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
> +		/* platform data defines chip_sel */
> +		gpio_chipsel = true;
> +		gpio = pdata->chip_sel[chip_sel];
> +	}

This would all be a lot simpler and more direct if you were to arrange
to use cs_gpio in the struct spi_device, and move you closer to
converting to use more of the core functionality.

> +		if (np && (master->cs_gpios != NULL) && (spi->cs_gpio >= 0)) {
> +			retval =
> +				gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> +			if (retval) {
> +				dev_err(&spi->dev,
> +					"GPIO %d request failed\n",
> +					spi->cs_gpio);
> +				return -ENODEV;
> +			}
> +			gpio_direction_output(spi->cs_gpio,
> +					      !(spi->mode & SPI_CS_HIGH));
> +			internal_cs = false;

It's much better to use gpio_request_one() rather than using
gpio_request(), it's one function apart from anything else.  The above
is also discarding the return code of gpio_request() meaning it's broken
for deferred probe.  The error code should also appear in the error
message.

--87QXWO7lMBldenH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2ppvAAoJELSic+t+oim9t1EP/Azk99OynmPlPKvCuj4/Jvpt
W4ZDBcAyLcrJXg4UDBUnau2ehlgwgLv63vnTnHS07T1HBDMQe0TGNoMam3OyFhSw
WhVTQr1hgjjiRhwNAHLbk8+EW516WQrjwCPjv3trXG6QJXg7N4QOP3WXBUc5hVM/
rrdGXwSNersy5XShUp0jn5vtylTmtgp1oWmyl8ztoiLPAKKaWUbnBaDUYnBp8LGN
QK2zhMwVSVmYeCR1Pvo1x561rmjP+GkZ2gTVPIl3gBem0hnmhc+oF+5PqGGxjFhM
AcGAafbLT0PLpFQL7r9kikA8Xe0o9xTmtnxrvz0NY9U/wMU3D0JSWZxES3uG/FOe
tXZ1oqA///t7aDrkrGzqYqUMyJWSQ9YacGVR8AHArzqHtNys9mov+w9KbEUvnJt6
pRa6Zl5JM5ojRGACduo5iTYNF0eQcNkzQB+LnxMF8vEd1M5p0v08Ll8HsTtRzZD0
pXpbyaKFbba0WoFPlZep8cnOmFLSSBYsE/Db1k9jER9N+TeuHER2e78w8hPSLGBL
+bwSqUcPlkHOIG3WN720veftWZqeGd5CKJjGr8EV/DzbWzlthtMG+VZ2zYv1LoDj
T0LnOfIsv1o4L5aPsI0Gwqreo47BIEAaxeIGdP5d6nc8h0C9Yv4WT9G8zGv6nf48
EJLHtQPHsr5ZFGLgeEDk
=JffP
-----END PGP SIGNATURE-----

--87QXWO7lMBldenH3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
