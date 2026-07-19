Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0014ABE;
	Sun, 19 Jul 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784422894; cv=none; b=XGaqo9rqA+trohJfhI0+lE6akA8MRv3avY49+gQV6ax3ltsFSxjEiS5SfY6gp/B0MyH1beCpIp6SBhVnRqELuOhGTDdM0d+WBD2tUVB1ICu+L+R+qzUhVfvbJMlKzBBI4oq2qG7B5EJbZ8zcbUHB7kxl/ivdT8eg1/reretx/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784422894; c=relaxed/simple;
	bh=FZg7QYMDFrrTBdgjp4YEySBn7SYcam+c4jwWN1HtBNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PElTk2cJxP03r+q3LXjdmzkpMVEH3+h9wQ+BIF52oPSrACru83M93UExq4Khft/P17GbzRRQMlwa1gbC4V8uoDwYTSLEdtmntY4ApQxEBoHBFa4Dan2+1r56bw4CV/+9dOlOGC5izPKz2AF52Wq4s/bELyIS8Wtwb/wzuzREUDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHMfffIVxq2bcQAA--.38100S3;
	Sun, 19 Jul 2026 09:01:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBHt8zfIVxqiPIAAw--.48030S3;
	Sun, 19 Jul 2026 09:01:19 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] spi: davinci: switch to managed controller allocation
Date: Sun, 19 Jul 2026 01:00:14 +0000
Message-Id: <20260719010014.3163356-2-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBHt8zfIVxqiPIAAw--.48030S3
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?Yw9d9wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI1QM3FeDoiIemi1/PTnfhEmsIm5nJKFeZEhQLGs1rUPFDFW
	5QQ3gQipZtKrpUeEbDip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxGr4DZFykKw43AF1fWw13ZFc_yoW5Xw17pF
	W5JFW3ArWDtw45K3Wjya1ru3WfCw1Sqay2k397Kw1fAw1agryvqrnY9Fy0yFZ8AFW8X3Wv
	gF45ZayrZF9rZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8w
	AqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8I
	cVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjc
	xG0xvY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8I_M3UUUUU==

The controller is allocated with the non-managed spi_alloc_host() while
the interrupt is registered with devm_request_threaded_irq().  During
removal, spi_bitbang_stop() only unregisters the controller; the
subsequent spi_controller_put() then frees the controller together with
its embedded davinci_spi devdata, which is the IRQ handler's dev_id.
The devm_request_threaded_irq() release action (free_irq()), which
drains the handler, does not run until after .remove() returns.  A late
or latched interrupt can therefore reach davinci_spi_irq() and
dereference already-freed memory.

Switch to devm_spi_alloc_host() so that the devres LIFO order releases
the controller only after free_irq() has drained the handler, and drop
the now-redundant spi_controller_put() from .remove().  The probe error
path is simplified to direct returns.

The clock is acquired with devm_clk_get_enabled(), which is registered
after the IRQ and thus released before it by the devres LIFO order.
Drain the interrupt explicitly with devm_free_irq() before disabling the
controller so that a late interrupt cannot access the registers of a
clock-gated controller.

This issue was found by an in-house static analysis tool.

Fixes: 5b3bb5963ff2 ("spi: davinci: Use devm_*() functions")
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/spi/spi-davinci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index da7f2ae3a570..087735ed9c80 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -928,7 +928,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	int ret = 0;
 	u32 spipc0;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct davinci_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct davinci_spi));
 	if (host == NULL) {
 		ret = -ENOMEM;
 		goto err;
@@ -1057,7 +1057,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_tx);
 	}
 free_host:
-	spi_controller_put(host);
 err:
 	return ret;
 }
@@ -1081,6 +1080,8 @@ static void davinci_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&dspi->bitbang);
 
+	devm_free_irq(&pdev->dev, dspi->irq, dspi);
+
 	/* This bit needs to be cleared to disable dpsi->clk */
 	clear_io_bits(dspi->base + SPIGCR1, SPIGCR1_POWERDOWN_MASK);
 
@@ -1088,8 +1089,6 @@ static void davinci_spi_remove(struct platform_device *pdev)
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
-
-	spi_controller_put(host);
 }
 
 static struct platform_driver davinci_spi_driver = {
-- 
2.34.1

