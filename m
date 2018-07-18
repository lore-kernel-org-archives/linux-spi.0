From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] spi: dw: allow providing own set_cs callback
Date: Wed, 18 Jul 2018 13:24:21 +0100
Message-ID: <20180718122421.GK5700@sirena.org.uk>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-3-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Cc: James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717142314.32337-3-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2018 at 04:23:11PM +0200, Alexandre Belloni wrote:
> Allow platform specific drivers to provide their own set_cs callback when
> the IP integration requires it.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-dw-set-cs

for you to fetch changes up to 62dbbae483b6452e688b8e26c4d024d484117697:

  spi: dw: allow providing own set_cs callback (2018-07-18 13:22:37 +0100)

----------------------------------------------------------------
spi: dw: Allow custom set_cs_callback

Allow platform specific drivers to provide their own set_cs callback when
the IP integration requires it.

----------------------------------------------------------------
Alexandre Belloni (1):
      spi: dw: allow providing own set_cs callback

 drivers/spi/spi-dw.c | 3 +++
 drivers/spi/spi-dw.h | 1 +
 2 files changed, 4 insertions(+)

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPMXUACgkQJNaLcl1U
h9BWsgf9FOP0W6xbxEz+Z9Vym3Fbf6vuznYgCsxHhqV79EP6lRLrdJOllZTSXOSy
dkYUwpR0MlLDukWBvPPwmDM2m/BR6rHfzMWXqyWh4+wj6CD9KZlm7hMqauANfSoC
6zV2IdBSVw3d0QHfiMRB2WuVBAnTlTFaPPik66NJo/VngEEvBrnsV3KjuECtdeKZ
KgHtmh0O/D674R8OdfKJ4BjpHAl2BCHJnyjr0fm1X/doqci62vM2Oq6WQWSA6Z2w
W9BgQzxMgFEiXNVAikwYAT2g/wos85wiqRFPMqUQDC0I0KTxZJjsL4yogxSiIEVZ
WUMcnYQ6Qzbwj83eD7krc7hVaCVYLw==
=I9ay
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
