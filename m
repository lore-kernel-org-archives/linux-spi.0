From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [git pull] spi and gpio patches for 2.6.39
Date: Fri, 18 Mar 2011 10:30:55 -0600
Message-ID: <AANLkTikXDaTFF0AmKOZFKDKRFd11MPc+oV5WAdZvvJsG@mail.gmail.com>
References: <AANLkTikPiwRgm0DX9CzJacMxsfhPjTU-ksZjw9m2dkEO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikPiwRgm0DX9CzJacMxsfhPjTU-ksZjw9m2dkEO@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Update to this, I just pushed out one more trivial change that moves a
header file for a driver out of include/linux.  I had forgotten about
it in another branch.

g.

On Fri, Mar 18, 2011 at 10:18 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Linus,
>
> Here are the SPI and GPIO changes I've got queued up for 2.6.39
>
> g.
>
> The following changes since commit 08351fc6a75731226e1112fc7254542bd3=
a2912e:
>
> =A0Merge git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux=
-tile
> (2011-03-17 19:34:12 -0700)
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 spi/next
>
> Axel Lin (2):
> =A0 =A0 =A0gpio: add MODULE_DEVICE_TABLE to pch_gpio and ml_ioh_gpio
> =A0 =A0 =A0gpio: Use __devexit at necessary places
>
> Bernhard Walle (1):
> =A0 =A0 =A0spi/spidev: Add 32 bit compat ioctl()
>
> Bob Liu (1):
> =A0 =A0 =A0spi/bfin_spi: support for multiples of 8bits with hardware=
 CS
>
> Dirk Eibach (1):
> =A0 =A0 =A0gpio/pca953x: Fix wrong pointer type
>
> Esben Haabendal (1):
> =A0 =A0 =A0of_mmc_spi: add card detect irq support
>
> Geert Uytterhoeven (1):
> =A0 =A0 =A0spi/rtc-{ds1390,ds3234,m41t94}: Use spi_get_drvdata() for =
SPI devices
>
> Grant Likely (4):
> =A0 =A0 =A0Merge commit 'v2.6.38-rc4' into spi/next
> =A0 =A0 =A0Merge branch 'devicetree/next' into spi/next
> =A0 =A0 =A0Merge commit 'v2.6.38-rc8' into spi/next
> =A0 =A0 =A0Merge remote-tracking branch 'origin' into spi/next
>
> Guennadi Liakhovetski (2):
> =A0 =A0 =A0spi/spi_sh_msiof: cosmetic clean-up
> =A0 =A0 =A0spi/spi_sh_msiof: consolidate data in 8-bit mode into 32-b=
it words
>
> Hannu Heikkinen (1):
> =A0 =A0 =A0spi/omap_mcspi: Off-by-one error in finding the right divi=
sor
>
> Jiri Slaby (1):
> =A0 =A0 =A0spi/dw_spi: Fix missing header
>
> Linus Walleij (4):
> =A0 =A0 =A0spi/pl022: use dmaengine helper macros
> =A0 =A0 =A0spi/pl022: disable core voltage when idle
> =A0 =A0 =A0spi/pl022: minor kerneldoc updates
> =A0 =A0 =A0spi/pl022: rid dangling labels
>
> Michael Jones (1):
> =A0 =A0 =A0spi/omap_mcspi: catch xfers of non-multiple SPI word size
>
> Michael Williamson (2):
> =A0 =A0 =A0spi/davinci: Use correct length parameter to dma_map_singl=
e calls
> =A0 =A0 =A0spi/davinci: Support DMA transfers larger than 65535 words
>
> Nikanth Karthikesan (1):
> =A0 =A0 =A0gpio/cs5535-gpio: Fix section mismatch
>
> Peter Korsgaard (1):
> =A0 =A0 =A0gpio/mcp23s08: support mcp23s17 variant
>
> Sascha Hauer (2):
> =A0 =A0 =A0spi/bitbang: check for setup_transfer during initializatio=
n
> =A0 =A0 =A0spi/imx: select master mode for all channels
>
> Sonic Zhang (1):
> =A0 =A0 =A0spi/bfin_spi: return immediately after skipping to next tr=
ansfer
>
> Thomas Chou (2):
> =A0 =A0 =A0spi: add OpenCores tiny SPI driver
> =A0 =A0 =A0spi: New driver for Altera SPI
>
> Thomas Gleixner (6):
> =A0 =A0 =A0gpio/sx150x: Do not access I2C from mask/unmask functions
> =A0 =A0 =A0gpio; Make Intel chipset gpio drivers depend on x86
> =A0 =A0 =A0gpio/langwell: Fix broken irq_eoi change.
> =A0 =A0 =A0gpio/langwell: Convert irq name space
> =A0 =A0 =A0gpio/langwell: Simplify demux loop
> =A0 =A0 =A0gpio/langwell: Clear edge bit before handling
>
> Virupax Sadashivpetimath (1):
> =A0 =A0 =A0spi/pl022: remove dangling status check
>
> Yoshihiro Shimoda (1):
> =A0 =A0 =A0spi: add support for SuperH SPI
>
> =A0.../devicetree/bindings/mmc/mmc-spi-slot.txt =A0 =A0 =A0 | =A0 =A0=
9 +-
> =A0.../devicetree/bindings/spi/spi_altera.txt =A0 =A0 =A0 =A0 | =A0 =A0=
4 +
> =A0.../devicetree/bindings/spi/spi_oc_tiny.txt =A0 =A0 =A0 =A0| =A0 1=
2 +
> =A0drivers/gpio/74x164.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/gpio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 12 +-
> =A0drivers/gpio/cs5535-gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A06 +-
> =A0drivers/gpio/langwell_gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 43 +-
> =A0drivers/gpio/mc33880.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/gpio/mcp23s08.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0| =A0191 +++++--
> =A0drivers/gpio/pca953x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 13 +-
> =A0drivers/gpio/sx150x.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 54 ++-
> =A0drivers/mmc/host/of_mmc_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 26 +-
> =A0drivers/rtc/rtc-ds1390.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0drivers/rtc/rtc-ds3234.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0drivers/rtc/rtc-m41t94.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A02 +-
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 19 +
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A03 +
> =A0drivers/spi/amba-pl022.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 73 ++--
> =A0drivers/spi/davinci_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 43 ++-
> =A0drivers/spi/omap2_mcspi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 38 +-
> =A0drivers/spi/spi_altera.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0339 ++++++++++++
> =A0drivers/spi/spi_bfin5xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0104 +++--
> =A0drivers/spi/spi_bitbang.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 13 +-
> =A0drivers/spi/spi_imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 12 +-
> =A0drivers/spi/spi_oc_tiny.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0425 +++++++++++++++
> =A0drivers/spi/spi_sh.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0543 ++++++++++++++++++++
> =A0drivers/spi/spi_sh_msiof.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0127 ++++--
> =A0drivers/spi/spidev.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 12 +
> =A0include/linux/spi/dw_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 =A01 +
> =A0include/linux/spi/mcp23s08.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 15 +-
> =A0include/linux/spi/spi_oc_tiny.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 20 +
> =A031 files changed, 1911 insertions(+), 256 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/spi/spi_alter=
a.txt
> =A0create mode 100644 Documentation/devicetree/bindings/spi/spi_oc_ti=
ny.txt
> =A0create mode 100644 drivers/spi/spi_altera.c
> =A0create mode 100644 drivers/spi/spi_oc_tiny.c
> =A0create mode 100644 drivers/spi/spi_sh.c
> =A0create mode 100644 include/linux/spi/spi_oc_tiny.h
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
