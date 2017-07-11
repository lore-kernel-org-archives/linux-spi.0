From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH linux-next v4 4/4] spi: imx: Add support for SPI Slave
 mode
Date: Tue, 11 Jul 2017 15:42:46 +0100
Message-ID: <20170711144246.v7xlik7ab7l462b7@sirena.org.uk>
References: <20170608051603.16070-1-jiada_wang@mentor.com>
 <20170608051603.16070-5-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i76luiayfnbdi3qf"
Cc: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Jiada Wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608051603.16070-5-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--i76luiayfnbdi3qf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2017 at 02:16:03PM +0900, Jiada Wang wrote:
> Previously i.MX SPI controller only works in Master mode.
> This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
> controller to work also in Slave mode.

This doesn't apply against current code, please check and resend.

--i76luiayfnbdi3qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllk4+UACgkQJNaLcl1U
h9BGLgf8CvfL57N6avYCahIgdGurgm1n75HeloIviSenPEZJmeBtRDte9TGg/yEM
MgbW6uB/ssNJofughJPv+20TVHZTN+0ycJyxMPt+q8eevQ6ujpy3TdKakV8dGWQa
s5uiSsoan41cQtN0IkGqCRkq1yFrh2lwJp4rLvw122o3UVpBPHEZZaW0bt0AQHrT
69DC8GLj/FLvvmfzxCWFfTmySHhy7MLqv3D47dMMzK/j60rGW1fFFrV5rHIuXl/E
/ttgZGM1HKa0/gXSwiwCSjMq8BAKqgF/lWCqtUOdYPQ8GpUkEpkbes8KsFh+TwwH
whlpQ7dqjm+KZ4qBg79YlcGj8B6jSw==
=UDgU
-----END PGP SIGNATURE-----

--i76luiayfnbdi3qf--
