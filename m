From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] drivers: spi-gpio: add support
	for	controllers without MISO or MOSI pin
Date: Thu, 01 Apr 2010 15:10:32 +0200
Message-ID: <002c01cad19c$b82b76c0$28826440$%szyprowski@samsung.com>
References: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
	<i2r1b68c6791004010417q1aaa996au22f526afbedb9635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: 'jassi brar' <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <i2r1b68c6791004010417q1aaa996au22f526afbedb9635-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: pl
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

On Thursday, April 01, 2010 1:17 PM jassi brar wrote:

> > There are some boards that do not strictly follow SPI standard and use
> > only 3 wires (SCLK, MOSI or MISO, SS) for connecting some simple auxiliary
> > chips and controls them with GPIO based 'spi controller'. In this
> > configuration the MISO or MOSI line is missing (it is not required if the
> > chip does not transfer any data back to host or host only reads data from
> > chip).
> >
> > This patch adds support for such non-standard configuration in GPIO-based
> > SPI controller. It has been tested in configuration without MISO pin.
> Though not very clear atm, but wouldn't having some ineffective
> virtual GPIO assigned
> to this non-existing MISO/MOSI do the trick?

This will be very hacky, also the platform would need to have some virtual
GPIO only for this purpose.

The proposed patch does it in the right way, especially because all required
SPI master flags (SPI_MASTER_NO_TX and SPI_MASTER_NO_RX) are already merged
to SPI core.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
