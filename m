Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D47B287276;
	Mon,  2 Feb 2026 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075215; cv=none; b=Yqj9EoWSOaKTloYu9SNAGdQ5AQgWa1hHA6UmUruRaEi8kfbayVAuFbrB7jLtse0zFD2vp1Dt3EE7mBB8UpIIG6IjV3U4beDp5OPfJBchpq5UFIxjqDb+hS0sWZvQtaw/lhImzN99ETd7IDq5ktiqxdEzi7X/HWUbhlZVqwreyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075215; c=relaxed/simple;
	bh=uTcauUUxDk1QARIIvO0Qay0BsuBOJtklwhWuhR3nLeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j1Yo+ObyuEoIQSe8XYREqkOOytu8YAA44RqY0bMD0xvZGc6jk7B/pgGZXG3q5vfssQZogC0QM67lYf9EZuao3Oorl9Yf68LKxjmt1QVoiQDCKAj3lET/y0uBdBvUUY2W/QZjpHK2sjzXzd3eIsfsskelBDUQAOUQcNjMC/Dahjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oua6foBw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oua6foBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F77CC116C6;
	Mon,  2 Feb 2026 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770075214;
	bh=uTcauUUxDk1QARIIvO0Qay0BsuBOJtklwhWuhR3nLeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Oua6foBw/m3uiwlJSorc5z9Y5AdmMFtpWfazjLam89utlAtWk1wmEN4ScLjtq3R2D
	 i5aShUL8WrntIQK7deCwDMY8DZxNORyRdUAEcu4YNSyd73tG/T1Ul86oA+Fh3nhQva
	 drqSqR3lIJMEdx4AxvGo7cbZE20N7R8cr0i4SdO4Zq6XLTUGy2UnTPkGYee8viwruA
	 Jxnm/A/MNWLuxZmlB+UZjrwQiT7/wGvTgIs5lTqdBNoEwlMGSN+T0lXmLn2xXNqTop
	 8xP4rqoligv2GtN8LLZ0sfZk0Kv+LzKDi8dQx4NWWAWXx8ncQ2CRoEQkfaKBtD+ahU
	 MCzHKa+Y4fujA==
From: Mark Brown <broonie@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Zhang Shurong <zhang_shurong@foxmail.com>, 
 Helen Koike <helen.koike@collabora.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260202-slink-v1-1-eac50433a6f9@gmail.com>
References: <20260202-slink-v1-1-eac50433a6f9@gmail.com>
Subject: Re: [PATCH] spi: tegra: Fix a memory leak in tegra_slink_probe()
Message-Id: <177007521299.976788.8413773321991263199.b4-ty@kernel.org>
Date: Mon, 02 Feb 2026 23:33:32 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 02 Feb 2026 23:15:09 +0800, Felix Gu wrote:
> In tegra_slink_probe(), when platform_get_irq() fails, it directly
> returns from the function with an error code, which causes a memory leak.
> 
> Replace it with a goto label to ensure proper cleanup.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra: Fix a memory leak in tegra_slink_probe()
      commit: 41d9a6795b95d6ea28439ac1e9ce8c95bbca20fc

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

