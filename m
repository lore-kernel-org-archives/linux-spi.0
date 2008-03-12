From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Wed, 12 Mar 2008 14:01:18 -0800
Message-ID: <200803121501.19131.david-b@pacbell.net>
References: <47C42D50.7020204@rubico.se>
	<200802272155.29706.david-b@pacbell.net> <47C66D8A.3010904@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	Hans Eklund <hans-9ai+6vhHfRGzQB+pC5nmwQ@public.gmane.org>, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pwilshire-j9pdmedNgrk@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47C66D8A.3010904-j9pdmedNgrk@public.gmane.org>
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

On Thursday 28 February 2008, Phil Wilshire wrote:
> I agree, I did have some concerns about the callback issue.
> It also looks like we have enough people + momentum on this problem to
> get a fix in good time. So I'll wait to see what happens.

Actually, I'm not sure I'd agree on that.  Folk want a fix,
but nobody (including me!) has sent something that's quite
mergeable yet.

I think part of the solution may be what someone (Brian?)
observed:  that growing the mid-layer to handle some of the
queue management functions should help, no matter what
eventual solution is adopted.

That might be as little as providing a default "add to queue"
and "take from queue" mechanism and starting to phase it into
use in the various master controller drivers.  When they use
that scheme, it should be easy to splice in alternative queue
management policies (notably:  "only spi_mmc can access the
bus for now") without changing the controller drivers.

So it'd be really nice if someone could come up with a patch
like that to help get some forward motion ... unless there's
a better suggestion for how to move forward?

- Dave



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
