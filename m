From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH] spi: davinci: add comment about dummy tx buffer usage
Date: Fri, 17 Mar 2017 16:41:10 +0100
Message-ID: <1489765270-17950-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frode Isaksen <fisaksen@baylibre.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
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

Add explanation about using the the rx buffer as the
dummy tx buffer.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f37bbdd..595acdc 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -660,7 +660,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			goto err_desc;
 
 		if (!t->tx_buf) {
-			/* use rx buffer as dummy tx buffer */
+			/* To avoid errors when doing rx-only transfers with
+			 * many SG entries (> 20), use the rx buffer as the
+			 * dummy tx buffer so that dma reloads are done at the
+			 * same time for rx and tx.
+			 */
 			t->tx_sg.sgl = t->rx_sg.sgl;
 			t->tx_sg.nents = t->rx_sg.nents;
 		}
-- 
2.7.4
