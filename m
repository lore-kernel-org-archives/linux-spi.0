From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] spi: loopback-test: Fix kfree() NULL pointer error.
Date: Tue, 20 Jun 2017 15:00:53 +0530
Message-ID: <36969f0624050d0ca6262e79bf4935698d063d84.1497950982.git.arvind.yadav.cs@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Here, rx/tx allocation can fail. So avoid kvfree call
with NULL pointer.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/spi/spi-loopback-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index f4875f1..e459d01 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -1021,10 +1021,9 @@ int spi_test_run_tests(struct spi_device *spi,
 		rx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
 	else
 		rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
-	if (!rx) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!rx)
+		return -ENOMEM;
+
 
 	if (use_vmalloc)
 		tx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
@@ -1032,7 +1031,7 @@ int spi_test_run_tests(struct spi_device *spi,
 		tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!tx) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_tx;
 	}
 
 	/* now run the individual tests in the table */
@@ -1057,8 +1056,9 @@ int spi_test_run_tests(struct spi_device *spi,
 	}
 
 out:
-	kvfree(rx);
 	kvfree(tx);
+err_tx:
+	kvfree(rx);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_test_run_tests);
-- 
1.9.1
