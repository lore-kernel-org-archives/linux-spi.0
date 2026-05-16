Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDC230BD5;
	Sat, 16 May 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947530; cv=none; b=fH3ZhzlDyRpzbBNRWD11UteKF1fEcYeYy+MQyggBRTrClqB8YjTVm5t6VBDDpMToKzTS9SJYxc4CBrnzYpCvFh13tdexdH7lqgrHWIofcdl9U4aYwfTVzCIGBAcBMzgdf+703KPIf9vd4/VKj6b1Tg/watI8WPz16GtGVSIQY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947530; c=relaxed/simple;
	bh=lbd5B9oodZPfOUeAo28ajLBuYsbpGHy3HfUdL93AmT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+JQmLJ6v1wSVnHDK+RF0YEDZn/66gZGgRZCDgctcZ+Rk0VVvJorQLx6d4UuFq4bqLuEXE+53ArR0FgVQ4gHXw9Q4NJQR/vR8D6tGnKZGtJ8/YCMZhoqotKmihV6BREFOE4IK19rq8eY9zQMLLN3mtvjx5yhpF+mqm+Fl0no4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D80DC19425;
	Sat, 16 May 2026 16:05:27 +0000 (UTC)
Message-ID: <b272b786-75d5-42f2-9622-ae4659722c44@tuxon.dev>
Date: Sat, 16 May 2026 19:05:25 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: fix resource leak on DMA buffer
 allocation failure
To: Felix Gu <ustc.gu@gmail.com>, Ryan Wanner <ryan.wanner@microchip.com>,
 Mark Brown <broonie@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Radu Pirea <radu.pirea@microchip.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
 <20260516-atmel-v1-1-674fb4707af6@gmail.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260516-atmel-v1-1-674fb4707af6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Felix,

On 5/15/26 20:20, Felix Gu wrote:
> The original code set use_dma to false when dma_alloc_coherent() fails,
> so DMA channels allocated earlier were never freed, causing a resource
> leak.
> 
> Fix by moving the bounce buffer allocation into
> atmel_spi_configure_dma() and extending atmel_spi_release_dma() to
> also free the bounce buffers. Any allocation failure in the DMA
> configuration path now rolls back both channels and buffers through
> the same release function.
> 
> Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
> Signed-off-by: Felix Gu<ustc.gu@gmail.com>
> ---
>   drivers/spi/spi-atmel.c | 113 ++++++++++++++++++++++++------------------------
>   1 file changed, 57 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 25aa294631c8..e519a86a2b45 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -559,6 +559,34 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
>   	return err;
>   }
>   
> +static void atmel_spi_release_dma(struct spi_controller *host,
> +				  struct atmel_spi *as)
> +{
> +	if (host->dma_rx) {
> +		dma_release_channel(host->dma_rx);
> +		host->dma_rx = NULL;
> +	}
> +	if (host->dma_tx) {
> +		dma_release_channel(host->dma_tx);
> +		host->dma_tx = NULL;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
> +		if (as->addr_tx_bbuf) {
> +			dma_free_coherent(&as->pdev->dev, SPI_MAX_DMA_XFER,
> +					  as->addr_tx_bbuf,
> +					  as->dma_addr_tx_bbuf);
> +			as->addr_tx_bbuf = NULL;
> +		}
> +		if (as->addr_rx_bbuf) {
> +			dma_free_coherent(&as->pdev->dev, SPI_MAX_DMA_XFER,
> +					  as->addr_rx_bbuf,
> +					  as->dma_addr_rx_bbuf);
> +			as->addr_rx_bbuf = NULL;
> +		}
> +	}
> +}
> +
>   static int atmel_spi_configure_dma(struct spi_controller *host,
>   				   struct atmel_spi *as)
>   {
> @@ -569,7 +597,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
>   	if (IS_ERR(host->dma_tx)) {
>   		err = PTR_ERR(host->dma_tx);
>   		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
> -		goto error_clear;
> +		host->dma_tx = NULL;
> +		return err;
>   	}
>   
>   	host->dma_rx = dma_request_chan(dev, "rx");
> @@ -580,12 +609,31 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
>   		 * requested tx channel.
>   		 */
>   		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
> -		goto error;
> +		host->dma_rx = NULL;
> +		goto err_release_dma;
>   	}
>   
>   	err = atmel_spi_dma_slave_config(as, 8);
>   	if (err)
> -		goto error;
> +		goto err_release_dma;
> +
> +	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
> +		as->addr_tx_bbuf = dma_alloc_coherent(dev, SPI_MAX_DMA_XFER,
> +						      &as->dma_addr_tx_bbuf,
> +						      GFP_KERNEL | GFP_DMA);
You could use dmam_alloc_coherent() and avoid bulking the failure path.

Thank you,
Claudiu
