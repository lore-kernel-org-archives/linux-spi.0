From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] drivers: spi-gpio: add support for
 controllers without MISO or MOSI pin
Date: Wed, 09 Jun 2010 09:14:25 +0200
Message-ID: <000301cb07a3$679c6ec0$36d54c40$%szyprowski@samsung.com>
References: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
	<001701cb0180$60f0b320$22d21960$%szyprowski@samsung.com>
	<AANLkTilQ5yD16LAq4xEmXKAmrNqO8eWFh0BmHPd2cR0q@mail.gmail.com>
	<002b01cb0218$ddab68e0$99023aa0$%szyprowski@samsung.com>
	<AANLkTim-yZb55jAyOaQJ_pOnp-LcXh-wdzw4TKqAyfea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Jassi Brar' <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <AANLkTim-yZb55jAyOaQJ_pOnp-LcXh-wdzw4TKqAyfea-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wednesday, June 02, 2010 11:00 AM Jassi Brar wrote:

> On Wed, Jun 2, 2010 at 3:00 PM, Marek Szyprowski
> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > On Tuesday, June 01, 2010 5:00 PM Grant Likely wrote:
> >> On Tue, Jun 1, 2010 at 5:48 AM, Marek Szyprowski
> >> <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> >> I'm not convinced this is the best approach.  I did look at it, but
> >> decided not to merge it yet.  It adds code to the hottest path in the
> >> spi-gpio driver (not that this driver will ever be fast, but on
> >> bit-banged gpio, every instruction counts).
> >
> > If this is really a problem I can remove the 'if (SPI_{MOSI,MISO}_GPIO !=
> > SPI_GPIO_NO_{MOSI,MISO})' checks. If we assume that the upper level of
> the
> > spi framework works correctly, these functions shouldn't be called if
> > the pin is set to NO_GPIO (the master device has SPI_MASTER_NO_{TX,RX}
> flags
> > set).

Ok. I've did a research and that SPI_{MOSI,MISO}_GPIO != SPI_GPIO_NO_{MOSI,MISO}
checks cannot be easily removed, because in each loop both getmiso() and
setmosi() are called by the bitbang_txrx_be_* functions. I also understand that
this part of code is really hot and should be optimized as much as possible.

> As I pointed in the last thread, such peculiar platforms had better
> assign some virtual gpio
> for such non-existent miso/mosi, rather than imposing these extra
> checks on most of the normal platforms.

Creating a virtual gpio bank only for this case is also an overhead imho.
GPIO SPI masters without RX line will be used by more than one machine, so
some kind of a generic driver is imho needed.

Notice that the spi_s3c24xx_gpio.c driver already silently handles such
NO_RX transfers and machines that use it depends on such behavior. I expect
that this driver will be soon removed in favor of generic spi_gpio driver,
once plat-s3c24xx will be finally converted to use generic gpio lib.

What do you think about duplicating spi_gpio driver with my proposed changes
as spi_gpio_adv? The original spi_gpio driver won't be modified at all, so no
performance lose will happen for machines that use it. For new machines the
developers will be able to select weather they need a high speed transfers or
a driver that supports some rarely used features.

The other possibility would be to create a new version of the bitbang_txrx_be_*
functions for NO_TX and NO_RX cases. Then the proper function can be assigned
in spi_gpio_probe(). However this would increase the size of spi_gpio driver
significantly.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
