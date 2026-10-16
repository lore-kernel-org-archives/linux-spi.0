Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DF30C177;
	Fri, 16 Oct 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161913; cv=none; b=uSByOVa2zRnX5Fnsh0UNlfk3BY+sT97gmjoyCuzAlSen6vjK6S0TGZ85RJZDMLoVerZXQfuR3wJvwPrBzkIl6rFGcB8cUMNJlxaOeeJKRLdizp8dEl2dHhpbcMNQ3+jmlhivSMOZywrWzg4uiEAeUXLuklg48xzTp2AH0DvdwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161913; c=relaxed/simple;
	bh=jmELZitEhSIOY9RUMcUUOIX86AhbCbcUO1hmW/FdI1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KULFdffCSwwqBtDIldBtM9GsGnFKC0m1WirssaGpp9HUKerVI+1bI0NzU8KT/Poiu8QLSr1extCc/SVTkEt+G1TM8a8gBhtfNg/OZSglfMUNpVucHMEpzWbrG/zQMJ/3Ym4AfpHsx6vUyD4WXhojiPfacg83e59Jc4VwSGlCbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VOxKw9Mw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VOxKw9Mw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8OuZaPA2GtRZhh15wzhLlS2yNX+s76kDLb857HbaDKs=; b=VOxKw9Mwh3OYzZETVAfSxiDEjT
	3Djfk7WxPHHYQCaqrSIYEAaaZegQYCovwOkRZV+5t5e2w+25t6GESpc4GdivPP0oBckZt4XrE1NMt
	muXerQV5nfRhfylHTS+maonMGnYYTwbUuIvAtP345n1G0rdRFOXbt8wRqGAgfL/6wJTy/ngq5ymxx
	FhnXlmMBvmxI+4eIV0jqHgM8NyZiY4mJYLtt7vfYrM81mVeFOUOGLn4e+gYPc0nMiQtfCxaTlXUCG
	5mDun7Twjmb8rbq6CJadk7mNRwzo1T33Erq0+Pu6kAXr7QiPgzZaWjFWM/JANcT0AII078t/jueat
	k6EFIP6g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHjBC-0062Vp-0A;
	Fri, 16 Oct 2026 14:45:06 +0000
Date: Fri, 16 Oct 2026 07:45:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Aaron Kling <webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, 
	Suresh Mangipudi <smangipudi@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: tegra210-quad: don't overwrite refreshed status
 with lost-IRQ snapshot
Message-ID: <atI4VjOnSgBaYy67@gmail.com>
References: <20261016132520.3723412-1-va@nvidia.com>
 <20261016132520.3723412-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016132520.3723412-2-va@nvidia.com>
X-Debian-User: leitao

On Fri, Oct 16, 2026 at 01:25:19PM +0000, Vishwaroop A wrote:
> tegra_qspi_handle_timeout() captures a "lost IRQ" FIFO status snapshot
> when the ISR cache is empty on entry but QSPI_TRANS_STATUS shows the
> transfer completed. After masking the controller IRQ and draining the
> workqueue with cancel_work_sync(), it re-loads the ISR cache with
> smp_load_acquire(): if the drain observed a real ISR completion, the
> refreshed cache holds ISR-published status_reg, tx_status and rx_status
> that reflect the true hardware error state at IRQ time.
> 
> However, when both cache and snapshot are set, the code keeps the
> refreshed value in the local status variable but then unconditionally
> publishes the pre-drain lost_fifo_status / lost_tx_status /
> lost_rx_status snapshot into tqspi->status_reg / tx_status / rx_status
> via the lost_irq_snapshot branch. That snapshot is racy: if the ISR
> fires on another CPU between our live QSPI_TRANS_STATUS read and our
> live QSPI_FIFO_STATUS snapshot, the ISR W1Cs the hardware error bits
> before we sample them, so the snapshot may contain zeroed error
> fields. Overwriting the ISR-published values with these zeros makes
> the manual completion handler downstream silently accept a transfer
> that actually reported a FIFO error.
> 
> Clear lost_irq_snapshot when the refreshed cache is non-zero, so the
> ISR-published status wins over the pre-drain snapshot in that case.
> The lost-IRQ path (refreshed == 0 && live QSPI_RDY set) is unaffected.
> 
> Fixes: 1ff82c13ea94 ("spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler")
> Reported-by: Carol Soto <csoto@nvidia.com>
> Link: https://github.com/NVIDIA/NV-Kernels/pull/579
> Signed-off-by: Vishwaroop A <va@nvidia.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
