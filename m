From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Wed, 1 Aug 2007 11:17:24 -0700
Message-ID: <200708011117.24664.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200707261632.37011.david-b@pacbell.net>
	<20070801171217.1478267b@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070801171217.1478267b-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
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

On Wednesday 01 August 2007, Pierre Ossman wrote:
> On Thu, 26 Jul 2007 16:32:36 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > 
> > You said you weren't going to update the MMC core to check
> > the status bits after every request, and I'm certainly not
> > about to change *EVERY MMC/SD REQUEST* to adopt a radically
> > different callling convention either!!
> > 
> > Which leaves us needing a solution that actually works, and
> > this seems to be the only option:  continue to use the current
> > calling convention, ->error fields report the failures.
> > 
> 
> I'm more concerned with where you check this, rather than how. If you
> want to apply it broadly, the request handling functions in core.c
> would seem more sane.

That's not how any other host controller driver works though...

I'm concerned with not becoming a guinea pig for experimenting
with deep MMC stack changes which are not directly related to
the SPI support.


> > However, that bit looks deeply messy.  You'd be splitting
> > the OCR (and other SPI four byte responses) into two
> > different words, for example!
> > 
> > Or to put it differently, this way the structure that's
> > passed up to the core is actually meaningful:  one word
> > of status, and maybe another word of data.  And *never*
> > any mixed status/data words that'd need disentangling.
> > 
> > After all, if you really wanted to provide raw protocol
> > data to the mmc core, cmd->resp[] would be bytes, not
> > 32-bit words in cpu-order.
> > 
> 
> It should, as that's how it's used everywhere. And I'd gladly accept a
> patch that fixes this.

Erm, I don't follow.  It *is* used as 32-bit words
everywhere I've had occasion to check.


> > I guess we'll have to disagree on this for now.  If it
> > matters, it can be changed later; but I certainly couldn't
> > call mixing data and status as an improvement!! 
> > 
> 
> From my point of view, it's all data. :)

Which of your points of view, though?  Clearly at some
point the MMC stack recognizes the different semantics
associated with for example OCR vs the command response
codes.  Data isn't necessarily opaque ... 
 

> > The data block CRC is quite expensive, yes.  The CRC7 isn't;
> > and in any case, you had pretty much demanded that it always
> > be computed (to eliminate the #define for the crc needed in
> > the card reset command) ...
> > 
> 
> Ah, didn't think of that distinction. Carry on.
> 
> > > 
> > > At least we agree on error codes. This is precisely the change
> > > I have pending in my patch set to remove the MMC_ERR_* mess. :) 
> > 
> > I had to pick something.  ;)
> > 
> 
> I have committed that to -mm now. Could I bother you with an update of
> your patch to remove all MMC_ERR_ stuff? :)

You mean, git-mmc.patch from 2.6.23-rc1-mm2 which I see has
just come out?

It really would have been easier all around if you had made
those changes *after* merging at least the core parts of the
SPI support.  It looks like most of the SPI patches won't even
apply any more, so I'm "gifted" with a needless quantity of
make-work.  The kind of stuff I've been trying to avoid by
submitting the SPI stuff *before* any of those newer patches
which jumped ahead of it in the queue ... :(


> > > I'd like to see those REVISIT things attended to before I push
> > > the stuff to Linus though. 
> > 
> > In this driver?  They're mostly performance tuning issues, which
> > are normally best left till later:
> > 
> >   - dma_map_single() operations could theoretically fail.
> >     Not that it'd be likely on hardware that uses this driver;
> >     but that's simple error path cleanup.
> > 
> 
> This is the one I'm mostly concerned with. Dangling error paths give me
> the willies.

That will be a trivial incremental patch.  You are aware
that almost all DMA mapping calls in the kernel don't check
for errors, right?  Because the ability to return errors is
quite new ... and last I checked, not even documented.

So while I'm glad that the DMA API finally changed (I recall
pointing out that gaping hole almost four years ago by now),
this particular issue shouldn't worry much at all.


> > More significant are the two FIXMEs related to card reset.
> > One will require someone with relevant hardware (Jan?),
> > the other still needs investigation.
> > 
> 
> Ok.

I can't see those getting investigated before these patches
merge.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
