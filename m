Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E953EDAD2;
	Wed, 25 Feb 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046456; cv=none; b=LoYMvCuhmUMUTayaVgxJ44qowzFd88eqUvQiE/FkrXk9adMto7O2rb7sgSIPgSk6GDllJ7SQWKPefLX/Ddcg8zapNcSfx+6aPcGz+9yvr8C184cwScjhZvd25WuTczaZ9wHthL0yRTZiUnxdqt3ncMboXCHUcTUN43vy53IHOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046456; c=relaxed/simple;
	bh=hSiieK6gw9zhLfbluo0StCtR2+HseDZumG3VzdZ9QbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NAwdAoIzSrr4Ff1rEx/98oj8J3gN26zSOImuk9ztal0rvIbn81tuKugT4e2RM/Gg43Hf/hNhwykbE54hYBt9Z9CX7tlm2cEFWLdck/QGTMfVfL0rSdxyEr9SdSdfjQHbsjdZ3bhWWnPlElnS25T2cj5B0t82wj/CAL/1FUasGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEtFRoAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEtFRoAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9527C2BC87;
	Wed, 25 Feb 2026 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046456;
	bh=hSiieK6gw9zhLfbluo0StCtR2+HseDZumG3VzdZ9QbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZEtFRoAo4oBPAzYCOLiT0/TNL8/2/puRvEflRaFGh4v/KtesRLapwNI0L893w7erB
	 osV4riLBUHl2O9Er+SvS/VXX5N/zfsBOSS5jurMNC7pKrPmC3ZeZbbJRBI6u24xin3
	 JzFCkpxHaOhEptevS2DHJKcvElbDArVPxQHlBfACaTuQxcT/xHMpuY8eu4STKiI+Kh
	 iYPoK93WEBNfFgGuJJy1XH2POwDxQPbjLDaKiEKY2AbefKwfdgKe1jhbiXTsJvvFbW
	 i1WjvguwLO9V7VQooRyxN0E2tnID42yBMQiq8e1dIrwkDzTbGpjn0pedGFq5jrCpxw
	 RLjr/QbjoJHLg==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20260212-spi-stm32-fix-dma-rx-release-v1-1-53a37c31626b@foss.st.com>
References: <20260212-spi-stm32-fix-dma-rx-release-v1-1-53a37c31626b@foss.st.com>
Subject: Re: [PATCH] spi: stm32: fix rx DMA request error handling
Message-Id: <177204645457.169139.2112213155210381085.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:34 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 12 Feb 2026 12:49:10 +0100, Alain Volmat wrote:
> Avoid trying to release the RX DMA channel when an error occurs
> during RX dma_request_chan() call. Instead, jump directly to
> release the TX channel, if applicable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix rx DMA request error handling
      commit: 837f6691d5f39ea6453e4489dded40fb17755c60

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

