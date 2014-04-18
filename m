From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: core: Ignore unsupported Dual/Quad Transfer Mode
 bits
Date: Fri, 18 Apr 2014 18:26:07 +0100
Message-ID: <20140418172607.GP12304@sirena.org.uk>
References: <1397497193-28067-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jElBB+g0hITs+cx9"
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397497193-28067-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jElBB+g0hITs+cx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2014 at 07:39:53PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> The availability of SPI Dual or Quad Transfer Mode as indicated by the
> "spi-tx-bus-width" and "spi-rx-bus-width" properties in the device tree is
> a hardware property of the SPI master, SPI slave, and board wiring.  Hence
> the SPI core should not reject an SPI slave because an SPI master driver
> doesn't (yet) support Dual or Quad Transfer Mode.

Applied, thanks.

--jElBB+g0hITs+cx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUWAsAAoJELSic+t+oim9XqUP/i0hl9S5zGaLJTerphXINOYV
JpEUhjUSsAggcv0Ur5xmtTL3XimUaWES++qZV4BFZ3Gzh6mErKBCSEYcKZQSEwWm
IiGpl2ltk4gm8vm/ABquyY1ucG2I0j4EIocVAF20GKhG1t51+sjmN+CperW0Cyu8
3LBFwBaiX2kQ54ydHun1SyRHaFtK+f/o8nLrBOq7G13i/nxclRBlpNOE8st8PxGF
rMbF+QhjfD4jDiJXKhN7lOQulROL51dDUOawoHvIE0GbP2Q/Z2O2kNHK+XG6rIuA
doLvJ9EiyYeWc2HFX2y8VC1xDysMnXfP0ENsG/H1yRCyk0G0fne+mb9nD+znsI9u
MvyjbI2ZLxyru07VQojO+oIMT4Bj2qtI99scN2Hf6bMgoFrikWaxRGYzNj9B5eIw
Gebbcb85TuyzRDUVU1X0MLhJg7N1IeNxuVzkiqpoRGcW6NZqzYDZ2ybEzhJSbfrW
HMasr4mm9pk38GlAYy978eYpMw22aGlXnLZhMbrvSSh0goZlzDRDgoLg1IayLTDB
YtYoRXMdn8gR6BkEyPf4iCjEP2VkAR/1PqYHRRgvK/8znwRI6YXmji+ILXSEXNLR
wxLG4E6iUMciRSVzVFuguywe8e4oQzv4+bsvgkyEl6GuwWyPs50iGowJfJLlUha+
N1zOdHvgqCpex2YBh7Xh
=xlPO
-----END PGP SIGNATURE-----

--jElBB+g0hITs+cx9--
