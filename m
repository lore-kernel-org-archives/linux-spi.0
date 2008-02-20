From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c chip
	select sequence error
Date: Wed, 20 Feb 2008 14:48:45 -0800
Message-ID: <200802201448.46106.david-b@pacbell.net>
References: <47B90B11.6000601@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	merrij3-IL7dBOYR4Vg@public.gmane.org, Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47B90B11.6000601-/d+BM93fTQY@public.gmane.org>
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


> David: 
> 
> Is there a defined procedure for distributing patches the can be
> applied to different kernel versions, when they won't apply directly?

A couple of them.  One is to just cc the "stable" list,
possibly with a note about merge issues.  Another is to
leave the issue up to other folk who support back-rev
kernels, which isn't quite as useful.

> 
> David:
> 
> Can I assume that you or someone up the chain will go through the
> motions of applying this patch to 2.6.25 and showing that it compiles?
> I really don't expect any trouble with that.

Yes.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
