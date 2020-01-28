From: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 0/2] spi: cadence-xspi: Add support for Cadence XSPI controller
Date: Tue, 28 Jan 2020 13:40:29 +0100
Message-ID: <20200128124042.11469-1-konrad@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Driver for Cadence xSPI flash controller.

Command processing
Driver uses STIG work mode to communicate with flash memories.
In this mode, controller sends low-level instructions to memory.
Each instruction is 128-bit width. There is special instruction
DataSequence which carries information about data phase.
Driver uses Slave DMA interface to transfer data as only this
interface can be used in STIG work mode.

PHY initialization
The initialization of PHY module in Cadence XSPI controller
is done by driving external pin-strap signals to controller.
Next, driver runs PHY training to find optimal value of
read_dqs_delay parameter. Controller checks device discovery
status and if it's completed and with no error PHY training
passes.

Changes between initial version and v2:
 - fixed device tree schema yaml file

Konrad Kociolek (2):
  Add Cadence XSPI driver
  Add dt-bindings for Cadence XSPI controller

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 ++++
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-cadence-xspi.c                     | 895 +++++++++++++++++++++
 4 files changed, 1073 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
 create mode 100644 drivers/spi/spi-cadence-xspi.c

-- 
2.15.0
