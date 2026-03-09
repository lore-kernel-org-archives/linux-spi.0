Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE93603CB;
	Mon,  9 Mar 2026 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083209; cv=none; b=Hbs0n1vJCXvpociCY8KQxohZDrWwFgAc8d1PH2Xap6aIfRlZTwgEz+4uDJfELcziOY3PLnRoidEJhIkdC9lPy6luxQeHgMT/B/VGDFe6UbvPOWw16g3GPahNiFKnE7FW+R0dUrff339JaDMHmrgYfMblpRQPbR+2iQ3ElmU0Nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083209; c=relaxed/simple;
	bh=9d5O6O+Ep5zzd/o1g6XAtTHKMqeRROriSSYMY8Crhmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fv1/ZtUa5a77AAISJH49NCH/4prKqnPMXUoOE1K/e+4v3oPmRWDBoFdnpvPvFiewn6joQtTfbhudCIOak6iNaF45wmCVDsvQavUVnQulBlrKuUQqqYll1VTZkoJ5JwaIm4sVsn4O0jDf5bivxqDyWGGfkYOwmpAqaj1iiNn/dzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndsDJaEU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndsDJaEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30BCC2BC87;
	Mon,  9 Mar 2026 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773083209;
	bh=9d5O6O+Ep5zzd/o1g6XAtTHKMqeRROriSSYMY8Crhmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ndsDJaEUzC2AnODnw1sj2u2kFmiZdE6bTzyA8bs3Cx3MmnbcnhdupJalotXFQBLSz
	 gHNlFeYwXQhD2YBgG4s1vwmHrheIGvF49ORqEC/0GysQO/Io0wgYDDWZqf7IEFT7Gr
	 EZQdvsF4yCy8ErQUBY7aFTJsvY2bHPYNgEpc7U1IbxAoS8tXFmmAR5EF1uQOGVP36c
	 VrdCPJ8Pn7/cFYcBwpQQzv2j/xxybduYhfJYeYbf3T13+6vefVvfvcwXLpYIj1bJ20
	 Cm6zhIAzGm9eFZ9UnyxRhz8vF+xKJQYYkHVxNjPvIaXWgXPgwXvJLBkX5R2ZThY1do
	 vyBfp5jRZ3hjA==
From: Mark Brown <broonie@kernel.org>
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com>
References: <20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com>
Subject: Re: [PATCH] spi: amlogic: spifc-a4: Fix DMA mapping error handling
Message-Id: <177308320766.255456.17100678441910106235.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 19:06:47 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-83dbb

On Fri, 06 Mar 2026 01:24:32 +0800, Felix Gu wrote:
> Fix three bugs in aml_sfc_dma_buffer_setup() error paths:
> 1. Unnecessary goto: When the first DMA mapping (sfc->daddr) fails,
>    nothing needs cleanup. Use direct return instead of goto.
> 2. Double-unmap bug: When info DMA mapping failed, the code would
>    unmap sfc->daddr inline, then fall through to out_map_data which
>    would unmap it again, causing a double-unmap.
> 3. Wrong unmap size: The out_map_info label used datalen instead of
>    infolen when unmapping sfc->iaddr, which could lead to incorrect
>    DMA sync behavior.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic: spifc-a4: Fix DMA mapping error handling
      commit: b20b437666e1cb26a7c499d1664e8f2a0ac67000

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

