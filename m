From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 3/3] spi: s3c24xx: Convert spinlock to mutex
Date: Tue,  4 Aug 2015 14:09:58 +0800
Message-ID: <1438668598-6678-3-git-send-email-drinkcat@chromium.org>
References: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Cc: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438668598-6678-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

bitbang->lock is now a mutex: replace spinlock function calls
by mutex functions.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/spi/spi-s3c24xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index f36bc32..b1d03e5 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -198,12 +198,11 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	spin_lock(&hw->bitbang.lock);
-	if (!hw->bitbang.busy) {
+	if (mutex_trylock(&hw->bitbang.lock)) {
 		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
 		/* need to ndelay for 0.5 clocktick ? */
+		mutex_unlock(&hw->bitbang.lock);
 	}
-	spin_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
-- 
2.5.0.rc2.392.g76e840b
