From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2] spi: cadence: Remove Kconfig dependency
Date: Mon,  9 Mar 2015 09:46:15 +0100
Message-ID: <6202725ab40c7bb26e8650f904bba68b8996f07c.1425890773.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Remove Kconfig dependency and enable driver for
all ARCHs.
Also update help description.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v2:
- Remove ARM and ARM64 in Kconfig

Test for all archs done by Kbuild test robot without any problem.
---
 drivers/spi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbef6f1b..0c008162d0af 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -159,10 +159,9 @@ config SPI_BUTTERFLY
=20
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
-	depends on ARM
 	help
 	  This selects the Cadence SPI controller master driver
-	  used by Xilinx Zynq.
+	  used by Xilinx Zynq and ZynqMP.
=20
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
--=20
1.8.2.3
