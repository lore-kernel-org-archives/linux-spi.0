Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B52773D3
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777944300; cv=none; b=iDWp/h2cQwT0qyMh5SLyRIC2kdMCigER1TNYuz9505SWpJau9BEe90eraEqgZMQZaeEjItkaR09RiwC79+wtXPs6bkF7aSbh5ZoPUQLAzLmZvxSai3iJumhAQm2wFKnu7nZRr4Lnqek5nQIDHTYkPrMJsPhYmSsCxJwnT0iVTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777944300; c=relaxed/simple;
	bh=EjWK5hyMTEnw/Dc5suy7YvEsOAzy6+oCC79Tg4orlI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q+jfVV5L7VjwInqv1f/yDNMYTDcDIUr3VixeHZtg3V0oof9yE5xzrppfyRC846JYW3I9R6oVNsq3YBmaT7OgJoPZibJ9GkuHR6ktsadz6Ex9+LlScfTz15LaUyWjhUL7zOZ+1yEuj6lOmUwLqIHkxKnJ2rIJy47X7n9NRKNEJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4yB9pK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4yB9pK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586E7C2BCB8;
	Tue,  5 May 2026 01:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777944300;
	bh=EjWK5hyMTEnw/Dc5suy7YvEsOAzy6+oCC79Tg4orlI4=;
	h=Subject:From:Date:To:From;
	b=e4yB9pK/K/rcYUzCZaCDQ9fEsbPTn4+Ehu/dJ0F9+YRVEdbbg8qNq0D/AXFc7ptZ0
	 2xxm2nBJwA134ibcnWCukRFLxrkI7onVyxxW5xKx6v5dlYWY/hvwNmwN5BLx8PJZEG
	 Nf8isCSHK5KhQRInVpHu1xDlIHxuO8oZgG+l4pipPb9sc6spom67bJCIljgxqBzS8j
	 Ofk9a7UtUPQIEK2r52Grx9I4BqFc29ot4QTr5dUCn1Jvmy4NydiJ2vl3AAaiBUjLFs
	 9V/aPJKk1QvQkmYS7VqRyM1sXjaPa1eICvY89srNCXtVUE8DZc7nQLPz5I3isoQA7i
	 ZbpW/nI0Cf0+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 428C33930193;
	Tue,  5 May 2026 01:24:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177794425086.1376492.13207160356228156582.git-patchwork-summary@kernel.org>
Date: Tue, 05 May 2026 01:24:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add QSPI support for QCS615 and improve interconnect handling
  Submitter: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087622
  Lore link: https://lore.kernel.org/r/20260429-spi-nor-v5-0-993016c9711e@oss.qualcomm.com
    Patches: [v5,1/7] spi: dt-bindings: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
             [v5,2/7] spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM
             [v5,3/7] spi: spi-qcom-qspi: Add interconnect support for memory path

Series: spi: switch to managed controller allocation (part 1/3)
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087350
  Lore link: https://lore.kernel.org/r/20260429091333.165363-1-johan@kernel.org
    Patches: [01/19] spi: at91-usart: switch to managed controller allocation
             [02/19] spi: atmel: switch to managed controller allocation
             [03/19] spi: bcm63xx: switch to managed controller allocation
             [04/19] spi: bcm63xx-hsspi: switch to managed controller allocation
             [05/19] spi: cadence: switch to managed controller allocation
             [06/19] spi: octeon: switch to managed controller allocation
             [07/19] spi: cavium-thunderx: switch to managed controller allocation
             [08/19] spi: coldfire-qspi: switch to managed controller allocation
             [09/19] spi: dln2: switch to managed controller allocation
             [10/19] spi: ep93xx: switch to managed controller allocation
             [11/19] spi: fsl: switch to managed controller allocation
             [12/19] spi: fsl-espi: switch to managed controller allocation
             [13/19] spi: img-spfi: switch to managed controller allocation
             [14/19] spi: lantiq-ssc: switch to managed controller allocation
             [15/19] spi: meson-spicc: switch to managed controller allocation
             [16/19] spi: mxs: switch to managed controller allocation
             [17/19] spi: npcm-pspi: switch to managed controller allocation
             [19/19] spi: orion: switch to managed controller allocation

Series: spi: imx: Three fixes for the i.MX SPI driver
  Submitter: John Madieu <john.madieu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088539
  Lore link: https://lore.kernel.org/r/20260501135951.2416527-1-john.madieu@gmail.com
    Patches: [1/3] spi: imx: Fix precedence bug in spi_imx_dma_max_wml_find()
             [2/3] spi: imx: Fix UAF on package-1 prepare failure in spi_imx_dma_data_prepare()
             [3/3] spi: imx: Propagate prepare_transfer() error from spi_imx_setupxfer()

Series: microchip core-qspi gpio-cs fixes + cleanup
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088034
  Lore link: https://lore.kernel.org/r/20260430-levers-defiling-00406e391c5a@spud
    Patches: [v3,1/3] spi: microchip-core-qspi: control built-in cs manually
             [v3,2/3] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
             [v3,3/3] spi: microchip-core-qspi: remove some inline markings

Patch: spi: at91-usart: drop dead runtime pm support
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087351
  Lore link: https://lore.kernel.org/r/20260429092005.166128-1-johan@kernel.org

Series: mtd/spi: Fix Winbond W35N02JW / W35N04JW support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079878
  Lore link: https://lore.kernel.org/r/20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com
    Patches: [1/5] spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
             [3/5] mtd: spinand: Add support for packed read data ODTR commands
             [4/5] mtd: spinand: winbond: Set the packed page read flag to W35N02/04JW
             [5/5] mtd: spinand: winbond: Fix ODTR write VCR on W35NxxJW

Series: spi: omap2-mcspi: switch to managed controller allocation
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088109
  Lore link: https://lore.kernel.org/r/20260430120200.249323-1-johan@kernel.org
    Patches: [v2,1/3] spi: omap2-mcspi: switch to managed controller allocation
             [v2,2/3] spi: omap2-mcspi: clean up error labels
             [v2,3/3] spi: omap2-mcspi: clean up probe return value

Series: spi: support the SpacemiT K1 SPI controller
  Submitter: Guodong Xu <guodong@riscstar.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088800
  Lore link: https://lore.kernel.org/r/20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com
    Patches: [v10,1/3] spi: dt-bindings: add SpacemiT K1 SPI support
             [v10,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver

Patch: [GIT,PULL] SPI fixes for v7.1-rc1
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1088401
  Lore link: https://lore.kernel.org/r/20260501013924.B14F81AC5863@finisterre.sirena.org.uk


Total patches: 38

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


