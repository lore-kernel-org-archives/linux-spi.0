From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 19:25:20 +0100
Message-ID: <2156.91258567876$1228242446@news.gmane.org>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200811202010.30845.david-b@pacbell.net>
	<1228231118.9867.108.camel@gentoo-jocke.transmode.se>
	<200812021017.11880.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812021017.11880.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: sv
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
> Sent: den 2 december 2008 19:17
> To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
> Cc: 'Peter Korsgaard'; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [spi-devel-general] Performance of spi_mpc83xx.c sucks.
> =

> On Tuesday 02 December 2008, Joakim Tjernlund wrote:
> > > > The question is if the poll code I sent is good, even for longer tr=
ansfers?
> > > > Perhaps some sort of LOWLAT flag could be used for transfers that r=
eally need them?
> > >
> > > So long as you do the polling with IRQs enabled, I'd keep it simple a=
nd
> > > just always poll. =A0YMMV of course, but most devices seem to prefer =
more
> > > like 10 MHz clocks than 1 MHz ones.
> >
> > Sorry for the delay, forgot about this.
> >
> > Won't polling for long periods starve user space?
> =

> If your system is that I/O bound, use DMA ... :)

:), I wish I had the time to do such a driver.

> =

> > How to overcome this?
> > Why use a kernel thread(mpc83xx_spi.0) to do the work?
> > Would it not be better if the polling was in process context?
> =

> Using a kernel thread, like the not-so-well-named bitbang
> utilities will do for you, *does* ensure the polling is
> done in a process context.  If it's interruptible, as I
> suggested, it should also be pre-emptible ... so if its
> activity (polling) gets to be serious overhead, some other
> task can be scheduled.

Oh, so the kernel thread actually gets pre-empted(is that a word?)
once it has consumed its "time slice"? Do I need to turn on
pre-empt support in the kernel for this?

     Jocke


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
