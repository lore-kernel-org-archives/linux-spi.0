From: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/8] clk: samsung: s3c64xx: Remove clock aliases of old DMA
 driver
Date: Mon, 21 Oct 2013 05:12:00 -0700
Message-ID: <20131021121200.11944.16288@quantum>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <1381950659-12703-7-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Padmavathi Venna <padma.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Sangbeom Kim <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>,
	Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381950659-12703-7-git-send-email-tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Quoting Tomasz Figa (2013-10-16 12:10:57)
> Since the old DMA driver got removed, these aliases are no longer
> necessary.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> ---
>  drivers/clk/samsung/clk-s3c64xx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
> index 06cf105..8e27aee 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c
> @@ -331,9 +331,7 @@ static struct samsung_clock_alias s3c64xx_clock_aliases[] = {
>         ALIAS(HCLK_HSMMC1, "s3c-sdhci.1", "mmc_busclk.0"),
>         ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "hsmmc"),
>         ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "mmc_busclk.0"),
> -       ALIAS(HCLK_DMA1, NULL, "dma1"),
>         ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
> -       ALIAS(HCLK_DMA0, NULL, "dma0"),
>         ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),
>         ALIAS(HCLK_CAMIF, "s3c-camif", "camif"),
>         ALIAS(HCLK_LCD, "s3c-fb", "lcd"),
> -- 
> 1.8.3.2
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
