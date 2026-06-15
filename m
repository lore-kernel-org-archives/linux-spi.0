Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E33090D5;
	Mon, 15 Jun 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543107; cv=none; b=Gyty4V+yBXgQZh2gelQz339nt9+xrSBjvGRorgh/UIgmzgQtXraFSBiAWO89ZEWvjZFRZSZKBv/KJ8vaRkpp6qlQie7b6KRE2/XmpZjvjZYGhaoJXVkTYH60KIbR/rnRXs3u6ZGX5PM7f032bOkNiJgsiNM0WCK6ogKmYhrDJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543107; c=relaxed/simple;
	bh=o19azkfjOGUDKOufJaVve0Yy136MXC77c83OH/O6aco=;
	h=Message-ID:From:To:Cc:Subject:Date; b=cmCIel70bcpIniHjFp0/47TXXXfNYMbwQZZjIFWmXe9d69WIyznMOlP/OWo8ifpwsIKjkdCTFZ+5gTTQjcru5ZKeaoR0IU6gmnKGlHtxiAVxZVQPMXXTuc4xRh1XAg83cDYM8xz/DbWVznjssx+LzsxYo2lOMmnw34cB/Fl98g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeyjVX2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeyjVX2y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D6D5C1F000E9;
	Mon, 15 Jun 2026 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781543106;
	bh=+1xOEs1/EHvIJPWqNIwuryBSi8f0Cdszx+6pNydtPQw=;
	h=From:To:Cc:Subject:Date;
	b=DeyjVX2yGPantikYkcBqKMi67aQm4CbYRscDUvMNGk+houwCccbzKWO2sj2ZM5G6F
	 EthYkWycKmYMqpDwVpraLRdN7X6xWivxTt/JgoiNfFWojYUPvKzCRs5E31egsD5GoB
	 fKssqCfAEfzt1HdwtdC8gHsqcslu3fsiu0LExj+Wr/Ycj6FIVuh1tNe7DEvrWGQTDB
	 w9A+GcvXwHS2yhwFiixsEFGhRHdGJZuFNUr5k+U/QppZ42GwAu2N+LGF0uSpl8a+59
	 FzBwrfbeWtWgY5sSjDIjxo0l6gBeQr/S6etCQoj+Oy8VGvsJ4J7X6Mp4GhZriJObRz
	 cfq7T+ng+12Lg==
Message-ID: <eafbecb22793db47da30c2609eedb2ae@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v7.2
Date: Mon, 15 Jun 2026 18:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.2

for you to fetch changes up to f846d68992142034b1d34a83200a10cdc713eeda:

  spi: Fix mismatched DT property access types (2026-06-14 01:18:29 +0100)

----------------------------------------------------------------
spi: Updates for v7.2

This has been quite a busy release, mainly due to the subsystem wide
work Johan Hovold has done to modernise resource allocation for the
subsystem on probe, the subsystem did some very clever allocation
management pre devm which didn't quite mesh comfortably with managed
allocations and made it far too easy to introduce error handling and
removal bugs.

 - Cleanup and simplification of controller struct allocation, moving
   everything over to devm and making the devm APIs more robust, from
   Johan Hovold
 - Support for spi-mem devices that don't assert chip select and support
   for a secondary read command for memory mapped flashes, some commits
   for this are shared with mtd.
 - Support for SpacemiT K1.

There will be a simple add/add conflict with the i2c-host tree in the
x86 quirk data in drivers/acpi/acpi_apd.c.

----------------------------------------------------------------
Aaron Kling (1):
      spi: tegra210-quad: Allocate DMA memory for DMA engine

Alex Elder (2):
      spi: dt-bindings: add SpacemiT K1 SPI support
      spi: spacemit: introduce SpacemiT K1 SPI controller driver

Carlos Song (3):
      spi: fsl-lpspi: replace dmaengine_terminate_all() with dmaengine_terminate_sync()
      spi: fsl-lpspi: terminate the RX channel on TX prepare failure path
      spi: imx: replace dmaengine_terminate_all() with dmaengine_terminate_sync()

Chin-Ting Kuo (2):
      spi: aspeed: Fix missing __iomem annotation in output transfer path
      spi: aspeed: Replace VLA parameter with flat pointer in calibration helper

Conor Dooley (2):
      spi: microchip-core-qspi: report device on which timeout occured instead of which controller
      spi: microchip-core-qspi: remove an unused define

Felix Gu (6):
      spi: atcspi200: fix use-after-free when driver unbind
      spi: atcspi200: switch to devm functions
      spi: rspi: Simplify reset control handling
      spi: atmel: fix DMA channel and bounce buffer leaks
      spi: ep93xx: fix double-free of zeropage on DMA setup failure
      spi: dw-pci: remove redundant pci_free_irq_vectors() calls

Guodong Xu (1):
      spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid 32-bit overflow

Hans Zhang (10):
      spi: amlogic-spifc-a1: Use FIELD_MODIFY()
      spi: amlogic-spisg: Use FIELD_MODIFY()
      spi: cadence-xspi: Use FIELD_MODIFY()
      spi: meson-spicc: Use FIELD_MODIFY()
      spi: nxp-xspi: Use FIELD_MODIFY()
      spi: sn-f-ospi: Use FIELD_MODIFY()
      spi: stm32-ospi: Use FIELD_MODIFY()
      spi: stm32-qspi: Use FIELD_MODIFY()
      spi: sunplus-sp7021: Use FIELD_MODIFY()
      spi: uniphier: Use FIELD_MODIFY()

Jisheng Zhang (1):
      spi: cadence-xspi: Support 32bit and 64bit slave dma interface

Johan Hovold (61):
      spi: mpc52xx: clean up interrupt handling
      spi: cadence: rename probe error labels
      spi: cadence: clean up probe return value
      spi: cadence-quadspi: clean up disable runtime pm quirk
      spi: cadence-quadspi: drop redundant match data lookup
      spi: clean up controller registration return value
      spi: at91-usart: drop dead runtime pm support
      spi: at91-usart: switch to managed controller allocation
      spi: atmel: switch to managed controller allocation
      spi: bcm63xx: switch to managed controller allocation
      spi: bcm63xx-hsspi: switch to managed controller allocation
      spi: cadence: switch to managed controller allocation
      spi: octeon: switch to managed controller allocation
      spi: cavium-thunderx: switch to managed controller allocation
      spi: coldfire-qspi: switch to managed controller allocation
      spi: dln2: switch to managed controller allocation
      spi: ep93xx: switch to managed controller allocation
      spi: fsl: switch to managed controller allocation
      spi: fsl-espi: switch to managed controller allocation
      spi: img-spfi: switch to managed controller allocation
      spi: lantiq-ssc: switch to managed controller allocation
      spi: meson-spicc: switch to managed controller allocation
      spi: mxs: switch to managed controller allocation
      spi: npcm-pspi: switch to managed controller allocation
      spi: orion: switch to managed controller allocation
      spi: omap2-mcspi: switch to managed controller allocation
      spi: omap2-mcspi: clean up error labels
      spi: omap2-mcspi: clean up probe return value
      spi: pic32: switch to managed controller allocation
      spi: pic32-sqi: switch to managed controller allocation
      spi: pl022: switch to managed controller allocation
      spi: qup: switch to managed controller allocation
      spi: rspi: switch to managed controller allocation
      spi: sh-hspi: switch to managed controller allocation
      spi: sh-msiof: switch to managed controller allocation
      spi: sifive: switch to managed controller allocation
      spi: slave-mt27xx: switch to managed controller allocation
      spi: sprd: switch to managed controller allocation
      spi: st-ssc4: switch to managed controller allocation
      spi: sun4i: switch to managed controller allocation
      spi: sun6i: switch to managed controller allocation
      spi: syncuacer: switch to managed controller allocation
      spi: tegra114: switch to managed controller allocation
      spi: tegra20-sflash: switch to managed controller allocation
      spi: ti-qspi: switch to managed controller allocation
      spi: ti-qspi: cleanup registration error path
      spi: uniphier: switch to managed controller allocation
      spi: zync-qspi: switch to managed controller allocation
      spi: altera-platform: switch to managed controller allocation
      spi: armada-3700: switch to managed controller allocation
      spi: clps711x: switch to managed controller allocation
      spi: falcon: switch to managed controller allocation
      spi: fsi: switch to managed controller allocation
      spi: hisi-sfc-v3xx: switch to managed controller allocation
      spi: jcore: switch to managed controller allocation
      spi: lp8841-rtc: switch to managed controller allocation
      spi: lp8841-rtc: drop unused ifdef
      spi: meson-spifc: switch to managed controller allocation
      spi: mux: switch to managed controller allocation
      spi: xlp: switch to managed controller allocation
      spi: fix controller registration API inconsistency

Lad Prabhakar (1):
      spi: Drop redundant 'cs' variable declaration in __spi_add_device()

Lars Pöschel (1):
      spi: xilinx: use FIFO occupancy register to determine buffer size

Mark Brown (13):
      spi: cadence: runtime PM fixes
      spi: cadence-quadspi: runtime PM fixes
      spi: atcspi200: two cleanup
      spi: microchip core-qspi cleanup
      spi: omap2-mcspi: switch to managed controller allocation
      spi: switch to managed controller allocation (part 2/3)
      spi: Use FIELD_MODIFY() for bitfield operations
      spi: switch to managed controller allocation (part 3/3)
      spi: Merge up fixes
      spi: Add trace events for Qualcomm GENI SPI drivers
      spi: aspeed: Fix __iomem annotation and VLA parameter
      spi: fsl-lpspi: fix DMA termination issues
      spi: spi-mem: Add a no_cs_assertion capability

Miquel Raynal (7):
      mtd: spinand: Drop a too strong limitation
      mtd: spinand: Expose spinand_op_is_odtr()
      mtd: spinand: Drop ECC dirmaps
      spi: spi-mem: Transform the read operation template
      spi: spi-mem: Create a secondary read operation
      spi: spi-mem: Add a no_cs_assertion capability
      spi: spi-mem: Fix spi_controller_mem_ops kdoc

Nathan Chancellor (1):
      spi: cadence-xspi: Revert COMPILE_TEST support

Praveen Talari (2):
      spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
      spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver

Qiang Ma (1):
      spi: hisi-kunpeng: Use dev_err_probe() for host registration failure

Randy Dunlap (1):
      spi: s3c64xx: fix all kernel-doc warnings

Rob Herring (Arm) (1):
      spi: Fix mismatched DT property access types

Rosen Penev (2):
      spi: cadence-xspi: Add COMPILE_TEST support
      spi: omap2-mcspi: Use of_device_get_match_data()

Ruoyu Wang (1):
      spi: meson-spifc: fix runtime PM leak on remove

Stepan Ionichev (1):
      spi: amlogic-spisg: drop misleading NULL check on exdesc

Thomas Lin (1):
      spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs

Tomer Maimon (1):
      spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema

Tommaso Merciai (1):
      spi: rzv2h-rspi: Add suspend/resume support

Uwe Kleine-König (The Capable Hub) (3):
      spi: Consistently define pci_device_ids using named initializers
      spi: Use named initializers for arrays of i2c_device_data
      spi: Use named initializers for platform_device_id arrays

Vadim Fedorenko (1):
      spi: xilinx: let transfers timeout in case of no IRQ

Viken Dadhaniya (3):
      spi: dt-bindings: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
      spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM
      spi: spi-qcom-qspi: Add interconnect support for memory path

 .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt   |  58 --
 .../bindings/spi/nuvoton,npcm750-fiu.yaml          |  93 +++
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |  21 +-
 .../devicetree/bindings/spi/spacemit,k1-spi.yaml   |  84 +++
 drivers/acpi/acpi_apd.c                            |   7 +
 drivers/media/usb/msi2500/msi2500.c                |   9 +-
 drivers/mtd/nand/spi/core.c                        |  76 +-
 drivers/mtd/spi-nor/core.c                         |  22 +-
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-airoha-snfi.c                      |   6 +-
 drivers/spi/spi-altera-platform.c                  |  31 +-
 drivers/spi/spi-amlogic-spifc-a1.c                 |   5 +-
 drivers/spi/spi-amlogic-spisg.c                    |  16 +-
 drivers/spi/spi-armada-3700.c                      |  44 +-
 drivers/spi/spi-aspeed-smc.c                       |  15 +-
 drivers/spi/spi-at91-usart.c                       |  63 +-
 drivers/spi/spi-atcspi200.c                        |  28 +-
 drivers/spi/spi-atmel.c                            | 167 +++--
 drivers/spi/spi-bcm63xx-hsspi.c                    |  17 +-
 drivers/spi/spi-bcm63xx.c                          |  26 +-
 drivers/spi/spi-bitbang.c                          |  11 +-
 drivers/spi/spi-cadence-quadspi.c                  |  52 +-
 drivers/spi/spi-cadence-xspi.c                     |  56 +-
 drivers/spi/spi-cadence.c                          |  40 +-
 drivers/spi/spi-cavium-octeon.c                    |  17 +-
 drivers/spi/spi-cavium-thunderx.c                  |  32 +-
 drivers/spi/spi-clps711x.c                         |  31 +-
 drivers/spi/spi-coldfire-qspi.c                    |  28 +-
 drivers/spi/spi-cs42l43.c                          |   4 +-
 drivers/spi/spi-dln2.c                             |  26 +-
 drivers/spi/spi-dw-core.c                          |   2 +
 drivers/spi/spi-dw-mmio.c                          |   7 +-
 drivers/spi/spi-dw-pci.c                           |  26 +-
 drivers/spi/spi-ep93xx.c                           |  23 +-
 drivers/spi/spi-falcon.c                           |   8 +-
 drivers/spi/spi-fsi.c                              |   8 +-
 drivers/spi/spi-fsl-dspi.c                         |   2 +
 drivers/spi/spi-fsl-espi.c                         |  22 +-
 drivers/spi/spi-fsl-lpspi.c                        |  18 +-
 drivers/spi/spi-fsl-spi.c                          |  14 +-
 drivers/spi/spi-geni-qcom.c                        |  13 +
 drivers/spi/spi-hisi-kunpeng.c                     |  12 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |  20 +-
 drivers/spi/spi-img-spfi.c                         |  40 +-
 drivers/spi/spi-imx.c                              |  16 +-
 drivers/spi/spi-intel-pci.c                        |  66 +-
 drivers/spi/spi-intel.c                            |   6 +-
 drivers/spi/spi-jcore.c                            |  23 +-
 drivers/spi/spi-lantiq-ssc.c                       |  28 +-
 drivers/spi/spi-lp8841-rtc.c                       |  16 +-
 drivers/spi/spi-mem.c                              |  32 +-
 drivers/spi/spi-meson-spicc.c                      |  48 +-
 drivers/spi/spi-meson-spifc.c                      |  23 +-
 drivers/spi/spi-microchip-core-qspi.c              |   3 +-
 drivers/spi/spi-mpc52xx.c                          |  28 +-
 drivers/spi/spi-mux.c                              |  19 +-
 drivers/spi/spi-mxic.c                             |  18 +-
 drivers/spi/spi-mxs.c                              |  14 +-
 drivers/spi/spi-npcm-fiu.c                         |  16 +-
 drivers/spi/spi-npcm-pspi.c                        |  19 +-
 drivers/spi/spi-nxp-xspi.c                         |  12 +-
 drivers/spi/spi-omap2-mcspi.c                      |  49 +-
 drivers/spi/spi-orion.c                            |  26 +-
 drivers/spi/spi-pci1xxxx.c                         |  42 +-
 drivers/spi/spi-pic32-sqi.c                        |  28 +-
 drivers/spi/spi-pic32.c                            |  11 +-
 drivers/spi/spi-pl022.c                            |  11 +-
 drivers/spi/spi-qcom-qspi.c                        |  80 ++-
 drivers/spi/spi-qup.c                              |  15 +-
 drivers/spi/spi-rpc-if.c                           |   8 +-
 drivers/spi/spi-rspi.c                             |  44 +-
 drivers/spi/spi-rzv2h-rspi.c                       |  18 +
 drivers/spi/spi-s3c64xx.c                          |   6 +-
 drivers/spi/spi-sc18is602.c                        |   6 +-
 drivers/spi/spi-sh-hspi.c                          |  11 +-
 drivers/spi/spi-sh-msiof.c                         |  32 +-
 drivers/spi/spi-sifive.c                           |  39 +-
 drivers/spi/spi-slave-mt27xx.c                     |  33 +-
 drivers/spi/spi-sn-f-ospi.c                        |   5 +-
 drivers/spi/spi-spacemit-k1.c                      | 789 +++++++++++++++++++++
 drivers/spi/spi-sprd.c                             |  20 +-
 drivers/spi/spi-st-ssc4.c                          |  14 +-
 drivers/spi/spi-stm32-ospi.c                       |  13 +-
 drivers/spi/spi-stm32-qspi.c                       |  11 +-
 drivers/spi/spi-sun4i.c                            |  35 +-
 drivers/spi/spi-sun6i.c                            |  38 +-
 drivers/spi/spi-sunplus-sp7021.c                   |   3 +-
 drivers/spi/spi-synquacer.c                        |  24 +-
 drivers/spi/spi-tegra114.c                         |  34 +-
 drivers/spi/spi-tegra20-sflash.c                   |  24 +-
 drivers/spi/spi-tegra210-quad.c                    |  29 +-
 drivers/spi/spi-ti-qspi.c                          |  37 +-
 drivers/spi/spi-topcliff-pch.c                     |  10 +-
 drivers/spi/spi-uniphier.c                         |  46 +-
 drivers/spi/spi-wpcm-fiu.c                         |   2 +-
 drivers/spi/spi-xcomm.c                            |   4 +-
 drivers/spi/spi-xilinx.c                           |  19 +-
 drivers/spi/spi-xlp.c                              |   3 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |   1 -
 drivers/spi/spi-zynq-qspi.c                        |  40 +-
 drivers/spi/spi.c                                  |  41 +-
 drivers/staging/greybus/spilib.c                   |   8 +-
 include/linux/mtd/spinand.h                        |   4 +-
 include/linux/platform_data/spi-s3c64xx.h          |   3 +-
 include/linux/spi/spi-mem.h                        |  13 +-
 include/linux/spi/spi.h                            |   4 -
 include/trace/events/qcom_geni_spi.h               | 103 +++
 108 files changed, 2085 insertions(+), 1448 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm750-fiu.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml
 create mode 100644 drivers/spi/spi-spacemit-k1.c
 create mode 100644 include/trace/events/qcom_geni_spi.h
