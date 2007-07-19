From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Thu, 19 Jul 2007 13:28:17 -0700
Message-ID: <200707191328.18846.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200707181027.17819.david-b@pacbell.net>
	<20070719161553.GA15756@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070719161553.GA15756-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Thursday 19 July 2007, Anton Vorontsov wrote:
> > =

> > Thanks. =A0In that case, I'm thinking there *IS* a bug of some kind
> > in the controller driver Anton is using, else mode 3 would work
> > for him like it (evidently) works for everyone else.
> =

> I've checked with MPC8323E reference manual, and according to it
> spi_mpc83xx is doing right thing.

I notice that driver disregards the cs_change instructions in the
messages ... I could imagine how that could make a big difference.

If that hardware were doing the right thing, then it would work
reliably!  Since it's not reliable, it's doing something wrong.
You seem to think it's not a hardware issue; that may be true.

Recall that the first dozen or so commands worked just fine.  The
issue was that some byte that should have been all-ones or 0xfe
reported instead an 0xf8.  That's not the kind of error that can
be explained by clock skew; it covers at least two bits.


> > I'll see about making time to see if mode 0 works for me too; but
> > even if it does, I'd prefer to leave the driver the way it is now
> > instead of changing it to cover up for that mpc83xx bug ... plus,
> > I just like CPHA=3D1 modes better because they don't need to start
> > with that strange half-clock. =A0;)
> =

> Well. As Pierre Ossman told, it should work at any mode.

Well, either mode 0 or mode 3.  And since it doesn't work in both
modes, clearly something in your test system is buggy.


> That also =

> proves that it's not mpc83xx's bug (because even if it would be a
> bug, and spi_mpc83xx having inversed values, it's still should work).

No way could it "prove" that!!

How could it ever be possible that your system not work in mode 3, and
yet that not be a bug in your test system???

The only thing "proven" is that the mmc_spi code is basically correct;
otherwise neither clock mode could cause the right data transfers.
(And otherewise other folk wouldn't have seen it work...)

The problem is in a lower level ... maybe the SPI controller driver,
or the silicon, or the board wiring.


> So, it's likely depends on spi controller, maybe some timing issues
> or signal shapes, which distracts SD/MMC... Not sure.

What does your oscilloscope show is going on when this error triggers?

Right now I'd most suspect the lack of cs_change support in that
controller driver.


> But then, may I ask for "alt_mode" (bool) platform data variable?

Well, as already said:  (a) we know mode 3 is required to work,
(b) we know that on your test system it doesn't, so accordingly
(c) we know there's a bug in your test system.

The only reason to add such a flag would be to paper over that bug.

The idea with bugs is to *FIX* them, not paper them over so they'll
never get fixed.  Especially if you've got a lab setup with even
basic hardware debug tools, like your oscilloscope, which make it
so easy to verify that the right signals are going down the wires.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
