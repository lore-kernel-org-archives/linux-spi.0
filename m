From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: SPI chip select semantics (was: [PATCH RFT] spi: mpc512x-psc:
 Refactor to use core message parsing)
Date: Mon, 31 Mar 2014 09:34:23 +0200
Message-ID: <20140331073423.GD2775@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

[ breaking the thread by removing the In-Reply-To: ]

On Sun, 2014-03-30 at 00:30 +0000, Mark Brown wrote:
> 
> On Sat, Mar 29, 2014 at 04:09:10PM +0100, Gerhard Sittig wrote:
> 
> > The core implements the loop over the transfers of a message
> > (spi_transfer_one_message() routine).  The logic is
> > - unconditionally assert CS at the start of a message
> > - invert(?) CS between transfers if the transfer's cs_change
> >   property is set
> > - deassert CS at the end of the message _if_ transmission was
> >   successful _and_ the caller did not ask to keep CS asserted
> >   (when the last transfer's cs_change is set)
> > Is my interpretation of the implementation correct?  Then I'd
> > expect "undocumented features" in the current implementation.
> 
> That's what it's intended to do, yes (and what a bunch of drivers were
> doing).

Turns out I was wrong.  CS gets deasserted if the caller
requested it (did not request to keep it asserted) _or_ if
transmission failed.  CS only remains asserted if the caller
wanted it, _and_ transmission succeeded.

This is what the implementation does, and what the documentation
suggests.  So it's good.  I just wanted to correct my wrong
interpretation of the code, should somebody look at archives.

> > Does it mean that with cs_change set, subsequent transfers will
> > run with CS deasserted?  I thought this property would "pulse"
> > the CS, i.e. release and re-assert the signal.  The spi.h kernel
> > doc suggests so: "(i) If the transfer isn't the last one in the
> > message, this flag is used to make the chipselect briefly go
> > inactive in the middle of the message."  An approach to adjust
> > the core's implementation might be to move the set_cs(true) into
> > the transfer loop, and to set_cs(false) between transfers if
> > cs_change is set.  Or do the set_cs(false) set_cs(true) sequence
> > in the if() arm depending on how the cost might be perceived.
> 
> Right, that's what the documentation says and what the bitbang driver
> does so we should probably update the code to reflect that.

I saw your patch, and it looks good (introduces the correct
deassertion of CS instead of the current inversion).

> > And I was not aware of the effect on the message's end, that one
> > could leave CS asserted.  The spi.h comment reads "(ii) When the
> > transfer is the last one in the message, the chip may stay
> > selected until the next transfer.", which fits the
> > implementation.  Then it continues "... this is just a
> > performance hint; starting a message to another device deselects
> > this one.", which might assume a specific hardware implementation
> > and need not apply to all setups in general.  I assume that the
> > documentation is more permissive or suggests more than the
> > subsystem can enforce.
> 
> Well, the thing is that for hardware that can't control /CS from
> software so anything using it between transfers can't rely on it
> happening at all.  Within a transfer you can always paper this over
> since there's full visibility of what's going to happen but that's
> not possible over transfers.

What I meant was that even those setups which do control CS from
software might not be able to "late deassert" a previously kept
CS signal upon new selection of another slave.  Think of an array
of GPIO backed CS signals, asserting one of them won't change the
others' current signal.

The documentation might assume the specific behaviour of an
individual controller or CS decoding approach that just does not
apply in general.  It's not a problem in the implementation, but
the documentation might need to get extended to become less
permissive.  I prepared something along these lines (yet to get
sent).

> > And I would like to ask whether determining how CS needs to be
> > set at the end of a transfer can be done before the transfer_one
> > callback gets invoked.  In the specific MPC512x PSC case, the
> > appropriate control is done _during_ transmission.  The injection
> > of the MPC512x_PSC_FIFO_EOF txcmd code before feeding more data
> > into the TX FIFO will make CS go inactive as the data is drained
> > (gets sent over the wire).  So the set_cs() after the transfer's
> > completion may be late, won't work and/or will disturb other
> > communication in the case of PSC internal SS lines.  Other
> > hardware may have similar constraints.  Those who need not handle
> > CS during transmission already can ignore the information during
> > transfer_one(), and use the regular set_cs() invocation.
> 
> It could be I guess, though to be honest I've never been convinced that
> supporting set_cs on the final transfer is a sane idea in the first
> place - my guess is that it's actually going to cost more on average to
> implement it (what with remembering to deassert if another device is
> selected and so on) than just unconditionally disabling /CS.

The early decision of what CS should be after the transfer is not
specific to the last transfer and to keeping CS asserted after
the complete message.  It applies to any transfer within a
message that might want to deassert CS.  So it applies to those
intermediate transfers which want to pulse CS, as well as to the
last transfer in the regular case of deasserting CS after the
message.

The point is that to deassert CS after the data transfer, some
controllers have to take action _during_ their transmission of TX
data.  The Freescale PSC is one of those controllers when CS
lines are involved that are internal to the PSC (i.e. anything
that is not GPIO).  And it's another case where CS cannot get
deasserted "late".

> > I might have prepared and sent patches, but wanted to verify that
> > the issues are present, and how best to address them.  Feel free
> > to tell me if this discussion should have its own thread, to not
> > end up in the review comments of a patch (although it's RFT).
> 
> Another thread would've been helpful - I was reading it thinking it was
> going to explain the poor performance!

In the MUA you will see that the performance and the CS semantics
are two separate subthreads that both are spawned from the patch
which switches MPC512x to the common message transmission
routine.  I broke the thread for you, to not have the CS
semantics discussion for the SPI core within the MPC512x patch
feedback in trackers.  Hope it helps.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
