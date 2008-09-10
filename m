From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
 delay, cs change, transfer length
Date: Wed, 10 Sep 2008 16:26:45 -0400
Message-ID: <48C82D85.1020101@whoi.edu>
References: <48BFEBF7.1080902@whoi.edu>
	<200809081644.26081.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809081644.26081.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> On Thursday 04 September 2008, Ned Forrester wrote:
>> I think enough time has elapsed for any objections to surface.  Is there
>> still time to push this patch for 2.6.27? 
> 
> I enclose a slightly cleaned-up version.  Comments, checkpath.pl,
> and so on.  Could you eyeball make sure it still behaves?
> 
> Also, this is too much for one patch.  The transfer_delay and
> cs_change stuff (fixing bugs #1-4) are plausibly one patch.
> And the DMA stuff (#5-6) is plausibly a different patch.
> 
> Could you split those two out?  Then I'll submit them.

I'm working on it, (emergencies yesterday, sorry), but I have questions...

>> Also, the patch should be directed at the stable maintainers for
>> addition to any kernel as far back as 2.6.20. I'm not sure how to do
>> direct that, but I expect that you do.
> 
> One just cc's stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org ... I don't think the stable
> team maintains anything that old though.  I cc'd Eric (at Marvell)
> who is probably worth keeping in the loop in terms of PXA fixes.
> The PXA platform is now getting an overhaul to help make the
> PXA3xx changes work better ... yay!

Am I right to assume that you could/should/would make that cc: after you
add your Acked-by:

I don't expect that they would go back as far as 2.6.20, though
individuals could do so if they are still using old kernels.  I would
expect the stable maintainers to apply this as far back as they choose.

> p.s. Eric, it seems the pxa2xx_spi driver is in need of more
>      active maintaining than it's got.  I seem to have a few
>      other patches for it in my mailbox too...

As some of you know, but perhaps not Eric, I am creating a driver that
is a major expansion of pxa2xx_spi.c, so I am trying to stay involved
with pxa2xx_spi.c development to limit structural changes that might
make my work more difficult.  This may be a fool's errand, because my
changes are so significant that they likely never will be accepted into
the driver.  I think I have preserved all the existing functionality,
while adding the ability to operate in various formats, and as a slave
(limited to a single chip on the bus with a predictable transfer
pattern) at the maximum bus speed of 13Mbit/sec.  This driver is finally
working, as of last month, but is a wreck in terms of coding style, so
it is not ready for consideration.

More about that some other time.  I just thought it might be useful to
state my intentions and reason for interest.

> ========= CUT HERE
> From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
> 

[snip]

> There are some additional issues when GPIOs aren't being used as
> chipselects.  Probably the SSFRM support should be removed, and
> the GPIO support switched over to use standard GPIO calls (and to
> support SPI_CS_HIGH).

I accept your other changes to my patch notes, but I disagree that the
above paragraph is related to this patch.  I will leave it out unless
you strongly object.

Note that the driver does not specifically do anything to support using
SSPFRM as chip select.  The documentation says that if no cs_control
routine is specified, then the driver assumes use of SSPFRM, but really
it does nothing.  The real assumption is that the user knows what's
right, and has either hooked up (and is happy with) SSPFRM, or is using
a (single) chip that doesn't care.

Possibly a change to Documentation/spi/pxa2xx should be made to
highlight the ways in which use of SSPFRM differs from use of a GPIO.
Maybe I will take a shot at that with this patch.

> Signed-off-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
> Cc: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> # NYET-Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
>  drivers/spi/pxa2xx_spi.c |  116 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 91 insertions(+), 25 deletions(-)
> 
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -47,9 +47,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>  
>  #define MAX_BUSES 3
>  
> -#define DMA_INT_MASK (DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
> -#define RESET_DMA_CHANNEL (DCSR_NODESC | DMA_INT_MASK)
> -#define IS_DMA_ALIGNED(x) (((u32)(x)&0x07)==0)
> +#define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
> +#define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK
> +#define IS_DMA_ALIGNED(x)	(((x) & 0x07) == 0)

You are asking to change unrelated things here, but I will not object.
I don't know if there are any consequences to dropping the u32 cast;
that was in Stephen's earliest version, and I have not messed with those
things.

> +		/* see if the next and current messages point
> +		 * to the same chip
> +		 */
> +		if (next_msg && next_msg->spi != msg->spi)
> +			next_msg = NULL;

You have changed this from:
		if (next_msg)
			if (next_msg->spi != msg->spi)
				next_msg = NULL;

My understanding is that C does not guarantee the order of evaluation in
a compound conditional.  If "next_msg->spi != msg->spi" is evaluated
before "next_msg" a segmentation fault may occur.  Am I out of date on this?

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
