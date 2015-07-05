From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar spi1 and spi2
Date: Sun, 5 Jul 2015 23:11:52 +1000
Message-ID: <51801EDD-782C-4553-9462-D4873B2D7085@martin.sperl.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <20150622165529.1b758b07@north> <E72B3D8C-EA1B-4B4C-8EAF-C14A5631882E@martin.sperl.org> <97C7561C-6D67-4F51-94BB-3B8D401D77A0@martin.sperl.org> <20150630094232.GM11162@sirena.org.uk> <6A2CCE70-5DAF-4E86-A0A4-F5E93FD1B540@martin.sperl.org> <55945448.7010502@tronnes.org> <1400E1A3-43E1-4D0E-A54D-E5D668A4C516@martin.sperl.org> <55990904.9040002@tronnes.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	=?utf-8?Q?Jakub_Kici=C5=84ski?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55990904.9040002-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> On 05.07.2015, at 20:37, Noralf Tr=C3=B8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wro=
te:
>=20
> I have looked closer at the 8250 serial driver, and in fact it has a
> framework for writing 8250 like drivers. This makes it easy to extend
> it to include support for the mini uart.
> drivers/tty/serial/8250/8250_dw.c is an example of a driver that
> overrides the interrupt handler. So a 8250_bcm2835.c can easily be
> made with interrupt sharing as you suggest (and aux enabling). But
> this means that the irq status register has to be included in the
> syscon regmap as well.

With the Module parameter share_irqs=3D1 the stock 8250 driver will
request a shared irq, but you can also control it via:
CONFIG_SERIAL_8250_SHARE_IRQ

As for regmap support - the driver only uses the status register of
the uart so it does not need access to the shared interrupt flag regist=
er.
(If no irq condition is detected then IRQ_NoNE is returned and the
Shared irq system will call the next irq handler in the list)

So all that is left to do is enabling the uart device in the aux-enable
registers using regmap and then the uart can get used.

Martin--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
