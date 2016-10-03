From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v1 1/2] ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
Date: Mon, 03 Oct 2016 11:05:59 -0700
Message-ID: <48b237c5d8709a67112465ea147f4c0c@agner.ch>
References: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org
To: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 2016-10-03 05:50, Sanchayan Maity wrote:
> Enable DMA for DSPI on Vybrid.

Hm, we have that in 4.4 already, is that meant for 4.1?

> 
> Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/vf-colibri.dtsi | 4 ++++
>  arch/arm/boot/dts/vfxxx.dtsi      | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi
> b/arch/arm/boot/dts/vf-colibri.dtsi
> index b741709..21bfef9 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -108,6 +108,10 @@
>  	status = "okay";
>  };
>  
> +&edma1 {
> +	status = "okay";
> +};
> +
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 2c13ec6..eac4213 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -194,6 +194,9 @@
>  				clocks = <&clks VF610_CLK_DSPI0>;
>  				clock-names = "dspi";
>  				spi-num-chipselects = <6>;
> +				dmas = <&edma1 1 12>,
> +					<&edma1 1 13>;
> +				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
>  
> @@ -206,6 +209,9 @@
>  				clocks = <&clks VF610_CLK_DSPI1>;
>  				clock-names = "dspi";
>  				spi-num-chipselects = <4>;
> +				dmas = <&edma1 1 14>,
> +					<&edma1 1 15>;
> +				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
