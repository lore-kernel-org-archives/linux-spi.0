From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi_mpc83xx.c,
	support QE enabled 83xx CPU's like mpc832x
Date: Sat, 30 Jun 2007 08:02:23 -0700
Message-ID: <200706300802.23189.david-b@pacbell.net>
References: <1183213370.20673.100.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1183213370.20673.100.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
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

On Saturday 30 June 2007, Joakim Tjernlund wrote:
> Quicc Engine enabled mpc83xx CPU's has a somewhat different HW interface
> to the SPI controller. This patch adds a qe_mode knob that sees to that
> needed adaptions are performed.

But nothing seems to add it to <linux/fsl_devices.h> ...
so this won't build.  Right?


> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
> ---
> 
> This is a resend of a patch Kumar and I tossed back and forth a few
> times.
> 
>  Jocke
> 
> diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
> index e9798bf..c571f7c 100644
> --- a/drivers/spi/spi_mpc83xx.c
> +++ b/drivers/spi/spi_mpc83xx.c
> @@ -47,6 +47,7 @@ struct mpc83xx_spi_reg {
>  #define	SPMODE_ENABLE		(1 << 24)
>  #define	SPMODE_LEN(x)		((x) << 20)
>  #define	SPMODE_PM(x)		((x) << 16)
> +#define	SPMODE_OP		(1 << 14)
>  
>  /*
>   * Default for SPI Mode:
> @@ -85,6 +86,11 @@ struct mpc83xx_spi {
>  	unsigned nsecs;		/* (clock cycle time)/2 */
>  
>  	u32 sysclk;
> +	u32 rx_shift;		/* amount to adjust RX data regs if in qe mode */
> +	u32 tx_shift;		/* amount to adjust TX data regs if in qe mode */
> +
> +	bool qe_mode;
> +
>  	void (*activate_cs) (u8 cs, u8 polarity);
>  	void (*deactivate_cs) (u8 cs, u8 polarity);
>  };
> @@ -103,7 +109,7 @@ static inline u32 mpc83xx_spi_read_reg(__be32 __iomem * reg)
>  void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi) \
>  {									  \
>  	type * rx = mpc83xx_spi->rx;					  \
> -	*rx++ = (type)data;						  \
> +	*rx++ = (type)(data >> mpc83xx_spi->rx_shift);			  \
>  	mpc83xx_spi->rx = rx;						  \
>  }
>  
> @@ -114,7 +120,7 @@ u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi)	\
>  	const type * tx = mpc83xx_spi->tx;			\
>  	if (!tx)						\
>  		return 0;					\
> -	data = *tx++;						\
> +	data = *tx++ << mpc83xx_spi->tx_shift;			\
>  	mpc83xx_spi->tx = tx;					\
>  	return data;						\
>  }
> @@ -197,12 +203,22 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  	    || ((bits_per_word > 16) && (bits_per_word != 32)))
>  		return -EINVAL;
>  
> +	mpc83xx_spi->rx_shift = 0;
> +	mpc83xx_spi->tx_shift = 0;
>  	if (bits_per_word <= 8) {
>  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
>  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
> +		if (mpc83xx_spi->qe_mode) {
> +			mpc83xx_spi->rx_shift = 16;
> +			mpc83xx_spi->tx_shift = 24;
> +		}
>  	} else if (bits_per_word <= 16) {
>  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u16;
>  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u16;
> +		if (mpc83xx_spi->qe_mode) {
> +			mpc83xx_spi->rx_shift = 16;
> +			mpc83xx_spi->tx_shift = 16;
> +		}
>  	} else if (bits_per_word <= 32) {
>  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u32;
>  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u32;
> @@ -371,7 +387,6 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
>  		ret = -ENODEV;
>  		goto free_master;
>  	}
> -
>  	mpc83xx_spi = spi_master_get_devdata(master);
>  	mpc83xx_spi->bitbang.master = spi_master_get(master);
>  	mpc83xx_spi->bitbang.chipselect = mpc83xx_spi_chipselect;
> @@ -380,9 +395,17 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
>  	mpc83xx_spi->sysclk = pdata->sysclk;
>  	mpc83xx_spi->activate_cs = pdata->activate_cs;
>  	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
> +	mpc83xx_spi->qe_mode = pdata->qe_mode;
>  	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
>  	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
>  
> +	mpc83xx_spi->rx_shift = 0;
> +	mpc83xx_spi->tx_shift = 0;
> +	if (mpc83xx_spi->qe_mode) {
> +		mpc83xx_spi->rx_shift = 16;
> +		mpc83xx_spi->tx_shift = 24;
> +	}
> +
>  	mpc83xx_spi->bitbang.master->setup = mpc83xx_spi_setup;
>  	init_completion(&mpc83xx_spi->done);
>  
> @@ -417,6 +440,9 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
>  
>  	/* Enable SPI interface */
>  	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
> +	if (pdata->qe_mode)
> +		regval |= SPMODE_OP;
> +
>  	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
>  
>  	ret = spi_bitbang_start(&mpc83xx_spi->bitbang);
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
