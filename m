From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] spi/rockchip: fixup incorrect dma direction setting
Date: Wed, 20 Aug 2014 10:09:56 +0200
Message-ID: <3440626.YssIeyfVzZ@phil>
References: <1408506462-3686-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: broonie@kernel.org, dianders@chromium.org, grant.likely@linaro.org,
	robh+dt@kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, olof@lixom.net, hj@rock-chips.com,
	kever.yang@rock-chips.com, xjq@rock-chips.com,
	huangtao@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com,
	zhenfu.fang@rock-chips.com, cf@rock-chips.com,
	zhangqing@rock-chips.com, hl@rock-chips.com, wei.luo@rock-chips.com
To: Addy Ke <addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408506462-3686-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Addy,

please always remember to add a real commit message, something similar to:

"Fix typo that caused the tx direction to be set twice and left out the rx 
direction."

for example.

> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index cb8fd6f..4ef3fd3 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -679,7 +679,7 @@ static int rockchip_spi_probe(struct platform_device
> *pdev) rs->dma_tx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_TXDR);
> rs->dma_rx.addr = (dma_addr_t)(mem->start + ROCKCHIP_SPI_RXDR);
> rs->dma_tx.direction = DMA_MEM_TO_DEV;
> -		rs->dma_tx.direction = DMA_DEV_TO_MEM;
> +		rs->dma_rx.direction = DMA_DEV_TO_MEM;
> 
>  		master->can_dma = rockchip_spi_can_dma;
>  		master->dma_tx = rs->dma_tx.ch;
