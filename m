From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spidev: introduce
 SPI_IOC_WR_DEFAULT_MAX_SPEED_HZ command
Date: Sun, 14 May 2017 18:27:16 +0900
Message-ID: <20170514092716.kqx634djffgj32r6@sirena.org.uk>
References: <20170509122401.2561-1-kirkseraph@gmail.com>
 <20170509122401.2561-2-kirkseraph@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rih5johw3t72ljkg"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seraphime Kirkovski <kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170509122401.2561-2-kirkseraph-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rih5johw3t72ljkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 02:24:00PM +0200, Seraphime Kirkovski wrote:

> I think, this change is necessary, on the one hand, because there are sti=
ll
> a lot of longterm[2] supported kernels out there, whose users may be rely=
ing on
> SPI_IOC_WR_MAX_SPEED being system-wide and, on the other hand, this
> same command has been exhibiting a different behaviour for 3 years now,
> so its users may break, if 9169051617df7 is reverted in one way or
> another.

Do we have any evidence that such users exist? =20

--rih5johw3t72ljkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYIvMACgkQJNaLcl1U
h9Ckiwf/TA23WcQuwJL+hDApL1sNiGCaLqNdBsq3VRUxssKbCXOfCy+EoR6b7DF7
J8PK3BCUowBIAomsRw02kxdmZ2d7WN2/ylhMgZpzNzeYd9ddh4TSVQg24FadcKvF
BHFmu1E8xsFuWW0AshEO7saxfvXcSkOtSAlPhCSR+ijbErOhGQWdVLzMgM07mZPN
MgcRuBg2tBp8wdYpsQduazve1oQTAhmj59yRqBpZI55Voyyzp6JwWiI2e9B94NVi
WDyJhuSkwltto0uPlDCEr//Fkk3Qicv07hpP7oYBnONJmTL9Ao/BLPOcXI6nAPyj
R/uBhOl6UIbkez/KQT3465sAJYou4A==
=Qig6
-----END PGP SIGNATURE-----

--rih5johw3t72ljkg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
