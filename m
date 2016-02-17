From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i.MX SPI DMA cleanup
Date: Wed, 17 Feb 2016 14:42:33 +0100
Message-ID: <56C478C9.6050706@de.bosch.com>
References: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sascha,

On 17.02.2016 14:28, Sascha Hauer wrote:
> This picks up a series sent by Anton Bondarenko last year. It
> contains the remaining not yet upstreamed patches from Antons series
> plus some more DMA related cleanup patches.
>
> My mission was to hunt a bug in the DMA code path sometimes causing
> an additional word in the RX FIFO which locked up the driver in the
> next transfer. It turned out that this was no bug in the driver but
> instead in the device tree: We used the wrong SDMA script for i.MX6.
> The ECSPI cores are connected through the SPBA, so according to the
> reference manual we need the shp/mcu scripts rather than the app/mcu
> scripts.


Are you talking about what is known as "TKT238285 hardware issue"

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/spi/spi-imx.c?id=a02bb401f8ae264be782ee57d98bdd99f14c8022

?

Or are you talking about a different issue?

Best regards

Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
