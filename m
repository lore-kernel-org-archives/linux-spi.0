From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
Date: Tue, 08 Sep 2015 18:48:07 -0700
Message-ID: <87h9n4weg8.fsf@eliezer.anholt.net>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441359711-2800-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> The BCM2835 contains 3 auxiliar devices:
> * spi1
> * spi2
> * uart1
>
> All of those 3 devices are enabled/disabled via a shared register,
> which is set by default to be disabled.
>
> Access to this register needs to get serialized.
>
> So after several iterations of discussions with the following ideas:
> * syscon - device tree should describe HW not drivers to use -
>            'compatiblity = "brcm,bcm2835-aux-enable", "syscon";'
>            is not acceptable
> * regulator - it is not necessarily a regulator or a power gate
>               that is implemented in HW, so it is not valid to use
>               this framework
>
> The recommendation was made to create a new minimal API in soc
> just for access to this shared enable/disable register.
>
> This patch-series implements:
> * the bcm2835-auxiliar device enable/disable api in soc.
> * the bcm2835-auxiliar spi device driver
>
> The uart1 device driver (ns16550 based) is not implemented so far
> but would be using the same API.
>
> Both spi and uart drivers can run with shared interrupts,
> so there is no need for an interrupt-controller to get implemented.

I finally had a chance to sit down and look at what the hardware's doing
with the enable bit (also, I've read a whole lot more of the hardware
now, so I'm a lot faster at answering questions like this).  The enable
bits are a clock gate off of the VPU clock.

I knocked together the enable bits as a clock gate driver, since I'd
just written very similar code for the audio domain clock driver (and I
assume you are grumpy about how much time you've spent on this one
stupid register).  It's up at
https://github.com/anholt/linux/tree/bcm2835-clock-aux and I can submit
it if you like the result.  I've compile tested it only, but I'm hoping
you could just drop your aux SPI driver on top of it and have things
work.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJV74/XAAoJELXWKTbR/J7otvAP/1idFaFVwTgUPINQLN7zFU7J
NZ47B7fNqHJ1UaTCv37+WsIkUlALu538yMwuQI/Ctmz5giNqHo//b0KGbW6LU38b
bcM44ItGwEcbuKOSAyU5A0NMZLIDQXDSBOLP1SUrAjWHj0UBbSoqXpwdGlo8KQhO
csiqLE0k4inmic1D9KHVU5FHqOapl5XnGVPUt6pxsIwMYO81V12E95QvbjTJPUyr
7qojHVCIzLxLQoLHHUmR7VZlcVX5bRgcNtdpE80U3Af6IklAwlAJ5pILS1mzs/Y3
XHNL8QTyG7s9wd5k8iEy5qIP5YBPmCW9SXysBllldyD0tJOA/PkuSNXORG6s7cqw
kUqHfuKflm3n79jjPRY6FC8ichx4J7avezyFuRs8PrMjxk2WWLxDQEbRufWBIqWp
9kIO6/JAGgZZdjSOy2AjkLbYsGHN+CaxH0v3ocfOG1B7IzIavASdQNORBwH6B+CZ
wtsPMUkzTzJjQkySkaXNQj2som35sOhf+D3ybcDkymT+hisc7mk5lEgJTXCKg/bV
HRgSmx365hJoOPWR7zKtNvq63H86FnCoa/ywtKJlSZVrr02c8o9IYeuwxaZYu7zg
0otc2lLnjExSrehlanUxrXqhCZnshtykSMVvulFlqARfO4NwPQteETDD6cmGmhVP
j6woI3ZsnGP4uHBPZnSo
=2uio
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
