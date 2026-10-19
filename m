Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894F3D5227;
	Mon, 19 Oct 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399548; cv=none; b=sqcsTszmCVZMzoeCB3sd6Jv9sdIW9gUVnqzmY0Nk6mJHBKGGhUGH2mkFLpRCR+4QurA0yb2K8aZbTeFClloQSVA3EjKK+34JRNshUFbxgfW/zulm5QqhhPX6EkdRBaxf8hYp/By/sLi1+lxeXskvpzT5GFV2LXlYRiie3R4FedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399548; c=relaxed/simple;
	bh=1sC6tL3xiB8Bs4X81YVeYCiM+G+HJ4hyAZUJAg04XBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjPrZSGC/qSwN+A9YD7Rl3pXJNXrmJLD3DpZHJpLB9Pl8mAEYE0Zy937Oysi5YQ0Ki40ZpdWce1Xc+xjyyJIInriFiSai2Mekqejo+XiAGBUOKoKrwyiviylYC2h9bsc4XlTJclrcNdlS6AJHN5KyL6F+2DcHDpgxmfO4gvx1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=COrgKVXB; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="COrgKVXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=E0
	z+5oHpQTRQspcRGTh9XM1CoadJN2ADm1m9N7KDp00=; b=COrgKVXBHlFU0hy5Ts
	5tyQusbheb0GBgm9O+3h7b1/pAiNQnp+7+FlBxFgg8aXaidtOTfpf3iNwvOuYtaJ
	kswSZdRkhylSPYYxWb5FLYXyXNOhzpysaU9p4h4gLnHlkMuXHkE1xcmt7u/nFIg4
	fj5ehMj5mztjpJpSM88yOWNho=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnaJF82NVqrQQEAw--.30772S3;
	Mon, 19 Oct 2026 16:44:46 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/2] spi: stm32-ospi: handle runtime resume failure in remove
Date: Mon, 19 Oct 2026 16:44:42 +0800
Message-Id: <20261019084443.1824122-2-yaojiale02@163.com>
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
X-CM-TRANSID:QCgvCgBnaJF82NVqrQQEAw--.30772S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13CrWrGr4xJF4kXryxZrb_yoW8WFW8pa
	1UXa17Cr4kJa1rt3ZrZrW09FyY9a4ftrWDX3s7K3WxZ3s5Aryvqa95JryjvFs3JFykJa1k
	KF47tw4fZF4qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_4E_tUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B5ln2rV2H7GFgAA3d

stm32_ospi_remove() continues with the controller teardown when runtime
resume fails. The register write can then access an unavailable device,
and the final runtime PM put does not match an acquired reference.

Keep the resource cleanup, but skip the register access and matching
runtime PM put when the resume operation fails.

Fixes: 73cd1f97946a ("spi: stm32-ospi: Fix resource leak in remove() callback")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/spi/spi-stm32-ospi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index fa0e8e83cb1b..1340e62ebe1b 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -986,12 +986,15 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 static void stm32_ospi_remove(struct platform_device *pdev)
 {
 	struct stm32_ospi *ospi = platform_get_drvdata(pdev);
+	int ret;
 
-	pm_runtime_resume_and_get(ospi->dev);
+	ret = pm_runtime_resume_and_get(ospi->dev);
 
 	spi_unregister_controller(ospi->ctrl);
-	/* Disable ospi */
-	writel_relaxed(0, ospi->regs_base + OSPI_CR);
+	if (ret >= 0) {
+		/* Disable ospi */
+		writel_relaxed(0, ospi->regs_base + OSPI_CR);
+	}
 	mutex_destroy(&ospi->lock);
 
 	if (ospi->dma_chtx)
@@ -1001,7 +1004,8 @@ static void stm32_ospi_remove(struct platform_device *pdev)
 
 	reset_control_release(ospi->rstc);
 
-	pm_runtime_put_sync_suspend(ospi->dev);
+	if (ret >= 0)
+		pm_runtime_put_sync_suspend(ospi->dev);
 	pm_runtime_force_suspend(ospi->dev);
 }
 
-- 
2.34.1

