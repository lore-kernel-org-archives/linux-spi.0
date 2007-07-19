From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Thu, 19 Jul 2007 20:15:53 +0400
Message-ID: <20070719161553.GA15756@localhost.localdomain>
References: <200707141504.51950.david-b@pacbell.net>
	<200707170911.16715.david-b@pacbell.net>
	<20070718164409.56ca0019@poseidon.drzeus.cx>
	<200707181027.17819.david-b@pacbell.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender t <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200707181027.17819.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, Jul 18, 2007 at 10:27:17AM -0700, David Brownell wrote:
> On Wednesday 18 July 2007, Pierre Ossman wrote:
> > On Tue, 17 Jul 2007 09:11:15 -0700
> > David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > 
> > > Ideally, someone with access to full MMC and SD specs can see
> > > what they say about the SPI clocking.  The simplified SD specs
> > > omit the timing diagrams.
> > >  
> > 
> > I can probably help out there.
> > 
> > According to the specs, both mode 0 and mode 3 are valid. The idle
> > polarity simply isn't specified, only that data shall be sampled on
> > rising edge. Hence mode 0 or 3.
> 
> Thanks.  In that case, I'm thinking there *IS* a bug of some kind
> in the controller driver Anton is using, else mode 3 would work
> for him like it (evidently) works for everyone else.

I've checked with MPC8323E reference manual, and according to it
spi_mpc83xx is doing right thing.

> I'll see about making time to see if mode 0 works for me too; but
> even if it does, I'd prefer to leave the driver the way it is now
> instead of changing it to cover up for that mpc83xx bug ... plus,
> I just like CPHA=1 modes better because they don't need to start
> with that strange half-clock.  ;)

Well. As Pierre Ossman told, it should work at any mode. That also
proves that it's not mpc83xx's bug (because even if it would be a
bug, and spi_mpc83xx having inversed values, it's still should work).

So, it's likely depends on spi controller, maybe some timing issues
or signal shapes, which distracts SD/MMC... Not sure.

But then, may I ask for "alt_mode" (bool) platform data variable?

Thanks!

-- 
Anton Vorontsov
email: cbou-JGs/UdohzUI@public.gmane.org
backup email: ya-cbou-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
