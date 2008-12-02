From: "Joakim Tjernlund" <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 2 Dec 2008 16:20:40 +0100
Message-ID: <1228231118.9867.108.camel@gentoo-jocke.transmode.se>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<877i81rf2g.fsf@macbook.be.48ers.dk>
	<002f01c933ab$4bee9180$e3cbb480$@Tjernlund@transmode.se>
	<200811202010.30845.david-b@pacbell.net>
Reply-To: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200811202010.30845.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2008-11-20 at 20:10 -0800, David Brownell wrote:
> On Tuesday 21 October 2008, Joakim Tjernlund wrote:
> > 
> > > Maybe it indeed makes more sense to use polling for high bitrates.
> > 
> > The cpu can't keep up at ~10MHz for me, but even at much small Hz
> > the poll is significantly faster, the IRQ overhead seems huge or is it 
> > something else?
> 
> I'd guess IRQ-per-word is a bad design policy ... If you assume 10 MHz
> SPI clock, and (keeping math simple) a 10-bit word, then a polling loop
> of 1 MHz -- 1 usec/loop -- is needed to keep up.
> 
> Regardless of latency, per-IRQ overheads (save context, call handler,
> do its work, return, restore) are not always below 1 usec...
> 
> 
> > The question is if the poll code I sent is good, even for longer transfers?
> > Perhaps some sort of LOWLAT flag could be used for transfers that really need them?
> 
> So long as you do the polling with IRQs enabled, I'd keep it simple and
> just always poll.  YMMV of course, but most devices seem to prefer more
> like 10 MHz clocks than 1 MHz ones.

Sorry for the delay, forgot about this.

Won't polling for long periods starve user space? How to overcome this?
Why use a kernel thread(mpc83xx_spi.0) to do the work?
Would it not be better if the polling was in process context?

  Jocke  



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
