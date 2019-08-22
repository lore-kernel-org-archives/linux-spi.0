From: Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Thu, 22 Aug 2019 20:05:07 +0100
Message-ID: <20190822190507.GI23391@sirena.co.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
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
In-Reply-To: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 02:18:43PM +0000, Ashish Kumar wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Snippet from driver spi-fsl-qspi.c
> static const struct of_device_id fsl_qspi_dt_ids[] = {
>         { .compatible = "fsl,vf610-qspi", .data = &vybrid_data, },
>         { .compatible = "fsl,imx6sx-qspi", .data = &imx6sx_data, },
>         { .compatible = "fsl,imx7d-qspi", .data = &imx7d_data, },
>         { .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>         { .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>         { .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>         { /* sentinel */ }
> };

> I had previously sent dts patch based out of Shawn's tree with
> dependency on these dt binding patch. To which Shawn had
> replied to get dependency patch accepted first before sending
> this dts change.

Right, there appears to be an entry for patch 1 which was added
without the binding doc being updated - patch 2 looks to not have
the compatibles in the driver though?

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1e52IACgkQJNaLcl1U
h9CabAf/YnrmOa6aer/v5GZLa3V7LnDmLiT3+f/Pw1XPzt4G1mUV+xM1rjIPcPBy
i2g6mH4lVLJYx/ERwlDb6jW+2GH+uG08pU8ekqm1lQqOhqGaWJGY+Q4zXRGNoWRd
OlCbXUx/ZLWJ0RjrHkoSO43s5mOXkX1rtef65k/b6tAgW1PIM4GEzrRNnSwFXQ+R
zxOhxAAesVweBvASCRd5tOll8I+9KFX9pHbByUwCxHbb1OqJHg5/sT1TCtCRr0fR
K+7/bB4MjfjCF14StKLKszFUWhRNnyT73S13gX8NlPQPSRAUtOOyvuNPX/UtkNJj
trVFOiTCRf5s01u6GQl2n+a1gOa/Ew==
=Scpe
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
