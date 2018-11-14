From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] spi: pxa2xx: Fix '"CONFIG_OF" is not defined' warning
Date: Wed, 14 Nov 2018 20:15:52 +0100
Message-ID: <87lg5vjwrb.fsf@belgarion.home>
References: <20181114173107.1229717-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114173107.1229717-1-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Wed, 14 Nov 2018 18:31:07 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> A careless oversight. Sorry.
>
> Fixes: 0a897143b7c9 ("spi: pxa2xx: Add slave mode support")
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/spi/spi-pxa2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 29e6025f104c..7194070e4009 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1555,7 +1555,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>  	}
>  #endif
>  
> -#if CONFIG_OF
> +#ifdef CONFIG_OF
>  	if (of_id) {
>  		pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
>  								"spi-slave");
While at it, why not simply remove the "#if CONFIG_OF", the if (of_id), and
write simply this, without any ifs ? :
	pdata->is_slave = of_property_read_bool(pdev->dev.of_node,
						"spi-slave");

If CONFIG_OF=n, of_property_read_bool() is guaranteed to return false. If the
device is not found through devicetree, of_node == NULL and a false will
still be returned. And the last case is your bool read case (ie. when devicetree
probed the device).

Cheers.

-- 
Robert
