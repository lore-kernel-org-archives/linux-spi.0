Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00321946DA
	for <linux-spi@vger.kernel.org>; Sun,  1 Mar 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772384927; cv=none; b=X3Zh7xwTGCkvwAEcAcYTx77t3s7P4edoAEKbqXeDIUgp4RMvxnNJ49SP0Mu2vaaQ0yONCoyz2wjSRnvr0blfpqjZUufZspnZKkdXp4paH2BO/fFz39DsQ3iB0BQE9PjgS3E5rTaKlXJqLxttCQR89/SDVf9y2yJq6RshbQA3ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772384927; c=relaxed/simple;
	bh=yRcPxQvhGF4Ecv8niJ2audTUHBcYg9U8KcKsj1DASZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lBGQOrAH0Jbu6SPS+r7Wkvh0AwoLen3xU5rTP5W5ODnRsxMP8chS2OBnJmTUZj1a0CDyErpxlKqBIbFLcnKs/l9Mx5+vF/o8Xsz59OpYCYAtO0KYS2OojGZAMl9tciqlQlyQWPysnjzx1sh55LVjUn0qc+WLTTG2sJb/XgSHyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaL4ONfe; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaL4ONfe"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1325815a12.1
        for <linux-spi@vger.kernel.org>; Sun, 01 Mar 2026 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772384925; x=1772989725; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JC8dtCejMLT5Ebas54y2Sb5Ey1Dlmdy+AbqrqYYmf+k=;
        b=DaL4ONfeVzP0B7gbzDeGEKvBjLLXzLadxcKSGR53fVSRzPIs8c14Pef0N/MJc6tfXu
         6PPkxv4WrEUJl9sHOCg5UoozCmvlOLLEFCApuP3zg0LKGtlNZ5SPOKSk9X1xNCbPOxHs
         s4sKQZqJj7FnBIrBSqugOmFb/xeEUcvPpvU2mkicR5p7pMm50ZqI9L6bvmAaWYQCLdyh
         IpQ7FTNZ7sM+v6swyl4hA3YX8V5m1f56HNSeDA7FIFNBzb6NBW6jbPem4cEZeyZvT0MN
         KiYZdWbS0fdrXeD3VYJtLvS6JwEAlNBLAkuA0eko3pxRicg8Qnu+N7i3uSh1PqirxOue
         8gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772384925; x=1772989725;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC8dtCejMLT5Ebas54y2Sb5Ey1Dlmdy+AbqrqYYmf+k=;
        b=LUprpiyokCAz4pgRBnIGJqD4344UvdA0cgoQGGMikzfKXbutRU9T1dWcEA+oEFhn9A
         vnoIdNUc8Qm9fZy1IrHoj6+VynfeEb9QQ2fOjpznonx4tY14sfAcsOmuX4YUPdOvs0RL
         5VntOUX0udAeYeu0exqA3c6corpEFu5J8Iixbb3D6UyuNdU4EzkSB0veO9DSwOrI0Flp
         5sn5Fg5U7Ffp45IZdhILZ2jnwq5BkM1GTarP8f90AR8zJV0S3Rc3TuTLrZDUz0dvI8lS
         lDA/xpxGHI3jsqaB6XD8ILoZWf8Lk9l2hkqBNvi+8wX2VeI0qwxmbfpXelHZtaJJXpn6
         1q6w==
X-Gm-Message-State: AOJu0YxlM7btFnApGL/4bq85cdU4w9S7COjmC0na+WrfHJrwucGYyL15
	hfYH7s2/PVvUDCSPgVNOv3E/DAwgyDWx4RM4GhDF+rprWrH4HfUxRC25N30zwaDjM+g=
X-Gm-Gg: ATEYQzxnX0NdwJVYLHsPkRvI8C4+086Ifl1w7oU00hz4jN8a4s/j/h3QXBq8F/rpwvN
	zFIAsVkMEeyWdKiDoHjCiIBeQz1ZJyCZmgUQ9KzK2aImE4FEAHrIoGz9Ohc6+tDSPZVVDbogSMb
	l+bACHIS02P2WqfT2WaDeRqO5D8ZiXqcTzfuw1n8F42xg94UpqtzTdaxuYhzNKA5+nUu7f1a/Hj
	fq7aDRD8BfbnVdOD59R6BpwOeZK0QUtBiwVV8JmU1trzJxdbZLF+EIpuUg0qnc2uTJ5AGxq5fDB
	QM/y3VqZDynJbgmT/3vKWqWpjEx9oeTJ7KA3kYQxsH2R9mmG10zspwGL/yR04PJ5bJAOjzpmoR1
	8oUIZWr51we/qAiGbJ1wyDAXr2U4ZrU9pQ5uGcnQMSP2dHG/f9QDbtKCqgxbDQ84X1QQi2uNSxk
	lt2SP4ZK1rtwUz8XohrPBu7qGs2BROY/emYQzJ
X-Received: by 2002:a17:902:e884:b0:2ad:ae41:76c2 with SMTP id d9443c01a7336-2ae2e496e4dmr118882715ad.26.1772384925120;
        Sun, 01 Mar 2026 09:08:45 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:fcc8:844a:f21c:8d7f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b257esm113727485ad.4.2026.03.01.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 09:08:44 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 02 Mar 2026 01:08:40 +0800
Subject: [PATCH] spi: axiado: Fix double-free in ax_spi_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-axiado-v1-1-1132819f1cb7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJdypGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3cSKzMSUfN0kQ4OkNIskExPL1CQloOKCotS0zAqwQdGxtbUATZB
 QCVgAAAA=
X-Change-ID: 20260302-axiado-b10bf8b449eb
To: Vladimir Moravcevic <vmoravcevic@axiado.com>, 
 Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Mark Brown <broonie@kernel.org>, 
 Harshit Shah <hshah@axiado.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772384921; l=2297;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=yRcPxQvhGF4Ecv8niJ2audTUHBcYg9U8KcKsj1DASZI=;
 b=6ZyludJkVlCPWMcgh0edieK7UilddIXrENzghd58O7RYYEezPlqmEAkZztl66/zJRQ+npqbeV
 Uk98OQPSAFoCPV+XJQpBmGIpVwAwS1M7RjQGYCVPeocfqiPnTaDYOMb
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

ctlr is allocated using devm_spi_alloc_host(), which automatically
handles reference counting via the devm framework.

Calling spi_controller_put() manually in the probe error path is
redundant and results in a double-free.

Fixes: e75a6b00ad79 ("spi: axiado: Add driver for Axiado SPI DB controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-axiado.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 8cea81432c5b..8ddcd27def22 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -765,30 +765,22 @@ static int ax_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctlr);
 
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xspi->regs)) {
-		ret = PTR_ERR(xspi->regs);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xspi->regs))
+		return PTR_ERR(xspi->regs);
 
 	xspi->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(xspi->pclk)) {
-		dev_err(&pdev->dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xspi->pclk);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xspi->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(xspi->pclk),
+				     "pclk clock not found.\n");
 
 	xspi->ref_clk = devm_clk_get(&pdev->dev, "ref");
-	if (IS_ERR(xspi->ref_clk)) {
-		dev_err(&pdev->dev, "ref clock not found.\n");
-		ret = PTR_ERR(xspi->ref_clk);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xspi->ref_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(xspi->ref_clk),
+				     "ref clock not found.\n");
 
 	ret = clk_prepare_enable(xspi->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
-		goto remove_ctlr;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Unable to enable APB clock.\n");
 
 	ret = clk_prepare_enable(xspi->ref_clk);
 	if (ret) {
@@ -869,8 +861,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
-remove_ctlr:
-	spi_controller_put(ctlr);
+
 	return ret;
 }
 

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260302-axiado-b10bf8b449eb

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

