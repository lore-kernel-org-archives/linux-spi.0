From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFC/PATCH 3/3] drivers: mtd: devices: Add memory mapped read support.
Date: Wed, 9 Oct 2013 20:54:44 +0530
Message-ID: <1381332284-21822-4-git-send-email-sourav.poddar@ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
 Sourav Poddar <sourav.poddar@ti.com>, linux-mtd@lists.infradead.org,
 balbi@ti.com
To: <broonie@kernel.org>, <dwmw2@infradead.org>, <computersforpeace@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
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

Add memory mapped flash read support. In memory mapped, only the len, from
and t->rx_buf is required from the flash side, while other configuration
will be taken care of from the respective controller side with the help
of the transfer flag(memory_map).

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---

 drivers/mtd/devices/m25p80.c |   13 +++++++++++--
 include/linux/spi/spi.h      |    2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index dc9bcbf..9d09bad 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -102,6 +102,7 @@ struct m25p {
 	u8			*command;
 	bool			fast_read;
 	bool			quad_read;
+	bool			mmap_read;
 };
 
 static inline struct m25p *mtd_to_m25p(struct mtd_info *mtd)
@@ -440,10 +441,15 @@ static int m25p80_quad_read(struct mtd_info *mtd, loff_t from, size_t len,
 	spi_message_init(&m);
 	memset(t, 0, (sizeof(t)));
 
+	if (flash->mmap_read)
+		t[0].memory_map = 1;
 	t[0].tx_buf = flash->command;
-	t[0].len = m25p_cmdsz(flash) + (flash->quad_read ? 1 : 0);
+	t[0].len = flash->mmap_read ? from : m25p_cmdsz(flash) +
+				(flash->quad_read ? 1 : 0);
 	spi_message_add_tail(&t[0], &m);
 
+	if (flash->mmap_read)
+		t[1].memory_map = 1;
 	t[1].rx_buf = buf;
 	t[1].len = len;
 	t[1].rx_nbits = SPI_NBITS_QUAD;
@@ -470,7 +476,7 @@ static int m25p80_quad_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	spi_sync(flash->spi, &m);
 
-	*retlen = m.actual_length - m25p_cmdsz(flash) -
+	*retlen = flash->mmap_read ? len : m.actual_length - m25p_cmdsz(flash) -
 			(flash->quad_read ? 1 : 0);
 
 	mutex_unlock(&flash->lock);
@@ -1207,6 +1213,9 @@ static int m25p_probe(struct spi_device *spi)
 	if (spi->mode && SPI_RX_QUAD)
 		flash->quad_read = true;
 
+	if (spi->mode && SPI_RX_MMAP)
+		flash->mmap_read = true;
+
 	flash->command = kmalloc(MAX_CMD_SIZE + (flash->fast_read ? 1 :
 				(flash->quad_read ? 1 : 0)), GFP_KERNEL);
 	if (!flash->command) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4d634d6..a6ffb52 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -91,6 +91,7 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
+#define SPI_RX_MMAP	0x1000			/* Memory mapped read */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
@@ -557,6 +558,7 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u32		speed_hz;
 
+	bool	memory_map;
 	struct list_head transfer_list;
 };
 
-- 
1.7.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
