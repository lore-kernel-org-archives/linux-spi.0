Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2A424D70;
	Mon, 20 Jul 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553607; cv=none; b=BnOXQhqHRq8i+rxDJw3Gz0m8zSapifLVuMSet39HqbQHsk1+iVp8cwHFpGd8Vm4L1/3BpfGm0Clr1zOY08nKl7ZBDuaZgRZYqAG6uAlFyVZdDHehk1I3EBazLoDL5srtqfMXtU14WDzoQp4SHzjJoRWxl5Ht3IwEDpJmRhzNQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553607; c=relaxed/simple;
	bh=lNDsCrr6Zr1a04BpBZ3lfOtH7qJfNJwbYY0TuEgr1a8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eMT3WqFHYPhpbHwnTNPD6feAmXh/aUkr5K73Si5H/97VXDsUl0rVTk5+Wo3FShZgvT7CaifC4/l5wSP2ZSdefH4gGvL4jcNGKnoBjXVzAH9Ztb+YaQGxTnFslQ9mTTb/eX6u0tCoD0xOJJGFWoovS5bjdwkXDVlgrRoze3Oxyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK05cXzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK05cXzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC141F000E9;
	Mon, 20 Jul 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553606;
	bh=bB8LbbQ8ato4eUpI/pD/xOs6h3QBYChFQmgrhaxvC8s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iK05cXzGHHMN+9KPEzYdSfXWKYItWmCHctLtMUa31qHmsjose29IsskHQDTahKwCm
	 yVQPLbdZJIrdzNpRhzeCuomzgjFBkFrz7MWsTGf3ndJngG9Kfh7hWGQowjdb1uXMEJ
	 Ij6gKgGGhm7pCLpaiW4F3SqS4rBbLStmx2LdEBLf5ydy9+iS0f1hGIU1TovVBMGSSo
	 n6MAOYF7YSdETFxFlMMJH7hL3csUE19ZjkuyPgNOW0mQAPDSmk1UwLi4PJtNQrQ7iP
	 c4iaOsAkoeawpz6JPQW3+JZKwTyVi8VD5a6kgqy6Y4HNqnRoF8klq0AVXOlrv27b/3
	 rGUcpiUYKws/w==
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <dlan@kernel.org>, Zhengyu He <hezhy472013@gmail.com>
Cc: wefu@redhat.com, linux-spi@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Peixin Xie <peixin.xie@spacemit.com>
In-Reply-To: <20260715-k1-spi-tx-fifo-fix-v1-for-next-v1-1-02024223b08a@gmail.com>
References: <20260715-k1-spi-tx-fifo-fix-v1-for-next-v1-1-02024223b08a@gmail.com>
Subject: Re: [PATCH] spi: spacemit: Correct TX FIFO slot calculation
Message-Id: <178449558269.33801.416545162576183224.b4-ty@b4>
Date: Sun, 19 Jul 2026 22:13:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lNDsCrr6Zr1a04BpBZ3lfOtH7qJfNJwbYY0TuEgr1a8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqXiCEOyek79WHHGGiFXCeTAW8F77//b0UOazmO
 DXeim3CFjWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal4ghAAKCRAk1otyXVSH
 0JB3B/sGiLFZW8tY8oSWfbgOEY5rtcyssZ6mdOCkSFUjCHdM71rqTs7M0hwMcXo8vjuE8zQFZF+
 oq8fxc6FoG+lRnqWwim6F7ZylZS6Y83MszA+46+HXz9dSQcno+l05zzRAaeJl0wPgX0LrFPmn5l
 F2EXDwTEu7GG4a/XOWSZ/mXX83arEsylSvh0yvRAh8BfV69LRD2SsOd2T3b81flqBRgVCKMDK/L
 CFofHiqSTYsHC1naZuHGyQPjYaGrUTZltAlQN04ZQ1nlqfoqAfbCk8KrIa72aHOLhOW6izjebAU
 hPx0DPv1WiL2REbIyRknW7e2yLITYb3C53w73w+gqDzy9Pmz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 15 Jul 2026 20:52:15 +0800, Zhengyu He wrote:
> spi: spacemit: Correct TX FIFO slot calculation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spacemit: Correct TX FIFO slot calculation
      https://git.kernel.org/broonie/spi/c/a88df1d92fcf

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

