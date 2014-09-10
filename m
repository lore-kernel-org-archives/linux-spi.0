From: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v5] spi: spi-imx: add DMA support
Date: Wed, 10 Sep 2014 13:46:22 +0800
Message-ID: <20140910054621.GA29307@Robin-OptiPlex-780>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
 <540FD084.6000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<marex-ynQEQJNshbs@public.gmane.org>, <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <540FD084.6000805-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Sep 10, 2014 at 09:46:04AM +0530, Varka Bhadram wrote:
> On 09/10/2014 07:00 AM, Robin Gong wrote:
> >Enable DMA support on i.mx6. The read speed can increase from 600KB/s
> >to 1.2MB/s on i.mx6q. You can disable or enable dma function in dts.
> 
> (...)
> 
> >+
> >+static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
> >+			     struct spi_master *master,
> >+			     const struct resource *res)
> >+{
> >+	struct dma_slave_config slave_config = {};
> >+	int ret;
> >+
> >+	/* Prepare for TX DMA: */
> >+	master->dma_tx = dma_request_slave_channel(dev, "tx");
> >+	if (!master->dma_tx) {
> >+		dev_err(dev, "cannot get the TX DMA channel!\n");
> >+		ret = -EINVAL;
> >+		goto err;
> >+	}
> >+
> >+	slave_config.direction = DMA_MEM_TO_DEV;
> >+	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
> >+	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> >+	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
> >+	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
> >+	if (ret) {
> >+		dev_err(dev, "error in TX dma configuration.");
> >+		
> 
> Missed terminating new line..
>
You mean lack "\n" in the print info? If yes, I can improve it in v6.
> -- 
> Regards,
> Varka Bhadram.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
