From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 06/14] spi: imx: fix ERR009165
Date: Sun, 12 May 2019 18:16:18 +0900
Message-ID: <20190512091618.GP21483@sirena.org.uk>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h9WqFG8zn/Mwlkpe"
Cc: "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kern
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557249513-4903-7-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--h9WqFG8zn/Mwlkpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 09:16:13AM +0000, Robin Gong wrote:
> Change to XCH  mode even in dma mode, please refer to the below
> errata:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf

Acked-by: Mark Brown <broonie@kernel.org>

--h9WqFG8zn/Mwlkpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX5GIACgkQJNaLcl1U
h9Ax/Qf9F9Mm2dXsW6BETnXLb+haskxu5BW0ouwrc02+EmnMZCpk+eK2JWSx/BVA
hHEAVO5EpQ0txbRvSYWbDxfOheX1M6BYaA2ROjxHirVL+HT52VRa+dYja6OcK/LY
PDXYdW6hHB3YqCBFcV+/oXF94jjke9Rh+pnUIs5YEdRnd5MoZiYSCzvJKVcsDaHl
FAzP/LhX8HAupSbLbGojE7NKqKj2SuOeaKsD10zBEdo0eVFzCCsKwkNvmTlweDgy
VXujenPsoeAsM9VNu5En2yvrMtAN+7oe2mo5HZvOvdF4deOUS4HqR87fFEzT4Zad
IWZBFcTVrdqXuUinn5daxLAhu/5Rjg==
=9X9u
-----END PGP SIGNATURE-----

--h9WqFG8zn/Mwlkpe--
