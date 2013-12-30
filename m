From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Eliminate 3WIRE spi_transfer check
Date: Mon, 30 Dec 2013 12:44:36 +0000
Message-ID: <20131230124436.GV31886@sirena.org.uk>
References: <1388123466-7525-1-git-send-email-tpiepho@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+FNB8hLr74QeaOK6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388123466-7525-1-git-send-email-tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--+FNB8hLr74QeaOK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 26, 2013 at 09:51:06PM -0800, Trent Piepho wrote:
> Checking for SPI_3WIRE isn't needed.  spi_setup() already prevents 3WIRE
> mode from being combined with DUAL or QUAD mode support.  So there is no
> need to differentiate between a single bit device with SPI_3WIRE set and
> one with without.  It doesn't change the allowed bit widths.

Applied, thanks.

--+FNB8hLr74QeaOK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwWqxAAoJELSic+t+oim9c2AP/iHVP29t/mtj9ELhOnzYdhQD
HlFFT4EUvyChSvaiLuZQ30OIPQdULKG6k3gUP//+QE0xt6Y4RlfXMM1wh5ib1Xvi
i658bFkqqVxJw+imjBf2JYIMjytfNVRnq6+OHyHnlz0TW5xXjcyhPZ70XXgh5smU
vuVijaWUDje+0DWJMEi5icZm536Ia3Zkg6uBJ/viE5U+n2jYOH4pJuPpo1r+lD1C
Gmw/Y5cRLlEps76MqCaTdaENIz+hWZQYdkkuAC19VcUwnSFePIWpEqKtyqWPw+GO
E6h0VD+z46oNW32SgEOYKj8wq5C8W3YNrE94X0Gi4q8Pr/rFh/D/5TrhyXz7Ji1D
yfQzYNEwX1DoLRy/5YuPS95bsCrSb+hccH3f6DEjFXUucaz6POhclvxFx/vWirQm
HZaYV4zOPq6bj+QkAJ5C8p5/AXHOd6tn4RhoyuNTtGxI5ExmQ3US6m0Vp9d9+LJ+
5vrInN/g3OHg8XxdyJUSiMONdYrT86Yicv3jp8ruWKZwrGRuSpYOS4BUzGsrNzgg
5R8G4FL70Zx8c+R2i4O4ieRtnjBYBTpZRE4++NeG9RAI9DPziU5IVOOb/hTgpVqJ
vzqMyltJclpsMb2MknSY7An+B+A0ZKW4CPILxchhTS6JA2wC4YQxhBCDkkA+J+eK
CbwGdJAMm7suC29LAwRR
=YoQ0
-----END PGP SIGNATURE-----

--+FNB8hLr74QeaOK6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
