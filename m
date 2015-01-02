From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RFT] spi: dw: Fix off-by-one for checking fifo depth
Date: Fri, 02 Jan 2015 16:02:08 +0200
Message-ID: <1420207328.12456.15.camel@linux.intel.com>
References: <1418976099.23257.4.camel@phoenix>
	 <1418989567.17201.71.camel@linux.intel.com>
	 <CAFRkauAeny6cSrqDq=NpNrx2eyZ8sCzoWzH_KpTxTreuXuWwMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauAeny6cSrqDq=NpNrx2eyZ8sCzoWzH_KpTxTreuXuWwMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 2014-12-20 at 10:17 +0800, Axel Lin wrote:
> 2014-12-19 19:46 GMT+08:00 Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:
> > On Fri, 2014-12-19 at 16:01 +0800, Axel Lin wrote:
> >> The fifo depth could be from 2 to 256 from HW spec, so fix off-by-one for
> >> checking fifo depth.
> >> Without this patch, fifo is 258 after for loop iteration for the "no-match"
> >> case. So below line does not catch the "no-match" case.
> >>         dws->fifo_len = (fifo == 257) ? 0 : fifo;
> >
> > Seems reasonable, but never tried because in case of Medfield device we
> > have fifo size defined.
> >
> > I would try this in January.
> 
> hi Andy,
> 
> I check the code again and I think what current code does is:
> It tries to find the highest valid fifo depth so it checks the value it wrote
> to DW_SPI_TXFLTR. I think the valid value range is 2 ~ 256.
> So it will break out when writing 257 to DW_SPI_TXFLTR.

I think it will be considered as 1 by HW that kinda not what we want.

> 
> There is an off-by-one in dws->fifo_len setting because it assumes the
> latest register write fails so the latest valid value is fifo - 1.
> 
> So I think you can set dws->fifo_len to 0 to test current behavior first.
> 
> I guess below change should work, please test this instead my previous patch.

Something wrong with formatting below, but don't worry I applied it
manually and retested.

> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index d0d5542..1a0f266 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -621,13 +621,13 @@ static void spi_hw_init(struct dw_spi *dws)
>   if (!dws->fifo_len) {
>   u32 fifo;
> 
> - for (fifo = 2; fifo <= 257; fifo++) {
> + for (fifo = 2; fifo <= 256; fifo++) {
>   dw_writew(dws, DW_SPI_TXFLTR, fifo);
>   if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
>   break;
>   }
> 
> - dws->fifo_len = (fifo == 257) ? 0 : fifo;
> + dws->fifo_len = (fifo == 2) ? 0 : fifo - 1;
>   dw_writew(dws, DW_SPI_TXFLTR, 0);
>   }
>  }

So, my diff looks like:

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 549f5c96..83d17e38 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -595,7 +595,7 @@ static void dw_spi_cleanup(struct spi_device *spi)
 }
 
 /* Restart the controller, disable all interrupts, clean rx fifo */
-static void spi_hw_init(struct dw_spi *dws)
+static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 {
        dw_spi_disable_intr(dws);
 
@@ -606,14 +606,15 @@ static void spi_hw_init(struct dw_spi *dws)
        if (!dws->fifo_len) {
                u32 fifo;
 
-               for (fifo = 2; fifo <= 257; fifo++) {
+               for (fifo = 2; fifo <= 256; fifo++) {
                        dw_writew(dws, DW_SPI_TXFLTR, fifo);
                        if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
                                break;
                }
-
-               dws->fifo_len = (fifo == 257) ? 0 : fifo;
                dw_writew(dws, DW_SPI_TXFLTR, 0);
+
+               dws->fifo_len = (fifo == 2) ? 0 : fifo - 1;
+               dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
        }
 }
 
@@ -653,7 +654,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
        master->dev.of_node = dev->of_node;
 
        /* Basic HW init */
-       spi_hw_init(dws);
+       spi_hw_init(dev, dws);
 
        if (dws->dma_ops && dws->dma_ops->dma_init) {
                ret = dws->dma_ops->dma_init(dws);
@@ -718,7 +719,7 @@ int dw_spi_resume_host(struct dw_spi *dws)
 {
        int ret;
 
-       spi_hw_init(dws);
+       spi_hw_init(&dws->master->dev, dws);
        ret = spi_master_resume(dws->master);
        if (ret)
                dev_err(&dws->master->dev, "fail to start queue (%d)\n", ret);

Feel free to amend it if needed. For the fix itself get my

Reviewed-and-tested-by: Andy Shevchenko
<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>


-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
