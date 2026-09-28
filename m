Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99404D4876;
	Mon, 28 Sep 2026 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629196; cv=none; b=Z/VtXXf3uBOyFlDQOTCA4Vm8JKpaT9QQuDI51w2aD5y+Ce36dAeABWwfRKHMYgc1qtTRp8F4ukBkZpoTazOdqaRRzkIOaiaYnW8PK2tc+WzcPNyfug2tW7J4VsfbYBI1UciiL0QRIbYCpmb87uDySG9mBooQwL1nz3e/A2Gwg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629196; c=relaxed/simple;
	bh=mCQBKvDwSYcMeBPYtgLN8NGeK50mlEQE+kesMwkQkUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FAwRb9alqYh0i//01MgyvXgv4Zy6+Vmwe4YjXBx95E7TnxX1sCngdp8kgzvIi+ESOw5yANOIAkp/McJWeF95tDdhwu/63KpvJgXTkN/+S1nd+4z2akNko7RegKWQk3Ru8DnR5l2n4tYlSBGnbm/ZwLyWIr00/+ZbBOp+vBpEr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpgIbPS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpgIbPS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1A51F00898;
	Mon, 28 Sep 2026 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629195;
	bh=lSYH7wJH8ss5/ZYFWNVKUNP+kIllh+e//UjlhjktYTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YpgIbPS3TeqVk6Gu+C3GLyuY4WjT++rGvKslECIxuhOzhQm8UuZWeh1qGK0e59QIP
	 g7mWbC2rsc4LtmwgGhXcCa46NIhU0o3iR/ocDvTnbsRGiLOJP+TyrM72airQHHLapw
	 cIeMG6rA6KVD8OVjGm5GlTxeJuMdY4R/FrJTy40attACtXI3Z6tODI50c0qKEPX72R
	 dEli2jhCEv0M7dbtlbUwJZa1PFFUSYrd+Oxk8B4F+xrpC0EYQX9bCLfDKO243pLUdP
	 i+kVLkoj86Grhq6QVjKVW9Ni3zyumvcV9GrOdM6kESNLvgumu+i1Nhwu6ep18h5rDC
	 L1Xf2Ntj3tPbw==
From: Mark Brown <broonie@kernel.org>
To: geert+renesas@glider.be, Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
References: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
Subject: Re: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is
 built as a module
Message-Id: <179061312407.139547.16480019677433739258.b4-ty@b4>
Date: Mon, 28 Sep 2026 17:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mCQBKvDwSYcMeBPYtgLN8NGeK50mlEQE+kesMwkQkUo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqutVI7yexo7fhaA4pCxAYvH4dQcVyp4NPb1/0O
 XD7ZhDE20iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarrVSAAKCRAk1otyXVSH
 0NrqB/4kzMVbqgwBnOUYm33fyHMVXtO4bbVEGkDoMIDVHGXZFHW1E1DA83Oq4J5QryuUGmil9N1
 n9BKK7+5WxJvUGRUFUnehTdi6+pPy4LnvMtlFSHrGm4WQHHZEJ8XMJphUsI4pv0tFTd8yX8ttIf
 kPlA55K3uYSIgO+VB2VopfNLL1CMR49TddWAx/gTrlVil0lE5zmlQ8YSEEZbESA0fjdFMmQ5cI0
 NAr4xkn3HKbNW6X2NhfrSQmRLjJJGwq+pn4H0W8/2FCBnKm071Ks4aN3Szzv3JSxNFK/Z6mPLoE
 bPIwLGaqcpKo2MyV5lhxsEg5dqpNPjiO3a4lMx3NZ+GVVDG5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 21 Sep 2026 19:59:43 +0000, Ovidiu Panait wrote:
> spi: rspi: Fix DMA mode when the DMA controller is built as a module

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: rspi: Fix DMA mode when the DMA controller is built as a module
      https://git.kernel.org/broonie/spi/c/7b85114d47f6

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

