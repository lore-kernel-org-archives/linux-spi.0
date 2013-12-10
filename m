From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/11] spi: nuc900: Use devm_*() functions
Date: Tue, 10 Dec 2013 13:51:59 +0800
Message-ID: <CAKT61h9D=mSqTshn4RxHJpBWkaoEtSCom_N1MvYdF5FxR8hy=w@mail.gmail.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com> <001101cef4c7$fb071e20$f1155a60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001101cef4c7$fb071e20$f1155a60$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2013/12/9 Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> Use devm_*() functions to make cleanup paths simpler.
>
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-nuc900.c |   50 ++++++++++------------------------------------
>  1 file changed, 10 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
> index e0c32bc..43d340c 100644
> --- a/drivers/spi/spi-nuc900.c
> +++ b/drivers/spi/spi-nuc900.c
> @@ -57,7 +57,6 @@ struct nuc900_spi {
>         const unsigned char     *tx;
>         unsigned char           *rx;
>         struct clk              *clk;
> -       struct resource         *ioarea;
>         struct spi_master       *master;
>         struct spi_device       *curdev;
>         struct device           *dev;
> @@ -344,8 +343,7 @@ static int nuc900_spi_probe(struct platform_device *pdev)
>         master = spi_alloc_master(&pdev->dev, sizeof(struct nuc900_spi));
>         if (master == NULL) {
>                 dev_err(&pdev->dev, "No memory for spi_master\n");
> -               err = -ENOMEM;
> -               goto err_nomem;
> +               return -ENOMEM;
>         }
>
>         hw = spi_master_get_devdata(master);
> @@ -376,40 +374,31 @@ static int nuc900_spi_probe(struct platform_device *pdev)
>                 goto err_pdata;
>         }
>
> -       hw->ioarea = request_mem_region(hw->res->start,
> -                                       resource_size(hw->res), pdev->name);
> -
> -       if (hw->ioarea == NULL) {
> -               dev_err(&pdev->dev, "Cannot reserve region\n");
> -               err = -ENXIO;
> +       hw->regs = devm_ioremap_resource(&pdev->dev, hw->res);
> +       if (IS_ERR(hw->regs)) {
> +               err = PTR_ERR(hw->regs);
>                 goto err_pdata;
>         }
>
> -       hw->regs = ioremap(hw->res->start, resource_size(hw->res));
> -       if (hw->regs == NULL) {
> -               dev_err(&pdev->dev, "Cannot map IO\n");
> -               err = -ENXIO;
> -               goto err_iomap;
> -       }
> -
>         hw->irq = platform_get_irq(pdev, 0);
>         if (hw->irq < 0) {
>                 dev_err(&pdev->dev, "No IRQ specified\n");
>                 err = -ENOENT;
> -               goto err_irq;
> +               goto err_pdata;
>         }
>
> -       err = request_irq(hw->irq, nuc900_spi_irq, 0, pdev->name, hw);
> +       err = devm_request_irq(&pdev->dev, hw->irq, nuc900_spi_irq, 0,
> +                               pdev->name, hw);
>         if (err) {
>                 dev_err(&pdev->dev, "Cannot claim IRQ\n");
> -               goto err_irq;
> +               goto err_pdata;
>         }
>
> -       hw->clk = clk_get(&pdev->dev, "spi");
> +       hw->clk = devm_clk_get(&pdev->dev, "spi");
>         if (IS_ERR(hw->clk)) {
>                 dev_err(&pdev->dev, "No clock for device\n");
>                 err = PTR_ERR(hw->clk);
> -               goto err_clk;
> +               goto err_pdata;
>         }
>
>         mfp_set_groupg(&pdev->dev, NULL);
> @@ -425,17 +414,8 @@ static int nuc900_spi_probe(struct platform_device *pdev)
>
>  err_register:
>         clk_disable(hw->clk);
> -       clk_put(hw->clk);
> -err_clk:
> -       free_irq(hw->irq, hw);
> -err_irq:
> -       iounmap(hw->regs);
> -err_iomap:
> -       release_mem_region(hw->res->start, resource_size(hw->res));
> -       kfree(hw->ioarea);
>  err_pdata:
>         spi_master_put(hw->master);
> -err_nomem:
>         return err;
>  }
>
> @@ -443,18 +423,8 @@ static int nuc900_spi_remove(struct platform_device *dev)
>  {
>         struct nuc900_spi *hw = platform_get_drvdata(dev);
>
> -       free_irq(hw->irq, hw);
> -
>         spi_bitbang_stop(&hw->bitbang);
> -
>         clk_disable(hw->clk);
> -       clk_put(hw->clk);
> -
> -       iounmap(hw->regs);
> -
> -       release_mem_region(hw->res->start, resource_size(hw->res));
> -       kfree(hw->ioarea);
> -
>         spi_master_put(hw->master);
>         return 0;
>  }

Great, thanks for your help.

Acked-by: <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> --
> 1.7.10.4
>
>



-- 
Wan ZongShun.
www.mcuos.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
