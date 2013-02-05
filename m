From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/6] spi/ath79: use gpio_request_one
Date: Tue, 05 Feb 2013 12:59:06 +0000
Message-ID: <20130205125906.C812E3E0E27@localhost>
References: <1356601349-23617-1-git-send-email-juhosg@openwrt.org>
	<1356601349-23617-5-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1356601349-23617-5-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Dec 2012 10:42:27 +0100, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> Use gpio_request_one() instead of multiple gpiolib calls.
> 
> Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-ath79.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
> index a725e62..19d539e 100644
> --- a/drivers/spi/spi-ath79.c
> +++ b/drivers/spi/spi-ath79.c
> @@ -100,6 +100,7 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
>  {
>  	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
>  	struct ath79_spi_controller_data *cdata;
> +	int status;
>  
>  	cdata = spi->controller_data;
>  	if (spi->chip_select && !cdata)
> @@ -115,22 +116,21 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
>  	/* TODO: setup speed? */
>  	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
>  
> +	status = 0;
>  	if (spi->chip_select) {
> -		int status = 0;
> +		unsigned long flags;
>  
> -		status = gpio_request(cdata->gpio, dev_name(&spi->dev));
> -		if (status)
> -			return status;
> +		flags = GPIOF_DIR_OUT;
> +		if (spi->mode & SPI_CS_HIGH)
> +			flags |= GPIOF_INIT_HIGH;
> +		else
> +			flags |= GPIOF_INIT_LOW;
>  
> -		status = gpio_direction_output(cdata->gpio,
> -					       spi->mode & SPI_CS_HIGH);
> -		if (status) {
> -			gpio_free(cdata->gpio);
> -			return status;
> -		}
> +		status = gpio_request_one(cdata->gpio, flags,
> +					  dev_name(&spi->dev));
>  	}
>  
> -	return 0;
> +	return status;
>  }
>  
>  static void ath79_spi_cleanup_cs(struct spi_device *spi)
> -- 
> 1.7.10
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
