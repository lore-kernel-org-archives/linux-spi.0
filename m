From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: convert mtk-quadspi binding doc for
 spi-mtk-nor
Date: Tue, 3 Mar 2020 16:47:06 -0600
Message-ID: <20200303224706.GA22867@bogus>
References: <20200228043636.559915-1-gch981213@gmail.com>
 <20200228043636.559915-4-gch981213@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200228043636.559915-4-gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 28, 2020 at 12:36:35PM +0800, Chuanhong Guo wrote:
> spi-mtk-nor is a driver to replace mtk-quadspi and they have almost
> the same device-tree bindings. Reuse this binding documentation and
> convert it for new driver:
> 
> 1. "Mediatek SoCs" -> "Mediatek ARM SoCs" because MTK MIPS SoCs
>    use different controllers.
> 2. document "interrupts" as a required property because it's
>    available on all SoCs with this controller and new driver takes
>    advantages of it. It's implemented as optional only to maintain
>    backward compatibility.
> 3. replace binding example with a mt7629 one because this is the
>    only one I know the interrupt assignment.

That doesn't really matter. It would be less churn without that change 
and examples are just examples.

> 
> Signed-off-by: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Change since v1:
>  none
> 
>  .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   | 34 ++++++++-----------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> similarity index 62%
> rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> index a12e3b5c495d..829da480b9a9 100644
> --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
> @@ -1,4 +1,4 @@
> -* Serial NOR flash controller for MediaTek SoCs
> +* SPI NOR flash controller for MediaTek ARM SoCs
>  
>  Required properties:
>  - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
> @@ -13,6 +13,7 @@ Required properties:
>  		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
>  		  "mediatek,mt8173-nor"
>  - reg: 		  physical base address and length of the controller's register
> +- interrupts:	  Interrupt number used by the controller.
>  - clocks: 	  the phandle of the clocks needed by the nor controller
>  - clock-names: 	  the names of the clocks
>  		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
> @@ -22,29 +23,24 @@ Required properties:
>  - #address-cells: should be <1>
>  - #size-cells:	  should be <0>
>  
> -The SPI flash must be a child of the nor_flash node and must have a
> -compatible property. Also see jedec,spi-nor.txt.
> -
> -Required properties:
> -- compatible:	  May include a device-specific string consisting of the manufacturer
> -		  and name of the chip. Must also include "jedec,spi-nor" for any
> -		  SPI NOR flash that can be identified by the JEDEC READ ID opcode (0x9F).
> -- reg :		  Chip-Select number
> +There should be only one spi slave device following generic spi bindings.
> +It's not recommended to use this controller for devices other than SPI NOR
> +flash due to limited transfer capability of this controller.
>  
>  Example:
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/mt7629-clk.h>
>  
> -nor_flash: spi@1100d000 {
> -	compatible = "mediatek,mt8173-nor";
> -	reg = <0 0x1100d000 0 0xe0>;
> -	clocks = <&pericfg CLK_PERI_SPI>,
> -		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> +spi_nor: spi@11014000 {
> +	compatible = "mediatek,mt7629-nor",
> +		     "mediatek,mt8173-nor";
> +	reg = <0x11014000 0xe0>;
> +	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +	clocks = <&pericfg CLK_PERI_FLASH_PD>,
> +		 <&topckgen CLK_TOP_FLASH_SEL>;
>  	clock-names = "spi", "sf";
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -	};

Better to leave this in the example IMO.

Rob
