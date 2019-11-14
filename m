From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 8/9] spi: tegra114: Use dma_request_chan() directly for
 channel request
Date: Thu, 14 Nov 2019 07:06:14 +0000
Message-ID: <4ae959a4-a765-9c3b-4e61-53b7a830709a@nvidia.com>
References: <20191113094256.1108-1-peter.ujfalusi@ti.com>
 <20191113094256.1108-9-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux-tegra@vger.kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, <broonie@kernel.org>,
        <radu_nicolae.pirea@upb.ro>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <linus.walleij@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <andi@etezian.org>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113094256.1108-9-peter.ujfalusi@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On 13/11/2019 09:42, Peter Ujfalusi wrote:
> dma_request_slave_channel_reason() is:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/spi/spi-tegra114.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index e6a450d9b4f0..fc40ab146c86 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -666,8 +666,7 @@ static int tegra_spi_init_dma_param(struct tegra_spi_data *tspi,
>  	dma_addr_t dma_phys;
>  	int ret;
>  
> -	dma_chan = dma_request_slave_channel_reason(tspi->dev,
> -					dma_to_memory ? "rx" : "tx");
> +	dma_chan = dma_request_chan(tspi->dev, dma_to_memory ? "rx" : "tx");
>  	if (IS_ERR(dma_chan)) {
>  		ret = PTR_ERR(dma_chan);
>  		if (ret != -EPROBE_DEFER)
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic
