From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC 2/6] spi: core: Add support for registering SPI slave
 controllers
Date: Mon, 18 Jul 2016 18:02:33 +0100
Message-ID: <20160718170233.GU30372@sirena.org.uk>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
 <1466602929-4191-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uUozbLrG2OP+gMtx"
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466602929-4191-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uUozbLrG2OP+gMtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 03:42:05PM +0200, Geert Uytterhoeven wrote:
> Add support for registering SPI slave controllers using the existing SPI
> master framework:
>   - SPI slave controllers must set the SPI_MASTER_IS_SLAVE flag in
>     spi_master.flags,
>   - The "cs-gpios" property is ignored,
>   - The bus is described in DT as having a single slave node, "reg" and
>     "spi-max-frequency" properties are ignored.
>=20
> From the point of view of an SPI slave protocol handler, an SPI slave
> controller looks exactly like an ordinary SPI master controller.

I think this needs a *bit* more fleshing out around cancellation of
transfers, the inability to remove any of the modules due to them being
blocked in SPI calls.  Probably just an API call that allows us to
inject a timeout/cancellation but I think it does need to be there and
used before we start getting bad practice propagating around.

I'm also wondering about supporting varible length transfers but that's
going to be rather controller specific I fear and I'm not sure there's
much demand.

Otherwise the basic idea looks OK.

--uUozbLrG2OP+gMtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjQuoAAoJECTWi3JdVIfQyBUIAIY3+xCkGmBQI4DeFSF3pEng
h3h5G8oSxRlKd/NxWlpVsFq7ZB92U5pimpKLTHoRVgvAj2a0SZcGmcryqYPfgpDT
tgoECSRAL1aZJ4Jk5wTxSJMBug8sQZiLWQsg4r02GVyKEkCc93B4QrqB9xN7ceCq
z5z5xTmDSIjqwt4N8OwNkFRfW4E20cvtUHjk9K7jPq90NJHqB3//gSdbSVpZ87Nz
W+dqAos5mf+uF2ebi8TzOu6hoCePAEAgrcBRR5SF4vtgmTEAnvkDlgLbuO7B8GmB
EK4ZzZnDif9u949TsjT6TSFA9a4j7f1DUSkl0Wz8r62O23FG0+m7sHELQf2Cw7Q=
=tfa9
-----END PGP SIGNATURE-----

--uUozbLrG2OP+gMtx--
