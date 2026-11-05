Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886285;
	b=j8yZpVtu+Z/eSp7AH3aid/zEhjRTI4wG6paSmT50BFsaILNfbHtRM1qrUOWF0TPq2Pf/
	 L7CSVEXtKPNPiAgltaWxJAvLVvQN4payoswvpSEey4xX8alAE0nrzxFKZqR+vGgczu4m+
	 0Anp+PvQIjp5fdzJ4rT6crlEsrZCo7IZSdwQ/UbdUklYGqiQOU7CWi2Cco13zfy5pOelQ
	 F9UcJhRhnp+LiNtN7fCsD1WYzRQSl7X7pi2sS6tpGFbuUVLOdTIfufkP3GymSbj/Zf+J6
	 gTJVWEfGF0o2DO6zJC1eG7kTT6fud05w/LepinzaOUR4jSRXSq7q+avb6Fb52hPNnLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886285;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2dnaL6lMjO0vksrMo624Wl9ctTHzxve0dQKHCnrkYWc=;
	b=o5A+nPDUm/fvftkNtwv6cWvRtcXY9wYYQXpD2FXxuAaW3iVFcruciF7Q3NVEsetw+iMZ
	 A46qkBZagqAMywKGwXPiqBfPXwKZTEMr7Q+P+gIHZYULBYtgXRI1M87U9UokEp1Pq4AVz
	 vRMRpy0qGWYwSHkcaovfTqRlHG73hjMY3mlG2haubI1vUoqZwr9Kn36two0SfZ/hwt0Wl
	 Rd+G7AsxSSeKj4EWa5KoNJtNyGAnXFLY8ajNc+i4yEXJeUaR6U+lqH8c0IJa7V44EncIt
	 30CUBKjRBibl5tTBgxZRvWdpFXBrAqpqCvSq4VumzlE2fjfY58/nQz3TZi4wxRYl36g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alblbtWH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F690606D808;
	Thu,  5 Nov 2026 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alblbtWH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF99B1F0093A;
	Thu,  5 Nov 2026 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886285;
	bh=2dnaL6lMjO0vksrMo624Wl9ctTHzxve0dQKHCnrkYWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=alblbtWHKnV2SiK9/IkQ1dbjudC/7QWnEEz6G5QSKvbPj7Zm4qG1XdTdLyyeSgTud
	 49X9fzFizPRjeFp8UIphDu0YcObv2xI2oXqmNlANpP8EFGy+Ynr65bC3+aDmKBIeeL
	 ClPk7/Ie9LYeOObnCl+0VfVKFvyPis/4LDB+Z8VPvcp3hVOENi9FlFdxlofoATeKAN
	 kMPMfx05TrZ9vvzIIjBJKyle0aTe374FImhpz+ephr6jOUygUJt/98Bubu4ZwPGmYD
	 4iCUHtMu97tbut0Iay4SheEHBdwhzbyM3Mo8AsWMR6L4SwSg3gWyYZ1PHkZoFloAJJ
	 t8/MBkwupzelQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D5D292762835;
	Thu, 05 Nov 2026 13:44:42 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Vishwaroop A <va@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Rhyland Klein <rklein@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, 
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <179258895296.403962.3492255118456900623@nvidia.com>
References: <179258895296.403962.3492255118456900623@nvidia.com>
Subject: Re: [PATCH 0/5] spi: tegra114: chip-select fixes and PIO-only
 probe
Message-Id: <179383886509.2186205.16728641594593011636.b4-ty@b4>
Date: Thu, 05 Nov 2026 00:34:25 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iYtn6PIJnMh8R7kkukJ0M7rCvDl6KUNklngTZ8kJGSE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLedHg99S/+ETVxouDPtXPO7S3K1H907ZBx+EzuU5Onq
 irtCtgT1lHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJ7PzF8N9rY0KVfmGgnGi0
 YXJ/SN7PyQdDRP5cntUeLu/MVcDIOpeRYbX4DC41FqnCvz+OyXGosTWl6lfkCO2Tuyp7Nfkg84H
 n/AA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 21 Oct 2026 10:14:06 +0000, Vishwaroop A wrote:
> spi: tegra114: chip-select fixes and PIO-only probe
> 
> Tegra114 SPI sends each transfer as its own packet, and hardware CS
> follows that packet. The driver implements transfer_one_message(), so
> it has to do the per-transfer delay and cs_change itself. It gets
> both wrong.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/5] spi: tegra114: Allow PIO fallback when DMA is unavailable
      https://git.kernel.org/broonie/spi/c/04eebd439d91
[2/5] spi: tegra114: Run per-transfer delay before ending the transfer
      https://git.kernel.org/broonie/spi/c/5b4ed7580ece
[3/5] spi: tegra114: Assert CS between transfers when cs_change is set
      https://git.kernel.org/broonie/spi/c/679565d314db
[4/5] spi: tegra114: Decide the chip-select mode once per message
      https://git.kernel.org/broonie/spi/c/d9dfcbf274d5
[5/5] spi: tegra114: Keep software CS across bus-locked messages
      https://git.kernel.org/broonie/spi/c/881e4ef23286

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

