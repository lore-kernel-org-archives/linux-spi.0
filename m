From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 3/4] MMC-over-SPI core updates
Date: Sat, 16 Jun 2007 14:16:17 -0700
Message-ID: <200706161416.17802.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
	<200706131753.47453.david-b@pacbell.net>
	<4672D474.4060707@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4672D474.4060707-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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

On Friday 15 June 2007, Pierre Ossman wrote:
> David Brownell wrote:
> > 
> > I can move it.  I tried expanding it inline there, and thought
> > the result was worse:  (a) duplication, in both MMC and SD code
> > paths; (b) it complicates otherwise-clean logic; (c) you had
> > asked that the core patch be small.
> > 
> > You're quite sure you want those drawbacks ... ?
> > 
> 
> Fairly. The idea when I did the rewrite was that the initial detection (that
> identifies card type) should be fairly clear and shouldn't require you to dig
> around in other areas.

I figured calling mmc_spi_fixup() would be very clear, and
since it's defined right before the routine using it then
digging would be a non-issue.

But if you want uglified code, I suppose I could do that.  ;)


> >> You also need to fix the check further down as SPI doesn't have a bit indicating
> >> if it toggled into ACMD mode.
> > 
> > Right now this is not needed, since the host records that and hands
> > it back in the R1 status mapping.
> > 
> 
> In other words, lying to the core.

I can't see it that way.  It's just a different way of managing
that status than you currently expect.


> Someone looking at that function will get the 
> impression that the system can verify that the card entered app command mode
> even on spi, even though it can't. Don't try to get the round peg into the
> square hole. Change the hole.

So, get rid of all R1_APP_CMD checks in the MMC stack?
That's what I'll do for now.

I count two of them, and they are both superfluous since
they follow successful completion of MMC_APP_CMD.  The
only way that can succeed is if the card supports APP_CMD
and enters that mode...

(The alternative would be to do the superfluous checks
only for non-SPI hosts, but that'd seem pointless.)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
