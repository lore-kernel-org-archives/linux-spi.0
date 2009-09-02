From: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
Subject: Re: [patch 2.6.31-rc7] spi: Freescale STMP
	driver
Date: Wed, 02 Sep 2009 19:56:04 +0400
Message-ID: <1251906964.30703.3.camel@hp>
References: <200908271847.43226.david-b@pacbell.net>
	<20090901135112.58f50b30.akpm@linux-foundation.org>
	<200909020847.18907.david-b@pacbell.net>
Reply-To: dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200909020847.18907.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2009-09-02 at 08:47 -0700, David Brownell wrote:
> On Tuesday 01 September 2009, Andrew Morton wrote:
> > > +#define busy_wait(cond)                                                      \
> > > +     ({                                                              \
> > > +     unsigned long end_jiffies = jiffies + STMP_SPI_TIMEOUT;         \
> > > +     bool succeeded = false;                                         \
> > > +     do {                                                            \
> > > +             if (cond) {                                             \
> > > +                     succeeded = true;                               \
> > > +                     break;                                          \
> > > +             }                                                       \
> > > +             cpu_relax();                                            \
> > > +     } while (time_before(end_jiffies, jiffies));                    \
> > > +     succeeded;                                                      \
> > > +     })
> > 
> > Oh dear.
> 
> Bothered me a bit too, but ... compared to <linux/wait.h> and
> all the wait_event_*() macros, I couldn't object much.  :)
Yes, you've found the root of this ugly stuff :)



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
