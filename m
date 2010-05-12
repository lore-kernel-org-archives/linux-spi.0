From: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi_mpc8xxx.c: fix potential
	memory corruption.
Date: Wed, 12 May 2010 20:22:31 +0400
Message-ID: <20100512162231.GA449@oksana.dev.rtsoft.ru>
References: <1273679450-4185-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1273679450-4185-1-git-send-email-Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 12, 2010 at 05:50:50PM +0200, Joakim Tjernlund wrote:
> tx_dma/rx_dma are already set to a dummy buffer when no
> tx/rx buffer and t->tx_dma/t->rx_dma does not contain a dma
> address, but NULL.
> This may lead to corruption of kernel memory. Fix this by
> leaving tx_dma/rx_dma alone.
> 
> Do not INIT_TX_RX while controller is enabled, this is bad according
> to the MPC8321 manual.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>

Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks!

> ---
>  drivers/spi/spi_mpc8xxx.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index e1d8045..c312d0e 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -240,7 +240,6 @@ static void mpc8xxx_spi_change_mode(struct spi_device *spi)
>  
>  	/* Turn off SPI unit prior changing mode */
>  	mpc8xxx_spi_write_reg(mode, cs->hw_mode & ~SPMODE_ENABLE);
> -	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
>  
>  	/* When in CPM mode, we need to reinit tx and rx. */
>  	if (mspi->flags & SPI_CPM_MODE) {
> @@ -257,7 +256,7 @@ static void mpc8xxx_spi_change_mode(struct spi_device *spi)
>  			}
>  		}
>  	}
> -
> +	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
>  	local_irq_restore(flags);
>  }
>  
> @@ -437,7 +436,7 @@ static int mpc8xxx_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
>  			dev_err(dev, "unable to map tx dma\n");
>  			return -ENOMEM;
>  		}
> -	} else {
> +	} else if (t->tx_buf) {
>  		mspi->tx_dma = t->tx_dma;
>  	}
>  
> @@ -448,7 +447,7 @@ static int mpc8xxx_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
>  			dev_err(dev, "unable to map rx dma\n");
>  			goto err_rx_dma;
>  		}
> -	} else {
> +	} else if (t->rx_buf) {
>  		mspi->rx_dma = t->rx_dma;
>  	}
>  
> -- 
> 1.6.4.4

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

------------------------------------------------------------------------------
