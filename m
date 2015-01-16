From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3] spi: orion: Add multiple chip select support to
 spi-orion
Date: Fri, 16 Jan 2015 12:39:02 +0000
Message-ID: <20150116123902.GN3043@sirena.org.uk>
References: <1421377847-3198-1-git-send-email-ken.wilson@opengear.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tb77rFjxeKqknTuc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421377847-3198-1-git-send-email-ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Tb77rFjxeKqknTuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 01:10:47PM +1000, Ken Wilson wrote:
> This commit adds support for multiple hardware chip selects to spi-orion.
> Different SoCs support different number of chip selects (up to
> 8 on some platforms). The driver allows up to this number, and it is up
> to the implementer to only use the chip selects that are available.

Applied, thanks.

--Tb77rFjxeKqknTuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuQZlAAoJECTWi3JdVIfQybYH/2CLWtEiSU/it0DJVhBnzLly
QdPgZd0F+4Az+5chcy+A/XeKZvkWEDGSrwrVWUqBs2VTA6iY3BrHg4ActX5l5I8Z
3gy9xLx5M9/KJINsIVW0iMfiJLixWhzDrdwE/RYBcug4H0g1pOsTAWqcabnnPVnf
wb/9Q6wOt8gAgG0EfaWZCgcwlM7abrlMGnLaGq3Vd4fol4c7iwqfiiH2Y5UfvnNF
MvvJNdW9G90Y6HsXqfu0TNDbhV8FXnQR1f8wTO1glIm4mac9p7TMys58njYw3/3I
fVhN+9++KCtbbDmpy1n8VAjPezePA36nMepWnYCet6ObhoLWcZ3UGVewNUqOGRA=
=HqW0
-----END PGP SIGNATURE-----

--Tb77rFjxeKqknTuc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
