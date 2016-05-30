From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] spi: xilinx: Update devicetree bindings for
 spi-xilinx
Date: Mon, 30 May 2016 18:38:39 +0100
Message-ID: <20160530173839.GA29837@sirena.org.uk>
References: <1464601627-5246-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tK3TaB1xs9ylLrl6"
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464601627-5246-1-git-send-email-nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tK3TaB1xs9ylLrl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 30, 2016 at 03:17:07PM +0530, Naga Sureshkumar Relli wrote:

> Update bindings for spi-xilinx.
> as per spi-bus.txt rename num-ss-bits to num-cs.
> and add fifo-size and bits-per-word properties.

This makes the new bindings backwards incompatible breaking existing
machine descriptions.  It's fine to add new options but the driver
should accept the old options.

--tK3TaB1xs9ylLrl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTHqdAAoJECTWi3JdVIfQF18H/iPA0TN7RxwiawQPBMUat99E
yzKIhVmm7v9gUAjp8Y5eYzU2+aqvmfYLI3nqafWf9g1KxlXnn8jAE829PcjfcvAe
MnqwBzJI3Z2XKmLhprayWZo3rf431yk69gfwhMibkW/B21oJ179GayxEg/pOFEee
Him6+NNUs0i1XpqIw9PXIvKpXuwfvQcL8/CmlArHxPcoeQO3G/jL0PPYGdMlyven
gjkoesBBzjHHIcSm9Qvr3uqSI7ieNuLEKuDvzUXCub7g8UgWnkgfkSQ2RObZ+EzX
dsHYoyk8lO3G6LxYjZxb0Pb49Aa+oDETj/J82F9p71PR1wYBubtCnpaUMiJcHDc=
=brC3
-----END PGP SIGNATURE-----

--tK3TaB1xs9ylLrl6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
