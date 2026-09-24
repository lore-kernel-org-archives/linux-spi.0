Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DF423E9E;
	Fri, 25 Sep 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331365; cv=none; b=ZnqH4gfw9jg1xxxWzUUD3pARPlDzo/oFmQ/UvcfB884kvUqWL3CFVXrVw16CIzaQ2scUS3nHtu2WcAwpIiPifBwJQPs9LavCww+hB5c5ITjbDqbE7s/7sXPo6KO2DcrEKhIXqR86RLnS/BBJj1ZMsAUyw+sqcyrRLzlzXO/GLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331365; c=relaxed/simple;
	bh=DOCogC8VZUdOUXFgbMaseVq7Jwe2YN8FRQBo1oKxJys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MZLEcsoMycWFwoEDRLKtyiRqEFzY4CBLSXqosasFDt6uCHHkM6Zi3Kjwp1BBxzsYNxTZpXDXa6vkx4g4HdFhtg6Gng4HlrmBFZXGHj3RuuM59At/FQkAGqnvzd3C2cadj8Mrp/GwxLxL+CEB2f9fcUvNQB6cKBhM5+Vih+IXeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXDCreTL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXDCreTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888451F00893;
	Fri, 25 Sep 2026 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331363;
	bh=UNP7bFWNDrSQfBLNaeNOpZUuBT3HZBThto/XhQC3kz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DXDCreTLckDkGW3CBUxEBoHL/5PbNIDht0pd/REMXss727Qg6oPsrRd7yZxpky5R3
	 MRsl5eVW1nuhSyj+If+tEawNhCWxmWRAdxJ4hEJmKQDAoEKLxb3Y55LNRPH64LLGeZ
	 7/BQvXywTnb43MRtB5ki6EEBAvv6ELYb0E6osEyj4awRhY8/jEZIv9Ob1frCYgG/n8
	 6Z96Ib7LwWXK6bYdxzuX2s6IN0zvVLrN8C/ca9TQlJevF0drindUqgQjmJIF0b+iF6
	 Ys7oIbnl7BDAa9BUgNAi+5ReWjINcVi4eVHtfDpmePkVxDNg/gDK5m7OPo3+3ARwMA
	 qt4euS+4xvbyA==
From: Mark Brown <broonie@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
Subject: Re: [PATCH v7 00/13] spi: spidev_test: new features
Message-Id: <179028361909.149798.4722443728698354015.b4-ty@b4>
Date: Thu, 24 Sep 2026 22:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DOCogC8VZUdOUXFgbMaseVq7Jwe2YN8FRQBo1oKxJys=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtkngY2ZW1gvAdC7r31iYK6B/Vdi6yGoyruDMD
 df1qeZg+46JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJ4AAKCRAk1otyXVSH
 0BihB/sElioqMTCgaaPUWoYEeO+in8A/OIwvRWi/1u5fb68QylVVetojNzTXdgGbKx+HxnMmBCC
 8oshk4T8sieFLHHapWkmYBdIROFlSGvPY4dBEDJB8/VIBKKIcweKqqRqlXQ02FBGIRi8a5JcCiU
 9bQA+dcJZ7DhWX/Ko10U1b6/F3iJFZueMGOal7l2UevKvNHxMKT7Cbrxk8cT7gAUHopdDDtAgGu
 64miP4eh09oZ5o+oywO1bsX3Ko+gxFI3O0kLIA2mkzENm6GaA7Wys8mPUsCngzfynH2eJQ/HnS4
 ky4CYh2fPGMzgorRweLFDxO2lWLFpzvwwWVQxtM3UxCiXfNm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 24 Sep 2026 15:43:50 +0200, Jonas Rebmann wrote:
> spi: spidev_test: new features
> 
> A collection of new features for spidev_test which have collected during
> testing/development of spi drivers.
> 
> Patch 1 is a small preparatory commit to share macro definitions with
> the rest of the tools tree instead of keeping local copies.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[01/13] spi: spidev_test: include tools/include
        https://git.kernel.org/broonie/spi/c/88ca7a587f73
[02/13] spi: spidev_test: clarify usage for --size
        https://git.kernel.org/broonie/spi/c/a9e74a4c9911
[03/13] spi: spidev_test: make size argument mandatory for --size
        https://git.kernel.org/broonie/spi/c/df79e49bd7d7
[04/13] spi: spidev_test: allow zero-length transfers
        https://git.kernel.org/broonie/spi/c/bd511c42d290
[05/13] spi: spidev_test: abort when -I is selected without -S
        https://git.kernel.org/broonie/spi/c/683d7fac9b0f
[06/13] spi: spidev_test: always compare loopback data
        https://git.kernel.org/broonie/spi/c/2d736e05dbcd
[07/13] spi: spidev_test: add compare mode
        https://git.kernel.org/broonie/spi/c/a47226866b8a
[08/13] spi: spidev_test: allow disabling rx or tx buffers
        https://git.kernel.org/broonie/spi/c/d2b908c75a81
[09/13] spi: spidev_test: don't send 0x0 or 0xff
        https://git.kernel.org/broonie/spi/c/951a60af6c0b
[10/13] spi: spidev_test: send predictable data
        https://git.kernel.org/broonie/spi/c/c807c71d21eb
[11/13] spi: spidev_test: add option to split message into multiple transfers
        https://git.kernel.org/broonie/spi/c/31ce698070aa
[12/13] spi: spidev_test: print TX on error
        https://git.kernel.org/broonie/spi/c/a73c71e1f25a
[13/13] spi: spidev_test: rewrite unescape() to stay in bounds
        https://git.kernel.org/broonie/spi/c/c79bbeadabc0

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

