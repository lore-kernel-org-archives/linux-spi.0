From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v6 01/10] mtd: spi-nor: change return value of read/write
Date: 2 Dec 2015 10:38:19 -0000
Message-ID: <b255ef9e237b9b58e2cfb13ee0047df62cabe9a5.1449052427.git.hramrach@gmail.com>
References: <cover.1449052427.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
 Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 "Rafal Milecki" <zajec5@gmail.com>, Jagan Teki <jteki@openedev.com>,
 "Andrew F. Davis" <afd@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Gabor Juhos <juhosg@openwrt.org>, "Bean Huo  " <beanhuo@micron.com>,
 Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1449052427.git.hramrach@gmail.com>
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

Change the return value of spi-nor device read and write methods to
allow returning amount of data transferred and errors as
read(2)/write(2) does.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---

 - avoid compiler warning
---
 drivers/mtd/devices/m25p80.c      | 5 +++--
 drivers/mtd/spi-nor/fsl-quadspi.c | 5 +++--
 include/linux/mtd/spi-nor.h       | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c9c3b7f..6ee3bb3 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -73,7 +73,7 @@ static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 	return spi_write(spi, flash->command, len + 1);
 }
 
-static void m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
+static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 			size_t *retlen, const u_char *buf)
 {
 	struct m25p *flash = nor->priv;
@@ -101,6 +101,7 @@ static void m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	spi_sync(spi, &m);
 
 	*retlen += m.actual_length - cmd_sz;
+	return 0;
 }
 
 static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
@@ -119,7 +120,7 @@ static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
  * Read an address range from the nor chip.  The address range
  * may be any size provided it is within the physical boundaries.
  */
-static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
+static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct m25p *flash = nor->priv;
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 54640f1..10d2b59 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -822,7 +822,7 @@ static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 	return ret;
 }
 
-static void fsl_qspi_write(struct spi_nor *nor, loff_t to,
+static ssize_t fsl_qspi_write(struct spi_nor *nor, loff_t to,
 		size_t len, size_t *retlen, const u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
@@ -832,9 +832,10 @@ static void fsl_qspi_write(struct spi_nor *nor, loff_t to,
 
 	/* invalid the data in the AHB buffer. */
 	fsl_qspi_invalid(q);
+	return 0;
 }
 
-static int fsl_qspi_read(struct spi_nor *nor, loff_t from,
+static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 		size_t len, size_t *retlen, u_char *buf)
 {
 	struct fsl_qspi *q = nor->priv;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7bed974..6080701 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -171,9 +171,9 @@ struct spi_nor {
 	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 
-	int (*read)(struct spi_nor *nor, loff_t from,
+	ssize_t (*read)(struct spi_nor *nor, loff_t from,
 			size_t len, size_t *retlen, u_char *read_buf);
-	void (*write)(struct spi_nor *nor, loff_t to,
+	ssize_t (*write)(struct spi_nor *nor, loff_t to,
 			size_t len, size_t *retlen, const u_char *write_buf);
 	int (*erase)(struct spi_nor *nor, loff_t offs);
 
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
