From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] dt/bindings: control CS via standard GPIO operations
 instead of SPI-HW
Date: Fri, 06 Mar 2015 22:47:53 -0700
Message-ID: <54FA9109.6080102@wwwdotorg.org>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org> <1425487205-5477-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425487205-5477-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/04/2015 09:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Change the device tree to use cs-gpios for the spi bus master
> and standard gpio operation instead of relying on the HW with
> just 2 chip_selects using ALT0.
> 
> This reassigns the existing CS pins 7(=CS1) and 8(=CS0)
> as output instead of ALT0 (=SPI HW block controlled) 
> and adds them in the list of cs-gpios for the spi-bus.

These pins aren't used by anything on the board, but are rather part of
the expansion header. I wonder if we wouldn't be better off removing any
configuration of the pins from the DT. After all, we can't guarantee how
the user has connected them. The "default" usage, a/k/a the expansion
header signal naming, isn't any guarantee.

Rather, the user should specify what they want to use the pin as; as a
GPIO input, GPIO output, or an SPI chip-select.

> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi

>  	gpioout: gpioout {
> -		brcm,pins = <6>;
> +		brcm,pins = <6 7 8>;
>  		brcm,function = <1>; /* GPIO out */
>  	};
>  
>  	alt0: alt0 {
> -		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 14 15 40 45>;
> +		brcm,pins = <0 1 2 3 4 5 9 10 11 14 15 40 45>;
>  		brcm,function = <4>; /* alt0 */
>  	};

While the existing DT already has this issue, note that this forces
these pins to be driven as outputs. What if the user has hooked up an
external device that drives these signals, and wants to use the pins as
GPIO inputs?

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			status = "disabled";
> +			cs-gpios = <&gpio 8 0>, <&gpio 7 0>;
>  		};

This shouldn't be in the SoC .dtsi file. It's quite possible for someone
to use other GPIOs as SPI CS. It's board or even use-case specific
whether those are the correct values.

I would argue that we should not put any cs-gpios into any in-kernel DT
file, since there's no on-board usage of SPI on the RPi boards.

For SPI to be useful, the user has to add a DT node to represent the SPI
device itself anyway, so adding some properties to the controller to
define which GPIOs to use for SPI CS can be done then too.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
