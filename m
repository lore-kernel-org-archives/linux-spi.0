From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 3/4] MMC core learns
	about SPI
Date: Thu, 2 Aug 2007 14:54:45 +0200
Message-ID: <20070802145445.1118d1e7@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200707261458.55558.david-b@pacbell.net>
	<20070801170220.3c5ccff6@poseidon.drzeus.cx>
	<200708011002.28801.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708011002.28801.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 1 Aug 2007 10:02:28 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> On Wednesday 01 August 2007, Pierre Ossman wrote:
> > 
> > Well, it's rather straight-forward if you think about it. As they've
> > changed the addressing scheme,
> 
> Since I've not seen the MMC4 spec, I couldn't know.  :)
> 

You can see the same thing in SD with the if cond thingy.

> And the nearest approximation of MMC4 I've got (an early Samsung
> spec) says CMD58 has argument "none" (== 0) ... while one of the
> cards I've got rejected CMD58 before CMD1.  So "straightforward"
> is not a word I could apply here...
> 

We can just code it so that failure is acceptable for that initial
CMD58.

> 
> > but retain the original commands, a host 
> > that does not understand the new scheme would utterly destroy the
> > data. So the card refuses to init unless the host can present some
> > evidence that it understands the new scheme.
> 
> Right, but that doesn't answer my question:  whether the card
> is specified to lock up "forever", or whether (as I'd expect)
> reinitialization (starting with reset) works the normal way.
> 

Like SDHC, it never goes out of idle mode.

> 
> My current setup uses a breadboard, so it can hook up to the
> real SPI hardware ... I started out using bitbanged SPI to a
> card which normally muxed to a "native" controller.  Maybe
> one of those could work for you.
> 

Well, I'd need something to do the banging.

> 
> > Please add a comment that we know that MMC 4.2 is broken and can be
> > fixed once someone is able to test.
> 
> Doesn't the general disclaimer that MMC4 cards haven't been
> tested already cover that part?  If you like, just tweak the
> patch comments to clarify.
> 

The disclaimer is in the commit message. And people rarely go digging
into the history for documentation.

I'll add the comment before committing.

> 
> So, move the param and mmc_spi_set_crc() into core.c then, and
> leave the calls where they are?
> 

mmc_spi_set_crc() fits quite nicely into mmc_ops.c, so no need for
moving that. I was thinking more along the lines of:

extern int mmc_spi_crc_enabled;

mmc_spi_set_crc(host, mmc_spi_crc_enabled);

> Can we do that as a separate patch?  You said below we can proceed,
> which suggests to me that now's the time to convert to incrmentals.
> I don't mind a few more update patches, but it'd be easier to do
> them against say a git-mmc patch against 2.6.23-rc2 ...
> 

Sure.

> > 
> > I hate this part of the spec. The SD spec also claims:
> > 
> > "Clear condition B: Always related to the previous command"
> > 
> > But in the SPI section, they back out of that claim. So for SPI,
> > things seems somewhat sane.
> 
> I don't have either of those specs.  "Previous command" isn't
> particularly clear, though maybe in context it could be ... it
> might mean the immediately preceding command, or the one before
> that, depending on usage.
> 

That's from the public SD physical spec. And the wording doesn't get
much clearer. Sometimes they also talk about the "last" command, which
is equally ambiguous.

Rgds
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
