Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4921ABD7;
	Wed, 20 May 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290735; cv=none; b=pBDfRQciIFV94GB/3hC1LsDKfBxXxw1+YSXVN4CurLPyQLK7Z6mRUC9igmf8cks/kqrV8wczg3C5xORegzfjFMxFoy0XPlvD5HKPqf32WJVv7dSvnLh2KiDKaQjzispiyslJ0ZX1iyfAK5Bf9ZZUQQ22Rhi3sTzdRmrcBbn+8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290735; c=relaxed/simple;
	bh=FMunUHcD9yjTAOMH61lCFzdp+GRQSe3B7neBni2XcBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoK/KkiCdosrgUtske7y70iBvTQ9mdQR/VbiI841cHCtaGqBpMlQfRH3/o2tysn5Ik3wJLHngf9eXcW7cOwzo6gOw8Eg4HAwIfkXbbi515nxpgsJSplq/30YAIw/SdMInI4yqTb8yVNoghTnc1bw7rM+FxMhkoByBE17tSIqsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=MZ9IdD6Z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="MZ9IdD6Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qeCRBprliZAhgWw96s1LS6BpSxf/Q/HJFhC6X5iOewc=; b=MZ9IdD6ZgAl0Z98xkP2GaJprQv
	aOUtU8/vM328IOTyzjLVk8upaty4OMkh2CvMPMefipbXd9xUaoJAtGYoOP0chbMqV4q59iRdkiPOy
	yhoSPKW0N6WhfYVDRdyaY2wiSeekIa0xM0cqYMiEhXzxnxJoiHtTP5u4esiApMECxBjNbYNvgE8UM
	SVLCzeIv8z/WE1mQHc5M86SLUNAQz8o/BDebi2v089J108Qoz/34OgXYCR/yQF0sd/nk7l8uNkIXk
	In76+XQFPQgqrHFMbP2uZtuwUYk4Vc6Y4mG8cwa5oUjhTYFW707H9GjdQFw/qRThQjh6L/6v94pVh
	HHAia0XQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPinX-003CMj-2x;
	Wed, 20 May 2026 15:25:28 +0000
Date: Wed, 20 May 2026 08:25:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Suresh Mangipudi <smangipudi@nvidia.com>, Krishna Yarlagadda <kyarlagadda@nvidia.com>, 
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] spi: tegra210-quad: Convert to hard IRQ with
 high-priority workqueue
Message-ID: <ag3ReYsoyCh-niZH@gmail.com>
References: <20260519155108.4092518-1-va@nvidia.com>
 <20260519155108.4092518-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519155108.4092518-2-va@nvidia.com>
X-Debian-User: leitao

On Tue, May 19, 2026 at 03:51:06PM +0000, Vishwaroop A wrote:
> Threaded IRQ handlers suffer from scheduler latency on heavily loaded
> systems, causing false transfer timeouts. Convert to hard IRQ handler
> that schedules work on a high-priority unbound workqueue.
> 
> The hard IRQ handler verifies the interrupt, caches FIFO status,
> clears and masks interrupts, then schedules bottom-half processing.
> The workqueue handler runs in process context (can sleep for DMA)
> and can execute on any CPU, avoiding CPU0 bottlenecks.

Thanks for doing this work!

> +	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> +	if (!(status & QSPI_RDY))
> +		return IRQ_NONE;
> +
> +	spin_lock(&tqspi->lock);

Can you help me to understand what the tqspi->lock protects? I am still
a bit confused by this lock, but at the first glance, I am wondering if
you don't need to have the lock while reading the status.

Thanks
--breno
