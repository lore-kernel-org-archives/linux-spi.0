Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708623;
	b=lvJRJjLma5hLuc8kQ1CfQF0DPIXQhZkAUONqR6+f0oFKdO+hBaIM61SQ5CnsuJ7DPIoF
	 2ugmRy1gWeQ4IxJHkw7sVVDEpGZfiwVUOB28VTF315PooOS3bF1a0Dig+XKr4QDvrT3GU
	 RNYiCTm5KFHJgcKk2WGN8kxYp+ZdiaUKWkk0g7T8JK08mFXI2USwe0OadV6dgWjmjFfqe
	 Y5XhZ82+P9DvsSicGihKRkt5gb+3694lNuRmyDYBrc5fvPBJ5ZoBCJ3miK42A+nxAE5oK
	 QNti8AjDr3Yjf6LVPc8tQwOXKVQKYHOWwYV21/sY3YWY05oadLC65ejmD5RzefzS8Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708623;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gUF18AwME3azUVhVd8I4pOcDJhpPq1HSS0ogGBT3ngE=;
	b=eMFyVupCw9vpQbiyrPbl9YIgRB2dDcs2NvRiOqS0WK5fS/vek8Idb91YrFot8WBrsZC/
	 hhysWcJ9ei7ftYwRojJ+Yrf/ItAnZatotsK3garXSiDTHmPKfadpMAfLjhUcbiILzXkiP
	 Wobj45vxTUZ6jRxDGFHDipxzpGpUJD+fPpnaQ4wA50R99PE+i+6PnDeOMY/YztKyy7aV/
	 CJgGySsZSqyBxVJxelT3NmZLKdWbpF4jxCPhJlCW3XktcCSfWAgn0tasbhxXfM9km/wlF
	 wJAEE6xURHX2qCJoOKV5QSeGifojA+0xXE/VHjFcTJQJrHC9xfmtrPvDQx44crsgvNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kc0z8L6p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D88606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kc0z8L6p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B569D1F000C4;
	Thu, 26 Nov 2026 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708622;
	bh=gUF18AwME3azUVhVd8I4pOcDJhpPq1HSS0ogGBT3ngE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Kc0z8L6pIKfWCRq2AZVL00BjOMT551JPyql/1qKfsquM/jp+xTO+MnBorAkr4m+F3
	 3BYYj6oeupW1J8gs3m+3oE9tRlW5nwhylD4AOdXRVxPY8BwpnoaJOa6fLpDne6TGtz
	 SWt/mg5n7aBnDS4KIeQ5L6MxRb0QWdcR6ilzRBstIiiotMZrU18iGJcBr5tlyHpVHJ
	 hSfnlngk/gnm4BGTCud0yMnzmu/UNqG1flKD8UKoAh+JMbSCl11vJ8o34K8vo+iqWh
	 9rsP+M1mlbnmYDxlGjASe82lBy4tCHs2i2xxexod7k1VIyN9yRSr71QZuAEkIwaV6R
	 fcq2yt/7Xm4GQ==
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
Subject: Re: [PATCH] spi: cadence-quadspi: Stop controller on shutdown
From: Mark Brown <broonie@kernel.org>
To: Srikanth Boyapally <srikanth.boyapally@amd.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 michal.simek@amd.com, git@amd.com, 
 Mohammad Zeeshan <zeeshan.mohammad2@amd.com>
In-Reply-To: <20261126-ospi_shutdown_v1-v1-1-5aa6e65d76d7@amd.com>
References: <20261126-ospi_shutdown_v1-v1-1-5aa6e65d76d7@amd.com>
Date: Thu, 26 Nov 2026 15:56:58 +0000
Message-Id: <179570861879.142532.8629241586962212713.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qmoFrJ56+KRGEpf6c6KsM2IHJBOdpVWxzoSnhWSiPjE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5ws70pH/++vWMw4QvzUunJYVdX3Vd3Wb5/58fzjltO
 mXq61mj21HKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJ8H1lZLhyQScjbVvx+jdh
 OlbfFZd+1p76SOKB/n/7F+rC72+v+n2N4ReT8f62gFv68U13ZP9+3d11bJpSUpMye/tidv3vFnd
 mdfACAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Stop the Cadence QSPI controller during an orderly reboot or kexec so
> the next boot stage can take over the hardware.

> Reject new SPI memory operations and suspend the SPI controller to
> drain operations already holding the bus lock. If runtime PM has
> already stopped the hardware, skip the register accesses.

> Wait for the controller to go idle, mask interrupts, and disable the
> IRQ line before clearing pending status and turning off the clocks.
> Disabling the IRQ line waits for any running handler, which accesses
> controller registers.

> +static void cqspi_shutdown(struct platform_device *pdev)
> +{
> +	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	/* Block new SPI memory operations and drain any active operation. */
> +	refcount_set(&cqspi->refcount, 0);

It would be nicer to take the bus lock instead so we let the currently
active message complete, ensuring a complete transaction will reduce the
risk that we'll confuse devices we're actively working with when we shut
down.

> +	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);

cqspi_versal_indirect_read_dma() suggests there's a separate DMA
interrupt on that device that also needs masking.

> +	cqspi_runtime_suspend(dev);

See 30dbc1c8d50f (spi: cadence-qspi: defer runtime support on socfpga if
reset bit is enabled) - this needs some quirking for SoCFPGA systems I
think.

-- 
Mark Brown <broonie@kernel.org>
