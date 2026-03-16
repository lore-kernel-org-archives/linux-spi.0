Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87733F5B9;
	Mon, 16 Mar 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683579; cv=none; b=h/bDB1uhc9J04rn+Bt4V8n+p9Lrc73YJP8mihta78ZFQ/c81z3hD+fGXUVJEOoJfe7jC3u0foviOWQFHOkCms6tdqMp7yU1AtplPUteKPxTTIjGsCz95JlHp1uWIpskfwYp4mayrX3VtfR3/9F54muHg4CBAhGlEv3E3xn0+TQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683579; c=relaxed/simple;
	bh=getjwqKgNmfq6BzmmTQiHcZudhJOJnw/iMntCINEbFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jfLvx4zC0ink7MiZ5o5672FpmCAgvOHlgNwq7FpYTmgNkpxhdxha4hOE4Ow3BLGJu+GocPe1fp0kjqeb1PchgQsVwGVgbSrcqx0+1Sku9/knyImmxk3guXjdVpleXW2q1fMoaqBLykvPmlXlHtqfTZ+5sI0BMs5DpBlrRGgQoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViS4wNTa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViS4wNTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D651C2BC87;
	Mon, 16 Mar 2026 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773683578;
	bh=getjwqKgNmfq6BzmmTQiHcZudhJOJnw/iMntCINEbFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ViS4wNTa1ZHgMdsTM50AyxsY2fwxoCk5PMsa+Zqn0xkpHkUzzBBa4yil+gLgXOHOk
	 t4nXT4JBUF3PXhQe9Y75B0GgLZGpdpe2r7EOwFyhnMAOI5sGBCE6dTKlH1zec7AQPL
	 AICnAywmBQ9VHXewPtV9YYTwyuW2oVjB9bl7pUl1Xo0vx08NhurgWxNoKIjPGsaYOJ
	 kQgqCiewgYUjbHy6RtpDJ2mBLeDE8GrPQC6yJ1fip+3VxmAMnkVE2iCO/UHhq481lD
	 7llUI3qlacmNf+SbMxD+t5RqnDge1kzNDykr+ZnHhpcTxetJ3pAZT+CERuRnp3bDnY
	 y50Q3Xzpq2IhQ==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Harshit Shah <hshah@axiado.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260302-axiado-v1-1-1132819f1cb7@gmail.com>
References: <20260302-axiado-v1-1-1132819f1cb7@gmail.com>
Subject: Re: [PATCH] spi: axiado: Fix double-free in ax_spi_probe()
Message-Id: <177368357691.147197.14162826062674228144.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 17:52:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c239c

On Mon, 02 Mar 2026 01:08:40 +0800, Felix Gu wrote:
> ctlr is allocated using devm_spi_alloc_host(), which automatically
> handles reference counting via the devm framework.
> 
> Calling spi_controller_put() manually in the probe error path is
> redundant and results in a double-free.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axiado: Fix double-free in ax_spi_probe()
      https://git.kernel.org/broonie/misc/c/7fc5e2f5603c

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

