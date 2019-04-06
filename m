From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS
Date: Sat, 6 Apr 2019 23:14:57 +0800
Message-ID: <20190406151457.32104-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
To: <broonie@kernel.org>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
 <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <eric@anholt.net>, <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building CONFIG_DEBUG_FS is not set
gcc warn this:

drivers/spi/spi-bcm2835aux.c: In function bcm2835aux_spi_probe:
drivers/spi/spi-bcm2835aux.c:591:2: error: too many arguments to function bcm2835aux_debugfs_create
  bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
  ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/spi-bcm2835aux.c:145:13: note: declared here
 static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8048d151eb4d ("spi: bcm2835aux: add driver stats to debugfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-bcm2835aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index fd8252d..bbf87ad 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -142,7 +142,8 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
 	bs->debugfs_dir = NULL;
 }
 #else
-static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
 {
 }
 
-- 
2.7.4
