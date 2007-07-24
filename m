From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Tue, 24 Jul 2007 14:23:53 +0400
Message-ID: <20070724102353.GA8399@localhost.localdomain>
References: <200707141504.51950.david-b@pacbell.net>
	<200707191328.18846.david-b@pacbell.net>
	<20070723142923.GA28979@localhost.localdomain>
	<200707231033.31717.david-b@pacbell.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200707231033.31717.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Mon, Jul 23, 2007 at 10:33:31AM -0700, David Brownell wrote:
> On Monday 23 July 2007, Anton Vorontsov wrote:
> > On Thu, Jul 19, 2007 at 01:28:17PM -0700, David Brownell wrote:
> 
> > > I notice that driver disregards the cs_change instructions in the
> > > messages ... I could imagine how that could make a big difference.
> 
> For example, the extra flapping on the chipselect changes timings...
> 
> 
> > > If that hardware were doing the right thing, then it would work
> > > reliably!  Since it's not reliable, it's doing something wrong.
> > > You seem to think it's not a hardware issue; that may be true.
> > > 
> > > Recall that the first dozen or so commands worked just fine.  The
> > > issue was that some byte that should have been all-ones or 0xfe
> > > reported instead an 0xf8.  That's not the kind of error that can
> > > be explained by clock skew; it covers at least two bits.
> > 
> > Yup, I've either noticed that 0xf8 and 0xfe differs by only two
> > bits (and by three if comparing to 0xff). But I can't really
> > explain it yet.
> 
> See if fixing the cs_change handling -- so that chipselect never
> goes inactive except between MMC requests -- helps. 

Okay.. I've looked into cs_change for spi_mpc83xx, and it seems
bitbang framework (which is used by spi_mpc83xx driver) handle
cs_change by itself.

At least bitbang_work() doing very similar things done by other
drivers not using bitbang library.

> Minimally,
> you'll notice that mode 0 adds extra delays (albeit only 1/2 clock)
> before the clock starts toggling; and that deslecting cards
> except between requests or while the card issues BUSY, falls into
> the "undefined behavior" category.  So while that might not be
> able to trigger certain perversions, dropping a few clocks in
> some odd cases would not seem to violate the spec...
> 
> - Dave

Thanks,

-- 
Anton Vorontsov
email: cbou-JGs/UdohzUI@public.gmane.org
backup email: ya-cbou-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
