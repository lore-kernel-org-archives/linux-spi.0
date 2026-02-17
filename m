Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406592D0C62;
	Tue, 17 Feb 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356306; cv=none; b=R2QxsRbRW42xU1Uv/vVUDYvopQq8/YU3E7KuRO2oh9NXTmVE9p5U7cyeJckueUnTHjt1tjptxbULds3lE/FpYts1kSejWVvj26DFb/3Y+Ei0Yx+v4vIsQ+0tvZh45IuX4BSOJcZh4JUMI/q8Uv0+NDZKwhB0oYbW4XyFfAYpLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356306; c=relaxed/simple;
	bh=X+uVlZmiRa/SeEbYregyI7s+fnw/l4zH9aKU0KP+0iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IUZwPjLje2UH2qiC9Khz/6M0N0B+nl/mdbwwZmHKSOP5+rPgKzUKLYhSmb+tHxRH2A1DpiyePbbuunCUhsnlHtwx6+x2O6gZaWvXiIN53zXmdmrRWEPX57P3BMkATNw6OAetLBurOgvZGAACKyHKAiVbIxjM1fnLq8FFBuHe44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjS7ArDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjS7ArDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C7C4CEF7;
	Tue, 17 Feb 2026 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771356305;
	bh=X+uVlZmiRa/SeEbYregyI7s+fnw/l4zH9aKU0KP+0iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JjS7ArDvCnGh5lJ2ED0IFQ0rtf7z2my2Eav0w/f5r73ttZ/EIJ+S8NaviyirqH9vv
	 ev27iP6BX+rteefHrrD4zzTyu5cLfJWzphDmShuW9VXFUt5rOiXugiJiag6chh/bBd
	 iDx2IFYDPH6j29Xw48EKWb0cjyXb420jdNOo+yeTJveV+g4BibYLIRd90Nlmq6GXLT
	 h1jjfQTb9T14dxckU3vO5vA8BqC5Ec/sKJpeqrxZ2lwB656xCo5xUYQBNFdEH2Yk89
	 9r7jrHI2oSnOgyfvHnCfLnKVkwxQkmZiN8lDfqIwkix7UFWvg157QWOz/gf+PTG6it
	 LdS92kY7Gs7uw==
From: Mark Brown <broonie@kernel.org>
To: Fabian Godehardt <fg@emlix.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260211072616.489522-1-fg@emlix.com>
References: <20260211072616.489522-1-fg@emlix.com>
Subject: Re: [PATCH] spi: spidev: fix lock inversion between spi_lock and
 buf_lock
Message-Id: <177135630497.311376.17485346108295229888.b4-ty@kernel.org>
Date: Tue, 17 Feb 2026 19:25:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Wed, 11 Feb 2026 08:26:16 +0100, Fabian Godehardt wrote:
> The spidev driver previously used two mutexes, spi_lock and buf_lock,
> but acquired them in different orders depending on the code path:
> 
>   write()/read(): buf_lock -> spi_lock
>   ioctl():       spi_lock -> buf_lock
> 
> This AB-BA locking pattern triggers lockdep warnings and can
> cause real deadlocks:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: fix lock inversion between spi_lock and buf_lock
      commit: 40534d19ed2afb880ecf202dab26a8e7a5808d16

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

