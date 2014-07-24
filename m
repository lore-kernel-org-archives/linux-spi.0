From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Thu, 24 Jul 2014 14:18:40 +0300
Message-ID: <1406200720.8530.4.camel@smile.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Kweh Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406196111-22861-1-git-send-email-hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2014-07-24 at 18:01 +0800, Kweh Hock Leong wrote:
> From: "Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Intel LPSS Baytrail supports two DMA controllers and SPI is only
> using one of the DMA controller. During DMA channel request,
> we need to ensure the requested Tx and Rx channels are from the correct
> DMA controller. Thus, we add extra checking in filter callback funtion
> by matching against the DMA controller device name.

I think this is bot good approach.

I already discussed with Mika how we could do this better for devices in
PCI mode. (Seems you have the problem only in PCI, right?)

So, for PCI case you have to get the device with BDF = BD0, where BDF is
Bus:Device:Function triplet for an SPI controller itself.

I don't know if it's good to enable CONFIG_PCI_QUIRKS and tweak
pci_dev_dma_source. In that case you just call pci_get_dma_source() and
get a PCI device of the DMA.

> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-pxa2xx-dma.c   | 5 +++++
>  drivers/spi/spi-pxa2xx-pci.c   | 3 +++
>  include/linux/spi/pxa2xx_spi.h | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
> index c41ff14..4c4e918 100644
> --- a/drivers/spi/spi-pxa2xx-dma.c
> +++ b/drivers/spi/spi-pxa2xx-dma.c
> @@ -214,6 +214,11 @@ static bool pxa2xx_spi_dma_filter(struct dma_chan *chan, void *param)
>  {
>  	const struct pxa2xx_spi_master *pdata = param;
>  
> +	if (pdata->dma_devname) {
> +		if (strcmp(dev_name(chan->device->dev), pdata->dma_devname))
> +			return false;
> +	}
> +
>  	return chan->chan_id == pdata->tx_chan_id ||
>  	       chan->chan_id == pdata->rx_chan_id;
>  }
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index c1865c9..7a21bce 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -21,6 +21,7 @@ struct pxa_spi_info {
>  	int tx_chan_id;
>  	int rx_slave_id;
>  	int rx_chan_id;
> +	char *dma_devname;
>  };
>  
>  static struct pxa_spi_info spi_info_configs[] = {
> @@ -41,6 +42,7 @@ static struct pxa_spi_info spi_info_configs[] = {
>  		.tx_chan_id = 0,
>  		.rx_slave_id = 1,
>  		.rx_chan_id = 1,
> +		.dma_devname = "0000:00:1e.0"
>  	},
>  };
>  
> @@ -72,6 +74,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
>  	spi_pdata.rx_slave_id = c->rx_slave_id;
>  	spi_pdata.rx_chan_id = c->rx_chan_id;
>  	spi_pdata.enable_dma = c->rx_slave_id >= 0 && c->tx_slave_id >= 0;
> +	spi_pdata.dma_devname = c->dma_devname;
>  
>  	ssp = &spi_pdata.ssp;
>  	ssp->phys_base = pci_resource_start(dev, 0);
> diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
> index 82d5111..264c3cb 100644
> --- a/include/linux/spi/pxa2xx_spi.h
> +++ b/include/linux/spi/pxa2xx_spi.h
> @@ -34,6 +34,7 @@ struct pxa2xx_spi_master {
>  	int tx_chan_id;
>  	int rx_slave_id;
>  	int tx_slave_id;
> +	char *dma_devname;
>  
>  	/* For non-PXA arches */
>  	struct ssp_device ssp;


-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
