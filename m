From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: Problems with suspend/resume of pxa2xx_spi
Date: Fri, 29 Feb 2008 10:02:51 +1100
Message-ID: <33e9dd1c0802281502x3d045a03pcb6282a781ac4e56@mail.gmail.com>
References: <33e9dd1c0802201932v6873415bm9202ad478f192b7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <33e9dd1c0802201932v6873415bm9202ad478f192b7f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

On Thu, Feb 21, 2008 at 2:32 PM, Zik Saleeba <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org> wrote:
> I've been having some more problems with my SPI application on the
>  PXA270. When I suspend the system it all goes into suspend mode
>  correctly but when it comes back on resume any call to the pxa2xx_spi
>  code just hangs.

I've looked into this problem a bit more. It looks like suspend/resume
can never have worked on the pxa2xx spi subsystem.

One problem I've found is that after suspend the SSP registers don't
come back in their previous state. They need to be saved and restored.
I've added in some code to do that and it means that at least the
system doesn't hang as soon as spi is accessed during a resume. It
does however still hang at some later point. I'm still tracking that
one down.

I found that saving and restoring SSCR0, SSCR1, SSITR, SST0 (for
pxa270) and SSPSP was enough to bring the system back to life again.

Would more experienced people like to comment on whether I'm on the
right track here?

Cheers,
Zik

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
