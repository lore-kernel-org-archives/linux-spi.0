From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
 delay, cs change, transfer length
Date: Wed, 10 Sep 2008 17:47:33 -0400
Message-ID: <48C84075.9070000@whoi.edu>
References: <48BFEBF7.1080902@whoi.edu>
	<200809081644.26081.david-b@pacbell.net>
	<48C82D85.1020101@whoi.edu>
	<200809101428.28237.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809101428.28237.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
>> As some of you know, but perhaps not Eric, I am creating a driver that
>> is a major expansion of pxa2xx_spi.c, so I am trying to stay involved
>> with pxa2xx_spi.c development to limit structural changes that might
>> make my work more difficult.  This may be a fool's errand, because my
>> changes are so significant that they likely never will be accepted into
>> the driver. 
> 
> At one point we had discussed having something like an SSP/DMA engine
> driver, on top of which could live various protcols ... SPI, maybe I2S
> for Alsa-SOC (if AC97 isn't appropriate), data capture/streaming stuff
> (which ISTR was more your interest) ... like that?

I have a very narrow view at that moment, and my understanding of the
kernel is especially narrow.  I don't know enough about what you are
suggesting to offer an opinion.  It might work out.  Yes, streaming data
is my interest.

>> Possibly a change to Documentation/spi/pxa2xx should be made to
>> highlight the ways in which use of SSPFRM differs from use of a GPIO.
>> Maybe I will take a shot at that with this patch.
> 
> Separate, please.  I'll repost the relevant patch from Vernon ... that
> seems like it should become a part of that.

Interesting.  OK.  Vernon slipped a note or two about DMA length,
related to one of the two patches you will get today, so maybe his would
work for the SSPFRM issue, too.

> For "A && B", it's guaranteed that A runs before B;
> both values are evaluated as nonzero/true vs zero/false.
> 
> C has worked that way forever.

Hmmm... OK.  I guess I have spent the last 28yrs trying to avoid
reliance on that for naught. :-)

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
