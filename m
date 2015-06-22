From: =?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Mon, 22 Jun 2015 16:08:06 +0200
Message-ID: <558816C6.9090009@tronnes.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434980408-4086-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Den 22.06.2015 15:40, skrev kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> This driver does NOT make use of native chip-selects but uses the
> generic cs-gpios facilities provided by the framework allowing for
> more than 3 chip-selects.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> ---
>   drivers/spi/Kconfig          |   10 +
>   drivers/spi/Makefile         |    1 +
>   drivers/spi/spi-bcm2835aux.c |  549 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 560 insertions(+)
>   create mode 100644 drivers/spi/spi-bcm2835aux.c
>
> Only tested spi1, as no Compute Module is available to me to test spi2.
>
> Also note that the driver currently implements locking of the auxiliar
> device enable bits inside the driver. This is shared with the uart1,
> for which we have so far no driver. Ideally this should get moved out
> as soon as we get the uart1 driver enabled.
>
> Uart1 is also only accessible on the Compute Module.

Uart1 is available on the uart0 pins (alt5) and the 8250 driver can be 
used (ns16550 compatible).
See: https://github.com/raspberrypi/linux/pull/1008

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
