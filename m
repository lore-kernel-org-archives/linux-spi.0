Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346593939B1;
	Mon, 15 Jun 2026 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501864; cv=none; b=BX9j8tkRkx3wfPCO97G7HZ0LI0AlTZRrlSUxO5sIaJt+vQRKTA3lizvNaZ6eJNehUX05sHZWkGyX9KnkGnhWJrXvZIiVkMOnvJPOg4777zB92UlriRDGQdtDBBAqLKdqz+onZqoCwN91A6Q6wHx78N0gQ+qUjQSfQZoYdRGgI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501864; c=relaxed/simple;
	bh=U4wr89G0y+eb/D9ZojMnHnHKBI8My7W3RylcKRMTlPM=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=H+xst1C3RIsBN0zNXHkaVYVHZcFOaIseKNSSXmAcE3szQckT9BErO7uLxBsdpJXhnHz0wmLZHcNTUiJNh/G+CWpyRVjFXRshs2XkHnGovvqbx67CY0ftn18kqjBY3LiQ8f/CHfiwUlR+9eWK9FgfjyOo/g4R1oJR7iETN2+IRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eqKr2rNh; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eqKr2rNh"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id Z00owyUlSUNPnZ00pwigHQ; Mon, 15 Jun 2026 07:37:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1781501851;
	bh=ZXY52u/Dgw0vha9d0r4RlJN6YAqOKZmlVFqYLCVvjnU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=eqKr2rNhPDYK72SwsA4Z7bwdCrOl7TH/9gx+rSnwYgJwjOiqPlVFQ1+BnOtqPB9Hc
	 MNu9NTkBE9rKLZv7NB+MfacFEPGtVvy61KzON/CETf71lSkneNoL/ilymgEftLaYf/
	 WQ/K70c99VCdwMteShaMN6jGlWOGfHvdeX2wd3NrG9r8W0j4lDlYxAKmEsYBKYCt56
	 sWTevWYxXnBZ/dBqYAetABqfm6kWeF1TaH5agOUfHHBZHATXFP3QbXPF4tTspAX4ho
	 dD414R3ffLYrwMddyUQdy6kbGgVORvR52fIExgYIzy6KLHp5lEFDzoVLIkrxp6+D2I
	 gK6agx76mbeXg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Jun 2026 07:37:31 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <71b00ff8-a872-4bb2-aa5b-6ca7677f6a57@wanadoo.fr>
Date: Mon, 15 Jun 2026 07:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] spi: dw: use threaded interrupt and optimize the
 threaded ISR
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20260615044039.9750-1-jszhang@kernel.org>
 <20260615044039.9750-6-jszhang@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jszhang@kernel.org
In-Reply-To: <20260615044039.9750-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 15/06/2026 à 06:40, Jisheng Zhang a écrit :
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.
> 
> Use threaded interrupt and move the SPI transfer handling to an
> interrupt thread.
> 
> After that, since the dw_reader() and dw_writer() are called in
> threaded ISR now, so we can delay the unmasking interrupts until no
> rx and tx action is taken, thus reduce the interrupt numbers further.
> 
> Tested with below two cmds
> ./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1
> 
> ./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1000
> ./rtla timerlat top -q -k -P f:95
> 
> The first cmd is to check the interrupt numbers optmizaion result, the
> 2nd cmd group is to check the threaded interrupt improvement.
> 
> Before the patch:
> each 32KB spi spidev_test transfer triggers 33118 interrupts
> 
> spidev_test reports ~22090kbps
> and rtla reports:
>                                       Timer Latency
>    0 00:00:37   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>    0 #9958      |        1         0        67    103394 |        6         4      2198    105031
>    1 #36902     |        1         0         1        18 |        5         4         5        29
> 
> After the patch:
> each 32KB spi spidev_test transfer only triggers 3 interrupts
> 
> spidev_test reports ~23520kbps
> and now rtla reports:
>                                      Timer Latency
>    0 00:00:58   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
> CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
>    0 #58362     |        1         0         0        29 |        6         3         4        56
>    1 #58363     |        1         0         1        23 |        6         4         5        68
> 
> In summary:
> before the patch	after the patch
> 33118 interrutps	3 interrupts	 	reduced by 11038 times!
> 103394 us max latency	29 us max latency	reduced by 3564 times!
> 22090 kbps		23520 kbps		improved by 6.5%	
> 
> Signed-off-by: Jisheng Zhang <jszhang-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   drivers/spi/spi-dw-core.c | 100 +++++++++++++++++++++++---------------
>   1 file changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index feac17655847..cc4cc058ee72 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -132,10 +132,11 @@ static inline u32 dw_spi_rx_max(struct dw_spi *dws)
>   	return min_t(u32, dws->rx_len, dw_readl(dws, DW_SPI_RXFLR));
>   }
>   
> -static void dw_writer(struct dw_spi *dws)
> +static u32 dw_writer(struct dw_spi *dws)
>   {
>   	u32 max = dw_spi_tx_max(dws);
>   	u32 txw = 0;
> +	u32 tx = 0;
>   
>   	while (max--) {
>   		if (dws->tx) {
> @@ -150,13 +151,16 @@ static void dw_writer(struct dw_spi *dws)
>   		}
>   		dw_write_io_reg(dws, DW_SPI_DR, txw);
>   		--dws->tx_len;
> +		++tx;
>   	}
> +	return tx;
>   }
>   
> -static void dw_reader(struct dw_spi *dws)
> +static u32 dw_reader(struct dw_spi *dws)
>   {
>   	u32 max = dw_spi_rx_max(dws);
>   	u32 rxw;
> +	u32 rx = 0;
>   
>   	while (max--) {
>   		rxw = dw_read_io_reg(dws, DW_SPI_DR);
> @@ -171,7 +175,9 @@ static void dw_reader(struct dw_spi *dws)
>   			dws->rx += dws->n_bytes;
>   		}
>   		--dws->rx_len;
> +		++rx;
>   	}
> +	return rx;
>   }
>   
>   int dw_spi_check_status(struct dw_spi *dws, bool raw)
> @@ -210,42 +216,59 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
>   }
>   EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, "SPI_DW_CORE");
>   
> -static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
> +static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
>   {
> -	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
> +	struct spi_controller *ctlr = dev_id;
> +	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
> +	u16 irq_status = dw_readl(dws, DW_SPI_RISR);
> +	u32 rx, tx, imask, mask = 0;
> +
> +	do {
> +		/*
> +		 * Read data from the Rx FIFO every time we've got a chance executing
> +		 * this method. If there is nothing left to receive, terminate the
> +		 * procedure. Otherwise adjust the Rx FIFO Threshold level if it's a
> +		 * final stage of the transfer. By doing so we'll get the next IRQ
> +		 * right when the leftover incoming data is received.
> +		 */
> +		rx = dw_reader(dws);
> +		if (!dws->rx_len) {
> +			mask = DW_SPI_INT_MASK;
> +			spi_finalize_current_transfer(dws->ctlr);
> +		} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
> +			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
> +		}
> +
> +		/*
> +		 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
> +		 * disabled after the data transmission is finished so not to
> +		 * have the TXE IRQ flood at the final stage of the transfer.
> +		 */
> +		if (irq_status & DW_SPI_INT_TXEI) {
> +			tx = dw_writer(dws);
> +			if (!dws->tx_len)
> +				mask = DW_SPI_INT_TXEI;
> +		}
> +	} while (rx != 0 || tx != 0);
> +
> +	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
> +		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
> +	imask &= ~mask;
> +	dw_spi_umask_intr(dws, imask);
>   
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
> +{
>   	if (dw_spi_check_status(dws, false)) {
>   		spi_finalize_current_transfer(dws->ctlr);
>   		return IRQ_HANDLED;
>   	}
>   
> -	/*
> -	 * Read data from the Rx FIFO every time we've got a chance executing
> -	 * this method. If there is nothing left to receive, terminate the
> -	 * procedure. Otherwise adjust the Rx FIFO Threshold level if it's a
> -	 * final stage of the transfer. By doing so we'll get the next IRQ
> -	 * right when the leftover incoming data is received.
> -	 */
> -	dw_reader(dws);
> -	if (!dws->rx_len) {
> -		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
> -		spi_finalize_current_transfer(dws->ctlr);
> -	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
> -		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
> -	}
> -
> -	/*
> -	 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
> -	 * disabled after the data transmission is finished so not to
> -	 * have the TXE IRQ flood at the final stage of the transfer.
> -	 */
> -	if (irq_status & DW_SPI_INT_TXEI) {
> -		dw_writer(dws);
> -		if (!dws->tx_len)
> -			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
> -	}
> +	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
>   
> -	return IRQ_HANDLED;
> +	return IRQ_WAKE_THREAD;
>   }
>   
>   static irqreturn_t dw_spi_irq(int irq, void *dev_id)
> @@ -944,13 +967,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
>   	/* Basic HW init */
>   	dw_spi_hw_init(dev, dws);
>   
> -	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
> -			  ctlr);
> -	if (ret < 0 && ret != -ENOTCONN) {
> -		dev_err(dev, "can not request IRQ\n");
> -		goto err_free_ctlr;
> -	}
> -
>   	dw_spi_init_mem_ops(dws);
>   
>   	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
> @@ -990,7 +1006,7 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
>   	if (dws->dma_ops && dws->dma_ops->dma_init) {
>   		ret = dws->dma_ops->dma_init(dev, dws);
>   		if (ret == -EPROBE_DEFER) {
> -			goto err_free_irq;
> +			goto err_free_ctlr;
>   		} else if (ret) {
>   			dev_warn(dev, "DMA init failed\n");
>   		} else {
> @@ -999,6 +1015,13 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
>   		}
>   	}
>   
> +	ret = request_threaded_irq(dws->irq, dw_spi_irq, dw_spi_irq_thread_fn,
> +				   IRQF_SHARED, dev_name(dev), ctlr);
> +	if (ret < 0 && ret != -ENOTCONN) {
> +		dev_err(dev, "can not request IRQ\n");
> +		goto err_free_ctlr;

Hi,

I guess that the error handling path should be updated to move 
free_irq() a few lines above.

Here, IIUC, we should jump to err_dma_exit to undo the dma_init stuff, 
but without calling free_irq().

> +	}
> +
>   	ret = spi_register_controller(ctlr);
>   	if (ret) {
>   		dev_err_probe(dev, ret, "problem registering spi controller\n");
> @@ -1012,7 +1035,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
>   	if (dws->dma_ops && dws->dma_ops->dma_exit)
>   		dws->dma_ops->dma_exit(dws);
>   	dw_spi_enable_chip(dws, 0);
> -err_free_irq:
>   	free_irq(dws->irq, ctlr);
>   err_free_ctlr:
>   	spi_controller_put(ctlr);


Also, but completly unrelated to this patch, dw_spi_enable_chip(0) and 
dw_spi_enable_chip(1) seem to be paired.

Is it in purpose that at [1], it is left disabled?

[1]: 
https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/spi/spi-dw-core.c#L453

Just my 2c,

CJ
