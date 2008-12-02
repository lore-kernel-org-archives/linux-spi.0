From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 11:10:52 -0800
Message-ID: <200812021110.52964.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<200812021017.11880.david-b@pacbell.net>
	<040601c954ab$554cff20$ffe6fd60$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <040601c954ab$554cff20$ffe6fd60$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
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
> Oh, so the kernel thread actually gets pre-empted(is that a word?)
> once it has consumed its "time slice"?

And potentially at other times.  When an IRQ arrives and
is handled, that's a form of non-task preemption.  And
when that IRQ enables a higher-priority task, the lower
priority one can be preempted in a more usual manner.


> Do I need to turn on 
> pre-empt support in the kernel for this?

To get some kinds of preemption, yes.  But it's not
strictly required.

- Dave



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
