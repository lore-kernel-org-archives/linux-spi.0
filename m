Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CC37A49F;
	Wed, 11 Mar 2026 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226074; cv=none; b=LDSz/NiOsW2MGj3xY8Ibj+1WC7gTmnBy6Im/YGQDR3FABrQK249vvAG3TwQmTJhEL45jGruAJQTQgyUiLUJTcJnxUrg6Q2TKSlx80YdLPfgTwrh7AKrxH0EOq44sqXHvdw95xqhuLv8GJRQEPd3sXWLk3M8erthvMYdTjWh/fXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226074; c=relaxed/simple;
	bh=QzsNINDiOOaeW+/k9aWRWovcFPnCSIYMiDryqSjzgtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pU9M5tqvHUfR9130kn1gwVUsrFqWvqZxpwjIbBQJmQPf6GVJ2n50oymOq75E2lQjxhC8ErwE+GPnokH6CGkY4ivQctcDXq2SXGgLMmW4wQyMMUCGV5xX/Oy3+RjLEjOYMaRlv9NsAEpQbDQ/GOoEq+79fcquoANNGn1l9BQSGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g40ykOAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g40ykOAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44535C2BC86;
	Wed, 11 Mar 2026 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773226073;
	bh=QzsNINDiOOaeW+/k9aWRWovcFPnCSIYMiDryqSjzgtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g40ykOAvXIyU6ZlXBF62klKPGz5v4I4P96eKHMUSV/zNk4ifPUzAjd5QQVeFB63fT
	 eFiiXVoTDnq4Xbqr0+uggeOzHVIhj/ac5MsXkWKvONyvcKYOu1KD3k0HtpHHjOMea1
	 UmMQSj6yjAIVTVJ4p4NwrN9mMF25OLFr/AN7BXUiI1kpbKQCDjGu72g6MP4jBvW6GB
	 bAlnwh1aMBpA0dLeyQikgQxhhbH4oA3jtTJ5Mqxu6oGfdpAZCfQeas6AC3WLRdqVRW
	 +mhR9lju4FP9qiagO/ONhL4c8Y2jvr3MZXZYET3ukr1bsRL54f9JRbGumpQsBk3SHO
	 GQOLyhcsPWZKQ==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Vishwaroop A <va@nvidia.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260307-quad-v1-1-f103515db501@gmail.com>
References: <20260307-quad-v1-1-f103515db501@gmail.com>
Subject: Re: [PATCH] spi: tegra210-quad: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <177322607201.10718.11513895360308353153.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 10:47:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Sat, 07 Mar 2026 15:24:45 +0800, Felix Gu wrote:
> pm_runtime_put_autosuspend() already internally updates the last_busy
> timestamp before scheduling the autosuspend, making explicit
> pm_runtime_mark_last_busy() calls immediately before it redundant.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Remove redundant pm_runtime_mark_last_busy() calls
      commit: d1008a8e29b09ea57c77ddf82d688f8c2ea6cbe8

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

