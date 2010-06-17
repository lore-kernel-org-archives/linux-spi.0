From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] drivers: spi-gpio: add support for
 controllers without MISO or MOSI pin
Date: Thu, 17 Jun 2010 08:54:22 +0200
Message-ID: <013801cb0de9$ed930f10$c8b92d30$%szyprowski@samsung.com>
References: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
	<001701cb0180$60f0b320$22d21960$%szyprowski@samsung.com>
	<AANLkTilQ5yD16LAq4xEmXKAmrNqO8eWFh0BmHPd2cR0q@mail.gmail.com>
	<002b01cb0218$ddab68e0$99023aa0$%szyprowski@samsung.com>
	<AANLkTim-yZb55jAyOaQJ_pOnp-LcXh-wdzw4TKqAyfea@mail.gmail.com>
	<000301cb07a3$679c6ec0$36d54c40$%szyprowski@samsung.com>
	<AANLkTimT_IHfv4dKXuvTpa8M4L_MDqIvjrDPBLgzKUWn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Grant Likely' <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <AANLkTimT_IHfv4dKXuvTpa8M4L_MDqIvjrDPBLgzKUWn-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wednesday, June 16, 2010 9:52 PM Grant Likely:

> > The other possibility would be to create a new version of the
> bitbang_txrx_be_*
> > functions for NO_TX and NO_RX cases. Then the proper function can be
> assigned
> > in spi_gpio_probe(). However this would increase the size of spi_gpio
> driver
> > significantly.
> 
> Not that significantly, and it would keep all the relevant code
> together.  I'm more in favor of this approach.

Ok, I will prepare a new patch then.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
