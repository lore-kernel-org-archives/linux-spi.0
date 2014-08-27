From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [Fixes: PATCH v1] spi: dw: fix kernel crash due to NULL pointer dereference
Date: Wed, 27 Aug 2014 19:26:08 +0300
Message-ID: <1409156768-28461-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<stable@vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The obvious fix after the commit d9c73bb8a3a5 "spi: dw: add support for gpio
controlled chip select". This patch fixes the issue by using locally defined
temporary variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: <stable@vger.kernel.org> # v3.16+
---
 drivers/spi/spi-dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 29f3314..670f062 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -271,7 +271,7 @@ static void giveback(struct dw_spi *dws)
 					transfer_list);
 
 	if (!last_transfer->cs_change)
-		spi_chip_sel(dws, dws->cur_msg->spi, 0);
+		spi_chip_sel(dws, msg->spi, 0);
 
 	spi_finalize_current_message(dws->master);
 }
-- 
2.1.0
