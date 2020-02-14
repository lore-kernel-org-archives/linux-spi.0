From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 5/5] arm64: dts: enable fspi in imx8mm dts
Date: Fri, 14 Feb 2020 11:36:05 +0800
Message-ID: <20200214033605.GP22842@dragon>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-5-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200202125950.1825013-5-aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Feb 02, 2020 at 06:59:50AM -0600, Adam Ford wrote:
> Pull in upstream patch from NXP repo to:
> enable fspi in imx8mm DT file
> 
> Signed-off-by: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> V2: Reorder s-o-b lines to give credit in proper order.
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 1e5e11592f7b..679769fe6cab 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -558,7 +558,21 @@ aips3: bus@30800000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x30800000 0x30800000 0x400000>;
> +			ranges = <0x30800000 0x30800000 0x400000>,
> +				 <0x8000000 0x8000000 0x10000000>;
> +
> +			flexspi: spi@30bb0000 {

Keep the node sort in unit-address.

Shawn

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "nxp,imx8mm-fspi";
> +				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
> +				reg-names = "fspi_base", "fspi_mmap";
> +				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
> +					 <&clk IMX8MM_CLK_QSPI_ROOT>;
> +				clock-names = "fspi", "fspi_en";
> +				status = "disabled";
> +			};
>  
>  			ecspi1: spi@30820000 {
>  				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
> -- 
> 2.24.0
> 
