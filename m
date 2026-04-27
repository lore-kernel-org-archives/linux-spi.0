Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBF27587D;
	Tue, 28 Apr 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347458; cv=none; b=U7EVz1MIoPToc5ohmlZgvrQOg355+n2wL7A5q2/jvLBEJfVqplS8lb6BpOWM1E8wVCSke6JI3V0JhDIj9VcWip2KzPlMCZOJCoOBwfGr511d6Km9nQ01eqE8/Qr7D++ZV9nQ6IV8xv+m/y3anjyO0J7wY3uGFs/KmBiSLV1FT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347458; c=relaxed/simple;
	bh=NEf/nz49Jg5cePXiflaKdHCDvgtTYKtPL33NG+khY4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AhIooXZFOUhM9bh90VISTiowMrT+kn7O53BzPzwTDlNAomGrTudeJQYJm9x4LuTABNaxG2CyHnTotdRqCiM5mvHrMlFLWTnL9+GMIRgxlXCRDc0RJr7WNHvU88qB9YbMYAtTQXSGEkobMt8nF4J8io4h+WKypT9Uw/7JtdERoE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S603NHWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S603NHWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B77C2BCB3;
	Tue, 28 Apr 2026 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347457;
	bh=NEf/nz49Jg5cePXiflaKdHCDvgtTYKtPL33NG+khY4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S603NHWzzyuuW6NGjbe45U+3g2zbeeyN+6WY7hmeqEFU49pCh/qP4icOtTAtOItMZ
	 1HfjdtUWUgiUcVJoRkSXBAK+8CtIwLuHm9aDOYVB8Jg88sVryiwHRVPUDHJRwuKyeg
	 DEShaIYqiLN5hnBAj/2fZVugNWLt4XIivYqfN+aiK9hl7099ErQ6hMrGhgOzFnh62M
	 hBKdxSyk5wcTZ91qT1/QCBBi0Be3VDvhi5L+2lGhQ8cwXmhmI/si2CCeb/jvrX43Gj
	 UTq/yWw8XSk7dCqMU/bjl577g5VSBXXcK+YDIvaX2VU9mnPNIlTUBAwemnI40H4Xj6
	 bhH7iUA41xLsQ==
From: Mark Brown <broonie@kernel.org>
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Harshit Shah <hshah@axiado.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428-axiado-v1-1-cd767500af72@gmail.com>
References: <20260428-axiado-v1-1-cd767500af72@gmail.com>
Subject: Re: [PATCH] spi: axiado: replace usleep_range() with udelay() in
 IRQ path
Message-Id: <177733296453.324244.7720403151697677139.b4-ty@b4>
Date: Tue, 28 Apr 2026 08:36:04 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NEf/nz49Jg5cePXiflaKdHCDvgtTYKtPL33NG+khY4c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8Ct/MjDAxn8mdGp6ObrdIsYa9KFm0Svgqfo4R
 hLW2izo2B6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafArfwAKCRAk1otyXVSH
 0Hj7B/9yqUS9eo3ZW3/ugPvk+J9hVbs7T5ZfOhPCDnVLIwZgrsUNXbz5B98NkQ56+wqLz0YheZl
 SeGKo5ILY+W/5CLwYcM2jsmkeHxcijMXZvQ5kOPozbi/YC0CkHGpGHnORxyxbbEzFugDnfVNtVC
 +GXTRVcAh2ZRLsiNsEuXCljwRSCU2lXIn6jCkAyUcIbnKpl+k0zGQjj2fHg+qEGNsK969I6t/Q8
 8RNz0u/rgM8QaPbcvwdmGw1wdayIUuINpuhiePyv+qMU7ZmsLqYxSXWxMuLt9y23dbdoLuXcXLU
 fpcrYfijy2bTh0m6llpKpz4ccjoI/XY7PvlDiCLlRHlDlnqC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 28 Apr 2026 00:33:04 +0800, Felix Gu wrote:
> spi: axiado: replace usleep_range() with udelay() in IRQ path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: axiado: replace usleep_range() with udelay() in IRQ path
      https://git.kernel.org/broonie/spi/c/f5c6a272b699

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

