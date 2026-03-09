Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A334F472;
	Mon,  9 Mar 2026 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083207; cv=none; b=kDz1N42M2s/WDWUrFI4oyZ04jWeO6izezHgbYmW3LPQ3HPfMye1WZEFFOs68VlYxueBjfiSiP5v+5cq3aHUGAvj+QwDiX1/YEaUK3BMf1hjorEm+joUdGALoq61Egi5gRL0HunjLt4jBR0wATy2+djcCu2+6Ow2Tnttjxltr/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083207; c=relaxed/simple;
	bh=mzM1cghYUK9xVXcA3OodM78rFSeiLYAF46+jRkGZRkE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rcrz5kBowIi4iMJGe+lrmwc3VdhdE2tNSYb3yLE7xxuje2xTSQxv8719ysvCRhbddY4goqeaaKwN0eQYBZ6TuLOwW5UPoa9TM0tbPghsRYP8XoJP70NGtpzwEVXt9r6377aTjrIYbQsok//tNMvIxljg8j3EnPzp363UiaRtEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0z7xp5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0z7xp5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A019EC2BC87;
	Mon,  9 Mar 2026 19:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773083207;
	bh=mzM1cghYUK9xVXcA3OodM78rFSeiLYAF46+jRkGZRkE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S0z7xp5sN9wNZjkWuetTys4QVegtU6WkOMUbE9gx9Ol63Qy5gcVVj9aBkBj49SPXT
	 tLmfzKyazXPpcKABZAazWyJkp84sRWUAvjd0ULGbi4Ei723dwDAH8/161b9D2pRfkO
	 BbVHt7U+S5OenJdmt0RS+qggad73Oibv3gZNR+qwpzMab7mmzm2BrxKPxFL474NzWY
	 8Tu8n87cFk0EYXI06bhEFhRUWgcxwavNDGOThjc7rV0sZxJCdqtJu60dHujCyuS7Ra
	 PQ1x8xuWuqs3mUnBpK5IXoPiUEGrq6RkpSpa6D8jE3x235mto/Nj65Ia5Jz1VFYI31
	 2lUzfk5RzZiFg==
From: Mark Brown <broonie@kernel.org>
To: CL Wang <cl634@andestech.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305-atcspi2000-v1-1-eafe08dcca60@gmail.com>
References: <20260305-atcspi2000-v1-1-eafe08dcca60@gmail.com>
Subject: Re: [PATCH] spi: atcspi200: Fix double-free in
 atcspi_configure_dma()
Message-Id: <177308320638.255456.5056724011837560562.b4-ty@kernel.org>
Date: Mon, 09 Mar 2026 19:06:46 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-83dbb

On Thu, 05 Mar 2026 20:22:38 +0800, Felix Gu wrote:
> The driver uses devm_dma_request_chan() which registers automatic cleanup
> via devm_add_action_or_reset(). Calling dma_release_channel() manually on
> the RX channel when TX channel request fails causes a double-free when
> the devm cleanup runs.
> 
> Remove the unnecessary manual cleanup and simplify the error handling
> since devm will properly release channels on probe failure or driver
> detach.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atcspi200: Fix double-free in atcspi_configure_dma()
      commit: ad0e9ac2d5f5ab7a773c2c07ecf06ee59db9259f

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

