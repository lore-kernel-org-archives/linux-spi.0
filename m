Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9635B63B;
	Fri, 14 Aug 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677333; cv=none; b=D8u9y8Xfi06c7ukQptVJaU4IfSWf52n6zALWdK7pZ68iF7SrfsCyfPMc6NJo/1Y2p4oD90N0Q46s8ht7H2QmXHpufyUgTg55Pzv7eKephwOGa4uyR/+6RwHzIBqeDYlbdNFCSZiMQrFHtaaJzMN7UL+MkonLEh50CtlB0/5E2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677333; c=relaxed/simple;
	bh=m6wLsI8IVMiYEbFVY7/NQs5I4xpWQ2WB7HifDiZb48o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+7dVQbc0KTPU4fQcmfgF4t6+YveNauJXokWkumWHmTgMlHpBcAZZB2W337PoUuEMYPFTdJoaE1k2LrkAfTkywFEAw5JdxvAE89wBYXmxHt/yba99nOFddCHFvaxEoc4SUewkhNa8JggKgTRwO93aTDpB7z8Hxi00D9C8vANi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DvLd/hqo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DvLd/hqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/j
	mzp83YFF+Pnp4Q+QVoHubLBQ9hENJo3+6hDIjgJLQ=; b=DvLd/hqo4ySbG4usL5
	tNJn9w1I1D/4KkEWNvjfLWAgvgOZV8Ya4y7KNOFe7x5VczXT4F5/qB/YRgyJdGIK
	k6eM8XPzx/EqMe6b5khh/qnGjHOUl5K7QLG6xW7x8MUJSyrFL1iOLfMe2v0Dm2tU
	61EizQj57d4OlY9Xtj8MMxnCY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAXtfsQiH5q0wLOLA--.8409S2;
	Fri, 14 Aug 2026 11:14:25 +0800 (CST)
From: Honghui Jiang <jiang_hh2019@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Honghui Jiang <jiang_hh2019@163.com>
Subject: [PATCH v2 2/4] spi: Move __spi_unmap_msg() before __spi_map_msg()
Date: Fri, 14 Aug 2026 11:14:16 +0800
Message-ID: <20260814031419.43378-3-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814031419.43378-1-jiang_hh2019@163.com>
References: <20260814031419.43378-1-jiang_hh2019@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAXtfsQiH5q0wLOLA--.8409S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw17KryUuF48Zw48ZFyxKrg_yoW5Gr1fpF
	4fJFWjyrW8JF4FgFnIqw4Y9rnxta97G39rW3yakwnYkw1DtrZxJFyUC3WfJF98GFy7X3Wx
	CrWYyFW8Gw1rArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRfgA7UUUUU=
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC0xFgoGp+iBHPkQAA3R

Move __spi_unmap_msg() above __spi_map_msg() so the mapping error path
can call it without a forward declaration. This is a code-only
relocation with no functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Honghui Jiang <jiang_hh2019@163.com>
---
 drivers/spi/spi.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 12b3a3b29..96f5058c7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1231,7 +1231,29 @@ void spi_unmap_buf(struct spi_controller *ctlr, struct device *dev,
 	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
 }
 
-static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg);
+static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
+{
+	struct device *rx_dev = ctlr->cur_rx_dma_dev;
+	struct device *tx_dev = ctlr->cur_tx_dma_dev;
+	struct spi_transfer *xfer;
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* The sync has already been done after each transfer. */
+		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
+
+		if (xfer->rx_sg_mapped)
+			spi_unmap_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
+					    DMA_FROM_DEVICE, attrs);
+		xfer->rx_sg_mapped = false;
+
+		if (xfer->tx_sg_mapped)
+			spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
+					    DMA_TO_DEVICE, attrs);
+		xfer->tx_sg_mapped = false;
+	}
+
+	return 0;
+}
 
 static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 {
@@ -1300,30 +1322,6 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	return ret;
 }
 
-static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
-{
-	struct device *rx_dev = ctlr->cur_rx_dma_dev;
-	struct device *tx_dev = ctlr->cur_tx_dma_dev;
-	struct spi_transfer *xfer;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		/* The sync has already been done after each transfer. */
-		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
-
-		if (xfer->rx_sg_mapped)
-			spi_unmap_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
-					    DMA_FROM_DEVICE, attrs);
-		xfer->rx_sg_mapped = false;
-
-		if (xfer->tx_sg_mapped)
-			spi_unmap_buf_attrs(ctlr, tx_dev, &xfer->tx_sg,
-					    DMA_TO_DEVICE, attrs);
-		xfer->tx_sg_mapped = false;
-	}
-
-	return 0;
-}
-
 static void spi_dma_sync_for_device(struct spi_controller *ctlr,
 				    struct spi_transfer *xfer)
 {
-- 
2.43.0


