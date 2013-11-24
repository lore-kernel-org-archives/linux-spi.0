From: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: spi-gpio: Use 'cansleep' variants to access GPIO
Date: Sun, 24 Nov 2013 12:56:29 -0300
Message-ID: <20131124155628.GA3417@localhost>
References: <1385296621-23638-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131124141255.GZ14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131124141255.GZ14725-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Nov 24, 2013 at 02:12:55PM +0000, Mark Brown wrote:
> On Sun, Nov 24, 2013 at 09:37:01AM -0300, Ezequiel Garcia wrote:
> > The GPIO chip in use could be of any kind, and therefore might slee=
p
> > when accesing the GPIO lines. Take account of this by using canslee=
p
> > instead, which is the most generic case.
>=20
> Applied, thanks.

Mark:

I'm just wondering -as I don't have much experience with gpiolib-
is this replacement the Right Thing To Do?

It seemed to me that the xxx_cansleep variant just adds a check
and a might_sleep, so this change won't hurt the general case.

Is this correct?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
