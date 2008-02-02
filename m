From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 2.6.24 3/6] spi_bfin: wait for tx	to
	complete on some cs_chg paths
Date: Sat, 02 Feb 2008 14:20:45 +0800
Message-ID: <1201933245.6978.5.camel@roc-laptop>
References: <200801311219.11238.david-b@pacbell.net>
	<20080131132631.91075a19.akpm@linux-foundation.org>
	<200801311353.34281.david-b@pacbell.net>
Reply-To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801311353.34281.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Thu, 2008-01-31 at 13:53 -0800, David Brownell wrote:
> On Thursday 31 January 2008, Andrew Morton wrote:
> > On Thu, 31 Jan 2008 12:19:11 -0800
> > David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > 
> > > +		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
> > > +			cpu_relax();
> > 
> > I'd suggest that this commonly-occurring code sequence be implemented in a
> > standalone function.
> 
> The bitmask to check can be a parameter too, as well as the
> termination result after the mask.  That will allow other loops
> to get properly limited too -- e.g. wait till RXS or TXS clears,
> not just SPIF getting set.
> 

Before SPIF getting set, we do wait for RXS or TXS clears in the code,
right?

> 
> > That'll probably produce less code and you can also 
> > add a timeout+printk+BUG (or whatever) to that function, rather than just
> > mysteriously locking up if something goes wrong.

I will pull out these things to a generic standalone function later.

Thanks a lot
-Bryan


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
