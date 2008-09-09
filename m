From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
 delay, cs change, transfer length
Date: Mon, 08 Sep 2008 23:11:30 -0400
Message-ID: <48C5E962.5040207@whoi.edu>
References: <48BFEBF7.1080902@whoi.edu>	
	<200809081644.26081.david-b@pacbell.net>
	<f17812d70809081936i588dfad5i9ffa84f69d4e3cd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f17812d70809081936i588dfad5i9ffa84f69d4e3cd7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

Eric Miao wrote:
> Is it possible that the GPIO CS patch merged first before this one?
> And the patch below includes actually multiple changes, which
> makes the merge not so straight-forward.

I guess I don't have the whole picture.  There must be other patches
that support the gpio_ calls.  If you are saying that some of those
patches have already merged, or are farther up the chain, then I guess I
should accommodate that.

> Ned, I think you have reviewed my patch, and will it be convenient
> for you to update this one against mine? I have a lot of other stuffs
> depending on that, so it will be appreciated if you do. Thanks.

Not convenient, but possible.  That would prevent the patch from
applying to earlier kernels.  Because the patch fixes operational bugs,
I think porting is important.  Of course, the original patch can be
offered to stable, and a new one submitted to the current kernel.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
