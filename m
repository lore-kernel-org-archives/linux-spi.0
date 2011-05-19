From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH resend] spi/amba-pl022: work in polling or interrupt mode
	if pl022_dma_probe fails
Date: Thu, 19 May 2011 13:36:23 -0600
Message-ID: <20110519193623.GT5109@ponder.secretlab.ca>
References: <052261410dd8d224fc199518e646abf80bfa7d4c.1305518921.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: armando.visconti@st.com, spi-devel-general@lists.sourceforge.net,
	linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
	shiraz.hashim@st.com
To: Viresh Kumar <viresh.kumar@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <052261410dd8d224fc199518e646abf80bfa7d4c.1305518921.git.viresh.kumar@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 16, 2011 at 09:40:10AM +0530, Viresh Kumar wrote:
> If pl022_dma_probe fails, we can try to transfer data in polling or interrupt
> mode. Also, set platform_info->enable_dma to 0, so that no other code tries to
> use dma.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Merged, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index dae886e..77f90de 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1068,7 +1068,7 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
>  					    pl022->master_info->dma_filter,
>  					    pl022->master_info->dma_rx_param);
>  	if (!pl022->dma_rx_channel) {
> -		dev_err(&pl022->adev->dev, "no RX DMA channel!\n");
> +		dev_dbg(&pl022->adev->dev, "no RX DMA channel!\n");
>  		goto err_no_rxchan;
>  	}
>  
> @@ -1076,13 +1076,13 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
>  					    pl022->master_info->dma_filter,
>  					    pl022->master_info->dma_tx_param);
>  	if (!pl022->dma_tx_channel) {
> -		dev_err(&pl022->adev->dev, "no TX DMA channel!\n");
> +		dev_dbg(&pl022->adev->dev, "no TX DMA channel!\n");
>  		goto err_no_txchan;
>  	}
>  
>  	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!pl022->dummypage) {
> -		dev_err(&pl022->adev->dev, "no DMA dummypage!\n");
> +		dev_dbg(&pl022->adev->dev, "no DMA dummypage!\n");
>  		goto err_no_dummypage;
>  	}
>  
> @@ -1098,6 +1098,8 @@ err_no_txchan:
>  	dma_release_channel(pl022->dma_rx_channel);
>  	pl022->dma_rx_channel = NULL;
>  err_no_rxchan:
> +	dev_err(&pl022->adev->dev,
> +			"Failed to work in dma mode, work without dma!\n");
>  	return -ENODEV;
>  }
>  
> @@ -2111,7 +2113,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (platform_info->enable_dma) {
>  		status = pl022_dma_probe(pl022);
>  		if (status != 0)
> -			goto err_no_dma;
> +			platform_info->enable_dma = 0;
>  	}
>  
>  	/* Initialize and start queue */
> @@ -2143,7 +2145,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>   err_init_queue:
>  	destroy_queue(pl022);
>  	pl022_dma_remove(pl022);
> - err_no_dma:
>  	free_irq(adev->irq[0], pl022);
>   err_no_irq:
>  	clk_put(pl022->clk);
> -- 
> 1.7.2.2
> 
> 
> ------------------------------------------------------------------------------
> Achieve unprecedented app performance and reliability
> What every C/C++ and Fortran developer should know.
> Learn how Intel has extended the reach of its next-generation tools
> to help boost performance applications - inlcuding clusters.
> http://p.sf.net/sfu/intel-dev2devmay
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
