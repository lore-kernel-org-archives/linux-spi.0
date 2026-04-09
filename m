Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE23395D8E;
	Thu,  9 Apr 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774158; cv=none; b=jywQ800iFIXOxQfozw1p9v7mmWvSbBoSlSNO6flxWaxqyiAknz60wOr9bLfRbjBtdlnfK1Rxn8NICMRyRtJu5JB509Mf7w0NMbI9kHaNa5Ib0iS1FUHdEcKwCNOh+ZJHBAAU43QSrJHWe/sYXSxwPnWLq2uK2oCR2kOgdvHohw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774158; c=relaxed/simple;
	bh=1RKJElpzdUbhEiOAslIb3U7U4znh5scNAP+xaDOOoSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JaZtQ2juHFrj1IZdRYtKSqFuhI3Lum3iADMXXXMBBQDrrd7ErqBSNhxEo0pcrOBokwzx1msR7/n52Ig9Sq97i4oyBc1PytsKQio8MUt3X1ddjk2CFBJlE1DNg2zYMXBNhhQiDfdRUcjg61MSNBQmBXd5bgjwnaEQ0inQ/ZhJ+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvzrZo71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvzrZo71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B43C4CEF7;
	Thu,  9 Apr 2026 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775774158;
	bh=1RKJElpzdUbhEiOAslIb3U7U4znh5scNAP+xaDOOoSE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GvzrZo71bDVbRtSfQqmoqaO4nU/zCejQvB/BV6MCOE1Xp6uMo75g1NBmZ1UEyyr7B
	 uSS/IyS/nMPzWdIvPIal7kmxmiNWItIgvRy3fGX3+X05hiM/S/VFHME7RA06Dh9Cd3
	 BPA8S3iuDjqbJhe/PmXOkpml0SB11nZeh+k4d0cuLn5+z5nAdtypSASriPaIfZyX5S
	 wFTfhb5IQRk/SkZcKjIB4e38U8zK6MYPJDICQZ/eAlGNc3dBG0j3RZ6XtFB0POBa1H
	 111T9MYn2ax0y63VxpXCPjQjYPhVEQfL/NxIS57kl2/9L8KWC7y4yBYP4BtdyUkhzh
	 v5MG+ZGJQ/S5g==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Radu Pirea <radu_nicolae.pirea@upb.ro>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Subject: Re: (subset) [PATCH 00/20] spi: fix controller deregistration
 (part 1/2)
Message-Id: <177576177503.997653.13296252117952232507.b4-ty@b4>
Date: Thu, 09 Apr 2026 20:09:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1RKJElpzdUbhEiOAslIb3U7U4znh5scNAP+xaDOOoSE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2CnJqzEXfvJuMhruU52u1ekniUzTxmSTz9VMe
 urZNQLj7WaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadgpyQAKCRAk1otyXVSH
 0PKJB/9tWsND7yjVqiM2cflW/rQxFF491rUVbie2RCIe4nXuWnHaq2A2GwcL3f8wHGSu6TZO/K+
 DpeRgYEH0O8CMGwFrbgZI/oXjfM1K2Q2JSvfRW7/EchHQcvpju+dcvoE9zbYK6sybLgoQWdqeVn
 AEIOFlRyjqCdprXkCysuHfBDRserclxnZ7jy50jHvphFEZ/Mmi7tOXHacO+YyEiU9WMHNMY9On0
 V9mOD+WuyFOs6p1FGXAEocw2inDugOw/xOUFk+BrdE1QMGfWPJ46dKeQvIzpuAX5E0VZEndndLd
 0Cd41y0wUmoGvpRgjMFp7DrzHHj5CF1ROp9SGpqW04DhueCV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 09 Apr 2026 14:03:59 +0200, Johan Hovold wrote:
> spi: fix controller deregistration (part 1/2)
> 
> Device managed registration generally only works if all involved
> resources are managed as otherwise resources may be disabled or freed
> while they are still in use.
> 
> This series fixes the SPI controller drivers that get this wrong by
> disabling resources such as clocks, DMA and interrupts while the
> controller (and its devices) are still registered, which can lead to
> issues like system errors due to unclocked accesses, NULL-pointer
> dereferences, hangs or just prevent SPI device drivers from doing I/O
> during during deregistration (e.g. to power down devices).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[01/20] spi: amlogic-spisg: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/84d31bb1f625
[02/20] spi: aspeed-smc: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/1044e5a4ccd5
[03/20] spi: at91-usart: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/9acecc9bcff0
[04/20] spi: atmel: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/8d4de97e8352
[05/20] spi: bcm63xx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/c39e65a4e3b8
[06/20] spi: bcm63xx-hsspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/ab837c51899d
[07/20] spi: bcmbca-hsspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/c3d97c3320b9
[08/20] spi: octeon: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/3c49a4d8799b
[09/20] spi: cavium-thunderx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/dbb6b01267c0
[10/20] spi: coldfire-qspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/e7c510e192ff
[11/20] spi: dln2: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/c353020fbfa8
[12/20] spi: ep93xx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/f4838934b695
[13/20] spi: fsl-espi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/e506a700a7ad
[15/20] spi: img-spfi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/fc3a83b0d9c1
[16/20] spi: lantiq-ssc: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/b99206710d03
[17/20] spi: meson-spicc: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/77953c76bec9
[18/20] spi: microchip-core-qspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/e6464140d439
[19/20] spi: microchip-core-spi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/d00d722ebad4
[20/20] spi: mpfs: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/573c7db8fce9

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

