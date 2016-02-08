From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] devicetree: Add bindings documentation for Analog
 Devices axi-spi-engine
Date: Mon, 8 Feb 2016 12:59:28 -0600
Message-ID: <20160208185928.GA16097@rob-hp-laptop>
References: <1454602410-14049-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454602410-14049-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 04, 2016 at 05:13:29PM +0100, Lars-Peter Clausen wrote:
> Add the devicetree bindings documentation for the Analog Devices
> axi-spi-engine SPI master peripheral. This is a soft-peripheral used in
> FPGAs.
> 
> The external interfaces of the peripheral are:
> 	* A memory mapped register map which is used to configure the
> 	  peripheral.
> 	* One interrupt.
> 	* Two clocks, one for the memory mapped register interface and one
> 	  for the SPI bus.
> 	* A SPI master interface to which the slave devices are connected.
> 
> These interfaces are described by the devicetree bindings accordingly.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/adi,axi-spi-engine.txt | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
> new file mode 100644
> index 0000000..8a18d71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
> @@ -0,0 +1,31 @@
> +Analog Devices AXI SPI Engine controller Device Tree Bindings
> +
> +Required properties:
> +- compatible		: Must be "adi,axi-spi-engine-1.00.a""
> +- reg			: Physical base address and size of the register map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number.
> +- clock-names		: List of input clock names - "s_axi_aclk", "spi_clk"
> +- clocks		: Clock phandles and specifiers (See clock bindings for
> +			  details on clock-names and clocks).
> +- #address-cells	: Must be <1>
> +- #size-cells		: Must be <0>
> +
> +Optional subnodes:
> +	Subnodes are use to represent the SPI slave devices connected to the SPI
> +	master. They follow the generic SPI bindings as outlined in spi-bus.txt.
> +
> +Example:
> +
> +    spi@@44a00000 {
> +		compatible = "adi,axi-spi-engine-1.00.a";
> +		reg = <0x44a00000 0x1000>;
> +		interrupts = <0 56 4>;
> +		clocks = <&clkc 15 &clkc 15>;
> +		clock-names = "s_axi_aclk", "spi_clk";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* SPI devices */
> +    };
> -- 
> 2.1.4
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
