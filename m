From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 10:17:11 -0800
Message-ID: <200812021017.11880.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200811202010.30845.david-b@pacbell.net>
	<1228231118.9867.108.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1228231118.9867.108.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
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
> > > The question is if the poll code I sent is good, even for longer tran=
sfers?
> > > Perhaps some sort of LOWLAT flag could be used for transfers that rea=
lly need them?
> > =

> > So long as you do the polling with IRQs enabled, I'd keep it simple and
> > just always poll. =A0YMMV of course, but most devices seem to prefer mo=
re
> > like 10 MHz clocks than 1 MHz ones.
> =

> Sorry for the delay, forgot about this.
> =

> Won't polling for long periods starve user space?

If your system is that I/O bound, use DMA ... :)

> How to overcome this? =

> Why use a kernel thread(mpc83xx_spi.0) to do the work?
> Would it not be better if the polling was in process context?

Using a kernel thread, like the not-so-well-named bitbang
utilities will do for you, *does* ensure the polling is
done in a process context.  If it's interruptible, as I
suggested, it should also be pre-emptible ... so if its
activity (polling) gets to be serious overhead, some other
task can be scheduled.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
