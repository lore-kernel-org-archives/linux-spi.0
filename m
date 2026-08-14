Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3FA39F162;
	Fri, 14 Aug 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721154; cv=none; b=kFm1LeImKVo3EmajqtQ2lO329WnjQ0okNIgIiJkWaNa13tL/8EKV7cxM/PNw5QCTuBLqFZVGRem6+RbJ60eI/B3Wv8x1TQ7UFRxFp8zbBnZtpy0BMVD8E+/kLWu87jRo6l052MYi8r73b1ovu5xhszvabXsoPCGs2e8Zw3NDO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721154; c=relaxed/simple;
	bh=ak79TMgzFa1RpXdyvr/PCLH7lKEmbz6BNPW5165tTjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FjKGaeng7rz0XN3nREe2C82Od33b0Gu8HTKOHW+fh0C+cc6pBuvaQZKhJ2Fy34uPfnzhd+8ZZbj8fu/ebgqtRz4UcOdyWU82A6JDYrCwl5FQ8fJ5DJEtln0pwbT+hW5qJ4u3gyQnxg53DCgmR5w5Y1ncayPJgy4SC1VEC/RNZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC4mY75E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC4mY75E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DF81F000E9;
	Fri, 14 Aug 2026 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721152;
	bh=4P2Uqal5fCOZ6vxtHXYL6JVblh9CtBcZ4XBZjUo5gMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QC4mY75EU4G55Ix5S2Hl07J7CLkljwyHynEkfOw4K4CHWVAgOj8wm2/6DgRQJrR2M
	 Wv16Eq3SSH9UkNkfGbwzRGAJvmUmbumD53ylD9ntUXOPIZlCt41O1VibgF8BqEe4+r
	 De+9qNCryj+widk2DaIiq6PLA2PaYbFZ9g2XtfhHdHFmAtK3zMQQBTlrYKmWlDZS5C
	 O+zBw8JbVMGaoR6WK5pl6eiRK6ONplM9G3PYv8veAklmQUxSlJ+/8znHd4JkSp962k
	 AZ+jD9GiFIdNuqUMuFnmN4Bx1vLqN8CSkFtxPHOmftOFX1v5Q8T49TJ8ahY/UhX17B
	 doDSXwVjqSyVA==
From: Mark Brown <broonie@kernel.org>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
Subject: Re: [PATCH 0/5] spi: ma35d1-qspi: Improvements and DTR support
Message-Id: <178671109592.118516.7247309761546749849.b4-ty@b4>
Date: Fri, 14 Aug 2026 13:38:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Thu, 13 Aug 2026 10:00:20 +0200, Miquel Raynal wrote:
> spi: ma35d1-qspi: Improvements and DTR support
> 
> I am in possession of an MA35D1 NuMaker board. The SPI controller has
> been contributed, but:
> 1- it lacks a DT descriptions [1]
> 2- it does not work with current clock driver [2]
> 3- it can be improved
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/5] spi: ma35d1-qspi: Remove redundant reset operation
      https://git.kernel.org/broonie/spi/c/dc72e9e8cd19
[2/5] spi: ma35d1-qspi: Move speed setting to bus configuration
      https://git.kernel.org/broonie/spi/c/b5671d865ed9
[3/5] spi: ma35d1-qspi: Allow several command bytes
      https://git.kernel.org/broonie/spi/c/99542d244f53
[4/5] spi: ma35d1-qspi: Add DTR support
      https://git.kernel.org/broonie/spi/c/15e9362f6190
[5/5] spi: ma35d1-qspi: Use the existing update helper
      https://git.kernel.org/broonie/spi/c/0730bb35229b

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

