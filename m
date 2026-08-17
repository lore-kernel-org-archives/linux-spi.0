Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C544781B;
	Mon, 17 Aug 2026 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985638; cv=none; b=W67Rpc+83/5Db8+8yPKt7UqxKBYXlgalbpkxgC9dfVWiOce8nKe0E+7KJg9QPM7hpcZhfUwWtvdu/wnNzrjAutRfGXxd6EHnBwgyr4K3tHqt3aRWPf9vLD+g2WSBTh/7zN3wRT7G5uqd8PIAh2+8NKP6vwk1eUtw0bGwHEbK290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985638; c=relaxed/simple;
	bh=Nx2QoEq8I7icJiyVgMN1Y3jpNsZsSLUBfRJgw0jpZ7k=;
	h=Message-ID:From:To:Cc:Subject:Date; b=hUpABdsIheYgOQFt16fJ34EfpZ1f9RqqYfMCT+SPOfAEDVO7x4A1SnY8WF5BqvC/tdxfDkqfSjEsJOUy7xCl5pje13E13erPhnQz4sBxNKnbAUkUhhilugL9rKHHLuYjUmI7Z37GZtl+Im1meufma3ijJoFU6iD3LYhXhQ/1PsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0g7gqum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0g7gqum"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 36D5F1F00A3A;
	Mon, 17 Aug 2026 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985625;
	bh=BCQ/2D9gYDS8yLAAn+1S9kG5b/Q3nfO/m3Kk4Pa3828=;
	h=From:To:Cc:Subject:Date;
	b=J0g7gqumhvGgypOb/km21xfcljcoSbxNU/G5dhOg3Qc6fJtqFaJ6k7RSmQveEdYCB
	 PRGg68gp78ggWawtdhyEMJI8t0ffO8u3DMw42Lv8DgaeuP5PSoo2rka4kfhFkJ9hV1
	 VNcOy7FWkE6sC/M9ISrfYkrxs9MiMd26iBbJS7swYZ5ek0CV0+pRLlpOsJxrefbcB1
	 EAW8A7j3pZJoOwJ68THl2sWb5tRPIY4ZLKDJ4CV+TW0UP+bj4fz6BSQtsTng0YEnig
	 LbZbQh9k4RhmM2e1TkikoElbj/rbGUpOICG8839/fLZpA8zlpUX9jk8GO+W8Ayg2Xi
	 07a/4xse/W8EA==
Message-ID: <14728b3c8987929a3f2944ce5ddb7297@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v7.3
Date: Mon, 17 Aug 2026 17:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.3

for you to fetch changes up to 23688febe4b44b10f4b454eb1cde0ba379a84119:

  spi: Fix DMA mapping ownership on partial map failure (2026-08-14 16:48:53 +0100)

----------------------------------------------------------------
spi: Updates for v7.3

Along with a lot of driver specific work we've got a couple of core
features here.  The bigger one is that we've now got support for
instantiating devices from sysfs similarly to how it's already done for
I2C, this is used with development boards with non-enumerable expansion
headers since SPI devices need to be manually specified.  We also have
support for the DQS signal on higher end flash devices.

 - Support for intantiating devices from sysfs, useful for development
   boards with non-enumerable plugin modules, from Vishwaroop A.
 - Support for DQS in spi-mem, an additional signal used by flash
   devices to avoid clock skew from Miquel Raynal.
 - Support for more advanced SPI modes on DesignWare controllers from
   Sudip Mukherjee.
 - Changes from Jisheng Zhang to update to modern methods of specifying
   the PM callbacks.
 - Fixes for DMA mapping error handling, plus KUnit tests for this, from
   Honghui Jiang.
 - Substantial cleanup and performance work in the nxp-spi driver.
 - Support for Microchip LAN969x, Nuvoton MA35D1 QSPI, Qualcomm SA8255p
   and SA8797P, and StarFive JHB100 SFC.

There is a trivial add/add conflict with the KUnit tree in their
all_tests.config.

----------------------------------------------------------------
Babanpreet Singh (3):
      spi: axiado: merge identical if/else branches in ax_transfer_one()
      spi: axiado: fix kernel-doc comments
      spi: sprd-adi: Fix probe succeeding without registering the controller

Can Peng (3):
      spi: bcm63xx-hsspi: disable clocks on resume failure
      spi: bcm63xx: disable clock on resume failure
      spi: bcmbca-hsspi: disable clocks on resume failure

Changhuang Liang (2):
      spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
      spi: dw: Add support for StarFive JHB100 SoC SFC

Chi-Wen Weng (3):
      dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
      spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support
      spi: dt-bindings: nuvoton,ma35d1-qspi: Disallow GPIO chip selects

Colin Ian King (1):
      spi: bcm2835: make read-only const array pinctrl_compats static

Fan Wu (2):
      spi: oc-tiny: switch to managed controller allocation
      spi: davinci: switch to managed controller allocation

Felix Gu (2):
      spi: meson-spifc: use devm_pm_runtime_set_active_enabled
      spi: img-spfi: don't disable runtime PM on DMA deferred probe

Han Xu (2):
      spi: dt-bindings: nxp,imx94-xspi: add DMA properties
      spi: nxp-xspi: Improve AHB read performance with DMA

Honghui Jiang (4):
      spi: Fix DMA mapping ownership on partial map failure
      spi: Move __spi_unmap_msg() before __spi_map_msg()
      spi: Clear current DMA devices when unmapping a message
      spi: Add KUnit coverage for DMA mapping error paths

Jerome Brunet (1):
      spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers

Jiawen Liu (7):
      spi: bcm63xx: return error from failed controller suspend
      spi: bcm63xx-hsspi: return error from failed controller suspend
      spi: bcm-qspi: return error from failed controller suspend
      spi: atcspi200: return error from failed controller suspend
      spi: bcmbca-hsspi: return error from failed controller suspend
      spi: fsl-dspi: clean up after failed suspend and resume
      spi: nxp-fspi: disable runtime PM on probe failures

Jisheng Zhang (43):
      spi: cadence-xspi: group marvell support code together
      spi: cadence-xspi: put marvell support code under CONFIG_64BIT
      spi: cadence-xspi: only use readsq/writesq under 64BIT
      spi: cadence-xspi: remove 64BIT Kconfig dependency
      spi: atmel-quadspi: use modern PM macros
      spi: amlogic-spifc-a1: use modern PM macros
      spi: at91-usart: use modern PM macros
      spi: axiado: use modern PM macros
      spi: bcm-qspi: use modern PM macros
      spi: bcm63xx-hsspi: use modern PM macros
      spi: bcmbca-hsspi: use modern PM macros
      spi: cadence: use modern PM macros
      spi: coldfire-qspi: use modern PM macros
      spi: dln2: use modern PM macros
      spi: dw-pci: use modern PM macros
      spi: spi-fsl-dspi: use modern PM macros
      spi: fsl-espi: use modern PM macros
      spi: fsl-lpspi: use modern PM macros
      spi: qcom-geni: use modern PM macros
      spi: img-spfi: use modern PM macros
      spi: loongson: use modern PM macros
      spi: meson-spifc: use modern PM macros
      spi: mt65xx: use modern PM macros
      spi: mtk-nor: use modern PM macros
      spi: mxic: use modern PM macros
      spi: omap2-mcspi: use modern PM macros
      spi: orion: use modern PM macros
      spi: pl022: use modern PM macros
      spi: spi-qcom-qspi: use modern PM macros
      spi: qup: use modern PM macros
      spi: rockchip-sfc: use modern PM macros
      spi: rockchip: use modern PM macros
      spi: s3c64xx: use modern PM macros
      spi: slave-mt27xx: use modern PM macros
      spi: sprd: use modern PM macros
      spi: sunplus-sp7021: use modern PM macros
      spi: syncuacer: use modern PM macros
      spi: tegra114: use modern PM macros
      spi: tegra20-sflash: use modern PM macros
      spi: tegra20-slink: use modern PM macros
      spi: tegra210-quad: use modern PM macros
      spi: topcliff-pch: use modern PM macros
      spi: zynqmp-gqspi: use modern PM macros

Krzysztof Kozlowski (8):
      spi: atmel-quadspi: Simplify probe() with local 'dev' variable
      spi: atmel-quadspi: Simplify with dev_err_probe()
      spi: altera: Simplify with dev_err_probe()
      spi: dt-bindings: andestech,ae350-spi: Drop redundant num-cs
      spi: dt-bindings: marvell,armada-3700-spi: Drop redundant num-cs
      spi: dt-bindings: axiado,ax3000-spi: Drop duplicated type/ref
      spi: dt-bindings: spi-cadence: Drop duplicated type/ref
      spi: atcspi200: Drop redundant andestech,qilai-spi compatible

Lad Prabhakar (1):
      spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay

Liang Hao (1):
      spi: dw: Remove shadowed dws in dw_spi_setup()

Mark Brown (15):
      Merge existing fixes from spi/for-7.2 into new branch
      spi: Enable SPI on SA8255p Qualcomm platforms
      spi: atmel-quadspi: add support for LAN969x
      spi: axiado: cond_no_effect and kernel-doc fixes
      spi: Merge up fixes
      spi: Add trace event support for GENI SE registers dump
      spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
      spi: Add support for StarFive JHB100 SFC
      spi: cadence-xspi: remove 64BIT dependency
      spi: Few cleanups while looking at num-cs
      spi: add new_device/delete_device sysfs interface
      spi: use modern PM macros
      Add quad mode support for QPIC SNAND
      spi: ma35d1-qspi: Improvements and DTR support
      spi: Fix DMA mapping ownership on partial map failure

Md Sadre Alam (4):
      spi: spi-qpic-snand: Increase ECC strength for large OOB SPI-NAND devices
      spi: spi-qpic-snand: move command mapping helper
      spi: spi-qpic-snand: add quad mode support
      spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b

Miquel Raynal (6):
      spi: spi-mem: Flag DQS capability
      spi: ma35d1-qspi: Remove redundant reset operation
      spi: ma35d1-qspi: Move speed setting to bus configuration
      spi: ma35d1-qspi: Allow several command bytes
      spi: ma35d1-qspi: Add DTR support
      spi: ma35d1-qspi: Use the existing update helper

Ninad Naik (1):
      spi: dt-bindings: octeon: Convert to DT schema

Patrice Chotard (1):
      spi: dt-bindings: st,stm32-qspi: Add power-domains property

Pei Xiao (2):
      spi: spacemit: fix dangling TX DMA descriptor on RX prep failure
      spi: spacemit: drop redundant dev_err_probe() around irq helpers

Pengpeng Hou (1):
      spi: qpic-snand: free OOB buffer with ECC context

Praveen Talari (8):
      spi: dt-bindings: describe SA8255p
      spi: qcom-geni: Use geni_se_resources_init() for resource initialization
      spi: qcom-geni: Use resources helper APIs in runtime PM functions
      spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()
      spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto
      soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      spi: qcom-geni: add GENI SE registers trace event on error paths

Robert Marko (4):
      spi: dt-bindings: Document LAN969x QSPI
      spi: atmel-quadspi: add controller init callback
      spi: atmel-quadspi: use init callback for gclk variants
      spi: atmel-quadspi: add LAN969x QSPI support

Rosen Penev (5):
      spi: orion: use devm_clk_get_optional_enabled for axi clock
      spi: ppc4xx: devm-ify probe and drop manual resource management
      spi: spi-mpc52xx: use platform_get_irq_optional for IRQ lookup
      spi: ppc4xx: use of_property_read_u32 for clock frequency
      spi: ath79: use devm everywhere in probe

Rustam Adilov (1):
      spi: realtek-rtl: change to __raw reads and writes

Shawn Guo (1):
      spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible for Nord SA8797P

Sudip Mukherjee (9):
      spi: dw: Introduce spi_frf and STD_SPI
      spi: dw: update SPI_CTRLR0 register
      spi: dw: add check for support of enhanced spi
      spi: dw: adjust size of mem_op
      spi: dw: update NDF while using enhanced spi mode
      spi: dw: Introduce enhanced single/dual/quad/octal spi
      spi: dw: send cmd and addr to start the spi transfer
      spi: dw: use irq handler for enhanced spi
      spi: dw: detect enhanced spi mode

Tomer Maimon (1):
      spi: npcm-fiu: support dual and quad UMA writes

Vishwaroop A (2):
      spi: add new_device/delete_device sysfs interface
      docs: spi: add documentation for userspace device instantiation

bui duc phuc (3):
      spi: hisi-sfc-v3xx: Propagate errors from optional IRQ lookup
      spi: mtk-nor: Propagate errors from optional IRQ lookup
      spi: mtk-nor: Propagate errors from IRQ request

 Documentation/ABI/testing/sysfs-class-spi-master   |  34 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   6 +
 .../bindings/spi/andestech,ae350-spi.yaml          |   4 -
 .../devicetree/bindings/spi/atmel,quadspi.yaml     |   1 +
 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml |   1 -
 .../bindings/spi/cavium,octeon-3010-spi.yaml       |  61 ++
 .../bindings/spi/marvell,armada-3700-spi.yaml      |   3 -
 .../bindings/spi/nuvoton,ma35d1-qspi.yaml          |  65 ++
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |  10 +
 .../bindings/spi/qcom,sa8255p-geni-spi.yaml        |  68 ++
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  22 +
 .../devicetree/bindings/spi/spi-cadence.yaml       |   1 -
 .../devicetree/bindings/spi/spi-octeon.txt         |  33 -
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   3 +
 Documentation/spi/index.rst                        |   1 +
 Documentation/spi/instantiating-devices.rst        |  88 +++
 drivers/soc/qcom/qcom-geni-se.c                    |   5 +
 drivers/spi/.kunitconfig                           |   4 +
 drivers/spi/Kconfig                                |  27 +-
 drivers/spi/Makefile                               |   2 +
 drivers/spi/atmel-quadspi.c                        | 148 +++--
 drivers/spi/internals.h                            |   9 +-
 drivers/spi/spi-altera-platform.c                  |  13 +-
 drivers/spi/spi-amlogic-spifc-a1.c                 |  15 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-atcspi200.c                        |   6 +-
 drivers/spi/spi-ath79.c                            |  24 +-
 drivers/spi/spi-axiado.c                           |  35 +-
 drivers/spi/spi-axiado.h                           |   5 +-
 drivers/spi/spi-bcm-qspi.c                         |  12 +-
 drivers/spi/spi-bcm2835.c                          |   2 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  22 +-
 drivers/spi/spi-bcm63xx.c                          |  11 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |  22 +-
 drivers/spi/spi-brcmstb-qspi.c                     |   2 +-
 drivers/spi/spi-cadence-xspi.c                     | 475 +++++++-------
 drivers/spi/spi-cadence.c                          |  15 +-
 drivers/spi/spi-coldfire-qspi.c                    |  12 +-
 drivers/spi/spi-davinci.c                          |   7 +-
 drivers/spi/spi-dln2.c                             |  11 +-
 drivers/spi/spi-dw-core.c                          | 387 +++++++++++-
 drivers/spi/spi-dw-mmio.c                          |  72 +++
 drivers/spi/spi-dw-pci.c                           |   6 +-
 drivers/spi/spi-dw.h                               |  52 +-
 drivers/spi/spi-fsl-dspi.c                         |  27 +-
 drivers/spi/spi-fsl-espi.c                         |  11 +-
 drivers/spi/spi-fsl-lpspi.c                        |   6 +-
 drivers/spi/spi-geni-qcom.c                        | 143 +++--
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   4 +-
 drivers/spi/spi-img-spfi.c                         |  16 +-
 drivers/spi/spi-iproc-qspi.c                       |   2 +-
 drivers/spi/spi-loongson-core.c                    |   4 +-
 drivers/spi/spi-loongson-pci.c                     |   2 +-
 drivers/spi/spi-loongson-plat.c                    |   2 +-
 drivers/spi/spi-ma35d1-qspi.c                      | 685 +++++++++++++++++++++
 drivers/spi/spi-mem.c                              |  32 +
 drivers/spi/spi-meson-spifc.c                      |  30 +-
 drivers/spi/spi-mpc52xx.c                          |  16 +-
 drivers/spi/spi-mt65xx.c                           |  11 +-
 drivers/spi/spi-mtk-nor.c                          |  21 +-
 drivers/spi/spi-mxic.c                             |   9 +-
 drivers/spi/spi-npcm-fiu.c                         |  15 +-
 drivers/spi/spi-nxp-fspi.c                         |  31 +-
 drivers/spi/spi-nxp-xspi.c                         | 143 ++++-
 drivers/spi/spi-oc-tiny.c                          |  24 +-
 drivers/spi/spi-omap2-mcspi.c                      |   9 +-
 drivers/spi/spi-orion.c                            |  37 +-
 drivers/spi/spi-pl022.c                            |  10 +-
 drivers/spi/spi-ppc4xx.c                           | 105 +---
 drivers/spi/spi-qcom-qspi.c                        |  16 +-
 drivers/spi/spi-qpic-snand.c                       | 174 ++++--
 drivers/spi/spi-qup.c                              |  14 +-
 drivers/spi/spi-realtek-rtl.c                      |  26 +-
 drivers/spi/spi-rockchip-sfc.c                     |  12 +-
 drivers/spi/spi-rockchip.c                         |  12 +-
 drivers/spi/spi-rpc-if.c                           |   4 +
 drivers/spi/spi-s3c64xx.c                          |  12 +-
 drivers/spi/spi-slave-mt27xx.c                     |  12 +-
 drivers/spi/spi-spacemit-k1.c                      |  10 +-
 drivers/spi/spi-sprd-adi.c                         |   6 +
 drivers/spi/spi-sprd.c                             |   9 +-
 drivers/spi/spi-sunplus-sp7021.c                   |  16 +-
 drivers/spi/spi-synquacer.c                        |  10 +-
 drivers/spi/spi-tegra114.c                         |  10 +-
 drivers/spi/spi-tegra20-sflash.c                   |  10 +-
 drivers/spi/spi-tegra20-slink.c                    |  14 +-
 drivers/spi/spi-tegra210-quad.c                    |  14 +-
 drivers/spi/spi-topcliff-pch.c                     |  47 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  15 +-
 drivers/spi/spi.c                                  | 337 ++++++++--
 drivers/spi/tests/Makefile                         |   3 +
 drivers/spi/tests/spi-dma-kunit.c                  | 259 ++++++++
 include/linux/soc/qcom/geni-se.h                   |  38 ++
 include/linux/spi/spi-mem.h                        |   4 +
 include/linux/spi/spi.h                            |  18 +
 include/trace/events/qcom_geni_se.h                | 157 +++++
 tools/testing/kunit/configs/all_tests.config       |   1 +
 tools/testing/kunit/configs/default.config         |   1 +
 98 files changed, 3486 insertions(+), 980 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-spi-master
 create mode 100644 Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
 create mode 100644 Documentation/spi/instantiating-devices.rst
 create mode 100644 drivers/spi/.kunitconfig
 create mode 100644 drivers/spi/spi-ma35d1-qspi.c
 create mode 100644 drivers/spi/tests/Makefile
 create mode 100644 drivers/spi/tests/spi-dma-kunit.c
 create mode 100644 include/trace/events/qcom_geni_se.h
