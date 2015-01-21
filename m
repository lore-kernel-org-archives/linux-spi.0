From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] ARM: sti: Provide DT nodes for SSC[0..4]
Date: Wed, 21 Jan 2015 16:22:43 +0000
Message-ID: <20150121162243.GG22024@x1>
References: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
 <1417534844-25080-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	maxime.coquelin-qxv4g6HH51o@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417534844-25080-4-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Maxime,

Can you ping these up please?

> The Synchronous Serial Controller is used to provide SPI.
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih407.dtsi | 54 ++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih4=
07.dtsi
> index 50637f5..90bc090 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -275,5 +275,59 @@
> =20
>  			status =3D "disabled";
>  		};
> +
> +		spi@9840000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9840000 0x110>;
> +			interrupts =3D <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names =3D "ssc";
> +			pinctrl-0 =3D <&pinctrl_spi0_default>;
> +			pinctrl-names =3D "default";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9841000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9841000 0x110>;
> +			interrupts =3D <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9842000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9842000 0x110>;
> +			interrupts =3D <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9843000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9843000 0x110>;
> +			interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9844000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9844000 0x110>;
> +			interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
>  	};
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
