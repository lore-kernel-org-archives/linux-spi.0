From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
	core learns about SPI
Date: Sat, 27 Oct 2007 09:33:29 -0700
Message-ID: <200710270933.30538.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<471DAB71.8000808@gmail.com>
	<20071027140823.5d7ec7e2@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071027140823.5d7ec7e2-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
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

On Saturday 27 October 2007, Pierre Ossman wrote:
> > > Is this really a problem that plagues you, or just something you
> > > noticed in the code? 
> > 
> > It is that we need to suspend as soon as possible because of power loss.
> > Waiting to flush all the caches does not help, because there will not be
> > enough time with backup power. So it's better not to start any new block
> > requests to safe as much backup power as possible and to avoid
> > interrupted block transfer.
> 
> Ah, that is a very good point. Could I bother you with having a look at how
> other parts of the kernel does things? 

That'll be interesting to know ... but I think the "panic suspend"
should probably have different code paths than "normal suspend".

In the normal case, there's no power shortage *just now* and the
safest shutdown sequence is appropriate.  Notably, all removable
media should have I/O be fully flushed, and the filesystem made
consistent.  And on resume, the filesystem should NOT be assumed
to be in the same state it was on suspend.

In the panic case, like this, power may not be available, and the
prayer is that some can be found before too long.

>From earlier discussions elsewhere, I think neither of those cases
is handled all that well.  If anything, there's an assumption that
suspend is never done in a panic ... but that there's no need to
make the filesystem fully consistent/clean since media aren't
removable.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
