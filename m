From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date: Fri, 1 Feb 2019 05:05:49 +0000
Message-ID: <VI1PR04MB5726460C6F341F0DFEA8BA8899920@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20190201025405.GA19882@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Shawn Guo <shawnguo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201025405.GA19882@dragon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Friday, February 1, 2019 8:24 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; bbrezillon@kernel.org;
> marek.vasut@gmail.com; broonie@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; mark.rutland@arm.com; robh@kernel.org; linux-
> kernel@vger.kernel.org; frieder.schrempf@kontron.de;
> computersforpeace@gmail.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node propert=
y
>=20
> On Tue, Jan 15, 2019 at 12:00:26PM +0000, Yogesh Narayan Gaur wrote:
> > Add fspi node property for LX2160A SoC for FlexSPI driver.
> > Property added for the FlexSPI controller and for the connected slave
> > device for the LX2160ARDB target.
> > This is having two SPI-NOR flash device, mt35xu512aba, connected at
> > CS0 and CS1.
> >
> > Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> > Changes for v8:
> > - None
> > Changes for v7:
> > - None
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - Incorporated Rob review comments.
> > Changes for v3:
> > - None.
> > Changes for v2:
> > - Incorporated Shawn review comments.
> >
> >  .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > index 6481e5f20e69..70658946fbbe 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -50,6 +50,28 @@
> >  	status =3D "okay";
> >  };
> >
> > +&fspi {
> > +	status =3D "okay";
> > +
> > +	mt35xu512aba0: flash@0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "spansion,m25p80";
> > +		m25p,fast-read;
> > +		spi-max-frequency =3D <50000000>;
> > +		reg =3D <0>;
> > +	};
> > +
> > +	mt35xu512aba1: flash@1 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "spansion,m25p80";
> > +		m25p,fast-read;
> > +		spi-max-frequency =3D <50000000>;
> > +		reg =3D <1>;
> > +	};
> > +};
> > +
> >  &i2c0 {
> >  	status =3D "okay";
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index a79f5c1ea56d..e3ff86201f73 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -762,5 +762,18 @@
> >  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> >  			dma-coherent;
> >  		};
> > +
> > +		fspi: spi@20c0000 {
>=20
> To keep the nodes sorted in unit-address, it should go after i2c@2070000.
>=20
> > +			compatible =3D "nxp,lx2160a-fspi";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> > +				<0x0 0x20000000 0x0 0x10000000>;
>=20
> I would align the indentation with the above.
>=20
> > +			reg-names =3D "fspi_base", "fspi_mmap";
> > +			interrupts =3D <0 25 0x4>; /* Level high type */
>=20
> interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>; so that we can save the
> comment there.
>=20
> I fixed up all these small things and applied the patch.
>=20
Ok, Thanks.

--
Regards
Yogesh Gaur.

> Shawn
>=20
> > +			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> > +			clock-names =3D "fspi_en", "fspi";
> > +			status =3D "disabled";
> > +		};
> >  	};
> >  };
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
t
> > s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C
> >
> 01%7Cyogeshnarayan.gaur%40nxp.com%7C6308464db1a541247dfd08d687f09
> 124%7
> >
> C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636845864632818753&a
> mp;sda
> >
> ta=3DurGFUKDP6ZZZOTXS1ccfLceCV2OBV5%2BiZq9foCu7ZX8%3D&amp;reserved=3D
> 0
