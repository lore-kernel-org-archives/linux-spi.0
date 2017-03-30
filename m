From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: loopback-test: fix spelling mistake: "minimam" -> "minimum"
Date: Thu, 30 Mar 2017 11:01:25 +0100
Message-ID: <20170330100125.19703-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 51c0ceab04cc..f4875f177df0 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -533,7 +533,7 @@ static int spi_test_check_elapsed_time(struct spi_device *spi,
 	estimated_time += delay_usecs * NSEC_PER_USEC;
 	if (test->elapsed_time < estimated_time) {
 		dev_err(&spi->dev,
-			"elapsed time %lld ns is shorter than minimam estimated time %lld ns\n",
+			"elapsed time %lld ns is shorter than minimum estimated time %lld ns\n",
 			test->elapsed_time, estimated_time);
 
 		return -EINVAL;
-- 
2.11.0
