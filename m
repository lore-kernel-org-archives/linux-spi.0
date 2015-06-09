From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
Date: Tue, 9 Jun 2015 14:15:55 +0200
Message-ID: <5576D8FB.2050906@atmel.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com> <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 09/06/2015 13:53, Cyrille Pitchen a =E9crit :
> - add new property "atmel,fifo-size"
> - change "cs-gpios" to optional for SPI controller version >=3D 2.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/spi/spi_atmel.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Do=
cumentation/devicetree/bindings/spi/spi_atmel.txt
> index 4f8184d..fb588b3 100644
> --- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
> +++ b/Documentation/devicetree/bindings/spi/spi_atmel.txt
> @@ -4,11 +4,16 @@ Required properties:
>  - compatible : should be "atmel,at91rm9200-spi".
>  - reg: Address and length of the register set for the device
>  - interrupts: Should contain spi interrupt
> -- cs-gpios: chipselects
> +- cs-gpios: chipselects (optional for SPI controller version >=3D 2 =
with the
> +  Chip Select Active After Transfer feature).
>  - clock-names: tuple listing input clock names.
>  	Required elements: "spi_clk"
>  - clocks: phandles to input clocks.
> =20
> +Optional properties:
> +- atmel,fifo-size: maximum number of data the RX and TX FIFOs can st=
ore for FIFO
> +  capable SPI controllers.
> +
>  Example:
> =20
>  spi1: spi@fffcc000 {
> @@ -20,6 +25,7 @@ spi1: spi@fffcc000 {
>  	clocks =3D <&spi1_clk>;
>  	clock-names =3D "spi_clk";
>  	cs-gpios =3D <&pioB 3 0>;
> +	atmel,fifo-size =3D <32>;
>  	status =3D "okay";
> =20
>  	mmc-slot@0 {
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
