From: Joe Perches <joe@perches.com>
Subject: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
Date: Thu, 05 Mar 2020 07:15:53 -0800
Message-ID: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: John Garry <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
controller driver") likely inadvertently used a select statement
with a CONFIG_ prefix, remove the prefix.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 82177d..2dc7bd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
 	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
 	depends on HAS_IOMEM
-	select CONFIG_MTD_SPI_NOR
+	select MTD_SPI_NOR
 	help
 	  This enables support for HiSilicon v3xx SPI-NOR flash controller
 	  found in hi16xx chipsets.
