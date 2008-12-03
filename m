From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Wed, 3 Dec 2008 00:56:16 -0800
Message-ID: <200812030056.17010.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200812021246.27884.david-b@pacbell.net>
	<041e01c954cb$15c0f030$4142d090$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <041e01c954cb$15c0f030$4142d090$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
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

> > If you're only guessing about what's going on, you need to go
> > back and get solid data. =A0What does "as expected" mean? =A0Some
> > app developers have silly expectations. =A0If you were "playing"
> > the issue could more easily have been goofs in your code.
> =

> yeah, I know I need to investigate this further. I just want
> to put the "starving" issue out of my mind.

You won't be able to do that without solid data.  You're
still just speculating.


> I feel a bit =

> uneasy about the busy wait nature of polling for potentially long
> periods of time and that might slow down the rest of the system.

Yet $SUBJECT is about suckage with IRQ-driven transfers, slowing
down the system.  There is a common thread ...

A first-principles analysis would help.  What SPI clock rate is
involved, and how big are the data transfers?  It should be easy
to come up with a per-word instruction count ceiling for polling,
and compare that to the IRQ overhead.

Then remember that unless you've got DMA, you're stuck with some
CPU costs here.  So the question is only how/when you incur them:
in bursts giving adequate SPI throughput, or spread out over time
giving objectionably low throughput?


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
