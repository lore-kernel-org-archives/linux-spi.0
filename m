From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-rc2-git] spidev compiler
	warning gone
Date: Tue, 29 May 2007 15:39:04 -0700
Message-ID: <200705291539.04253.david-b@pacbell.net>
References: <200705251035.10587.david-b@pacbell.net>
	<20070529150214.75204439.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070529150214.75204439.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 29 May 2007, Andrew Morton wrote:
> On Fri, 25 May 2007 10:35:07 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > Get rid of annoying GCC warning on 32-bit platforms.  The trick is to
> > add an extra cast using "ptrdiff_t" to convert the u64 to the correct
> > size integer, and only then casting it into a "void *" pointer.
> > 
> >	...
> > -			if (__copy_to_user((u8 __user *)u_tmp->rx_buf, buf,
> > +			if (__copy_to_user((u8 __user *)
> > +					(ptrdiff_t) u_tmp->rx_buf, buf,
> > 	...
> 
> This seems overly tricky.  The way we normally squish that warning is
> via a (long) cast.

Well, "ptrdiff_t" seems equivalent to "long" in common cases.

Presumably C99 guarantees pointer-to-long conversions work in
both directions?  It seemed there must necessarily be such a
guarantee for "ptrdiff_t", even if it weren't true for "long".
I didn't have a copy of a C spec to consult.  ;)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
