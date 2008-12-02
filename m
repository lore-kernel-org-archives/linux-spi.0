From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 23:12:37 +0100
Message-ID: <18192.6707657569$1228291290@news.gmane.org>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200812021031.26711.david-b@pacbell.net>
	<041201c954af$f32ad3d0$d9807b70$@Tjernlund@transmode.se>
	<200812021246.27884.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200812021246.27884.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> Sent: den 2 december 2008 21:46
> To: Joakim Tjernlund
> Cc: 'Peter Korsgaard'; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [spi-devel-general] Performance of spi_mpc83xx.c sucks.
> =

> On Tuesday 02 December 2008, Joakim Tjernlund wrote:
> > >
> > > I've not observed polling from a task context to starve anyone,
> > > when done sanely. =A0The opposite is true for doing an order of
> > > magnitude more instructions in IRQ context ...
> >
> > When playing with this the app developer complained that the system did=
n't
> > behave as expected so I guessed it had to do with starvation. Perhaps
> > lowering the prio or something would be a wise thing to do? Or is the t=
hread
> > already at lower prio than normal userspace processes?
> =

> If you're only guessing about what's going on, you need to go
> back and get solid data.  What does "as expected" mean?  Some
> app developers have silly expectations.  If you were "playing"
> the issue could more easily have been goofs in your code.

yeah, I know I need to investigate this further. I just want
to put the "starving" issue out of my mind. I feel a bit
uneasy about the busy wait nature of polling for potentially long
periods of time and that might slow down the rest of the system.

he, I just remembered that one of the complaints was that the SPI thread
started to consume a lot of CPU when it was polling :)

>
> > I guess you are not keen on a LOWLAT option for SPI transfers?
> =

> Again, you're guessing in absence of facts ... including a
> concrete proposal for what a "LOWLAT option" would be here,
> and how it would relate to that one developer's possibly
> unrealistic expectations in the context of a collection of
> experimental kernel hacks vs. using a saner implementation
> of the I/O loops to start with.

Here I was thinking LOWLAT as a per transaction flag that would mean that t=
he driver
should try to complete the transactions as fast as possible. In my case tha=
t would mean
polling instead of IRQ driven.
I don't have a complete suggestion, just want to test the idea first.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
