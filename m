From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: get rid of chipinfo dev pointer
Date: Sun, 10 Oct 2010 00:51:50 -0600
Message-ID: <20101010065150.GB1227@angua.secretlab.ca>
References: <1285926452-8636-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285926452-8636-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 01, 2010 at 11:47:32AM +0200, Linus Walleij wrote:
> What is the dev pointer doing inside the platform data anyway.
> We have another pointer to the actual device at hand, use that.
> 
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Applied, thanks.

g.

> ---
> Note: this is based off Kevin Wells patch for using the proper
> modebits since I expect that to go in first. If you want this to
> go before that patch, tell me and we both have to rebase.
> ---
>  drivers/spi/amba-pl022.c   |   27 ++++++++++++---------------
>  include/linux/amba/pl022.h |    1 -
>  2 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 610c274..b01ee5b 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1597,58 +1597,58 @@ static int verify_controller_parameters(struct pl022 *pl022,
>  {
>  	if ((chip_info->iface < SSP_INTERFACE_MOTOROLA_SPI)
>  	    || (chip_info->iface > SSP_INTERFACE_UNIDIRECTIONAL)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"interface is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if ((chip_info->iface == SSP_INTERFACE_UNIDIRECTIONAL) &&
>  	    (!pl022->vendor->unidir)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"unidirectional mode not supported in this "
>  			"hardware version\n");
>  		return -EINVAL;
>  	}
>  	if ((chip_info->hierarchy != SSP_MASTER)
>  	    && (chip_info->hierarchy != SSP_SLAVE)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"hierarchy is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if (((chip_info->clk_freq).cpsdvsr < CPSDVR_MIN)
>  	    || ((chip_info->clk_freq).cpsdvsr > CPSDVR_MAX)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"cpsdvsr is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if ((chip_info->com_mode != INTERRUPT_TRANSFER)
>  	    && (chip_info->com_mode != DMA_TRANSFER)
>  	    && (chip_info->com_mode != POLLING_TRANSFER)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"Communication mode is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if ((chip_info->rx_lev_trig < SSP_RX_1_OR_MORE_ELEM)
>  	    || (chip_info->rx_lev_trig > SSP_RX_32_OR_MORE_ELEM)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"RX FIFO Trigger Level is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if ((chip_info->tx_lev_trig < SSP_TX_1_OR_MORE_EMPTY_LOC)
>  	    || (chip_info->tx_lev_trig > SSP_TX_32_OR_MORE_EMPTY_LOC)) {
> -		dev_err(chip_info->dev,
> +		dev_err(&pl022->adev->dev,
>  			"TX FIFO Trigger Level is configured incorrectly\n");
>  		return -EINVAL;
>  	}
>  	if (chip_info->iface == SSP_INTERFACE_NATIONAL_MICROWIRE) {
>  		if ((chip_info->ctrl_len < SSP_BITS_4)
>  		    || (chip_info->ctrl_len > SSP_BITS_32)) {
> -			dev_err(chip_info->dev,
> +			dev_err(&pl022->adev->dev,
>  				"CTRL LEN is configured incorrectly\n");
>  			return -EINVAL;
>  		}
>  		if ((chip_info->wait_state != SSP_MWIRE_WAIT_ZERO)
>  		    && (chip_info->wait_state != SSP_MWIRE_WAIT_ONE)) {
> -			dev_err(chip_info->dev,
> +			dev_err(&pl022->adev->dev,
>  				"Wait State is configured incorrectly\n");
>  			return -EINVAL;
>  		}
> @@ -1658,12 +1658,12 @@ static int verify_controller_parameters(struct pl022 *pl022,
>  			     SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
>  			    && (chip_info->duplex !=
>  				SSP_MICROWIRE_CHANNEL_HALF_DUPLEX))
> -				dev_err(chip_info->dev,
> +				dev_err(&pl022->adev->dev,
>  					"Microwire duplex mode is configured incorrectly\n");
>  				return -EINVAL;
>  		} else {
>  			if (chip_info->duplex != SSP_MICROWIRE_CHANNEL_FULL_DUPLEX)
> -				dev_err(chip_info->dev,
> +				dev_err(&pl022->adev->dev,
>  					"Microwire half duplex mode requested,"
>  					" but this is only available in the"
>  					" ST version of PL022\n");
> @@ -1671,7 +1671,7 @@ static int verify_controller_parameters(struct pl022 *pl022,
>  		}
>  	}
>  	if (chip_info->cs_control == NULL) {
> -		dev_warn(chip_info->dev,
> +		dev_warn(&pl022->adev->dev,
>  			"Chip Select Function is NULL for this chip\n");
>  		chip_info->cs_control = null_cs_control;
>  	}
> @@ -1851,9 +1851,6 @@ static int pl022_setup(struct spi_device *spi)
>  			"using user supplied controller_data settings\n");
>  	}
>  
> -	/* Pointer back to the SPI device */
> -	chip_info->dev = &spi->dev;
> -
>  	/*
>  	 * We can override with custom divisors, else we use the board
>  	 * frequency setting
> diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
> index bf14366..4ce98f5 100644
> --- a/include/linux/amba/pl022.h
> +++ b/include/linux/amba/pl022.h
> @@ -276,7 +276,6 @@ struct pl022_ssp_controller {
>   * @dma_config: DMA configuration for SSP controller and peripheral
>   */
>  struct pl022_config_chip {
> -	struct device *dev;
>  	enum ssp_interface iface;
>  	enum ssp_hierarchy hierarchy;
>  	bool slave_tx_disable;
> -- 
> 1.6.3.3
> 

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
