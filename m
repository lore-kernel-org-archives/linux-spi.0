Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4B72622;
	Fri, 20 Feb 2026 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555564; cv=none; b=X6KnMBP2LczQn98Lb0r4gUQeFNCeVJPAJbIi3XUUSf4IlOx7VwJUuzb+e6FFGB+gT4GL0Km7AmKqXOVRmQtgFT2Oe2h4m3fDrLGDIVdeR/3V/9T2IjlVfAUuXy8apMXbLc3tavui/WK/26z5FQh2nnmho0WqXc5MgJAW01mu6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555564; c=relaxed/simple;
	bh=Eru3PleG7fa/25XwF++tUbHpD7fieWPrKuRPvWQDGPw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HuuBfVGreVgJx3BVNP9v0MM5VGyanF1LfSOuh9WuAvMsEY8pRRYCtKnL2JKLkpbRPu5JQi70vlb7WFJQf9S0hPQshsFtbNT7uAp8L5BaSQDg2ev5Srfq+lhmegzsWofZKUFX6AnaE0lGxj+6Y0dJG8qCzDSW9ojbKlAcs1Qu0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gyYwwmdG; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gyYwwmdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1771555550;
	bh=bIWZyUSJXXsYuyfG+/wEGdv0rhwJdpC1SegkH7uXaRM=;
	h=From:To:Cc:Subject:Date;
	b=gyYwwmdGUlnFDBvblAeiIyunnJR5WLrVNczJusdEVavI8NzF3O21R0wAJqvq3gs9k
	 l0PYG9plmDwPmKJ9AHdOkbs2r288b+dy5rd4qjq9tRED42AzBwobwu92AdH6SFutSr
	 14MyoL1nF8fD2er4AvEGD980EBg8TJlDzrnspQVo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B1A2C00F; Fri, 20 Feb 2026 10:44:26 +0800
X-QQ-mid: xmsmtpt1771555466t6c47mdvu
Message-ID: <tencent_65C9C09CBD2B68C400F7145521A4B217E606@qq.com>
X-QQ-XMAILINFO: OQjltBcbYeafPeOCe4GyjKRMoidJjfljFLo9vY9IiYrmttGHVgU5We8xk9ROIs
	 wnZIHV0Np27UTNSGU76CGK3BbhdWjOQs12KNVEMjfAjBdjgtSBzZfC3wc80KuyBOe0nofgHurf/Q
	 YI1utmW5ttqO0VRrEm5GRUjCz5TsBCKdiRUvHOqtQW2iotjYhd0aC5JN0nB2lm2nXpDMuT4Ojjgr
	 fa9+Lgd2hHqIVEkdsX26N/vODptu8whURrBnsw1Pthtw2RdwCRWCvkGJWU1smxClr4KnQOSo2zld
	 2vu5rclsvxKEa5sHzZVHcpBdW/ceXwu+tdcWz7rlLJ7PdW/LS/dts5pl0rRe/Q3lEo+CijO5VY2o
	 w94qcfWw8XDn6AmLGcPkrrmq4Ty7QM8kvfr3e/MmtLI4uAgG+S2x/QwxI8mkPYWiCfp2CTLDu5oB
	 NySVWqajhSqDWYv7fjemEz/ZsrcqRNzp/7d/Hc0vBGMhBST3xlm2FViHKX1KyRm7x5h/f+zG49/P
	 ax+kmcmkBg2MpqF+hFb21Qaynzv429uv5hhbHk3xslkjaBIWqD2kyulkxQzN410nTiOWLuf7YgAe
	 xVZAlA4QASy0k0TxAYovuiK6OkUjQRzTzBARkskh1kZJTOwJai00bF+AHmf81LaFz29LSEmus904
	 OoqKDaGNBROmb3fmQMa85Uf9+IH6738nje1cb3aMrBR7n23T+KFV7vqMkyf0qf0vInRCNrIsc13m
	 MCtEhl5Ssr4zk4FtEcfT8wbpipaOZYGP6cvC2BOBvo6UiwezA30wKNAlmS5gQCsBH/tdCCX0ci4b
	 0eHNaFgIaXy3Lf4udFacWmft9kQFHyuMC1ANVe2JsYbgX29KILEIQfZbHoqLHzkAf1bnj7Us8/sQ
	 DEyJJfsl3XL8JKry8PKPNRxjp3LT3bBwAN2jrZy46PO50GTN2Mv9PYA3JP0HQntWSA14+w6MONIQ
	 pNc2m2gpDwaMEvjWGHzxmz2OOVPRZrHjJf2Qra5GvYdI9opOO+FBoHj3bgfOCcIZfFPmA2Dli5PS
	 5znyZLtDg0cCMhpF3fZtgiffmylXU=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: xiaopeitux@foxmail.com
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] spi: atcspi200: Remove redundant assignment to .owner
Date: Fri, 20 Feb 2026 10:44:25 +0800
X-OQ-MSGID: <a4d079b68605cacf90edb8b06a183f61f4f040b3.1771555403.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

The coccicheck tool reports the following warning for this driver:

./spi-atcspi200.c:670:3-8: No need to set .owner here. The core will do it.

The manual assignment of .owner = THIS_MODULE; in the platform_driver
struct is redundant. The platform_driver_register() function, which is
called to register the driver, is a macro that automatically sets the
driver's owner to THIS_MODULE.

The driver core handles this assignment internally, making the explicit
initialization in the struct definition unnecessary. Remove the
unnecessary line.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-atcspi200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 60a37ff5c6f5..2075058387f3 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -667,7 +667,6 @@ static struct platform_driver atcspi_driver = {
 	.probe = atcspi_probe,
 	.driver = {
 		.name = "atcspi200",
-		.owner	= THIS_MODULE,
 		.of_match_table = atcspi_of_match,
 		.pm = pm_sleep_ptr(&atcspi_pm_ops)
 	}
-- 
2.25.1

