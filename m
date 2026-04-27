Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435B41F91D6
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249684; cv=none; b=Q0440YvGqsBNAp3k9aUgl72Eb6b8YPogJy9u5t7jK/TZ4eeOM1hhYFK8VQyvJZobOXr3iEGNURj5CMdpHq/FaLexPuK5svZtM01ZptufcCNEUDi/ZS0j5haBkx3argM9BmgroCWiXDDaE3he6LE9WPI7JSdcCBb0o08Vkvib1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249684; c=relaxed/simple;
	bh=jjjFES5h8gdRqs8uMgLWSjft70bwKbgp9cCnCHUI8v8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lEw5C56G+w8NGqAToyE7CWyDoPI/rsRLjVzdXpKExVWtWFkHx+g81EEx5eZlZux0e2UQD4TPq2BNgH9L2HplVeTOZM9IfPtMyahAgXr7xNg9UzP3dzULqQe9ptXcCezngmVOcmywIwaRVc79IP9a5r/PG9Ss/79Lq/o4LIjyUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr/y4PHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr/y4PHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC7DC2BCAF;
	Mon, 27 Apr 2026 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777249683;
	bh=jjjFES5h8gdRqs8uMgLWSjft70bwKbgp9cCnCHUI8v8=;
	h=Subject:From:Date:To:From;
	b=sr/y4PHuVnXhY9Mr8okdcLNZEg7hsKHpeKgej6h0+k7edBkGxeFwub5PrxaKXzcwi
	 7YLF1SOpiUchVrnCkXHDINbLRXx3dwPmwFDCxxTHqxvqyn8HReTazDaIPq2c2La5k8
	 WKUq5NwpF8WD3YSpG2V4ak1Qg7Sf3pDEOYyywCkOyhfze3cSXpgdqyADUaGyR6JAuw
	 hXfI9jnFd8Bit7+xnncu9Oxtt/gnMJk+SXUI5jq47Y7p3RSKEs9xskvI0Av8BYFJ1R
	 QJwX+5CkEHTh1ARRbfhIT/zEnE5qIEXnmDjZvSyHjOaM6EStXUmwhxZpCb2KFmOhe3
	 fHwRX+9YRxWCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 427A738119E5;
	Mon, 27 Apr 2026 00:27:23 +0000 (UTC)
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
 <177724964178.2839245.4467448694414783027.git-patchwork-summary@kernel.org>
Date: Mon, 27 Apr 2026 00:27:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [GIT,PULL] SPI fixes for v7.1-merge-window
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1085243
  Lore link: https://lore.kernel.org/r/b1a629e07ae2ecbbd869f15441a95e06@kernel.org

Patch: [GIT,PULL] SPI updates for v7.1
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1080798
  Lore link: https://lore.kernel.org/r/5dc2e23847a30ccbc6e1f4a494412157@kernel.org

Series: Add support for Microchip LAN969x
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Committer: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1059939
  Lore link: https://lore.kernel.org/r/20260302112153.464422-1-robert.marko@sartura.hr
    Patches: [v6,1/6] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
             [v6,2/6] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
             [v6,3/6] arm64: dts: microchip: add LAN969x clock header file
             [v6,4/6] arm64: dts: microchip: add LAN969x support
             [v6,5/6] dt-bindings: arm: AT91: document EV23X71A board
             [v6,6/6] arm64: dts: microchip: add EV23X71A board

Series: treewide: Convert buses to use generic driver_override
  Submitter: Danilo Krummrich <dakr@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1071294
  Lore link: https://lore.kernel.org/r/20260324005919.2408620-1-dakr@kernel.org
    Patches: [01/12] amba: use generic driver_override infrastructure
             [02/12] bus: fsl-mc: use generic driver_override infrastructure
             [05/12] PCI: use generic driver_override infrastructure
             [06/12] platform/wmi: use generic driver_override infrastructure
             [08/12] vdpa: use generic driver_override infrastructure
             [09/12] s390/cio: use generic driver_override infrastructure
             [10/12] s390/ap: use generic driver_override infrastructure

Patch: spi: mpc52xx: clean up interrupt handling
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1084562
  Lore link: https://lore.kernel.org/r/20260423075801.2252318-1-johan@kernel.org

Patch: lib: count_zeros: fix 32/64-bit inconsistency in count_trailing_zeros()
  Submitter: Yury Norov <ynorov@nvidia.com>
  Committer: Yury Norov <ynorov@nvidia.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1065971
  Lore link: https://lore.kernel.org/r/20260312230817.372878-1-ynorov@nvidia.com

Series: spi: rockchip: ISR fix and minor cleanups
  Submitter: John Madieu <john.madieu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1085461
  Lore link: https://lore.kernel.org/r/20260425092936.2590132-1-john.madieu@gmail.com
    Patches: [1/3] spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
             [2/3] spi: rockchip: Drop unused and broken CR0 macros

Series: Remove class_find_device_by_of_node in favor of finding by firmware node
  Submitter: Dmitry Torokhov <dmitry.torokhov@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070598
  Lore link: https://lore.kernel.org/r/20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com
    Patches: [net-next,01/10] net: wan: framer: switch to using class_find_device_by_fwnode()
             [05/10] leds: led-class: switch to using class_find_device_by_fwnode()

Patch: [v2] device property: Make modifications of fwnode "flags" thread safe
  Submitter: Doug Anderson <dianders@chromium.org>
  Committer: Danilo Krummrich <dakr@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1068110
  Lore link: https://lore.kernel.org/r/20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid

Series: tracepoint: Avoid double static_branch evaluation at guarded call sites
  Submitter: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
  Committer: Steven Rostedt (Google) <rostedt@goodmis.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1071027
  Lore link: https://lore.kernel.org/r/20260323160052.17528-1-vineeth@bitbyteword.org
    Patches: [v2,01/19] tracepoint: Add trace_call__##name() API
             [v2,13/19] spi: Use trace_call__##name() at guarded tracepoint call sites

Series: Add DMA support for RZ/T2H RSPI
  Submitter: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1048273
  Lore link: https://lore.kernel.org/r/20260128215132.1353381-1-cosmin-gabriel.tanislav.xa@renesas.com
    Patches: [v3,1/3] dt-bindings: spi: renesas,rzv2h-rspi: allow multiple DMAs
             [v3,2/3] arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
             [v3,3/3] arm64: dts: renesas: r9a09g087: wire up DMA support for SPI

Series: arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
  Submitter: Chen-Yu Tsai <wens@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1060109
  Lore link: https://lore.kernel.org/r/20260302153559.3199783-1-wens@kernel.org
    Patches: [v2,1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
             [v2,2/3] arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ pins
             [v2,3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND

Series: spi: cadence-qspi: Add Renesas RZ/N1 support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1051278
  Lore link: https://lore.kernel.org/r/20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com
    Patches: [v5,1/4] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
             [v5,4/4] ARM: dts: r9a06g032: Describe the QSPI controller

Series: Add RSPIs support for RZ/G3E SoC
  Submitter: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
  Committer: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1054931
  Lore link: https://lore.kernel.org/r/cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com
    Patches: [1/5] clk: renesas: r9a09g047: Add entries for the RSPIs
             [4/5] arm64: dts: renesas: r9a09g047: Add RSPI nodes
             [5/5] arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0

Patch: spi: rzv2h-rspi: Fix silent failure in clock setup error path
  Submitter: John Madieu <john.madieu.xa@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1085408
  Lore link: https://lore.kernel.org/r/20260425024725.2393632-1-john.madieu.xa@bp.renesas.com

Series: lan966x pci device: Add support for SFPs
  Submitter: Herve Codina <herve.codina@bootlin.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1072358
  Lore link: https://lore.kernel.org/r/20260325143555.451852-1-herve.codina@bootlin.com
    Patches: [v6,01/27] Revert "treewide: Fix probing of devices in DT overlays"
             [v6,17/27] of: property: Allow fw_devlink device-tree on x86


Total patches: 38

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


