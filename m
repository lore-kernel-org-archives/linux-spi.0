From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: Do not use
 map_tx_dma to unmap rx_dma
Date: Mon, 17 May 2010 17:22:54 +0400
Message-ID: <20100517132254.GA6567@oksana.dev.rtsoft.ru>
References: <1274102230-20828-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1274102230-20828-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 17, 2010 at 03:17:10PM +0200, Joakim Tjernlund wrote:
> This fixes a typo were map_tx_dma is used instead of
> map_rx_dma, casing the driver to unmap rx_dma when it
> shouldn't.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>

Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks!

> ---
>  drivers/spi/spi_mpc8xxx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index c85dbbb..2d54020 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -514,7 +514,7 @@ static void mpc8xxx_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
>  
>  	if (mspi->map_tx_dma)
>  		dma_unmap_single(dev, mspi->tx_dma, t->len, DMA_TO_DEVICE);
> -	if (mspi->map_tx_dma)
> +	if (mspi->map_rx_dma)
>  		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
>  	mspi->xfer_in_progress = NULL;
>  }
> -- 
> 1.6.4.4

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

------------------------------------------------------------------------------
