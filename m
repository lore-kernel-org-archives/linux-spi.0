From: Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Mon, 26 Aug 2019 06:19:53 +0000
Message-ID: <DB7PR04MB4011C9785D8D9CDFE9BC62DD95A10@DB7PR04MB4011.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
 <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
 <20190822190507.GI23391@sirena.co.uk>
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
In-Reply-To: <20190822190507.GI23391@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, August 23, 2019 12:35 AM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: shawnguo@kernel.org; linux-kernel@vger.kernel.org; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-next@vger.kernel.org; Kuldeep Singh
> <kuldeep.singh@nxp.com>
> Subject: Re: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add=
 ls2080a
> compatibility string to bindings
>=20
> On Wed, Aug 21, 2019 at 02:18:43PM +0000, Ashish Kumar wrote:
>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>=20
> > Snippet from driver spi-fsl-qspi.c
> > static const struct of_device_id fsl_qspi_dt_ids[] =3D {
> >         { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
> >         { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
> >         { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
> >         { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
> >         { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, =
},
> >         { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, =
},
> >         { /* sentinel */ }
> > };
>=20
> > I had previously sent dts patch based out of Shawn's tree with
> > dependency on these dt binding patch. To which Shawn had replied to
> > get dependency patch accepted first before sending this dts change.
>=20
> Right, there appears to be an entry for patch 1 which was added without t=
he
> binding doc being updated - patch 2 looks to not have the compatibles in =
the
> driver though?
Hi Mark,

For Patch-2, I intended to use this in arm64/boot/dts/freescale/fsl-ls1088a=
.dtsi (please see below), since both ls1088 and ls2080 has same QSPI contro=
ller.
So I had introduced new compatible
+                "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
+                "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"

Now the dtsi will look like this:
               qspi: spi@20c0000 {
                        compatible =3D "fsl,ls2080a-qspi", "fsl,ls1088a-qsp=
i";
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        reg =3D <0x0 0x20c0000 0x0 0x10000>,
                              <0x0 0x20000000 0x0 0x10000000>;
                        reg-names =3D "QuadSPI", "QuadSPI-memory";
                        interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
                        clock-names =3D "qspi_en", "qspi";
                        clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
                        status =3D "disabled";
                };

If you think this is incorrect, then I can add this in driver
{ .compatible =3D "fsl,ls1088a-qspi", .data =3D &ls2080a_data, },

Regards
Ashish=20
