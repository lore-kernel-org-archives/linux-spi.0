From: Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Wed, 28 Aug 2019 06:20:33 +0000
Message-ID: <VI1PR04MB401588B866A00A4507CC8C5795A30@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
 <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
 <20190827180320.GE23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827180320.GE23391@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, August 27, 2019 11:33 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: shawnguo@kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-next@vger.kernel.org; Kuldeep Singh
> <kuldeep.singh@nxp.com>
> Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> On Mon, Aug 26, 2019 at 06:19:53AM +0000, Ashish Kumar wrote:
>=20
> > For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-
> ls1088a.dtsi (please see below), since both ls1088 and ls2080 has same QS=
PI
> controller.
> > So I had introduced new compatible
> > +                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
> > +                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"
>=20
> Even if the compatible is supposed to be used in conjunction with other
> fallbacks it should still explicitly be there in case someone forgets or =
decides
> not to do that for some reason.
Thanks Mark, I will update the spi-fsl-qspi.c to include ls1088, ls1012 in =
driver data.

Regards
Ashish=20
