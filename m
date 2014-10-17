From: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv3] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Fri, 17 Oct 2014 08:52:33 +0200
Message-ID: <20141017065233.GA10262@pengutronix.de>
References: <1413497251-21954-1-git-send-email-tthayer@opensource.altera.com>
 <1413497251-21954-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org,
	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413497251-21954-2-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

On Thu, Oct 16, 2014 at 05:07:31PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> 
> Add 2 SPI nodes to SOCFPGA device tree.
> 
> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> ---
> v2: Remove extra files. Move SPIDEV into board specific file.
> 
> v3: Remove dts file since SPIDEV is not allowed.
> ---
>  arch/arm/boot/dts/socfpga.dtsi |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 4d77ad6..d81bc2d3 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -628,6 +628,30 @@
>  			clock-names = "biu", "ciu";
>  		};
>  
> +		spi0: spi@fff00000 {
> +			compatible = "snps,dw-apb-ssi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xfff00000 0x1000>;
> +			interrupts = <0 154 4>;
> +			num-cs = <4>;
> +			bus-num = <0>;
			^^^^^^^^^^^^^^

I think you can/should get rid of this property. It is only used/documented for
fsl-dspi as far as I can see.

> +			clocks = <&spi_m_clk>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@fff01000 {
> +			compatible = "snps,dw-apb-ssi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0xfff01000 0x1000>;
> +			interrupts = <0 156 4>;
> +			num-cs = <4>;
> +			bus-num = <1>;
> +			clocks = <&spi_m_clk>;
> +			status = "disabled";
> +		};
> +
>  		/* Local timer */
>  		timer@fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";

The rest looks good IMO.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
