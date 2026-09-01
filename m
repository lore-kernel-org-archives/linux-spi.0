Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B1396585
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231124; cv=none; b=NGifMkIpaVwuP5g7QOl8FWHjdHaEbJw/J5rXFRt18ezh0PYQOXVEQqUrd7ClMguxBha2LeKwyK/1ELYkEEsTy5m715hdkhVP7stj9hqdVMVeEeu9EoPCTF0Wr4LQViWvKWBvrQjw7LUwZp8h3WXxZcN5n41Np7rhxOwo9aT/f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231124; c=relaxed/simple;
	bh=prt2hkMi9GWN5msRjQ5ekIkTxQHIbvhqaYytq7D+fAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCGe6oXDjdcQsrUqw/XutA/LpRyA2rzhNimbDq3ZQyce/eLTdBg5iPDaPFFiW39LIREi54/y58G+cm+Te2rjyXywtsPc5mG+cIaUQvUnMHaXqN6UFmxoai+NZXlGnC2IHaSWcsrf3J1eNs0ztycqygu8QhabpW1zJfw9U584A5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=julSyJEf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="julSyJEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FU
	81qntwAFVdmVb/UmW5+/CYllzLnCuEzEsQatHhMLA=; b=julSyJEfZcSqmgFYWU
	v1gfoKz744FUqnFfVfos86QMdr6oXu5D8gxOaEoy6J6W8oeEW17T5dAYmjtAhtHG
	ZVONcfPaWeI05INJIWJUl9zzDsCysyTzdvpKSkbkk5Txfq5n6mZfRzgBSZoXdW2i
	3NWcurGYN89jw/BN9fkY9rriI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnbpiyPZZqN4jWSg--.25091S2;
	Tue, 01 Sep 2026 10:51:30 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] spi: ma35d1-qspi: assert reset on probe error paths
Date: Tue,  1 Sep 2026 10:51:29 +0800
Message-Id: <20260901025129.359960-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnbpiyPZZqN4jWSg--.25091S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4UGr1rGryxXF4DZw1UWrg_yoW8uFy3pF
	srGF4FkFy0q3WfX3y3Aa1DXF1YkFyIva1UGrW2gw1xZrZ5tryDJw17AFWfK3ZrtFyjya47
	JFWUZay8CFsrZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOjjgUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hO7amqWPbOc1wAA3B

From: Li Youhong <liyouhong@kylinos.cn>

nuvoton_qspi_probe() pulses the exclusive reset and leaves it
deasserted for normal operation. Later probe failures returned
without re-asserting the reset, leaving the controller out of
reset after a failed probe. Assert the reset on those error
paths.

Fixes: 78b16af159ae ("spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/spi/spi-ma35d1-qspi.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 7f938d0c6f1f..cf731fa2f7e2 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -633,12 +633,16 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "failed to deassert reset\n");
 
 	ret = device_property_read_u32(dev, "num-cs", &num_cs);
-	if (ret && ret != -EINVAL)
-		return dev_err_probe(dev, ret, "failed to read num-cs\n");
+	if (ret && ret != -EINVAL) {
+		ret = dev_err_probe(dev, ret, "failed to read num-cs\n");
+		goto err_assert;
+	}
 
-	if (!num_cs || num_cs > NUVOTON_QSPI_MAX_NUM_CS)
-		return dev_err_probe(dev, -EINVAL, "invalid num-cs %u\n",
+	if (!num_cs || num_cs > NUVOTON_QSPI_MAX_NUM_CS) {
+		ret = dev_err_probe(dev, -EINVAL, "invalid num-cs %u\n",
 				     num_cs);
+		goto err_assert;
+	}
 
 	ctlr->num_chipselect = num_cs;
 	ctlr->max_transfer_size = nuvoton_qspi_max_transfer_size;
@@ -655,14 +659,20 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 
 	ret = nuvoton_qspi_hw_init(qspi);
 	if (ret)
-		return ret;
+		goto err_assert;
 
 	ret = devm_spi_register_controller(dev, ctlr);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to register spi controller\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret,
+				    "failed to register spi controller\n");
+		goto err_assert;
+	}
 
 	return 0;
+
+err_assert:
+	reset_control_assert(rst);
+	return ret;
 }
 
 static const struct of_device_id nuvoton_qspi_of_match[] = {
-- 
2.25.1

