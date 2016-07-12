From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 6/7] spi: s3c64xx: restore removed comments
Date: Tue, 12 Jul 2016 11:07:53 -0700
Message-ID: <146834687302.73491.6686338412638288829@resonance>
References: <57837606.8050906@samsung.com>
 <1468306444-18512-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Chanwoo Choi" <cw00.choi@samsung.com>,
	"Jaehoon Chung" <jh80.chung@samsung.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	"Andi Shyti" <andi.shyti@samsung.com>,
	"Andi Shyti" <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>,
	"Rob Herring" <robh+dt@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Kukjin Kim" <kgene@kernel.org>,
	"Krzysztof Kozlowski" <k.kozlowski@samsung.com>,
	"Mark Brown" <broonie@kernel.org>,
	"Sylwester Nawrocki" <s.nawrocki@samsung.com>,
	"Tomasz Figa" <tomasz.figa@gmail.com>,
	"Stephen Boyd" <sboyd@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1468306444-18512-1-git-send-email-andi.shyti@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Andi Shyti (2016-07-11 23:54:04)
> Patch a9e93e8 has erroneously removed some comments which are
> important to understand why the bus frequency is multiplied by
> two during the spi transfer.
> 
> Reword the previous comment to a more appropriate message.
> 
> Suggested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
> ---
> Hi,
> 
> despite Mike's comments I'm sending the patch as it was
> originally meant. I think that fixing the exact clk where to set
> the rate should anyway go in a different patch.

That sounds fair.

Regards,
Mike

> 
> V2->V3
> The comment has been reworded as Sylwester recommended.
> 
> Thanks,
> Andi
> 
>  drivers/spi/spi-s3c64xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 6da663f..5bedafc 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -639,6 +639,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>         writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
>         if (sdd->port_conf->clk_from_cmu) {
> +               /* The src_clk clock is divided internally by 2 */
>                 clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
>         } else {
>                 /* Configure Clock */
> -- 
> 2.8.1
> 
