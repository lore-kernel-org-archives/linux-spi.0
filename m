From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] spi: dw: make sure SPI controller is enabled
Date: Fri, 6 Mar 2015 20:33:47 +0000
Message-ID: <20150306203347.GF21293@sirena.org.uk>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425301137-8043-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rKmsGiK4KDf+3lKL"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425301137-8043-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rKmsGiK4KDf+3lKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 02:58:55PM +0200, Andy Shevchenko wrote:
> The error handling is partially broken since the controller is disabled on
> error and is not re-enabled until condition occurs, i.e. mode (poll, PIO/DMA),
> chip (cs_change), or speed (clk_div) is changed. In the result of these changes
> we will have a predictable state of the SPi controller independently on how
> successfull was a previous transfer.

Applied, thanks.

--rKmsGiK4KDf+3lKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+g8rAAoJECTWi3JdVIfQa8cH/R5EX3FcGdrNsDi49BJJ4F9C
qEk3XKLqW6v0i/oCt0D2oqG3YnxLCrWQSH16iY9JnY+M5yoj7xw3bRyWxV+QWXGc
b57Vn+BlUwRtgomox9MS+4XfodpTnckTX3rSZgB+Yze4U0AEoK4Tlx8ajo0wJ9BW
8UnpJyCh0ECDbPhrqLfuzW9yMsqWyrkuGS0l0miAYnfjkCsPDSmgvA8Pq/kP8rHw
ds/n/aKCVnS8to/qTRtagWy4PEn8Y4LuWivQIG7nf3+Dc83/J7pWOW76XvmNzkZ1
7R9yD60tEIo14jo9jKielF19Y+IL3PONL/sIyVYpPi9RUU9/Zyzlai3spNJJQw0=
=BshU
-----END PGP SIGNATURE-----

--rKmsGiK4KDf+3lKL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
