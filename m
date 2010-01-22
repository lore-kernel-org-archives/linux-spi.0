From: Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>
Subject: [PATCH] dw_spi_mmio depends on HAVE_CLK
Date: Fri, 22 Jan 2010 07:45:39 -0500
Message-ID: <20100122124515.2619.14103.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

dw_spi_mmio is dependent on the clock framework. This marks it as such
in Kconfig.


Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 505f1c2..c1ac092 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -319,7 +319,7 @@ config SPI_DW_PCI
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE
+	depends on SPI_DESIGNWARE && HAVE_CLK
 
 #
 # There are lots of SPI device types, with sensors and memory
