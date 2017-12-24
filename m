From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer for
 data transfer
Date: Sun, 24 Dec 2017 05:36:04 +0100
Message-ID: <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, devicetree@vger.kernel.org, nicolas.ferre@microchip.com,
 linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 radu.pirea@microchip.com, linux-spi@vger.kernel.org
To: computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
 boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
 linux-mtd@lists.infradead.org, broonie@kernel.org, vigneshr@ti.com,
 linux@armlinux.org.uk
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
In-Reply-To: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
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

This patch has two purposes:

1 - To fix the compatible issue between the MTD and SPI sub-systems

The MTD sub-system has no particular requirement about the memory areas it
uses. Especially, ubifs is well known for using vmalloc'ed buffers, which
then are not DMA-safe. There are reasons behind that, so we have to deal
with it.

On the other hand, the SPI sub-system clearly states in the kernel doc for
'struct spi-transfer' (include/linux/spi/spi.h) that both .tx_buf and
.rx_buf must point into "dma-safe memory". This requirement has not been
taken into account by the m25p80.c driver, at the border between MTD and
SPI, for a long time now. So it's high time to fix this issue.

2 - To help other SPI flash controller drivers to perform DMA transfers

Those controller drivers suffer the same issue as those behind the
m25p80.c driver in the SPI sub-system: They may be provided by the MTD
sub-system with buffers not suited to DMA operations. We want to avoid
each controller to implement its own bounce buffer so we offer them some
optional bounce buffer, allocated and managed by the spi-nor framework
itself, as an helper to add support to DMA transfers.

Then the patch adds two hardware capabilities for SPI flash controllers,
SNOR_HWCAPS_WR_BOUNCE and SNOR_HWCAPS_RD_BOUNCE.

SPI flash controller drivers are supposed to use them to request the
spi-nor framework to allocate an optional bounce buffer in some
DMA-safe memory area then to use it in some cases during (Fast) Read
and/or Page Program operations.

More precisely, the bounce buffer is used if and only if two conditions
are met:
1 - The SPI flash controller driver has declared the
    SNOR_HWCAPS_RD_BOUNCE, resp. SNOR_HWCAPS_WR_BOUNCE for (Fast) Read,
    resp. Page Program operations.
2 - The buffer provided by the above MTD layer is not already in a
    DMA-safe area.

This policy avoid using the bounce buffer when not explicitly requested
or when not needed, hence limiting the performance penalty.

Besides, the bounce buffer is allocated once for all at the very first
time it is actually needed. This means that as long as all buffers
provided by the above MTD layer are allocated in some DMA-safe areas, the
bounce buffer itself is never allocated.

Finally, the bounce buffer size is limited to 256KiB, the currently known
maximum erase sector size. This tradeoff should still provide good
performances even if new memory parts come with even larger erase sector
sizes, limiting the memory footprint at the same time.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
---
 drivers/mtd/devices/m25p80.c  |   4 +-
 drivers/mtd/spi-nor/spi-nor.c | 136 +++++++++++++++++++++++++++++++++++++++---
 include/linux/mtd/spi-nor.h   |   8 +++
 3 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index a4e18f6aaa33..60878c62a654 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -239,7 +239,9 @@ static int m25p_probe(struct spi_device *spi)
 	struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ |
 			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_PP,
+			SNOR_HWCAPS_PP |
+			SNOR_HWCAPS_RD_BOUNCE |
+			SNOR_HWCAPS_WR_BOUNCE,
 	};
 	char *flash_name;
 	int ret;
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8bafd462f0ae..59f9fbd45234 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -14,8 +14,10 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/math64.h>
+#include <linux/mm.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
@@ -1232,6 +1234,56 @@ static const struct flash_info spi_nor_ids[] = {
 	{ },
 };
 
+static bool spi_nor_is_dma_safe(const void *buf)
+{
+	if (is_vmalloc_addr(buf))
+		return false;
+
+#ifdef CONFIG_HIGHMEM
+	if ((unsigned long)buf >= PKMAP_BASE &&
+	    (unsigned long)buf < (PKMAP_BASE + (LAST_PKMAP * PAGE_SIZE)))
+		return false;
+#endif
+
+	return true;
+}
+
+static int spi_nor_get_bounce_buffer(struct spi_nor *nor,
+				     u_char **buffer,
+				     size_t *buffer_size)
+{
+	const struct flash_info *info = nor->info;
+	/*
+	 * Limit the size of the bounce buffer to 256KB: this is currently
+	 * the largest known erase sector size (> page size) and should be
+	 * enough to still reach good performances if some day new memory
+	 * parts use even larger erase sector sizes.
+	 */
+	size_t size = min_t(size_t, info->sector_size, SZ_256K);
+
+	/*
+	 * Allocate the bounce buffer once for all at the first time it is
+	 * actually needed. This prevents wasting some precious memory
+	 * in cases where it would never be needed.
+	 */
+	if (unlikely(!nor->bounce_buffer)) {
+		nor->bounce_buffer = devm_kmalloc(nor->dev, size, GFP_KERNEL);
+
+		/*
+		 * The SPI flash controller driver has required and expects to
+		 * use the DMA-safe bounce buffer, so we can't recover from
+		 * this allocation failure.
+		 */
+		if (!nor->bounce_buffer)
+			return -ENOMEM;
+	}
+
+	*buffer = nor->bounce_buffer;
+	*buffer_size = size;
+
+	return 0;
+}
+
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
 	int			tmp;
@@ -1260,6 +1312,10 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	bool use_bounce = (nor->flags & SNOR_F_USE_RD_BOUNCE) &&
+			  !spi_nor_is_dma_safe(buf);
+	u_char *buffer = buf;
+	size_t buffer_size = 0;
 	int ret;
 
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
@@ -1268,13 +1324,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (ret)
 		return ret;
 
+	if (use_bounce) {
+		ret = spi_nor_get_bounce_buffer(nor, &buffer, &buffer_size);
+		if (ret < 0)
+			goto read_err;
+	}
+
 	while (len) {
 		loff_t addr = from;
+		size_t length = len;
 
 		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
-		ret = nor->read(nor, addr, len, buf);
+		if (use_bounce && length > buffer_size)
+			length = buffer_size;
+
+		ret = nor->read(nor, addr, length, buffer);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1283,7 +1349,11 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (ret < 0)
 			goto read_err;
 
-		WARN_ON(ret > len);
+		WARN_ON(ret > length);
+		if (use_bounce)
+			memcpy(buf, nor->bounce_buffer, ret);
+		else
+			buffer += ret;
 		*retlen += ret;
 		buf += ret;
 		from += ret;
@@ -1300,7 +1370,10 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	size_t actual;
+	bool use_bounce = (nor->flags & SNOR_F_USE_WR_BOUNCE) &&
+			  !spi_nor_is_dma_safe(buf);
+	u_char *buffer = NULL;
+	size_t actual = 0, buffer_size = 0;
 	int ret;
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
@@ -1309,6 +1382,12 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (ret)
 		return ret;
 
+	if (use_bounce) {
+		ret = spi_nor_get_bounce_buffer(nor, &buffer, &buffer_size);
+		if (ret < 0)
+			goto sst_write_err;
+	}
+
 	write_enable(nor);
 
 	nor->sst_write_second = false;
@@ -1318,8 +1397,13 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (actual) {
 		nor->program_opcode = SPINOR_OP_BP;
 
+		if (use_bounce)
+			buffer[0] = buf[0];
+		else
+			buffer = (u_char *)buf;
+
 		/* write one byte. */
-		ret = nor->write(nor, to, 1, buf);
+		ret = nor->write(nor, to, 1, buffer);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -1334,8 +1418,15 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 	for (; actual < len - 1; actual += 2) {
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
+		if (use_bounce) {
+			buffer[0] = buf[actual];
+			buffer[1] = buf[actual + 1];
+		} else {
+			buffer = (u_char *)buf + actual;
+		}
+
 		/* write two bytes. */
-		ret = nor->write(nor, to, 2, buf + actual);
+		ret = nor->write(nor, to, 2, buffer);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
@@ -1358,7 +1449,13 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		write_enable(nor);
 
 		nor->program_opcode = SPINOR_OP_BP;
-		ret = nor->write(nor, to, 1, buf + actual);
+
+		if (use_bounce)
+			buffer[0] = buf[actual];
+		else
+			buffer = (u_char *)buf + actual;
+
+		ret = nor->write(nor, to, 1, buffer);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -1384,7 +1481,10 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	size_t *retlen, const u_char *buf)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	size_t page_offset, page_remain, i;
+	bool use_bounce = (nor->flags & SNOR_F_USE_WR_BOUNCE) &&
+			  !spi_nor_is_dma_safe(buf);
+	u_char *buffer = NULL;
+	size_t page_offset, page_remain, i, buffer_size = 0;
 	ssize_t ret;
 
 	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
@@ -1393,6 +1493,12 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 	if (ret)
 		return ret;
 
+	if (use_bounce) {
+		ret = spi_nor_get_bounce_buffer(nor, &buffer, &buffer_size);
+		if (ret < 0)
+			goto write_err;
+	}
+
 	for (i = 0; i < len; ) {
 		ssize_t written;
 		loff_t addr = to + i;
@@ -1419,8 +1525,17 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
+		if (use_bounce) {
+			if (page_remain > buffer_size)
+				page_remain = buffer_size;
+
+			memcpy(nor->bounce_buffer, buf + i, page_remain);
+		} else {
+			buffer = (u_char *)buf + i;
+		}
+
 		write_enable(nor);
-		ret = nor->write(nor, addr, page_remain, buf + i);
+		ret = nor->write(nor, addr, page_remain, buffer);
 		if (ret < 0)
 			goto write_err;
 		written = ret;
@@ -2814,6 +2929,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_S3AN)
 		nor->flags |=  SNOR_F_READY_XSR_RDY;
 
+	if (hwcaps->mask & SNOR_HWCAPS_RD_BOUNCE)
+		nor->flags |= SNOR_F_USE_RD_BOUNCE;
+	if (hwcaps->mask & SNOR_HWCAPS_WR_BOUNCE)
+		nor->flags |= SNOR_F_USE_WR_BOUNCE;
+
 	/* Parse the Serial Flash Discoverable Parameters table. */
 	ret = spi_nor_init_params(nor, info, &params);
 	if (ret)
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index de36969eb359..9f4218990fc7 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -233,6 +233,8 @@ enum spi_nor_option_flags {
 	SNOR_F_S3AN_ADDR_DEFAULT = BIT(3),
 	SNOR_F_READY_XSR_RDY	= BIT(4),
 	SNOR_F_USE_CLSR		= BIT(5),
+	SNOR_F_USE_RD_BOUNCE	= BIT(6),
+	SNOR_F_USE_WR_BOUNCE	= BIT(7),
 };
 
 /**
@@ -259,6 +261,7 @@ struct flash_info;
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto		the SPI protocol for read_reg/write_reg/erase operations
  * @cmd_buf:		used by the write_reg
+ * @bounce_buffer:	an optional kmalloc'ed buffer as DMA transfer helper
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
  * @unprepare:		[OPTIONAL] do some post work after the
@@ -294,6 +297,7 @@ struct spi_nor {
 	bool			sst_write_second;
 	u32			flags;
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
+	void			*bounce_buffer;
 
 	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
 	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
@@ -386,6 +390,10 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
 #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
 
+/* Bounce buffer helper, for DMA transfer for instance. */
+#define SNOR_HWCAPS_WR_BOUNCE	BIT(30)
+#define SNOR_HWCAPS_RD_BOUNCE	BIT(31)
+
 /**
  * spi_nor_scan() - scan the SPI NOR
  * @nor:	the spi_nor structure
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
