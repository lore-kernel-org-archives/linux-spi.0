Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBF476064
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040052; cv=none; b=Xy8RWk0xNWVpE/sPI0JNvr4J6lHypv92Cn2DjMsb1fVcX35Fn/43N0if4xtlEjej6OlFc26GYjrZ1ojtIWADUR0zL1oB9cvObYE/o5XjFut+pdjLxQxlpUwtLaM5uHherVcLPGTreZHUhfsiqAIHq/t6TyQnEdJdo5MzilqhzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040052; c=relaxed/simple;
	bh=CJUuoQ2iTfwcG6oeIrw7E+rGr4DRPBFegg1mGe30BQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnquyKHQ9tJYka0C2gDoAX2J22qfp+HVsxP2ceyATZEuQZbylSD5oiG6+hEZN55ghdQ9Pcnq17s60q1SzWz5AgvU5+F+44tJkD36Dmac/ugimTr/K+YSkKL+Z3U1xxsuvWu2KJz+GahSU21wC5zArmN3QVBXhZqpOsThK4XBkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTwQvbQX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTwQvbQX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b93204449so4061605e9.3
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789040047; x=1789644847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hbLnIWJycW550lJgcztROooyzxfaoCBFJTCFjxtrh3I=;
        b=JTwQvbQXoYmvd5WjFiN5Cty9lyfVXerC+Luhp2ACyu+xoyfBKzm31EJTDtw2LT7poj
         yVeXDCIMxUVJ+ex54TjCMPvBA1PBQkA1FifH7jU0pIoGD8sWBWGd+9rY9nWHAKVTCu6u
         UgkanNZafDTiiYpQ8pYGSpt6xWegucV9netyvnN0Tsh6TRVkyoB4xRbo6wOJcvgiIZXZ
         EpItQhLtQewTM3/+j1ZPVFKMIRrYSe0iPwoP3lCjffqWUpW7NfStBVYUHwqc554CnN1u
         XqBhW6sXy7sEI7E+r5OsvWq0DhqaBY6K7mD8flIN3ZkV37GAvbd3C35wo58RWvHwkABt
         GBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789040047; x=1789644847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbLnIWJycW550lJgcztROooyzxfaoCBFJTCFjxtrh3I=;
        b=F6HV+J2slpTy3aZCsKu+XGxjg1y2+V98pfqUQq82LxbMeK34RskDc85JaUjcpG48Kg
         CZ1UpdoiE94lZxsMOI8M1AzmiLZOBXl96hmNi1CGg6Vc5vObfkbk49CsvyD361MLmgJf
         VihNGtjk6ZktmqtRJypSaAPTZKSBk6NaHUGQe/Qx86L8bt881p9McE3GWK8XzRIwxSvY
         kdfpG84YbjxDLtun8+z3lGqTT5uq6vKu9fGxOAebcV0RIaGKrMAME2vr6F1RD95lWsRx
         EHYDqX+wtteNaYMQU5echyn69qAZA1/4EzL4Wf0YtRNfwVVfvy/4hnuRVFkh1NcqUb1J
         gEHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPq05bGbNnk2sgDX8lP6g1pPiWwRGF0gu3n9Xa4bqTtGyd7LcwintoAdJQGBdeg7BYSxJJknJRGRg=@vger.kernel.org
X-Gm-Message-State: AFuF++kFwegpTzP4zct1gOQ9htQ7c7WxBOIm02fGz0AgsZyTOQD1z2Na
	/495fj9tQjsC8VlKFxoARsKwYyiMrByEm5ZVu1VAW08bWohXunSPTGAj
X-Gm-Gg: AYBFou3BKIYLQK5SkQOV+hg5JWI+Ht213p91G/xkBFhcWoYlwxpDM3RFdvpFp7/9VBb
	kyHyGdse4b62b6jlbJ3FiyBHlCgr5BOaH2oLIz4l9zxMcC0DQCelesPW14QTYa7sWC1MRgmlsJw
	rDR4Gfpq1u+gJoDEM2BGai9w3hOc3+p9hdT6g2nfLn5rzcOw3U+q9J5SJjq9b0n+orvfHwjCpvs
	v8V212iIliC/kzHoAu6BS8FOGC0B8FAmCWu8FodS9oz5zgyUzcznF0vRKcpF96PvPJvmNmHURrL
	1IRnCmjVt0t2WFDA1ynlxieH14PgHcamaHtJqpBVb8hbUsqM/WPs3rwNazo7sYOm7EGjYCVO0lV
	2EJOOcdjQSycFhFr3mtG90MdbzEMxJcvNxos00joFRpE0uwgTItknF18Qm4AZzgYchd6EwBoU+Y
	tSVQQt30eTpraSIBVyUp1whmLXtAR6gW2iGtpFtwqq7FuHNy0pbHfPYHtjdEzQnXK26YBxyYJl1
	riBXqAZhUlfqXtH4fI=
X-Received: by 2002:a05:6000:2c0e:b0:484:3328:1ad1 with SMTP id ffacd0b85a97d-48590805fabmr30378346f8f.6.1789040047066;
        Thu, 10 Sep 2026 04:34:07 -0700 (PDT)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm49155813f8f.22.2026.09.10.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 04:34:06 -0700 (PDT)
From: Itai Handler <itai.handler@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	Itai Handler <itai.handler@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Thu, 10 Sep 2026 14:33:25 +0300
Message-Id: <20260910113325.717882-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has no ->shutdown, and platform_drv_shutdown() has no
fallback of its own.  Unlike pci_device_shutdown(), which clears bus
mastering when kexec_in_progress, nothing on the platform bus disarms a
device that can still write to memory.  The normal kexec path never
calls ->suspend either, so the quiesce in zynqmp_qspi_suspend() is not
reached.

A controller that is still executing a DMA read may therefore keep
writing to memory across a kexec.  QSPIDMA_DST_ADDR still points at
memory owned by the kernel that called kexec, DST_SIZE is non-zero and
the flash is still clocked, so data can keep landing in RAM while the
new kernel is being relocated, and after it has started executing.

That destination is a physical address which means nothing to the new
kernel, so the writes can corrupt whatever now occupies it: kernel text
or data, page tables, or the initrd.  Nothing reports an error and the
resulting behaviour is undefined.

This can be observed by reading GQSPI_EN (offset 0x114) and
QSPIDMA_DST_ADDR/SIZE/STS/CTRL (offsets 0x800 to 0x80c) early in the new
kernel, before the driver probes: without this patch GQSPI_EN reads 1
and QSPIDMA_DST_ADDR still points into the previous kernel's memory.

Write 0 to GQSPI_EN_OFST, as zynqmp_qspi_remove() and
zynqmp_qspi_suspend() already do.  Skip it only when
pm_runtime_get_if_in_use() returns 0, i.e. runtime suspended: the clocks
are gated, so the registers are unreachable and the controller cannot be
mastering the bus.  A negative return is not the same thing - it is what
the CONFIG_PM=n stub always returns, and there probe() has enabled pclk
and refclk for good, so the controller is running and must be stopped.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
Note for stable: before commit 1c26372e5aa9 ("spi: spi-zynqmp-gqspi:
Update driver to use spi-mem framework") this driver stored the
spi_master in the platform drvdata rather than the zynqmp_qspi, so a
backport to those trees needs spi_master_get_devdata() in place of the
platform_get_drvdata() used here.

 drivers/spi/spi-zynqmp-gqspi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 4d55090..24f680b 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1373,11 +1373,35 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->pclk);
 }
 
+static void zynqmp_qspi_shutdown(struct platform_device *pdev)
+{
+	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * Only a runtime suspended controller can be left alone: its clocks
+	 * are gated, so it cannot be mastering the bus, and its registers
+	 * must not be accessed either.  Any other answer means it may be
+	 * running and has to be stopped.  In particular, on a kernel built
+	 * without runtime PM this returns -EINVAL, and there the clocks
+	 * enabled in probe() are never gated at all.
+	 */
+	ret = pm_runtime_get_if_in_use(&pdev->dev);
+	if (!ret)
+		return;
+
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	if (ret > 0)
+		pm_runtime_put_noidle(&pdev->dev);
+}
+
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

