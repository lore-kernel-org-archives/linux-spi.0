From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Thu, 20 Nov 2008 20:10:30 -0800
Message-ID: <200811202010.30845.david-b@pacbell.net>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<877i81rf2g.fsf@macbook.be.48ers.dk>
	<002f01c933ab$4bee9180$e3cbb480$@Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>,
	"'Peter Korsgaard'" <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <002f01c933ab$4bee9180$e3cbb480$@Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
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

On Tuesday 21 October 2008, Joakim Tjernlund wrote:
> 
> > Maybe it indeed makes more sense to use polling for high bitrates.
> 
> The cpu can't keep up at ~10MHz for me, but even at much small Hz
> the poll is significantly faster, the IRQ overhead seems huge or is it 
> something else?

I'd guess IRQ-per-word is a bad design policy ... If you assume 10 MHz
SPI clock, and (keeping math simple) a 10-bit word, then a polling loop
of 1 MHz -- 1 usec/loop -- is needed to keep up.

Regardless of latency, per-IRQ overheads (save context, call handler,
do its work, return, restore) are not always below 1 usec...


> The question is if the poll code I sent is good, even for longer transfers?
> Perhaps some sort of LOWLAT flag could be used for transfers that really need them?

So long as you do the polling with IRQs enabled, I'd keep it simple and
just always poll.  YMMV of course, but most devices seem to prefer more
like 10 MHz clocks than 1 MHz ones.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
