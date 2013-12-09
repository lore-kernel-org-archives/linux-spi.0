From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: mpc512x: Use devm_*() functions
Date: Mon, 9 Dec 2013 14:12:13 +0100
Message-ID: <20131209131213.GL2982@book.gsilab.sittig.org>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
 <000e01cef4c7$53d9e060$fb8da120$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Anatolij Gustschin' <agust-ynQEQJNshbs@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000e01cef4c7$53d9e060$fb8da120$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Dec 09, 2013 at 19:13 +0900, Jingoo Han wrote:
> 
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-mpc512x-psc.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
> index 2babea2..77c03e2 100644
> --- a/drivers/spi/spi-mpc512x-psc.c
> +++ b/drivers/spi/spi-mpc512x-psc.c
> @@ -503,7 +503,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	master->cleanup = mpc512x_psc_spi_cleanup;
>  	master->dev.of_node = dev->of_node;
>  
> -	tempp = ioremap(regaddr, size);
> +	tempp = devm_ioremap(dev, regaddr, size);
>  	if (!tempp) {
>  		dev_err(dev, "could not ioremap I/O port range\n");
>  		ret = -EFAULT;
> @@ -513,8 +513,8 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	mps->fifo =
>  		(struct mpc512x_psc_fifo *)(tempp + sizeof(struct mpc52xx_psc));
>  
> -	ret = request_irq(mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> -			  "mpc512x-psc-spi", mps);
> +	ret = devm_request_irq(dev, mps->irq, mpc512x_psc_spi_isr, IRQF_SHARED,
> +				"mpc512x-psc-spi", mps);
>  	if (ret)
>  		goto free_master;
>  	init_completion(&mps->txisrdone);

nit: whitespace, indentation of the continued parameter list

everything else looks good (from looking at it, did not build/run-test)

> @@ -522,11 +522,11 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	clk = devm_clk_get(dev, "mclk");
>  	if (IS_ERR(clk)) {
>  		ret = PTR_ERR(clk);
> -		goto free_irq;
> +		goto free_master;
>  	}
>  	ret = clk_prepare_enable(clk);
>  	if (ret)
> -		goto free_irq;
> +		goto free_master;
>  	mps->clk_mclk = clk;
>  	mps->mclk_rate = clk_get_rate(clk);
>  
> @@ -554,11 +554,7 @@ free_ipg_clock:
>  	clk_disable_unprepare(mps->clk_ipg);
>  free_mclk_clock:
>  	clk_disable_unprepare(mps->clk_mclk);
> -free_irq:
> -	free_irq(mps->irq, mps);
>  free_master:
> -	if (mps->psc)
> -		iounmap(mps->psc);
>  	spi_master_put(master);
>  
>  	return ret;
> @@ -571,9 +567,6 @@ static int mpc512x_psc_spi_do_remove(struct device *dev)
>  
>  	clk_disable_unprepare(mps->clk_mclk);
>  	clk_disable_unprepare(mps->clk_ipg);
> -	free_irq(mps->irq, mps);
> -	if (mps->psc)
> -		iounmap(mps->psc);
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
