From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: stm32-qspi: add spi_master_put in release
 function
Date: Mon, 25 Mar 2019 16:03:13 +0000
Message-ID: <20190325160313.GJ7284@sirena.org.uk>
References: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
 <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2019 at 03:35:53PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>=20
> This patch adds spi_master_put in release function
> to drop the controller's refcount.

I'm getting build errors with this:

  CC      drivers/spi/spi-stm32-qspi.o
drivers/spi/spi-stm32-qspi.c: In function =E2=80=98stm32_qspi_probe=E2=80=
=99:
drivers/spi/spi-stm32-qspi.c:430:8: error: =E2=80=98struct stm32_qspi=E2=80=
=99 has no member named =E2=80=98phys_base=E2=80=99; did you mean =E2=80=98=
io_base=E2=80=99?
  qspi->phys_base =3D res->start;
        ^~~~~~~~~
        io_base

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY+8AACgkQJNaLcl1U
h9B0aQf/fdWpPjnowIBjcy1bnS1nYt1V/UZopHw918CDYM0j/ws6gqcZ6hliRlSB
2WhwMUaq4th49OQOitBHw/kDyQAS7gkfvHhg9LyEL0B5nkVnQDTN8pfnsRj7b/5N
fjG2AM6bMKjeiyUl97ObpJrDPvNUi6Gp/RwAXVlFLEXMKrN5vnnzaQYEfpctAFp5
JBMc6n9Qp2Ao5jAHb6Kw0yGqnrFvDDz/Rnp03ofXJJI4T+lvtwp+rUz2R3ZzyRlC
SHP68Lapg/Jk+AQ3EQexlyR3SpOezzpiDRH4iECxNH98nNX3WmUQJ5u8WjMTGU75
0eNyyzqbd0DM8wXYWOd0QSHCV0JCaA==
=T4u8
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--
