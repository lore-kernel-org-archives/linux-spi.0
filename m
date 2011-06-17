From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi/bfin_spi: use structs for
	accessing hardware regs
Date: Fri, 17 Jun 2011 08:37:29 -0600
Message-ID: <20110617143729.GB21412@ponder.secretlab.ca>
References: <1308298618-23461-1-git-send-email-vapier@gentoo.org>
	<1308298618-23461-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1308298618-23461-2-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 17, 2011 at 04:16:56AM -0400, Mike Frysinger wrote:
> Rather than hardcoding the register sizes/offsets in this file, use the
> existing struct in the spi header for reading/writing the hardware.
> 
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_bfin5xx.c |  208 ++++++++++++++++++---------------------------
>  1 files changed, 84 insertions(+), 124 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index c491057..8822bcc 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -58,7 +58,7 @@ struct bfin_spi_master_data {
>  	struct spi_master *master;
>  
>  	/* Regs base of SPI controller */
> -	void __iomem *regs_base;
> +	struct bfin_spi_regs __iomem *regs;
>  
>  	/* Pin request list */
>  	u16 *pin_req;
> @@ -122,34 +122,14 @@ struct bfin_spi_slave_data {
>  	const struct bfin_spi_transfer_ops *ops;
>  };
>  
> -#define DEFINE_SPI_REG(reg, off) \
> -static inline u16 read_##reg(struct bfin_spi_master_data *drv_data) \
> -	{ return bfin_read16(drv_data->regs_base + off); } \
> -static inline void write_##reg(struct bfin_spi_master_data *drv_data, u16 v) \
> -	{ bfin_write16(drv_data->regs_base + off, v); }
> -
> -DEFINE_SPI_REG(CTRL, 0x00)
> -DEFINE_SPI_REG(FLAG, 0x04)
> -DEFINE_SPI_REG(STAT, 0x08)
> -DEFINE_SPI_REG(TDBR, 0x0C)
> -DEFINE_SPI_REG(RDBR, 0x10)
> -DEFINE_SPI_REG(BAUD, 0x14)
> -DEFINE_SPI_REG(SHAW, 0x18)
> -
>  static void bfin_spi_enable(struct bfin_spi_master_data *drv_data)
>  {
> -	u16 cr;
> -
> -	cr = read_CTRL(drv_data);
> -	write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
> +	bfin_write_or(&drv_data->regs->ctl, BIT_CTL_ENABLE);
>  }
>  
>  static void bfin_spi_disable(struct bfin_spi_master_data *drv_data)
>  {
> -	u16 cr;
> -
> -	cr = read_CTRL(drv_data);
> -	write_CTRL(drv_data, (cr & (~BIT_CTL_ENABLE)));
> +	bfin_write_and(&drv_data->regs->ctl, ~BIT_CTL_ENABLE);
>  }
>  
>  /* Caculate the SPI_BAUD register value based on input HZ */
> @@ -172,10 +152,10 @@ static int bfin_spi_flush(struct bfin_spi_master_data *drv_data)
>  	unsigned long limit = loops_per_jiffy << 1;
>  
>  	/* wait for stop and clear stat */
> -	while (!(read_STAT(drv_data) & BIT_STAT_SPIF) && --limit)
> +	while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_SPIF) && --limit)
>  		cpu_relax();
>  
> -	write_STAT(drv_data, BIT_STAT_CLR);
> +	bfin_write(&drv_data->regs->stat, BIT_STAT_CLR);
>  
>  	return limit;
>  }
> @@ -183,29 +163,19 @@ static int bfin_spi_flush(struct bfin_spi_master_data *drv_data)
>  /* Chip select operation functions for cs_change flag */
>  static void bfin_spi_cs_active(struct bfin_spi_master_data *drv_data, struct bfin_spi_slave_data *chip)
>  {
> -	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
> -		u16 flag = read_FLAG(drv_data);
> -
> -		flag &= ~chip->flag;
> -
> -		write_FLAG(drv_data, flag);
> -	} else {
> +	if (likely(chip->chip_select_num < MAX_CTRL_CS))
> +		bfin_write_and(&drv_data->regs->flg, ~chip->flag);
> +	else
>  		gpio_set_value(chip->cs_gpio, 0);
> -	}
>  }
>  
>  static void bfin_spi_cs_deactive(struct bfin_spi_master_data *drv_data,
>                                   struct bfin_spi_slave_data *chip)
>  {
> -	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
> -		u16 flag = read_FLAG(drv_data);
> -
> -		flag |= chip->flag;
> -
> -		write_FLAG(drv_data, flag);
> -	} else {
> +	if (likely(chip->chip_select_num < MAX_CTRL_CS))
> +		bfin_write_or(&drv_data->regs->flg, chip->flag);
> +	else
>  		gpio_set_value(chip->cs_gpio, 1);
> -	}
>  
>  	/* Move delay here for consistency */
>  	if (chip->cs_chg_udelay)
> @@ -216,25 +186,15 @@ static void bfin_spi_cs_deactive(struct bfin_spi_master_data *drv_data,
>  static inline void bfin_spi_cs_enable(struct bfin_spi_master_data *drv_data,
>                                        struct bfin_spi_slave_data *chip)
>  {
> -	if (chip->chip_select_num < MAX_CTRL_CS) {
> -		u16 flag = read_FLAG(drv_data);
> -
> -		flag |= (chip->flag >> 8);
> -
> -		write_FLAG(drv_data, flag);
> -	}
> +	if (chip->chip_select_num < MAX_CTRL_CS)
> +		bfin_write_or(&drv_data->regs->flg, chip->flag >> 8);
>  }
>  
>  static inline void bfin_spi_cs_disable(struct bfin_spi_master_data *drv_data,
>                                         struct bfin_spi_slave_data *chip)
>  {
> -	if (chip->chip_select_num < MAX_CTRL_CS) {
> -		u16 flag = read_FLAG(drv_data);
> -
> -		flag &= ~(chip->flag >> 8);
> -
> -		write_FLAG(drv_data, flag);
> -	}
> +	if (chip->chip_select_num < MAX_CTRL_CS)
> +		bfin_write_and(&drv_data->regs->flg, ~(chip->flag >> 8));
>  }
>  
>  /* stop controller and re-config current chip*/
> @@ -243,15 +203,15 @@ static void bfin_spi_restore_state(struct bfin_spi_master_data *drv_data)
>  	struct bfin_spi_slave_data *chip = drv_data->cur_chip;
>  
>  	/* Clear status and disable clock */
> -	write_STAT(drv_data, BIT_STAT_CLR);
> +	bfin_write(&drv_data->regs->stat, BIT_STAT_CLR);
>  	bfin_spi_disable(drv_data);
>  	dev_dbg(&drv_data->pdev->dev, "restoring spi ctl state\n");
>  
>  	SSYNC();
>  
>  	/* Load the registers */
> -	write_CTRL(drv_data, chip->ctl_reg);
> -	write_BAUD(drv_data, chip->baud);
> +	bfin_write(&drv_data->regs->ctl, chip->ctl_reg);
> +	bfin_write(&drv_data->regs->baud, chip->baud);
>  
>  	bfin_spi_enable(drv_data);
>  	bfin_spi_cs_active(drv_data, chip);
> @@ -260,7 +220,7 @@ static void bfin_spi_restore_state(struct bfin_spi_master_data *drv_data)
>  /* used to kick off transfer in rx mode and read unwanted RX data */
>  static inline void bfin_spi_dummy_read(struct bfin_spi_master_data *drv_data)
>  {
> -	(void) read_RDBR(drv_data);
> +	(void) bfin_read(&drv_data->regs->rdbr);
>  }
>  
>  static void bfin_spi_u8_writer(struct bfin_spi_master_data *drv_data)
> @@ -269,10 +229,10 @@ static void bfin_spi_u8_writer(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->tx < drv_data->tx_end) {
> -		write_TDBR(drv_data, (*(u8 *) (drv_data->tx++)));
> +		bfin_write(&drv_data->regs->tdbr, (*(u8 *) (drv_data->tx++)));
>  		/* wait until transfer finished.
>  		   checking SPIF or TXS may not guarantee transfer completion */
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
>  		/* discard RX data and clear RXS */
>  		bfin_spi_dummy_read(drv_data);
> @@ -287,10 +247,10 @@ static void bfin_spi_u8_reader(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->rx < drv_data->rx_end) {
> -		write_TDBR(drv_data, tx_val);
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		bfin_write(&drv_data->regs->tdbr, tx_val);
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
> -		*(u8 *) (drv_data->rx++) = read_RDBR(drv_data);
> +		*(u8 *) (drv_data->rx++) = bfin_read(&drv_data->regs->rdbr);
>  	}
>  }
>  
> @@ -300,10 +260,10 @@ static void bfin_spi_u8_duplex(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->rx < drv_data->rx_end) {
> -		write_TDBR(drv_data, (*(u8 *) (drv_data->tx++)));
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		bfin_write(&drv_data->regs->tdbr, (*(u8 *) (drv_data->tx++)));
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
> -		*(u8 *) (drv_data->rx++) = read_RDBR(drv_data);
> +		*(u8 *) (drv_data->rx++) = bfin_read(&drv_data->regs->rdbr);
>  	}
>  }
>  
> @@ -319,11 +279,11 @@ static void bfin_spi_u16_writer(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->tx < drv_data->tx_end) {
> -		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
> +		bfin_write(&drv_data->regs->tdbr, (*(u16 *) (drv_data->tx)));
>  		drv_data->tx += 2;
>  		/* wait until transfer finished.
>  		   checking SPIF or TXS may not guarantee transfer completion */
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
>  		/* discard RX data and clear RXS */
>  		bfin_spi_dummy_read(drv_data);
> @@ -338,10 +298,10 @@ static void bfin_spi_u16_reader(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->rx < drv_data->rx_end) {
> -		write_TDBR(drv_data, tx_val);
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		bfin_write(&drv_data->regs->tdbr, tx_val);
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
> -		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
> +		*(u16 *) (drv_data->rx) = bfin_read(&drv_data->regs->rdbr);
>  		drv_data->rx += 2;
>  	}
>  }
> @@ -352,11 +312,11 @@ static void bfin_spi_u16_duplex(struct bfin_spi_master_data *drv_data)
>  	bfin_spi_dummy_read(drv_data);
>  
>  	while (drv_data->rx < drv_data->rx_end) {
> -		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
> +		bfin_write(&drv_data->regs->tdbr, (*(u16 *) (drv_data->tx)));
>  		drv_data->tx += 2;
> -		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  			cpu_relax();
> -		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
> +		*(u16 *) (drv_data->rx) = bfin_read(&drv_data->regs->rdbr);
>  		drv_data->rx += 2;
>  	}
>  }
> @@ -428,7 +388,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  	int loop = 0;
>  
>  	/* wait until transfer finished. */
> -	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
> +	while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_RXS))
>  		cpu_relax();
>  
>  	if ((drv_data->tx && drv_data->tx >= drv_data->tx_end) ||
> @@ -439,11 +399,11 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  			if (!(n_bytes % 2)) {
>  				u16 *buf = (u16 *)drv_data->rx;
>  				for (loop = 0; loop < n_bytes / 2; loop++)
> -					*buf++ = read_RDBR(drv_data);
> +					*buf++ = bfin_read(&drv_data->regs->rdbr);
>  			} else {
>  				u8 *buf = (u8 *)drv_data->rx;
>  				for (loop = 0; loop < n_bytes; loop++)
> -					*buf++ = read_RDBR(drv_data);
> +					*buf++ = bfin_read(&drv_data->regs->rdbr);
>  			}
>  			drv_data->rx += n_bytes;
>  		}
> @@ -468,15 +428,15 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  			u16 *buf = (u16 *)drv_data->rx;
>  			u16 *buf2 = (u16 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
> -				*buf++ = read_RDBR(drv_data);
> -				write_TDBR(drv_data, *buf2++);
> +				*buf++ = bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, *buf2++);
>  			}
>  		} else {
>  			u8 *buf = (u8 *)drv_data->rx;
>  			u8 *buf2 = (u8 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes; loop++) {
> -				*buf++ = read_RDBR(drv_data);
> -				write_TDBR(drv_data, *buf2++);
> +				*buf++ = bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, *buf2++);
>  			}
>  		}
>  	} else if (drv_data->rx) {
> @@ -485,14 +445,14 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  		if (!(n_bytes % 2)) {
>  			u16 *buf = (u16 *)drv_data->rx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
> -				*buf++ = read_RDBR(drv_data);
> -				write_TDBR(drv_data, chip->idle_tx_val);
> +				*buf++ = bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, chip->idle_tx_val);
>  			}
>  		} else {
>  			u8 *buf = (u8 *)drv_data->rx;
>  			for (loop = 0; loop < n_bytes; loop++) {
> -				*buf++ = read_RDBR(drv_data);
> -				write_TDBR(drv_data, chip->idle_tx_val);
> +				*buf++ = bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, chip->idle_tx_val);
>  			}
>  		}
>  	} else if (drv_data->tx) {
> @@ -501,14 +461,14 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  		if (!(n_bytes % 2)) {
>  			u16 *buf = (u16 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
> -				read_RDBR(drv_data);
> -				write_TDBR(drv_data, *buf++);
> +				bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, *buf++);
>  			}
>  		} else {
>  			u8 *buf = (u8 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes; loop++) {
> -				read_RDBR(drv_data);
> -				write_TDBR(drv_data, *buf++);
> +				bfin_read(&drv_data->regs->rdbr);
> +				bfin_write(&drv_data->regs->tdbr, *buf++);
>  			}
>  		}
>  	}
> @@ -528,19 +488,19 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
>  	struct spi_message *msg = drv_data->cur_msg;
>  	unsigned long timeout;
>  	unsigned short dmastat = get_dma_curr_irqstat(drv_data->dma_channel);
> -	u16 spistat = read_STAT(drv_data);
> +	u16 spistat = bfin_read(&drv_data->regs->stat);
>  
>  	dev_dbg(&drv_data->pdev->dev,
>  		"in dma_irq_handler dmastat:0x%x spistat:0x%x\n",
>  		dmastat, spistat);
>  
>  	if (drv_data->rx != NULL) {
> -		u16 cr = read_CTRL(drv_data);
> +		u16 cr = bfin_read(&drv_data->regs->ctl);
>  		/* discard old RX data and clear RXS */
>  		bfin_spi_dummy_read(drv_data);
> -		write_CTRL(drv_data, cr & ~BIT_CTL_ENABLE); /* Disable SPI */
> -		write_CTRL(drv_data, cr & ~BIT_CTL_TIMOD); /* Restore State */
> -		write_STAT(drv_data, BIT_STAT_CLR); /* Clear Status */
> +		bfin_write(&drv_data->regs->ctl, cr & ~BIT_CTL_ENABLE); /* Disable SPI */
> +		bfin_write(&drv_data->regs->ctl, cr & ~BIT_CTL_TIMOD); /* Restore State */
> +		bfin_write(&drv_data->regs->stat, BIT_STAT_CLR); /* Clear Status */
>  	}
>  
>  	clear_dma_irqstat(drv_data->dma_channel);
> @@ -552,17 +512,17 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
>  	 * register until it goes low for 2 successive reads
>  	 */
>  	if (drv_data->tx != NULL) {
> -		while ((read_STAT(drv_data) & BIT_STAT_TXS) ||
> -		       (read_STAT(drv_data) & BIT_STAT_TXS))
> +		while ((bfin_read(&drv_data->regs->stat) & BIT_STAT_TXS) ||
> +		       (bfin_read(&drv_data->regs->stat) & BIT_STAT_TXS))
>  			cpu_relax();
>  	}
>  
>  	dev_dbg(&drv_data->pdev->dev,
>  		"in dma_irq_handler dmastat:0x%x spistat:0x%x\n",
> -		dmastat, read_STAT(drv_data));
> +		dmastat, bfin_read(&drv_data->regs->stat));
>  
>  	timeout = jiffies + HZ;
> -	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
> +	while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_SPIF))
>  		if (!time_before(jiffies, timeout)) {
>  			dev_warn(&drv_data->pdev->dev, "timeout waiting for SPIF");
>  			break;
> @@ -698,9 +658,9 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  		bfin_spi_giveback(drv_data);
>  		return;
>  	}
> -	cr = read_CTRL(drv_data) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
> +	cr = bfin_read(&drv_data->regs->ctl) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
>  	cr |= cr_width;
> -	write_CTRL(drv_data, cr);
> +	bfin_write(&drv_data->regs->ctl, cr);
>  
>  	dev_dbg(&drv_data->pdev->dev,
>  		"transfer: drv_data->ops is %p, chip->ops is %p, u8_ops is %p\n",
> @@ -711,11 +671,11 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  
>  	/* Speed setup (surely valid because already checked) */
>  	if (transfer->speed_hz)
> -		write_BAUD(drv_data, hz_to_spi_baud(transfer->speed_hz));
> +		bfin_write(&drv_data->regs->baud, hz_to_spi_baud(transfer->speed_hz));
>  	else
> -		write_BAUD(drv_data, chip->baud);
> +		bfin_write(&drv_data->regs->baud, chip->baud);
>  
> -	write_STAT(drv_data, BIT_STAT_CLR);
> +	bfin_write(&drv_data->regs->stat, BIT_STAT_CLR);
>  	bfin_spi_cs_active(drv_data, chip);
>  
>  	dev_dbg(&drv_data->pdev->dev,
> @@ -748,7 +708,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  		}
>  
>  		/* poll for SPI completion before start */
> -		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
> +		while (!(bfin_read(&drv_data->regs->stat) & BIT_STAT_SPIF))
>  			cpu_relax();
>  
>  		/* dirty hack for autobuffer DMA mode */
> @@ -765,7 +725,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  			enable_dma(drv_data->dma_channel);
>  
>  			/* start SPI transfer */
> -			write_CTRL(drv_data, cr | BIT_CTL_TIMOD_DMA_TX);
> +			bfin_write(&drv_data->regs->ctl, cr | BIT_CTL_TIMOD_DMA_TX);
>  
>  			/* just return here, there can only be one transfer
>  			 * in this mode
> @@ -820,7 +780,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  		set_dma_config(drv_data->dma_channel, dma_config);
>  		local_irq_save(flags);
>  		SSYNC();
> -		write_CTRL(drv_data, cr);
> +		bfin_write(&drv_data->regs->ctl, cr);
>  		enable_dma(drv_data->dma_channel);
>  		dma_enable_irq(drv_data->dma_channel);
>  		local_irq_restore(flags);
> @@ -834,7 +794,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  	 * problems with setting up the output value in TDBR prior to the
>  	 * start of the transfer.
>  	 */
> -	write_CTRL(drv_data, cr | BIT_CTL_TXMOD);
> +	bfin_write(&drv_data->regs->ctl, cr | BIT_CTL_TXMOD);
>  
>  	if (chip->pio_interrupt) {
>  		/* SPI irq should have been disabled by now */
> @@ -844,19 +804,19 @@ static void bfin_spi_pump_transfers(unsigned long data)
>  
>  		/* start transfer */
>  		if (drv_data->tx == NULL)
> -			write_TDBR(drv_data, chip->idle_tx_val);
> +			bfin_write(&drv_data->regs->tdbr, chip->idle_tx_val);
>  		else {
>  			int loop;
>  			if (bits_per_word % 16 == 0) {
>  				u16 *buf = (u16 *)drv_data->tx;
>  				for (loop = 0; loop < bits_per_word / 16;
>  						loop++) {
> -					write_TDBR(drv_data, *buf++);
> +					bfin_write(&drv_data->regs->tdbr, *buf++);
>  				}
>  			} else if (bits_per_word % 8 == 0) {
>  				u8 *buf = (u8 *)drv_data->tx;
>  				for (loop = 0; loop < bits_per_word / 8; loop++)
> -					write_TDBR(drv_data, *buf++);
> +					bfin_write(&drv_data->regs->tdbr, *buf++);
>  			}
>  
>  			drv_data->tx += drv_data->n_bytes;
> @@ -1352,8 +1312,8 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
>  		goto out_error_get_res;
>  	}
>  
> -	drv_data->regs_base = ioremap(res->start, resource_size(res));
> -	if (drv_data->regs_base == NULL) {
> +	drv_data->regs = ioremap(res->start, resource_size(res));
> +	if (drv_data->regs == NULL) {
>  		dev_err(dev, "Cannot map IO\n");
>  		status = -ENXIO;
>  		goto out_error_ioremap;
> @@ -1396,8 +1356,8 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
>  	/* Reset SPI registers. If these registers were used by the boot loader,
>  	 * the sky may fall on your head if you enable the dma controller.
>  	 */
> -	write_CTRL(drv_data, BIT_CTL_CPHA | BIT_CTL_MASTER);
> -	write_FLAG(drv_data, 0xFF00);
> +	bfin_write(&drv_data->regs->ctl, BIT_CTL_CPHA | BIT_CTL_MASTER);
> +	bfin_write(&drv_data->regs->flg, 0xFF00);
>  
>  	/* Register with the SPI framework */
>  	platform_set_drvdata(pdev, drv_data);
> @@ -1407,15 +1367,15 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
>  		goto out_error_queue_alloc;
>  	}
>  
> -	dev_info(dev, "%s, Version %s, regs_base@%p, dma channel@%d\n",
> -		DRV_DESC, DRV_VERSION, drv_data->regs_base,
> +	dev_info(dev, "%s, Version %s, regs@%p, dma channel@%d\n",
> +		DRV_DESC, DRV_VERSION, drv_data->regs,
>  		drv_data->dma_channel);
>  	return status;
>  
>  out_error_queue_alloc:
>  	bfin_spi_destroy_queue(drv_data);
>  out_error_free_io:
> -	iounmap((void *) drv_data->regs_base);
> +	iounmap(drv_data->regs);
>  out_error_ioremap:
>  out_error_get_res:
>  	spi_master_put(master);
> @@ -1472,14 +1432,14 @@ static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t state)
>  	if (status != 0)
>  		return status;
>  
> -	drv_data->ctrl_reg = read_CTRL(drv_data);
> -	drv_data->flag_reg = read_FLAG(drv_data);
> +	drv_data->ctrl_reg = bfin_read(&drv_data->regs->ctl);
> +	drv_data->flag_reg = bfin_read(&drv_data->regs->flg);
>  
>  	/*
>  	 * reset SPI_CTL and SPI_FLG registers
>  	 */
> -	write_CTRL(drv_data, BIT_CTL_CPHA | BIT_CTL_MASTER);
> -	write_FLAG(drv_data, 0xFF00);
> +	bfin_write(&drv_data->regs->ctl, BIT_CTL_CPHA | BIT_CTL_MASTER);
> +	bfin_write(&drv_data->regs->flg, 0xFF00);
>  
>  	return 0;
>  }
> @@ -1489,8 +1449,8 @@ static int bfin_spi_resume(struct platform_device *pdev)
>  	struct bfin_spi_master_data *drv_data = platform_get_drvdata(pdev);
>  	int status = 0;
>  
> -	write_CTRL(drv_data, drv_data->ctrl_reg);
> -	write_FLAG(drv_data, drv_data->flag_reg);
> +	bfin_write(&drv_data->regs->ctl, drv_data->ctrl_reg);
> +	bfin_write(&drv_data->regs->flg, drv_data->flag_reg);
>  
>  	/* Start the queue running */
>  	status = bfin_spi_start_queue(drv_data);
> -- 
> 1.7.5.3
> 
