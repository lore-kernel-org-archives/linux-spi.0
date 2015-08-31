From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] spi updates for v4.3
Date: Mon, 31 Aug 2015 15:03:06 +0100
Message-ID: <20150831140306.GM12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kpAq596eOR9Dleuo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kpAq596eOR9Dleuo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit c13dcf9f2d6f5f06ef1bf79ec456df614c5e058b:

  Linux 4.2-rc8 (2015-08-23 20:52:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E3

for you to fetch changes up to c5992f610f78e6c9d0a78e8fef1066ad640e17e8:

  Merge remote-tracking branches 'spi/topic/ti-qspi', 'spi/topic/xcomm' and=
 'spi/topic/xlp' into spi-next (2015-08-31 14:45:45 +0100)

----------------------------------------------------------------
spi: Updates for v4.3

A few core tweaks this time together with the usual collection of driver
specific updates and fixes plus a larger than average selection of new
device support:

 - Fix DMA mapping of unaligned vmalloc() buffers.
 - Statistics tracking transfer volumes exposed via sysfs.
 - New drivers for Freescale MPC5125, Intel Sunrise Point, Mediatek SoCs,
   and Netlogic XLP SoCs.

----------------------------------------------------------------
Alexandre Belloni (1):
      spi: atmel: remove useless include

Alexey Klimov (2):
      spi/s3c24xx: remove unnecessary memset of s3c24xx_spi
      spi/rockchip: remove unnecessary memset of rockchip_spi

Andrew Gabbasov (1):
      spi: Fix per-page mapping of unaligned vmalloc-ed buffer

Axel Lin (3):
      spi: pxa2xx: Add terminating entry for pxa2xx_spi_pci_compound_match
      spi: mt65xx: Fix module alias
      spi: fsl-(e)spi: Fix checking return value of devm_ioremap_resource

Colin Ian King (1):
      spi: spidev: fix inconsistent indenting

Fabio Estevam (1):
      spi: spidev: Fix typo

Franklin S Cooper Jr (3):
      spi: davinci: Set prescale value based on register value
      spi: davinci: Choose correct pre-scaler limit based on SOC
      ARM: davinci: Set proper SPI prescale limit value

Geert Uytterhoeven (3):
      spi: rspi: Drop variable "error" in qspi_trigger_transfer_out_in()
      spi: rspi: Make qspi_set_send_trigger() return "unsigned int"
      spi: sh-msiof: Remove obsolete spi_r8a779x_msiof platform_device_id e=
ntries

Heiner Kallweit (3):
      spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup
      spi: fsl-(e)spi: simplify cleanup code
      spi: fsl-espi: add runtime PM

Jarkko Nikula (3):
      spi: pxa2xx: Add support for Intel Sunrisepoint
      spi: spi-pxa2xx: Remove unused legacy PXA DMA API channel numbers
      spi: spi-pxa2xx: Remove unused legacy null dma buffer and allocation =
for it

Javier Martinez Canillas (1):
      spi: xcomm: Export I2C module alias information

Jonas Gorski (1):
      spi/bcm63xx-hsspi: add support for dual spi read/write

Kamlakant Patel (2):
      spi/xlp: SPI controller driver for Netlogic XLP SoCs
      spi: Add DT bindings documentation for Netlogic XLP SPI controller

Koji Matsuoka (1):
      spi: sh-msiof: Fix FIFO size to 64 word from 256 word

Krzysztof Kozlowski (1):
      spi: xcomm: Drop owner assignment from i2c_driver

Lars Persson (1):
      spi: Fix regression in spi-bitbang-txrx.h

Leilk Liu (14):
      spi: support spi without dma channel to use can_dma()
      spi: Mediatek: Document devicetree bindings for spi bus
      spi: mediatek: Add spi bus for Mediatek MT8173
      spi: mediatek: fix endian warnings
      spi: Mediatek: fixup cpu_to_le32 incorrect usage
      spi: mediatek: remove redundant clock in prepare_hardware/unprepare_h=
ardware
      spi: mediatek: fix spi incorrect endian usage
      spi: medaitek: revise quirks compatibility style
      spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET
      spi: mediatek: add linux/io.h include file
      spi: mediatek: replace int with u32, delete TAB and define MTK_SPI_PA=
USE_INT_STATUS marco
      spi: mediatek: add PM clk_prepare_enable fail flow
      spi: mediatek: replace *_time name
      spi: mediatek: fix SPI_CMD_PAUSE_IE macro error

Mark Brown (10):
      Merge remote-tracking branch 'spi/fix/bcm2835' into spi-fix-bcm2835
      spi: Fall back to master maximum speed if no slave speed specified
      Merge remote-tracking branches 'spi/fix/bcm2835', 'spi/fix/bitbang', =
'spi/fix/img-spfi', 'spi/fix/omap2-mcspi', 'spi/fix/orion' and 'spi/fix/xil=
inx' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/dma' into spi-next
      Merge remote-tracking branches 'spi/topic/atmel', 'spi/topic/bcm2835'=
, 'spi/topic/bcm63xx-hsspi' and 'spi/topic/davinci' into spi-next
      Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/fsl-espi', =
'spi/topic/img-spfi' and 'spi/topic/mpc512x-psc' into spi-next
      Merge remote-tracking branches 'spi/topic/mtk', 'spi/topic/pxa2xx', '=
spi/topic/qspi', 'spi/topic/rockchip' and 'spi/topic/s3c24xx' into spi-next
      Merge remote-tracking branches 'spi/topic/s3c64xx', 'spi/topic/sg', '=
spi/topic/sh-msiof', 'spi/topic/spidev' and 'spi/topic/stats' into spi-next
      Merge remote-tracking branches 'spi/topic/ti-qspi', 'spi/topic/xcomm'=
 and 'spi/topic/xlp' into spi-next

Martin Sperl (5):
      spi: expose spi_master and spi_device statistics via sysfs
      spi: bcm2835: fix overflow in calculation of transfer time
      spi: bcm2835: set up spi-mode before asserting cs-gpio
      spi: bcm2835: fix overflow in calculation of transfer time
      spi: bcm2835: set up spi-mode before asserting cs-gpio

Michael van der Westhuizen (2):
      dt: snps,dw-apb-ssi: Document new I/O data register width property
      spi: dw: Allow interface drivers to limit data I/O to word sizes

Michal Suchanek (1):
      spi: s3c64xx: print fifo size on probe.

Nadav Haklai (1):
      spi: orion: On a38x, implement "50MHZ SPI AC timing" Erratum No. FE-9=
144572

Ricardo Ribalda Delgado (2):
      spi/spi-xilinx: Fix mixed poll/irq mode
      spi/spi-xilinx: Fix spurious IRQ ACK on irq mode

Sebastian Reichel (1):
      spi: omap2-mcspi: add runtime PM to set_cs()

Sifan Naeem (4):
      spi: img-spfi: check for max speed supported by the spfi block
      spi: img-spfi: check for timeout error before proceeding
      spi: img-spfi: fix multiple calls to request gpio
      spi: img-spfi: fix kbuild test robot warning

Stefan Br=FCns (1):
      spi: check bits_per_word in spi_setup

Stephen Boyd (1):
      spi: spi-pxa2xx: Remove clk.h include

Uwe Kleine-K=F6nig (3):
      spi: mpc512x-psc: add support for Freescale MPC5125
      spi: mpc512x-psc: adapt mpc5121-psc document to reality
      spi: mpc512x-psc: fix compiler warning about uninitialized variable

Vignesh R (1):
      spi: ti-qspi: use 128 bit transfer mode where possible

kbuild test robot (1):
      spi: mediatek: mtk_spi_driver can be static

 .../bindings/powerpc/fsl/mpc5121-psc.txt           |  24 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    |   2 +
 .../devicetree/bindings/spi/spi-davinci.txt        |   2 +
 .../devicetree/bindings/spi/spi-img-spfi.txt       |   1 +
 .../devicetree/bindings/spi/spi-mt65xx.txt         |  51 ++
 Documentation/devicetree/bindings/spi/spi-xlp.txt  |  39 ++
 arch/arm/mach-davinci/devices-da8xx.c              |   2 +
 arch/arm/mach-davinci/dm355.c                      |   1 +
 arch/arm/mach-davinci/dm365.c                      |   1 +
 arch/powerpc/include/asm/mpc52xx_psc.h             |   5 +-
 drivers/spi/Kconfig                                |  20 +
 drivers/spi/Makefile                               |   2 +
 drivers/spi/spi-atmel.c                            |   1 -
 drivers/spi/spi-bcm2835.c                          |  38 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  13 +-
 drivers/spi/spi-bitbang-txrx.h                     |   4 +-
 drivers/spi/spi-davinci.c                          |  50 +-
 drivers/spi/spi-dw-mmio.c                          |   3 +
 drivers/spi/spi-dw.c                               |   4 +-
 drivers/spi/spi-dw.h                               |  35 +
 drivers/spi/spi-fsl-espi.c                         |  89 ++-
 drivers/spi/spi-fsl-lib.c                          |  19 -
 drivers/spi/spi-fsl-lib.h                          |   3 -
 drivers/spi/spi-fsl-spi.c                          |  43 +-
 drivers/spi/spi-img-spfi.c                         |  73 ++-
 drivers/spi/spi-mpc512x-psc.c                      |  70 +-
 drivers/spi/spi-mt65xx.c                           | 726 +++++++++++++++++=
++++
 drivers/spi/spi-omap2-mcspi.c                      |  10 +
 drivers/spi/spi-orion.c                            |  54 +-
 drivers/spi/spi-pxa2xx-pci.c                       |   1 -
 drivers/spi/spi-pxa2xx.c                           |  66 +-
 drivers/spi/spi-pxa2xx.h                           |   5 -
 drivers/spi/spi-rockchip.c                         |   1 -
 drivers/spi/spi-rspi.c                             |  19 +-
 drivers/spi/spi-s3c24xx.c                          |   1 -
 drivers/spi/spi-s3c64xx.c                          |   4 +-
 drivers/spi/spi-sh-msiof.c                         |  20 +-
 drivers/spi/spi-ti-qspi.c                          |  34 +-
 drivers/spi/spi-xcomm.c                            |   2 +-
 drivers/spi/spi-xilinx.c                           |  20 +-
 drivers/spi/spi-xlp.c                              | 456 +++++++++++++
 drivers/spi/spi.c                                  | 235 ++++++-
 drivers/spi/spidev.c                               |   8 +-
 include/linux/platform_data/spi-davinci.h          |   1 +
 include/linux/platform_data/spi-mt65xx.h           |  20 +
 include/linux/pxa2xx_ssp.h                         |   1 +
 include/linux/spi/spi.h                            |  64 ++
 47 files changed, 2116 insertions(+), 227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xlp.txt
 create mode 100644 drivers/spi/spi-mt65xx.c
 create mode 100644 drivers/spi/spi-xlp.c
 create mode 100644 include/linux/platform_data/spi-mt65xx.h

--kpAq596eOR9Dleuo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5F6ZAAoJECTWi3JdVIfQCh4H/2pSa0jUFdiV5irqevVcrHZr
2vRphlrLMni949d1RzojglBVuvdrn6h0UIIbki3z2v4JdZ1gaK27u3Stu11h7TYb
JwXceiKcpzXxtGU0UcF9ILpYCExLUn5S4chr7R3sjz9u88pJ0Orzn97tmauJIwND
bnhf8c9LQSbZ0wswa4kCJ8KpLsdnPU8PdNABDHvYIo/HPvHboIw/YHq2GuIceJ+g
RUNTNjYjtpLOVIvFrgdKmasrFTpXHAuplHttCUhIS+rnZ1tI4IE7Y8kmhQOTWDCJ
W9JxlC5JglqXgKvk+1oeRvsZheauiDPWL6r/L0As6zlv8BJHFQHBLzMkhdl4l+U=
=FYfz
-----END PGP SIGNATURE-----

--kpAq596eOR9Dleuo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
