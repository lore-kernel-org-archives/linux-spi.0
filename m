From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 10:31:26 -0800
Message-ID: <200812021031.26711.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<87d4gav94h.fsf@macbook.be.48ers.dk>
	<040001c954aa$a00e3930$e02aab90$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <040001c954aa$a00e3930$e02aab90$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 02 December 2008, Joakim Tjernlund wrote:
> =

> > =A0Joakim> Won't polling for long periods starve user space? How to
> > =A0Joakim> overcome this?
> > =

> > I guess it won't be any worse than the processor being overloaded with
> > interrupts - In fact it's better, as there's more real work done.
> =

> It gets the work done faster but will starve everyone else in the process.
> The IRQ version doesn't do that.

I've not observed polling from a task context to starve anyone,
when done sanely.  The opposite is true for doing an order of
magnitude more instructions in IRQ context ...


> > =A0Joakim> Why use a kernel thread(mpc83xx_spi.0) to do the work? =A0Wo=
uld
> > =A0Joakim> it not be better if the polling was in process context?
> > =

> > I guess that's needed for the async stuff.
> =

> hmm, yes that sounds reasonable.

Doesn't sound so to me.  Recall that if you have four chipselects,
the driver using each chip can submit its own request ... *EVERY*
request made to the controller driver is async, entering a queue
and coming out when it's done.


> One could detect if the operation is =

> async or not and use process context if it is synchronous.

No you can't.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
