From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI
 controllers nodes and pinmuxes
Date: Wed, 8 Jan 2020 11:45:15 +0100
Message-ID: <CAJiuCccSWR4oMF5x67eUVMFL6YhRMJVo_r0VfCUVVRtAJ9uR2w@mail.gmail.com>
References: <20200108101006.150706-1-andre.przywara@arm.com> <20200108101006.150706-2-andre.przywara@arm.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-sunxi+bncBCELXIX7UICBBR7F23YAKGQELQKWT4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20200108101006.150706-2-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Andre,

On Wed, 8 Jan 2020 at 11:10, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org> wrote:
>
> The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
> but with the added capability of 3-wire and 4-wire operation modes.
> For now the driver does not support those, but the SPI registers are
> fully backwards-compatible, just adding bits and registers which were
> formerly reserved. So we can use the existing driver for the "normal" SPI
> modes, for instance to access the SPI NOR flash soldered on the PineH64
> board.
> We use an H6 specific compatible string in addition to the existing H3
> string, so when the driver later gains Quad SPI support, it should work
> automatically without any DT changes.
>
> Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
> connecting another SPI flash to the SPI1 header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3329283e38ab..40835850893e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -338,6 +338,30 @@
>                                 bias-pull-up;
>                         };
>
> +                       /omit-if-no-ref/
> +                       spi0_pins: spi0-pins {
> +                               pins = "PC0", "PC2", "PC3";
> +                               function = "spi0";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi0_cs_pin: spi0-cs-pin {
> +                               pins = "PC5";
> +                               function = "spi0";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_pins: spi1-pins {
> +                               pins = "PH4", "PH5", "PH6";
> +                               function = "spi1";
> +                       };
> +
> +                       /omit-if-no-ref/
> +                       spi1_cs_pin: spi1-cs-pin {
> +                               pins = "PH3";
> +                               function = "spi1";
> +                       };
> +
>                         spdif_tx_pin: spdif-tx-pin {
>                                 pins = "PH7";
>                                 function = "spdif";
> @@ -504,6 +528,36 @@
>                         #size-cells = <0>;
>                 };
>
> +               spi0: spi@5010000 {
> +                       compatible = "allwinner,sun50i-h6-spi",
> +                                    "allwinner,sun8i-h3-spi";

You need to document this compatible in the dt-bindings to avoid any warnings.

Regards,
Clement




> +                       reg = <0x05010000 0x1000>;
> +                       interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +                       clock-names = "ahb", "mod";
> +                       dmas = <&dma 22>, <&dma 22>;
> +                       dma-names = "rx", "tx";
> +                       resets = <&ccu RST_BUS_SPI0>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
> +               spi1: spi@5011000 {
> +                       compatible = "allwinner,sun50i-h6-spi",
> +                                    "allwinner,sun8i-h3-spi";
> +                       reg = <0x05011000 0x1000>;
> +                       interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +                       clock-names = "ahb", "mod";
> +                       dmas = <&dma 23>, <&dma 23>;
> +                       dma-names = "rx", "tx";
> +                       resets = <&ccu RST_BUS_SPI1>;
> +                       status = "disabled";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };
> +
>                 emac: ethernet@5020000 {
>                         compatible = "allwinner,sun50i-h6-emac",
>                                      "allwinner,sun50i-a64-emac";
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200108101006.150706-2-andre.przywara%40arm.com.
