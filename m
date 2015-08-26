From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 5/5] dt/bindings: bcm2835: Add binding documentation
 for auxiliar spi devices
Date: Tue, 25 Aug 2015 19:49:05 -0600
Message-ID: <55DD1B11.30709@wwwdotorg.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org> <1440405608-3995-6-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440405608-3995-6-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/24/2015 02:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Patch description?

> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt

> +Required properties:
> +- compatible: Should be "brcm,bcm2835-aux-spi".
> +- reg: Should contain register location and length for the spi block
> +       as well as for the common aux block control

Is that meant to imply that reg should contain a single value that
covers both the common aux registers and the SPI device, or two separate
values, one for the aux common registers and another for the SPI device?
Neither of those options sound correct. I would expect only a single
entry which covered solely the SPI registers. The common aux registers
are owned by the other brcm,bcm2835-aux binding.

> +Example:
> +
> +spi1@7e215080 {
> +	compatible = "brcm,bcm2835-aux-spi";
> +	reg = <0x7e215080 0x40>;

That seems to match what I'd expect, but doesn't correspond to the
description above.

> +/* the necessary syscon config referenced above*/
> +aux_enable: aux_enable@0x7e215004 {

It's not a "syscon"...

> +Note that it also requires the GPIOs to be set up with the
> +correct ALT-functions.
> +
> +For spi1 the following pins need to be set as:
> +* ALT4: 19, 20, 21 (MISO, MOSI, SCK)
> +
> +For spi2 the following pins need to be set as:
> +* ALT4: 40, 41, 42 (MISO, MOSI, SCK)
> +
> +CS-GPIOS need to get set as output - typically:
> +* spi1: 18, 17, 16 (CS0, CS1, CS2)
> +* spi2: 43, 44, 45 (CS0, CS1, CS2)

That's generally true of any HW block, and has nothing to do with the
binding for the device. I would suggest removing that chunk of text.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
