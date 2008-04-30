From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 29 Apr 2008 17:08:09 -0700
Message-ID: <200804291708.09424.david-b@pacbell.net>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<1CF6EDDF0820924DA43C9A52FE7325950A89DA47@MI8NYCMAIL17.Mi8.com>
	<20080424140541.773f6e6b@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080424140541.773f6e6b-OhHrUh4vRMSnewYJFaQfwJ5kstrrjoWp@public.gmane.org>
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

On Thursday 24 April 2008, Pierre Ossman wrote:
> On Tue, 15 Apr 2008 15:26:54 -0400
> "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
> =

> > I do get the IRQ on every card insertion and removal. Actually if I boot
> > the system with the card removed I end up getting a:
> > =

> > mmc0: error -22 whilst initialising SDIO card  =

> =

> This is a bit odd. It shouldn't have gone down that route unless it is
> sure it's an SDIO card it is dealing with.

I've seen that in the past, I forget why.  It may have been the
problem with cards that didn't like to respond to certain requests
while they're resetting ... the problem which ensures that I must
always use the appended patch, since you didn't want to merge it.


> > If I then insert the card I get the IRQ and:
> > =

> > mmc0: new MMC card on SPI
> > mmcblk0: mmc0:0001 SDM064 62720KiB
> > =A0mmcblk0: p1 p2 p3 p4
> > =

> > So it appears the initial card detect does work. But for some reason
> > it's not seeing the removal of the card or the insertion of a new card.
> > =

> > Any ideas?  =

> =

> Without debugging info it's impossible to tell if it's the driver or
> the core that's doing something wrong. Have you checked that
> interrupts keep coming?  =


I have a patch I've been playing with that should help make the card
detect debounce work better.  I'll send it along in a bit.  Not sure
it's properly cooked yet.  I *do* still observe delays in detection
of the removal ... sometimes adding up to "not detected"; and when
those delays appear, similar delays in detecting newly inserted cards.
Removing then re-inserting seems to help at that point.


> David, I don't suppose you've checked if you can reproduce this?

I tried with a few cards; nope, no such problems observed.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
