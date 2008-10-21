From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: Performance of spi_mpc83xx.c sucks.
Date: Tue, 21 Oct 2008 20:31:55 +0200
Message-ID: <38536.6059061655$1224614007@news.gmane.org>
References: <1224605947.14078.17.camel@gentoo-jocke.transmode.se>
	<877i81rf2g.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'spi-devel-general' <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "'Peter Korsgaard'" <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <877i81rf2g.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
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
> Sent: den 21 oktober 2008 20:14
> To: Joakim Tjernlund
> Cc: spi-devel-general
> Subject: Re: [spi-devel-general] Performance of spi_mpc83xx.c sucks.
> 
> >>>>> "Joakim" == Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org> writes:
> 
>  Joakim> We have noticed that the spi_mpc83xx.c driver is very slow, the gap
>  Joakim> between words are huge.
>  Joakim> So I started to optimise it and it still sucks.
>  Joakim> However, if I poll the SPIE_NF SPIE_NE bits instead it works MUCH
>  Joakim> better, like so:
> 
> Yes, I've noticed the same. I get around ~5 times higher throughput
> with a simple polled loop in U-Boot compared to under Linux (66MHz
> clock).
> 
> I've written it of as simply being a question of interrupt overhead
> (at 66MHz / 32bits we're talking over 2 million interrupts per
> second - E.G. only ~100 instructions between each!)
> 
> Maybe it indeed makes more sense to use polling for high bitrates.

The cpu can't keep up at ~10MHz for me, but even at much small Hz
the poll is significantly faster, the IRQ overhead seems huge or is it 
something else?
The question is if the poll code I sent is good, even for longer transfers?
Perhaps some sort of LOWLAT flag could be used for transfers that really need them?

 Jocke 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
