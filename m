From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: sun6i: dt: Add PLL6 and SPI module clocks
Date: Thu, 16 Jan 2014 12:15:28 -0600
Message-ID: <20140116181528.GY8153@joshc.qualcomm.com>
References: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
 <1389892285-11745-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389892285-11745-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 16, 2014 at 06:11:23PM +0100, Maxime Ripard wrote:
> The module clocks in the A31 are still compatible with the A10 one. Add the SPI
> module clocks and the PLL6 in the device tree to allow their use by the SPI
> controllers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 48 +++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 5256ad9..ae058eb 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -73,16 +73,12 @@
>  			clocks = <&osc24M>;
>  		};
>  
> -		/*
> -		 * This is a dummy clock, to be used as placeholder on
> -		 * other mux clocks when a specific parent clock is not
> -		 * yet implemented. It should be dropped when the driver
> -		 * is complete.
> -		 */
> -		pll6: pll6 {
> -			#clock-cells = <0>;
> -			compatible = "fixed-clock";
> -			clock-frequency = <0>;
> +		pll6: clk@01c20028 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun6i-a31-pll6-clk";
> +			reg = <0x01c20028 0x4>;
> +			clocks = <&osc24M>;
> +			clock-output-names = "pll6";
>  		};
>  
>  		cpu: cpu@01c20050 {
> @@ -182,6 +178,38 @@
>  					"apb2_uart1", "apb2_uart2", "apb2_uart3",
>  					"apb2_uart4", "apb2_uart5";
>  		};
> +
> +		spi0_clk: clk@01c200a0 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-mod0-clk";
> +			reg = <0x01c200a0 0x4>;
> +			clocks = <&osc24M>, <&pll6>;

This looks weird.  You've set the pll6 #clock-cells = <1>, but you
aren't using a specifier here.  Same below, as well.  The binding
documentation indicates that #clock-cells should be 0 for the pll6 node.

  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
