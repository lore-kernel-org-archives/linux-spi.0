From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7] spi: orion.c: Add direct access mode
Date: Mon, 2 May 2016 16:44:41 +0100
Message-ID: <20160502154441.GJ6292@sirena.org.uk>
References: <1462187964-21876-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462187964-21876-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 02, 2016 at 01:19:24PM +0200, Stefan Roese wrote:

> +	if ((orion_spi->direct_access[cs].vaddr) && (xfer->tx_buf) &&
> +	    (word_len == 8)) {
> +		unsigned int cnt = count >> 2;
> +		unsigned int rem = count % 4;

For the benefit of readers please write divisions as divisions and let
the compiler figure out if they can be turned into shifts.

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXJ3XnAAoJECTWi3JdVIfQLlEH/36xsC9/UnyTTNPtQsdJve55
4dG4isYZNaSKyUYAdxaBaufEQ1EWH4kxOUUemPA04u1x0+1T50Z1FBn9yIwNHVO0
qqoQHTENZc+jBfnxYDyCuCzuUHADZyDRmw7vp1kxq+qS+pgm2FFD1SSbQcse/HQ2
L1CPNhgRY3yY8IfwCU0GvxhTdu3SM2uhrwRenXGmylQNAvVG1kdzAxAccdSZMgEY
NqzDpDp1sla0oKF3IdT4VHiMfxpOJxsKy58uHr9JVn0lbqoI9OF9Fgp+6mi8o6V4
kVRihdSYlS/jWEmknPCp5Ei9ULNYdOsyDK9A4Yk8I+J7ILnpqAEE1rHIs6+pf5U=
=6WGZ
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
