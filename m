Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580685;
	b=X/neRbwSUbH33WvTr+QUFtouym/0vKeJNOeXt4jd5tnPePzYH92IAKUy+iKs02QYoGbc
	 i63932ChSjvyWM5w0LhFDtSKrdEjxAILpWs908VIrffiFhsjHVPL+WDYYKD1NEx0BQJNH
	 70OxZ9dVxci8wwFh6LpV/yCgDUvZwyxWTFFWhS0CFeltnpeytGoATbhTKHMAgY2cB366Z
	 K7Cs4g3DajvQWhsNahCZTKZnAZ/VD2h3dQJnG4M5u/cSEwsH3l+vVbQHVW9gb+SGqCoSh
	 o+zzyrm9EeG7QD7ij83l9SnrzpTO8DdQxvJz6bu11X6ZgQYAjHvo+q1Ih40N+p5cmGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580685;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id;
	bh=KEyWZpn7GCxKyFe1cxVvA+i6hof6XrBCfCM5wK05RnI=;
	b=JjwR0WSQBQwCT0oMpWdhvDkkrQ7iFXVb2FoPId83DyOJZmK99br6r7sTTlH1PuycWtZY
	 wihVM1djBLmy7Ds8McP6v5HiSYxEU1t7pZ+YNA8aSq3vA8VbnRLUKwtd4T406QDKRuuXh
	 jW6uo42QEoRLKo13fb3lRyT74aRbYGiozPDxTkPzuMdxeuMYY/yE7AKZuB3mn8P4bRlSk
	 E0DkRgEefz5yMg80B+V5BuJvQCIb0Qg+mw8902fM91vpamtZj5cf1ITDqmJRsZE0Ce8Uw
	 xG6oblw1BO6VJCFzTSeOI4Cxg8EWd1cVITXe18W/EKoA4Kn6A8RVdv7fFa/o00IOXhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0vDXS2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FB606A319;
	Wed, 21 Oct 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0vDXS2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8744E1F000C9;
	Wed, 21 Oct 2026 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580684;
	bh=KEyWZpn7GCxKyFe1cxVvA+i6hof6XrBCfCM5wK05RnI=;
	h=From:To:Cc:Subject:Date;
	b=a0vDXS2z+3BJvzseCZvWZS178zabUBM12dt9uZuAT8c9vzQIB8l42/FHR/0F5fn7C
	 WEVAHD7CvrrdppVW4/cklsU45lSCPyImvhMHsJluSZcHj/O+QvI+2pmSpPAgxQRmi2
	 LF36C62+IAwEWnbt2T84EhD/A0UhrdzDnoUkCuhPEBbMzH6ZgvLS+1PyQiTyzPXROl
	 az5RGUNxLVNap7yin28pegCZbzZrK4b6CnZzk//FR5z9wyQezu6IYpZ/y+b+OU+HdD
	 16XdklW3JJ76JwrMoPsn26l0+YQCcDP2dM6qDwmoJl9jBt6RRw0Qwv0qxRE+0U7bYp
	 WL2ha5F3VDpDw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 5E5C91AC5994; Wed, 21 Oct 2026 12:04:41 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v7.4
Date: Wed, 21 Oct 2026 12:03:53 +0100
Message-Id: <20261021110441.5E5C91AC5994@finisterre.sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The following changes since commit b0f0c761ed3fa10754dc9295db85374a173123b7:

  spi: spi-fsl-lpspi: directly return ret in fsl_lpspi_transfer_one() (2026-10-15 22:37:15 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.4

for you to fetch changes up to d5acef12e819c1627c8bf6a0325845ab39d8c99d:

  spi: Merge up fixes (2026-10-19 18:00:23 +0100)

----------------------------------------------------------------
spi: Updates for v7.4

Quite a lot of work in the SPI subsystem this time around, almost all in
drivers rather than the core.  As well as the general cleanup/fix work
we're seeing over most of the kernel there's been some substantial
performance work to two existing drivers and support for a number of new
devices including a couple of new drivers.  There was also a big
overhaul of the spidev_test utility from the Pengutronix people.

 - Improvements for spidev_test to cover additional use cases, plus be a
   bit easier to use.
 - Substantial performance work in both DesignWare and Tegra210 QSPI
   drivers, making their interrupt handling more efficient to drive up
   hardware utilisation.
 - Documentation clarifications.
 - Fixes for some runtime PM and error handling issues.
 - Support for Nuvoton MA35D1, Qualcomm QPIC SNAND v2, Renesas R-Car
   Gen5 and X5H and Realtek RTD1625.

Some of these updates are also present in my ASoC pull request to
Takashi, b4's base selection logic picked a SPI commit for an ASoC
branch and I didn't notice until far too late after I'd already merged
the ASoC branch and stacked further work on it.

----------------------------------------------------------------
Aayush Kumar (12):
      spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
      spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()
      spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
      spi: omap2-mcspi: Use snprintf() instead of sprintf()
      spi: s3c64xx: Use snprintf() instead of sprintf()
      spi: sh-hspi: Use devm_platform_ioremap_resource()
      spi: jcore: Use devm_platform_ioremap_resource()
      spi: butterfly: Use strscpy() instead of strcpy()
      spi: lm70llp: Use strscpy() instead of strcpy()
      spi: tle62x0: Use kstrtoul() instead of simple_strtoul()
      spi: omap2-mcspi: Use snprintf() instead of sprintf()
      spi: s3c64xx: Use snprintf() instead of sprintf()

Abraham Zukor (1):
      spi: tegra114: initialize native chip selects inactive

Alban Bedel (1):
      spi: Fix ACPI SPI resources using relative path

Andrew Gaylard (1):
      spi: sunplus: handle signal interruption in transfer wait

Andy Shevchenko (3):
      spi: Fix tab and space mixture in Kconfig
      spi: Drop redundant dependency on SPI_MASTER
      spi: Fix the section ordering in accordance with the comment

Bhargav Joshi (1):
      spi: dt-bindings: ti,davinci-spi: Convert to DT schema

Changhuang Liang (4):
      spi: dw: Convert the Tx done delay from SCK cycles to time
      spi: dw: Support DMA with a single channel
      spi: dw: Add DMA support for enhanced memory operations
      spi: dw: Unconditionally stop DMA on errors

Chi-Wen Weng (4):
      spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1 SPI controller
      spi: ma35d1: Add Nuvoton MA35D1 SPI controller support
      spi: ma35d1-qspi: Add GPIO chip select support
      spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant SPI example

Felix Gu (5):
      spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
      spi: ingenic: release tx DMA channel when rx request fails
      spi: mtk-nor: fix runtime PM usage count leak in probe error path
      spi: ar934x: Convert to devm_spi_register_controller()
      spi: mxic: fix ps_clk leak in runtime resume

Francesco Valla (3):
      spi: virtio: drop duplicate completion init
      spi: virtio: fix max frequency setting
      spi: virtio: drop unused field from private data

Frank Li (4):
      spi: ingenic: remove dmaengine_desc_free()
      spi: use dmaengine public API instead of raw ops
      spi: use dmaengine_get_dma_device() instead of chan->device->dev
      spi: use dmaengine_submit() instead of ->tx_submit()

Frieder Schrempf (3):
      spi: dt-bindings: Clarify what rx-sample-delay-ns describes
      spi: Parse the rx-sample-delay-ns peripheral property in the core
      spi: dw: Use the rx-sample-delay-ns value parsed by the core

Gabor Juhos (8):
      spi: spi-qpic-snand: remove interim 'dev_data' variable from qcom_spi_probe()
      spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'
      spi: spi-qpic-snand: add qcom_spi_config_page_read() helper
      spi: spi-qpic-snand: drop ecceng_to_qspi() macro
      spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()
      spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of struct 'qpic_ecc'
      spi: spi-qpic-snand: set 'qpic_version2' flag
      spi: spi-qpic-snand: skip BBM copy on regular raw reads

Geert Uytterhoeven (1):
      spi: sh-msiof: Add support for R-Car Gen5

Guangshuo Li (2):
      spi: fsl: unmap immr_spi_cs on remove
      spi: bcm63xx-hsspi: Disable runtime PM on remove

Han Gao (2):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits

Hemanth Selam (1):
      spi: fix typos in comments

Hongjian Dai (1):
      spi: meson-spicc: fix invalid DMA unmap on mapping failure

Jesse Jeronimus (1):
      Documentation: devres: Remove non-existent SPI register helpers

Jiawen Liu (1):
      spi: rockchip-sfc: disable runtime PM in remove

Jisheng Zhang (6):
      spi: dw: use DW_SPI_ISR directly
      spi: dw: Make dw_spi_update_config()
      spi: dw: remove useless dws->transfer_handler check
      spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
      spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
      spi: dw: use threaded interrupt and optimize the threaded ISR

Johan Alvarado (2):
      spi: spi-qpic-snand: publish the ECC context to snandc->qspi
      spi: spi-qpic-snand: drop the redundant ECC context handling

Jonas Jelonek (1):
      spi: realtek-rtl: add support for second CS

Jonas Rebmann (9):
      spi: spidev_test: include tools/include
      spi: spidev_test: clarify usage for --size
      spi: spidev_test: make size argument mandatory for --size
      spi: spidev_test: allow zero-length transfers
      spi: spidev_test: abort when -I is selected without -S
      spi: spidev_test: always compare loopback data
      spi: spidev_test: send predictable data
      spi: spidev_test: rewrite unescape() to stay in bounds
      spi: spi-sun4i: sun4i_spi_transfer_one(): add error handling at clock setup

Jonathan Santos (2):
      spi: axi-spi-engine: fix stale SYNC IRQ pending
      spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

Jyan Chou (2):
      spi: dt-bindings: Add Realtek RTD1625 SPI NOR support
      spi: spi-mem: Add Realtek SPI NOR flash controller driver

Karl Mehltretter (3):
      spi: docs: Use the multi-lane mode constants in examples
      spi: Fix the return value in spi_new_ancillary_device() kernel-doc
      spi: atmel-quadspi: balance runtime PM and pclk across system sleep

Kathiravan Thirumoorthy (1):
      spi: dt-bindings: spi-qpic-snand: Add IPQ9650 compatible

Li Youhong (2):
      spi: ma35d1-qspi: assert reset on probe error paths
      spi: amlogic-spisg: check clk_prepare_enable() return value

Lucas Costa (1):
      spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Marc Kleine-Budde (10):
      spi: spidev_test: add compare mode
      spi: spidev_test: allow disabling rx or tx buffers
      spi: spidev_test: don't send 0x0 or 0xff
      spi: spidev_test: add option to split message into multiple transfers
      spi: spidev_test: print TX on error
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
      spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
      spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
      spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
      spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

Mark Brown (23):
      spi: Kconfig cleanups
      spi: qcom-geni: Add shutdown and panic notifier support
      spi: add support for Amlogic A9
      spi: ma35d1-qspi: Flag the DTR capability correctly
      spi: tegra210-quad: Improve interrupt handling for loaded systems
      spi: virtio: fix max frequency setting plus minor cleanup
      spi: spi-qpic-snand: fix the stale ECC context pointer
      spi: Better specification for rx-sample-delay-ns and core parsing
      spi: sh-msiof: Add support for R-Car X5H
      spi: spidev_test: new features
      spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
      Add enhance SPI DMA support for JHB100 SFC
      spi: Add Nuvoton MA35D1 SPI controller support
      spi: qcom-geni: Use GPIO to notify master of SPI target activity
      spi: spi-sun4i: assorted fixes
      spi: use sysfs_emit() in bcm63xx-hsspi and bcmbca-hsspi
      spi: use kstrtoul() and snprintf()
      spi: dw: use threaded interrupt
      spi: axi-spi-engine: fix stale SYNC IRQ pending
      spi: use devm_platform_ioremap_resource() in sh-hspi and jcore
      spi: replace strcpy(), sprintf() and simple_strtoul() with strscpy(), snprintf() and kstrtoul()
      spi: cadence-xspi: two memory-safety fixes in the slave-DMA paths
      spi: Merge up fixes

Miquel Raynal (3):
      spi: spi-mem: Enable DTR transfers using the standard API
      spi: ma35d1-qspi: Allow DTR operations with the regular SPI API
      spi: cadence-qspi: Prevent SPI NAND continuous reads

Myeonghun Pak (1):
      spi: rockchip-sfc: skip DMA cleanup in PIO mode

Ovidiu Panait (1):
      spi: rspi: Fix DMA mode when the DMA controller is built as a module

Peng Fan (1):
      spi: use dmaengine_get_dma_device() for DMA mapping

Pengpeng Hou (1):
      spi: sh-msiof: propagate setup runtime-PM errors

Pin-Hao Chen (1):
      spi: stm32: fix double free of SRAM buffer on MDMA fallback

Praveen Talari (4):
      spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic
      spi: dt-bindings: Document ready-gpios property
      spi: qcom-geni: Use GPIO to notify master of SPI target activity

Randy Dunlap (1):
      spi: spi-master: use literal blocks for commands

Rosen Penev (1):
      spi: orion: yield to scheduler in transfer wait loop

Saad Anjum (1):
      spi: bitbang: Drop duplicated word in file header comment

Sahaj Chaudhari (1):
      spi: omap2-mcspi: handle DMA setup failures

Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Thanh Quan (1):
      spi: dt-bindings: renesas,sh-msiof: Add support for R-Car X5H

Udaya Kiran Challa (1):
      spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema

Viken Dadhaniya (1):
      spi: qcom-geni: rename setup_fifo_params() to setup_spi_params() and make it void

Vishwaroop A (3):
      spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
      spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
      spi: tegra210-quad: Process small PIO transfers in hard IRQ context

Weibin Liu (9):
      spi: ljca: validate the response length before copying the data
      spi: cadence-xspi: reject SDMA transfers larger than the requested length
      spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path
      spi: jcore: fix divide-by-zero when speed_hz is zero
      spi: npcm-fiu: limit UMA data_size to the 16-byte staging buffer
      spi: bcm-qspi: reject oversized dummy bytes in mspi exec_mem_op
      spi: amd: fix len==0 underflow and FIFO overflow
      spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
      spi: ch341: handle transfers without a TX or RX buffer

Xianwei Zhao (4):
      spi: dt-bindings: amlogic: spisg: Document A9-specific properties
      spi: amlogic: spisg: Fix transfer size limit and timeout handling
      spi: amlogic: spisg: Add support for A9 controller features
      spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible

Yu-Chun Lin (1):
      spi: rtk-nor: Fix incorrect boolean return value

Ziyang Huang (1):
      spi: spi-qpic-snand: reject when no enough OOB space

 Documentation/ABI/testing/sysfs-class-spi-master   |   6 +-
 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  30 +-
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  13 +-
 .../bindings/spi/microchip,pic32mzda-spi.yaml      |  82 +++
 .../bindings/spi/microchip,spi-pic32.txt           |  34 -
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml          |  21 +-
 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        |   9 +
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |   9 +
 .../bindings/spi/qcom,spi-qpic-snand.yaml          |   1 +
 .../bindings/spi/realtek,rtd1625-nor.yaml          |  65 ++
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |   9 +-
 .../devicetree/bindings/spi/spi-davinci.txt        | 100 ---
 .../bindings/spi/spi-peripheral-props.yaml         |   9 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 125 ++++
 Documentation/driver-api/driver-model/devres.rst   |   2 -
 Documentation/spi/multiple-data-lanes.rst          |  10 +-
 MAINTAINERS                                        |   6 +
 drivers/spi/Kconfig                                | 379 +++++------
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        |  26 +-
 drivers/spi/spi-amd.c                              |  17 +
 drivers/spi/spi-amlogic-spisg.c                    | 116 +++-
 drivers/spi/spi-ar934x.c                           |  13 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-atmel.c                            |   8 +-
 drivers/spi/spi-axi-spi-engine.c                   |  20 +-
 drivers/spi/spi-bcm-qspi.c                         |   3 +-
 drivers/spi/spi-bcm2835.c                          |  29 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   5 +-
 drivers/spi/spi-bcm63xx.c                          |   2 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |   2 +-
 drivers/spi/spi-bitbang.c                          |   2 +-
 drivers/spi/spi-butterfly.c                        |   3 +-
 drivers/spi/spi-cadence-quadspi.c                  |  12 +-
 drivers/spi/spi-cadence-xspi.c                     |  52 +-
 drivers/spi/spi-ch341.c                            |   6 +
 drivers/spi/spi-dw-core.c                          | 218 +++++--
 drivers/spi/spi-dw-dma.c                           | 289 +++++++--
 drivers/spi/spi-dw-mmio.c                          |   2 +
 drivers/spi/spi-dw.h                               |  26 +-
 drivers/spi/spi-ep93xx.c                           |   8 +-
 drivers/spi/spi-fsl-dspi.c                         |  35 +-
 drivers/spi/spi-fsl-spi.c                          |   8 +
 drivers/spi/spi-geni-qcom.c                        | 114 +++-
 drivers/spi/spi-imx.c                              |  12 +-
 drivers/spi/spi-ingenic.c                          |  10 +-
 drivers/spi/spi-jcore.c                            |  16 +-
 drivers/spi/spi-ljca.c                             |   7 +-
 drivers/spi/spi-lm70llp.c                          |   2 +-
 drivers/spi/spi-ma35d1-qspi.c                      |  64 +-
 drivers/spi/spi-ma35d1.c                           | 716 +++++++++++++++++++++
 drivers/spi/spi-mem.c                              |  14 +-
 drivers/spi/spi-meson-spicc.c                      |  11 +-
 drivers/spi/spi-mtk-nor.c                          |   1 +
 drivers/spi/spi-mxic.c                             |   8 +-
 drivers/spi/spi-npcm-fiu.c                         |   8 +
 drivers/spi/spi-nxp-xspi.c                         |  16 +-
 drivers/spi/spi-omap2-mcspi.c                      | 246 ++++---
 drivers/spi/spi-orion.c                            |   9 +
 drivers/spi/spi-pci1xxxx.c                         |  71 ++
 drivers/spi/spi-pic32.c                            |   2 +-
 drivers/spi/spi-pl022.c                            |  19 +-
 drivers/spi/spi-qpic-snand.c                       | 119 ++--
 drivers/spi/spi-realtek-rtl.c                      |  36 +-
 drivers/spi/spi-rockchip-sfc.c                     |  21 +-
 drivers/spi/spi-rspi.c                             |  49 +-
 drivers/spi/spi-rtk-nor.c                          | 624 ++++++++++++++++++
 drivers/spi/spi-s3c64xx.c                          |   5 +-
 drivers/spi/spi-sh-hspi.c                          |  15 +-
 drivers/spi/spi-sh-msiof.c                         |  18 +-
 drivers/spi/spi-stm32.c                            |   5 +-
 drivers/spi/spi-sun4i.c                            |  68 +-
 drivers/spi/spi-sun6i.c                            |   2 +-
 drivers/spi/spi-sunplus-sp7021.c                   |  13 +-
 drivers/spi/spi-tegra114.c                         |  49 ++
 drivers/spi/spi-tegra210-quad.c                    | 509 +++++++++++++--
 drivers/spi/spi-ti-qspi.c                          |   2 +-
 drivers/spi/spi-tle62x0.c                          |   6 +-
 drivers/spi/spi-topcliff-pch.c                     |   4 +-
 drivers/spi/spi-virtio.c                           |  22 +-
 drivers/spi/spi-xilinx.c                           |   2 +-
 drivers/spi/spi.c                                  |  19 +-
 include/linux/spi/spi.h                            |   9 +
 tools/spi/Makefile                                 |   2 +-
 tools/spi/spidev_test.c                            | 330 +++++++---
 86 files changed, 4066 insertions(+), 1056 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,pic32mzda-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
 create mode 100644 Documentation/devicetree/bindings/spi/ti,davinci-spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/ti,davinci-spi.yaml
 create mode 100644 drivers/spi/spi-ma35d1.c
 create mode 100644 drivers/spi/spi-rtk-nor.c
