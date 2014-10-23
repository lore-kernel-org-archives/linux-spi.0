From: Dinh Nguyen <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCHv4] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Thu, 23 Oct 2014 10:33:56 -0500
Message-ID: <alpine.DEB.2.02.1410231032100.31473@linux-builds1>
References: <1413917741-19240-1-git-send-email-tthayer@opensource.altera.com> <1413917741-19240-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<mark.rutland-5wv7dgnIgG8@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413917741-19240-2-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 21 Oct 2014, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> 
> Add 2 SPI nodes to SOCFPGA device tree.
> 
> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> ---
> v2: Remove extra files. Move SPIDEV into board specific file.
> 
> v3: Remove dts file since SPIDEV is not allowed.
> 
> v4: Remove bus-num since it is unused and not defined in bindings.
> ---
>  arch/arm/boot/dts/socfpga.dtsi |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 4d77ad6..2792e6c 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -628,6 +628,28 @@
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
> +			clocks = <&spi_m_clk>;
> +			status = "disabled";
> +		};
> +
>  		/* Local timer */
>  		timer@fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";
> -- 
> 1.7.9.5

Applied to git.rocketboards.org/linux-socfpga-next.git next-dt.

BR,
Dinh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
