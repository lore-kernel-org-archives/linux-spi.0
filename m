Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55419B672;
	Mon,  9 Feb 2026 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654413; cv=none; b=K89CYIoBSKKT55HdU3zgkNTJDK65SjOmXP3RPngtKi7g4kKteql7evq3CLtmumlT+hn2elZACbsk1dqG127Fv3Z5QqrWLnvE9RlhPXkuLqg6dHqD44gGEKBUj8/Mgtc1v1RdUe01mNI9YJkD6fm0K0qNDZeD0nxd06ldXfGqKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654413; c=relaxed/simple;
	bh=H29pwCXl4e+9rLbXXVtWutOEOmiJvQufCHB8B7cVBlI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LcLqiIKvB7lkAjEE8drqTfbuqvZdZAC+vZ69I5N2uDr4HZDFWEPdYbuUU20EN0/XVJRqOvweqjUEEx0eXjCkSIaRVAhSzJnsXzZFBtEx50cyUYvd0So7mMXA1BZmmCTkK9VNOPuY//4QUGBv3ER7H27ilMKvEk109h3Bu5UyH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENv1KZ6S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENv1KZ6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE88C116C6;
	Mon,  9 Feb 2026 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770654413;
	bh=H29pwCXl4e+9rLbXXVtWutOEOmiJvQufCHB8B7cVBlI=;
	h=From:To:Cc:Subject:Date:From;
	b=ENv1KZ6Sg8GO9KGrJUSJbVJxVTJiwgfQn9umveDi9rTis0DYH0kPnPG8wVXoSKMD2
	 QjIPl3E03D7Urx8pe2V95juooJk8afTScCqIqP6GLGXPHmpadpzfabDoS7WAmQEhx+
	 vii6iOWm2lByy0eMtkitHy/Tn3L0dV8CsM0I64sdL3L+hctAYAr4FvffssSIhpmcSb
	 ODTKD3tLTuh0vJKMN82p8gD6s7BrDBZVgKlgsPoKlHhsm4eBGX/z2mURkLCkOvFAj3
	 ScGPZ4gqZl2dUzXil8Ifn5/KdNZlCHvywnYQEq8+yV94pQMdLpbjzGxYrqCTo3LwkS
	 SIieS8GsrqT4A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EE5881AC57EB; Mon, 09 Feb 2026 16:26:49 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.20
Date: Mon, 09 Feb 2026 16:26:45 +0000
Message-Id: <20260209162649.EE5881AC57EB@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.20

for you to fetch changes up to 5af56f30c4fcbade4a92f94dadfea517d1db9703:

  spi: tools: Add include folder to .gitignore (2026-02-09 12:27:31 +0000)

----------------------------------------------------------------
spi: Updates for v7.0

The highlight here is that David Lechner has added support for multi-lane
SPI devices.  Unlike the existing dual/quad SPI support this is for
devices (typically ADCs/DACs) which support multiple independent data
streams over multiple data lanes, instead of sending one data stream N
times as fast they simultaneously transfer N different data streams.
This is very similar to the case where multiple devices are grouped
together but in this case it's a single device in a way that's visible
to software.

Otherwise there's been quite a bit of work on existing drivers, both
cleanup and feature improvement, and a reasonable collection of new
drivers.

 - Support for multi-lane SPI devices.
 - Preparatory work for some memory mapped flash improvements that will
   happen in the MTD subsystem.
 - Several conversions to fwnode APIs.
 - A bunch of cleanup and hardening work on the ST drivers.
 - Support for DMA mode on Renesas RZV2H and i.MX target mode.
 - Support for ATCSPI200, AXIADO AX300, NXP XPI and Renesas RZ/N1.

----------------------------------------------------------------
Abdurrahman Hussain (3):
      spi: dt-bindings: xilinx: make interrupts optional
      spi: xilinx: make irq optional
      spi: xilinx: use device property accessors.

Akif Ejaz (1):
      spi: cadence-qspi: Remove redundant pm_runtime_mark_last_busy call

Alain Volmat (7):
      spi: dt-bindings: st,stm32-spi: add 'power-domains' property
      spi: stm32: properly fail on dma_request_chan error
      spi: stm32: perform small transfer in polling mode
      spi: st: remove __maybe_unused for suspend/resume
      spi: stm32-ospi: avoid __maybe_unused and use pm_ptr
      spi: stm32-qspi: avoid __maybe_unused and use pm_ptr
      spi: stm32: avoid __maybe_unused and use pm_ptr

Andy Shevchenko (10):
      spi: cadence-xspi: Replace ACPI specifics by agnostic APIs
      spi: cadence-xspi: Replace OF/ACPI specifics by agnostic APIs
      spi: microchip-core: use XOR instead of ANDNOT to fix the logic
      spi: Simplify devm_spi_*_controller()
      spi: Propagate default fwnode to the SPI controller device
      spi: Drop duplicate of_node assignment
      spi: Drop duplicate fwnode assignment
      spi: Drop duplicate device_set_node() call
      spi: dw: Remove duplicate error message
      spi: dw: Remove not-going-to-be-supported code for Baikal SoC

CL Wang (3):
      spi: atcspi200: Add ATCSPI200 SPI controller driver
      spi: dt-bindings: Add support for ATCSPI200 SPI controller
      MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver

Carlos Song (7):
      spi: imx: group spi_imx_dma_configure() with spi_imx_dma_transfer()
      spi: imx: introduce helper to clear DMA mode logic
      spi: imx: avoid dmaengine_terminate_all() on TX prep failure
      spi: imx: handle DMA submission errors with dma_submit_error()
      spi: imx: support dynamic burst length for ECSPI DMA mode
      spi: imx: enable DMA mode for target operation
      spi: spi-fsl-lpspi: convert min_t() to simple min()

Chen Ni (2):
      spi: stm32-ospi: Remove unneeded semicolon
      spi: stm32-qspi: Remove unneeded semicolon

Chin-Ting Kuo (2):
      spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
      spi: aspeed: Add support for non-spi-mem devices

Cosmin Tanislav (11):
      spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
      spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
      spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
      spi: rzv2h-rspi: use device-managed APIs
      spi: rzv2h-rspi: store RX interrupt in state
      spi: rzv2h-rspi: set MUST_RX/MUST_TX
      spi: rzv2h-rspi: set TX FIFO threshold to 0
      spi: rzv2h-rspi: enable TX buffer empty interrupt
      spi: rzv2h-rspi: split out PIO transfer
      spi: dt-bindings: renesas,rzv2h-rspi: document optional support for DMA
      spi: rzv2h-rspi: add support for DMA mode

David Lechner (7):
      spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
      spi: dt-bindings: add spi-{tx,rx}-lane-map properties
      spi: support controllers with multiple data lanes
      spi: add multi_lane_mode field to struct spi_transfer
      spi: Documentation: add page on multi-lane support
      spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
      spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE

Deepak Kumar (1):
      spi: stm32: fix Overrun issue at < 8bpw

Francesco Lavra (1):
      spi: tools: Add include folder to .gitignore

Gabor Juhos (1):
      spi: spi-qpic-snand: remove superfluous qcom_spi_set_read_loc() calls

Geert Uytterhoeven (1):
      spi: SPI_AXIADO should depend on ARCH_AXIADO

Haibo Chen (3):
      spi: dt-bindings: nxp,imx94-xspi: Document imx94 xspi
      spi: add driver for NXP XSPI controller
      spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi

Jisheng Zhang (2):
      spi: cadence-xspi: support suspend/resume
      spi: dw-mmio: support suspend/resume

Jonas Gorski (1):
      spi: bcm63xx-hsspi: add support for 1-2-2 read ops

Jonathan Marek (5):
      spi-geni-qcom: remove manual CS control
      spi-geni-qcom: don't set max clock in setup_fifo_params
      spi-geni-qcom: use xfer->bits_per_word for can_dma()
      spi-geni-qcom: initialize mode related registers to 0
      spi-geni-qcom: rework setup_fifo_params

Krzysztof Kozlowski (2):
      spi: virtio: Fix confusing cleanup.h syntax
      spi: fsi: Simplify with scoped for each OF child loop

Linus Walleij (1):
      dt-bindings: spi: Add binding for Faraday FTSSP010

Marek Vasut (1):
      spi: spi-fsl-lpspi: Handle clock polarity and phase

Mark Brown (17):
      spi: cadence-quadspi: Parse DT for flashes with the rest of the DT parsing
      spi: stm32: Update for OSPI and QSPI drivers
      Support ECSPI dynamic burst feature for DMA mode
      Add DMA support for RZ/T2H RSPI
      Add support for NXP XSPI
      spi: atcspi200: Add support for Andes ATCSPI200 SPI
      spi: stm32: stability & performance enhancements
      spi: st: use pm_ptr and remove __maybe_unused
      Axiado AX3000 SoC SPI DB controller driver
      mtd: spinand: Octal DTR support
      spi: rockchip: Use plain request_irq()
      spi: Make SPI core to take care of fwnode
      spi: xilinx: make IRQs optional
      spi: aspeed: Improve handling of shared SPI
      spi: cadence-qspi: Add Renesas RZ/N1 support
      spi: add multi-lane support
      spi: cadence-qspi: Add Renesas RZ/N1 support

Miquel Raynal (3):
      spi: spi-mem: Make the DTR command operation macro more suitable
      spi: spi-mem: Create a repeated address operation
      spi: spi-mem: Limit octal DTR constraints to octal DTR situations

Miquel Raynal (Schneider Electric) (14):
      spi: dt-bindings: cdns,qspi-nor: Drop label in example
      spi: cadence-qspi: Align definitions
      spi: cadence-qspi: Fix style and improve readability
      spi: cadence-qspi: Fix ORing style and alignments
      spi: cadence-qspi: Remove an useless operation
      spi: cadence-qspi: Make sure we filter out unsupported ops
      spi: cadence-qspi: Fix probe error path and remove
      spi: cadence-qspi: Try hard to disable the clocks
      spi: cadence-qspi: Add a flag for controllers without indirect access support
      spi: cadence-qspi: Make sure write protection is disabled
      spi: cadence-qspi: Use a default value for cdns,fifo-width
      spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
      spi: cadence-qspi: Kill cqspi_jh7110_clk_init
      spi: cadence-qspi: Add support for the Renesas RZ/N1 controller

Patrice Chotard (8):
      spi: stm32-ospi: Set DMA maxburst dynamically
      spi: stm32-ospi: Optimize FIFO accesses using u16 or u32
      spi: stm32-ospi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-ospi: Simplify SMIE interrupt test
      spi: stm32-qspi: Set DMA maxburst dynamically
      spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      spi: stm32-qspi: Remove CR_TCIE and CR_TEIE irq usage
      spi: stm32-qspi: Simplify SMIE interrupt test

Praveen Talari (4):
      spi: geni-qcom: Improve target mode allocation by using proper allocation functions
      spi: geni-qcom: Fix abort sequence execution for serial engine errors
      spi: geni-qcom: Drop unused msg parameter from timeout handlers
      spi: geni-qcom: Add target abort support

Robert Marko (1):
      spi: dt-bindings: at91: add microchip,lan9691-spi

Vladimir Moravcevic (3):
      spi: dt-bindings: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
      spi: axiado: Add driver for Axiado SPI DB controller
      MAINTAINERS: Add entries for the Axiado SPI DB controller

Vladimir Zapolskiy (1):
      spi: dt-bindings: nxp,lpc3220-spi: Add DMA specific properties

 .../bindings/display/panel/sitronix,st7789v.yaml   |    5 +-
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |   42 +-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |    5 +-
 .../bindings/spi/adi,axi-spi-engine.yaml           |   15 +
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |    6 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |    6 +-
 .../bindings/spi/andestech,ae350-spi.yaml          |   87 ++
 .../bindings/spi/atmel,at91rm9200-spi.yaml         |    1 +
 .../devicetree/bindings/spi/axiado,ax3000-spi.yaml |   73 ++
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   21 +-
 .../devicetree/bindings/spi/faraday,ftssp010.yaml  |   43 +
 .../bindings/spi/nvidia,tegra210-quad.yaml         |    6 +-
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |   92 ++
 .../devicetree/bindings/spi/nxp,lpc3220-spi.yaml   |    8 +
 .../bindings/spi/renesas,rzv2h-rspi.yaml           |    8 +
 .../bindings/spi/spi-peripheral-props.yaml         |   40 +-
 .../devicetree/bindings/spi/spi-xilinx.yaml        |    1 -
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |    3 +
 Documentation/spi/index.rst                        |    1 +
 Documentation/spi/multiple-data-lanes.rst          |  217 +++
 MAINTAINERS                                        |   26 +
 drivers/spi/Kconfig                                |   57 +-
 drivers/spi/Makefile                               |    4 +-
 drivers/spi/atmel-quadspi.c                        |    1 -
 drivers/spi/spi-airoha-snfi.c                      |    1 -
 drivers/spi/spi-altera-platform.c                  |    2 -
 drivers/spi/spi-amlogic-spifc-a1.c                 |    1 -
 drivers/spi/spi-amlogic-spisg.c                    |    1 -
 drivers/spi/spi-apple.c                            |    1 -
 drivers/spi/spi-ar934x.c                           |    1 -
 drivers/spi/spi-armada-3700.c                      |    4 +-
 drivers/spi/spi-aspeed-smc.c                       |  135 +-
 drivers/spi/spi-atcspi200.c                        |  679 ++++++++++
 drivers/spi/spi-ath79.c                            |    1 -
 drivers/spi/spi-atmel.c                            |    1 -
 drivers/spi/spi-axi-spi-engine.c                   |  146 ++-
 drivers/spi/spi-axiado.c                           | 1007 ++++++++++++++
 drivers/spi/spi-axiado.h                           |  133 ++
 drivers/spi/spi-bcm-qspi.c                         |    1 -
 drivers/spi/spi-bcm2835.c                          |    1 -
 drivers/spi/spi-bcm2835aux.c                       |    1 -
 drivers/spi/spi-bcm63xx-hsspi.c                    |   65 +-
 drivers/spi/spi-bcm63xx.c                          |    1 -
 drivers/spi/spi-bcmbca-hsspi.c                     |    1 -
 drivers/spi/spi-cadence-quadspi.c                  |  292 ++---
 drivers/spi/spi-cadence-xspi.c                     |   77 +-
 drivers/spi/spi-cadence.c                          |    1 -
 drivers/spi/spi-cavium-octeon.c                    |    1 -
 drivers/spi/spi-cavium-thunderx.c                  |    1 -
 drivers/spi/spi-clps711x.c                         |    1 -
 drivers/spi/spi-cs42l43.c                          |    8 +
 drivers/spi/spi-davinci.c                          |    1 -
 drivers/spi/spi-dln2.c                             |    3 -
 drivers/spi/spi-dw-bt1.c                           |  331 -----
 drivers/spi/spi-dw-core.c                          |    2 -
 drivers/spi/spi-dw-mmio.c                          |   37 +-
 drivers/spi/spi-ep93xx.c                           |    1 -
 drivers/spi/spi-falcon.c                           |    1 -
 drivers/spi/spi-fsi.c                              |    7 +-
 drivers/spi/spi-fsl-dspi.c                         |    1 -
 drivers/spi/spi-fsl-espi.c                         |    1 -
 drivers/spi/spi-fsl-lib.c                          |    1 -
 drivers/spi/spi-fsl-lpspi.c                        |   65 +-
 drivers/spi/spi-geni-qcom.c                        |  188 +--
 drivers/spi/spi-gpio.c                             |    1 -
 drivers/spi/spi-gxp.c                              |    1 -
 drivers/spi/spi-hisi-kunpeng.c                     |    1 -
 drivers/spi/spi-img-spfi.c                         |    1 -
 drivers/spi/spi-imx.c                              |  626 +++++++--
 drivers/spi/spi-ingenic.c                          |    1 -
 drivers/spi/spi-lantiq-ssc.c                       |    1 -
 drivers/spi/spi-ljca.c                             |    1 -
 drivers/spi/spi-loongson-core.c                    |    1 -
 drivers/spi/spi-lp8841-rtc.c                       |    1 -
 drivers/spi/spi-mem.c                              |   26 +-
 drivers/spi/spi-meson-spicc.c                      |    1 -
 drivers/spi/spi-meson-spifc.c                      |    1 -
 drivers/spi/spi-microchip-core-spi.c               |    3 +-
 drivers/spi/spi-mpc512x-psc.c                      |    2 -
 drivers/spi/spi-mpc52xx-psc.c                      |    2 -
 drivers/spi/spi-mpc52xx.c                          |    1 -
 drivers/spi/spi-mpfs.c                             |    1 -
 drivers/spi/spi-mt65xx.c                           |    1 -
 drivers/spi/spi-mt7621.c                           |    1 -
 drivers/spi/spi-mtk-nor.c                          |    1 -
 drivers/spi/spi-mtk-snfi.c                         |    1 -
 drivers/spi/spi-mux.c                              |    1 -
 drivers/spi/spi-mxic.c                             |    1 -
 drivers/spi/spi-npcm-fiu.c                         |    1 -
 drivers/spi/spi-npcm-pspi.c                        |    1 -
 drivers/spi/spi-nxp-fspi.c                         |    2 -
 drivers/spi/spi-nxp-xspi.c                         | 1384 ++++++++++++++++++++
 drivers/spi/spi-oc-tiny.c                          |    1 -
 drivers/spi/spi-orion.c                            |    1 -
 drivers/spi/spi-pl022.c                            |    1 -
 drivers/spi/spi-pxa2xx.c                           |    2 -
 drivers/spi/spi-qcom-qspi.c                        |    1 -
 drivers/spi/spi-qpic-snand.c                       |    5 -
 drivers/spi/spi-qup.c                              |    1 -
 drivers/spi/spi-rb4xx.c                            |    1 -
 drivers/spi/spi-realtek-rtl-snand.c                |    1 -
 drivers/spi/spi-realtek-rtl.c                      |    1 -
 drivers/spi/spi-rockchip-sfc.c                     |    1 -
 drivers/spi/spi-rockchip.c                         |    5 +-
 drivers/spi/spi-rspi.c                             |    1 -
 drivers/spi/spi-rzv2h-rspi.c                       |  279 +++-
 drivers/spi/spi-rzv2m-csi.c                        |    2 -
 drivers/spi/spi-s3c64xx.c                          |    1 -
 drivers/spi/spi-sc18is602.c                        |    2 -
 drivers/spi/spi-sg2044-nor.c                       |    1 -
 drivers/spi/spi-sh-hspi.c                          |    1 -
 drivers/spi/spi-sh-msiof.c                         |    1 -
 drivers/spi/spi-sifive.c                           |    1 -
 drivers/spi/spi-slave-mt27xx.c                     |    1 -
 drivers/spi/spi-sn-f-ospi.c                        |    1 -
 drivers/spi/spi-sprd-adi.c                         |    1 -
 drivers/spi/spi-sprd.c                             |    1 -
 drivers/spi/spi-st-ssc4.c                          |    4 +-
 drivers/spi/spi-stm32-ospi.c                       |  123 +-
 drivers/spi/spi-stm32-qspi.c                       |  127 +-
 drivers/spi/spi-stm32.c                            |  122 +-
 drivers/spi/spi-sun4i.c                            |    1 -
 drivers/spi/spi-sun6i.c                            |    1 -
 drivers/spi/spi-sunplus-sp7021.c                   |    1 -
 drivers/spi/spi-synquacer.c                        |    3 -
 drivers/spi/spi-tegra114.c                         |    1 -
 drivers/spi/spi-tegra20-sflash.c                   |    1 -
 drivers/spi/spi-tegra20-slink.c                    |    1 -
 drivers/spi/spi-tegra210-quad.c                    |    1 -
 drivers/spi/spi-ti-qspi.c                          |    1 -
 drivers/spi/spi-uniphier.c                         |    1 -
 drivers/spi/spi-virtio.c                           |    6 +-
 drivers/spi/spi-wpcm-fiu.c                         |    1 -
 drivers/spi/spi-xcomm.c                            |    1 -
 drivers/spi/spi-xilinx.c                           |   13 +-
 drivers/spi/spi-xlp.c                              |    1 -
 drivers/spi/spi-xtensa-xtfpga.c                    |    1 -
 drivers/spi/spi.c                                  |  192 ++-
 include/linux/spi/spi-mem.h                        |   14 +-
 include/linux/spi/spi.h                            |   30 +
 tools/spi/.gitignore                               |    1 +
 141 files changed, 5800 insertions(+), 1199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/faraday,ftssp010.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
 create mode 100644 Documentation/spi/multiple-data-lanes.rst
 create mode 100644 drivers/spi/spi-atcspi200.c
 create mode 100644 drivers/spi/spi-axiado.c
 create mode 100644 drivers/spi/spi-axiado.h
 delete mode 100644 drivers/spi/spi-dw-bt1.c
 create mode 100644 drivers/spi/spi-nxp-xspi.c
