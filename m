From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Tue, 27 Aug 2019 20:56:06 +0100
Message-ID: <20190827195606.GA28879@sirena.org.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822184927.GH23391@sirena.co.uk>
 <20190827155005.GA18581@bogus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190827155005.GA18581@bogus>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 10:50:05AM -0500, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 07:49:27PM +0100, Mark Brown wrote:

> > Drop the dt-bindings:.

> If you do 'git log --oneline Documentation/devicetree/bindings/' you'll=
=20
> notice that SPI and ASoC are the oddballs now. I don't really care
> except it does add to tribal knowledge needed regarding maintainers'=20
> requirements.

Well, you have been pushing people to change over to using
dt-bindings: so I guess you do care :(  It really does cause me
to miss stuff, especially where people don't even include the
subsystem name in the header.  I get quite a lot of CCs for
things where I once reviewed a patch for a subsystem that made
use of some subsystem I do maintain or where one patch in a
series (perhaps even an already applied one) was relevant at some
point so I'm doing quite a bit of triage that's purely based on
the subject lines.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1litUACgkQJNaLcl1U
h9CT3Qf/blNHGchHmk2gQ8FvcJr6UsKNmtbrNv1Zov3/pMDT0H/NiFlJzdL4A6lh
F/4aSXaqEoR8Ns/IBrQ+geoVVr8dzb0P44QVSOPBlP2PlnMH1lKtLjtGoVYMwd9s
WtByb4e5KTeuOGUWdVC7+//RwjZyx5dMiV5qTv7f6yEZb+bq208Lrm30mluybDiF
8xj3c1HFSN4S+U0qvDcgsTjPOP0sOSP/DxXQUpKBPjf04446WOB7D8f7z8E+avI3
y22TeatnvVC9KDuGM136rHNNpWnO7X7wB2HQKs12JwOjQJCcNNx8/WbGaQFgZ1Zp
fdK3xIKw8dtN4DMr9QAh2R8lLLOunw==
=8aqH
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
