Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9D3EEAE7;
	Thu, 10 Sep 2026 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037502; cv=none; b=bf30+2Hx1blao3AcXeqS7rIF1Nr/dGE21Ur/vq9vvXIdCCyfCQkcw+U5huzeCEnc/d8Wop4vXRIRsqKAAblk8yLDUiVjfmYE3x0owXqtUAFPEJk4fUoNhSI44Wb6w3Fu3t4bWvRE/z5SprwHqE/90FYLK6XxHoPzI5OshfPpA5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037502; c=relaxed/simple;
	bh=yZVzWlbPbvL+iV7XAErOntQR2Usf4H4OfkpRz1D7fxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WbJulYa4KZ4UpKmq4/n9sXP7cxNmLhb9iX/njIg3Hglxbzhmujod+wtqapAryy4scD60UR5I4JPn15xz3Lek3PnVkhnC68/Feu21/juFaBYWawwwd/G5hX4OEMXT/WvfyzFNjW127+RCPUacLeZOcmvno4XEXTab0m7TWSbZ9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuXfKMKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuXfKMKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749491F000FF;
	Thu, 10 Sep 2026 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037500;
	bh=rdDp2f06GJ5OU0nCbdn2ECcNb6jSQB9pduJdp18sVpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YuXfKMKqcJiAMnGvdWu3bkJYO34jWOsYOpiyFTT5LqVMlPdADbLOZhg8WeUqkWXsZ
	 Zjd+OGtj4QxLcozAuJjpE+20aA7coW/7ZhQkd2qE7p01BaAFPQazVsX5LhgjGhWGCD
	 EV8TzYPdsAArAAmW3ZeRYel/34LCLK7+MdiR8fAl9vmw+Lfiwnr1jFZv2km4psPkXg
	 wGb3bfca8XwqRWV0/gaCxePWXOk3KZ30rLfc0vD7XHqqdf5DpsabHKGnNB7tVWQbOw
	 PqrCCZgO3hf9BJQPCSBat1DBD7f5nKW8ily4NSahVyvR31AkKT6auRk/JEFbWf6x+l
	 0n9t508ZGKzWw==
From: Mark Brown <broonie@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Breno Leitao <leitao@debian.org>, Suresh Mangipudi <smangipudi@nvidia.com>, 
 Krishna Yarlagadda <kyarlagadda@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813200027.2711863-1-va@nvidia.com>
References: <20260813200027.2711863-1-va@nvidia.com>
Subject: Re: [PATCH v6 0/3] spi: tegra210-quad: Improve interrupt handling
 for loaded systems
Message-Id: <178895460101.87467.6194571652412534959.b4-ty@b4>
Date: Wed, 09 Sep 2026 12:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yZVzWlbPbvL+iV7XAErOntQR2Usf4H4OfkpRz1D7fxE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoou3x0e3hp8EM/fkuvocIF4Ee5aHRBmNIKwjh
 La0yeOl2KqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqKLtwAKCRAk1otyXVSH
 0A5OB/wNGku+Uj7ZXnNa3SQ3JmjQJmBFup+PCJpLm36EHvsm1g6PqqGq2IpdalhmZi30eCXxMr9
 S++qdq+EVx0xmrEU+DjKYUVT+cEkq7KM/b9eylFj46o75m22huWzwrzzTVzAuqwu/Kf47DKx47j
 ecmCsnNUZ5tJUw/rFvGDWt83jM8NsnSPso98KI7wtdXGbJGiODC2cDypXzy/Fu2ji1jD5FNK1FE
 yop5hJK+lnMjgXJdMLS9sv27YAX2WsmrtesbocV4RzoRI3dEUjneD5/LR+vRGBG2dGN7O22VoRH
 2kcqLbey6HiLpm87AGqfYKsbITKDyrSmBLOjUYqhxGVkkBNr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 13 Aug 2026 20:00:24 +0000, Vishwaroop A wrote:
> spi: tegra210-quad: Improve interrupt handling for loaded systems
> 
> The current threaded IRQ implementation in spi-tegra210-quad suffers
> from scheduler-induced latency on heavily loaded systems. The old
> irq_thread() runs SCHED_FIFO but is pinned by the kernel to the IRQ
> affinity mask (typically one CPU); when that CPU is saturated by RT
> workloads (e.g. NCCL multicast) or by an SPI transaction coming from
> a higher-priority context, the sleeping DMA/PIO wait inside the IRQ
> thread cannot progress and wait_for_completion_timeout() in
> transfer_one_message expires - even though the QSPI hardware
> finished on time. This results in false timeout errors and WARN_ON
> splats during normal operation.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
      https://git.kernel.org/broonie/sound/c/e329b94b1e47
[2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
      https://git.kernel.org/broonie/sound/c/1ff82c13ea94
[3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context
      https://git.kernel.org/broonie/sound/c/252ee24aff97

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

