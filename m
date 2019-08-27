From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Tue, 27 Aug 2019 19:03:20 +0100
Message-ID: <20190827180320.GE23391@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
 <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KC8n6y+EC4k2kdZR"
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Ashish Kumar <ashish.kumar@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KC8n6y+EC4k2kdZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 06:19:53AM +0000, Ashish Kumar wrote:

> For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-ls1088a.dtsi (please see below), since both ls1088 and ls2080 has same QSPI controller.
> So I had introduced new compatible
> +                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
> +                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"

Even if the compatible is supposed to be used in conjunction with
other fallbacks it should still explicitly be there in case
someone forgets or decides not to do that for some reason.

--KC8n6y+EC4k2kdZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lcGUACgkQJNaLcl1U
h9AO3wf+JCKT+OSIxSc0gdf/Uy1kGqqqZk0sJcNYIa8GbyIxvlUIyXI7fn0HYhs7
HeUX5hJxYc8xodd8CTzWXCdXFeXpV6weWYidbcvBDYLAQGEhnCQY7LoKFQdWBBse
GNwuCT4SMuAUXHutf6GZaTPv8SIXGrNaZqawtlrOg4TFzUmL74MjlCQvpMn5j15g
v9rmk4kF310PIxuIPFKHgU0gyJdJ7gcr7uYCfUJA1/EtEWHfVoOnyZ+IG0Di9rPC
sPa6VYx6Wv376zRTNMPBJEt0Sn87KEPnz7A0afRbmNhs5OxuK1kXXIhib5u6MvGj
neVEamNf4Dxb+u9KverWRMgfQFCSSw==
=mBNE
-----END PGP SIGNATURE-----

--KC8n6y+EC4k2kdZR--
