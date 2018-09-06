From: Jagdish Gediya <jagdish.gediya@nxp.com>
Subject: RE: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Date: Thu, 6 Sep 2018 07:08:16 +0000
Message-ID: <AM0PR04MB4052840603E71673747DFA7B90010@AM0PR04MB4052.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
 <20180904144627.1de264b6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904144627.1de264b6@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

Currently FlexSPI controller is present in ARM SoC but NXP is coming with P=
owerPC SoC with same FlexSPI controller.

We are trying to use same binding as defined in this patch-set(tested on AR=
M64 processors) for PowerPC.
Unfortunately, It is showing issue when driver tries to parse 'fspi_mmap'.

We did some investigation and figured out that for ARM device trees Periphe=
rals nodes inside 'soc' node have absolute addresses. For in general NXP's =
PowerPC device trees, Peripheral nodes have the relative addresses to the u=
nit-address of the parent 'soc' node. =20

This creates issue for PowerPC if we follow implementation in this patch-se=
t.=20

Example of device tree used for upcoming PowerPC SoC with FlexSPI controlle=
r.

soc@f8000000 {
	ranges =3D <0x0 0x0 0xf8000000 0x4000000>;
	.
	fspi0: flexspi@20c0000 {
		compatible =3D "nxp,XXX-fspi";
		reg =3D <0x20c0000 0x10000>, <0xC0000000 0x10000000>;
		reg-names =3D "fspi_base", "fspi_mmap";
		.
		.
	}
 }=20

As we can see, Final address of 'fspi_base' (0xf8000000 + 0x20c0000) falls =
into the parent 'soc' range(CCSR) but=20
for 'fspi_mmap', It is outside of 'soc' range(CCSR). It creates issue when =
driver tries to parse 'fspi_mmap'.

As per definition of ranges, this field can't be used to solve this problem=
.=20
Please suggest how to implement the "fspi_mmap"(memory mapping address and =
length) in case of PowerPC.

Thanks,
Jagdish

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Boris Brezillon
> Sent: Tuesday, September 4, 2018 6:16 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexS=
PI
> driver
>=20
> On Mon, 3 Sep 2018 09:54:08 +0000
> Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:
>=20
> > Dear Yogesh,
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Yogesh Gaur
> > > Sent: Friday, August 31, 2018 4:00 PM
> > > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org
> > > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org;
> > > linux- arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> > > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP
> > > FlexSPI driver
> > >
> > > Add binding file for NXP FlexSPI driver.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > ---
> > >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> > > ++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> > > fspi.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > new file mode 100644
> > > index 0000000..9f07116
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > > @@ -0,0 +1,42 @@
> > > +* NXP Flex Serial Peripheral Interface (FSPI)
> > > +
> > > +Required properties:
> > > +  - compatible : Should be "nxp,lx2160a-fspi"
> > > +  - reg :        First contains the register location and length,
> > > +                 Second contains the memory mapping address and
> > > +length
> >
> > Why are we overriding reg property.  Is there any special requirement.
> >
> > Can we use "reg" and "ranges" property in device tree.
> > Here "reg" represents controller registers and "ranges" represent the
> memory address of flash.
>=20
> No, ranges is not used for that. It's used when you need to convert from =
one
> address space to another, which is not what you're describing here. Check
> section 2.38 of this document [1] for more details.
>=20
> [1]https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fe
> linux.org%2Fimages%2Fc%2Fcf%2FPower_ePAPR_APPROVED_v1.1.pdf&amp;
> data=3D02%7C01%7Cjagdish.gediya%40nxp.com%7C5bdb57713bd4403a39e90
> 8d6126472a0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63671
> 6619958727753&amp;sdata=3DTB4mbWEm0opk58oPAVEOQFM0xeAFxCsqdzw
> 37BPuE3A%3D&amp;reserved=3D0
