From: Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: RE: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date: Wed, 12 Dec 2018 08:15:40 +0000
Message-ID: <HE1PR0402MB332315D53C681D842865B6B5F1A70@HE1PR0402MB3323.eurprd04.prod.outlook.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542366701-16065-4-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: devicetree-owner@vger.kernel.org [mailto:devicetree-
> owner@vger.kernel.org] On Behalf Of Yogesh Narayan Gaur
> Sent: Friday, November 16, 2018 4:44 PM
> To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> marek.vasut@gmail.com; broonie@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@kontron.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH v5 3/5] arm64: dts: lx2160a: add FlexSPI node property
>=20
> Add fspi node property for LX2160A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected slave dev=
ice for
> the LX2160ARDB target.
> This is having two SPI-NOR flash device, mt35xu512aba, connected at CS0 a=
nd
> CS1.
>=20
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v5:
> - None
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - None.
> Changes for v2:
> - - Incorporated Shawn review comments.
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22
> ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 13 +++++++++++++
>  2 files changed, 35 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 1483071..3b20c97 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -35,6 +35,28 @@
>  	status =3D "okay";
>  };
>=20
> +&fspi {
> +	status =3D "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency =3D <20000000>;

The SPI flash supports 50MHz frequency. Please update to 50Mhz

> +		reg =3D <0>;
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency =3D <20000000>;
> +		reg =3D <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status =3D "okay";
>  	i2c-mux@77 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index c758268..5d0025a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -698,5 +698,18 @@
>  			interrupts =3D <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>  			timeout-sec =3D <30>;
>  		};
> +
> +		fspi: spi@20c0000 {
> +			compatible =3D "nxp,lx2160a-fspi";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;
> +			reg-names =3D "fspi_base", "fspi_mmap";
> +			interrupts =3D <0 25 0x4>; /* Level high type */
> +			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names =3D "fspi_en", "fspi";
> +			status =3D "disabled";
> +		};
>  	};
>  };
> --
> 2.7.4
