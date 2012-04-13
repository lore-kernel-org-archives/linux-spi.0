From: Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Fri, 13 Apr 2012 11:54:21 +0200
Message-ID: <4F87F7CD.4000004@stericsson.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F87EBFC.90000@stericsson.com>
	<20120413091828.GJ3168@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120413091828.GJ3168-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 04/13/2012 11:18 AM, Mark Brown wrote:
> On Fri, Apr 13, 2012 at 11:03:56AM +0200, Ulf Hansson wrote:
>
>> But, how should those amba drivers that implements runtime PM
>> support be able to switch of the vcore regulator during normal
>> suspend? In normal suspend case we can not use
>
> A generic AMBA driver should have no idea about the implementation of
> the particular SoC that it's integrated on to.  This applies even more
> to system suspend (where drivers can generally just assume that they
> will loose all power normally) than it does to runtime suspend.
>
>> pm_runtime_put/pm_runtime_put_sync to trigger the power domain
>> runtime functions to switch of vcore. This is kind of more generic
>> problem when dealing with power domains, but as said this patch will
>> have consequences.
>
> The power domain gets callbacks on the system suspend path too and can
> do whatever is sensible there.
>
>> As far as I can see, the power domain must then implement a
>> suspend_noirq function to make sure same things is done as for the
>> runtime_suspend function. Do you agree with this as well or is there
>> another option?
>
> Yes, the power domain should just be handling this transparently.

Alright, thanks for your confirmation. Let's see how this works out then.

Kind regards
Ulf Hansson

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
