From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: fix hang due to missed
	interrupt
Date: Fri, 1 Aug 2008 15:49:31 +0200
Message-ID: <20080801154931.120632f1@hskinnemo-gx745.norway.atmel.com>
References: <1217524213-4027-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Lars Steubesand <lars.steubesand-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
To: Gerard Kam <gerardk5-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1217524213-4027-1-git-send-email-haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
>  		spi_writel(as, RNCR, 0);
>  		spi_writel(as, TNCR, 0);
> +		ieval = SPI_BIT(RXBUFF) | SPI_BIT(ENDRX) | SPI_BIT(OVRES);

Actually, I think the real bug happens right here: Writing RNCR to 0
will clear any pending ENDRX interrupt, so if the transfer is completed
before this, we won't see any interrupt. These writes are also
completely pointless -- RNCR is zeroed automatically after it gets
shifted into RCR. TNCR works the same way.

The RXBUFF interrupt is only cleared by writing a nonzero RCR or RNCR,
so your patch should fix it. But I'm wondering if there may be another
race left to fix: If we queue two transfers, and both of them complete
before we handle the interrupt, I think we only consider one of them to
be complete. If RXBUFF is set, we should complete any "next" transfer
we have queued up as well.

It could be your patch fixes this last case too -- when this happens,
RXBUFF stays set when we return from the interrupt handler, so the
interrupt gets retriggered immediately. We could handle this more
efficiently, but I think it's handled correctly with your patch applied.

I'll see if I can find a way to clean up the somewhat headache-inducing
control flow in this driver, but until then, your patch should
definitely improve things.

As for the overruns, I'm beginning to suspect that the only way to get
rid of those and still maintain a reasonable transfer rate is to use
bounce buffers in faster RAM (e.g. on-chip SRAM).

Haavard

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
