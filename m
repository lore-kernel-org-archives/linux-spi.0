From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 4/5] spi: bcm2835: new driver implementing auxiliar
 spi1/spi2 on the bcm2835 soc
Date: Tue, 25 Aug 2015 19:56:31 -0600
Message-ID: <55DD1CCF.4080808@wwwdotorg.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org> <1440405608-3995-5-git-send-email-kernel@martin.sperl.org>
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
In-Reply-To: <1440405608-3995-5-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/24/2015 02:40 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Patch description?

>  arch/arm/configs/bcm2835_defconfig |    1 +
>  drivers/spi/Kconfig                |   12 +
>  drivers/spi/Makefile               |    1 +
>  drivers/spi/spi-bcm2835aux.c       |  506 ++++++++++++++++++++++++++++++++++++

A change to the defconfig would be applied by the RPi maintainers, and a
change to drivers/spi by the SPI maintainers. Those need to be in
different patches.

> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c

> +static int bcm2835aux_spi_probe(struct platform_device *pdev)

> +	clk_prepare_enable(bs->clk);

Error checking?

> +	/* enable HW block */
> +	bcm2835aux_enable(&pdev->dev, ENABLE_PROPERTY);

The return value needs to be error-checked, so that deferred probe can
work, and so other kinds of errors can be detected. Wasn't this correct
in a previous patch version?

Note that I didn't review any code besides probe(), remove() and the
driver boiler-plate that refers to those functions.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
