From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/bcm63xx: document device tree bindings
Date: Thu, 10 Sep 2015 12:17:40 -0700
Message-ID: <55F1D754.9000101@openwrt.org>
References: <1441898975-22540-1-git-send-email-jogo@openwrt.org> <1441898975-22540-2-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441898975-22540-2-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/09/15 08:29, Jonas Gorski wrote:
> Add documentation for the bindings of the low speed SPI controller found
> on most bcm63xx SoCs.
> 
> Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-bcm63xx.txt        | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
> new file mode 100644
> index 0000000..1a60bb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
> @@ -0,0 +1,33 @@
> +Binding for Broadcom BCM6348/BCM6358 SPI controller
> +
> +Required properties:
> +- compatible: must contain one of "brcm,bcm6348-spi", "brcm,bcm6458-spi".

Typo, the second compatible should "brcm,bcm6358-spi", other than that:

Reviewed-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> +- reg: Base address and size of the controllers memory area.
> +- interrupts: Interrupt for the SPI block.
> +- clocks: phandle of the SPI clock.
> +- clock-names: has to be "spi".
> +- #address-cells: <1>, as required by generic SPI binding.
> +- #size-cells: <0>, also as required by generic SPI binding.
> +
> +Optional properties:
> +- num-cs: some controllers have less than 8 cs signals. Defaults to 8
> +  if absent.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +	spi@10000800 {
> +		compatible = "brcm,bcm6368-spi", "brcm,bcm6358-spi";
> +		reg = <0x10000800 0x70c>;
> +
> +		interrupts = <1>;
> +
> +		clocks = <&clkctl 9>;
> +		clock-names = "spi";
> +
> +		num-cs = <5>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
