From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 0/3] spi/xilinx: Merge OF and non-OF drivers
Date: Thu, 14 Oct 2010 10:19:54 -0600
Message-ID: <20101014161724.18966.42340.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net,
	richard.rojfors@mocean-labs.com, john.linn@xilinx.com,
	monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since of_platform_bus_type has been merged with the platform_bus_type,
a single platform driver can now support both use cases.  This patch
series merges the two halves of the xilinx_spi device driver.

Compile tested only.  I haven't booted this yet.

---

Grant Likely (3):
      spi/xilinx: Eliminate pdata references from common code.
      spi/xilinx: fold platform_driver support into main body
      spi/xilinx: merge OF support code into main driver


 drivers/spi/Kconfig            |   14 ----
 drivers/spi/Makefile           |    2 -
 drivers/spi/xilinx_spi.c       |  133 ++++++++++++++++++++++++++++++++++------
 drivers/spi/xilinx_spi.h       |   32 ----------
 drivers/spi/xilinx_spi_of.c    |  133 ----------------------------------------
 drivers/spi/xilinx_spi_pltfm.c |  102 -------------------------------
 6 files changed, 114 insertions(+), 302 deletions(-)
 delete mode 100644 drivers/spi/xilinx_spi.h
 delete mode 100644 drivers/spi/xilinx_spi_of.c
 delete mode 100644 drivers/spi/xilinx_spi_pltfm.c
