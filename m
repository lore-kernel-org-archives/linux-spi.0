Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064672;
	b=LnA4gts38k+wW5zTsPlJSmpCTeJIxmFsHwDd22BIwji6M4MrPmhR+7xSnVVP3qNgcU8u
	 erb4Que54ZpTndLXBkoipF+aJdRAbbzmIbZFWkOW0X2zXVWjHKFL4M8WN2uBUFEJCfXch
	 ESVcvaoj/tZMvH0a131CtzNdYjt9RXF33XdCd9NLGsmIXL+KPPRoIDPZDhwXOPLuqoS+j
	 +7uBcHT881i0HzecnjqOlYvkpoHZw9Hk+Mhtj+JDOTvtZq+6iYDbw7byjsmoCCK22Mkjt
	 SdDtGcuZMsunC3dgwaGHVfl0wtcylmZft10BPqQecqnY31Uw4TkxME4l2hS9adzYtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064672;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OrS8Vw9EJK4CMhHFx8Kx1+vACI7GK4ya2o51LnoPIt4=;
	b=lA4ExPm69CXDdeYNhDtN0iLrcPikXYYXSdxKzwMAXMGtp9wCZxeynJKDfUUb4BpMaLxx
	 aw+ZZltMOisnA0LluFxOc1l9K+ZH6b12VpFyJLchUnz4BCPjRYP/xdouMWctHTfX4QXOV
	 FYDhgs873zR3A+nv8wTjVUFFZA8aODC9ydaBemzfZ+GPMvP8wGKdQsCh+KsitpH1vOo0n
	 K7RjouoJ3xILru/4uDaQ5giakIYaGpr2H8muzMaRtblVCFf11i27IoTBFiQV/ZHZRyh7Z
	 sCnrLWF2ukF843AHE24tQbLJvPN4LxZYd2HQxu5IgimSg8OTwPkEfcg4kIdyuBLUq7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+lLv2Ae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDA606B89B;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G+lLv2Ae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB0B1F008A2;
	Sat,  7 Nov 2026 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064671;
	bh=OrS8Vw9EJK4CMhHFx8Kx1+vACI7GK4ya2o51LnoPIt4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=G+lLv2AeIPBg9Doy0iFL/uNEXU2efyC6xo4Rli+CowStHjXgbYPXLMMrX1PZdDKpu
	 wnUT/kceUI5I2p6H6pTcZucU7jkUL2Zwe3NM48vWtu3CRwAm7NuK1E+2e/jZRRsJ3A
	 OSiG07iIaKW9rtj/TJuojw/E8MXDLbnYcn5OwPxvedDyq8f//2H+pTB8aAmg16UBzz
	 Fs5PeLLM7N537lrj5Icp8XEJiZAdPS4AYUxcI4IOqGPYmh0aqhkvmL3z9S22fPkYkl
	 FdPFoSfG8NylUtHMby9Sa2rIMJ1JkFK4beZB+mS6Zmd4uWakU4NzUfe6pL4X9edtOs
	 NAQuUohNQDnSQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id C01092AB31C6;
	Sat, 07 Nov 2026 15:17:49 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/8] spi: loongson: Add interrupt support for SPI
 controller
From: Mark Brown <broonie@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
 Huacai Chen <chenhuacai@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Mark Brown <broonie@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
 linux-spi@vger.kernel.org
In-Reply-To: <7258e7e16b8a563e60b7129946c292f70aeee1d5.1793689461.git.zhoubinbin@loongson.cn>
References: <cover.1793689461.git.zhoubinbin@loongson.cn>
 <7258e7e16b8a563e60b7129946c292f70aeee1d5.1793689461.git.zhoubinbin@loongson.cn>
Date: Sat, 07 Nov 2026 15:17:48 +0000
Message-Id: <179406466808.3424803.8169701061345998672.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sjIYzY9UPQTzvhV4lLGLUIsOUJ29rpXZkCc9wF6r4a0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO8pOezh5hfLMEpUFh065aWem7FDOXzdNhN/6QZ5+W
 Q1Hwl+ujlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExk1QRGhkOnO2c2LX9wRUOu
 Pk1M7KFE9InZiy70K/v8O1X7I/zEy5cMfwXzDBjXLeas2qMt9qO2Ubh/1oQHDBGblkg+jV1y98/
 mxRwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The Loongson SPI controller can generate an interrupt on byte
> completion.  Add an interrupt-driven transfer path and use it when an
> IRQ is available, while keeping the existing polling path as a fallback.

> +	/* Read out the byte that was clocked in */
> +	regmap_read(priv->regmap, LOONGSON_SPI_FIFO_REG, &data);
> +	if (priv->rx_ptr)
> +		priv->rx_ptr[priv->count] = (u8)data;

We should really have a handle_err() which stops the transfer running,
otherwise this might run after a timeout has stopped things and told the
user that it owns the buffers again.

> +static size_t loongson_spi_max_transfer_size(struct spi_device *spi)
> +{
> +	return LOONGSON_SPI_MAX_XFER_SIZE;

Is there a particular reason to encode this limit, it doesn't look like
it comes from the hardware.

> +	/*
> +	 * Split large transfers so that each individual spi_transfer
> +	 * completes well within the SPI core's completion timeout.
> +	 * We allow roughly one second of data per chunk, capped by
> +	 * the controller's hardware maximum transfer size.
> +	 */
> +	speed_hz = m->spi->max_speed_hz ? m->spi->max_speed_hz : host->max_speed_hz;
> +	maxsize = min_t(size_t, hw_max, (size_t)speed_hz / 8);
> +	maxsize = max_t(size_t, maxsize, 64);

The core should already be scaling the timeout based on the transfer
parameters?

> @@ -23,7 +23,11 @@ static int loongson_spi_pci_register(struct pci_dev *pdev, const struct pci_devi
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to request and remap memory");
>  
> -	ret = loongson_spi_init_controller(dev, reg_base);
> +	irq = pci_irq_vector(pdev, 0);
> +	if (irq < 0)
> +		dev_info(dev, "no IRQ available, will use PIO mode");

This either needs pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES)
or a check for irq <= 0.

> -	ret = loongson_spi_init_controller(dev, reg_base);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		dev_info(dev, "no IRQ specified, will use PIO mode");

This should handle -EPROBE_DEFER, and since the IRQ is optional it
should be platform_get_irq_optional().

-- 
Mark Brown <broonie@kernel.org>
