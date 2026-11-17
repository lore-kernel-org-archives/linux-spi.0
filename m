Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881157;
	b=gRnalgNuc+K7AUYh/uJh17qPB60VBzW7Bdogi/fgzSHNw9MwR8j/0p08wtTItom1Mcat
	 FRdZhXxAuYKqrFAEqNvr+6TnobTUQLBrrHwfvQ0BYD1lGWWAuq2rp9rMgIB9CvdLZODkD
	 mIyiAtoshc+PypfjLbAx0uehVCbWuHUAYigaAntYhdhMSaW/PKSXKEZ5EvnTQCMIlvt+3
	 mrbXOZARIm9L1QkEl26KIS+D41GJ2bWLoYNnutfh/wT9iV5yjkHY0uIjDbvLJX8IkwB7t
	 I09DEl171u5YQNGRfbjNQk43EjyiW0VuGw8nVzcYf9pFJT8IFTMMBzTTR1krcv7p7VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881157;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y05LMTHAhK20B/ZLUic40ylZUlZKhXPp+9NtIYoDVw0=;
	b=5tV6oxLfpyMTVGK3MLEgd+72C3ZpPS5wZ9BSJTOw+lh8bZVrrfjTTg9AUZF0qk3mBFl8
	 ndO5CvZXEB04HFhCB8oYt9KajjzULZeAKsFcVSKvZ6Aofe+OHlaMb7YUV2QmRXV7m+JON
	 y4wWpDe4/chtTgSopKEiRIWSVXrjhd+npj5kyHwDzE0nIpYB99ORkmy1K9H87D4mZVJbc
	 3KNq95ksm1LPgPks4xmeuLkWzd7eWfx2aTfPtQtnKPPZhOJBAudwZjruQDzlC+HzFUhvX
	 9KT64p/V3yhHi9zg9YcMQoMsZ5C4A58tooH6cdWJzqKJtG9lujh90u6snv57bZlKOwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OWrLEKva;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB6606A31C;
	Tue, 17 Nov 2026 02:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BB6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OWrLEKva
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OWrLEKvaS+Fj8TcBCH5CrjyOARDtEwU9gL+lXxW2SrQ7J3Bk0O3m2OY5T6w8SGr6c05VKUPaUfMzq
	 IaoCIvIP0kX5JEnBIsIYlq8vS+CHVNOOK558ht60sPZC+FoLpJzScbaBXmNjTw9uJYC0sta3fzd0fr
	 3Shq0+XieaF3M3VQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16afbb6822a4-dfb98;
	Tue, 17 Nov 2026 10:05:55 +0800 (CST)
X-RM-TRANSID:2ee16afbb6822a4-dfb98
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96afbb681739-9ecee;
	Tue, 17 Nov 2026 10:05:54 +0800 (CST)
X-RM-TRANSID:2ee96afbb681739-9ecee
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw-mmio: handle clock and reset failures on resume
Date: Tue, 17 Nov 2026 10:05:57 +0800
Message-Id: <20261117020557.20019-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
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

dw_spi_mmio_resume() ignores the return values of the two
clk_prepare_enable() calls and of reset_control_deassert().  If any of them
fails, the function still calls platform_resume() and
dw_spi_resume_controller(), which access the controller with its clocks or
reset line not ready.

Check every step and unwind in reverse order on failure, including the
controller resume itself.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/spi/spi-dw-mmio.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index dd703c1e56..665805dea3 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -472,23 +472,37 @@ static int dw_spi_mmio_resume(struct device *dev)
 	struct dw_spi_mmio *dwsmmio = dev_get_drvdata(dev);
 	int ret;
 
-	clk_prepare_enable(dwsmmio->clk);
-	clk_prepare_enable(dwsmmio->pclk);
+	ret = clk_prepare_enable(dwsmmio->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dwsmmio->pclk);
+	if (ret)
+		goto err_clk;
 
-	reset_control_deassert(dwsmmio->rstc);
+	ret = reset_control_deassert(dwsmmio->rstc);
+	if (ret)
+		goto err_pclk;
 
 	if (dwsmmio->platform_resume) {
 		ret = dwsmmio->platform_resume(dwsmmio);
-		if (ret) {
-			reset_control_assert(dwsmmio->rstc);
-
-			clk_disable_unprepare(dwsmmio->pclk);
-			clk_disable_unprepare(dwsmmio->clk);
-			return ret;
-		}
+		if (ret)
+			goto err_rst;
 	}
 
-	return dw_spi_resume_controller(&dwsmmio->dws);
+	ret = dw_spi_resume_controller(&dwsmmio->dws);
+	if (ret)
+		goto err_rst;
+
+	return 0;
+
+err_rst:
+	reset_control_assert(dwsmmio->rstc);
+err_pclk:
+	clk_disable_unprepare(dwsmmio->pclk);
+err_clk:
+	clk_disable_unprepare(dwsmmio->clk);
+	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(dw_spi_mmio_pm_ops,
-- 
2.24.4



