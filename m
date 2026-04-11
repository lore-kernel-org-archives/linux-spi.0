Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8F34104B;
	Sat, 11 Apr 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775908680; cv=none; b=QfGqyIGEE5rxDI5lqKvXmqkRygnYgKe3VZnCBYfl3t42i0Q7MBQltxm0nRDKa0ifpGycrztzLA1XjCoo8OtkARvXDgpNJzaAOiKXctzpFTM8JkODAZcnklJyxD+W3FeGcsIoZ2M0MLS5EgtxWt20WVqh7MD52S2LLl9ZBvSG6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775908680; c=relaxed/simple;
	bh=9aNqulo+bCDLgbWF+8OgFjFhrZ7sbZ/hMi9TK61Sr4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rAQhpyo+AHTHFrbgGYlHBOGkbV+sZV/iE+XkR6nevHO7+NePPMujpuQMaMOJlJO6Ge3O+u+wzESw9J1+BY1g1vYrDA60EGCFS7qsD8tU4C1NkfeNwQotmYqz0hmmRPNy08KHjDWQShdLW1WFKAhlhh7N3IKXbVARCOu6dqGfN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOL9zfUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOL9zfUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EF7C4CEF7;
	Sat, 11 Apr 2026 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775908679;
	bh=9aNqulo+bCDLgbWF+8OgFjFhrZ7sbZ/hMi9TK61Sr4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QOL9zfUNhkMZizlDfk1CXuqqsB+elpMicOaY6nk4xnfwf3qT5+LpKECMV5gSE0iN7
	 Y8pE0UQA283oAeP4VrIWGixvNvK19mqDD5Pjv5I5L+1bwNXugFFWCTVAqv93dxp0Uh
	 YI7KqfVP2BYQlsAhr8Fnf5gFNFkrzhIzFaLDuFoGp8BgLuiLVBCPqCQ4NHNylzr39n
	 WKjL+cCqW/UoBMLfCVZvFpa6XT+qcPMA0r0uyYeGRTTZy/i0dk2z7uESepfFpH+im6
	 EyZZI2+oxlbAWFsSP/qeybpAVguLbkMEZHhjiLqdAkdtm1Bq/uCYhCFFWbkK+QhXZ9
	 Z6NoQxVyKIq5A==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
References: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
Subject: Re: (subset) [PATCH 0/5] mtd/spi: Fix Winbond W35N02JW / W35N04JW
 support
Message-Id: <177590483913.1311359.6081286854444459409.b4-ty@b4>
Date: Sat, 11 Apr 2026 11:53:59 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9aNqulo+bCDLgbWF+8OgFjFhrZ7sbZ/hMi9TK61Sr4Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2jdDnJedcoisHr8tbHDR8goEXSs8gjCLDC7gn
 CpwO75H5uOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCado3QwAKCRAk1otyXVSH
 0GhkB/4+9YuJbCvIZ+MzzcRpmGNisyUfJa1P4bnbAvshl9dO0wBzx7b2+pvM37qGIQR7usjVcfr
 MOVg9Cx+s2rWedOrqXH+o4gAE+HalWL1BdxPXs6EIy8zbd+UCRphSnxcAOKoSu9TRSPrNN2IQST
 4ZM9jKmhjNHhlVF06FwJ5IO2ZF7gleQtp/0QK0CN9c/M34jLAqTe0pZP3Ql6P+gI2X3+v6RxHdI
 4hAKWpJPGMbmOsRFeDDepBsBhSQjGPIzecWiVRnBpm2SpkztO8aXg59yO1mSBhf6fQ6FjwSoY6M
 5OtXVl6fSPVuuR12eCI4CZAWuRjzFK4kwwbdQh750YYMTDIP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Apr 2026 19:41:00 +0200, Miquel Raynal wrote:
> mtd/spi: Fix Winbond W35N02JW / W35N04JW support
> 
> Winbond chips W35N02JW and W35N04JW differ slightly from W35N01JW. As
> they have more blocks, they require a couple more bits to fully address
> the whole device. These address bits have been stuffed at the end of the
> command cycles, which is non standard, and this is something I didn't
> catch in the first place.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/5] spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
      https://git.kernel.org/broonie/spi/c/5e75c1d4d386
[2/5] spi: spi-mem: Add a packed command operation
      https://git.kernel.org/broonie/spi/c/f79ee9e4b232

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

