Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795246375;
	b=DJQCgonUhSzxSl862KBIYg2T0WtAArOYONjlyRbsKf7GSeCA7c9GGw5f7eFRsDdy6Fxx
	 Ihr1g4CkExBOg91AtGRMIPfajp9MrhGWzbz/rP1+4rDOj7Bm9v5OUewHi9aAMNFkR6TZg
	 xnpGsX4QO8l5v4GttCE4xEenyTITesWQJNxZwfQacTd9M4TkhmrCoftZLvblpgjChRV1g
	 q7ScaBe0t6q6HrL2ATl7E1iFvPBcRrrFJltKVBYH10Q5bsUcnbIAWI2XAoifQ9mvFyL8s
	 3W26kDYuZ52YNks5prqhk4RsqS9+in3m3kEHlRRZSYTm112d3IdVN0VRX0yZVSfPiSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795246375;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aW0ZGphEjqN9FBnq72DDJKV0boqgFU1NIIPhY/ErgW8=;
	b=y4mR32SFmOKQRWvEJr2ODIXcqMd4pETVW6845FRxvlUHyqpI8c+hSCXntt2ZG2UF3dQg
	 TokY/vqwHjM338RiSoP66sawr5n1Ju41RyXNFzNJFZu6An+vOKp2tS9hqUy8WQk8zT50s
	 71GWRu7pn08wKwnL833/wLDtt7C2UnSypvLc3Pk38Gc3uzG4lzlhdbuqEUskOKRJ3NmBx
	 ZM/mywvZjKakeoavb8BdZquT19zko1X+3ZcbiECGiBTRckmAASce2T8JfYHVtSOeZXVfZ
	 GpIE3OEq4F2dk08rkctaqKPT+YoVNm2i88L7NEFV67Z4URNp2hNFM+ZaGfzT6cNTYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=QF7yKmYo;
	arc=none smtp.remote-ip=203.205.221.149
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A0606A325;
	Sat, 21 Nov 2026 07:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404A0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=QF7yKmYo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795246371; bh=aW0ZGphEjqN9FBnq72DDJKV0boqgFU1NIIPhY/ErgW8=;
	h=From:To:Cc:Subject:Date;
	b=QF7yKmYoEcsPtnldjNL+r6jBJJXDIjJqvAhG4LHmsw8uUZyEdcu4dyBce1sGFpAwh
	 YWJWHP1Uge3RYaqHrnZu7F/sSbxQUfwC4AzwetJalQ5ASZttRVsbvBMnNPbUCblOWS
	 MTIs5Nz0/OmLV0skSH15mArLdJB+Me2GF2721kNM=
Received: from jerry-PC.lan ([2408:8249:5f:7101:71a:8713:56b4:5043])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 830284BE; Sat, 21 Nov 2026 15:32:48 +0800
X-QQ-mid: xmsmtpt1795246368tcja22yf3
Message-ID: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
X-QQ-XMAILINFO: OQac6g2KrvnWJd/AjyKj6bp8/lqaADZ4cF9P/T5Q+g+QTWQyxOcvf4+h96Y1ky
	 TzHie/FbERE7l3mL7TIEJIazVza8tUXUwS/Pg4YWwg66oGPjLd5P/6pVgnDDGEtNdCu89imhtdFe
	 D6wD5v4pPEeMMib0CQx1IB2UIISfNTVKeQSQtYFgnJF5duT7a/W7sIptnWNpowHRaiL9lY+uNwiq
	 hQjhniroPr3ihRqpqBBDCaRK1XsAthZ2DIKyhuQbKkKT4OqsOCwEHDnw0CkhxuA+iCQ7tCoeQaTK
	 VH8nRSvdeV06xuMPR2moIrSGq1DbDcbmlahl+Kf0L9+9INom4LtettvFCML7IxwsXyDVHDFaafmr
	 IPUNEm9y9NrGSCqp9mCFLGQGHOUmMDoGhMNTHxQiE1+uXw3fLZaP9PislaMc4d1c53Z6sG1ZEwB8
	 szDxO4u1f2Hj1psNuaVmNh4yW8TEaAo9UIdLd5vxZ4/vVbUaicz9G6SSn8X1n/SAqFpFsyrMmQv7
	 mmkb+c5oXHqXRZeT9zYA72F1hJ+XXkMWbz3i7/KNodra1M3XIz9MSRevBzQzceW7KN5pMcTuLKRv
	 WzAqXRdO7/1tWZupMBgsEqdgGHMjC5bfjutlzZeQ0YR0stQabBu2ll+OH7ypVsdvon67u3PdPOZ+
	 3biZ4LYxX7oqk7xt3L0NDFli5DylaFqU+fftq4mQsAxwD6GPm70xz/aHTByFkrNDWTeTuvlkMYrM
	 4rsuuaTIOs2jvPhBJwbh/kf2Wf5lF924rMFcZw2ER2CdC/UgQVOOYN2FFSLG+xfQbE9srUonw0fh
	 eLyjaM4tbO3b+f9htyCqwKWgD7x0/Wrb/uFo4YDx6w/Fk5820z5KWjTqALHuMhYx8QLKnCot24kU
	 ky7AX90Y1F1TnJQRHKj0V93Myw4RQOzqEu8dJOF5ZzF72ot9pXgGara3nS2gT7RgEA99r7txK0Z7
	 qrnDwB3ehnE+vA8GFOImK3YfJTal8CoE+Bfa5RMtsABeT5W9cTRzn28u8cUrPGGSDCX15ufYaTeC
	 fVzdUz8kw2OhFwNoEFHqc9K+CkbGUCXb9IWBxYhiQPlTbFFQFAfh+cjbTVT0X+tfcOJQgvilwhWt
	 d/T85TptX9BnD5/d+o8525s+IqQPeAP7pTXSGlg6Arl5pTCO0=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: ZhuXiangyu <1194781887@qq.com>
To: Mark Brown <broonie@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ZhuXiangyu <1194781887@qq.com>
Subject: [PATCH 1/2] spi: rockchip-sfc: add RK3506 support
Date: Sat, 21 Nov 2026 15:32:45 +0800
X-OQ-MSGID: <20261121073246.1233736-1-1194781887@qq.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3506 SFC reports version 9 but is compatible with the version 6
feature set. It needs a power-good handshake through the PMU GRF and
DLL delay-line training for clock rates above 50 MHz.

Add the version handling, DLL cell detection and training, and the
optional power-good poll. Parse the rockchip,max-dll property so boards
can limit the DLL training range.

Tested on an RK3506B board with the on-board SPI-NAND at 80 MHz.
DLL training selects cell 64; read and write are stable.

Tested-by: ZhuXiangyu <1194781887@qq.com>
Signed-off-by: ZhuXiangyu <1194781887@qq.com>
---
 drivers/spi/spi-rockchip-sfc.c | 201 ++++++++++++++++++++++++++++++++-
 1 file changed, 199 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index a85a260b..bfcad2fa 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -14,12 +14,14 @@
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spi/spi-mem.h>
 
@@ -112,7 +114,9 @@
 #define  SFC_VER_3			0x3
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
+#define  SFC_VER_6			0x6
 #define  SFC_VER_8			0x8
+#define  SFC_VER_9			0x9
 
 /* Delay line controller register */
 #define SFC_DLL_CTRL0			0x3C
@@ -168,23 +172,43 @@
  * 150MHz. No minimum or average value is suggested.
  */
 #define SFC_MAX_SPEED		(150 * 1000 * 1000)
+#define SFC_DLL_THRESHOLD_RATE	(50 * 1000 * 1000)
+
+#define SFC_DLL_TRAINING_STEP		10	/* Training step */
+#define SFC_DLL_TRAINING_VALID_WINDOW	80	/* Valid DLL window */
 
 #define ROCKCHIP_AUTOSUSPEND_DELAY	2000
 
+struct rockchip_sfc_powergood {
+	bool	valid;
+	u32	grf_offset;
+	u8	bits_mask;
+};
+
+struct rockchip_sfc_data {
+	struct rockchip_sfc_powergood powergood;
+};
+
 struct rockchip_sfc {
 	struct device *dev;
 	void __iomem *regbase;
 	struct clk *hclk;
 	struct clk *clk;
 	u32 speed[SFC_MAX_CHIPSELECT_NUM];
+	u32 cur_speed;
+	u32 cur_real_speed;
 	/* virtual mapped addr for dma_buffer */
 	void *buffer;
 	dma_addr_t dma_buffer;
 	struct completion cp;
 	bool use_dma;
 	u32 max_iosize;
+	u32 max_dll_cells;
+	u32 dll_cells[SFC_MAX_CHIPSELECT_NUM];
 	u16 version;
 	struct spi_controller *host;
+	struct regmap *grf;
+	const struct rockchip_sfc_data *data;
 };
 
 static int rockchip_sfc_reset(struct rockchip_sfc *sfc)
@@ -218,6 +242,33 @@ static u32 rockchip_sfc_get_max_iosize(struct rockchip_sfc *sfc)
 	return SFC_MAX_IOSIZE_VER3;
 }
 
+static u32 rockchip_sfc_get_max_dll_cells(struct rockchip_sfc *sfc)
+{
+	if (sfc->max_dll_cells)
+		return sfc->max_dll_cells;
+
+	if (sfc->version > SFC_VER_4)
+		return SFC_DLL_CTRL0_DLL_MAX_VER5;
+	else if (sfc->version == SFC_VER_4)
+		return SFC_DLL_CTRL0_DLL_MAX_VER4;
+	else
+		return 0;
+}
+
+static void rockchip_sfc_set_delay_lines(struct rockchip_sfc *sfc, u16 cells, u8 cs)
+{
+	u16 cell_max = (u16)rockchip_sfc_get_max_dll_cells(sfc);
+	u32 val = 0;
+
+	if (cells > cell_max)
+		cells = cell_max;
+
+	if (cells)
+		val = SFC_DLL_CTRL0_SCLK_SMP_DLL | cells;
+
+	writel(val, sfc->regbase + cs * SFC_CS1_REG_OFFSET + SFC_DLL_CTRL0);
+}
+
 static int rockchip_sfc_clk_set_rate(struct rockchip_sfc *sfc, unsigned long  speed)
 {
 	if (sfc->version >= SFC_VER_8)
@@ -321,6 +372,7 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
 {
 	u32 ctrl = 0, cmd = 0;
 	u8 cs = spi_get_chipselect(mem->spi, 0);
+	u32 voltage;
 
 	/* set CMD */
 	cmd = op->cmd.opcode;
@@ -375,6 +427,15 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
 	dev_dbg(sfc->dev, "sfc ctrl=%x cmd=%x addr=%llx len=%x\n",
 		ctrl, cmd, op->addr.val, len);
 
+	if (sfc->data && sfc->data->powergood.valid) {
+		if (regmap_read_poll_timeout(sfc->grf, sfc->data->powergood.grf_offset,
+					     voltage, voltage & sfc->data->powergood.bits_mask,
+					     1000, jiffies_to_usecs(HZ))) {
+			dev_err(sfc->dev, "wait for powergood failed\n");
+			return -EIO;
+		}
+	}
+
 	writel(ctrl, sfc->regbase + cs * SFC_CS1_REG_OFFSET + SFC_CTRL);
 	writel(cmd, sfc->regbase + SFC_CMD);
 	if (op->addr.nbytes)
@@ -521,6 +582,109 @@ static int rockchip_sfc_xfer_done(struct rockchip_sfc *sfc, u32 timeout_us)
 	return ret;
 }
 
+static int rockchip_sfc_exec_op_bypass(struct rockchip_sfc *sfc,
+				       struct spi_mem *mem,
+				       const struct spi_mem_op *op)
+{
+	u32 len = min_t(u32, op->data.nbytes, sfc->max_iosize);
+	int ret;
+
+	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
+	rockchip_sfc_xfer_setup(sfc, mem, op, len);
+	ret = rockchip_sfc_xfer_data_poll(sfc, op, len);
+	if (ret != len) {
+		dev_err(sfc->dev, "xfer data failed ret %d\n", ret);
+
+		return -EIO;
+	}
+
+	ret = rockchip_sfc_xfer_done(sfc, 100000);
+
+	return ret;
+}
+
+static void rockchip_sfc_delay_lines_tuning(struct rockchip_sfc *sfc, struct spi_mem *mem)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x9F, 1),
+						SPI_MEM_OP_NO_ADDR,
+						SPI_MEM_OP_NO_DUMMY,
+						SPI_MEM_OP_DATA_IN(3, NULL, 1));
+	u8 id[3], id_temp[3];
+	u16 cell_max = (u16)rockchip_sfc_get_max_dll_cells(sfc);
+	u16 right, left = 0;
+	u16 step = SFC_DLL_TRAINING_STEP;
+	bool dll_valid = false;
+	u8 cs = spi_get_chipselect(mem->spi, 0);
+
+	rockchip_sfc_clk_set_rate(sfc, SFC_DLL_THRESHOLD_RATE);
+	op.data.buf.in = &id;
+	if (rockchip_sfc_exec_op_bypass(sfc, mem, &op) ||
+	    (0xFF == id[0] && 0xFF == id[1]) ||
+	    (0x00 == id[0] && 0x00 == id[1])) {
+		dev_dbg(sfc->dev, "no dev, dll by pass\n");
+		rockchip_sfc_clk_set_rate(sfc, sfc->speed[cs]);
+		sfc->speed[cs] = SFC_DLL_THRESHOLD_RATE;
+
+		return;
+	}
+
+	rockchip_sfc_clk_set_rate(sfc, sfc->speed[cs]);
+	op.data.buf.in = &id_temp;
+	for (right = 0; right <= cell_max; right += step) {
+		int ret;
+
+		rockchip_sfc_set_delay_lines(sfc, right, cs);
+		ret = rockchip_sfc_exec_op_bypass(sfc, mem, &op);
+		if (!ret) {
+			dev_dbg(sfc->dev, "dll read flash id:%x %x %x\n",
+				id_temp[0], id_temp[1], id_temp[2]);
+
+			ret = memcmp(&id, &id_temp, 3);
+			if (dll_valid && ret) {
+				right -= step;
+
+				break;
+			}
+			if (!dll_valid && !ret)
+				left = right;
+
+			if (!ret)
+				dll_valid = true;
+		}
+
+		/* Add cell_max to loop */
+		if (right == cell_max)
+			break;
+		if (right + step > cell_max)
+			right = cell_max - step;
+	}
+
+	if (dll_valid && (right - left) >= SFC_DLL_TRAINING_VALID_WINDOW) {
+		if (left == 0 && right < cell_max)
+			sfc->dll_cells[cs] = left + (right - left) * 2 / 5;
+		else
+			sfc->dll_cells[cs] = left + (right - left) / 2;
+	} else {
+		sfc->dll_cells[cs] = 0;
+	}
+
+	if (sfc->dll_cells[cs]) {
+		dev_dbg(sfc->dev, "%u %u %u dll training success in %uMHz max_cells=%u sfc_ver=%u\n",
+			left, right, sfc->dll_cells[cs], sfc->speed[cs],
+			rockchip_sfc_get_max_dll_cells(sfc), rockchip_sfc_get_version(sfc));
+		rockchip_sfc_set_delay_lines(sfc, (u16)sfc->dll_cells[cs], cs);
+	} else {
+		dev_err(sfc->dev, "%u %u dll training failed in %uMHz, reduce the frequency\n",
+			left, right, sfc->speed[cs]);
+		rockchip_sfc_set_delay_lines(sfc, 0, cs);
+		rockchip_sfc_clk_set_rate(sfc, SFC_DLL_THRESHOLD_RATE);
+		mem->spi->max_speed_hz = SFC_DLL_THRESHOLD_RATE;
+		sfc->cur_speed = SFC_DLL_THRESHOLD_RATE;
+		sfc->cur_real_speed = rockchip_sfc_clk_get_rate(sfc);
+		sfc->speed[cs] = SFC_DLL_THRESHOLD_RATE;
+	}
+}
+
 static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct rockchip_sfc *sfc = spi_controller_get_devdata(mem->spi->controller);
@@ -540,8 +704,16 @@ static int rockchip_sfc_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op
 		if (ret)
 			goto out;
 		sfc->speed[cs] = op->max_freq;
-		dev_dbg(sfc->dev, "set_freq=%dHz real_freq=%ldHz\n",
+		sfc->cur_speed = op->max_freq;
+		sfc->cur_real_speed = rockchip_sfc_clk_get_rate(sfc);
+		dev_dbg(sfc->dev, "set_freq=%uHz real_freq=%luHz\n",
 			sfc->speed[cs], rockchip_sfc_clk_get_rate(sfc));
+		if (rockchip_sfc_get_version(sfc) >= SFC_VER_4) {
+			if (sfc->cur_real_speed > SFC_DLL_THRESHOLD_RATE)
+				rockchip_sfc_delay_lines_tuning(sfc, mem);
+			else
+				rockchip_sfc_set_delay_lines(sfc, 0, cs);
+		}
 	}
 
 	rockchip_sfc_adjust_op_work((struct spi_mem_op *)op);
@@ -657,6 +829,10 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	sfc->use_dma = !of_property_read_bool(sfc->dev->of_node, "rockchip,sfc-no-dma");
 
+	device_property_read_u32(&pdev->dev, "rockchip,max-dll", &sfc->max_dll_cells);
+	if (sfc->max_dll_cells > SFC_DLL_CTRL0_DLL_MAX_VER5)
+		sfc->max_dll_cells = SFC_DLL_CTRL0_DLL_MAX_VER5;
+
 	ret = clk_prepare_enable(sfc->hclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable ahb clk\n");
@@ -683,11 +859,23 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sfc);
 
+	sfc->data = device_get_match_data(dev);
+	if (sfc->data && sfc->data->powergood.valid) {
+		sfc->grf = syscon_regmap_lookup_by_phandle(dev->of_node, "rockchip,grf");
+		if (IS_ERR(sfc->grf)) {
+			ret = dev_err_probe(dev, PTR_ERR(sfc->grf),
+					    "failed to get grf\n");
+			goto err_irq;
+		}
+	}
+
 	ret = rockchip_sfc_init(sfc);
 	if (ret)
 		goto err_irq;
 
 	sfc->version = rockchip_sfc_get_version(sfc);
+	if (sfc->version == SFC_VER_9)
+		sfc->version = SFC_VER_6;
 	sfc->max_iosize = rockchip_sfc_get_max_iosize(sfc);
 
 	pm_runtime_set_autosuspend_delay(dev, ROCKCHIP_AUTOSUSPEND_DELAY);
@@ -823,8 +1011,17 @@ static const struct dev_pm_ops rockchip_sfc_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(rockchip_sfc_suspend, rockchip_sfc_resume)
 };
 
+static const struct rockchip_sfc_data rk3506_fspi_data = {
+	.powergood = {
+		.valid = true,
+		.grf_offset = 0x100,
+		.bits_mask = BIT(0),
+	},
+};
+
 static const struct of_device_id rockchip_sfc_dt_ids[] = {
-	{ .compatible = "rockchip,sfc"},
+	{ .compatible = "rockchip,rk3506-fspi", .data = &rk3506_fspi_data },
+	{ .compatible = "rockchip,sfc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_sfc_dt_ids);
-- 
2.47.3

