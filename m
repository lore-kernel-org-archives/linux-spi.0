From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/2] MIPS/spi: New driver for SPI master controller for OCTEON SOCs.
Date: Fri, 11 May 2012 14:34:44 -0700
Message-ID: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
To: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: David Daney <david.daney@cavium.com>

Several members of the OCTEON family have on-chips SPI master
controller hardware, so here is a driver for it.

I split the register definitions out to a separate patch so that they
live with all the other similar files for other OCTEON hardware blocks
in arch/mips/include/asm/octeon.  This does leave the question of who
should merge these.  I don't have a preference, could be Ralf's
Linux/MIPS tree or via the SPI maintainers.

Tested by driving an at25 eeprom.

David Daney (2):
  MIPS: OCTEON: Add register definitions for SPI host hardware.
  spi: Add SPI master controller for OCTEON SOCs.

 .../devicetree/bindings/spi/spi-octeon.txt         |   33 ++
 arch/mips/include/asm/octeon/cvmx-mpi-defs.h       |  328 +++++++++++++++++
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-octeon.c                           |  369 ++++++++++++++++++++
 5 files changed, 738 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
 create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h
 create mode 100644 drivers/spi/spi-octeon.c

-- 
1.7.2.3

