From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] spi: orion.c: Add direct access mode
Date: Mon, 18 Apr 2016 12:04:15 +0100
Message-ID: <20160418110415.GT3217@sirena.org.uk>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4437692.8jaX7AeWuo@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gSSGYPGSs0dvYOj7"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4437692.8jaX7AeWuo@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gSSGYPGSs0dvYOj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:

> This would be easier if have a conclusive proof that 1MB per CS always enough.
> Is this something that is guaranteed in the SPI spec or the documentation for
> this controller?

There's no spec for SPI but if there were it'd be hard to see it
imposing a limit, one can transfer data as long as the bus is clocked
(which some things like ADCs and DACs make use of).

--gSSGYPGSs0dvYOj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFL8uAAoJECTWi3JdVIfQrN0H/2W6Khd8SZsna/BCbzooP4Fg
C5B6s3YRSjRA/3Kptizijf9oM/ofvd0FKCCSuXQHzmJGC5Qm9y9KLbzjxHnhQuBN
Op41ZJLdz2tFzYSiygeUYrglfYhKN1mbcr/3p6TxXKaWv93ZI32KeYMKaX3ODNYr
B/AtkX94xhwqlRhlv+yHk1q8Fu9FiWH4G0ksRZVLdIQcyMbUy4Jjv8/9dvxzjMPa
3DF/LMuRJMmlO4kO0DpIcHyY7o7CtEixGdwprTs0alIfb9c2oSjlJwJpF0nZgRLb
/vmKA1jHUbhCGRhZxO83kl3aYI16PyymatDjvLzoImhh78t7su3hKJEu/rGftas=
=0a3U
-----END PGP SIGNATURE-----

--gSSGYPGSs0dvYOj7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
