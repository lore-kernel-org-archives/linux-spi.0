From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ARM: sti: Provide DT nodes for SBC SSC[0..2]
Date: Wed, 21 Jan 2015 16:23:09 +0000
Message-ID: <20150121162309.GH22024@x1>
References: <1417534844-25080-1-git-send-email-lee.jones@linaro.org>
 <1417534844-25080-5-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	maxime.coquelin-qxv4g6HH51o@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417534844-25080-5-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Maxime,

Can you ping these up please?

> The Synchronous Serial Controller is used to provide SPI.
>=20
> These are the ports which are located on the Stand-By Controller (SBC=
).
>=20
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arm/boot/dts/stih407.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih4=
07.dtsi
> index 90bc090..80e2407 100644
> --- a/arch/arm/boot/dts/stih407.dtsi
> +++ b/arch/arm/boot/dts/stih407.dtsi
> @@ -329,5 +329,36 @@
> =20
>  			status =3D "disabled";
>  		};
> +
> +		/* SBC SSC */
> +		spi@9540000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9540000 0x110>;
> +			interrupts =3D <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_sysin>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9541000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9541000 0x110>;
> +			interrupts =3D <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_sysin>;
> +			clock-names =3D "ssc";
> +
> +			status =3D "disabled";
> +		};
> +
> +		spi@9542000 {
> +			compatible =3D "st,comms-ssc4-spi";
> +			reg =3D <0x9542000 0x110>;
> +			interrupts =3D <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk_sysin>;
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
