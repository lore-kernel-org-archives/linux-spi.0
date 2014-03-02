From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix getting correct address for master
Date: Sun, 2 Mar 2014 23:09:41 +0800
Message-ID: <CAFRkauD3WFBw9VC6h+2bxcnuky7175G47+7tP8=5f4D2PeLpEQ@mail.gmail.com>
References: <1392353352.19487.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392353352.19487.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-02-14 12:49 GMT+08:00 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
> Current code set platform drvdata to dspi. However, the code in dspi_suspend()
> and dspi_resume() assumes the drvdata is the address of master.
> Fix it by setting platform drvdata to master.


Hi Mark,
I guess this one is for 3.14.

In dspi_probe(),
current code has:
        platform_set_drvdata(pdev, dspi);

However, in dspi_suspend() and dspi_resume(),
current code has:
        struct spi_master *master = dev_get_drvdata(dev);

Regards,
Axel
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index ec79f72..a253920 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -420,7 +420,6 @@ static int dspi_suspend(struct device *dev)
>
>  static int dspi_resume(struct device *dev)
>  {
> -
>         struct spi_master *master = dev_get_drvdata(dev);
>         struct fsl_dspi *dspi = spi_master_get_devdata(master);
>
> @@ -504,7 +503,7 @@ static int dspi_probe(struct platform_device *pdev)
>         clk_prepare_enable(dspi->clk);
>
>         init_waitqueue_head(&dspi->waitq);
> -       platform_set_drvdata(pdev, dspi);
> +       platform_set_drvdata(pdev, master);
>
>         ret = spi_bitbang_start(&dspi->bitbang);
>         if (ret != 0) {
> @@ -525,7 +524,8 @@ out_master_put:
>
>  static int dspi_remove(struct platform_device *pdev)
>  {
> -       struct fsl_dspi *dspi = platform_get_drvdata(pdev);
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct fsl_dspi *dspi = spi_master_get_devdata(master);
>
>         /* Disconnect from the SPI framework */
>         spi_bitbang_stop(&dspi->bitbang);
> --
> 1.8.1.2
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
