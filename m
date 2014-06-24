From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] documentation: add rockchip spi documentation
Date: Tue, 24 Jun 2014 11:18:02 +0100
Message-ID: <20140624101802.GE5856@leverpostej>
References: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
 <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	"cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403582324-9485-2-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 24, 2014 at 04:58:43AM +0100, addy ke wrote:
> Signed-off-by: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-rockchip.txt       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> new file mode 100644
> index 0000000..ce9c881
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> @@ -0,0 +1,51 @@
> +* Rockchip SPI Controller
> +
> +The Rockchip SPI controller is used to interface with various devices such as flash
> +and display controllers using the SPI communication interface.
> +
> +Required SoC Specific Properties:
> +
> +- compatible: should be one of the following.
> +    - rockchip,rk3066-spi: for rk3066, rk3188 and rk3288 platforms.

Are you sure you don't want specifc strings for rk3188 and rk3288 (in
addtion to the common "rockchip,rk3066-spi")?

> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +              depends on the interrupt controller.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
> +			   the peripheral clock.
> +
> +Optional properties:
> +- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> +		Documentation/devicetree/bindings/dma/dma.txt
> +- dma-names: DMA request names should include "tx" and "rx" if present.
> +
> +Example:
> +
> +- SoC Specific Portion:
> +
> +	spi0: spi@ff110000 {
> +		compatible = "rockchip,rockchip-spi";

This does not match the description of the compatible property.

> +		reg = <0xff110000 0x1000>;
> +		dmas = <&pdma1 11>, <&pdma1 12>;
> +		dma-names = "tx", "rx";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

These weren't mentioned.

> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0 &spi0_cs1>;

pinctrl was not mentioned.

> +		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> +		clock-names = "spiclk", "apb_pclk";
> +		status = "disabled";

Any reason for the status?

> +	};
> +
> +- Board Specific Portion:
> +
> +	&spi0 {
> +		status = "okay";
> +		spi_test@00 {
> +			compatible = "rockchip,spi_test";

Huh?

Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
