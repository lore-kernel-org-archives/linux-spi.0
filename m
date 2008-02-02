From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24 3/6] spi_bfin: wait for tx to
	complete on some cs_chg paths
Date: Fri, 1 Feb 2008 22:59:35 -0800
Message-ID: <200802012259.35878.david-b@pacbell.net>
References: <200801311219.11238.david-b@pacbell.net>
	<200801311353.34281.david-b@pacbell.net>
	<1201933245.6978.5.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1201933245.6978.5.camel@roc-laptop>
Content-Disposition: inline
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

On Friday 01 February 2008, Bryan Wu wrote:
> =

> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0while (!(read_STAT(drv_data) & BIT_STAT=
_SPIF))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cpu_relax();
> > > =

> > > I'd suggest that this commonly-occurring code sequence be implemented=
 in a
> > > standalone function.
> > =

> > The bitmask to check can be a parameter too, as well as the
> > termination result after the mask. =A0That will allow other loops
> > to get properly limited too -- e.g. wait till RXS or TXS clears,
> > not just SPIF getting set.
> > =

> =

> Before SPIF getting set, we do wait for RXS or TXS clears in the code,
> right?

Sure, but it's the same kind of loop-forever thing.
All "loop-forever" primitives should be replaced by
ones that have some kind of ceiling, since it's far
from unheard-of that hardware glitch.

My observation was that the standalone function
can trivially handle "loop-till-set" as well as
"loop-till-clear".

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
