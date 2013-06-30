From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 2/8] spi: spi-ep93xx: use bits_per_word_mask
Date: Sun, 30 Jun 2013 19:13:58 +0300
Message-ID: <20130630161358.GA786@mwesterb-mobl.lan>
References: <201306281143.07615.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, broonie@kernel.org,
	grant.likely@linaro.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201306281143.07615.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jun 28, 2013 at 11:43:07AM -0700, H Hartley Sweeten wrote:
> This driver supports 16 to 4 bits per work. Set the bits_per_word_mask
> to allows the spi core to handle validation.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> ---
>  drivers/spi/spi-ep93xx.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index c633cd0..93ae7b6 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -272,12 +272,6 @@ static int ep93xx_spi_setup(struct spi_device *spi)
>  	struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
>  	struct ep93xx_spi_chip *chip;
>  
> -	if (spi->bits_per_word < 4 || spi->bits_per_word > 16) {
> -		dev_err(&espi->pdev->dev, "invalid bits per word %d\n",
> -			spi->bits_per_word);
> -		return -EINVAL;
> -	}
> -
>  	chip = spi_get_ctldata(spi);
>  	if (!chip) {
>  		dev_dbg(&espi->pdev->dev, "initial setup for %s\n",
> @@ -341,10 +335,6 @@ static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_message *msg)
>  
>  	/* first validate each transfer */
>  	list_for_each_entry(t, &msg->transfers, transfer_list) {
> -		if (t->bits_per_word) {
> -			if (t->bits_per_word < 4 || t->bits_per_word > 16)
> -				return -EINVAL;
> -		}
>  		if (t->speed_hz && t->speed_hz < espi->min_rate)
>  				return -EINVAL;
>  	}
> @@ -1022,6 +1012,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
>  	master->bus_num = pdev->id;
>  	master->num_chipselect = info->num_chipselect;
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +	master->bits_per_word_mask = 0xfff8;	/* 16 to 4 bits per word */

Please use SPI_BPW_RANGE_MASK(4, 16) here.
