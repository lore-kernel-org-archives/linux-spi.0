Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217224B28;
	Wed, 28 Jan 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598457; cv=none; b=k9oUf5SBtK8aS9LIKkFQYuC2BOORSiJfHSUTR+bGYO4wNGKGU2U1guar1UJcB7xt/YjWyfpm3KJb5QDJktD1eqBuH0ytjMDlx8eg+EsCrQV9MMObIg12VcDiv7Y8QmgEYIY5X5E/Mt+0HhmjD3k9T1ioFtT49JcTRfSJITSgeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598457; c=relaxed/simple;
	bh=smmDVtSu0ZWVhA9ZOtKVV4fgkqduoylTndwo/jjLwEY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MX+JkmT/tJXzTdfOv/kRfu0lgZB+UiRhz9b9LeaIceyTTJ67XpX9GJr600HNlXR/CFkNcpYrUhrRxd6adBd6cQCJjAw2eZfyVloO8a/RT4hW8EWTtWk3RWjA4Rgi2gHqw1gj7/y6p6idlRk41VLHr6qlauFxiQTzx8NnochR5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRBg55RZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRBg55RZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAF7C4CEF1;
	Wed, 28 Jan 2026 11:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769598457;
	bh=smmDVtSu0ZWVhA9ZOtKVV4fgkqduoylTndwo/jjLwEY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TRBg55RZY0xMQqVf4QUyRMWoyXA99ZvUUVId7uhYB5NA0/d2BYgLmChCFT9bowm7v
	 +pu4yUW8nzKUSX2nLCUlSxezpYW0FhlC3SxUTZi1onQovH4sNnwb/fK6Q74PMB0mqD
	 Efsn6Cxc+17uO+2IZuwjg82FIuUzFejyl+1tZEQY4Nwu8FBfWogFxfRBY3DrAkOQUz
	 a6PFGWDSUxvdB24rdRZ5erRCormNhxy8uZEknJdX1mJOMCuTDlZN/JJkY4ahjgmlGh
	 M/DAbhrZlBng60n0ZgcbXYFnUYhfHgRtH3aAmPnL4gnsy3zSmMI7bGK4/kQOxtiauv
	 XUSgpp7Wi6qAg==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260127210541.4068379-1-andriy.shevchenko@linux.intel.com>
References: <20260127210541.4068379-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: dw: Remove not-going-to-be-supported code
 for Baikal SoC
Message-Id: <176959845599.1599280.7657137784980878886.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 11:07:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 27 Jan 2026 22:05:41 +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: dw: Remove not-going-to-be-supported code for Baikal SoC
      commit: 5e037759b4b8288d66e791d686b79653a6615115

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

