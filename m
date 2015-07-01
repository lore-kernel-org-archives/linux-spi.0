From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Thu, 2 Jul 2015 05:39:31 +1000
Message-ID: <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north> <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org> <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org> <20150630094232.GM11162@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150630094232.GM11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 30.06.2015, at 19:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> This looks relevant:
>=20
>>>> On 22.06.2015, at 16:55, Jakub Kici=C5=84ski <moorray3-5tc4TXWwyLM@public.gmane.org> wrot=
e:
>>>> As mentioned by Noralf UART1 is quite commonly used on Compute Mod=
ules.
>>>> Proper driver - perhaps modelled as a bus - seems like a prerequis=
ite
>>>> for this work.  You are also not using IRQ mux in DT binding examp=
le
>>>> which is very misleading.
Well, we are using shared interrupts, which is typical for other driver=
s on
the rpi as well - i2c and usb are examples for multiple handlers on
a single irq line on the rpi - excerpt from /proc/interrupts:
          CPU0
33: 3547607286  ARMCTRL-level  41 Edge      20980000.usb, dwc2_hsotg:us=
b1
77:          0  ARMCTRL-level  85 Edge      20205000.i2c, 20804000.i2c


The compute module is not supported upstream and nobody
created any patches for a device tree for a cm...

On top there is no direct support for uart1 in the upstream kernel.

Support only exists in the foundation kernel where the implementation
enables the uart1 in the board-config directly, so that uart1
can also get used as the console during boot.

This means (as far as I understand) that there can be no=20
race-condition, as spi would get configured later during boot
and the access to the enable register is then properly
protected against concurrent access when enabling both
auxiliar spi devices (and spi2 is only usable on the compute
Module - see above for upstream support of the cm)

=46inally asking for a recommendation with regards to using a bus
to arbitrate access to the enable register there was no feedback
how this could be get implemented...

This last piece is actually one of the last reasons why I have not
posted a patch for spi1 and spi2 to the default device-trees for
the rpi models yet.
(That and the fact that assigning pins in multiple pinctrl groups
- i2s and spi1 - gives warnings or errors in dmesg, because i2s is
also requiring Gpio 18, 19, 20 and 21 on the model-b-plus
device tree - so it can only be either/or not both...)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
