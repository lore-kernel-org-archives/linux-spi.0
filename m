Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54D27A47F;
	Mon, 16 Mar 2026 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625089; cv=none; b=h63zLB8xwKcXXZTkWzBLMP+G+UoPuSh2OdFXn0O9zlXyA23wUpNhfOpgrOVGCvp9kapT4VtBHwxQmdh1Er8DsyqAVHUYDKPH7Sd5NUFp2kogiSWmZyzcLcQz23vykJUvhlWGMcTPM6Q7SbtVZYrM1dvAch0qChzU3h06ZjFb/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625089; c=relaxed/simple;
	bh=QaMYSj2E3J2MiJ1HFej1CfGH/Zo9YEH4AIY/2x7kc6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LkqMj+xRJe1r5moDSuUyhcUHjr8q2YG05/nHXZpQghfOiZP4tUPh800BGRxgyxMoT0+vJ5xfADSC/dAF9PYVBm/TMk+mKvN5tkxrHV4cBeHtZvXr1nl0118x0NEMcT6sQEMLueJdzEUtM8O3b1ltDV+bnwVpPp940NwQH3j2mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaP/7Yn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaP/7Yn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A9DC2BCFC;
	Mon, 16 Mar 2026 01:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625088;
	bh=QaMYSj2E3J2MiJ1HFej1CfGH/Zo9YEH4AIY/2x7kc6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DaP/7Yn1Lyyz84iHMAPsxm/qSwP0EfH5+hC/rFbj1O6Ev4WzdOuclEkfIwWiZHhTg
	 tgvrFZa7gd9d/fvfPZMCFIQoNCSBKJldwauUy57+flwzijOaH+QGe54uEh9RVOu85d
	 k8tjMd831JDHXr5Yzlk2lB/j+rCV/aiejgVUHhW0sGHaiAy5pwbfN+StUo/BVinC4E
	 Yt8j5eLKP7LPw0Be1ayiFjFO54ohdwbgYI6EjR/mNiCmQDnYI6+OxSBR6ex/9vGBdZ
	 OdS18Hxgddn9LTBu5Zk0ha+r73sF+OOfiPvM7fJvLBHPq7e5CniOScmN/lYr0qU+yd
	 7bZoEcSghSKkA==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Harshit Shah <hshah@axiado.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com>
References: <20260307-axiado-1-v1-1-e90aa1b6dd9b@gmail.com>
Subject: Re: [PATCH] spi: axiado: Remove redundant
 pm_runtime_mark_last_busy() call
Message-Id: <177352554001.149922.7199933321657961901.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QaMYSj2E3J2MiJ1HFej1CfGH/Zo9YEH4AIY/2x7kc6k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt179BQywpjfiFhRqfaWhbs29/PtRQgdd1Wt8j
 J9Xu/QMqReJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabde/QAKCRAk1otyXVSH
 0ARIB/4tfl1/Rpme4nsvh6yVGFj6HPUurTbgCCS3NwoEpjAnw+kMZaLmJ7CJa+GORxoQH4RfnrQ
 o5ZcP0nSOgwZpu/RqedRj3rspEm51Tnn7mv7H//pfpPKWRTW6/drWm77RlMR1jXnn+GIparOhzs
 A9qv+HxE8CLXfDgOEXhpOVIuPZLi6icMxNdp2ytbyM1twmtxDIGfP0Hd+prHplOwvBg8lQDKpVK
 bliTcyk02eyy40cLJr23voQBH+zTR/AzxhaTjwi9PYM9baI0TEfW1YF+ZvbaWcWVoajoLpWFiM8
 DCyRagtOi9edpYBArTGuAXtKZSEFqCAwjo7qZT4y6geOr6mP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Mar 2026 15:47:15 +0800, Felix Gu wrote:
> spi: axiado: Remove redundant pm_runtime_mark_last_busy() call

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: axiado: Remove redundant pm_runtime_mark_last_busy() call
      https://git.kernel.org/broonie/misc/c/ec6c2e15a42f

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

