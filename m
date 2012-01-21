From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Subject: Re: [PATCH 1/3] spi/s3c64xx: Log error interrupts
Date: Sat, 21 Jan 2012 16:27:16 +0100
Message-ID: <4F1AD954.9030303@gmail.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com> <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/21/2012 02:24 PM, Mark Brown wrote:
> Although the hardware supports interrupts we're not currently using them
> at all since for small transfers the overhead is greater than that for
> busy waiting and for large transfers we have interrupts from the DMA.
> This means that if the hardware reports an error (especially one which
> might not stall transfer) we might miss it.
> 
> Take a first pass at dealing with such errors by enabling the interrupt
> if we can and logging the errors if they happen. Ideally we'd report the
> error via the affected transfer but since we're in master mode it's very
> difficult to trigger errors at present and this code is much simpler.
> 
> Signed-off-by: Mark Brown<broonie@opensource.wolfsonmicro.com>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
> ---
...
>   static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>   {
>   	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
> @@ -970,7 +999,8 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
>   	struct s3c64xx_spi_driver_data *sdd;
>   	struct s3c64xx_spi_info *sci;
>   	struct spi_master *master;
> -	int ret;
> +	int ret, irq;
> +	char clk_name[16];

clk_name seems to be unused, otherwise looks good.

--

Thanks,
Sylwester
