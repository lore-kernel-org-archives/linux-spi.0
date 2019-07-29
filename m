From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [RFC v1 3/3] mtd: m25p80: add get Flash size callback support
Date: Mon, 29 Jul 2019 17:25:04 +0300
Message-ID: <20190729142504.188336-4-tmaimon77@gmail.com>
References: <20190729142504.188336-1-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Tomer Maimon <tmaimon77@gmail.com>, linux-spi@vger.kernel.org
To: broonie@kernel.org, dwmw2@infradead.org, computersforpeace@gmail.com,
 marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, bbrezillon@kernel.org, yogeshnarayan.gaur@nxp.com,
 tudor.ambarus@microchip.com, gregkh@linuxfoundation.org,
 frieder.schrempf@exceet.de, tglx@linutronix.de
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190729142504.188336-1-tmaimon77@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Add get Flash size function support for
passing Flash size through callback use
to the spi layer.

Add get Flash size function support

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c50888670250..fd14c8c6d8d8 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -151,6 +151,15 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	return len;
 }
 
+/* Sending Flash size thourgh callback function to spi layer */
+size_t	m25p80_get_flash_size(void *param)
+{
+	struct spi_mem *spimem = param;
+	struct m25p *flash = spi_mem_get_drvdata(spimem);
+
+	return (u32)(flash->spi_nor.mtd.size >> 10) * 1024;
+}
+
 /*
  * board specific setup should have ensured the SPI clock used here
  * matches what the READ command supports, at least until this driver
@@ -188,6 +197,9 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_nor_set_flash_node(nor, spi->dev.of_node);
 	nor->priv = flash;
 
+	spimem->callback = m25p80_get_flash_size;
+	spimem->callback_param = spimem;
+
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem = spimem;
 
-- 
2.18.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
