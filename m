From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] spi: orion: Fix a resource leak if the optional "axi" clk is deferred
Date: Fri, 26 Jan 2018 09:10:07 +0100
Message-ID: <87fu6t2g80.fsf@free-electrons.com>
References: <20180125201617.17099-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20180125201617.17099-1-christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Thu, 25 Jan 2018 21:16:17 +0100")
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Christophe,
 
 On jeu., janv. 25 2018, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If the optional "axi" clk is deferred, we still need to undo some
> initialisation. Espacially 'master' must be released. It will be
                  Especially

> reallocated the next time 'orion_spi_probe()' is called.
>
> Add a new label to clean what needs to be cleaned and rename another
> label to improve the names used.
>
> Fixes: 92ae112e477a ("spi: orion: Fix clock resource by adding an optional bus clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


> ---
>  drivers/spi/spi-orion.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index 482a0cf3b7aa..deca63e82ff6 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -638,8 +638,10 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	/* The following clock is only used by some SoCs */
>  	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
>  	if (IS_ERR(spi->axi_clk) &&
> -	    PTR_ERR(spi->axi_clk) == -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> +	    PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
> +		status = -EPROBE_DEFER;
> +		goto out_rel_clk;
> +	}
>  	if (!IS_ERR(spi->axi_clk))
>  		clk_prepare_enable(spi->axi_clk);
>  
> @@ -667,7 +669,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>  	spi->base = devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(spi->base)) {
>  		status = PTR_ERR(spi->base);
> -		goto out_rel_clk;
> +		goto out_rel_axi_clk;
>  	}
>  
>  	/* Scan all SPI devices of this controller for direct mapped devices */
> @@ -705,7 +707,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>  							    PAGE_SIZE);
>  		if (!spi->direct_access[cs].vaddr) {
>  			status = -ENOMEM;
> -			goto out_rel_clk;
> +			goto out_rel_axi_clk;
>  		}
>  		spi->direct_access[cs].size = PAGE_SIZE;
>  
> @@ -733,8 +735,9 @@ static int orion_spi_probe(struct platform_device *pdev)
>  
>  out_rel_pm:
>  	pm_runtime_disable(&pdev->dev);
> -out_rel_clk:
> +out_rel_axi_clk:
>  	clk_disable_unprepare(spi->axi_clk);
> +out_rel_clk:
>  	clk_disable_unprepare(spi->clk);
>  out:
>  	spi_master_put(master);
> -- 
> 2.14.1
>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
