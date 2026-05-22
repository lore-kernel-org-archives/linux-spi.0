Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF8366542;
	Fri, 22 May 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471848; cv=none; b=ZrMl93EOXBxNz+mITn1ILG2btA1HNZkwwe3CN2YMZtCA0Is2dNGfQDVuWP3Y8DwHKpRxm1m5xbHc7UOSsubMHMmSP59d9CKmt5n9Bd0/SvfFZGkTqVQgdoecZf0HyFpFN7zSNdxrlgTiSFIAdCmVHzczK+taGj2zxIAtaBQfqMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471848; c=relaxed/simple;
	bh=Tv9yC/HPHD5MYTDVZZjm6BiKOT9UVVCDNhlVmgG3Lic=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JMyr0EDceIpVxNmAi910no4QyOnLPKDoSQ44kSJIgWltIfCSCCXNCG66qyljaF4sFPTNE8ur2KWGE38zdTuSthyI/QulhWJ9iXp+4rsytgeOckiEf5kGO8YBHOVrEmHLTHCxuSjwwAj81ehqZbDmn3HyTDWp0xGhI22LRD6sQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDaTfJ7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDaTfJ7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFFC1F000E9;
	Fri, 22 May 2026 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471847;
	bh=dPSy7gqM18tB/riDkEZyZMz/5Nf/xICtVmHbdFXpqic=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EDaTfJ7X17s+5b2rhHQNVFr4NtSQBZYy0GGlC9Lss5cvXCZRRNDUgWoSMZHh0gCrf
	 m+zcWfmdFkDgeKoyfvh80h79EEP+SNRsNeon2geS3sXTP47IZj1cs/BFDCFaUF9Qsx
	 vQatlyTlr8YbPnmbwh8MrS9zt6Jf82TQu11mv8VCYsdasNeC0lAFXynrJZgnUA7lPd
	 THfCNH7j6Mq8SIhd626f2kIu70q/AOLCC0C+atNfWtBVGDavevc0QqvTU/nIa26h1Z
	 f0HVAi71gu0OFLmUoUzk5akvmHhiyKm536u8sZ55NcthZGy7Vo3cptcHBstbCtjFaT
	 XDbaAKIyGgoCg==
From: Mark Brown <broonie@kernel.org>
To: clg@kaod.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, 
 BMC-SW@aspeedtech.com, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
In-Reply-To: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v2 0/2] spi: aspeed: Fix __iomem annotation and VLA
 parameter
Message-Id: <177944768300.6494.4828834856275675415.b4-ty@b4>
Date: Fri, 22 May 2026 12:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Tv9yC/HPHD5MYTDVZZjm6BiKOT9UVVCDNhlVmgG3Lic=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEJXkT2orRoPdoYnnzdEspQaf3e2CYyRio3QVd
 FZwd/M80uGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahCV5AAKCRAk1otyXVSH
 0Ng1B/9At3GEzpYWjnScrGWwjwyY5BSXn4qiWVk8pSrER3UFOq7Q9nblg/f2QpceDCw0n4CAJND
 SgoOGI+Bpjt9+PMLaR3lqv5yTW4Tlp2nvUbQyluqSWEWasUSOEXNRNBg4p3IQqp3WaNKSiCN/gJ
 wi7+LtWEgLuutwhJwtyETdaS0REBi+4ECFq+2y845igEKu20G6MMbhrc72Pi41nyx9qIZf/fxlc
 jG+bQCtiCJU+jSyaPJeOXyH23BWB65ycUUBNya1OnWTuokWiAlxv9GFhmSYZRJc+MVhEhPwN48x
 NTxehS8KOf9UUBfxigVx7XBOFeFo7lH2Nsw1sBdEE9dT3Qsx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 22 May 2026 15:16:19 +0800, Chin-Ting Kuo wrote:
> spi: aspeed: Fix __iomem annotation and VLA parameter
> 
> This series fixes two sparse warnings reported by the kernel test robot.
> The first patch fixes missing __iomem annotation on an MMIO pointer
> parameter, which also caused a redundant cast at the call site.
> A VLA function parameter warning is also fixed in this patch series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
      https://git.kernel.org/broonie/spi/c/5c3091e23f8f
[2/2] spi: aspeed: Replace VLA parameter with flat pointer in calibration helper
      https://git.kernel.org/broonie/spi/c/94f5efbaa751

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

