From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] spi: Enable Cadence SPI driver for ARM64
Date: Tue, 24 Feb 2015 08:44:01 +0100
Message-ID: <859f9c4d3fbbc5153d924d7a6e36aa3a734e1b16.1424763838.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver is used on new Xilinx ZynqMP SoC.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbef6f1b..fec97a479433 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -159,7 +159,7 @@ config SPI_BUTTERFLY
=20
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
-	depends on ARM
+	depends on ARM || ARM64
 	help
 	  This selects the Cadence SPI controller master driver
 	  used by Xilinx Zynq.
--=20
1.8.2.3
