Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B33D3008
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169587; cv=none; b=A2KCg94e/Xsa5ojTB25VIAv0Gz7OmeUZ5kCWt1oHAFthl/njlbE1PJHLB/ThwSzOrk/KSnOg/BgIHLtrEL/p3SZ/QtqeryoZhKSCHupNLzr7ViUP/bK67TBSS8jxM2h9cRngown1ZfyG7UQtvV7vzlAKwOIvgeIBGiH5HPPZmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169587; c=relaxed/simple;
	bh=HzvLLyKldzauCo5A/6W5mR9BbBacv7alsim8B9hTDRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYDaO+fVrdWNodjGUycNsBXZUBqzv2yWlybrYFre9jCDJXIcoPX/vyUzQum+/G4W2/3wPNo5jvp4LBMqPcOHuqp2zdYSwl4PoCWeqy/VTe3fq2mDDjpS1N59KOTVjm1uM/MkD2ZVBoxBcSzPo0/tNMRwt1xwr151Wdbj3RbOB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LFfPrgg3; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LFfPrgg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1C
	m/Usak3YOBFXQuAb9Arilpp+CET9HlhbS6Uj00x3E=; b=LFfPrgg3bszUt3tpcg
	o/dYfGNP+kumZWTa6rrMSvuW40eUSdr0RTdY7bNifEy/CxQwubKXP2xEY3cYj7tg
	LHF+MUTwx3gtO2MpOTxxlCXh4UheYILvp4LRLS6vW0mjhHbEDpSh22293hBWrPiD
	6wFar2lNOvMB47XddYCn3GSgk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD33wlRTZVq07RNQA--.65178S2;
	Mon, 31 Aug 2026 17:45:54 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: sunny.luo@amlogic.com,
	xianwei.zhao@amlogic.com,
	broonie@kernel.org
Cc: linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH] spi: amlogic-spisg: check clk_prepare_enable() return value
Date: Mon, 31 Aug 2026 17:45:53 +0800
Message-Id: <20260831094553.2247003-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD33wlRTZVq07RNQA--.65178S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxAFy7Xw15uF4kCw4UArb_yoW8Wr1UpF
	40qFWFkrW8XFy0kr43Ar4DCF15t3y0kFWxG34UKas7uwn7AryvyFy8KF4qqFs0kF95tF17
	GF4UJFyDC3WjqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um-ewUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+RJnFmqVTVIndgAA3r

From: Li Youhong <liyouhong@kylinos.cn>

The driver ignored clk_prepare_enable() failures for sclk during
probe and for core/sclk during runtime resume. Propagate the errors
and, on resume, disable core if enabling sclk fails, so probe/resume
do not continue with clocks disabled or report success falsely.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
 drivers/spi/spi-amlogic-spisg.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index afc8af04638d..71b73df1b5ca 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -704,7 +704,9 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 		return PTR_ERR(spisg->sclk);
 	}
 
-	clk_prepare_enable(spisg->sclk);
+	ret = clk_prepare_enable(spisg->sclk);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -841,9 +843,18 @@ static int spisg_suspend_runtime(struct device *dev)
 static int spisg_resume_runtime(struct device *dev)
 {
 	struct spisg_device *spisg = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spisg->core);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(spisg->sclk);
+	if (ret) {
+		clk_disable_unprepare(spisg->core);
+		return ret;
+	}
 
-	clk_prepare_enable(spisg->core);
-	clk_prepare_enable(spisg->sclk);
 	pinctrl_pm_select_default_state(&spisg->pdev->dev);
 
 	return 0;
-- 
2.25.1

