Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699103D6CCF;
	Tue, 28 Jul 2026 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225916; cv=none; b=oTuB7VcXL/76IQuWlzH8AVBmuHfCrUIBRl6yP9NcBEtoaFzkgrq92bxD15WoBY2k3ZE9dyWJBj1EicQAsjZPfYx0S4tNr+uF5co37swscpxt4FQEtmR/Avv57XDh/3+9MPn3HDmCmweGklKJIQBidc/5YBdYO53lwF3g6GIo5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225916; c=relaxed/simple;
	bh=/EJ59EVgmGs+wpGuR5MI9Rfm17v9hWsaXj3Y5ItVIhg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oTcrTisqkEMx9Y/mHs1XYNXmkcFJm37r6N+nUCBPFS7Y3ocm8cMeawNU2o9IvUKmoqqPksCUbiqKxp+RhIOqteeRZX0hagJWMUPlEF+91kwNC/8QUOm7eRHr7d37pVglkP5aZkZ7aLtWvXYxbwaM8hNSj3ynC8LGvUKcen97clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ypxtmJLg; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ypxtmJLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785225903; bh=kS48lR5yCmBFIkW1Y9w82Qwc19/67awgBhHL6qyuQcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ypxtmJLgk02Pukth8sEY365w4GjzRib6mjqz2117pvGXZhq7SQbbocn4GfJF11Hd9
	 Q1NnJYhUGOeyUcNcbu6FJK6laR/f1P28qN2FnOUkurJwZktcLhIXvbvtRpjBR0/H5l
	 FCQtHls5q0iimUcsgRaRh3OA34w/bRe4LGdAN26c=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 12B9D80E; Tue, 28 Jul 2026 16:04:43 +0800
X-QQ-mid: xmsmtpt1785225900thi5ozi1l
Message-ID: <tencent_F25742D45315ED400AEA2E39210242FCFE0A@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLTRtY6BSJsze4pUGTAzQ/WLgBK5ZGgzpElZ+Qv05yLmROUjS3Bxn
	 cRtONOh50Q32JPuvc8/JQcdEWU1+zWsoYujpCkusF1Im47TMpWb3JGfnxHuRpMCci0+Y3Vde/6XH
	 WoFPoKR8NxGn8lhppWfd1nWYbckzyfPr3wkW5EPbi6yB/1xlt8m7Z0NSboK7+Cc9jruG8IMQ9cn4
	 mss/P8zHsA7w3wXlvgPG/KCVGapIXX0/oHNeq3kEudHaLvKmO+mZkADCE5lR/fJSCyqddyYQ+7tM
	 cduq7ai15gJWRmraqoKC0w95tOIpk1HGRISjW9FHbS5bPhcRaecJqa6k0Bern+IEkyFMfWm86so8
	 MjGC5hHCPkqWVQbEGcx9GPIvFcRYIJ9DUAVa9e7/abRnyMsnc0C4OatTP55LEH7VYXBqy17/yg44
	 u7KsCC7TdEHkO+3+H2G9rlZhqWzR2NphiwQc+miXueI4aVgZ1n4FzmIVODO6YxCFNRZlSYxYx2lu
	 TrP9jLngyrTy2rdIoXBUJ0JY+DYHCNjkV2Bbb/CKWsPOqxGKPUTjB4zoj/mDGTDD3K4gIGCZJ3Ax
	 pgX9J2z1sqbAJbUpQe6u9bODEpguL6YnEp3C/jr922bEQ6kMA/BCn806WKMqsJOMmRigpQuYGNWg
	 hQr1qG05ugo3d0Qq79mCJ9IRiXW//tUY05EPTH0082x6NLDqpxe+RV5mkcw0f8Nx9OL3/5ItN5EU
	 +XI297i3w0jNiAwWl8AXkLkxxyv+9CoSY5t+aTUCmtdjkfPjT57J1jTgbzhYxMTb6ga87kE6YDFO
	 P31URn9KCTB0oEqmUQPT3MIaHaexxBRQc1pfjJ5/3IVdCeNbHbL8bzsO5jlIHQy5oBcWhlJnlz2j
	 Kcb3tUo03ljrMuYbXbeQO2iAk8CkcSqD3J4Kp6aCFtgVY2cXxF7wXijM9w+l2Fn5c2+5jEc9+QoC
	 FxAydlGXT5dEqRI1O6LZtDWnBPCj22WhBrtg1WNh160XHVQp3jcoQh1eQl1/fLjX+hFIv3wVJdim
	 rytUpzYt+Z54ZL9AH9slqdHD7wnWvOuQZSg+ik3VlTZD0xn3Aw
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jiawen Liu <1298662399@qq.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2 2/3] spi: nxp-fspi: propagate default setup failures
Date: Tue, 28 Jul 2026 12:04:42 +0400
X-OQ-MSGID: <20260728080443.153827-3-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728080443.153827-1-1298662399@qq.com>
References: <20260728080443.153827-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_fspi_default_setup() may fail while setting the controller clock rate
or while preparing and enabling the clock. The probe and runtime-resume
paths currently ignore that return value and continue as if the controller
was usable.

Return the setup error from probe and runtime resume so the driver does not
leave the PM core believing the controller is active after setup failed.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-nxp-fspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6be78712b534..3f1c3ed748eb 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1361,7 +1361,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (reg)
 		fspi_writel(f, reg, f->iobase + FSPI_INTR);
 
-	nxp_fspi_default_setup(f);
+	ret = nxp_fspi_default_setup(f);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup controller");
 
 	init_completion(&f->c);
 	ret = devm_request_irq(dev, irq,
@@ -1408,7 +1410,10 @@ static int nxp_fspi_runtime_resume(struct device *dev)
 		return ret;
 
 	if (f->flags & FSPI_NEED_INIT) {
-		nxp_fspi_default_setup(f);
+		ret = nxp_fspi_default_setup(f);
+		if (ret)
+			return ret;
+
 		ret = pinctrl_pm_select_default_state(dev);
 		if (ret)
 			dev_err(dev, "select flexspi default pinctrl failed!\n");
-- 
2.34.1

