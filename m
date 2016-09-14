From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: imx: set spi_bus_clk for mx1, mx31 and mx35
Date: Wed, 14 Sep 2016 18:05:35 +0100
Message-ID: <20160914170535.GE27974@sirena.org.uk>
References: <20160901203840.GA7972@reykholt.kaiser.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160901203840.GA7972-i8im91xUMdo3MargkJlfT5YgPPQkE1Si@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2016 at 10:38:40PM +0200, Martin Kaiser wrote:
> Modify spi_imx_clkdiv_2() to return the resulting bus clock frequency
> when the selected clock divider is applied. Set spi_imx->spi_bus_clk to
> this frequency.
>=20
> If spi_bus_clk is unset, spi_imx_calculate_timeout() causes a
> division by 0.
>=20
> [   90.356106] Division by zero in kernel.
> [   90.362631] CPU: 0 PID: 130 Comm: spidev_test Not tainted 4.8.0-rc3-ne=
xt-20160825+ #105
> [   90.372461] Hardware name: Freescale i.MX25 (Device Tree Support)
> [   90.378708] Backtrace:

Please think hard before including backtraces in upstream reports, they
are large and contain almost no useful information relative to their
size so often obscure the relevant content in your message. If part of
the backtrace is usefully illustrative then it's usually better to pull
out the relevant sections.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2YNeAAoJECTWi3JdVIfQ3g0H/1z8V0ZoiJMcAeg65q0WOFGT
Dnt36YbeBp5fHd27+nlUC2NouO0OAbFnPWk/iNAqoKIfNP50aM8DzDhrlJrAXLHk
Qg1qojJJFtxut7NExyMzI/V+N7ocMQ58E3csCloQj8Hw2yF5ylClM8+3TG975vXi
jolnwlx1B2dhhOaGfgWnZlWnZTX/GdEfk89xntHK6MRtidWTG26JuoP8aAyeGpvd
SFt76JfS9lGo8NZR9Rfhfpv1lNedyNdJ20m6saGQB732EZ5G0hAwY27ATGXPKc5I
zlxsERXFPe3do3H652Ii2UQiyJdqTcCGNaUbDKEL57G+u7XvM2g9vhYznkWLkGQ=
=weeX
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
