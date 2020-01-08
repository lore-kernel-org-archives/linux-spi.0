From: Emmanuel Vadot <manu@bidouilliste.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i: H6: Add SPI controllers nodes
 and pinmuxes
Date: Wed, 8 Jan 2020 12:34:48 +0100
Message-ID: <20200108123448.26286186e74f899caaf5ad35@bidouilliste.com>
References: <20200108101006.150706-1-andre.przywara@arm.com>
 <20200108101006.150706-2-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-sunxi@googlegroups.com,
 Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20200108101006.150706-2-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


 Hi Andre,

On Wed,  8 Jan 2020 10:10:05 +0000
Andre Przywara <andre.przywara@arm.com> wrote:

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
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 54 ++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3329283e38ab..40835850893e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -338,6 +338,30 @@
>  				bias-pull-up;
>  			};
>  
> +			/omit-if-no-ref/

 That would prevent users to use an overlay and use those pins, is that
something that we want ? I'm not sure that the space saved by those are
useful.

 Cheers,

> +			spi0_pins: spi0-pins {
> +				pins = "PC0", "PC2", "PC3";
> +				function = "spi0";
> +			};
> +
> +			/omit-if-no-ref/
> +			spi0_cs_pin: spi0-cs-pin {
> +				pins = "PC5";
> +				function = "spi0";
> +			};
> +
> +			/omit-if-no-ref/
> +			spi1_pins: spi1-pins {
> +				pins = "PH4", "PH5", "PH6";
> +				function = "spi1";
> +			};
> +
> +			/omit-if-no-ref/
> +			spi1_cs_pin: spi1-cs-pin {
> +				pins = "PH3";
> +				function = "spi1";
> +			};
> +
>  			spdif_tx_pin: spdif-tx-pin {
>  				pins = "PH7";
>  				function = "spdif";
> @@ -504,6 +528,36 @@
>  			#size-cells = <0>;
>  		};
>  
> +		spi0: spi@5010000 {
> +			compatible = "allwinner,sun50i-h6-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x05010000 0x1000>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
> +			clock-names = "ahb", "mod";
> +			dmas = <&dma 22>, <&dma 22>;
> +			dma-names = "rx", "tx";
> +			resets = <&ccu RST_BUS_SPI0>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		spi1: spi@5011000 {
> +			compatible = "allwinner,sun50i-h6-spi",
> +				     "allwinner,sun8i-h3-spi";
> +			reg = <0x05011000 0x1000>;
> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
> +			clock-names = "ahb", "mod";
> +			dmas = <&dma 23>, <&dma 23>;
> +			dma-names = "rx", "tx";
> +			resets = <&ccu RST_BUS_SPI1>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
>  		emac: ethernet@5020000 {
>  			compatible = "allwinner,sun50i-h6-emac",
>  				     "allwinner,sun50i-a64-emac";
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
