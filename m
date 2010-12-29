From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 8/9] spi/pxa2xx: Modify RX-Tresh instead of busy-loop
	for the remaining RX bytes.
Date: Wed, 29 Dec 2010 01:12:01 -0700
Message-ID: <20101229081201.GU8172@angua.secretlab.ca>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
	<1291312057-7933-9-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291312057-7933-9-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 02, 2010 at 06:47:36PM +0100, Sebastian Andrzej Siewior wrote:
> After all TX bytes are sent, the driver spins while the SPI core is busy
> and then it spins for a "short" period of time until RX bytes are
> available.
> On Sodavile the busy flag disappears pretty quick and after that it
> takes approx ~130ms (sometimes less but not much) until there are bytes
> available in the RX FIFO.
> This patch removes the busy loop and modifies the RX threshould so we
> get woken up once the remainings bytes arrived.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

picked up for -next via merge

g.

> ---
>  drivers/spi/pxa2xx_spi.c |   56 ++++++++++++++++++++++++++++++++--------------
>  1 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index a54685b..9ca6454 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -660,13 +660,25 @@ static irqreturn_t dma_transfer(struct driver_data *drv_data)
>  	return IRQ_NONE;
>  }
>  
> +static void reset_sccr1(struct driver_data *drv_data)
> +{
> +	void __iomem *reg = drv_data->ioaddr;
> +	struct chip_data *chip = drv_data->cur_chip;
> +	u32 sccr1_reg;
> +
> +	sccr1_reg = read_SSCR1(reg) & ~drv_data->int_cr1;
> +	sccr1_reg &= ~SSCR1_RFT;
> +	sccr1_reg |= chip->threshold;
> +	write_SSCR1(sccr1_reg, reg);
> +}
> +
>  static void int_error_stop(struct driver_data *drv_data, const char* msg)
>  {
>  	void __iomem *reg = drv_data->ioaddr;
>  
>  	/* Stop and reset SSP */
>  	write_SSSR_CS(drv_data, drv_data->clear_sr);
> -	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
> +	reset_sccr1(drv_data);
>  	if (!pxa25x_ssp_comp(drv_data))
>  		write_SSTO(0, reg);
>  	flush(drv_data);
> @@ -684,7 +696,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
>  
>  	/* Stop SSP */
>  	write_SSSR_CS(drv_data, drv_data->clear_sr);
> -	write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
> +	reset_sccr1(drv_data);
>  	if (!pxa25x_ssp_comp(drv_data))
>  		write_SSTO(0, reg);
>  
> @@ -739,24 +751,34 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
>  	}
>  
>  	if (drv_data->tx == drv_data->tx_end) {
> -		write_SSCR1(read_SSCR1(reg) & ~SSCR1_TIE, reg);
> -		/* PXA25x_SSP has no timeout, read trailing bytes */
> +		u32 bytes_left;
> +		u32 sccr1_reg;
> +
> +		sccr1_reg = read_SSCR1(reg);
> +		sccr1_reg &= ~SSCR1_TIE;
> +
> +		/*
> +		 * PXA25x_SSP has no timeout, set up rx threshould for the
> +		 * remaing RX bytes.
> +		 */
>  		if (pxa25x_ssp_comp(drv_data)) {
> -			if (!wait_ssp_rx_stall(reg))
> -			{
> -				int_error_stop(drv_data, "interrupt_transfer: "
> -						"rx stall failed");
> -				return IRQ_HANDLED;
> -			}
> -			if (!drv_data->read(drv_data))
> -			{
> -				int_error_stop(drv_data,
> -						"interrupt_transfer: "
> -						"trailing byte read failed");
> -				return IRQ_HANDLED;
> +
> +			sccr1_reg &= ~SSCR1_RFT;
> +
> +			bytes_left = drv_data->rx_end - drv_data->rx;
> +			switch (drv_data->n_bytes) {
> +			case 4:
> +				bytes_left >>= 1;
> +			case 2:
> +				bytes_left >>= 1;
>  			}
> -			int_transfer_complete(drv_data);
> +
> +			if (bytes_left > RX_THRESH_DFLT)
> +				bytes_left = RX_THRESH_DFLT;
> +
> +			sccr1_reg |= SSCR1_RxTresh(bytes_left);
>  		}
> +		write_SSCR1(sccr1_reg, reg);
>  	}
>  
>  	/* We did something */
> -- 
> 1.7.3.2
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
