From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Thu, 2 Aug 2007 15:06:15 +0200
Message-ID: <20070802150615.36e073c6@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200707261632.37011.david-b@pacbell.net>
	<20070801171217.1478267b@poseidon.drzeus.cx>
	<200708011117.24664.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708011117.24664.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 1 Aug 2007 11:17:24 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> On Wednesday 01 August 2007, Pierre Ossman wrote:
> > 
> > I'm more concerned with where you check this, rather than how. If
> > you want to apply it broadly, the request handling functions in
> > core.c would seem more sane.
> 
> That's not how any other host controller driver works though...
> 

Other controllers don't care at all about status bits. Except for omap,
which caused it to break in fun and interesting ways.

> I'm concerned with not becoming a guinea pig for experimenting
> with deep MMC stack changes which are not directly related to
> the SPI support.
> 

You're the one who started poking the error handling bear ;)

But we can ignore it for now.

> > > After all, if you really wanted to provide raw protocol
> > > data to the mmc core, cmd->resp[] would be bytes, not
> > > 32-bit words in cpu-order.
> > > 
> > 
> > It should, as that's how it's used everywhere. And I'd gladly
> > accept a patch that fixes this.
> 
> Erm, I don't follow.  It *is* used as 32-bit words
> everywhere I've had occasion to check.
> 

The only place it is used as that is when checking status bits (in the
app cmd handling). In all other places it is treated as a data buffer.
Just look at the UNSTUFF_BITS macro in mmc.c and sd.c.

> > 
> > From my point of view, it's all data. :)
> 
> Which of your points of view, though?  Clearly at some
> point the MMC stack recognizes the different semantics
> associated with for example OCR vs the command response
> codes.  Data isn't necessarily opaque ... 
>  

Right. I'm talking about the layer the host driver handles. There things
should be:

<header> <payload> <tail>

> > 
> > I have committed that to -mm now. Could I bother you with an update
> > of your patch to remove all MMC_ERR_ stuff? :)
> 
> You mean, git-mmc.patch from 2.6.23-rc1-mm2 which I see has
> just come out?
> 

Unfortunately I have little insight into Andrew's schedule for
producing new -mm. I push stuff to my "for-andrew" branch and he
eventually pulls from that.

> It really would have been easier all around if you had made
> those changes *after* merging at least the core parts of the
> SPI support.  It looks like most of the SPI patches won't even
> apply any more, so I'm "gifted" with a needless quantity of
> make-work.  The kind of stuff I've been trying to avoid by
> submitting the SPI stuff *before* any of those newer patches
> which jumped ahead of it in the queue ... :(
> 

I don't see how it would have been easier. The only difference is that
I'd get a merge problem when I applied the new stuff. So the difference
is really whose lap it would have fallen in.

I can fix your patches if you'd like, but you'd probably have better
insight into selecting relevant error codes now that the entire errno
is available.

> 
> That will be a trivial incremental patch.  You are aware
> that almost all DMA mapping calls in the kernel don't check
> for errors, right?  Because the ability to return errors is
> quite new ... and last I checked, not even documented.
> 

Somehow, that doesn't make me feel any better.

> > > More significant are the two FIXMEs related to card reset.
> > > One will require someone with relevant hardware (Jan?),
> > > the other still needs investigation.
> > > 
> > 
> > Ok.
> 
> I can't see those getting investigated before these patches
> merge.
> 

Sure, that's fine.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
