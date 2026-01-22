Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162A36EAA1;
	Thu, 22 Jan 2026 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101481; cv=none; b=EowGujyfH88juOvDnfs9lSYz5b/2JdCGow/jxwB5B3mcw/nBm9vGieOSppUZ9/ZBTum0lytlptyg2UDEmvx9Qd1FU4mF0bQFOAuRpE0mwdPaqAab71S7CGUom4BsJG3h0k8HIEzUvrypH7kTWq3d5a/zNd0virEzCxCSzlAejsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101481; c=relaxed/simple;
	bh=EJUiyx0fiNzV6nZRPuLTpeqOgZYbF7x2TL30h+puJtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7DI3Zbc+aHG3nyn1KYPcF4onXNw5MizGY1dTGHKD5ym+IN3z+BaeJZJiBBdjEqzYnnFSsOk7RVNMFnmHWck3TxsM0suSnqFXfUSv/ROB7nj2X8+ea43GntLn7fg5jHgYsOP0c1gGbE+IyMQN3bMjKLxCNXhsNd4rVC5B/+c0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=puPwBOs2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="puPwBOs2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=2qmG/ca9Nm5l33OpftaEiVZnmoIEA5h4CJ2pJZwge0Y=; b=puPwBOs2Izh45sTZRkemxSV+GD
	bncJOMdT4E6IATNWnAodlOcVHAoGZc4ZcmySNQZtfdFKouEZs+Geauljr6mg++38wPAUlq2kPbX/I
	oMfLFSQMzt9Ba4cdzxT1xMJFd3IdG2JNjG1iS6rvGhh5YCIZXQy2s9nYaIUTBgK7eFTw4mCNepkTs
	K/ZspNOrd/SSOebkxWXiim/MH9aK56ESheea+Ngf2oNI/VCyIs2ek/VhX6FzAaC3KWQzH2uCz6XtW
	9X7Pff2y/1MZdBvia4skPvR38+Zd0516/kL98ydvWXvrvZo5+cEnkgn8jFpJNHnj7Fw1p1DWFmBnh
	xb4OeVJw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1viy6Z-00DAkU-Cb; Thu, 22 Jan 2026 17:04:23 +0000
Date: Thu, 22 Jan 2026 09:04:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: thierry.reding@gmail.com, treding@nvidia.com, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, puranjay@kernel.org, usamaarif642@gmail.com
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL
 pointer dereference and spurious IRQ
Message-ID: <aXJWRUhAe8F67-zG@gmail.com>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260120112242.3766700-1-va@nvidia.com>
 <aW-seUXIJv4Lz7bK@gmail.com>
 <20260121000000.0000000-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121000000.0000000-1-va@nvidia.com>
X-Debian-User: leitao

Hello Vishwaroop,

On Wed, Jan 21, 2026 at 05:56:17PM +0000, Vishwaroop A wrote:
> Hi Breno,
> 
> After reviewing Mark Brown's feedback and the code carefully, let me clarify the 
> correct logic. This is important to get right.
> 
> **IRQ Handler Semantics (per Mark Brown):**
> - IRQ_NONE = interrupt was NOT from this device
> - IRQ_HANDLED = interrupt WAS from this device (regardless of whether we fully processed it)
> 
> **The QSPI_RDY Bit:**
> This bit in QSPI_TRANS_STATUS is set by hardware when a transfer completes and triggers 
> the interrupt. Software clears it by writing 1.
> 
> **Why Your Original v1 Logic is Correct:**
> 
> Your "[PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed 
> transfer" reads QSPI_TRANS_STATUS at the start of tegra_qspi_isr_thread():
> 
>     if (!tqspi->curr_xfer) {
>         if (!(status & QSPI_RDY))
>             return IRQ_NONE;        // HW never set RDY → spurious interrupt
>         return IRQ_HANDLED;         // HW did set RDY → real interrupt, timeout processed it
>     }
> 
> **Scenario 1 - Delayed ISR (the race you're fixing):**
> 1. HW completes transfer, sets QSPI_RDY, interrupt fires
> 2. ISR thread delayed (CPU busy)
> 3. Timeout handler runs, processes transfer, clears curr_xfer
> 4. Delayed ISR finally wakes up
> 5. Reads QSPI_RDY (may still be set)
> 6. curr_xfer is NULL
> 7. Return IRQ_HANDLED → this WAS our interrupt, just processed by timeout
> 
> **Scenario 2 - Truly Spurious:**
> 1. Spurious interrupt fires
> 2. QSPI_RDY = 0 (no transfer completed)
> 3. curr_xfer is NULL
> 4. Return IRQ_NONE → not our interrupt
> 
> **Your Latest Proposal Has It Backwards:**
> 
> The version in your last email returns IRQ_HANDLED when QSPI_RDY is NOT set, which is 
> incorrect per Mark's feedback.
> 
> **For v2:**
> 
> Patches 1-5: Keep as-is from v1 (all correct)
> 
> Patch 6 ("[PATCH 6/6] spi: tegra210-quad: Protect curr_xfer check in IRQ handler"): 
> The TODO comment you added asks about keeping the lock held across the handler call. I'd 
> suggest removing the TODO and replacing it with a comment explaining why the current 
> approach is safe:
> 
>     spin_unlock_irqrestore(&tqspi->lock, flags);
> 
>     /*
>      * Lock is released here but handlers safely re-check curr_xfer under lock
>      * before dereferencing. DMA handler also needs to sleep in 
>      * wait_for_completion_*(), which cannot be done while holding spinlock.
>      */
>     if (!tqspi->is_curr_dma_xfer)
>         return handle_cpu_based_xfer(tqspi);
> 
> This documents the design decision and closes the TODO.

Thanks. I will send a v2 with patches 1 - 5 untoouched, and patch
6 updated with this document.

Thanks for the review,
--breno
