From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
Date: Thu, 10 Sep 2015 17:57:49 +0200
Message-ID: <8B777380-A2A1-475E-8A1C-942BF28EE160@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org> <87h9n4weg8.fsf@eliezer.anholt.net> <55F1A651.5090102@tronnes.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Phil <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
To: =?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55F1A651.5090102-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 10.09.2015, at 17:48, Noralf Tr=F8nnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org> wrote:
>=20
> This looks interesting.
> But there's a challenge with the uart1 and the 8250 driver.
>=20
> Phil Elwell has this to say:
> This means that that UART1 isn't an exact clone of a 8250 UART.
> In a particular, the clock divisor is calculated differently.
> A standard 8250 derives the baud rate as clock/(divisor16),
> whereas the BCM2835 mini UART uses clock/(divisor8). This means
> that if you want to use the standard driver then you need to lie
> about the clock frequency, providing a value is twice the real
> value, in order for a suitable divisor to be calculated.
>=20
> Ref: https://github.com/raspberrypi/linux/pull/1008#issuecomment-1392=
34607
>=20
> So either we need a new uart1 driver or a doubled clock freq. somehow=
=2E

=46ound out the same thing and communicated it to Eric - not=20
knowing about the different divider=85

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
