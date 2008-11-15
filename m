From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI TX andRX buffer overlap
Date: Fri, 14 Nov 2008 20:41:01 -0800
Message-ID: <200811142041.01410.david-b@pacbell.net>
References: <491C87BF.6030905@whoi.edu>
	<200811141541.46799.david-b@pacbell.net>
	<491E47BD.5080005@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <491E47BD.5080005-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 14 November 2008, Ned Forrester wrote:
> David Brownell wrote:
> > Mapping any number of times *should* be OK -- unless one mapping
> > reports an error.  Or you do them in the wrong order (removing
> > cache entries before writing their data out to memory).
> 
> BINGO!  That was it.

Good news!  I haven't lost it yet.  ;)


> pxa2xx_spi has always done 
> 
> dma_map_single(..., rx, ..., DMA_FROM_DEVICE)
> 
> (thus invalidating the cache) before
> 
> dma_map_single(..., tx, ..., DMA_TO_DEVICE)
> 
> (thus copying possibly invalid data, if the buffers overlapped).
> 
> Thanks, it works now with a much more pleasant patch.

Yeah, mostly just swapping two blocks of code.  Much nicer.


> I never looked at 
> it that way before.  A patch will be coming soon.

Worth auditing the other SPI controller drivers too.  That'd
be easy to get wrong.  Hmmm ... au1550 and iMX goof it too,
while atmel_spi and omap2_mcspi get it right.  Wouldn't you
know ... the only DMA capable SPI drivers I used in DMA mode
don't have this problem.  ;)

- Dave
 
 
> -- 
> Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
> Oceanographic Systems Lab                                  508-289-2226
> Applied Ocean Physics and Engineering Dept.
> Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
> http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
> http://www.whoi.edu/hpb/Site.do?id=1532
> http://www.whoi.edu/page.do?pid=10079
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
