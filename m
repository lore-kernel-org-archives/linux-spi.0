From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 10/18] mtd: spi-nor: Add support for X-X-X modes
Date: Fri, 12 Oct 2018 10:48:17 +0200
Message-ID: <20181012084825.23697-11-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
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

Some NORs only support 1-1-1 and X-X-X modes, and in the case, the
benefit of using X-X-X mode is obvious, even if this implies extra
complexity in the core logic, since now the protocol used for a given
operation depends on the mode the NOR is currently operating in.

To deal with this stateful aspect, we add a ->mode field which keeps
track of the current mode. We also add a ->change_mode() hook, so that
NORs can have their own procedure to switch from one mode to another,
and ->adjust_op() is here to live patch spi_mem_op when a given
operation is executed (depending on the mode, it might involve extending
the number of dummy cycle, adding address or cmd cycles, ...).

Finally, ->preferred_mode is here let the core know what mode it should
enter when resuming or at init time. The preferred mode selection logic
(spi_nor_select_preferred_mode()) is pretty basic and might be extended
at some point.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 96 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   | 12 ++++++
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 42f299a0b76f..33a07d9eb7a8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -93,10 +93,18 @@ struct flash_info {
 #define USE_CLSR		BIT(14)	/* use CLSR command */
 
 	int	(*quad_enable)(struct spi_nor *nor);
+	int	(*change_mode)(struct spi_nor *nor, u32 newmode);
+	void	(*adjust_op)(struct spi_nor *nor, struct spi_mem_op *op);
 };
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+static void spi_nor_adjust_op(struct spi_nor *nor, struct spi_mem_op *op)
+{
+	if (nor->adjust_op)
+		nor->adjust_op(nor, op);
+}
+
 static int spi_nor_exec_op(struct spi_nor *nor, struct spi_mem_op *op,
 			   u64 *addr, void *buf, unsigned int len)
 {
@@ -106,6 +114,8 @@ static int spi_nor_exec_op(struct spi_nor *nor, struct spi_mem_op *op,
 	if (!op || (len && !buf))
 		return -EINVAL;
 
+	spi_nor_adjust_op(nor, op);
+
 	if (op->addr.nbytes && addr)
 		op->addr.val = *addr;
 
@@ -150,11 +160,17 @@ static int spi_nor_nodata_op(struct spi_nor *nor, struct spi_mem_op *op)
 
 static int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *val, int len)
 {
+	if (WARN_ON_ONCE(nor->mode != SPI_NOR_MODE_SPI))
+		return -ENOTSUPP;
+
 	return nor->read_reg(nor, opcode, val, len);
 }
 
 static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, u8 *val, int len)
 {
+	if (WARN_ON_ONCE(nor->mode != SPI_NOR_MODE_SPI))
+		return -ENOTSUPP;
+
 	return nor->write_reg(nor, opcode, val, len);
 }
 
@@ -184,6 +200,8 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	spi_nor_adjust_op(nor, &op);
+
 	while (remaining) {
 		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
 		if (!usebouncebuf)
@@ -243,6 +261,8 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t ofs,
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
+	spi_nor_adjust_op(nor, &op);
+
 	op.data.nbytes = len < UINT_MAX ? len : UINT_MAX;
 
 	if (!usebouncebuf) {
@@ -422,6 +442,25 @@ static int write_disable(struct spi_nor *nor)
 	return spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
 
+static int spi_nor_change_mode(struct spi_nor *nor, u32 newmode)
+{
+	int ret;
+
+	if (newmode == nor->mode)
+		return 0;
+
+	if (!nor->change_mode)
+		return -ENOTSUPP;
+
+	ret = nor->change_mode(nor, newmode);
+	if (ret)
+		return ret;
+
+	nor->mode = newmode;
+
+	return 0;
+}
+
 static struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -2902,9 +2941,6 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor,
 	/* DTR modes are not supported yet, mask them all. */
 	*hwcaps &= ~SNOR_HWCAPS_DTR;
 
-	/* X-X-X modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_X_X_X;
-
 	/* Start with read commands. */
 	for (cap = 0; cap < 32; cap++) {
 		int idx;
@@ -3884,6 +3920,46 @@ static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size)
 	return 0;
 }
 
+static void spi_nor_select_preferred_mode(struct spi_nor *nor, u32 hwcaps)
+{
+	nor->preferred_mode = SPI_NOR_MODE_SPI;
+
+	/*
+	 * Let's just avoid using stateful modes when SNOR_F_BROKEN_RESET is
+	 * set.
+	 */
+	if (nor->flags & SNOR_F_BROKEN_RESET)
+		return;
+
+	/*
+	 * Stateless (1-n-n or 1-1-n) opcodes should always be preferred to
+	 * stateful (n-n-n) ones if supported.
+	 */
+	if (hwcaps & SNOR_HWCPAS_READ_OCTO && hwcaps & SNOR_HWCAPS_PP_OCTO)
+		return;
+
+	if (hwcaps & SNOR_HWCAPS_OPI) {
+		nor->preferred_mode = SPI_NOR_MODE_OPI;
+		return;
+	}
+
+	if (hwcaps & SNOR_HWCAPS_READ_QUAD && hwcaps & SNOR_HWCAPS_PP_QUAD)
+		return;
+
+	if (hwcaps & SNOR_HWCAPS_QPI) {
+		nor->preferred_mode = SPI_NOR_MODE_QPI;
+		return;
+	}
+
+	if (hwcaps & SNOR_HWCAPS_READ_DUAL)
+		return;
+
+	if (hwcaps & SNOR_HWCAPS_DPI) {
+		nor->preferred_mode = SPI_NOR_MODE_DPI;
+		return;
+	}
+}
+
 static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 			 const struct spi_nor_flash_parameter *params,
 			 const struct spi_nor_hwcaps *hwcaps)
@@ -3892,6 +3968,10 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	bool enable_quad_io;
 	int err;
 
+	/* Set ->adjust_op() and ->change_mode(). */
+	nor->adjust_op = info->adjust_op;
+	nor->change_mode = info->change_mode;
+
 	/*
 	 * Keep only the hardware capabilities supported by both the SPI
 	 * controller and the SPI flash memory.
@@ -3951,6 +4031,8 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	else
 		nor->quad_enable = NULL;
 
+	spi_nor_select_preferred_mode(nor, shared_mask);
+
 	return 0;
 }
 
@@ -3971,6 +4053,11 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	err = spi_nor_change_mode(nor, nor->preferred_mode);
+	if (err)
+		dev_err(nor->dev, "failed to switch to mode %x",
+			nor->preferred_mode);
+
 	if (nor->quad_enable) {
 		err = nor->quad_enable(nor);
 		if (err) {
@@ -4011,6 +4098,9 @@ static void spi_nor_resume(struct mtd_info *mtd)
 
 void spi_nor_restore(struct spi_nor *nor)
 {
+	/* Restore the NOR to SPI mode. */
+	spi_nor_change_mode(nor, SPI_NOR_MODE_SPI);
+
 	/* restore the addressing mode */
 	if ((nor->addr_width == 4) &&
 	    !(nor->info->flags & SPI_NOR_4B_OPCODES) &&
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f2154672f75a..f80aba464eb2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -333,6 +333,14 @@ struct spi_nor_erase_map {
  */
 struct flash_info;
 
+enum spi_nor_mode {
+	SPI_NOR_MODE_SPI,
+	SPI_NOR_MODE_DPI,
+	SPI_NOR_MODE_QPI,
+	SPI_NOR_MODE_OPI,
+	SPI_NOR_NUM_MODES,
+};
+
 /**
  * struct spi_nor - Structure for defining a the SPI NOR layer
  * @mtd:		point to a mtd_info structure
@@ -381,6 +389,8 @@ struct spi_nor {
 	struct spi_mem		*spimem;
 	void			*bouncebuf;
 	unsigned int		bouncebuf_size;
+	enum spi_nor_mode	preferred_mode;
+	enum spi_nor_mode	mode;
 	const struct flash_info	*info;
 	u32			page_size;
 	u8			addr_width;
@@ -412,6 +422,8 @@ struct spi_nor {
 	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
+	int (*change_mode)(struct spi_nor *nor, enum spi_nor_mode newmode);
+	void (*adjust_op)(struct spi_nor *nor, struct spi_mem_op *op);
 
 	void *priv;
 };
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
