From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [PATCH 3/3] mmc: change .get_ro() callback
	semantics
Date: Thu, 5 Jun 2008 17:58:59 +0200
Message-ID: <200806051759.00202.marc.pignat@hevs.ch>
References: <20080523154204.GA19803@polina.dev.rtsoft.ru>
	<200806031207.49843.marc.pignat@hevs.ch>
	<20080605144310.GA31596@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080605144310.GA31596-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

On Thursday 05 June 2008, Anton Vorontsov wrote:
> On Tue, Jun 03, 2008 at 12:07:49PM +0200, Marc Pignat wrote:
> > Hi all!
> > 
> > On Friday 23 May 2008, Anton Vorontsov wrote:
> > > get_ro() callback must return values >= 0 for its logical state, and
> > ...
> > >  static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index f2e9885..ef3b773 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -55,6 +55,9 @@ struct mmc_host_ops {
> > >  	 * Avoid calling these three functions too often or in a "fast path",
> > >  	 * since underlaying controller might implement them in an expensive
> > >  	 * and/or slow way.
> > > +	 *
> > > +	 * .get_ro and .get_cd should return >= 0 for their logical values,
> > > +	 * or negative errno value in case of error.
> > >  	 */
> > 
> > I would suggest to use something more strict (bulletproof), something like:
> > 
> > /*
> >  * get_ro will return:
> >  *   0 for a read/write card
> >  *   1 for a read-only card 
> 
> This isn't always practical. For example, host is using u8 register for
> the status, so it might safely return u8 & mask, that will always fit
> into int. Or very smart/adventurous authors might be aware that, for the
> particular host, mask's bit isn't last, and safely do uXX & mask. :-)
> 
> The above is weak argument of course, since it is about optimization.

Ack, we will gain at most 1-4 assembly instructions, in a function that
is unlikely to be called more than once a second.

> 
> As an counter-evidence, the strict scheme that you described probably
> less error prone. But is it? To implement it we'll need something like
> WARN_ON(ret > 0 && ret != 1) to catch erroneous users. Take a closer
> look though, will it catch uXX & lastbit case? Nope. :-)

WARN_ON(ret > 0 && ret != 1 || ret == INT_MIN) will do ;)

I agree with you once more, I never thinked about a runtime check.

I don't really want to see a WARN_ON(foo) after each call to get_ro or get_cd.

But I'm sure if we specify "give me a positive value when a card is detected",
someone will write gpio & bit, and three years later, someone will fall in
the (gpio & lastbit < 0 case).

So we should specify: "give me 1 whan a card is present, 0 when not, -ENOSYS if
you don't know and a negative errno when something else goes wrong".




Best regards

Marc





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
