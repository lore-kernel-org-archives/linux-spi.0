From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/16] spi/s3c64xx: use correct dma_transfer_direction type
Date: Fri,  5 Oct 2012 16:55:29 +0200
Message-ID: <1349448930-23976-16-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
 linux-samsung-soc@vger.kernel.org, arm@kernel.org,
 Ben Dooks <ben-linux@fluff.org>, spi-devel-general@lists.sourceforge.net
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

There is a subtle difference between dma_transfer_direction and
dma_data_direction: the former is used by the dmaengine framework,
while the latter is used by the dma-mapping API. Although the
purpose is comparable, the actual values are different and must
not be mixed. In this case, the driver just wants to use
dma_transfer_direction.

Without this patch, building s3c6400_defconfig results in:

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_spi_dmacb':
drivers/spi/spi-s3c64xx.c:239:21: warning: comparison between
	'enum dma_data_direction' and 'enum dma_transfer_direction' [-Wenum-compare]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net
---
 drivers/spi/spi-s3c64xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d1c8441f..2e44dd6 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -132,7 +132,7 @@
 
 struct s3c64xx_spi_dma_data {
 	unsigned		ch;
-	enum dma_data_direction direction;
+	enum dma_transfer_direction direction;
 	enum dma_ch	dmach;
 	struct property		*dma_prop;
 };
-- 
1.7.10
