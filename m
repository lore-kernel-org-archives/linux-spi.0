From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v6, 0/8] Broadcom stb, and iProc SoC QSPI driver
Date: Wed, 24 Aug 2016 18:04:21 -0400
Message-ID: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, bcm-kernel-feedback-list@broadcom.com,
 jon.mason@broadcom.com
To: broonie@kernel.org, linux-spi@vger.kernel.org, computersforpeace@gmail.com,
 linux-mtd@lists.infradead.org, vigneshr@ti.com, f.fainelli@gmail.com,
 yendapally.reddy@broadcom.com
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is v6 changes for common spi driver for the brcmstb, nsp, ns2, cygnus
iProc SoCs. Changes include driver for standard MSPI and accelerated BSPI
blocks.The Brodcom STB uses l2-intc where as the SoC specific interrupt 
handling code has been separated in a new  driver. In case iProc SoCs it does
not have a dedicated l2 controller and the interrupts are specific to the 
spi core. The drivers are organized in the following way:
 
 drivers/spi/spi-bcm-qspi.c      - Common MSPI, BSPI driver

 drivers/spi/spi-bcm-qspi.h      - Common header 

 drivers/spi/spi-brcmstb-qspi.c  - SoC specific wth brcm,spi-brcmstb-qspi 
                                   compatibility, does not have anything 
                                   specific for stb SoC

 drivers/spi/spi-iproc-qspi.c      - Implements the interrupt hooks used by 
                                   the common driver with "brcm,spi-nsp-qspi"
                                   compatibility

V6 Changes 
----------

Bindings Documentation:
- Changed subject to spi:
- Squashed all SoCs bindings in one commit 
- Removed clock-frequency redundant parameter from main spi node

spi-bcm-qspi 
- Removed redundant transfer delays, let core handle it
- Removed chip select changes, let core handle it
- Use of named labels in probe function
- Add comments for the exported symbols for probe, remove, pm_ops
  suspend/resume, to be called by the SoC platform driver
- Remove redundant clock-frequency parsing
- Removed retry logic code from BSPI
- Use of big_endian as input parameter to the r/w inline function
- Suspend/resume uses spi core msg queue suspend and resume calls
- Other code cleanup to remove unused code

spi-brcmstb-qspi
-Separated just separated the commit

spi-iproc-qspi
- Changes name to spi-iproc-qspi
- Read the dt native endian locally and stored in soc structure
  to pass to r/w macro

mtd/devices/m25p80 
- Made a change to be able to fallback to normal spi read
  when the accelarated read function does not get aligned 
  buffers, feature used by the BSPI spi_flash_read() method

Kamal Dasu (8):
  spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings
  spi: bcm-qspi: Add Broadcom MSPI driver
  spi: brcmstb-qspi: Broadcom settop platform driver
  spi: bcm-qspi: Add BSPI spi-nor flash controller driver
  mtd: m25p80: Let m25p80_read() fallback to spi transfer
  arm: dts: Add bcm-nsp and bcm958625k support
  arm64: dts: Add ns2 SoC support
  spi: iproc-qspi: Add Broadcom iProc SoCs support

 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  |  233 ++++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   31 +-
 arch/arm/boot/dts/bcm958625k.dts                   |   34 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   34 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   18 +
 drivers/mtd/devices/m25p80.c                       |   11 +-
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm-qspi.c                         | 1400 ++++++++++++++++++++
 drivers/spi/spi-bcm-qspi.h                         |  115 ++
 drivers/spi/spi-brcmstb-qspi.c                     |   53 +
 drivers/spi/spi-iproc-qspi.c                       |  163 +++
 12 files changed, 2100 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
 create mode 100644 drivers/spi/spi-bcm-qspi.c
 create mode 100644 drivers/spi/spi-bcm-qspi.h
 create mode 100644 drivers/spi/spi-brcmstb-qspi.c
 create mode 100644 drivers/spi/spi-iproc-qspi.c

-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
