From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt/bindings/spi: Add bindings for PIC32 Quad-SPI
 driver.
Date: Thu, 14 Apr 2016 11:18:26 -0500
Message-ID: <20160414161826.GA12444@rob-hp-laptop>
References: <1460553125-32649-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460553125-32649-1-git-send-email-purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 13, 2016 at 06:42:04PM +0530, Purna Chandra Mandal wrote:
> Document Device tree bindings for quad SPI peripheral
> found on Microchip PIC32 class devices.
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> 
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> 
>  Documentation/devicetree/bindings/spi/sqi-pic32.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/sqi-pic32.txt

One nit below, otherwise:

Acked-by: Rob Herring <rob-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> diff --git a/Documentation/devicetree/bindings/spi/sqi-pic32.txt b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
> new file mode 100644
> index 0000000..5af9fab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/sqi-pic32.txt
> @@ -0,0 +1,18 @@
> +Microchip PIC32 Quad SPI controller
> +-----------------------------------
> +Required properties:
> +- compatible: Should be "microchip,pic32mzda-sqi".
> +- reg: Address and length of SQI controller register space.
> +- interrupts: Should contain SQI interrupt.
> +- clocks: Should contain phandle of two clocks in sequence, clock that drives
> +          clock on SPI bus and clock that drives SQI controller.
> +- clock-names: Should be "spi_ck" and "reg_ck" in order.
> +
> +Example:
> +	sqi1: sqi@1f8e2000 {

spi@...

> +		compatible = "microchip,pic32mzda-sqi";
> +		reg = <0x1f8e2000 0x200>;
> +		clocks = <&rootclk REF2CLK>, <&rootclk PB5CLK>;
> +		clock-names = "spi_ck", "reg_ck";
> +		interrupts = <169 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 1.8.3.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
