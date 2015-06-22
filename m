From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the
 auxiliar spi1 and spi2
Date: Mon, 22 Jun 2015 16:55:29 +0200
Message-ID: <20150622165529.1b758b07@north>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434980408-4086-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 22 Jun 2015 13:40:06 +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> Also note that the driver currently implements locking of the auxiliar
> device enable bits inside the driver. This is shared with the uart1,
> for which we have so far no driver. Ideally this should get moved out
> as soon as we get the uart1 driver enabled.

As mentioned by Noralf UART1 is quite commonly used on Compute Modules.
Proper driver - perhaps modelled as a bus - seems like a prerequisite
for this work.  You are also not using IRQ mux in DT binding example
which is very misleading.

Do we have any indication weather this AUX hardware is available on
RPi2 as well?  IIRC bcm2836 differs only in CPU cores, peripherals
remain identical.  Perhaps this driver could be used on RPi2 and
naming it 283x would be more appropriate?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
