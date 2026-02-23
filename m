Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FBC3019D8
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862907; cv=none; b=ahYtc8z9m73Iw+2hk9BsAmJz1KTz7SaWY4YfPEfRTm8INNYin6jE+QxFeVYrNq+m2vjQYNOKqkg30gEkSwI4hIddIcBpKn1IUSQoXcTOIUOeZRusFOsEFS8Owj6lpzRUVSQJUwgqzCWuLMuK8yLMMxcepPcYjPvJO9Sl09fcKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862907; c=relaxed/simple;
	bh=WuJu9Czo5A8pwAD99Zocf4aJMfdjElBkVdtYwH+N7OM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K58zHeA0tOFwvqbPk7/vFk4shYjib6giS1FO4j+xpzOj77oli/78f54MNgsSeR6aJJD6nVhZjJsNhaXakmq19UzG/J5xrJEMjmTXZMYT8zo2y7GIV769Wkp9GBDYTSBYVvx1Sq7y/WXmY4vt46FDnRgzmpIIrvntywNXNu1QARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW5FqC1/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW5FqC1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638BCC116C6;
	Mon, 23 Feb 2026 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862907;
	bh=WuJu9Czo5A8pwAD99Zocf4aJMfdjElBkVdtYwH+N7OM=;
	h=Subject:From:Date:To:From;
	b=OW5FqC1/i9kucJquJDwZe1LA3abQGal3Y/3nG0ac5rmM+xNQ9j9ladTk3PFB5/0FT
	 CLd8pdUWwgXlEWmlqd7bRPHSnTFqJi2yyuwu3jsh3nmCu0CsLCVAO2hDHBqe9lm+T2
	 kkfzvu6WkmfcAOX21cfCwCAtQxoGumrJyky2A8vS7mEIcKz2+XaPlHULU95O6slx82
	 81c0n7IDjB2H2K5AwOpSeJfQeLyAgolfkjhJeqhxPBxX1RocJ9GlA6aKAXD56CnYso
	 gPa/gvdDZd4ZC3goE1M0IgfB+uBE6g7hjbEHf+457OntoTVo/QDN04LgrIoj/T4bSq
	 sHUVOGlatqacA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCF4D3808200;
	Mon, 23 Feb 2026 16:08:34 +0000 (UTC)
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
 <177186291324.2372049.9152414702394981148.git-patchwork-summary@kernel.org>
Date: Mon, 23 Feb 2026 16:08:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mtd: spinand: Octal DTR support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1040574
  Lore link: https://lore.kernel.org/r/20260109-winbond-v6-17-rc1-oddr-v2-0-1fff6a2ddb80@bootlin.com
    Patches: [v2,01/27] spi: spi-mem: Make the DTR command operation macro more suitable
             [v2,04/27] mtd: spinand: Fix kernel doc
             [v2,05/27] mtd: spinand: Add missing check
             [v2,06/27] mtd: spinand: Remove stale definitions
             [v2,07/27] mtd: spinand: Use standard return values
             [v2,08/27] mtd: spinand: Decouple write enable and write disable operations
             [v2,09/27] mtd: spinand: Create an array of operation templates
             [v2,10/27] mtd: spinand: Make use of the operation templates through SPINAND_OP()
             [v2,11/27] mtd: spinand: macronix: Convert vendor specific operation to SPINAND_OP()
             [v2,12/27] mtd: spinand: winbond: Convert W25N specific operation to SPINAND_OP()
             [v2,13/27] mtd: spinand: winbond: Convert W35N specific operation to SPINAND_OP()
             [v2,14/27] mtd: spinand: List vendor specific operations and make sure they are supported
             [v2,15/27] mtd: spinand: macronix: Register vendor specific operation
             [v2,16/27] mtd: spinand: winbond: Register W25N vendor specific operation
             [v2,17/27] mtd: spinand: winbond: Register W35N vendor specific operation
             [v2,18/27] mtd: spinand: winbond: Fix style
             [v2,19/27] mtd: spinand: winbond: Rename IO_MODE register macro
             [v2,20/27] mtd: spinand: winbond: Configure the IO mode after the dummy cycles
             [v2,21/27] mtd: spinand: Gather all the bus interface steps in one single function
             [v2,22/27] mtd: spinand: Add support for setting a bus interface
             [v2,23/27] mtd: spinand: Propagate the bus interface across core helpers
             [v2,24/27] mtd: spinand: Give the bus interface to the configuration helper
             [v2,25/27] mtd: spinand: Warn if using SSDR-only vendor commands in a non SSDR mode
             [v2,26/27] mtd: spinand: Add octal DTR support
             [v2,27/27] mtd: spinand: winbond: W35N octal DTR support

Series: ASoC: rt5575: Add the codec driver for the ALC5575
  Submitter: Oder Chiou <oder_chiou@realtek.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033644
  Lore link: https://lore.kernel.org/r/20251216071853.3929135-1-oder_chiou@realtek.com
    Patches: [v10,1/3] spi: export of_find_spi_controller_by_node()
             [v10,2/3] ASoC: dt-bindings: realtek,rt5575: add support for ALC5575

Series: [1/4] spi: export of_find_spi_controller_by_node()
  Submitter: Oder Chiou <oder_chiou@realtek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1036664
  Lore link: https://lore.kernel.org/r/20251226083101.1052156-1-oder_chiou@realtek.com
    Patches: [1/4] spi: export of_find_spi_controller_by_node()
             [2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF

Series: [v11,1/4] spi: export of_find_spi_controller_by_node()
  Submitter: Oder Chiou <oder_chiou@realtek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1036671
  Lore link: https://lore.kernel.org/r/20251226083904.1052630-1-oder_chiou@realtek.com
    Patches: [v11,1/4] spi: export of_find_spi_controller_by_node()
             [v11,2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF

Series: ASoC: rt5575: Add the codec driver for the ALC5575
  Submitter: Oder Chiou <oder_chiou@realtek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1037516
  Lore link: https://lore.kernel.org/r/cover.1767148150.git.oder_chiou@realtek.com
    Patches: [v11,1/4] spi: export of_find_spi_controller_by_node()
             [v11,2/4] spi: change of_find_spi_controller_by_node() gating to CONFIG_OF

Series: LED: Add basic LP5860 LED matrix driver
  Submitter: Steffen Trumtrar <s.trumtrar@pengutronix.de>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1029227
  Lore link: https://lore.kernel.org/r/20251201-v6-14-topic-ti-lp5860-v6-0-be9a21218157@pengutronix.de
    Patches: [v6,1/2] dt-bindings: leds: add lp5860 LED controller

Series: [v2,01/19] include: dt-bindings: add LAN969x clock bindings
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033379
  Lore link: https://lore.kernel.org/r/20251215163820.1584926-1-robert.marko@sartura.hr
    Patches: [v2,01/19] include: dt-bindings: add LAN969x clock bindings
             [v2,06/19] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
             [v2,09/19] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
             [v2,11/19] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
             [v2,12/19] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
             [v2,14/19] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
             [v2,15/19] dt-bindings: hwmon: sparx5: add microchip,lan9691-temp
             [v2,16/19] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x

Series: Add support for Microchip LAN969x
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1042779
  Lore link: https://lore.kernel.org/r/20260115114021.111324-1-robert.marko@sartura.hr
    Patches: [v5,01/11] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
             [v5,04/11] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
             [v5,05/11] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
             [v5,06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
             [v5,10/11] dt-bindings: net: sparx5: do not require phys when RGMII is used

Series: spi: stm32: stability & performance enhancements
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1034541
  Lore link: https://lore.kernel.org/r/20251218-stm32-spi-enhancements-v2-0-3b69901ca9fe@foss.st.com
    Patches: [v2,1/4] spi: stm32: properly fail on dma_request_chan error
             [v2,4/4] ARM: dts: stm32: add spi1 sleep state pinctrl on stm32mp157c-ev1

Series: fsi: Convert to bus probe mechanism
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1028913
  Lore link: https://lore.kernel.org/r/cover.1764434226.git.ukleinek@kernel.org
    Patches: [05/12] spi: fsi: Drop assigning fsi bus
             [12/12] spi: fsi: Convert to fsi bus probe mechanism

Series: fsi: Convert to bus probe mechanism
  Submitter: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1031693
  Lore link: https://lore.kernel.org/r/cover.1765279318.git.u.kleine-koenig@baylibre.com
    Patches: [v2,05/13] spi: fsi: Drop assigning fsi bus
             [v2,13/13] spi: fsi: Convert to fsi bus probe mechanism

Series: spi: st: add power-domains on stm32mp2x
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1033229
  Lore link: https://lore.kernel.org/r/20251215-stm32-spi-mp2x-dt-updates-v1-0-464a5fd20f13@foss.st.com
    Patches: [1/3] dt-bindings: spi: st,stm32-spi: add 'power-domains' property
             [2/3] arm64: dts: st: add power-domains in all spi of stm32mp251.dtsi
             [3/3] arm64: dts: st: add power-domains in all spi of stm32mp231.dtsi

Series: arm64: allwinner: a523: Support SPI controllers
  Submitter: Chen-Yu Tsai <wens@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1035470
  Lore link: https://lore.kernel.org/r/20251221110513.1850535-1-wens@kernel.org
    Patches: [1/4] spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
             [3/4] arm64: dts: allwinner: sun55i: Add SPI controllers
             [4/4] arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR flash


Total patches: 59

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


