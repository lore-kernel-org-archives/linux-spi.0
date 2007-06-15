From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 3/4] MMC-over-SPI core updates
Date: Fri, 15 Jun 2007 20:03:32 +0200
Message-ID: <4672D474.4060707@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101307.11394.david-b@pacbell.net>
	<466FA700.2080009@drzeus.cx>
	<200706131753.47453.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706131753.47453.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> 
> I can move it.  I tried expanding it inline there, and thought
> the result was worse:  (a) duplication, in both MMC and SD code
> paths; (b) it complicates otherwise-clean logic; (c) you had
> asked that the core patch be small.
> 
> You're quite sure you want those drawbacks ... ?
> 

Fairly. The idea when I did the rewrite was that the initial detection (that
identifies card type) should be fairly clear and shouldn't require you to dig
around in other areas.

As for the patches being small, I guess I wasn't clear. I'd like to see small
patches so that they are easily reviewed, but the total changes can be as large
as needs be. The end results is the most important part, so if you do not see a
way to split up patches then I'll just have to deal with reviewing large ones.

> 
> I just grabbed a new version of  that spec; the original omitted
> absolutely *everything* about SPI.
> 

How evil.

> 
> I think it's the usual reason:  ACMD fails on MMC, so use that early to
> sort out SD-vs-MMC.  The Linux stack might be marginally quicker if that
> were the *ONLY* reason it used ACMD51.
> 

The specs are unclear, especially when comparing old and new ones. We'll just
have to feel our way forward here.

> 
> I observed that some cards didn't like CMD58 (READ_OCR) until after
> the reset was done, although all the specs I have say that it's
> supposed to work while the reset is happening.
> 

That's not good, as high-capacity MMC needs an initial READ_OCR. :/

> 
> The direct translation of the existing code would have needed them
> all as function parameters; ungood to have so many params!
> 

I don't think a temporary structure makes it better. It just makes things less
readable and gives the impression that it's a persistent object.

> 
> Hmm, that may be right.  I was trying to touch that code as
> little as possible ... less to break that way!
> 

Where's your sense of advanture? ;)

> 
> Arg is zero (except in the native send_csd), and two of
> the three commands are not valid down that route in the
> native code.  So I suppose it wouldn't hurt to pass an R1
> response code there, knowing that it will never be used,
> even though the correct code for those is R2.  That sort
> of trick is a bit too ugly for my personal taste; I would
> not have thought of always passing invalid parameters.  ;)
> 

I won't tell anyone if you don't ;)

> 
> There's a difference for SPI?!?  :)
> 
> Actually, the CRC and OCR stuff gets called before a card struct
> is available.  That may be different in the rest of the code.
> 

Right, never mind then.

>> You also need to fix the check further down as SPI doesn't have a bit indicating
>> if it toggled into ACMD mode.
> 
> Right now this is not needed, since the host records that and hands
> it back in the R1 status mapping.
> 

In other words, lying to the core. Someone looking at that function will get the
impression that the system can verify that the card entered app command mode
even on spi, even though it can't. Don't try to get the round peg into the
square hole. Change the hole.

> Other than that status mapping, this is useful to make sure the right
> tracing statements are emitted:  report ACMDx not CMDx.  It makes
> message tracing easier to read.  (This is something the MMC/SD core
> might benefit from, too.  Did I mention I'm glad that it now issues
> the CMDx messages in decimal, matching all docs, not hex?  :)
> 

On my todo list. :)

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
