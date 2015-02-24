From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 18:09:26 +0200
Message-ID: <1424794166.2340.17.camel@mm-sol.com>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424782803-13103-1-git-send-email-stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi Stan,

On Tue, 2015-02-24 at 15:00 +0200, Stanimir Varbanov wrote:
> 

<snip>

>  #define SPI_MAX_RATE                   50000000
> @@ -143,6 +147,11 @@ struct spi_qup {
>         int     tx_bytes;
>         int     rx_bytes;
>         int     qup_v1;
> +
> +       int     dma_available;

This is more like 'use dma for this transfer", right?

> +       struct dma_slave_configrx_conf;
> +       struct dma_slave_configtx_conf;
> +       atomic_t              dma_outstanding;

Do we really need this one. See below.

>  };
> 

<snip>

> +
> +static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
> +                                               enum dma_transfer_direction dir)
> +{
> +       struct spi_qup *qup = spi_master_get_devdata(master);
> +       unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
> +       struct dma_async_tx_descriptor *desc;
> +       struct scatterlist *sgl;
> +       dma_cookie_t cookie;
> +       unsigned int nents;
> +       struct dma_chan *chan;
> +       int ret;
> +
> +       if (dir == DMA_MEM_TO_DEV) {
> +               chan = master->dma_tx;
> +               nents = xfer->tx_sg.nents;
> +               sgl = xfer->tx_sg.sgl;
> +       } else {
> +               chan = master->dma_rx;
> +               nents = xfer->rx_sg.nents;
> +               sgl = xfer->rx_sg.sgl;
> +       }
> +
> +       desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
> +       if (!desc)
> +               return -EINVAL;
> +
> +       desc->callback = spi_qup_dma_done;
> +       desc->callback_param = qup;

What if we attach callback only on RX descriptor and use
dmaengine_tx_status() for TX channel in wait for completion?

> +
> +       cookie = dmaengine_submit(desc);
> +       ret = dma_submit_error(cookie);
> +       if (ret)
> +               return ret;
> +
> +       atomic_inc(&qup->dma_outstanding);
> +
> +       return 0;
> +}
> +
> +static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
> +{
> +       struct spi_qup *qup = spi_master_get_devdata(master);
> +       int ret;
> +
> +       atomic_set(&qup->dma_outstanding, 0);
> +
> +       reinit_completion(&qup->done);

Redundant, already done in transfer_one().

> +
> +       if (xfer->rx_buf) {

Always true.

> +               ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM);
> +               if (ret)
> +                       return ret;
> +
> +               dma_async_issue_pending(master->dma_rx);
> +       }
> +
> +       if (xfer->tx_buf) {

Same.

> 
+               ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV);
> +               if (ret)
> +                       goto err_rx;
> +
> +               dma_async_issue_pending(master->dma_tx);
> +       }
> +
> +       ret = spi_qup_set_state(qup, QUP_STATE_RUN);
> +       if (ret) {
> +               dev_warn(qup->dev, "cannot set RUN state\n");
> +               goto err_tx;
> +       }
> +
> +       if (!wait_for_completion_timeout(&qup->done, msecs_to_jiffies(1000))) {

transfer_one() calculates timeout dynamically based on transfer length.

Transition in state RUN and wait for completion are already coded in transfer_one().
With little rearrangement they could be removed from here.

> +               ret = -ETIMEDOUT;
> +               goto err_tx;
> +       }
> +
> +       return 0;
> +
> +err_tx:
> +       if (xfer->tx_buf)

Always true.

> +               dmaengine_terminate_all(master->dma_tx);
> +err_rx:
> +       if (xfer->rx_buf)
> 

Same.

> +               dmaengine_terminate_all(master->dma_rx);
> +
> +       return ret;
> +}

I don't see reason for this function, based on comments so far :-).

<snip>

> 
> @@ -621,10 +881,16 @@ static int spi_qup_probe(struct platform_device *pdev)
>         writel_relaxed(0, base + SPI_CONFIG);
>         writel_relaxed(SPI_IO_C_NO_TRI_STATE, base + SPI_IO_CONTROL);
> 
> +       ret = spi_qup_init_dma(master, res->start);
> +       if (ret == -EPROBE_DEFER)
> +               goto error;

Better move resource allocation before touching hardware.

Otherwise is looking good and I know that is working :-)

Regards,
Ivan



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
