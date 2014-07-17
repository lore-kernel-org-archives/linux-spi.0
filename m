From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] spi: s3c64xx: use the generic SPI "cs-gpios" property
Date: Thu, 17 Jul 2014 19:48:04 +0100
Message-ID: <20140717184804.GC17528@sirena.org.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-3-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzhqTaE66jeIVBY0"
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olof@lixom.net>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405523950-2231-3-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BzhqTaE66jeIVBY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2014 at 05:19:08PM +0200, Javier Martinez Canillas wrote:
> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>=20
> The s3c64xx SPI driver uses a custom DT binding to specify
> the GPIO used to drive the chip select (CS) line instead of
> using the generic "cs-gpios" property already defined in:
> Documentation/devicetree/bindings/spi/spi-bus.txt.

Applied, thanks.

--BzhqTaE66jeIVBY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyBphAAoJELSic+t+oim9iTcP/1JJ6L9RBhNYQP3bLmlclPqk
lJtwJijQezzfk3sUsf5XTGpsX9NDFZGPC9rio7le8EdVycypBcMUae2NrPTsCCe4
OudcibXGVyqKhErxqF5onispuPjHq/pBdvrgbyNKCVCL1/YL08XGrXlEB+0Dh0jH
MR1I+DMFVCtNhul1vbG1mv7bykakmRH7JYlxprv3IUDKrGq4m+I5QLqpBunQr31v
QUBsVdZw+S5pV7Ru8oDOiT3p/nUQuDYw/kfat4TZPiE4I/WRjmD+nVgmaVe42wsW
0rl9rwV0RIjEkHR9T4srYdo2v8+pkf6q6cGdsrH5HbwZrcmQqb/2Clkc6uEF27cM
/3muxWt0xELuxWqbAKg+lUawwmt9N4Q+pxsB90VAmK5JLeu9x8f9+bQnrZZ82QS2
PZktoK/jnrFVxdVBFLM1sP7TYCkDTKctnPaRZ2mYHTQR1/+Qpp7eLMT27vb76oIJ
Xx31wvOBQO3L3mqdhiBRnoth9hf0KqRa2o+ELKJDR/LHdH0cLwRGzyt7ZiPif4K5
FmKpBnbHY0bq7neZpcRbplElNyz4bDGyz/DHlcpSFm5Fuoe6xVdEpx7qO++2TuoC
5gSZm7SvcgXdtDbvE2Y/watfZHc9yF3bYImkzFUZxA0IvsO1wSNQa2vP/6nxRthG
LTHCZg+ic82DN0v3ucDI
=FPBf
-----END PGP SIGNATURE-----

--BzhqTaE66jeIVBY0--
