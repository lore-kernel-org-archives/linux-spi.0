Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE63BCD3C;
	Tue,  4 Aug 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872498; cv=none; b=Hn9r6XyOqJEjH77XrUFikj2ijAOu+B31Hgk9bSvIhCPUw/Yq57AdHbg1rQHuI3NTp2LPvRHFABrjokIsCZ9JYX7yKej6+RJ8d5lT5lOq5AyRM5pJXwSWemUFAaS62s1KcqSqM09bpqGrtjX6M7Wozf/gEvE/zJd1nSxEoAxGeZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872498; c=relaxed/simple;
	bh=9EDERQJ4HZqTGGWwB24WdmoGO6+L9DJncbN1ZsNVsrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CiDCJiG/U9Phpdo4KHqomses1wLAKM46OnMdjol2q28Q+4UG5OBnF58nCg8B0V4ydBn2otiXuRlVZvUC4ZOawh6NZrayDYcpfa5jEaZtAAyIiSsURxKCGCLjslmHTH+anuSkt0fu3LVk0uOcVCwjMseAxCWTnPSR8JJDIgAf5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwSPTTnW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwSPTTnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947371F00A3A;
	Tue,  4 Aug 2026 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872497;
	bh=zb8FAbDfD2tCENb5hd+V6dVydQ8w7GMKoU5UPDij9i0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kwSPTTnWh6B0XSdN6VituJrUE7lhIeokHTcaDte7DlU9yJGthJCZmoh3x1Hx+Catj
	 3vwegc3vtsk6TERiUmUs3KksDJqBSFfbJPInYBQ/LIkPrEEw6Pdc62fNUHL+Q4xGk8
	 5+c3I9IvnzeuaU0YwImbQ6SELYANfMeykw7dB51nAJKffzyXUETJTX33f0FReV9t4O
	 mElpOs2RdLjdWmuW2uQZNIQWF7U5iigecZdJOWpOtLW0Urt9A35efLpK6MOawq/LL4
	 2bBDSZpiF8DhLeR9a7Bwk2GBFaAN0xC0qUfyV70EaquKkQrr89epi7V69gE9hlTEqe
	 Z9LPCFF4jym6w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>, 
 Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
References: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v2 00/11] Add support for StarFive JHB100 SFC
Message-Id: <178584803821.111355.7674282835778349051.b4-ty@b4>
Date: Tue, 04 Aug 2026 13:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9EDERQJ4HZqTGGWwB24WdmoGO6+L9DJncbN1ZsNVsrw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqckBuklnY8aM6ASEPX0kF1gaEt9Do8OhOoXzIX
 iS/e7YZkQiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanJAbgAKCRAk1otyXVSH
 0NsXB/447pC7Ta4LIEcdEnqHe+qMGWkT9cTW6kGy4C6WKZMcmBVcdq90u2wCOTaq7q4h+2sgx15
 Mf6GjP9IEiHOV9ai2Kb6Gp7hL4W8ApclAmU0csoJCvK5GeDbbs9vZLL3J2wTqmABi8eEx5Uf7eT
 lDtJ/FV/SiAD4ZZSxarEKAJnH9duplahYsUKLvKgoECZ/gfDx4o16keeCViYbCvFu4G4jOZdtPJ
 eOGC6g2DeLu164CsJlo50q7JxvmzAEXL1Ffd3D6v9CtQPigGJQdsqSSGOfo036yLJBKeHpI/09U
 vl6+i5ISH3MyrBfebQThatfY207Qw4wHYMfBwVylRIe28zPQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 03 Aug 2026 05:40:33 -0700, Changhuang Liang wrote:
> Add support for StarFive JHB100 SFC
> 
> This serial add support for the StarFive JHB100 SoC SPI Flash
> Controller (SFC), which is based on the Synopsys DesignWare SSI
> version 2.00a but with some customizations and it also add
> enhanced SPI for DesignWare SPI controllers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[01/11] spi: dw: Introduce spi_frf and STD_SPI
        https://git.kernel.org/broonie/spi/c/c87b4ba09702
[02/11] spi: dw: update SPI_CTRLR0 register
        https://git.kernel.org/broonie/spi/c/607687a869e6
[03/11] spi: dw: add check for support of enhanced spi
        https://git.kernel.org/broonie/spi/c/f6b36efcbe01
[04/11] spi: dw: adjust size of mem_op
        https://git.kernel.org/broonie/spi/c/3d7fd27c970e
[05/11] spi: dw: update NDF while using enhanced spi mode
        https://git.kernel.org/broonie/spi/c/8678095362cc
[06/11] spi: dw: Introduce enhanced single/dual/quad/octal spi
        https://git.kernel.org/broonie/spi/c/4cd882e1da79
[07/11] spi: dw: send cmd and addr to start the spi transfer
        https://git.kernel.org/broonie/spi/c/51119176c252
[08/11] spi: dw: use irq handler for enhanced spi
        https://git.kernel.org/broonie/spi/c/e017fae89e6d
[09/11] spi: dw: detect enhanced spi mode
        https://git.kernel.org/broonie/spi/c/defdd0f3d09a
[10/11] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
        https://git.kernel.org/broonie/spi/c/8edce30fc953
[11/11] spi: dw: Add support for StarFive JHB100 SoC SFC
        https://git.kernel.org/broonie/spi/c/012c1b04f528

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

