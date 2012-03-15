From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: s3c64xx: Fix build
Date: Thu, 15 Mar 2012 03:32:33 -0600
Message-ID: <20120315093233.7F7ED3E0648@localhost>
References: <1331743934-23577-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Boojin Kim <boojin.kim@samsung.com>,
	Kyoungil Kim <ki0351.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1331743934-23577-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 14 Mar 2012 16:52:14 +0000, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> Commit 054ebc (spi: Compatibility with direction which is used in samsung
> DMA operation) does not build as one hunk adds a brace to the first branch
> of an if statement without adding at least the correspoding close. Remove
> the unwanted brace.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-s3c64xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index c40d118..3180100 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -264,7 +264,7 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>  	struct s3c64xx_spi_driver_data *sdd;
>  	struct samsung_dma_prep_info info;
>  
> -	if (dma->direction == DMA_DEV_TO_MEM) {
> +	if (dma->direction == DMA_DEV_TO_MEM)
>  		sdd = container_of((void *)dma,
>  			struct s3c64xx_spi_driver_data, rx_dma);
>  	else
> -- 
> 1.7.9.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
