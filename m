Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D861EBA14;
	Fri,  6 Feb 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337142; cv=none; b=GT3x0HhZ0u6pFFzjBITZAwG6P0U2b9J3KyIQd+6Ioel8MfUPzqTxOntR/4w+FHC4iwVpAmRZ0+zBNg6ooMpuLvoHxXtJzNkN27ZydmoyBEmNYinSoRguNXoG/xSApWA+AeFXZwZuocFfSgOIJk5q0E+aGSjitnjcXKYXCwRw5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337142; c=relaxed/simple;
	bh=lrhlkyeGAXpmAIBptKCG2tGQTvtZb2+82G0pxM3E4q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BIbz7tH/KRF5CfryNagsSHoAKTLP3xASW2npBHXzEuCNmI80jJ8BZgZBC+0avuAS//AvB/lokS0UO8xfYBNaXPnrzLjDWq+LHn2slOxVz35g6HN1Lq24+QHvxi0VfeR8I/bg3p4mSDcsFBYIWDvf3lyzILOa0M5zLTfUpqSRV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJDT4KVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJDT4KVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799EC19421;
	Fri,  6 Feb 2026 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337142;
	bh=lrhlkyeGAXpmAIBptKCG2tGQTvtZb2+82G0pxM3E4q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OJDT4KVJPvx8N6S9if0Y+WHSzcXQDAvKB6zdOMpB06gbfcvzBRGqJTQ1XFklonWG3
	 ittjInDq0R/MEFPDw/1CV2SJ0auN0u63tXfWj5S/KZVzgdVGY2eczqloFeaDwzpzok
	 5kXNJ34EH3AFIj5OeYzDtTtLy1E3PPf6LakN8lZgqzRs+ka/KqBkus/uQpMtZMJn+d
	 QXC9HuJ76BsxEFGT7vBV7u0FWB1Z/nxAKB35kC3AwTQkFtUxbzxWXwyOX0qOxkeq60
	 Br43QO6J4rxf1/WN3fpilc36ihJpfo51E4PyA/TxMZyiDw/1T29usQKmgGFhxVFkw6
	 aao2Atu80yvcg==
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, linux-spi@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260204141212.1540382-1-va@nvidia.com>
References: <20260204141212.1540382-1-va@nvidia.com>
Subject: Re: [PATCH] spi: tegra114: Preserve SPI mode bits in
 def_command1_reg
Message-Id: <177033714083.233295.17808462615832612540.b4-ty@kernel.org>
Date: Fri, 06 Feb 2026 00:19:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 04 Feb 2026 14:12:12 +0000, Vishwaroop A wrote:
> The COMMAND1 register bits [29:28] set the SPI mode, which controls
> the clock idle level. When a transfer ends, tegra_spi_transfer_end()
> writes def_command1_reg back to restore the default state, but this
> register value currently lacks the mode bits. This results in the
> clock always being configured as idle low, breaking devices that
> need it high.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra114: Preserve SPI mode bits in def_command1_reg
      commit: a0a75b40c919b9f6d3a0b6c978e6ccf344c1be5a

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

