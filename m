From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v5 06/10] mtd: spi-nor: simplify write loop
Date: 1 Dec 2015 16:51:05 -0000
Message-ID: <2236d87ad516f118f58eb5df232d441f970c4499.1448988089.git.hramrach@gmail.com>
References: <cover.1448988089.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiner Kallweit <hkallweit1@gmail.com>,
  David Woodhouse <dwmw2@infradead.org>,
  Brian Norris <computersforpeace@gmail.com>, Han Xu <han.xu@freescale.com>,
  Mark Brown <broonie@kernel.org>, Michal Suchanek <hramrach@gmail.com>,
  Boris Brezillon <boris.brezillon@free-electrons.com>,
  Javier Martinez Canillas <javier@osg.samsung.com>,
  Stephen Warren <swarren@nvidia.com>, "Andrew F. Davis" <afd@ti.com>,
  Marek Vasut <marex@denx.de>, "Rafał Miłecki" <zajec5@gmail.com>,
  Mika Westerberg <mika.westerberg@linux.intel.com>,
  Gabor Juhos <juhosg@openwrt.org>,
  "Bean Huo 霍斌斌 " <beanhuo@micron.com>,
  Furquan Shaikh <furquan@google.com>, linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1448988089.git.hramrach@gmail.com>
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

The spi-nor write loop assumes that what is passed to the hardware
driver write() is what gets written.

When write() writes less than page size at once data is dropped on the
floor. Check the amount of data writen and exit if it does not match
requested amount.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

---

 - add warning when writing incomplete pages
 - refuse to continue writing when full page was not written
---
 drivers/mtd/spi-nor/spi-nor.c | 58 +++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3d02803..115c123 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1005,8 +1005,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	u32 page_offset, page_size, i;
-	int ret;
+	size_t page_offset, page_remain, i;
+	ssize_t ret;
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
 
@@ -1014,45 +1014,37 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (ret)
 		return ret;
 
-	write_enable(nor);
-
-	page_offset = to & (nor->page_size - 1);
+	for (i = 0; i < len; ) {
+		ssize_t written;
 
-	/* do all the bytes fit onto one page? */
-	if (page_offset + len <= nor->page_size) {
-		ret = nor->write(nor, to, len, buf);
-		if (ret < 0)
-			goto write_err;
-		*retlen += ret;
-	} else {
+		page_offset = to & (nor->page_size - 1);
+		WARN_ONCE(page_offset,
+			  "Writing at offset %zu into a NOR page. Writing partial pages may decrease reliability and increase wear of NOR flash.",
+			  page_offset);
 		/* the size of data remaining on the first page */
-		page_size = nor->page_size - page_offset;
-		ret = nor->write(nor, to, page_size, buf);
+		page_remain = min_t(size_t,
+				    nor->page_size - page_offset, len - i);
+
+		write_enable(nor);
+		ret = nor->write(nor, to + i, page_remain, buf + i);
 		if (ret < 0)
 			goto write_err;
-		*retlen += ret;
-
-		/* write everything in nor->page_size chunks */
-		for (i = ret; i < len; ) {
-			page_size = len - i;
-			if (page_size > nor->page_size)
-				page_size = nor->page_size;
-
-			ret = spi_nor_wait_till_ready(nor);
-			if (ret)
-				goto write_err;
+		written = ret;
 
-			write_enable(nor);
-
-			ret = nor->write(nor, to + i, page_size, buf + i);
-			if (ret < 0)
-				goto write_err;
-			*retlen += ret;
-			i += ret;
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			goto write_err;
+		*retlen += written;
+		i += written;
+		if (written != page_remain) {
+			dev_err(nor->dev,
+				"While writing %zu bytes written %zd bytes\n",
+				page_remain, written);
+			ret = -EIO;
+			goto write_err;
 		}
 	}
 
-	ret = spi_nor_wait_till_ready(nor);
 write_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
