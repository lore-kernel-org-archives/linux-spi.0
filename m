From: Andi Shyti <andi.shyti@samsung.com>
Subject: [PATCH 4/5] spi: s3c64xx: do not configure the device twice
Date: Fri, 17 Jun 2016 16:57:24 +0900
Message-ID: <1466150245-2648-5-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-kernel@vger.kernel.org,
 Andi Shyti <andi.shyti@samsung.com>, linux-spi@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
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

At the start of the transfer, the spi_config function is called
twice, the first time when the 3c64xx_spi_prepare_message is
called and the second time with the s3c64xx_spi_transfer_one,
both called from the spi framework.

Remove the call from the prepare message as at that point we
don't have the imformation about "bit per word" and frequency.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 3d54c5f..a98930a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -676,16 +676,6 @@ static int s3c64xx_spi_prepare_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 
-	/* If Master's(controller) state differs from that needed by Slave */
-	if (sdd->cur_speed != spi->max_speed_hz
-			|| sdd->cur_mode != spi->mode
-			|| sdd->cur_bpw != spi->bits_per_word) {
-		sdd->cur_bpw = spi->bits_per_word;
-		sdd->cur_speed = spi->max_speed_hz;
-		sdd->cur_mode = spi->mode;
-		s3c64xx_spi_config(sdd);
-	}
-
 	/* Configure feedback delay */
 	writel(cs->fb_delay & 0x3, sdd->regs + S3C64XX_SPI_FB_CLK);
 
@@ -712,6 +702,7 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	if (bpw != sdd->cur_bpw || speed != sdd->cur_speed) {
 		sdd->cur_bpw = bpw;
 		sdd->cur_speed = speed;
+		sdd->cur_mode = spi->mode;
 		s3c64xx_spi_config(sdd);
 	}
 
-- 
2.8.1
