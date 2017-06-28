From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/9] dt-bindings: spi: stm32: use SoC specific
 compatible
Date: Wed, 28 Jun 2017 19:51:52 +0100
Message-ID: <20170628185152.h5dngp4tgwztgtcu@sirena.org.uk>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-2-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="piicu2wmbwggwywf"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498578321-13980-2-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--piicu2wmbwggwywf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2017 at 05:45:13PM +0200, Amelie Delaunay wrote:
> This patch replaces st,stm32-spi compatible with st,stm32h7-spi SoC
> specific compatible and updates the example accondingly.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--piicu2wmbwggwywf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT+scACgkQJNaLcl1U
h9CTrAf/bdxlWqVhmNhJVT26ioQkdtlfB8vX8QLOS7elO/J8tp3AX9XCrA6FIk95
zzOTsvpCdQcp5vZUwFrDYHse4msXk9qoxlXh/8QJ0m708zD5W58ifgPdMYIG0Hds
uRbXbP+3PG9y47u6iJLxb7h1386g0VcG/Cz+pjmy3yMwadRjIbw+/I6Lq7huGbOx
zcM/ocycULNH90nesxlPvGOkqZ6a5wFu0J/E03zChcEv8XWXHEVLn3TmhnDcHqTW
YWswIcKLSroN7yl/Xs6kJ5PGEy0mMKM4yeciFpZJbhSy58woEq1PlUSP9DmKxDDR
OMP8jIIGyOKCvYCG2OnLLSysmDJmEA==
=9ojv
-----END PGP SIGNATURE-----

--piicu2wmbwggwywf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
