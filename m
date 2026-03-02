Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656983E0C55;
	Mon,  2 Mar 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456500; cv=none; b=F5oC0KkYZ4GOeqptKGjHjjpni7M/BYFlAKdCOMxhAwQCEqxIEfKpc0+wEDuPCqyZS4t5AB63OGxwJCHaggQqzChcABNDLGZjco97KD7mFjILGDYMgj3x3fQoJ+TQJtwmUC6LEDe3KLMstw/pV+qmsZhZadZZiGnB+OejYqL80pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456500; c=relaxed/simple;
	bh=sY9jYK17uO62iqtXQmvMqOz12i3TagPRGRIPOY8q3pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZCTHDAXQYmecK23Vhr6vtg0lrY1OOAdF/QwjADc4KriCgOQKXYtdgx0gWc9A4vW4koJj3yeiLkWpRqrmb2zP++YNsEW3HNdA9Kg1FCA8m5gKyj31AgZVPxlxohcacU+wzP163mBpThtIp/70l++KSifdDg/HKK4CPO56TqP/rkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TN0T3gxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TN0T3gxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77317C2BC86;
	Mon,  2 Mar 2026 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772456500;
	bh=sY9jYK17uO62iqtXQmvMqOz12i3TagPRGRIPOY8q3pQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TN0T3gxE1/LTuQloFsUkmWeO+zO+c3yIIVJCIOhFZw+u3NjJj7Ra7NxMPF7Hr8RFP
	 MShT55kddATXU7z781IXbuvWK7VhkONx8BrLoLTrYrV2PPGGqcgjOHD8AEINxWUNyR
	 L1xE9jDTBLntNbmfZlf+QsFn8pEoCZbUbbWButCoklzLMMhbZKr5WPuBp8E+PhxPCl
	 WA+n6EX+3DuEBmUefRg+n2uieZKyAML22hBIJzhPYGPFnlz+lGnhx0EUXrOqO3TZCJ
	 fFF5SzHEKKQZzk2Yhz00a7B8t80Ln9d1tHF8LnqtbYjydwsp5hZ0vt1oyJYufER3aG
	 rvBezXQLLpJGw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20260301014743.3133167-1-rdunlap@infradead.org>
References: <20260301014743.3133167-1-rdunlap@infradead.org>
Subject: Re: [PATCH] spi: spi-mem: clean up kernel-doc in spi-mem.h
Message-Id: <177245649923.39631.9940299666569186725.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 13:01:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-38bf1

On Sat, 28 Feb 2026 17:47:43 -0800, Randy Dunlap wrote:
> Eliminate all kernel-doc warnings in spi-mem.h:
> - add missing struct member descriptions
> - don't use "struct" for function descrptions
> 
> Warning: include/linux/spi/spi-mem.h:202 struct member 'cmd' not described
>  in 'spi_mem_op'
> Warning: include/linux/spi/spi-mem.h:202 struct member 'addr' not described
>  in 'spi_mem_op'
> Warning: include/linux/spi/spi-mem.h:202 struct member 'dummy' not
>  described in 'spi_mem_op'
> Warning: include/linux/spi/spi-mem.h:202 struct member 'data' not described
>  in 'spi_mem_op'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: clean up kernel-doc in spi-mem.h
      commit: d3b693a13b39bce16e284e1c737874966b3a96de

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

