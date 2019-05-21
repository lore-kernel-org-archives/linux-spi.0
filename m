From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Date: Tue, 21 May 2019 09:48:28 +0530
Message-ID: <20190521041828.GG15118@vkoul-mobl>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-12-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557249513-4903-12-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07-05-19, 09:16, Robin Gong wrote:
> Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
> check ignore such special case without dma channel enabled, which caused
> ecspi1 rx works failed. Actually, no need to check event_id0, checking
> event_id1 is enough for DEV_2_DEV case because it's so lucky that event_id1
> never be 0.

Well is that by chance or design that event_id1 will be never 0?

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a495c7f..86594fc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1370,8 +1370,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  
>  	sdma_channel_synchronize(chan);
>  
> -	if (sdmac->event_id0)
> -		sdma_event_disable(sdmac, sdmac->event_id0);
> +	sdma_event_disable(sdmac, sdmac->event_id0);
> +
>  	if (sdmac->event_id1)
>  		sdma_event_disable(sdmac, sdmac->event_id1);
>  
> @@ -1670,11 +1670,9 @@ static int sdma_config(struct dma_chan *chan,
>  	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
>  
>  	/* Set ENBLn earlier to make sure dma request triggered after that */
> -	if (sdmac->event_id0) {
> -		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
> -			return -EINVAL;
> -		sdma_event_enable(sdmac, sdmac->event_id0);
> -	}
> +	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
> +		return -EINVAL;
> +	sdma_event_enable(sdmac, sdmac->event_id0);
>  
>  	if (sdmac->event_id1) {
>  		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
> -- 
> 2.7.4
> 

-- 
~Vinod
