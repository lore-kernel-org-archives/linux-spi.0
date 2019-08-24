From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: ls1088a: Add the DSPI controller node
Date: Sat, 24 Aug 2019 20:36:48 +0200
Message-ID: <20190824183647.GC14936@X250>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
 <20190801083105.30102-2-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190801083105.30102-2-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 01, 2019 at 04:31:04PM +0800, Chuanhua Han wrote:
> This patch adds the DSPI controller node for ls1088a boards.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index dacd8cf..fe8f1bd 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -252,6 +252,19 @@
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		dspi: spi@2100000 {
> +			compatible = "fsl,ls1088a-dspi",
> +						"fsl,ls1021a-v1.0-dspi";

I fixed the indent to have two compatible strings aligned on same
column when applying.

Shawn

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2100000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-names = "dspi";
> +			clocks = <&clockgen 4 1>;
> +			spi-num-chipselects = <6>;
> +			status = "disabled";
> +		};
> +
>  		duart0: serial@21c0500 {
>  			compatible = "fsl,ns16550", "ns16550a";
>  			reg = <0x0 0x21c0500 0x0 0x100>;
> -- 
> 2.9.5
> 
