From: Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Thu, 22 Aug 2019 06:39:18 +0000
Message-ID: <VI1PR04MB4015474B3086AE99354FE65395A50@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
To: Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org <devicetree-
> owner@vger.kernel.org> On Behalf Of Ashish Kumar
> Sent: Wednesday, August 21, 2019 7:49 PM
> To: Mark Brown <broonie@kernel.org>; shawnguo@kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> Caution: EXT Email
>=20
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, August 21, 2019 4:37 PM
> > To: Ashish Kumar <ashish.kumar@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com;
> > linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> > Subject: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
> > ls2080a compatibility string to bindings
> >
> > On Tue, Aug 13, 2019 at 03:53:09PM +0530, Ashish Kumar wrote:
> >
> > > There are 2 version of QSPI-IP, according to which controller
> > > registers sets can be big endian or little endian.There are some
> > > other minor changes like RX fifo depth etc.
> > >
> > > The big endian version uses driver compatible "fsl,ls1021a-qspi" and
> > > little endian version uses driver compatible "fsl,ls2080a-qspi"
> >
> > I'm not seeing the corresponding code changes anywhere?  I'd at least
> > expect to see the compatibles added, and it sounds like some actual
> > code updates are needed.
> Hi Mark,
>=20
> Snippet from driver spi-fsl-qspi.c
> static const struct of_device_id fsl_qspi_dt_ids[] =3D {
>         { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
>         { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
>         { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
>         { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
>         { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, },
>         { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, },
>         { /* sentinel */ }
> };
> I had previously sent dts patch based out of Shawn's tree with dependency
> on these dt binding patch. To which Shawn had replied to get dependency
> patch accepted first before sending this dts change.
> Reference conversion can be viewed here [1],[2].
>=20
> This compatible can be seen here: file arch/arm64/boot/dts/freescale/fsl-
> ls208xa.dtsi
>=20
> Snippet from previous dts patch based on Shawn tree, I will send next
> version on this patch after dt-bindings are updated
> arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-) diff --git
> a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index d7e78dcd153d..8e5ba513b24f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -606,7 +606,7 @@
>=20
>                 qspi: spi@20c0000 {
>                         status =3D "disabled";
> -                       compatible =3D "fsl,ls2080a-qspi", "fsl,ls1021a-q=
spi";
> +                       compatible =3D "fsl,ls2080a-qspi";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x20c0000 0x0 0x10000>,
> >
> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.
Hi Mark,

After looking at some patch in Documentation/devicetree/bindings/spi/
I think I should update subject line to
dt-bindings: spi: Add ls2080-qspi compatible string for FSL QSPI driver
or=20
doc: qspi: Add ls2080-qspi compatible to DT bindings for FSL QSPI driver

Please suggest, if you think these are good or still need change.
Regards
Ashish=20

> Could you please guide more, or point to documentation to follow sub-
> system style.
> dt-bindings: spi: spi-fsl-qspi: Add ls2080a-qspi compatibility string to =
bindings
> Is this a better now? if yes, I will send next version
>=20
> [1]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .spinics.net%2Flists%2Farm-
> kernel%2Fmsg727403.html&amp;data=3D02%7C01%7Cashish.kumar%40nxp.co
> m%7C5922d2067b004c8f8f2c08d72642800c%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C637019939369034444&amp;sdata=3DHsumTqK0SiaBjzmbK
> 9r5dfpNtWHiZ%2FcB9e%2Bwy7SW160%3D&amp;reserved=3D0
> [2]:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F10192103%2F&amp;data=3D02%7C01%7Cashish.k
> umar%40nxp.com%7C5922d2067b004c8f8f2c08d72642800c%7C686ea1d3bc2b
> 4c6fa92cd99c5c301635%7C0%7C0%7C637019939369034444&amp;sdata=3D2xRb
> YdJHTibb1BM0iNSJ00P69s2RKj9SLNFNUsneT8I%3D&amp;reserved=3D0
>=20
> Regards
> Ashish
