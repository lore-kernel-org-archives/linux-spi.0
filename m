Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5926C3B0;
	Tue, 27 Jan 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553371; cv=none; b=Zl4WXwc+v0PsugoLiJT5SxtAOz8mObo7OjsqqaT3kkxd2wHudbi06B6cPqaCySpZtoQ3EZhlXtNpMxNULHxcURz6OiIPc1j4qYS2XeE09Ob1imV4QkBEma/K9pUKgKax48tfA6AZzVzoG4nkeW/camQ1TffkHaLMg8cztJJ9Pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553371; c=relaxed/simple;
	bh=kaqvyYx0HFT2bjhY1mUo+B+GSJ43M4fj6w/gHKcnwAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k/Ex+I7RXatthq3Q1DWMILbEH4Yl9fT04Tg4hixFjnUywQts3RA8wJszeLe9ZdyrkcvXM9MYNflEiv/ctfl9qLCrSUGf6Cudw1THdKw6unCg9GBidcKiqFUGTAzjGkJC96UE0IMazFO46QprPotItjCiadmKVz6mpKrGgVOSqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmNb5gTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmNb5gTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87175C116C6;
	Tue, 27 Jan 2026 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769553371;
	bh=kaqvyYx0HFT2bjhY1mUo+B+GSJ43M4fj6w/gHKcnwAA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gmNb5gTiolXuP1FWNLy7lMs9FH0cULBfHEBh7obLirhVl827aLqGeUOafPMlC1jVX
	 APLxbWT0bv8tX5rMtIZI6HNQEFw/ObqXk3MG/K4/EUyBiel8F7jR+yn0lSDji4AR2+
	 Oj3FFgb08hwMUhQi99WS78xIl7My6mHGzuJuG/6+cvmfAQkSlYbPbRtqVdL8jOmhUP
	 AEo3v8y3TiZ0dBy+HKJqcS2w5v283xzMVPmUA6F6wPk/p8aS2GOJdBDo6AeYkgDnen
	 CrtSY0Plj7W2uoRu1ykjiYwAbaDYgEDC7l7hI9SoYvEXKLDMeihjxQ/WKoeSGoEy6O
	 BZzcntPz0QqaA==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260122155046.12848-1-jszhang@kernel.org>
References: <20260122155046.12848-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: dw-mmio: support suspend/resume
Message-Id: <176955337024.1431389.1553422106063259304.b4-ty@kernel.org>
Date: Tue, 27 Jan 2026 22:36:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 22 Jan 2026 23:50:46 +0800, Jisheng Zhang wrote:
> Add system wide suspend and resume support, the implementation is
> straightforward, just call spi_controller_suspend() then assert the
> reset and disable clks for suspend, enable clks and deassert reset
> then call spi_controller_resume() for resume.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-mmio: support suspend/resume
      commit: a8b6e3738c872d35f1cf7b3cd3ce67d86d38e7cf

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

