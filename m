Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226561;
	b=5n7E5tK5484eJZsmzyGG2kgyl4SrbQbDBRK4jUkFLHHKbooJjbrpbI+XQ4v9NYC8JrLZ
	 4ulb2+gEpojiNDmDJ+4bZpipdkoIsgxfnCxSKpOsdLrn/1YSFcw2FMl6wzvTI2Nr/y3HN
	 RPIJVXC+gd1XX+JGSHunJKoEoMBXJaH0aNYFadAugobrAyGIwOi7tngMD1UeoqGSl3ULr
	 0hJ6wJEDgq19S1hvKNkfFh0nYNIoQx8NGPN8gQOazkeAnZ2eRxlzZwSKCrBbFuRVnLmij
	 WLY3oI/PcFU1GfTbaY9qsnZ2LEqH8G4fPgBBZxAK39V3DTl76SYRYdOqBwPgrPTSW3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226561;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/CGZa/fBD0TBWmu3LGsIj547whIUEVzNqNobbCkoUPM=;
	b=GXxh2QzhDoL6N9g3iJ2mKJYmyFzyygHDfTdWQQAuhJ8gTUQ2uYNpVX++4SprTM5ALEsK
	 Ow1rmrgfT4ZhkePgF0bLIbSzShDznOaCkOy6cPnstb7j9w+HGw2Wl//6tueFBq54BfDVq
	 +yH3VrPWjnQKMM3Vb6LPJAtSzH/rO97IeUFce1kVeidf2RqaRde9SwRlm/5q/oYTT5TDf
	 3YgDAI+MXeS7lhDjlj0a2G8yYDEnftGqda+LYfAWvWvUyYS8BDR3g0EaFEPbejE4cO08e
	 CEpgDm0WHO66HtXzXiZF/qezRTq/x6eeXZaAH5RKuTvqVE83cs7u1T4ynsKTjHKEhiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhTkERSN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A1606A32A;
	Mon,  9 Nov 2026 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhTkERSN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F521F008A3;
	Mon,  9 Nov 2026 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226561;
	bh=/CGZa/fBD0TBWmu3LGsIj547whIUEVzNqNobbCkoUPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bhTkERSNG2RGu5E0Yj0B64wkJXexFbmLbXz/JxzFXJYbScfM4b3J9FbC67NzlguT6
	 W6oZXJ1vvb/9W600HLSnMIBaVHA0VkT3WqDmX+kc83L0YoMDknTz6aeTDTktcOImJY
	 v6jaSxC9LMwKiYrGOCLj0qrfn235nshs0ks8/ed9NR3hWz1TdJbB8pdzfNUbsJqDsk
	 1XZoD0P1Cpdc1ZFt6fnpNGBxIbZSnW3+X9UQBVpd1EFRqWEZp7t77vOMIY+YXp9Gsj
	 vi6uKceUrwKLwtM+5ahvumyBWf3ZHAHJ7F3PYcVpAlWSixyTQ0ae0HY+60Z2JC1x9K
	 P6ZwLPGSlh4GA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 56FBB2DB91D6;
	Mon, 09 Nov 2026 12:15:59 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vishwaroop A <va@nvidia.com>
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, 
 Aaron Kling <webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, 
 Suresh Mangipudi <smangipudi@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261026111412.3843954-1-va@nvidia.com>
References: <20261026111412.3843954-1-va@nvidia.com>
Subject: Re: [PATCH v2 0/3] spi: tegra210-quad: Fix timeout path status
 handling and DMA leak
Message-Id: <179422163907.3711751.17599615188016158846.b4-ty@b4>
Date: Mon, 09 Nov 2026 10:53:59 +0000
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vMMBf+eFJAAr0SQrfCgzh8jiTGssKOeyUcN5NCXqfuE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+7qwvi+RWCzu0wr67uvX24ZdKH+Yp7J275Gjjhb9al
 g2fTqxq7ChlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEWmoY/so1i9bnLq8u3/fu
 xqzYxGLuL98/V+/naio6mmE798eifZyMDDN67nDJP5Kc99a77negl9FabQeL3sOGT49q55c5xp3
 J4QYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 26 Oct 2026 11:14:09 +0000, Vishwaroop A wrote:
> spi: tegra210-quad: Fix timeout path status handling and DMA leak
> 
> Three fixes in the Tegra QSPI transfer timeout path: the two from v1, plus
> one new patch out of Mark's review.
> 
> Patch 1 fixes a regression from commit 1ff82c13ea94 ("spi: tegra210-quad:
> Cache TRANS_STATUS in ISR for timeout handler"), currently in linux-next
> only. When tegra_qspi_handle_timeout() observes a real ISR completion
> after draining the workqueue, it still publishes the pre-drain lost-IRQ
> FIFO snapshot. That snapshot can hold zeroed error bits if the ISR W1C-ed
> the hardware between the two reads, which makes the manual completion
> handler downstream accept a transfer that actually reported a FIFO
> underflow or overflow. No stable backport is needed because the offending
> commit has not been released.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
      https://git.kernel.org/broonie/spi/c/543a83912fed
[2/3] spi: tegra210-quad: Track DMA mapping state
      https://git.kernel.org/broonie/spi/c/7b9e6f7bc13c
[3/3] spi: tegra210-quad: Unmap DMA buffers on transfer timeout
      https://git.kernel.org/broonie/spi/c/d04ad85dd801

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

