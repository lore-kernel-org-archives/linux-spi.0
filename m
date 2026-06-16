Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCB38C437;
	Tue, 16 Jun 2026 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622700; cv=none; b=rz5CTz+v//06/htegQKq/B3KGkva6A4QJezeU0hlr5dHoSIcAf3qMd/BJXtbIAuXQd7sOlEqERZ6vGBpNXf2Nvpo94zb5CkqG0Uo7nibTAknXgKdGoGhEfXGEp1yr7WspmJ/36Cn9+5gREq9RhB4jzEb/EkT1cC9IatnLYvgWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622700; c=relaxed/simple;
	bh=HrYjQPl0DkkLatyyGTc5NZFfWWnojs9DG2dtRJ8dk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBaYEx+awdsvf1QOvECk3opvvlwEFTlSJOv2OwQHzpdgcVrcJiyTDeGP2LlclBANW1EcddE2ndAaCrBva4sAoL+kOhDs9ZD8wgL/3ZFNBuRVe4ddSuTS3nIGeV19g545GAnBYFdQ72mUtSCB7wCqGI6e6dg4+y0AK1/yOWUY1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABHZt2oZzFq_gPxFA--.13207S2;
	Tue, 16 Jun 2026 23:11:36 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] spi: qpic-snand: free OOB buffer with ECC context
Date: Tue, 16 Jun 2026 23:11:29 +0800
Message-ID: <20260616151129.76060-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHZt2oZzFq_gPxFA--.13207S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWkuFWDCrWftw1fKw45Wrg_yoW8Wr47pF
	WUJa1DCFn3GF109asFvws5XF13t3s5XrZ293y5Z3yYvr1SqF18ua98JFySvrnxXF48CayS
	vr1I9Fy7GF1YywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-J5rUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

qcom_spi_ecc_init_ctx_pipelined() allocates qspi->oob_buf as part of the
pipelined ECC context setup. The buffer is then used by the raw and ECC
page I/O paths through the NAND ECC context.

The matching cleanup callback only frees the qpic_ecc structure, and the
init error path also skips the OOB buffer after it has been allocated.
Free qspi->oob_buf on both paths and clear the pointer so the ECC context
teardown owns all resources allocated during init.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/spi/spi-qpic-snand.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 66f2d1b78ade..6cc53586b8a8 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -394,14 +394,19 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	return 0;
 
 err_free_ecc_cfg:
+	kfree(snandc->qspi->oob_buf);
+	snandc->qspi->oob_buf = NULL;
 	kfree(ecc_cfg);
 	return ret;
 }
 
 static void qcom_spi_ecc_cleanup_ctx_pipelined(struct nand_device *nand)
 {
+	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
 	struct qpic_ecc *ecc_cfg = nand_to_ecc_ctx(nand);
 
+	kfree(snandc->qspi->oob_buf);
+	snandc->qspi->oob_buf = NULL;
 	kfree(ecc_cfg);
 }
 
@@ -1645,4 +1650,3 @@ module_platform_driver(qcom_spi_driver);
 MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
 MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
 MODULE_LICENSE("GPL");
-
-- 
2.43.0

