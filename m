From: Ashish Kumar <ashish.kumar@nxp.com>
Subject: RE: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add
 ls2080a compatibility string to bindings
Date: Wed, 21 Aug 2019 14:18:43 +0000
Message-ID: <VI1PR04MB401528B4F92DAD98385EF53395AA0@VI1PR04MB4015.eurprd04.prod.outlook.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
 <20190821110640.GC5128@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821110640.GC5128@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, August 21, 2019 4:37 PM
> To: Ashish Kumar <ashish.kumar@nxp.com>
> Cc: linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linux-next@vger.kernel.org; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: [EXT] Re: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add ls2=
080a
> compatibility string to bindings
>=20
> On Tue, Aug 13, 2019 at 03:53:09PM +0530, Ashish Kumar wrote:
>=20
> > There are 2 version of QSPI-IP, according to which controller
> > registers sets can be big endian or little endian.There are some other
> > minor changes like RX fifo depth etc.
> >
> > The big endian version uses driver compatible "fsl,ls1021a-qspi" and
> > little endian version uses driver compatible "fsl,ls2080a-qspi"
>=20
> I'm not seeing the corresponding code changes anywhere?  I'd at least
> expect to see the compatibles added, and it sounds like some actual code
> updates are needed.
Hi Mark,

Snippet from driver spi-fsl-qspi.c
static const struct of_device_id fsl_qspi_dt_ids[] =3D {
        { .compatible =3D "fsl,vf610-qspi", .data =3D &vybrid_data, },
        { .compatible =3D "fsl,imx6sx-qspi", .data =3D &imx6sx_data, },
        { .compatible =3D "fsl,imx7d-qspi", .data =3D &imx7d_data, },
        { .compatible =3D "fsl,imx6ul-qspi", .data =3D &imx6ul_data, },
        { .compatible =3D "fsl,ls1021a-qspi", .data =3D &ls1021a_data, },
        { .compatible =3D "fsl,ls2080a-qspi", .data =3D &ls2080a_data, },
        { /* sentinel */ }
};
I had previously sent dts patch based out of Shawn's tree with dependency o=
n these dt binding patch. To which Shawn had replied to get dependency patc=
h accepted first before sending this dts change.
Reference conversion can be viewed here [1],[2].

This compatible can be seen here: file arch/arm64/boot/dts/freescale/fsl-ls=
208xa.dtsi

Snippet from previous dts patch based on Shawn tree, I will send next versi=
on on this patch after dt-bindings are updated
arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index d7e78dcd153d..8e5ba513b24f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -606,7 +606,7 @@
=20
 		qspi: spi@20c0000 {
 			status =3D "disabled";
-			compatible =3D "fsl,ls2080a-qspi", "fsl,ls1021a-qspi";
+			compatible =3D "fsl,ls2080a-qspi";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0x0 0x20c0000 0x0 0x10000>,
>=20
> Please use subject lines matching the style for the subsystem.  This make=
s it
> easier for people to identify relevant patches.
Could you please guide more, or point to documentation to follow sub-system=
 style.
dt-bindings: spi: spi-fsl-qspi: Add ls2080a-qspi compatibility string to bi=
ndings=20
Is this a better now? if yes, I will send next version

[1]: https://www.spinics.net/lists/arm-kernel/msg727403.html
[2]: https://patchwork.kernel.org/patch/10192103/

Regards
Ashish
