Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A617D6;
	Sun, 19 Jul 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784422895; cv=none; b=GyJ0mXWhjzuetlP7zMWcbUV+efPnGvjX5YT9VbQWTs5t4A3weo39xiGlDheIeaJXLqZ2v0b8/EsbRc5MnVihRS57OPHT8EyWlIv7EymHvJaYPuQUjKWr5WNOIMOeJxrqFJpSSPM89+cFrzLRslKplquxfRPLyVbsMj2JJtJ50+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784422895; c=relaxed/simple;
	bh=hL65SJUOHt+osSpbEZ+7mOCQUtvo8ggvTR+VE3XInWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jOgaHsI2C6rOPUy3588UWIUB7NzBekO9eEdY8zciaWR/csnVlJ1LdOzS4upWezaPyxLwnFc+6WY2NhbesYj4i97UzOGtulNthDXQwEtg92qILfgRN2Tyyd76RJhJTjtJI5FSDIf+BK4e9ZGxPEB5FzwlFaK8WMQYq4gFG4pNUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXZTXfIVxq27cQAA--.16949S3;
	Sun, 19 Jul 2026 09:01:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBHt8zfIVxqiPIAAw--.48030S2;
	Sun, 19 Jul 2026 09:01:19 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] spi: oc-tiny: switch to managed controller allocation
Date: Sun, 19 Jul 2026 01:00:13 +0000
Message-Id: <20260719010014.3163356-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBHt8zfIVxqiPIAAw--.48030S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?ng+nnwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI08z2GqJXdBIF5GQnIiyKcesIm5nJKFeZEhQLGs1rUPFNL5
	xlrX1ETFGJsCI1HhZBCp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGFWUKw1rKr1UuF1xuF17Arc_yoW5Zr4rpF
	WrWFWIyr48Ka1Yk3WUt3yUu3WSkw4IqryUC3s2gw1fAwn0qrsrtFyvyry0vayrCFykXw1D
	tr47ZrW8AFW3ZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY
	67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4rb1UUUUU

The controller is allocated with the non-managed spi_alloc_host() while
the interrupt is registered with devm_request_irq().  During removal,
spi_bitbang_stop() only unregisters the controller; the subsequent
spi_controller_put() then frees the controller together with its
embedded driver-private devdata, which is the IRQ handler's dev_id.  The
devm_request_irq() release action (free_irq()), which drains the
handler, does not run until after .remove() returns.  A late or latched
interrupt can therefore reach tiny_spi_irq() and dereference
already-freed memory (e.g. hw->base).

Switch to devm_spi_alloc_host() so that the devres LIFO order releases
the controller only after free_irq() has drained the handler, and drop
the now-redundant spi_controller_put() from .remove().  The probe error
path is simplified to direct returns.

This issue was found by an in-house static analysis tool.

Fixes: ce792580ea2c ("spi: add OpenCores tiny SPI driver")
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/spi/spi-oc-tiny.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 29333b1f82d7..1cd2a934c032 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -210,11 +210,11 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	struct tiny_spi_platform_data *platp = dev_get_platdata(&pdev->dev);
 	struct tiny_spi *hw;
 	struct spi_controller *host;
-	int err = -ENODEV;
+	int err;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct tiny_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct tiny_spi));
 	if (!host)
-		return err;
+		return -ENOMEM;
 
 	/* setup the host state. */
 	host->bus_num = pdev->id;
@@ -232,10 +232,8 @@ static int tiny_spi_probe(struct platform_device *pdev)
 
 	/* find and map our resources */
 	hw->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(hw->base)) {
-		err = PTR_ERR(hw->base);
-		goto exit;
-	}
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
 	/* irq is optional */
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq >= 0) {
@@ -243,7 +241,7 @@ static int tiny_spi_probe(struct platform_device *pdev)
 		err = devm_request_irq(&pdev->dev, hw->irq, tiny_spi_irq, 0,
 				       pdev->name, hw);
 		if (err)
-			goto exit;
+			return err;
 	}
 	/* find platform data */
 	if (platp) {
@@ -252,29 +250,23 @@ static int tiny_spi_probe(struct platform_device *pdev)
 	} else {
 		err = tiny_spi_of_probe(pdev);
 		if (err)
-			goto exit;
+			return err;
 	}
 
 	/* register our spi controller */
 	err = spi_bitbang_start(&hw->bitbang);
 	if (err)
-		goto exit;
+		return err;
 	dev_info(&pdev->dev, "base %p, irq %d\n", hw->base, hw->irq);
 
 	return 0;
-
-exit:
-	spi_controller_put(host);
-	return err;
 }
 
 static void tiny_spi_remove(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
-	struct spi_controller *host = hw->bitbang.ctlr;
 
 	spi_bitbang_stop(&hw->bitbang);
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_OF
-- 
2.34.1

