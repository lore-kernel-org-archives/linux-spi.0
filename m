From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Thu, 2 Aug 2007 13:34:49 -0700
Message-ID: <200708021334.50670.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200708011117.24664.david-b@pacbell.net>
	<20070802150615.36e073c6@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070802150615.36e073c6-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
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

On Thursday 02 August 2007, Pierre Ossman wrote:
> On Wed, 1 Aug 2007 11:17:24 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > On Wednesday 01 August 2007, Pierre Ossman wrote:
> > > 
> > > I'm more concerned with where you check this, rather than how. If
> > > you want to apply it broadly, the request handling functions in
> > > core.c would seem more sane.
> > 
> > That's not how any other host controller driver works though...
> > 
> 
> Other controllers don't care at all about status bits.

Maybe not, but they *do* report failures.  And in this case
there's no other way to report failures ... since SPI doesn't
have any integral error checks whatsoever.  The only way to
detect errors is to look at those bits after each transaction.

(Without hardware feedback, you can't even tell if there's a
device present on any given chipselect.  The SPI host can
fling bits out, and read back pulled-up/down bits in any
quantity, without error.)


> Except for omap, 
> which caused it to break in fun and interesting ways.

I think the only time I touched that code was to teach it
how to do SD ... 4wire support, writeprotect sensing, and
funky block sizes.

The intended design of an MMC/SD host driver has never
been all that clear.  It's becoming more clear with your
recent work ... but it's not there yet, and there aren't
even test scripts or suites for de-facto requirements
(and to facilitate regression testing).


> > I'm concerned with not becoming a guinea pig for experimenting
> > with deep MMC stack changes which are not directly related to
> > the SPI support.
> > 
> 
> You're the one who started poking the error handling bear ;)

Was I?  Didn't think so.  How was I to know that whiteboard
scribbles would animate themselves?  :)


> But we can ignore it for now.
> 
> > > > After all, if you really wanted to provide raw protocol
> > > > data to the mmc core, cmd->resp[] would be bytes, not
> > > > 32-bit words in cpu-order.
> > > > 
> > > 
> > > It should, as that's how it's used everywhere. And I'd gladly
> > > accept a patch that fixes this.
> > 
> > Erm, I don't follow.  It *is* used as 32-bit words
> > everywhere I've had occasion to check.
> > 
> 
> The only place it is used as that is when checking status bits (in the
> app cmd handling). In all other places it is treated as a data buffer.
> Just look at the UNSTUFF_BITS macro in mmc.c and sd.c.

And it all but ignores those status bits too, which seems kind
of problematic.  (Relies on controller hardware to mirror protocol
faults by hardware faults of some kind...)  But I see what you
mean about UNSTUFF_BITS.


> > > From my point of view, it's all data. :)
> > 
> > Which of your points of view, though?  Clearly at some
> > point the MMC stack recognizes the different semantics
> > associated with for example OCR vs the command response
> > codes.  Data isn't necessarily opaque ... 
> >  
> 
> Right. I'm talking about the layer the host driver handles. There things
> should be:
> 
> <header> <payload> <tail>

Fault handling being orthogonal to that.  And at this time,
like it or (clearly!) not, the mmc core does virtually no
fault checking ... it relies on reports from host drivers.

You're probably on to something with the notion that the
I/O wrappers should check the status codes.  But that's
a substantial change from how the stack has worked, ever
since it was written.


> > > I have committed that to -mm now. Could I bother you with an update
> > > of your patch to remove all MMC_ERR_ stuff? :)
> > 
> > You mean, git-mmc.patch from 2.6.23-rc1-mm2 which I see has
> > just come out?
> > 
> 
> Unfortunately I have little insight into Andrew's schedule for
> producing new -mm. I push stuff to my "for-andrew" branch and he
> eventually pulls from that.

That's no problem.


> > It really would have been easier all around if you had made
> > those changes *after* merging at least the core parts of the
> > SPI support.  It looks like most of the SPI patches won't even
> > apply any more, so I'm "gifted" with a needless quantity of
> > make-work.  The kind of stuff I've been trying to avoid by
> > submitting the SPI stuff *before* any of those newer patches
> > which jumped ahead of it in the queue ... :(
> > 
> 
> I don't see how it would have been easier. The only difference is that
> I'd get a merge problem when I applied the new stuff. So the difference
> is really whose lap it would have fallen in.

Not exactly ... you'd have been developing that new stuff against
current GIT, which would already have had some of those patches,
so there wouldn't even *be* a merge problem for that stuff.


> I can fix your patches if you'd like, but you'd probably have better
> insight into selecting relevant error codes now that the entire errno
> is available.

Patches #1 and #2 were easy fixes; about 2/3 of #3 is rejected,
and I've not yet looked at the details ... that's all the core
changes, which haven't previously cared about much more than
success-or-fault.  #4 should be easy to cope with.


> > That will be a trivial incremental patch.  You are aware
> > that almost all DMA mapping calls in the kernel don't check
> > for errors, right?  Because the ability to return errors is
> > quite new ... and last I checked, not even documented.
> > 
> 
> Somehow, that doesn't make me feel any better.

It's just an indication of how seldom DMA mapping errors
have ever made problems.

 
> > > > More significant are the two FIXMEs related to card reset.
> > > > One will require someone with relevant hardware (Jan?),
> > > > the other still needs investigation.
> > > > 
> > > 
> > > Ok.
> > 
> > I can't see those getting investigated before these patches
> > merge.
> > 
> 
> Sure, that's fine.
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
