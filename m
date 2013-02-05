From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
	possible
Date: Tue, 05 Feb 2013 14:22:02 +0000
Message-ID: <20130205142202.860453E1265@localhost>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
	<1359395857-1235-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1359395857-1235-3-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 28 Jan 2013 17:57:34 +0000, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> With the new OF DMA binding, it is possible to completely avoid the
> need for platform_data for configuring a DMA channel. In cases where the
> platform has already been converted, calling dma_request_slave_channel
> should get all the necessary information from the device tree.
> 
> Like the patch that converts the dw_dma controller, this is completely
> untested and is looking for someone to try it out.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Cc: linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/spi/spi-pl022.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index b0fe393..371cc66f 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1139,6 +1139,35 @@ err_no_rxchan:
>  	return -ENODEV;
>  }
>  
> +static int pl022_dma_autoprobe(struct pl022 *pl022)
> +{
> +	struct device *dev = &pl022->adev->dev;
> +
> +	/* automatically configure DMA channels from platform, normally using DT */
> +	pl022->dma_rx_channel = dma_request_slave_channel(dev, "rx");
> +	if (!pl022->dma_rx_channel)
> +		goto err_no_rxchan;
> +
> +	pl022->dma_tx_channel = dma_request_slave_channel(dev, "tx");
> +	if (!pl022->dma_tx_channel)
> +		goto err_no_txchan;
> +
> +	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!pl022->dummypage)
> +		goto err_no_dummypage;
> +
> +	return 0;
> +
> +err_no_dummypage:
> +	dma_release_channel(pl022->dma_tx_channel);
> +	pl022->dma_tx_channel = NULL;
> +err_no_txchan:
> +	dma_release_channel(pl022->dma_rx_channel);
> +	pl022->dma_rx_channel = NULL;
> +err_no_rxchan:
> +	return -ENODEV;
> +}
> +		
>  static void terminate_dma(struct pl022 *pl022)
>  {
>  	struct dma_chan *rxchan = pl022->dma_rx_channel;
> @@ -1167,6 +1196,11 @@ static inline int configure_dma(struct pl022 *pl022)
>  	return -ENODEV;
>  }
>  
> +static inline int pl022_dma_autoprobe(struct pl022 *pl022)
> +{
> +	return 0;
> +}
> +
>  static inline int pl022_dma_probe(struct pl022 *pl022)
>  {
>  	return 0;
> @@ -2226,8 +2260,13 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  		goto err_no_irq;
>  	}
>  
> -	/* Get DMA channels */
> -	if (platform_info->enable_dma) {
> +	/* Get DMA channels, try autoconfiguration first */
> +	status = pl022_dma_autoprobe(pl022);
> +
> +	/* If that failed, use channels from platform_info */
> +	if (status == 0)
> +		platform_info->enable_dma = 1;
> +	else if (platform_info->enable_dma) {
>  		status = pl022_dma_probe(pl022);
>  		if (status != 0)
>  			platform_info->enable_dma = 0;
> -- 
> 1.8.0
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
