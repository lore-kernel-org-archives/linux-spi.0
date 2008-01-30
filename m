From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH 2/6] [Blackfin] SPI driver: Use SPI device name to do gpio peripheral request
Date: Wed, 30 Jan 2008 13:48:43 -0800
Message-ID: <200801301348.43275.david-b@pacbell.net>
References: <1201684421-26124-1-git-send-email-bryan.wu@analog.com> <1201684421-26124-3-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Bryan Wu <bryan.wu@analog.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764005AbYAaAKf@vger.kernel.org>
In-Reply-To: <1201684421-26124-3-git-send-email-bryan.wu@analog.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 30 January 2008, Bryan Wu wrote:
> When got some gpio conflict, it is easy to know which SPI device driver not just got "bfin-spi"
> 
> Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> ---
>  drivers/spi/spi_bfin5xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index 8fd1365..c3f9ed4 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -1176,7 +1176,7 @@ static int setup(struct spi_device *spi)
>  	if ((chip->chip_select_num > 0)
>  		&& (chip->chip_select_num <= spi->master->num_chipselect))
>  		peripheral_request(ssel[spi->master->bus_num]
> -			[chip->chip_select_num-1], DRV_NAME);
> +			[chip->chip_select_num-1], spi->modalias);

Better:  spi->dev.bus_id (always unique) not spi->modalias (isn't) ...

 
>  
>  	cs_deactive(drv_data, chip);
>  
> 
