From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] spi: fix NULL pointer dereferences by checking
 dmaengine_prep_slave_sg
Date: Thu, 14 Mar 2019 01:42:01 -0500
Message-ID: <20190314064202.14864-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Andi Shyti <andi@etezian.org>, pakki001@umn.edu,
 linux-arm-kernel@lists.infradead.org
To: kjlu@umn.edu
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

In case dmaengine_prep_slave_sg fails, the fix returns to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7b7151ec14c8..3a5f161ce558 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -293,6 +293,8 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
 
 	desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
 				       dma->direction, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return;
 
 	desc->callback = s3c64xx_spi_dmacb;
 	desc->callback_param = dma;
-- 
2.17.1
