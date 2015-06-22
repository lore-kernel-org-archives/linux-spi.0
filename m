From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Mon, 22 Jun 2015 17:26:42 +0200
Message-ID: <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: =?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150622165529.1b758b07@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> wrote:
> As mentioned by Noralf UART1 is quite commonly used on Compute Module=
s.
> Proper driver - perhaps modelled as a bus - seems like a prerequisite
> for this work.  You are also not using IRQ mux in DT binding example
> which is very misleading.

Well - there is no support far for uart1 in upstream as of now.
And I am not even sure if the compute module is supported as there
is no device tree available in upstream for that...

So I have taken the simple route of using shared interrupts and providi=
ng
a minimal framework to enable the spi1/spi2 hw blocks with proper locki=
ng.
And I have mentioned that it would need to get modified when uart1 supp=
ort
comes along.

If you know of a better solution how to control this and that also
incorporates a patch to enable uart1, then please share it!

Just modify the bcm2835aux_spi_enable/disable to use a different framew=
ork
than just bcm2835_aux_modify_enable.

The patch Noralf mentions only applies downstream and only sets the
enable-register during the boot sequence, so it would not impact the
solution as is.

> Do we have any indication weather this AUX hardware is available on
> RPi2 as well?  IIRC bcm2836 differs only in CPU cores, peripherals
> remain identical.  Perhaps this driver could be used on RPi2 and
> naming it 283x would be more appropriate?

I have not checked, but I would guess that it exists.

As for naming: I have asked around and bcm2835aux seemed fine.
Also if we go that route we should start renaming ALL driver instances =
that
contain 2835.--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
