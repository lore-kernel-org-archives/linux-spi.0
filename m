From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 0/8]  Broadcom stb, nsp, ns2, cygnus QSPI driver
Date: Fri, 29 Jul 2016 18:12:13 -0400
Message-ID: <1469830341-13244-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org,
	f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is V5 changes for common spi driver for the brcmstb, nsp, ns2, cygnus
SoCs. Changes include driver for  standard MSPI and accelerated BSPI blocks.
The Brodcom STB uses l2-intc where as the SoC specific interrupt handling
code has been separated in a new  driver. In case of NS and NS2 SoCs it does
not have a dedicated l2 controller and the interrupts are specific to the 
spi core. The drivers are organized in the follwoing way:
 
 drivers/spi/spi-bcm-qspi.c      - Common MSPI, BSPI driver

 drivers/spi/spi-bcm-qspi.h      - Common header 

 drivers/spi/spi-brcmstb-qspi.c  - SoC specific wth brcm,spi-brcmstb-qspi 
                                   compatibility, does not have anything 
                                   specific for stb SoC

 drivers/spi/spi-nsp-qspi.c      - Implements the interrupt hooks used by 
                                   the common driver with "brcm,spi-nsp-qspi"
                                   compatibility
Changes in V5:
 - Added additional description in the binding documentation non MSPI and BSPI SoC IP
 - Split commits for MSPI spi driver and accelarated BSPI driver used for accelerated
   flash reads
 - Removed any parsing of transfer structures for commands
 - Other code cleanup for readability
 - Kept the interrupt handling code in separate driver, since hardware abstraction and l2
   controller driver in software do not exisit certain SoCs

Kamal Dasu (8):
  Documentation: dt: spi: Add BRCMSTB SoC bindings
  spi: bcm-qspi: Add Broadcom MSPI driver
  spi: bcm-qspi: Add BSPI spi-nor flash controller driver
  mtd: m25p80: Let m25p80_read() fallback to spi transfer
  Documentation: dt: spi: Add Broadcom NSP, NS2 SoC bindings
  arm: dts: Add bcm-nsp and bcm958625k support
  arm64: dts: Add ns2 SoC support
  spi: nsp-qspi: Add Broadcom NSP, NS2, Cygnus SoC support

 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt  |  235 ++++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   33 +-
 arch/arm/boot/dts/bcm958625k.dts                   |   34 +
 arch/arm64/boot/dts/broadcom/ns2-svk.dts           |   34 +-
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   19 +
 drivers/mtd/devices/m25p80.c                       |    7 +-
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm-qspi.c                         | 1440 ++++++++++++++++++++
 drivers/spi/spi-bcm-qspi.h                         |  112 ++
 drivers/spi/spi-brcmstb-qspi.c                     |   53 +
 drivers/spi/spi-nsp-qspi.c                         |  158 +++
 12 files changed, 2126 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
 create mode 100644 drivers/spi/spi-bcm-qspi.c
 create mode 100644 drivers/spi/spi-bcm-qspi.h
 create mode 100644 drivers/spi/spi-brcmstb-qspi.c
 create mode 100644 drivers/spi/spi-nsp-qspi.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
