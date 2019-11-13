From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 7/9] spi: s3c64xx: Use dma_request_chan() directly for
 channel request
Date: Thu, 14 Nov 2019 01:40:49 +0200
Message-ID: <20191113234049.GA1249@jack.zhora.eu>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-8-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, radu_nicolae.pirea@upb.ro, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linus.walleij@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org, andi@etezian.org,
        ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vkoul@kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-arm-msm@vger.kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux-tegra@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191113094256.1108-8-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Peter,

>  	if (!is_polling(sdd)) {
>  		/* Acquire DMA channels */
> -		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
> -								  "rx");
> +		sdd->rx_dma.ch = dma_request_chan(&pdev->dev, "rx");

I have a little concern here. We have two funcions
'dma_request_chan' and  'dma_request_channel' don't we end up
making some confusion here?

Wouldn't it make more sense renaming 'dma_request_chan' to
'dma_request_slave_channel_reason'?

Thanks,
Andi
