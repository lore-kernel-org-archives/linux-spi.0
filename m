Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135844;
	b=pjWGQNe6eMKMrfZTUg6e4aeaHfL0RFC9UZKHqBj4BbiL24GsqIC/D91px0DBsmERIQQk
	 A0Y9mwZ+QDLi0Qa4g40+1CGJveItXkkXQdAY+1B5sEKujtCvfNajCB6cv/cwTa+CA3uVe
	 oJypmR52Zpa5FtyIYiA2hlqxpF+o28qoJTflHaSc16310pP8p4cq4V7B/BRK+sX0FMtlF
	 3sjpEt69E5lY6meOUkhvOjO4TcNoTlDI+sXgetP6HhauHNYiRTmRqjPVtCkFCuBwtKlp0
	 LOF9eaSbbe+5sNMR4m/B5rf4E6a2wUmmcO1p9JgkV3GqyCdt+fr6aed6z60u+MP06Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135844;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=p3NBFyErUdwmXe138graI7qm0I68SUXT5LMRQPFSpE8=;
	b=waXUiyUc8556zkPwuO/ZMkeL5nf4z1TQl2x4s3QeRbnVhTgvnCSHVk0625N5qiR3cpdu
	 aGasrttL/e8BVTZSOFx38rwCLqKymExLzfmNPPwVk7cOgbnSJnQcAunpz5Z0DYkPft3tQ
	 69kwtMLvBv4r/P/22Ce+PUdmpDYUF4KHgdLp5TFc1K2IpbDHEtht1+wGU20VC6/p6PMhs
	 WCO6MdHs+3kzxfiKPL8g/cN5mLKj6OG+qJ3iJJc0WENz8FPjIX9AeB+h1Xnovh2m3Bll+
	 JPmZGRIALQPFiGEJQxxg0opAWVQ80iGT7hRyxigY1BwmHeDSsToBORMnRjf3Z2vBnsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKmilFD7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA06606A31C;
	Sun,  8 Nov 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKmilFD7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6481F0089F;
	Sun,  8 Nov 2026 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135844;
	bh=p3NBFyErUdwmXe138graI7qm0I68SUXT5LMRQPFSpE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lKmilFD72w61IjGyuxsnVCVhiW7IGGnsCGPV79JKH2bZKX1wuzb6aZJbggikpHGhz
	 sZCY2UGogBNkuFNZZKBth2PWVzo2/srp4GSC2Tzcw80QpBHwTArb+niK9malrXNez1
	 Pz1ez98Wnb2f5Q4lVzLLtsGCXW/m92sb0FGpaGHrHUfcmp/IgjSBS7On6xORUnBmUv
	 kKPO1T7uaVSitbps+/dNFYJPTcNhrbg2dkiTCtIiT+EwXmuqREIFHZqeXDYZ0kp2vv
	 oGIrnmo22lyJoJ9ei0yJszOVBod35DFmdNYjltaaRyxuF75Fp//+SFI7GsKob3AMXs
	 /IKNmKbE6lzWg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 0A0D22BF8D23;
	Sun, 08 Nov 2026 11:04:02 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
In-Reply-To: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
References: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
Subject: Re: (subset) [PATCH v2 0/5] Add DDR (Dual Data-Rate) support for
 DW SPI controller
Message-Id: <179406387904.3424803.10093750511448298483.b4-ty@b4>
Date: Sat, 07 Nov 2026 15:04:39 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ES1TNf6PGsu5Apnp6Fa+gsDqHgK9eit/kgDlsilNUiI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+hMtxm7KvMNFY/VNX+LbpbeaHq2eF957/P23j1bub0
 862KVzN6ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBNvsPwh0t0x93wTZuPMp+W
 arkltOPCrVlblph5fnymUrZYVcc+JZbhf5pF4AxJvZXuBbHPFJn+8tn0ti71KmPOPjbLsuVSTn0
 ZCwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 28 Oct 2026 05:10:55 -0700, Changhuang Liang wrote:
> Add DDR (Dual Data-Rate) support for DW SPI controller
> 
> This series implements DDR support for the DW SPI controller and also
> implements 1-4-4-DTR read support for the MX66L1G45G.
> This series has been tested on the JHB100 SoC.
> 
> Changes since v1:
> - Add a new patch 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/5] spi: dw: Detect DDR support in enhanced SPI mode
      https://git.kernel.org/broonie/spi/c/c74069df13b0
[2/5] spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode
      https://git.kernel.org/broonie/spi/c/ed1e4b288e57

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

