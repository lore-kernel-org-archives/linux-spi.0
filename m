From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 19:20:15 +0100
Message-ID: <8178.97760211981$1228242113@news.gmane.org>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>	<877i81rf2g.fsf@macbook.be.48ers.dk>	<002f01c933ab$4bee9180$e3cbb480$@Tjernlund@transmode.se>	<200811202010.30845.david-b@pacbell.net>	<1228231118.9867.108.camel@gentoo-jocke.transmode.se>
	<87d4gav94h.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'Peter Korsgaard'" <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87d4gav94h.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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
> From: Peter Korsgaard [mailto:jacmet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Peter Korsgaard
> Sent: den 2 december 2008 17:24
> To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
> Cc: David Brownell; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [spi-devel-general] Performance of spi_mpc83xx.c sucks.
> 
> >>>>> "Joakim" == Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> writes:
> 
> Hi,
> 
>  >> So long as you do the polling with IRQs enabled, I'd keep it
>  >> simple and just always poll.  YMMV of course, but most devices
>  >> seem to prefer more like 10 MHz clocks than 1 MHz ones.
> 
>  Joakim> Sorry for the delay, forgot about this.
> 
>  Joakim> Won't polling for long periods starve user space? How to
>  Joakim> overcome this?
> 
> I guess it won't be any worse than the processor being overloaded with
> interrupts - In fact it's better, as there's more real work done.

It gets the work done faster but will starve everyone else in the process.
The IRQ version doesn't do that.

> 
>  Joakim> Why use a kernel thread(mpc83xx_spi.0) to do the work?  Would
>  Joakim> it not be better if the polling was in process context?
> 
> I guess that's needed for the async stuff.

hmm, yes that sounds reasonable. One could detect if the operation is
async or not and use process context if it is synchronous.

 Jocke


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
