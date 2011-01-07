From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] (updated) spi changes for 2.6.38
Date: Fri, 7 Jan 2011 13:49:50 -0700
Message-ID: <AANLkTi=JRPpgyYnv1+mnY_VBYM=z74dpzngOPOLTEOAz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Added one more patch from Russell to get omap DMA working.

Thanks,
g.


The following changes since commit 01539ba2a706ab7d35fc0667dff919ade7f8=
7d63:

  Merge branch 'omap-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
(2011-01-06 19:13:58 -0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-spi

Brian Niebuhr (42):
      spi: davinci: fix checkpatch errors
      spi: davinci: whitespace cleanup
      spi: davinci: remove unused variable 'pdata'
      spi: davinci: set chip-select mode in SPIDEF only once
      spi: davinci: enable both activation and deactivation of chip-sel=
ects
      spi: davinci: remove unnecessary data transmit on CS disable
      spi: davinci: enable GPIO lines to be used as chip selects
      spi: davinci: simplify prescalar calculation
      spi: davinci: remove 'wait_enable' platform data member
      spi: davinci: make chip-slect specific parameters really
chip-select specific
      spi: davinci: consolidate setup of SPIFMTn in one function
      spi: davinci: setup chip-select timers values only if timer enabl=
ed
      spi: davinci: add support for wait enable timeouts
      spi: davinci: remove unused members of davinci_spi_slave
      spi: davinci: eliminate the single member structure davinci_spi_s=
lave
      spi: davinci: eliminate unnecessary update of davinci_spi->count
      spi: davinci: simplify calculation of edma acount value
      spi: davinci: check for NULL buffer pointer before using it
      spi: davinci: remove unnecessary disable of SPI
      spi: davinci: remove unnecessary 'count' variable in driver priva=
te data
      spi: davinci: remove unnecessary completion variable initializati=
on
      spi: davinci: remove non-useful interrupt mode support
      spi: davinci: simplify poll mode transfers
      spi: davinci: add support for interrupt mode
      spi: davinci: configure the invariable bits in spipc0 only once
      spi: davinci: remove unnecessary function davinci_spi_bufs_prep()
      spi: davinci: remove unnecessary call to davinci_spi_setup_transf=
er()
      spi: davinci: do not store DMA channel information per chip selec=
t
      spi: davinci: always start transmit DMA
      spi: davinci: do not use temporary buffer if no transmit data pro=
vided
      spi: davinci: always start receive DMA
      spi: davinci: use edma_write_slot() to setup EDMA PaRAM slot
      spi: davinci: fix DMA event generation stoppage
      spi: davinci: fix EDMA CC errors at end of transfers
      spi: davinci: handle DMA completion errors correctly
      spi: davinci: remove usage of additional completion variables for=
 DMA
      spi: davinci: let DMA operation be specified on per-device basis
      spi: davinci: remove non-useful "clk_internal" platform data
      spi: davinci: enable and power-up SPI only when required
      spi: davinci: setup the driver owner
      spi: davinci: add additional comments
      spi: davinci: add EF Johnson Technologies copyright

=46eng Tang (3):
      spi/dw_spi: Fix too short timeout in spi polling loop
      spi/dw_spi: change to EXPORT_SYMBOL_GPL for exported APIs
      spi/dw_spi: add DMA support

Grant Likely (6):
      spi/xilinx: Eliminate pdata references from common code.
      spi/xilinx: fold platform_driver support into main body
      spi/xilinx: merge OF support code into main driver
      Merge commit 'v2.6.37-rc7' into spi/next
      Merge branch 'for-grant' of
git://arago-project.org/git/projects/linux-davinci into spi/next
      Merge branch 'spi' of git://git.linutronix.de/users/bigeasy/soda
into spi/next

Joe Perches (1):
      drivers/spi: Remove unnecessary semicolons

Justin P. Mattock (2):
      spi/dw_spi Typo change diable to disable.
      spi/topcliff: Typo fix threhold to threshold

Linus Walleij (4):
      spi/pl022: map the buffers on the DMA engine
      spi/pl022: pass the returned sglen to the DMA engine
      spi/pl022: convert busy flag to a bool
      spi/pl022: convert running variable

Mingkai Hu (1):
      spi/fsl_espi: change the read behaviour of the SPIRF

Richard Genoud (1):
      spi/imx: correct the test on platform_get_irq() return value

Russell King - ARM Linux (1):
      spi/omap: Fix DMA API usage in OMAP MCSPI driver

Sebastian Andrzej Siewior (9):
      spi/pxa2xx: register driver properly
      spi/pxa2xx: add support for shared IRQ handler
      spi/pxa2xx: Use define for SSSR_TFL_MASK instead of plain numbers
      arm/pxa2xx: reorgazine SSP and SPI header files
      spi/pxa2xx: Add CE4100 support
      spi/pxa2xx: Consider CE4100's FIFO depth
      spi/pxa2xx: Add chipselect support for Sodaville
      spi/pxa2xx: Modify RX-Tresh instead of busy-loop for the
remaining RX bytes.
      spi/pxa2xx: pass of_node to spi device and set a parent device

Sekhar Nori (7):
      spi: davinci: removed unused #defines
      spi: davinci: remove unnecessary typecast
      spi: davinci: do not treat Tx interrupt being set as error
      spi: davinci: do not allocate DMA channels during SPI device setu=
p
      spi: davinci: remove unnecessary private data member 'region_size=
'
      spi: davinci: shorten variable names
      spi: davinci: kconfig: add manufacturer name to prompt string

Tomoya MORINAGA (1):
      spi/topcliff_pch: Fix data transfer issue

Uwe Kleine-K=F6nig (1):
      spi/imx: remove autodetection

Wolfram Sang (1):
      spi/mpc52xx-psc-spi: move probe/remove to proper sections

 Documentation/spi/pxa2xx                           |    4 +-
 arch/arm/mach-davinci/dm355.c                      |    7 +-
 arch/arm/mach-davinci/dm365.c                      |    6 -
 arch/arm/mach-davinci/include/mach/spi.h           |   52 +-
 arch/arm/mach-pxa/cm-x255.c                        |    2 +-
 arch/arm/mach-pxa/cm-x270.c                        |    2 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/icontrol.c                       |    2 +-
 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h        |   47 -
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/lubbock.c                        |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                          |    3 +-
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    1 -
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-pxa/zeus.c                           |    2 +-
 arch/arm/plat-pxa/ssp.c                            |    2 +-
 drivers/spi/Kconfig                                |   38 +-
 drivers/spi/Makefile                               |    6 +-
 drivers/spi/amba-pl022.c                           |   56 +-
 drivers/spi/davinci_spi.c                          | 1314 ++++++++----=
--------
 drivers/spi/dw_spi.c                               |   52 +-
 drivers/spi/dw_spi_mid.c                           |  223 ++++
 drivers/spi/dw_spi_pci.c                           |   20 +-
 drivers/spi/mpc52xx_psc_spi.c                      |   35 +-
 drivers/spi/omap2_mcspi.c                          |   11 +-
 drivers/spi/pxa2xx_spi.c                           |  190 ++-
 drivers/spi/pxa2xx_spi_pci.c                       |  201 +++
 drivers/spi/spi_fsl_espi.c                         |   19 +-
 drivers/spi/spi_imx.c                              |   32 +-
 drivers/spi/spi_nuc900.c                           |    2 +-
 drivers/spi/spi_topcliff_pch.c                     |   12 +-
 drivers/spi/xilinx_spi.c                           |  133 ++-
 drivers/spi/xilinx_spi.h                           |   32 -
 drivers/spi/xilinx_spi_of.c                        |  133 --
 drivers/spi/xilinx_spi_pltfm.c                     |  102 --
 .../plat/ssp.h =3D> include/linux/pxa2xx_ssp.h       |   39 +-
 include/linux/spi/dw_spi.h                         |   24 +-
 include/linux/spi/pxa2xx_spi.h                     |  152 +++
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 46 files changed, 1612 insertions(+), 1368 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
 create mode 100644 drivers/spi/dw_spi_mid.c
 create mode 100644 drivers/spi/pxa2xx_spi_pci.c
 delete mode 100644 drivers/spi/xilinx_spi.h
 delete mode 100644 drivers/spi/xilinx_spi_of.c
 delete mode 100644 drivers/spi/xilinx_spi_pltfm.c
 rename arch/arm/plat-pxa/include/plat/ssp.h =3D> include/linux/pxa2xx_=
ssp.h (90%)
 create mode 100644 include/linux/spi/pxa2xx_spi.h


2011/1/7 Grant Likely <grant.likely@secretlab.ca>:
> Hi Linus,
>
> Here are the spi subsystem changes to be merged for 2.6.38
>
> Thanks,
> g.
>
> The following changes since commit 3c0cb7c31c206aaedb967e44b98442bbeb=
17a6c4:
>
> =A0Merge branch 'devel' of master.kernel.org:/home/rmk/linux-2.6-arm
> (2011-01-06 16:50:35 -0800)
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 next-spi
>
> Brian Niebuhr (42):
> =A0 =A0 =A0spi: davinci: fix checkpatch errors
> =A0 =A0 =A0spi: davinci: whitespace cleanup
> =A0 =A0 =A0spi: davinci: remove unused variable 'pdata'
> =A0 =A0 =A0spi: davinci: set chip-select mode in SPIDEF only once
> =A0 =A0 =A0spi: davinci: enable both activation and deactivation of c=
hip-selects
> =A0 =A0 =A0spi: davinci: remove unnecessary data transmit on CS disab=
le
> =A0 =A0 =A0spi: davinci: enable GPIO lines to be used as chip selects
> =A0 =A0 =A0spi: davinci: simplify prescalar calculation
> =A0 =A0 =A0spi: davinci: remove 'wait_enable' platform data member
> =A0 =A0 =A0spi: davinci: make chip-slect specific parameters really
> chip-select specific
> =A0 =A0 =A0spi: davinci: consolidate setup of SPIFMTn in one function
> =A0 =A0 =A0spi: davinci: setup chip-select timers values only if time=
r enabled
> =A0 =A0 =A0spi: davinci: add support for wait enable timeouts
> =A0 =A0 =A0spi: davinci: remove unused members of davinci_spi_slave
> =A0 =A0 =A0spi: davinci: eliminate the single member structure davinc=
i_spi_slave
> =A0 =A0 =A0spi: davinci: eliminate unnecessary update of davinci_spi-=
>count
> =A0 =A0 =A0spi: davinci: simplify calculation of edma acount value
> =A0 =A0 =A0spi: davinci: check for NULL buffer pointer before using i=
t
> =A0 =A0 =A0spi: davinci: remove unnecessary disable of SPI
> =A0 =A0 =A0spi: davinci: remove unnecessary 'count' variable in drive=
r private data
> =A0 =A0 =A0spi: davinci: remove unnecessary completion variable initi=
alization
> =A0 =A0 =A0spi: davinci: remove non-useful interrupt mode support
> =A0 =A0 =A0spi: davinci: simplify poll mode transfers
> =A0 =A0 =A0spi: davinci: add support for interrupt mode
> =A0 =A0 =A0spi: davinci: configure the invariable bits in spipc0 only=
 once
> =A0 =A0 =A0spi: davinci: remove unnecessary function davinci_spi_bufs=
_prep()
> =A0 =A0 =A0spi: davinci: remove unnecessary call to davinci_spi_setup=
_transfer()
> =A0 =A0 =A0spi: davinci: do not store DMA channel information per chi=
p select
> =A0 =A0 =A0spi: davinci: always start transmit DMA
> =A0 =A0 =A0spi: davinci: do not use temporary buffer if no transmit d=
ata provided
> =A0 =A0 =A0spi: davinci: always start receive DMA
> =A0 =A0 =A0spi: davinci: use edma_write_slot() to setup EDMA PaRAM sl=
ot
> =A0 =A0 =A0spi: davinci: fix DMA event generation stoppage
> =A0 =A0 =A0spi: davinci: fix EDMA CC errors at end of transfers
> =A0 =A0 =A0spi: davinci: handle DMA completion errors correctly
> =A0 =A0 =A0spi: davinci: remove usage of additional completion variab=
les for DMA
> =A0 =A0 =A0spi: davinci: let DMA operation be specified on per-device=
 basis
> =A0 =A0 =A0spi: davinci: remove non-useful "clk_internal" platform da=
ta
> =A0 =A0 =A0spi: davinci: enable and power-up SPI only when required
> =A0 =A0 =A0spi: davinci: setup the driver owner
> =A0 =A0 =A0spi: davinci: add additional comments
> =A0 =A0 =A0spi: davinci: add EF Johnson Technologies copyright
>
> Feng Tang (3):
> =A0 =A0 =A0spi/dw_spi: Fix too short timeout in spi polling loop
> =A0 =A0 =A0spi/dw_spi: change to EXPORT_SYMBOL_GPL for exported APIs
> =A0 =A0 =A0spi/dw_spi: add DMA support
>
> Grant Likely (6):
> =A0 =A0 =A0spi/xilinx: Eliminate pdata references from common code.
> =A0 =A0 =A0spi/xilinx: fold platform_driver support into main body
> =A0 =A0 =A0spi/xilinx: merge OF support code into main driver
> =A0 =A0 =A0Merge commit 'v2.6.37-rc7' into spi/next
> =A0 =A0 =A0Merge branch 'for-grant' of
> git://arago-project.org/git/projects/linux-davinci into spi/next
> =A0 =A0 =A0Merge branch 'spi' of git://git.linutronix.de/users/bigeas=
y/soda
> into spi/next
>
> Joe Perches (1):
> =A0 =A0 =A0drivers/spi: Remove unnecessary semicolons
>
> Justin P. Mattock (2):
> =A0 =A0 =A0spi/dw_spi Typo change diable to disable.
> =A0 =A0 =A0spi/topcliff: Typo fix threhold to threshold
>
> Linus Walleij (4):
> =A0 =A0 =A0spi/pl022: map the buffers on the DMA engine
> =A0 =A0 =A0spi/pl022: pass the returned sglen to the DMA engine
> =A0 =A0 =A0spi/pl022: convert busy flag to a bool
> =A0 =A0 =A0spi/pl022: convert running variable
>
> Mingkai Hu (1):
> =A0 =A0 =A0spi/fsl_espi: change the read behaviour of the SPIRF
>
> Richard Genoud (1):
> =A0 =A0 =A0spi/imx: correct the test on platform_get_irq() return val=
ue
>
> Sebastian Andrzej Siewior (9):
> =A0 =A0 =A0spi/pxa2xx: register driver properly
> =A0 =A0 =A0spi/pxa2xx: add support for shared IRQ handler
> =A0 =A0 =A0spi/pxa2xx: Use define for SSSR_TFL_MASK instead of plain =
numbers
> =A0 =A0 =A0arm/pxa2xx: reorgazine SSP and SPI header files
> =A0 =A0 =A0spi/pxa2xx: Add CE4100 support
> =A0 =A0 =A0spi/pxa2xx: Consider CE4100's FIFO depth
> =A0 =A0 =A0spi/pxa2xx: Add chipselect support for Sodaville
> =A0 =A0 =A0spi/pxa2xx: Modify RX-Tresh instead of busy-loop for the
> remaining RX bytes.
> =A0 =A0 =A0spi/pxa2xx: pass of_node to spi device and set a parent de=
vice
>
> Sekhar Nori (7):
> =A0 =A0 =A0spi: davinci: removed unused #defines
> =A0 =A0 =A0spi: davinci: remove unnecessary typecast
> =A0 =A0 =A0spi: davinci: do not treat Tx interrupt being set as error
> =A0 =A0 =A0spi: davinci: do not allocate DMA channels during SPI devi=
ce setup
> =A0 =A0 =A0spi: davinci: remove unnecessary private data member 'regi=
on_size'
> =A0 =A0 =A0spi: davinci: shorten variable names
> =A0 =A0 =A0spi: davinci: kconfig: add manufacturer name to prompt str=
ing
>
> Tomoya MORINAGA (1):
> =A0 =A0 =A0spi/topcliff_pch: Fix data transfer issue
>
> Uwe Kleine-K=F6nig (1):
> =A0 =A0 =A0spi/imx: remove autodetection
>
> Wolfram Sang (1):
> =A0 =A0 =A0spi/mpc52xx-psc-spi: move probe/remove to proper sections
>
> =A0Documentation/spi/pxa2xx =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A04 +-
> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A07 +-
> =A0arch/arm/mach-davinci/dm365.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A06 -
> =A0arch/arm/mach-davinci/include/mach/spi.h =A0 =A0 =A0 =A0 =A0 | =A0=
 52 +-
> =A0arch/arm/mach-pxa/cm-x255.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/cm-x270.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/corgi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/devices.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/em-x270.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/hx4700.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/icontrol.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/include/mach/pxa2xx_spi.h =A0 =A0 =A0 =A0| =A0 4=
7 -
> =A0arch/arm/mach-pxa/littleton.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/lubbock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/pcm027.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/poodle.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/spitz.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 =A03 +-
> =A0arch/arm/mach-pxa/stargate2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-pxa/tosa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/trizeps4.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 -
> =A0arch/arm/mach-pxa/z2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-pxa/zeus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/plat-pxa/ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 38 +-
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A06 +-
> =A0drivers/spi/amba-pl022.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 56 +-
> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| 1314 ++++++++------------
> =A0drivers/spi/dw_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 52 +-
> =A0drivers/spi/dw_spi_mid.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0223 ++++
> =A0drivers/spi/dw_spi_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 20 +-
> =A0drivers/spi/mpc52xx_psc_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 35 +-
> =A0drivers/spi/pxa2xx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0190 ++-
> =A0drivers/spi/pxa2xx_spi_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0201 +++
> =A0drivers/spi/spi_fsl_espi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 19 +-
> =A0drivers/spi/spi_imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 32 +-
> =A0drivers/spi/spi_nuc900.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0drivers/spi/spi_topcliff_pch.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 12 +-
> =A0drivers/spi/xilinx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0133 ++-
> =A0drivers/spi/xilinx_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 32 -
> =A0drivers/spi/xilinx_spi_of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0133 --
> =A0drivers/spi/xilinx_spi_pltfm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0102 --
> =A0.../plat/ssp.h =3D> include/linux/pxa2xx_ssp.h =A0 =A0 =A0 | =A0 3=
9 +-
> =A0include/linux/spi/dw_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 24 +-
> =A0include/linux/spi/pxa2xx_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0152 +++
> =A0sound/soc/pxa/pxa-ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0 =A02 +-
> =A045 files changed, 1609 insertions(+), 1360 deletions(-)
> =A0delete mode 100644 arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
> =A0create mode 100644 drivers/spi/dw_spi_mid.c
> =A0create mode 100644 drivers/spi/pxa2xx_spi_pci.c
> =A0delete mode 100644 drivers/spi/xilinx_spi.h
> =A0delete mode 100644 drivers/spi/xilinx_spi_of.c
> =A0delete mode 100644 drivers/spi/xilinx_spi_pltfm.c
> =A0rename arch/arm/plat-pxa/include/plat/ssp.h =3D> include/linux/pxa=
2xx_ssp.h (90%)
> =A0create mode 100644 include/linux/spi/pxa2xx_spi.h
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
