Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A349D59E;
	Mon, 19 Oct 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399505; cv=none; b=NjdZocQC8S8bOzpx7ZPNTintdqyRrRSisd0ZaCyFXLPIP6ioxF7zRyZCyq2h9n8oRnVA+ciOeHNZDf/+jezTbwLwaMku+WAznqDk0OKXeGFwh5SSaYgFf2LwZGjDtlEVDMNKU1Q6zlOPvWAelFM7qAvSG9K11k9Ol154HntzYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399505; c=relaxed/simple;
	bh=jbmFSG9mPsEMwuxYqVKEO8Pel7QDVgG0BG7FmKZFkwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujrTxqYEQU/IbOInKMwnMt195kdQYNLa5snDi5WLanGZqqGU4354ktLJCsg+S6dmdNK15Al0hwucOjc7NcLIVJ2VS43My/pnP/tOrVrHaDjJlK+vFjPJhDubRw0RnLM35xd89Cn2WvWOWQUjuikxS3FJFkv+hWszpGXTVo5RXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mb12/rNc; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mb12/rNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xH
	UsrYUV0SNK3aD3oYbsFplA/eBNjf0yVTrM1RoiJZo=; b=Mb12/rNcOpalGdL6Mm
	jmMqzJUa7LIfu9+rel1hIYuzhLW4ydjdXI77E2RIUbKhSgGU+MzwiCdjvTx2BtAx
	dwsIQ4VTWYV9HzAjgx4sNabDoRKMbB5jLea3NhyetJ9W0fzlsCye7hmfEroV7QyN
	57w3d9nbTdsv6qCjGcikNmQvw=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnaJF82NVqrQQEAw--.30772S4;
	Mon, 19 Oct 2026 16:44:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mark Brown <broonie@kernel.org>,
	Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 2/2] spi: ti-qspi: handle setup clock runtime resume failure
Date: Mon, 19 Oct 2026 16:44:43 +0800
Message-Id: <20261019084443.1824122-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019084443.1824122-1-yaojiale02@163.com>
References: <20261019084443.1824122-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnaJF82NVqrQQEAw--.30772S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFyDZry8Kw4rXw4UZr4ruFg_yoW5Aw13pa
	18u34xtFy8tr4UCrn7Aw4kZr1ak3yxXFW3CwnxK3s3Zr12qwnrKF4UWFy2yF4fGF97J3Wk
	uF40vF4rWw1jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieT5XUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x9ln2rV2H9FzAAA3b

ti_qspi_setup_clk() writes controller registers after an unchecked
pm_runtime_resume_and_get() call. Runtime resume can fail, leaving the
controller unavailable while the helper continues with the register
access and later drops a reference that was not acquired.

Return the runtime resume error from the helper and propagate it through
the memory-map and transfer paths before any clock register access.

Fixes: 8d0b512844fd ("spi: spi-ti-qspi: Support per-transfer and per-slave speed_hz settings")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/spi/spi-ti-qspi.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 34b154922ff2..5851574a4292 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -167,10 +167,10 @@ static int ti_qspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
+static int ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
 {
 	struct ti_qspi_regs *ctx_reg = &qspi->ctx_reg;
-	int clk_div;
+	int clk_div, ret;
 	u32 clk_ctrl_reg, clk_rate, clk_ctrl_new;
 
 	clk_rate = clk_get_rate(qspi->fclk);
@@ -178,7 +178,9 @@ static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
 	clk_div = clamp(clk_div, 0, QSPI_CLK_DIV_MAX);
 	dev_dbg(qspi->dev, "hz: %d, clock divider %d\n", speed_hz, clk_div);
 
-	pm_runtime_resume_and_get(qspi->dev);
+	ret = pm_runtime_resume_and_get(qspi->dev);
+	if (ret < 0)
+		return ret;
 
 	clk_ctrl_new = QSPI_CLK_EN | clk_div;
 	if (ctx_reg->clkctrl != clk_ctrl_new) {
@@ -195,6 +197,8 @@ static void ti_qspi_setup_clk(struct ti_qspi *qspi, u32 speed_hz)
 	}
 
 	pm_runtime_put_autosuspend(qspi->dev);
+
+	return 0;
 }
 
 static void ti_qspi_restore_ctx(struct ti_qspi *qspi)
@@ -621,7 +625,9 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 	mutex_lock(&qspi->list_lock);
 
 	if (!qspi->mmap_enabled || qspi->current_cs != spi_get_chipselect(mem->spi, 0)) {
-		ti_qspi_setup_clk(qspi, op->max_freq);
+		ret = ti_qspi_setup_clk(qspi, op->max_freq);
+		if (ret)
+			goto unlock;
 		ti_qspi_enable_memory_map(mem->spi);
 	}
 	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
@@ -646,6 +652,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			      op->data.nbytes);
 	}
 
+unlock:
 	mutex_unlock(&qspi->list_lock);
 
 	return ret;
@@ -704,7 +711,11 @@ static int ti_qspi_start_transfer_one(struct spi_controller *host,
 		wlen = t->bits_per_word >> 3;
 		transfer_len_words = min(t->len / wlen, frame_len_words);
 
-		ti_qspi_setup_clk(qspi, t->speed_hz);
+		ret = ti_qspi_setup_clk(qspi, t->speed_hz);
+		if (ret) {
+			mutex_unlock(&qspi->list_lock);
+			return ret;
+		}
 		ret = qspi_transfer_msg(qspi, t, transfer_len_words * wlen);
 		if (ret) {
 			dev_dbg(qspi->dev, "transfer message failed\n");
-- 
2.34.1

