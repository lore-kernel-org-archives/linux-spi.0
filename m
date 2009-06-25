From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] [drivers] [SPI] SPI_GPIO: add support for controllers with missing MISO pin
Date: Thu, 25 Jun 2009 08:36:52 -0700
Message-ID: <200906250836.53027.david-b@pacbell.net>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0228288531@bssrvexch01.BS.local> <200906231155.15339.david-b@pacbell.net> <000401c9f58e$c1369230$43a3b690$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net, kyungmin.park@samsung.com
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758255AbZFYPhg@vger.kernel.org>
In-Reply-To: <000401c9f58e$c1369230$43a3b690$%szyprowski@samsung.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 25 June 2009, Marek Szyprowski wrote:
> > Thing is, this raises two related issues: =A0(a) there's the
> > analagous input-only case where MOSI isn't used, e.g. for
> > some kinds of sensor; and (b) there's also "real 3-wire SPI"
> > (spi->mode & SPI_3WIRE) where interactions are limited to
> > half duplex and one pin switches roles between MOSI and MISO.
> >=20
> > Clearly this "output-only" case is a subset of SPI_3WIRE (the
> > MOMI/SISO pin can't switch direction) so one more change I
> > want to see is requiring that spi->mode flag be set in all
> > SPI devices registered when this mode is used.

Don't forget that change ...

=20
> > If you have time, it would be good to generalize this patch
> > to cover all of those 3-wire modes ... accept all half
> > duplex calls, use gpio_direction_*() to switch direction.
> >
> > If not -- e.g. nothing to test that with! -- then I can
> > understand, but please make your changes with that model
> > in mind, and leave an appropriate FIXME in place.
>=20
> I'm sorry, but I have only a hw board with missing MISO pin so I won'=
t
> be able to properly check/debug any other configurations.

OK, then just stick to what you can test, and comment the issue.
