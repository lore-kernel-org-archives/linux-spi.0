Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A730AD0B;
	Mon, 27 Apr 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285246; cv=none; b=elTopirQ32VMlTS9RxjGeSPNZfzzLX8gAA8y20NprHFbp6PGktqnE01tKyPQN/x7XEIxSo3j4qQAmbWq79qfr6RtZKidzL+Lg/SVyVM5UysgfmqItBGGC3cV1kFhBHEBHZ2QdVllEB0q7ZVh1OZ7wAFCpBVZGZFY+mmwTi6Slk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285246; c=relaxed/simple;
	bh=tBAbz6EcU3LWyHlmX0Y4KOsu/Q9c9EXY1FH07SODnEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ofk9uvjMYBGoLMYLK5PVh4f2UYSO/dLTiM9swZg9Noyw/czh4CykI/XDma39fzB0L3r9nVtOR0qNW5L2WhzmkTTObi1W9ERpsskmN4wVNSUmlAAEijuUKerurLStSa3doQ7bO+j8ugC7L1bZxmDxMeTS3DEISkd86q4Zczn/EQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfodbggD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfodbggD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DEFC19425;
	Mon, 27 Apr 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285246;
	bh=tBAbz6EcU3LWyHlmX0Y4KOsu/Q9c9EXY1FH07SODnEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nfodbggDCKjppCanU2q7mcIShROftqHE6iJSJ8/meUrZ/8hDhWexSuFftBwY160tE
	 ShuxwKp1QcTEM52g3KpXWbZyBXMOBdHazROdnSNPIpy5okmeWig9DIOfP3fNMhJX1I
	 FjEG5kT3XA1q//NCdpz5aZNcuMSfBsc+NoJsbG3fUuA/X7Uz9Jhn8h8HVkSZA4ol5O
	 AhV25ODlwIF3P1sKLqjN3pAV1bLqWUz+PAexA64VByzuGO7AQLmUmnbxbbCtENyA4n
	 h/IIBtWN/uP64U1e8iz2yfSi6Zz0ZVFWvh97WSB4C2NJ/JPgJ/+xLtVBoscnw56isT
	 jiU8TZtyONBvA==
From: Mark Brown <broonie@kernel.org>
To: CL Wang <cl634@andestech.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260417-atcspi-v1-0-854831667d63@gmail.com>
References: <20260417-atcspi-v1-0-854831667d63@gmail.com>
Subject: Re: [PATCH 0/2] spi: atcspi200: two cleanup
Message-Id: <177724638006.266775.16652491820735407578.b4-ty@b4>
Date: Mon, 27 Apr 2026 08:33:00 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tBAbz6EcU3LWyHlmX0Y4KOsu/Q9c9EXY1FH07SODnEA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7zh8BYrTGhbZ/os0IjcrNzG/dTYCHb9TiaW7G
 x5y7kSw2bmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae84fAAKCRAk1otyXVSH
 0KpyB/0baKhTRAvOAvddhRAh6+kzHyWDA51vUBzAoDKhRVXWNBlFXyZzDeuxsZ/i3P3Xu59stR/
 IX3moeuUMqbd88VsbGY/rw/bp2FUOi5XTsxT9P4xE+IzAKM7G75xEYYLcLO7ujNPc2aFLj0wilU
 9wKBz805JoDFq3+O1lBj/YpMAThbS3ysKwx4ofAKWUtju2w1/zOwOXkP4NIKmWqtZk490NZqlER
 cDHLeNAmUqBJQdWo/LtSLnCKTiO2lpnhdhulCxlpH+ts9dnC/Nwdn75+lh6In8uXQ3olB4s2Ms8
 ujVrEcKFAxd3grCHnTtEKyPC/emZPytpBB60PD6mhI8X6ts+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 17 Apr 2026 00:27:53 +0800, Felix Gu wrote:
> spi: atcspi200: two cleanup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: atcspi200: fix use-after-free when driver unbind
      https://git.kernel.org/broonie/spi/c/565bdf45125a
[2/2] spi: atcspi200: switch to devm functions
      https://git.kernel.org/broonie/spi/c/aaea50c3bd76

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

