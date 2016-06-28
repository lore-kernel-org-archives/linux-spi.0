From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH v2 5/5] spi: s3c64xx: use unsigned type for fifo handling
 variables
Date: Tue, 28 Jun 2016 11:41:15 +0900
Message-ID: <1467081676-8442-6-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andi Shyti <andi.shyti@samsung.com>, linux-spi@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
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

The 'quirks' variable cannot ever be negative, therefore use u8
instead of int. The 8 bit size is given from the fact that
currently the quirks variable has very few statuses.

The rx_lvl_offset and tx_st_done store shift values, so that u8
is a proper size.

fifo_lvl_mask stores a series of masks, to be in we will keep the
32 bit size.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6d8486f..6c9503a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -150,10 +150,10 @@ struct s3c64xx_spi_dma_data {
  * which is provided as driver data to the driver.
  */
 struct s3c64xx_spi_port_config {
-	int	fifo_lvl_mask[MAX_SPI_PORTS];
-	int	rx_lvl_offset;
-	int	tx_st_done;
-	int	quirks;
+	u32	fifo_lvl_mask[MAX_SPI_PORTS];
+	u8	rx_lvl_offset;
+	u8	tx_st_done;
+	u8	quirks;
 	bool	high_speed;
 	bool	clk_from_cmu;
 };
-- 
2.8.1
