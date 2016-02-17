From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/13] spi: imx: allow only WML aligned transfers to use
 DMA
Date: Wed, 17 Feb 2016 14:16:19 +0000
Message-ID: <20160217141619.GR7544@sirena.org.uk>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
 <1455715739-25161-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rKoHqF+aPLVth8b2"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455715739-25161-2-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rKoHqF+aPLVth8b2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 17, 2016 at 02:28:47PM +0100, Sascha Hauer wrote:

> Also removing change introduced in f6ee9b582d2db652497b73c1f117591dfb6d3a90
> since this change only fix usecases with transfer size from 33 to 128 bytes
> and doesn't fix 129 bytes and bigger.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--rKoHqF+aPLVth8b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxICyAAoJECTWi3JdVIfQC9UH/3AjYcayJgVW7Vy8RN0qTsUj
T/CPyOPnAzQyzCOzMQ6zkAL5ptmAuB971yJumABBp9hr7hGcvIHbgFJ8klcOSt33
KjvkTDogDAls5v8R97ZQKaZH+eCVkc3YVG1QKSCb8FTz9t4gyaoVlka8gEt461Be
FWM7O95EHbJRsXodnp7TRwRzB1A3bHyU6GTsRdEVzQJ3uyT8Esq6hep0Je/fQF3Q
su4TqOJmQpXoh9bniNKKzJzlP29ie8UXSHYhMljfCjFqJ3Kxl8M3tVac8Ka/VikI
bYCxfVDMq60Q6H1M+71YNAmRsojAQu4jprIzkaGGiaW+xqdq15DeYshh700rfBs=
=4aFa
-----END PGP SIGNATURE-----

--rKoHqF+aPLVth8b2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
