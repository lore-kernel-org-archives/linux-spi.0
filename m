Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550768;
	b=gKmkCutmik08MUZMzcKFIBZq0at2krudzzWMZY61pHRxPcfz2lYhqbLHol1ylRKGV69b
	 SsmmBMMBedMRocy0ifQf7/nfC1Nx1bUVrYRnhT0Kf9nZVV4hdPKEEla8hg0jfA/rTvPQH
	 BC0tpyqAzLKYEt5pQO8aRilLHHhsnsnGrKWh5VHngyevROhwgN5LFyY9suEYI17xEcaC8
	 h+Lt3THyZm5LpilDShD1mI5O6ULsVvYSAH42MZmrcDWwEnbEIxbiymLluEgiKjEOyBYP4
	 DKda88tKmZ6Ki2M2r8z1dHJOcR6JY1ps8EpDZAwB4A5sxmAK39nM++SVelSbe2DuqSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RyXQwyWynVfXHdKU0E4ZYcDDObjBA4aLJVjCkOb/ED4=;
	b=WQsn5hWxEomkntd4Sf5oz1+17nieLiULJZ1VvXmE71ot1CjsJ3mMAvkaYLUPla+jdGIy
	 QKDuC1Rjv4aEQfW007RXYLW/Vev79lJWLMojy57p/6eXgly34nnl4UtibUGhGT7fe9cVH
	 CBbJotrIs86tU/GocIwXsqdXYBrb+dH7+LbGSzASVjGHho7XKP+jxQdEIJ9apueYIcP2w
	 6sPMkt32EurM7eLkbJEnHiP9uZTc1UhV/EiGvwUROdVF14gxUhVw6zRgMTAiiKmH2Z/Zv
	 H3ifbaxYYsC2URUc17iodvqkR9fTfa7xJDJATQNHhqdnLGIchEOiz4j2SZ5SvjzMGnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ayOxp/3c";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E2606A324
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 16:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ayOxp/3c
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1f80b7bf6so2960825e9.3
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550767; x=1794155567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyXQwyWynVfXHdKU0E4ZYcDDObjBA4aLJVjCkOb/ED4=;
        b=ayOxp/3cYiA511HvLHeR3I7kI4JX2H8rYHM8fVo83VOvHVuwdrX+rOmqhP8JczQkCf
         NqrenYh0TP5xWMhh9Mv7JQ1HFTVqvE9wiKXu677KcRUqIEKEEBCRQGZkbWTJB31JtqiE
         OgjQhqmZo5tzMuRPMtCVmORG7zgmv7fOuzQ0mde7LyDiTzkTEKSttvEsPUgcRT3kM3/m
         VCRm1idDMdBj3dYf8FHsBlt+sYHQR6WTNDA44zWceVpaZAMpLlKg6fvYHbQP0MsqRS6y
         miuBQrReD1f2xjL6fm6/qLp80vlBVGgn+YrG4bqSmk7WbpDkkON3JfdFrlvUnukHbj3e
         F+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550767; x=1794155567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RyXQwyWynVfXHdKU0E4ZYcDDObjBA4aLJVjCkOb/ED4=;
        b=vNXCFlJl2TzWRYDOEMUgiRjQPbV1erLrskYdYJmQopEk8qd6f0AdffTwCljUXr6Tw7
         4uOHh2PCM+Mz+TRBmkyGIfrgrhaDTFKNnCAqTYdOFBo9XVCFSLcw7Lgzj3jrdmgGkPNy
         lnOGXxIjZFUWHTK3RDIYj6cagUmd1k1piWuBzJx7Q1BzmxL6AkaZRqtHMmP4PwEcrENw
         Q6TnE+4i0Q2U6qcRiObW04aCa4ovs+o3M+H3urWl377hWBvjQTJathMthMGWm+T/cBuc
         wxFAvTRMSo0jrfNEsgWZpUkiWKgZBXHSwSiHNTYweZBDhjLT9Z3hXBV5rrpcCwjF7OWi
         P8eA==
X-Forwarded-Encrypted: i=1; AKwUvBy34M3a9ZFGScCoqHjm9EHtwYLndjY+QI5bWLOc4bWw28dAuXQ+UU8BnIND/v8qNy3fSkGQFouxtrw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLf6xOPCgubPOHtogswirmk3Zv9K+iJA3ARNQcpj9fZHKgPLoS5
	p1Pb48vXtnpVF659RgkR3geZUP9ze6sd999g2kvyJ0W2FB5oguF8vaIp
X-Gm-Gg: AYBFou3GOq7PMsgOdSxwQkCn6rG6djzf6w6lNhhU/+CFza+ojEiLYoG7thcphuwR7d+
	3J6tU9O2FdLr4rcgdnPS61Ct3W7UGqzO+rWtTxRnKpF5BovMW1X8u0NaNwXG9yLau4ECAVs0Zxh
	EvCp/gKXK4m6MnvdPXOqgRdYBLm7Qsk9x+MAcQKXc/Fi/Jtq86lBBb1Y0xbFlgYFfXaaqZLWUAY
	ZuSVjbmubwEykV4AKkVX6fx2uGIPeKLSvw0xjmFsD85/NTwhRsprdoIxvLKd4BHADAjpFbBPn0y
	R3hjvpyKhzM1M+LVuNlIcqdFlALAMdTtCq2/sC513UHbU5gFnKkwoO3uE0z9KFeI9msE2aBjF6w
	qnGi8SnMqgvI/M176XhXmK/h5vlvwwZEbTVzRJqIEjvzwP7/BjroQQElYhPNIHNo7e7QpzVZpMo
	qVUnM4SSD4OnLLsYt2xnYvItCYhkS0fJcPmzOcCYVCg1EbRR1FFW9TSZz4w/Op5IfVL5qa4Mch/
	InuthExJ4bOwx4W377TBS0v9IwvuBacruEGmxkqk3ud/vQSz51HX4pzNTz52u5Eyr3OhuPkBn6n
	xCQnGxyACZQcq5+zaW0no1WYumQkcUxwuO+QSA491mPQ5a53+w==
X-Received: by 2002:a05:600c:1c06:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4ac12194311mr219582685e9.0.1793550766921;
        Sun, 01 Nov 2026 08:32:46 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:46 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 5.10.y v2 4/4] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Sun,  1 Nov 2026 18:31:54 +0200
Message-Id: <20261101163154.2274099-5-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
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

commit e922bad8b2d5028c51a096d083fea41cd0987154 upstream.

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

Add a ->shutdown that stops the controller the way zynqmp_qspi_suspend()
already does.  spi_controller_suspend() stops the queue, waits for a
message that is already executing and makes any later transfer fail with
-ESHUTDOWN, so nothing can be cut short by the register write that
follows.  It may sleep, which is fine here: device_shutdown() runs in
process context.  Unlike ->suspend this cannot abort on error, because a
controller left mastering the bus is worse than a truncated transfer, so
a failure to drain is only logged.

GQSPI_EN_OFST is then cleared, as zynqmp_qspi_remove() and
zynqmp_qspi_suspend() already do.  Skip that write only when
pm_runtime_get_if_in_use() returns 0, i.e. runtime suspended: the clocks
are gated, so the registers are unreachable and the controller cannot be
mastering the bus.  A negative return is not the same thing - it is what
the CONFIG_PM=n stub always returns, and there probe() has enabled pclk
and refclk for good, so the controller is running and must be stopped.

Fixes: dfe11a11d523 ("spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Itai Handler <itai.handler@gmail.com>
Link: https://patch.msgid.link/20260910174832.873352-1-itai.handler@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ itai: context only - zynqmp_qspi_of_match[] still sits between
  zynqmp_qspi_remove() and MODULE_DEVICE_TABLE() in this tree, hoisted to
  the top of the file upstream by commit 29f4d95b97bc ("spi:
  spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal
  platform"), so zynqmp_qspi_shutdown() is placed above it ]
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 167eb9072c3e..840ba03b204a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1230,6 +1230,39 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void zynqmp_qspi_shutdown(struct platform_device *pdev)
+{
+	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * Stop the queue and reject any later transfer first, so the write
+	 * below cannot cut into a message that is still being executed.
+	 * Unlike ->suspend this cannot abort on error: a controller left
+	 * mastering the bus is worse than a truncated transfer.
+	 */
+	ret = spi_controller_suspend(xqspi->ctlr);
+	if (ret)
+		dev_warn(&pdev->dev, "could not stop the queue: %d\n", ret);
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
 static const struct of_device_id zynqmp_qspi_of_match[] = {
 	{ .compatible = "xlnx,zynqmp-qspi-1.0", },
 	{ /* End of table */ }
@@ -1240,6 +1273,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
 	.remove = zynqmp_qspi_remove,
+	.shutdown = zynqmp_qspi_shutdown,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.34.1

