From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.27-rc7] pxa2xx_spi buildfix
Date: Tue, 23 Sep 2008 02:01:11 -0700
Message-ID: <20080923020111.d0bd3876.akpm@linux-foundation.org>
References: <200809230056.25075.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809230056.25075.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 23 Sep 2008 00:56:24 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> 
> This patch fixes a build error in the pxa2xx-spi driver,
> introduced by commit 7e96445533ac3f4f7964646a202ff3620602fab4

Please always include the title of the commit as well as it's ID. 
otherwise Linus chucks a wobbly.  I always have to look it up and fill
it in.


> [dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: fix sparse warning too ]
> 
> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Acked-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> for 2.6.27-final, please ...

Please always quote the compiler output when fixing build errors and
warnings.

>  drivers/spi/pxa2xx_spi.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -49,7 +49,7 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>  
>  #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
>  #define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
> -#define IS_DMA_ALIGNED(x)	(((x) & 0x07) == 0)
> +#define IS_DMA_ALIGNED(x)	((((u32)(x)) & 0x07) == 0)
>  #define MAX_DMA_LEN		8191

I assume we were passing this a pointer?

include/linux/kernel.h has ALIGN and PTR_ALIGN, and IS_ALIGNED, but no
IS_PTR_ALIGNED.

>  /*
> @@ -896,7 +896,7 @@ static void pump_transfers(unsigned long
>  				|| transfer->rx_dma || transfer->tx_dma) {
>  			dev_err(&drv_data->pdev->dev,
>  				"pump_transfers: mapped transfer length "
> -				"of %lu is greater than %d\n",
> +				"of %u is greater than %d\n",
>  				transfer->len, MAX_DMA_LEN);
>  			message->status = -EINVAL;
>  			giveback(drv_data);

OK, that one's pretty obvious.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
