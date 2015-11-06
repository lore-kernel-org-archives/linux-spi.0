From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 3/7] spi: tegra: remove redundant "depends on
 RESET_CONTROLLER"
Date: Fri, 6 Nov 2015 10:22:37 +0000
Message-ID: <20151106102237.GX18409@sirena.org.uk>
References: <1446722128-11961-1-git-send-email-yamada.masahiro@socionext.com>
 <1446722128-11961-4-git-send-email-yamada.masahiro@socionext.com>
 <20151105115030.GB18409@sirena.org.uk>
 <CAK7LNAR6Mx4+E-8W5weSN2MyAgkMy6MFMxRQEDvrDftCW92ixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAR6Mx4+E-8W5weSN2MyAgkMy6MFMxRQEDvrDftCW92ixw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 03:02:57PM +0900, Masahiro Yamada wrote:
> 2015-11-05 20:50 GMT+09:00 Mark Brown <broonie@kernel.org>:
> > On Thu, Nov 05, 2015 at 08:15:24PM +0900, Masahiro Yamada wrote:
> >> ARCH_TEGRA selects RESET_CONTROLLER.
> >> The dependency "depends on RESET_CONTROLLER" is already met.

> >>       tristate "NVIDIA Tegra114 SPI Controller"
> >>       depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> >> -     depends on RESET_CONTROLLER && HAS_DMA
> >> +     depends on HAS_DMA

> > Again, this driver doesn't depend on ARCH_TEGRA.

> How come?

> Sorry, I have not been tracking this sub-system,
> so I do not get the "Again".

It's the same issue as your previous patch - there's an || COMPILE_TEST
in there.

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPH9sAAoJECTWi3JdVIfQnogH/A0PKsHEPvf1ISM9tCP0IVrK
7IoFMNKmEoQxCqFeesoBhPTLFKcpov4qkqNKn5uBykq5bO/AjlbCiVF4VJ+5jMz1
xyrqHp3KhwOwFs6HO0QngDuZRq0SCVL5HXvAYqkHBgZ8W6Cx0LDHE9SR5ZVC/gcP
qYBH4dp6RsIxBZu9/GpMibRFZCfT2dIFVYcbBO7sl8Gr3UqpCsSUkl6kbHi5Gyxd
il0I1npTTnOXn7Ow+DiN4UDzqblQBQ2VpuuvYHn2dIiEOiukXUz5xjiegnJ0sYf3
Kmv65MKGMjOt+d6ki8holWhAHiyG19wtVDdKZk2M1raXGsGhDVB5Kj3rqBH4fQ0=
=VFyR
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--
