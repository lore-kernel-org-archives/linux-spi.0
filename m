From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v6 02/10] mtd: m25p80: return amount of data transferred or
 error in read/write
Date: 2 Dec 2015 10:38:19 -0000
Message-ID: <addb82044e8f8472ac0d02bd08ee5dca1a186117.1449052427.git.hramrach@gmail.com>
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

Add checking of SPI transfer errors and return them from read/write
functions. Also return the amount of data transferred.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 6ee3bb3..fc694fd 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -81,6 +81,7 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	struct spi_transfer t[2] = {};
 	struct spi_message m;
 	int cmd_sz = m25p_cmdsz(nor);
+	ssize_t ret;
 
 	spi_message_init(&m);
 
@@ -98,10 +99,15 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
-	spi_sync(spi, &m);
+	ret = spi_sync(spi, &m);
+	if (ret)
+		return ret;
 
-	*retlen += m.actual_length - cmd_sz;
-	return 0;
+	ret = m.actual_length - cmd_sz;
+	if (ret < 0)
+		return -EIO;
+	*retlen += ret;
+	return ret;
 }
 
 static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
@@ -128,6 +134,7 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	struct spi_transfer t[2];
 	struct spi_message m;
 	unsigned int dummy = nor->read_dummy;
+	ssize_t ret;
 
 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;
@@ -147,10 +154,15 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
-	spi_sync(spi, &m);
+	ret = spi_sync(spi, &m);
+	if (ret)
+		return ret;
 
-	*retlen = m.actual_length - m25p_cmdsz(nor) - dummy;
-	return 0;
+	ret = m.actual_length - m25p_cmdsz(nor) - dummy;
+	if (ret < 0)
+		return -EIO;
+	*retlen += ret;
+	return ret;
 }
 
 /*
-- 
2.6.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
