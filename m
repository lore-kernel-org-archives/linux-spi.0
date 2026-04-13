Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78342BEFEF;
	Mon, 13 Apr 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096563; cv=none; b=RvsDKbE5hok8Vr+snaKjbOl0BbbHfpSCIEeoxcv3/CanuURH2ML1em8QhsTq3I2sQGjtSQWcHGtcQMR3k9oAnErZrWp4yWcjsaDXefG6wpMl0SQq2l7iB0KjvxlmnwwJu4XPcm9X7w1M75JNUd/oB/iAdm+bC8YyPv5/nlojtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096563; c=relaxed/simple;
	bh=KdvOILNYUYYBFPv75Wrq3RT/z+ts/6JNS4FbSs29QDU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=h1QVyiT1+UnDbOwplpvB/bGmiogcfmLA0Ul8f6W4L3lmIHYjJeXvw083erCob3ENWxn16foHUWNV4+gfzkOfg89zYOibtVCVpUR3QpSYeEGENxaUeOftl4rdrRydJazleYxgMruw2v0bTpqpl+92k3RDKgOR6xgzPTMRpDjrglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uICeXivp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uICeXivp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E75DC2BCAF;
	Mon, 13 Apr 2026 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776096562;
	bh=KdvOILNYUYYBFPv75Wrq3RT/z+ts/6JNS4FbSs29QDU=;
	h=From:To:Cc:Subject:Date:From;
	b=uICeXivpIPlVWkWOyVcOygxWVuO1KU1eHdYoFwJSgVwf/EDYry23ctLcvVBrehSee
	 259zJXyZ1j0UnBr4nI75no3RLEseozWL/dTi1VpJTPNsXDfRYPhFIJsNGWiPliYZsj
	 x1AX+EFPuwXSYQV5rmGpip/AzTodmMB6Xrrt2vVJ3OUVTwEnzYmMbGFnMqyAsNsh86
	 a76BiHUcG3P2RUBUuDpUO4z5F5RqL/zQcGhpzmOGylIXu1xdZalQ6iDDE6jMw91Arn
	 zmm7GTXeFuplyWbMkn3WbeTlelbR2Dw+R7pc4ywW+4F1kqemN55pZcsoPTBvHAKvzw
	 0sHtW2NRb2WZg==
Message-ID: <5dc2e23847a30ccbc6e1f4a494412157@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v7.1
Date: Mon, 13 Apr 2026 17:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 705355a82b8ea86e0afe44560e970eedc74c05d3:

  MAINTAINERS: Update AMD SPI driver maintainers (2026-04-07 17:45:37 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.1

for you to fetch changes up to c4c3fc872d2a05bf10372233c98e81344e685cdf:

  spi: sn-f-ospi: fix incorrect return code for invalid num-cs (2026-04-11 12:58:16 +0100)

----------------------------------------------------------------
spi: Updates for v7.1

A busy release for SPI, almost all of it in a couple of larger fix and
cleanup serieses for patterns that affected many drivers.  We do have
a couple of core API additions as well, relatively application specific
but they enable some new use cases.

 - A packed command operation for spi-mem devices.
 - Improvements to the ancillary device support to enable some IIO use
   cases from Antoniu Miclaus.
 - Fixes for a registration ordering issue pattern caused by the
   handover between allocation and registration of controllers in
   concert with devm from Johan Hovold.
 - Improvements to handling of clock allocation from Pei Xiao.
 - Cleanups in the fsl-lpspi driver from Marc Kleine-Budde.
 - Support for Renesas RZ/G3E and RZ/G3L.

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: fix rx DMA request error handling

Andy Shevchenko (2):
      spi: pxa2xx: use min() instead of min_t()
      spi: Replace open coded variant of spi_bpw_to_bytes()

Antoni Pokusinski (1):
      spi: omap2-mcspi: add support for 3-wire transfers

Antoniu Miclaus (2):
      spi: allow ancillary devices to share parent's chip selects
      spi: add devm_spi_new_ancillary_device()

Biju Das (2):
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
      spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

Breno Leitao (1):
      spi: tegra210-quad: Fix false positive WARN on interrupt timeout with transfer complete

Charles Keepax (1):
      spi: cs42l43: Don't support sidecar properties on device tree systems

Conor Dooley (2):
      spi: dt-bindings: mpfs-spi: permit resets
      spi: dt-bindings: mpfs-spi: remove clock-names

Cosmin Tanislav (1):
      spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs

Felix Gu (7):
      spi: nxp-xspi: Use reinit_completion() for repeated operations
      spi: nxp-fspi: Use reinit_completion() for repeated operations
      spi: fsl-qspi: Use reinit_completion() for repeated operations
      spi: axiado: Remove redundant pm_runtime_mark_last_busy() call
      spi: tegra210-quad: Remove redundant pm_runtime_mark_last_busy() calls
      spi: amlogic-spisg: Use IS_ERR() instead of IS_ERR_OR_NULL()
      spi: sn-f-ospi: fix incorrect return code for invalid num-cs

Johan Hovold (60):
      spi: drop unused devres statistics allocation
      spi: fix misleading controller registration kernel-doc
      spi: fix misleading controller deregistration kernel-doc
      spi: imx: fix use-after-free on unbind
      spi: rockchip: fix controller deregistration
      spi: imx: switch to managed controller allocation
      spi: tegra20-slink: switch to managed controller allocation
      spi: rockchip: switch to managed controller allocation
      spi: ch341: fix memory leaks on probe failures
      spi: ch341: fix devres lifetime
      spi: pl022: enable compile testing
      spi: atcspi200: enable compile testing
      spi: npcm-fiu: drop unused remove callback
      spi: amlogic-spisg: fix controller deregistration
      spi: aspeed-smc: fix controller deregistration
      spi: at91-usart: fix controller deregistration
      spi: atmel: fix controller deregistration
      spi: bcm63xx: fix controller deregistration
      spi: bcm63xx-hsspi: fix controller deregistration
      spi: bcmbca-hsspi: fix controller deregistration
      spi: octeon: fix controller deregistration
      spi: cavium-thunderx: fix controller deregistration
      spi: coldfire-qspi: fix controller deregistration
      spi: dln2: fix controller deregistration
      spi: ep93xx: fix controller deregistration
      spi: fsl-espi: fix controller deregistration
      spi: img-spfi: fix controller deregistration
      spi: lantiq-ssc: fix controller deregistration
      spi: meson-spicc: fix controller deregistration
      spi: microchip-core-qspi: fix controller deregistration
      spi: microchip-core-spi: fix controller deregistration
      spi: mpfs: fix controller deregistration
      spi: fsl: fix controller deregistration
      spi: mt65xx: fix controller deregistration
      spi: mtk-nor: fix controller deregistration
      spi: mxs: fix controller deregistration
      spi: npcm-pspi: fix controller deregistration
      spi: omap2-mcspi: fix controller deregistration
      spi: pic32: fix controller deregistration
      spi: pic32-sqi: fix controller deregistration
      spi: pl022: fix controller deregistration
      spi: qup: fix controller deregistration
      spi: rspi: fix controller deregistration
      spi: s3c64xx: fix controller deregistration
      spi: sh-hspi: fix controller deregistration
      spi: sh-msiof: fix controller deregistration
      spi: sifive: fix controller deregistration
      spi: slave-mt27xx: fix controller deregistration
      spi: sprd: fix controller deregistration
      spi: st-ssc4: fix controller deregistration
      spi: sun4i: fix controller deregistration
      spi: sun6i: fix controller deregistration
      spi: syncuacer: fix controller deregistration
      spi: tegra114: fix controller deregistration
      spi: tegra20-sflash: fix controller deregistration
      spi: ti-qspi: fix controller deregistration
      spi: uniphier: fix controller deregistration
      spi: zynqmp-gqspi: fix controller deregistration
      spi: zynq-qspi: fix controller deregistration
      spi: s3c64xx: fix NULL-deref on driver unbind

Kexin Sun (2):
      spi: pl022: update outdated references to pump_transfers()
      spi: pxa2xx: update outdated reference to pump_transfers()

Krzysztof Kozlowski (1):
      spi: stm32: Use NULL instead of 0 for pointer

Lad Prabhakar (3):
      spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
      spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
      spi: rzv2h-rspi: Simplify clock rate search function signatures

Marc Kleine-Budde (10):
      spi: spi-fsl-lpspi: adapt to kernel coding style
      spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control register
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from struct fsl_lpspi_data::config::mode
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): remove obfuscated and obsolete assignment of TCR_CPOL and SPI_CPHA
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
      spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
      spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
      spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void function
      spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
      spi: spi-fsl-lpspi: make struct lpspi_config::mode u32

Mark Brown (9):
      spi: add devm_spi_new_ancillary_device()
      spi: Merge up v7.0-rc2
      spi: controller registration fixes
      spi: hisi-kunpeng cleanup and fix
      spi: Use after free fixes
      Add Renesas RZ/G3L RSPI support
      spi: Merge up fixes
      spi: rzv2h-rspi: Fix max_speed_hz and clock configuration issues
      spi: fix controller deregistration (part 2/2)

Miquel Raynal (2):
      spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
      spi: spi-mem: Add a packed command operation

Patrice Chotard (1):
      spi: stm32-ospi: Remove exec_op() callback debug log

Pei Xiao (12):
      spi: atcspi200: Remove redundant assignment to .owner
      spi: atcspi200: Use helper function devm_clk_get_enabled()
      spi: atcspi200: fix mutex initialization order
      spi: bcm63xx-hsspi: Simplify clock handling with devm_clk_get_enabled()
      spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
      spi: sifive: Simplify clock handling with devm_clk_get_enabled()
      spi: stm32: Simplify clock handling with devm_clk_get_enabled()
      spi: sunplus-sp7021: Simplify clock handling with devm_clk_get_enabled()
      spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
      spi: hisi-kunpeng: Add timeout warning in FIFO flush function
      spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
      spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback

Randy Dunlap (1):
      spi: spi-mem: clean up kernel-doc in spi-mem.h

Tommaso Merciai (2):
      spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
      spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support

Vishwaroop A (1):
      spi: tegra210-quad: Add runtime autosuspend support

 .../bindings/spi/microchip,mpfs-spi.yaml           |   4 +-
 .../bindings/spi/renesas,rzv2h-rspi.yaml           |  52 +++++++++-
 drivers/spi/Kconfig                                |   4 +-
 drivers/spi/spi-amlogic-spisg.c                    |  10 +-
 drivers/spi/spi-aspeed-smc.c                       |   9 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-atcspi200.c                        |  29 ++----
 drivers/spi/spi-atmel.c                            |   8 +-
 drivers/spi/spi-axiado.c                           |   1 -
 drivers/spi/spi-bcm63xx-hsspi.c                    |  54 ++++------
 drivers/spi/spi-bcm63xx.c                          |   8 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |  53 ++++------
 drivers/spi/spi-cadence-quadspi.c                  |   4 -
 drivers/spi/spi-cavium-octeon.c                    |   8 +-
 drivers/spi/spi-cavium-thunderx.c                  |   8 +-
 drivers/spi/spi-ch341.c                            |  43 +++++---
 drivers/spi/spi-coldfire-qspi.c                    |  10 +-
 drivers/spi/spi-cs42l43.c                          |   4 +-
 drivers/spi/spi-dln2.c                             |   8 +-
 drivers/spi/spi-ep93xx.c                           |   8 +-
 drivers/spi/spi-fsl-espi.c                         |  10 +-
 drivers/spi/spi-fsl-lpspi.c                        |  68 ++++++-------
 drivers/spi/spi-fsl-qspi.c                         |   3 +-
 drivers/spi/spi-fsl-spi.c                          |  14 ++-
 drivers/spi/spi-hisi-kunpeng.c                     |  17 +++-
 drivers/spi/spi-img-spfi.c                         |   8 +-
 drivers/spi/spi-imx.c                              |  41 +++-----
 drivers/spi/spi-lantiq-ssc.c                       |   8 +-
 drivers/spi/spi-meson-spicc.c                      |   8 +-
 drivers/spi/spi-microchip-core-qspi.c              |  12 ++-
 drivers/spi/spi-microchip-core-spi.c               |   4 +-
 drivers/spi/spi-mpfs.c                             |   4 +-
 drivers/spi/spi-mt65xx.c                           |   4 +-
 drivers/spi/spi-mtk-nor.c                          |   4 +-
 drivers/spi/spi-mtk-snfi.c                         |  14 +++
 drivers/spi/spi-mxs.c                              |   8 +-
 drivers/spi/spi-npcm-fiu.c                         |   8 --
 drivers/spi/spi-npcm-pspi.c                        |   8 +-
 drivers/spi/spi-nxp-fspi.c                         |   3 +-
 drivers/spi/spi-nxp-xspi.c                         |   3 +-
 drivers/spi/spi-omap2-mcspi.c                      |  25 +++--
 drivers/spi/spi-pic32-sqi.c                        |   8 +-
 drivers/spi/spi-pic32.c                            |  11 +-
 drivers/spi/spi-pl022.c                            |  18 ++--
 drivers/spi/spi-pxa2xx-dma.c                       |   6 +-
 drivers/spi/spi-pxa2xx.c                           |  11 +-
 drivers/spi/spi-qup.c                              |   8 +-
 drivers/spi/spi-rockchip.c                         |  40 +++-----
 drivers/spi/spi-rspi.c                             |  10 +-
 drivers/spi/spi-rzv2h-rspi.c                       |  60 ++++++-----
 drivers/spi/spi-s3c64xx.c                          |   9 +-
 drivers/spi/spi-sh-hspi.c                          |  10 +-
 drivers/spi/spi-sh-msiof.c                         |  10 +-
 drivers/spi/spi-sifive.c                           |  29 +++---
 drivers/spi/spi-slave-mt27xx.c                     |  10 +-
 drivers/spi/spi-sn-f-ospi.c                        |   2 +-
 drivers/spi/spi-sprd.c                             |   8 +-
 drivers/spi/spi-st-ssc4.c                          |   8 +-
 drivers/spi/spi-stm32-ospi.c                       |   5 -
 drivers/spi/spi-stm32.c                            |  72 ++++---------
 drivers/spi/spi-sun4i.c                            |  10 +-
 drivers/spi/spi-sun6i.c                            |   8 +-
 drivers/spi/spi-sunplus-sp7021.c                   |  15 +--
 drivers/spi/spi-synquacer.c                        |   8 +-
 drivers/spi/spi-tegra114.c                         |   8 +-
 drivers/spi/spi-tegra20-sflash.c                   |   8 +-
 drivers/spi/spi-tegra20-slink.c                    |  26 ++---
 drivers/spi/spi-tegra210-quad.c                    |  22 +++-
 drivers/spi/spi-ti-qspi.c                          |  14 ++-
 drivers/spi/spi-uniphier.c                         |  24 ++---
 drivers/spi/spi-zynq-qspi.c                        |  15 ++-
 drivers/spi/spi-zynqmp-gqspi.c                     |   4 +-
 drivers/spi/spi.c                                  | 113 +++++++++++++++------
 include/linux/spi/spi-mem.h                        |  16 ++-
 include/linux/spi/spi.h                            |   1 +
 75 files changed, 741 insertions(+), 493 deletions(-)
