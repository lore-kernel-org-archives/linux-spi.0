From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] ARM: vf610: add second DSPI instance
Date: Thu, 26 Feb 2015 16:02:20 +0800
Message-ID: <20150226080217.GG20028@dragon>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-2-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422356244-15629-2-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 27, 2015 at 04:27:18PM +0530, Bhuvanchandra DV wrote:
> Acked-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

> ---
>  arch/arm/boot/dts/vf500.dtsi |  4 ++++
>  arch/arm/boot/dts/vfxxx.dtsi | 11 +++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
> index 1dbf8d2..f5f807c 100644
> --- a/arch/arm/boot/dts/vf500.dtsi
> +++ b/arch/arm/boot/dts/vf500.dtsi
> @@ -66,6 +66,10 @@
>  	interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
>  };
>  
> +&dspi1 {
> +	interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &edma0 {
>  	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>  			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index a29c7ce..789744b 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -139,6 +139,17 @@
>  				status = "disabled";
>  			};
>  
> +			dspi1: dspi1@4002d000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,vf610-dspi";
> +				reg = <0x4002d000 0x1000>;
> +				clocks = <&clks VF610_CLK_DSPI1>;
> +				clock-names = "dspi";
> +				spi-num-chipselects = <5>;
> +				status = "disabled";
> +			};
> +
>  			sai2: sai@40031000 {
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
> -- 
> 2.2.2
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
