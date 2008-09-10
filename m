From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Patch 0/1] spi: Fix pxa2xx_spi.c transfer
	delay, cs change, transfer length
Date: Wed, 10 Sep 2008 14:28:27 -0700
Message-ID: <200809101428.28237.david-b@pacbell.net>
References: <48BFEBF7.1080902@whoi.edu>
	<200809081644.26081.david-b@pacbell.net>
	<48C82D85.1020101@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48C82D85.1020101-/d+BM93fTQY@public.gmane.org>
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

> > I enclose a slightly cleaned-up version.  Comments, checkpath.pl,
> > and so on.  Could you eyeball make sure it still behaves?
> > 
> > Also, this is too much for one patch.  The transfer_delay and
> > cs_change stuff (fixing bugs #1-4) are plausibly one patch.
> > And the DMA stuff (#5-6) is plausibly a different patch.
> > 
> > Could you split those two out?  Then I'll submit them.
> 
> I'm working on it, (emergencies yesterday, sorry), but I have questions...

Stuff happens.  :)

 
> >> Also, the patch should be directed at the stable maintainers for
> >> addition to any kernel as far back as 2.6.20. I'm not sure how to do
> >> direct that, but I expect that you do.
> > 
> > One just cc's stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org ... I don't think the stable
> > team maintains anything that old though.  I cc'd Eric (at Marvell)
> > who is probably worth keeping in the loop in terms of PXA fixes.
> > The PXA platform is now getting an overhaul to help make the
> > PXA3xx changes work better ... yay!
> 
> Am I right to assume that you could/should/would make that cc: after you
> add your Acked-by:

Yeah, but I don't think that particular order matters much.


> > p.s. Eric, it seems the pxa2xx_spi driver is in need of more
> >      active maintaining than it's got.  I seem to have a few
> >      other patches for it in my mailbox too...
> 
> As some of you know, but perhaps not Eric, I am creating a driver that
> is a major expansion of pxa2xx_spi.c, so I am trying to stay involved
> with pxa2xx_spi.c development to limit structural changes that might
> make my work more difficult.  This may be a fool's errand, because my
> changes are so significant that they likely never will be accepted into
> the driver. 

At one point we had discussed having something like an SSP/DMA engine
driver, on top of which could live various protcols ... SPI, maybe I2S
for Alsa-SOC (if AC97 isn't appropriate), data capture/streaming stuff
(which ISTR was more your interest) ... like that?
 

> > There are some additional issues when GPIOs aren't being used as
> > chipselects.  Probably the SSFRM support should be removed, and
> > the GPIO support switched over to use standard GPIO calls (and to
> > support SPI_CS_HIGH).
> 
> I accept your other changes to my patch notes, but I disagree that the
> above paragraph is related to this patch.  I will leave it out unless
> you strongly object.

OK.


> Note that the driver does not specifically do anything to support using
> SSPFRM as chip select.  The documentation says that if no cs_control
> routine is specified, then the driver assumes use of SSPFRM, but really
> it does nothing.  The real assumption is that the user knows what's
> right, and has either hooked up (and is happy with) SSPFRM, or is using
> a (single) chip that doesn't care.
> 
> Possibly a change to Documentation/spi/pxa2xx should be made to
> highlight the ways in which use of SSPFRM differs from use of a GPIO.
> Maybe I will take a shot at that with this patch.

Separate, please.  I'll repost the relevant patch from Vernon ... that
seems like it should become a part of that.

 
> > +		/* see if the next and current messages point
> > +		 * to the same chip
> > +		 */
> > +		if (next_msg && next_msg->spi != msg->spi)
> > +			next_msg = NULL;
> 
> You have changed this from:
> 		if (next_msg)
> 			if (next_msg->spi != msg->spi)
> 				next_msg = NULL;
> 
> My understanding is that C does not guarantee the order of evaluation in
> a compound conditional.  If "next_msg->spi != msg->spi" is evaluated
> before "next_msg" a segmentation fault may occur.  Am I out of date on this?

For "A && B", it's guaranteed that A runs before B;
both values are evaluated as nonzero/true vs zero/false.

For "X & Y" it isn't ... but those values are bit masks
not simple true/false, so they're not usually equivalent.

C has worked that way forever.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
