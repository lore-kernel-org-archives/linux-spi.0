From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 2/2] dt/bindings: control CS via standard GPIO operations
 instead of SPI-HW
Date: Tue, 17 Mar 2015 09:03:47 +0100
Message-ID: <5507DFE3.6080900@i2se.com>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org> <1425487205-5477-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425487205-5477-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

Am 04.03.2015 um 17:40 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Change the device tree to use cs-gpios for the spi bus master
> and standard gpio operation instead of relying on the HW with
> just 2 chip_selects using ALT0.
>
> This reassigns the existing CS pins 7(=CS1) and 8(=CS0)
> as output instead of ALT0 (=SPI HW block controlled) 
> and adds them in the list of cs-gpios for the spi-bus.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi |    4 ++--
>  arch/arm/boot/dts/bcm2835.dtsi     |    1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index c706448..f0e36ab 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -20,12 +20,12 @@
>  	pinctrl-names = "default";
>  
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

just a note for your next version. I think this patch won't apply
against for-rpi-next.

It misses that one:

https://git.kernel.org/cgit/linux/kernel/git/rpi/linux-rpi.git/commit/?h=for-rpi-next&id=72a6dbe0ea91e2a9c4357a3b0afbbd7b1f00dc8a

Regards
Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
