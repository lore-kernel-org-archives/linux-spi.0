From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/5] Documentation: atmel-quadspi: add binding file
 for Atmel QSPI driver
Date: Fri, 31 Jul 2015 10:08:53 +0200
Message-ID: <55BB2D15.2020408@atmel.com>
References: <cover.1437986785.git.cyrille.pitchen@atmel.com> <a5ece7085956e97f35ecd5ddb41abd28a7c402a8.1437986785.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <marex-ynQEQJNshbs@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a5ece7085956e97f35ecd5ddb41abd28a7c402a8.1437986785.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 27/07/2015 10:59, Cyrille Pitchen a =E9crit :
> This patch documents the DT bindings for the driver of the Atmel QSPI
> controller embedded inside sama5d2x SoCs.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Yes, it seems good:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++++=
++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quads=
pi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt =
b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> new file mode 100644
> index 000000000000..0b8d545bb198
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> @@ -0,0 +1,29 @@
> +* Atmel Quad Serial Peripheral Interface (QSPI)
> +
> +Required properties:
> +- compatible:     should be "atmel,sama5d2-qspi"
> +- reg:            the first contains the register location and lengt=
h,
> +                  the second contains the memory mapping address and=
 length
> +- interrupts:     should contain the interrupt for the device
> +- clocks:         the phandle of the clock needed by the QSPI contro=
ller
> +- #address-cells: should be <1>
> +- #size-cells:    should be <0>
> +
> +Example:
> +
> +spi@f0020000 {
> +	compatible =3D "atmel,sama5d2-qspi";
> +	reg =3D <0xf0020000 0x100>,
> +	      <0xd0000000 0x8000000>;
> +	interrupts =3D <52 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks =3D <&spi0_clk>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_spi0_default>;
> +	status =3D "okay";
> +
> +	m25p80@0 {
> +		...
> +	};
> +};
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
