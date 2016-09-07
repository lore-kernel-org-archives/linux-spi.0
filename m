From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: Default thresholds to PXA
 configuration
Date: Wed, 07 Sep 2016 14:39:42 +0300
Message-ID: <1473248382.11323.43.camel@linux.intel.com>
References: <20160907011133.56465-1-andriy.shevchenko@linux.intel.com>
         <1da79ff4-b6e1-ff96-d2a2-8db0f43318d6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1da79ff4-b6e1-ff96-d2a2-8db0f43318d6-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2016-09-07 at 10:13 +0300, Jarkko Nikula wrote:
> On 09/07/2016 04:11 AM, Andy Shevchenko wrote:
> > 
> > Most of the devices in the supported list have PXA configuration of
> > FIFO. In
> > particularly Intel Merrifield has bigger FIFO, than it's defined for
> > CE4100.
> > 
> > Split CE4100 in the similar way how it was done for Intel Quark,
> > i.e. prefix
> > definitions by CE4100 and append necessary pieces of code to switch
> > case
> > conditions.
> > 
> > Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> > - convert SSCR1_CHANGE_MASK as well
> > 
> >  drivers/spi/spi-pxa2xx.c   | 47
> > +++++++++++++++++++++++++++++++++++++++++-----
> >  include/linux/pxa2xx_ssp.h | 20 ++++++++------------
> >  2 files changed, 50 insertions(+), 17 deletions(-)
> > 
> ...
> > 
> > -#ifdef CONFIG_ARCH_PXA
> >  #define RX_THRESH_DFLT	8
> >  #define TX_THRESH_DFLT	8
> > 
> Does this removal and
> 
> > 
> > 
> these actually break other x86 platforms than CE4100 since
> thresholds, 
> SSSR and SSCR1 definitions are different between PXA and others?

I will resend with extended commit message to clarify this question.
TL;DR: it doesn't.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
