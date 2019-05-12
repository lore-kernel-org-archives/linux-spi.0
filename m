From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
Date: Sun, 12 May 2019 18:17:22 +0900
Message-ID: <20190512091722.GQ21483@sirena.org.uk>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-8-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
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
In-Reply-To: <1557249513-4903-8-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 09:16:19AM +0000, Robin Gong wrote:
> ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> i.mx8m/8mm still need this errata. Please refer to nxp official
> errata document from https://www.nxp.com/ .

Acked-by: Mark Brown <broonie@kernel.org>

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX5KIACgkQJNaLcl1U
h9C8+gf+KmYRm2L5VEF3eL4ork1xvAFHJtXfOjV/B1DR0Gie2THR7U8Jq6RYoxM3
WiNuy0sL5QpNc6jpXplVGB0Zy2YS7FE5FEmNfcqk6WIqnN6oASqi6nUpe4J20w/2
SH0NVyn4dI3aQwMPtYVm283OZYYnTjK8TXvqUQ5pdONcY1ApcuBfqhw3A3yIySoW
CNafHUttb19MMiZg4A7OoGrNf8J1Xu8GNEESpYyKc7tFXb3pKnNx18mRPw4R8VLP
lKd5jBdm3TmuZskVn45y9hEr+R2T96Vr5v/SHpTaNmMzDhStNOFLuKHes888Pz/C
jyuAQnZRpNhrLu0wDPl/cIXRmGh4iw==
=ccm6
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
