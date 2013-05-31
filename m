From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: convert drivers to use bits_per_word_mask
Date: Fri, 31 May 2013 10:45:32 +0200
Message-ID: <1528437.8btZmmDHhd@wuerfel>
References: <1369190195-14598-1-git-send-email-swarren@wwwdotorg.org>
	<1369190195-14598-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, device-drivers-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1369190195-14598-2-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Can you check this part again:

On Tuesday 21 May 2013 20:36:35 Stephen Warren wrote:
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f5d84d6..7de2ca1 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -881,21 +881,6 @@ static int setup(struct spi_device *spi)
>                 rx_thres = RX_THRESH_DFLT;
>         }
>  
> -       if (!pxa25x_ssp_comp(drv_data)
> -               && (spi->bits_per_word < 4 || spi->bits_per_word > 32)) {
> -               dev_err(&spi->dev, "failed setup: ssp_type=%d, bits/wrd=%d "
> -                               "b/w not 4-32 for type non-PXA25x_SSP\n",
> -                               drv_data->ssp_type, spi->bits_per_word);
> -               return -EINVAL;
> -       } else if (pxa25x_ssp_comp(drv_data)
> -                       && (spi->bits_per_word < 4
> -                               || spi->bits_per_word > 16)) {
> -               dev_err(&spi->dev, "failed setup: ssp_type=%d, bits/wrd=%d "
> -                               "b/w not 4-16 for type PXA25x_SSP\n",
> -                               drv_data->ssp_type, spi->bits_per_word);
> -               return -EINVAL;
> -       }
> -
>         /* Only alloc on first setup */
>         chip = spi_get_ctldata(spi);
>         if (!chip) {
> @@ -1011,9 +996,6 @@ static int setup(struct spi_device *spi)
>                 chip->n_bytes = 4;
>                 chip->read = u32_reader;
>                 chip->write = u32_writer;
> -       } else {
> -               dev_err(&spi->dev, "invalid wordsize\n");
> -               return -ENODEV;
>         }
>         chip->bits_per_word = spi->bits_per_word;
>  
> @@ -1190,11 +1172,13 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>         drv_data->ioaddr = ssp->mmio_base;
>         drv_data->ssdr_physical = ssp->phys_base + SSDR;
>         if (pxa25x_ssp_comp(drv_data)) {
> +               master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
>                 drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE;
>                 drv_data->dma_cr1 = 0;
>                 drv_data->clear_sr = SSSR_ROR;
>                 drv_data->mask_sr = SSSR_RFS | SSSR_TFS | SSSR_ROR;
>         } else {
> +               master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
>                 drv_data->int_cr1 = SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
>                 drv_data->dma_cr1 = DEFAULT_DMA_CR1;
>                 drv_data->clear_sr = SSSR_ROR | SSSR_TINT;

I get a new build warning

drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_probe':
drivers/spi/spi-pxa2xx.c:1152:3: warning: left shift count >= width of type [enabled by default]
   master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
   ^

	Arnd

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
