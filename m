From: P L Sai Krishna <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Mon, 21 Mar 2016 17:50:08 +0530
Message-ID: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Harini Katakam <harinik@xilinx.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 P L Sai Krishna <lakshmis@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>,
 Punnaiah Choudary Kalluri <punnaia@xilinx.com>,
 linux-arm-kernel@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann
 <soren.brinkmann@xilinx.com>, David Woodhouse <dwmw2@infradead.org>, "Brian
 Norris" <computersforpeace@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Javier Martinez Canillas" <javier@osg.samsung.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>, Stephen Warren <swarren@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, "Andrew F. Davis" <afd@ti.com>,
 Marek Vasut <marex@denx.de>, Jagan Teki <jteki@openedev.com>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
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

This patch does following things.
1. Added dummy entry in the spi_transfer structure.
2. Assigned dummy cycles to dummy member in the transfer
structure during read operation.

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/mtd/devices/m25p80.c | 1 +
 include/linux/spi/spi.h      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c9c3b7f..7c9fac9 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -139,6 +139,7 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 
 	t[0].tx_buf = flash->command;
 	t[0].len = m25p_cmdsz(nor) + dummy;
+	t[0].dummy = nor->read_dummy;
 	spi_message_add_tail(&t[0], &m);
 
 	t[1].rx_buf = buf;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 857a9a1..3f93526 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -664,6 +664,7 @@ extern void spi_res_release(struct spi_master *master,
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
+ * @dummy: number of dummy cycles.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
@@ -752,6 +753,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
+	u32		dummy;
 
 	struct list_head transfer_list;
 };
-- 
2.1.2
