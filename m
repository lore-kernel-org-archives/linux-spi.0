Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9631D72E;
	Mon, 16 Mar 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683573; cv=none; b=leqHK8d7SNnn3WDeS0BN+fcYBO0aYYvVPeGKL8bTGXozaeDsA9IV1cNh3JGJvkFtQNNyTt/+SD0aUtB5hUBNHzfa4LcXJD3iXYabaKtG+SaCC7xqeWs2j6ukON9ovj/uTxOz/+0qcXbmUYLlbazRVKOQqGUd8tB7w3gZPKCDht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683573; c=relaxed/simple;
	bh=OEwG9/7Qz07DUhhGU75z8KJ/0FJEh4JIXFXDtPd/Vho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cl0m2C7+VE3n1YWQc3YYSJH5yK6dcdcbSr042Gdf5osYhA1IapGKkv++mTcHHDLr7UAlRJX5kQ0tmwnM/Z6lW8IXsKxxuXUxfdKKv1W4yNz5XQdRGG/AvEP+2ClSKQQ7ubZeSjSg5IUA/Lg0AW/KB1T75rzYGOQn9NdYpI5/rC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfpeH4oJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfpeH4oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D77C19421;
	Mon, 16 Mar 2026 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683573;
	bh=OEwG9/7Qz07DUhhGU75z8KJ/0FJEh4JIXFXDtPd/Vho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YfpeH4oJXAuDCb/CEbnrT5EwJC3+z5nA6nBgvGcMnSVIyoMig8cS/e+omu436gBg9
	 KrdTXMau1nnEND386IT4Qtz2FW3GSeJ7rQrLF7ZqAOEe3Yx2iqprkM/qVVgXM4KLcU
	 laDdiODnzjJiqootV4gQMANn2X0EQWlTjHtTOHyiZmB2HWE15jzc0A0EZ3TU1JpZ5y
	 dam/mooAk7AvOR/6Jz6fvQzz0Uk0RkTQ3SpZHPvxEKwkNQ9D/at2gEFvgAxHUaxp2j
	 wCPg/WLwPFEnd+VoyKwIH2U92U/FvxCrm6iC+JR/HZQtpZAnEg2L5DxkYmheUefgro
	 TlaDHcUKbaeBw==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spisg-v1-1-2cace5cafc24@gmail.com>
References: <20260308-spisg-v1-1-2cace5cafc24@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: Fix memory leak in
 aml_spisg_probe()
Message-Id: <177368357179.147197.16355665844565795171.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 17:52:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c239c

On Sun, 08 Mar 2026 14:49:21 +0800, Felix Gu wrote:
> In aml_spisg_probe(), ctlr is allocated by
> spi_alloc_target()/spi_alloc_host(), but fails to call
> spi_controller_put() in several error paths. This leads
> to a memory leak whenever the driver fails to probe after
> the initial allocation.
> 
> Convert to use devm_spi_alloc_host()/devm_spi_alloc_target()
> to fix the memory leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()
      https://git.kernel.org/broonie/misc/c/b8db95529979

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

