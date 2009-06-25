From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH] [drivers] [SPI] SPI_GPIO: add support for controllers with
 missing MISO pin
Date: Thu, 25 Jun 2009 14:16:04 +0200
Message-ID: <000401c9f58e$c1369230$43a3b690$%szyprowski@samsung.com>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0228288531@bssrvexch01.BS.local>
 <200906231155.15339.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: 'LKML' <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net, kyungmin.park@samsung.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
To: 'David Brownell' <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754448AbZFYMRe@vger.kernel.org>
In-reply-to: <200906231155.15339.david-b@pacbell.net>
Content-language: pl
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Tuesday, June 23, 2009 8:55 PM, David Brownell wrote:

> > There are some boards that do not strictly follow SPI standard and use only 3 wires
> > (SCLK, MOSI, SS) for connecting some simple auxiliary chips and controls them with GPIO
> > based 'spi controller'. In this configuration the MISO line is missing (it is not
> > required if the chip does not transfer any data back to host). The example of such
> > board is a NCP ARM S3C64XX based machine. This patch adds support for such non-standard
> > configuration in GPIO-based SPI controller.
> >
> > Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> This is missing one integrity feature:  it should reject all
> requests that provide a read buffer, since obviously it can't
> satisfy any such requests.
> 
> Also, please add a comment in spi_gpio_request() explaining
> this point:  that output-only configs exist, and you're
> supporting them by letting MISO be invalid.
> 
> Address those two points and this will be almost OK.

Thanks for your review. I will post an updated patch soon.

> Thing is, this raises two related issues:  (a) there's the
> analagous input-only case where MOSI isn't used, e.g. for
> some kinds of sensor; and (b) there's also "real 3-wire SPI"
> (spi->mode & SPI_3WIRE) where interactions are limited to
> half duplex and one pin switches roles between MOSI and MISO.
> 
> Clearly this "output-only" case is a subset of SPI_3WIRE (the
> MOMI/SISO pin can't switch direction) so one more change I
> want to see is requiring that spi->mode flag be set in all
> SPI devices registered when this mode is used.
> 
> If you have time, it would be good to generaize this patch
> to cover all of those 3-wire modes ... accept all half
> duplex calls, use gpio_direction_*() to switch direction.
>
> If not -- e.g. nothing to test that with! -- then I can
> understand, but please make your changes with that model
> in mind, and leave an appropriate FIXME in place.

I'm sorry, but I have only a hw board with missing MISO pin so I won't
be able to properly check/debug any other configurations. However I
will add a support for missing MOSI pin as well (simple code
reusage).

> p.s. I'll CC you on one more related patch.  Briefly,
>      there's a new spi_master->flags field that should
>      set SPI_MASTER_HALF_DUPLEX.  Arguably, this specific
>      case should also advertise something like NO_RX.

Thanks. I will add SPI_MASTER_NO_TX/NO_RX flags there.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
