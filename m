From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: clps711x: dts: Add bindings documentation for
 the CLPS711X SPI driver
Date: Mon, 22 Sep 2014 19:08:52 +0100
Message-ID: <20140922180852.GA23666@leverpostej>
References: <1411196736-5019-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411196736-5019-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Sep 20, 2014 at 08:05:36AM +0100, Alexander Shiyan wrote:
> This patch adds the devicetree documentation for the
> Cirrus Logic CLPS711X SPI driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-clps711x.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-clps711x.txt b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
> new file mode 100644
> index 0000000..43712c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
> @@ -0,0 +1,20 @@
> +* Cirrus Logic ARM CLPS711X Serial Peripheral Interface (SPI)
> +
> +Required properties:
> +- compatible: Shall contain "cirrus,clps711x-spi".

Is there a specific "clps11x" device, or is that 'x' a wildcard?

Please don't use wildcards in bindings. Choose a particular device as
the fallback string to use.

> +- reg: Offset and length of the register set for the device.
> +- interrupts: Should contain SPI interrupt.
> +- clocks: phandle to SPI reference clock.
> +- cs-gpios: Specifies the GPIO pins to be used for chipselects.
> +
> +Example:
> +	spi: spi@80000500 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "cirrus,ep7312-spi", "cirrus,clps711x-spi";

Which other strings are compatible?

Thanks,
Mark.

> +		reg = <0x80000500 0x4>;
> +		interrupts = <15>;
> +		clocks = <&clks CLPS711X_CLK_SPIREF>;
> +		cs-gpios = <&portb 4 GPIO_ACTIVE_LOW>,
> +			   <&portb 5 GPIO_ACTIVE_LOW>;
> +	};
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
