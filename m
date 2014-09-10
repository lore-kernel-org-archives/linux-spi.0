From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] spi: spi-imx: add DMA support
Date: Wed, 10 Sep 2014 12:45:30 +0100
Message-ID: <20140910114530.GD7960@sirena.org.uk>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <20140910102105.GR2601@sirena.org.uk>
 <20140910112258.GA30794@Robin-OptiPlex-780>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140910112258.GA30794@Robin-OptiPlex-780>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2014 at 07:22:59PM +0800, Robin Gong wrote:
> On Wed, Sep 10, 2014 at 11:21:05AM +0100, Mark Brown wrote:

> > This isn't going to work, anything that looks at the usedma flag will
> > see the result of the last thing that was checked which may or may not
> > be the transfer that it's handling.  The driver should check to see if
> > the core mapped the transfer for DMA.

> Yes, you're right. I should use "transfer->tx_sg->sgl == NULL" or
> "transfer->rx_sg->sgl == NULL" instead of usedma flag in driver, right?

Right.

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEDnZAAoJECTWi3JdVIfQUScH/387Cp1Y8r1kKvVGGJamy69G
GMXCh0iSsSkU0/gCJ9MxRE43cuzxwaknjUupiOTPqlnXYlOwuruljboxe+a+2jfG
UojB7690yUYs1BSNauj3x9N9KEQcOXP5cZ9vYarjqdIW1i+LT8c3wiSQ70rBfHBC
QpHEWYju9gJrYdVLGVTp5V3wpD9CvGSS8I7MnV6WRAdM4dccj4tIbC3Ule3q5yKy
ShNgVfzS+wPMDXAsTcyH+MEMxDj7FZe0WZgZszH/S4zcRxggExbwI9PYhXbM/tC3
rRtSlzgB7YdvCENs4T+TNeCHqj/z8z8dSIn+z9d0tBXOhdWZ6SV6tcUoE4o9IDI=
=RYuO
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
