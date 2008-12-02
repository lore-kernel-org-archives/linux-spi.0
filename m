From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 12:46:27 -0800
Message-ID: <200812021246.27884.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200812021031.26711.david-b@pacbell.net>
	<041201c954af$f32ad3d0$d9807b70$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <041201c954af$f32ad3d0$d9807b70$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
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
> > =

> > I've not observed polling from a task context to starve anyone,
> > when done sanely. =A0The opposite is true for doing an order of
> > magnitude more instructions in IRQ context ...
> =

> When playing with this the app developer complained that the system didn't
> behave as expected so I guessed it had to do with starvation. Perhaps
> lowering the prio or something would be a wise thing to do? Or is the thr=
ead
> already at lower prio than normal userspace processes?

If you're only guessing about what's going on, you need to go
back and get solid data.  What does "as expected" mean?  Some
app developers have silly expectations.  If you were "playing"
the issue could more easily have been goofs in your code.


> I guess you are not keen on a LOWLAT option for SPI transfers?

Again, you're guessing in absence of facts ... including a
concrete proposal for what a "LOWLAT option" would be here,
and how it would relate to that one developer's possibly
unrealistic expectations in the context of a collection of
experimental kernel hacks vs. using a saner implementation
of the I/O loops to start with.

 =

> We a app that needs to do protection

What is "do protection"?


> (in its own RT pthread) so any SPI =

> transfers should be performed as quickly as possible when the protection
> thread is running, for the rest speed it doesn't matter.

You're free to impose whatever queuing discipline you like
so long as it's FIFO as observed by each spi_device driver.

I would not advise trying to have spi_master.transfer()
methods infer anything about the call context, though.
Such methods are fragile, and are frowned upon in Linux.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
