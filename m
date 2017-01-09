From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] spi: spi-axi: Free resources on error path
Date: Mon, 9 Jan 2017 01:11:44 +0100
Message-ID: <5a377f44-f548-2167-51bf-4fb46890fae3@metafoo.de>
References: <20170109000247.3215-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109000247.3215-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/09/2017 01:02 AM, Christophe JAILLET wrote:
> We should go to 'err_put_master' here instead of returning directly.
> Otherwise a call to 'spi_master_put' is missing.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/spi/spi-axi-spi-engine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 319225d7e761..6ab4c7700228 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -494,7 +494,8 @@ static int spi_engine_probe(struct platform_device *pdev)
>  			SPI_ENGINE_VERSION_MAJOR(version),
>  			SPI_ENGINE_VERSION_MINOR(version),
>  			SPI_ENGINE_VERSION_PATCH(version));
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_put_master;
>  	}
>  
>  	spi_engine->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
> 
