Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A2360EDC;
	Sun, 26 Jul 2026 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045130; cv=none; b=AfnsXJT0E0YU0+8XYx+Is+UpShar80oq2Da5IT1xFRzghbPbV1Q8uXQ5XwQ9z//ZLjF2JcM/n9HEfig3AEetT8k8PBs6VJJYiJXuKEUGt9w3/m1qc6tLKmnAjvhWixXy9N4P4BpxR1gWGodI1/SQplz3sIXh9wRs3PVUly8w95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045130; c=relaxed/simple;
	bh=kwucQG+xExy9rhtQqxhTLUYmWy7QJpI7ijSd1iPz6+w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=UFiToDh2xUaATpnFwwSQjQAuOdt/5MqEo7JURub5sFVZk84BHauubdbfRU8qHqshkpzQFHCeKnuxGi+xm9Jxd7H4k/27p3BQHr3+o7OBGVOICp+/fOrbmGKe6YtQDIJ2PovViMghQg+rxNgJtIWFqmEMDssbODjBr8Id/W80KmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=I128UY3W; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="I128UY3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785045123; bh=0LPLvQIVYpcaGTgXQxvhW7Bbbp0nXz9jWnUHxpMJhpE=;
	h=From:To:Cc:Subject:Date;
	b=I128UY3WZ8Ral2aLbF8V90YABG7+dfVxBhIWbJrOJGu7weIrivTMeDyu8UYzhDoCs
	 v60yoUJXFUJvb9L8zWv8RZLVCajvJCq8SIjiXIyOXXQsz7pDrHRs1m8SUtmYVFsNQ0
	 bHLhiW+xsaBIvsrpjXJ7H8KiSDFnhFD5OAhdrN5w=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id CF11F2FD; Sun, 26 Jul 2026 13:51:49 +0800
X-QQ-mid: xmsmtpt1785045109tae9le73y
Message-ID: <tencent_D74B48085D60A729C0BE5FD64A87FAB9A207@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gvxu2gMb0xKf28BiKvllqeQPooAqTqh1tXbF/3AinGgQO+5b5O1
	 ziASW8lRAfq2Gyn+OWVl644Pyt7CwwQFvoGYevtV4xMm8GzP8JfI8rOhs3Dzdts34EdyKpSG7+0b
	 Q1DOvesu4lgJBGiTwj3KiFqcAoGiHDXgSrEo+l3bmN8OT+lF3QXuLsMCTr35c1tjmZQuQJyap0HL
	 DYaUypc0hmhoDfJrX0LURNx6GhQcIZygMKEmnhY7cWjBEChqCvStFlxNsWNnCcHPvf177NjsgQEy
	 6rXFeY3zN/EYJh4lsTfPT06w1FDlONcOsq+eSPZnpdSiA9ZlyoSHGA17zvWIDrkpcILgJ586UPxQ
	 ttK0pf8PlOQzp+Xx+DdORcfjQxbUZARclnDhmU5LmP220uBmEdEhlt59GFm1wSrKIjGCLrwnw2Gk
	 EegTBAyUmOrwLEDtjaQwosqGMh26MFLfgB4Qcc8geR9An/uug5Ma3Ai+5GbwFo1QUEJDjvD0HJJc
	 rgasNDR8fMDXwQD8kIILppOtjh0uj8wtUvwRr3HUWBCC5kIHDgDlu42RBaYN8jmSurCBa+8SGkH9
	 +PvCYtOXtI7ZjaWZAIEH4MglWY2K/CIXwUWHm+V6vZYalZbynzJqgICWYiFHjFuQnSrVZMEuxMLL
	 rm3oUitVToobIax84NtM9Et5taVXqk/Kdr0ICy+xT5vQjjq9rIo3WmzK+YCM33KQp8cUCh9aPX6A
	 vz4owW2cPNSIw1sHVkCnd2jU/Wmu13eg/GMyGqrgM51hE+8QTCVcpbRmsNPh2N/T/DQttAR4v0Lk
	 tGmK7ftZXtLeergg/PUdPBbvgPnFZxRCsLYYPl1rLSsfCaSg67r8OPE3CiM+yTTSpzoHqxjqaZu4
	 HpPTVDzMe/Q8ihk+fWxL5Jqh/iDGEth24VCP65zEvfI/pf/PzSbgqAHpcTiHBDhCFUmvOqC73n4m
	 PZmGXm3dHgyZgL7yHnPu61x1NqxXxEv2CMVcB9HbNlrZ0PS3bC69wT2iaFjnzVAPKsee0+JBN/rs
	 jsiqYVkyJ2tF4Hvphzm/IHlfoiUI/ct/tjNhvp1A==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jiawen Liu <1298662399@qq.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] spi: nxp-fspi: fix runtime PM cleanup on probe failure
Date: Sun, 26 Jul 2026 09:51:44 +0400
X-OQ-MSGID: <20260726055144.1388819-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_fspi_probe() enables runtime PM before calling pm_runtime_get_sync()
to bring the controller clock on for register initialization.

If pm_runtime_get_sync() fails, the function currently returns immediately.
That leaves runtime PM enabled and leaves the usage counter incremented.
Clean up the failed get with pm_runtime_put_noidle() and disable runtime PM
before returning the error.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-nxp-fspi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1e36ae084dd8..c6037f3209c5 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1352,7 +1352,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* enable clock */
 	ret = pm_runtime_get_sync(f->dev);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable clock");
+		goto err_pm_runtime;
 
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
@@ -1389,6 +1389,13 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		return ret;
 
 	return devm_spi_register_controller(&pdev->dev, ctlr);
+
+err_pm_runtime:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+
+	return dev_err_probe(dev, ret, "Failed to enable clock");
 }
 
 static int nxp_fspi_runtime_suspend(struct device *dev)
-- 
2.34.1

