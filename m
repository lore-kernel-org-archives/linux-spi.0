From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 19:58:22 +0100
Message-ID: <5099.64855523339$1228244405@news.gmane.org>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<87d4gav94h.fsf@macbook.be.48ers.dk>
	<040001c954aa$a00e3930$e02aab90$@Tjernlund@transmode.se>
	<200812021031.26711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812021031.26711.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> Sent: den 2 december 2008 19:31
> To: Joakim Tjernlund
> Cc: 'Peter Korsgaard'; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [spi-devel-general] Performance of spi_mpc83xx.c sucks.
> =

> On Tuesday 02 December 2008, Joakim Tjernlund wrote:
> >
> > > =A0Joakim> Won't polling for long periods starve user space? How to
> > > =A0Joakim> overcome this?
> > >
> > > I guess it won't be any worse than the processor being overloaded with
> > > interrupts - In fact it's better, as there's more real work done.
> >
> > It gets the work done faster but will starve everyone else in the proce=
ss.
> > The IRQ version doesn't do that.
> =

> I've not observed polling from a task context to starve anyone,
> when done sanely.  The opposite is true for doing an order of
> magnitude more instructions in IRQ context ...

When playing with this the app developer complained that the system didn't
behave as expected so I guessed it had to do with starvation. Perhaps
lowering the prio or something would be a wise thing to do? Or is the thread
already at lower prio than normal userspace processes?

I guess you are not keen on a LOWLAT option for SPI transfers?

We a app that needs to do protection(in its own RT pthread) so any SPI
transfers should be performed as quickly as possible when the protection
thread is running, for the rest speed it doesn't matter.

> =

> > > =A0Joakim> Why use a kernel thread(mpc83xx_spi.0) to do the work? =A0=
Would
> > > =A0Joakim> it not be better if the polling was in process context?
> > >
> > > I guess that's needed for the async stuff.
> >
> > hmm, yes that sounds reasonable.
> =

> Doesn't sound so to me.  Recall that if you have four chipselects,
> the driver using each chip can submit its own request ... *EVERY*
> request made to the controller driver is async, entering a queue
> and coming out when it's done.

I see, so leave thread alone :)

 Jocke


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
