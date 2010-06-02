From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] drivers: spi-gpio: add support for
 controllers without MISO or MOSI pin
Date: Wed, 02 Jun 2010 08:00:08 +0200
Message-ID: <002b01cb0218$ddab68e0$99023aa0$%szyprowski@samsung.com>
References: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
	<001701cb0180$60f0b320$22d21960$%szyprowski@samsung.com>
	<AANLkTilQ5yD16LAq4xEmXKAmrNqO8eWFh0BmHPd2cR0q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Grant Likely' <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <AANLkTilQ5yD16LAq4xEmXKAmrNqO8eWFh0BmHPd2cR0q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Tuesday, June 01, 2010 5:00 PM Grant Likely wrote:

> On Tue, Jun 1, 2010 at 5:48 AM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > Hello,
> >
> > On Thursday, April 01, 2010 12:36 PM Marek Szyprowski wrote:
> >
> >> There are some boards that do not strictly follow SPI standard and use
> >> only 3 wires (SCLK, MOSI or MISO, SS) for connecting some simple
> auxiliary
> >> chips and controls them with GPIO based 'spi controller'. In this
> >> configuration the MISO or MOSI line is missing (it is not required if
> the
> >> chip does not transfer any data back to host or host only reads data
> from
> >> chip).
> >>
> >> This patch adds support for such non-standard configuration in GPIO-
> based
> >> SPI controller. It has been tested in configuration without MISO pin.
> >>
> >> Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >
> > Is there any progress on merging this patch? It hangs on the patchwork
> for
> > 2 months still marked as 'new'. I'm a bit confused. The idea behind the
> patch
> > was already accepted (see commit 568d0697f42771425ae9f1e9a3db769fef7e10b6)
> > but then the patch is still waiting... My fault I didn't asked for it on
> the
> > beginning of the merge window.
> 
> I'm not convinced this is the best approach.  I did look at it, but
> decided not to merge it yet.  It adds code to the hottest path in the
> spi-gpio driver (not that this driver will ever be fast, but on
> bit-banged gpio, every instruction counts).

If this is really a problem I can remove the 'if (SPI_{MOSI,MISO}_GPIO !=
SPI_GPIO_NO_{MOSI,MISO})' checks. If we assume that the upper level of the
spi framework works correctly, these functions shouldn't be called if
the pin is set to NO_GPIO (the master device has SPI_MASTER_NO_{TX,RX} flags
set).

> I was delayed it getting on the SPI backlog this merge cycle due to
> travel, so I've deferred making a decision on this patch.  I'll be
> taking another look in the next few weeks and I'll let you know
> whether or not I'll pick it up for 2.6.36

Ok.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


------------------------------------------------------------------------------
