From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/9] arm/pxa2xx: reorgazine SSP and SPI header files
Date: Wed, 24 Nov 2010 15:13:27 +0100
Message-ID: <4CED1D87.3000607@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>	<1290597207-29838-5-git-send-email-bigeasy@linutronix.de>
	<AANLkTinBFQZkuH4haeQAZQv8p0WZN5uh4xJj53sjUGTt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTinBFQZkuH4haeQAZQv8p0WZN5uh4xJj53sjUGTt-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Haojian Zhuang wrote:
> On Wed, Nov 24, 2010 at 7:13 PM, Sebastian Andrzej Siewior
> <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
<snip>
>> diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/include/linux/pxa2xx_ssp.h
>> similarity index 98%
>> rename from arch/arm/plat-pxa/include/plat/ssp.h
>> rename to include/linux/pxa2xx_ssp.h
>> index 21c12ca..84465d4 100644
>> --- a/arch/arm/plat-pxa/include/plat/ssp.h
>> +++ b/include/linux/pxa2xx_ssp.h
> Is there any reason to rename ssp.h?

Yup. It ends up in a global include/linux folder so just ssp may get
confused with something else. I didn't move it into the spi folder because
it isn't really spi and it is also used by the sound driver.

Sebastian

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
