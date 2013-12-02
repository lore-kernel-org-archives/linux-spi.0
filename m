From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/11] spi: spi-sh-msiof: let it run even without GPIO
Date: Mon, 2 Dec 2013 12:53:20 +0000
Message-ID: <20131202125320.GD27568@sirena.org.uk>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-3-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DYCP9ZX4RRtQiwKl"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385921962-19843-3-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DYCP9ZX4RRtQiwKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 03:19:14AM +0900, takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:

> -	/* use spi->controller data for CS (same strategy as spi_gpio) */
> -	gpio_set_value((unsigned)spi->controller_data, value);
> +	/* use spi->controller data for CS (same strategy as spi_gpio),
> +	 * if any. otherwise let HW controll CS */
> +	if (spi->controller_data)
> +		gpio_set_value((unsigned)spi->controller_data, value);

This makes sense in terms of what it tries to do however the standard
thing is to set the GPIO value to an error value if it isn't there
(especially since 0 is in theory a valid GPIO) so the test should be
different.

I'd also suggest changing to use the core cs_gpio field but that's a
separate thing.

--DYCP9ZX4RRtQiwKl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIK9AAoJELSic+t+oim97LUP/2wxHJrMeaCTZ5a3Rp9qSr+g
59rH+xuCJDNIjfoaAnZSfStwhdn0u+J9CqFwByCb/H9fbGIgrzrSuAXyGcMPXvGQ
Z9m+f9dOgKM/FLDeI8HXDuYg1q9s5AXBLqJBj5BC9u8junNmjQMyDocdCEcu0KKX
b6KEfhREdfn6FH0++L/DbCN839MNKUBFFwvmPJhRffXxGz/tpxhPV34bg5aWspko
UQU+8tryqoX3ptYARrVeIsGx9ceuKqW+de/70FrqaI0hOXULc6kU6eOxoOLE0K+M
0aFaqsbcwdomlYWSgK2Ls4Vubf/hz/PLt/GlouZW6iOVl0Znf75KGrHH1KRo7Uqu
xSBwuEjfg0fZ7UUlPiTaiAFMBKOKpMvOoMUmvr/MHzgzGvJrGVZ+1X0aGPkMBsE1
TaMqqL5UYfMEETjAsJw/0LyggzAcgPdp42Fdpeg+hgy4iDMdqlBGF8Et8SjjoYsP
3GfOjw2iNMBUOkq5WJUTUvJAKgxhrUEizDJmi7Mt6higDl31REypfxYrqywSmST0
34YJjp++H2FhKJaL2WlKA4oFXBp8a5Y6Saa4eV13QmyiXSzuNhZlUWd0rl5QMKQW
p1hcQzTH+/iOoCFBcBOVtSu86Dy5TxD7axba5LXyFxqY6fWLJ0jzEOhGm+BTBFAN
4Fx2ALTtEKkWsenA6Kcg
=fhW5
-----END PGP SIGNATURE-----

--DYCP9ZX4RRtQiwKl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
