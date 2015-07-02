From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH V2] dt: brcm,bcm2835-aux-spi: add binding documentation
 for new spi-bcm2835aux
Date: Thu, 02 Jul 2015 18:31:10 +0200
Message-ID: <5595674E.1020201@lategoodbye.de>
References: <1435229673-2214-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435229673-2214-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

Am 25.06.2015 um 12:54 schrieb kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>   .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   35 ++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
>
> Changelog:
>    V1 -> V2:	fixed typo
> 		added cs-gpios
>
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
> new file mode 100644
> index 0000000..66f52d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
> @@ -0,0 +1,35 @@
> +Broadcom BCM2835 auxiliar SPI1/2 controller
> +
> +The BCM2835 contains two forms of SPI master controller, one known simply as
> +SPI0, and the other known as the "Universal SPI Master"; part of the
> +auxiliary block. This binding applies to the SPI1/2 controller.
> +
> +Required properties:
> +- compatible: Should be "brcm,bcm2835-aux-spi".
> +- reg: Should contain register location and length for the spi block
> +       as well as for the common aux block control
> +- interrupts: Should contain shared interrupt of the aux block
> +- clocks: The clock feeding the SPI controller.
> +- cs-gpios: the cs-gpios (native cs is NOT supported)

it would be nice to reference to spi-bus.txt here, just like the other 
bindings does.

- cs-gpios: see spi-bus.txt (native chip-select is NOT supported)

Beside that try to get a feedback from the devicetree maintainers.

Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
