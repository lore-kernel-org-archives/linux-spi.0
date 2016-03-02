From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: davinci: set new SPI_FC_* flags
Date: Wed, 2 Mar 2016 11:16:16 +0900
Message-ID: <20160302021616.GP18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
 <1456843400-20696-4-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TZpBVqDN88c+FZts"
Cc: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456843400-20696-4-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TZpBVqDN88c+FZts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2016 at 03:43:18PM +0100, Oleksij Rempel wrote:

> -		if (spi->mode & SPI_READY) {
> +		if (spi->mode & SPI_FC_READY) {

This isn't setting new flags, this is replacing old flags with new ones
which suggests that the patch renaming the flag needs to rename the flag
in all the drivers...

--TZpBVqDN88c+FZts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1kzvAAoJECTWi3JdVIfQF80IAIZikntMl+12ZgtVdyRtQLPj
uzetNmnsKcUvpUZOeVE8RUPDDmZVEeUQFa3HPrd/CXwcSulofH8gfwzcCu2kBy44
FRb3mEgOwa8QAWLm0MPAuCLZNjxfjffu8RCxH2+BpT6B/DZPw8OanLB/PveY24Dd
1OMlEFu1N+CGmVXi+J9HIRAbjEyVHsVr6hC62wZBFzoGobM+I9WoUJ7OYhuixeZl
C4DbKTJuFHdU6b1Az5k6Gbl4qixzkJJJqG1Y7g7okX177GMVnhYe0fbiYVBvsZG8
8MLHVEaa7UgAbCgyYWLNMeG+KBFWGseiDmsf060wgeZUraCQDYtPKsBquC4QCL0=
=CPpK
-----END PGP SIGNATURE-----

--TZpBVqDN88c+FZts--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
