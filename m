Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980392D6401
	for <linux-spi@vger.kernel.org>; Sun,  8 Mar 2026 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953198; cv=none; b=dVftfH/DygA51Qu0CVwFbnieby5vzJwGuz9VHd71lqLxgZc95O/u8XFTryDxIInp7BbM7qzImkGUbDXOp4yr0L/gL5e9FS31jea0hNHzljsPbCw9UHNG5XnjFPUviT90dGReS/Ta9Wrj3v8k20Yonv7QWkuZbbaIlHbSZ4hMl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953198; c=relaxed/simple;
	bh=+RNmhyrfQMWHwu+8od84odlXgRn/4U7kSubd4dXtgmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RKJHq9EymMAt2Y9YUL80mMOmeUzR3/Ipx7SqoI6504RA75UAU+lLAq4/GZNKDQQvV2idPzkIz5fttlkoqV0fNWAjYtu/diANqgNa6JOGhr53DMggJrdBJQv+0EAJ8aGiXV+UazzTIefyq+IS8SsFxdgp+aklKy7UYhD8q7KjSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvzYUbPK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvzYUbPK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35994d84c6dso2882230a91.2
        for <linux-spi@vger.kernel.org>; Sat, 07 Mar 2026 22:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772953196; x=1773557996; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0nWv8X0cARRJ4XJPERkEaD5MqJj6WxTqHyPFa/TlB8=;
        b=mvzYUbPKNixCeuuUrGiB3hBRFd2w44t7P7kkckQIytwxekxqjvnFuZutq+vPlptW68
         sAhbP8bDJf4VHLrysUK6jvYi3BP8wraugz7AKz8c5BOx+kwmSBOFc1qWMun9K4rHRftp
         HT3cB1LMpHMAypMIYCSXNO7TU5lo70v5ryMyGDWYk7W3Px3PT2Y34QmiC/E0kDpgcu7G
         hu4i/UWz98h2U+wz0PDytm8nnTClrGxaoOo4HHAvS4QyqIZZxEKoq9Y75QyPIdbScktq
         lOCAu13pU4WfCkOeCyijmAT32V495ywwCA8IhwV9+dBJs7BS3h9J4cMt2yq9sUvk/Cia
         mV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772953196; x=1773557996;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0nWv8X0cARRJ4XJPERkEaD5MqJj6WxTqHyPFa/TlB8=;
        b=QBG3YJDs3J83yU0JwvIe37LN/CQFXPPN9gvspd3ltaY5lG1vJ9bijyk3lEPMljaEtz
         BD5WXKyB+TM0trXQ55N6xLS9GNgqCBH5hPl4RIkdd1fH/EdZGCPu+9iK6IJfvm3YUneI
         lXK9gACl9Js6cLFlRUHBee4UvfPh7cqjnY7aOEIBurw0AzybyBA/PXpu39jV50y2NKLf
         P7atLegU4G6LiN/Z7ux+CS5PXqFtuGU6a+88Trr+aYM4jLzSKSmB0GAvvLzb292CC1ss
         rBTC2aTKTVWACSbwJxpVEk+3fDpz4PRtLKT5TIqQjm8k6ilayv9Vye5fSXaCrgKWpQvH
         2jZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx4l4hJCU/VQxJMG6WubM8/MKuhfoOpwpDUTo8rA41MDm9UgMG+m0Flo9iZ0jVBTHq6BQuw0WvZ+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtzzC1SsZcDTR6seW5kc4BVw/Gin33KxVCt82TtMjPdnbyfug
	41kfVn+2pL/HOtAVn+hwZnCdA9lVVJHdOIhcTlmzp5DxV5u65yBtt0xh2ZphgT1tOc8=
X-Gm-Gg: ATEYQzy43sc5pPlEBxjy90HRx9nNCsuBdWCwBt/8OL0eZtzAIwN1gliL2mQWnP0XBSl
	o7CvLxYK5kIAJm3452AAj8yqq2yBruUOOCBTH30wb3qRm1UbSRiysls6PUC0DhN8IO1lYufcYrL
	A8AQF+rPQ67VjSb024q2QGisqHtaWetiTi4RqEmk+CF7MaYA6VEW0dL2ZfI0bqnpFtO+3uUkj9T
	dexoLCorIFHb0SCjHegK5RKJujOkNJ34OWlHPn8DgV9pc8VDB3SmM+z6wk9iIMQM2PU+kjEPf3V
	xbIddt6bfx6FoVT6KzeNed2OGIfeLp9frjUbTHSHyol874dLARCfQjlnW+KOM/F7IlyDdOOSCy0
	0YUGqRmYJ3nkLwJlrExJCkA+OSnAVmsgMwU7N3pD9WL6Mw53/cKIYI6+QzB53iPrbeBqw1c20Pn
	hXIYlOIf00kLjekjopLae1PnLSgtm2jOx68xXd6TWxDDOoCXs=
X-Received: by 2002:a17:90b:3c4a:b0:356:24f0:af08 with SMTP id 98e67ed59e1d1-359be28d404mr6645265a91.1.1772953195878;
        Sat, 07 Mar 2026 22:59:55 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4507:7fb4:bc3a:eca9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e00177sm14464792a91.14.2026.03.07.22.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 22:59:55 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 08 Mar 2026 14:59:50 +0800
Subject: [PATCH] spi: amlogic-spisg: Use IS_ERR() instead of
 IS_ERR_OR_NULL()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-spisg-1-v1-1-4e209faf228d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGUerWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwML3eKCzOJ0XUPdNGMTo5QkC4skM/NkJaDqgqLUtMwKsEnRsbW1AEG
 WhcNZAAAA
X-Change-ID: 20260308-spisg-1-f342db88b67c
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772953192; l=1524;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=+RNmhyrfQMWHwu+8od84odlXgRn/4U7kSubd4dXtgmo=;
 b=IivQ04b4Vat5+bqGtsxOs3thUBaQ4qZSzLSCErKbdMYgH9O5udI1OrEO0OIVeU7zaYEynhEKL
 7JVo11RZSD5DP1oCd8kKsBx5xoGTFTrr5ibxXTg2UI39dFfvBr8ZQfn
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

devm_clk_get_enabled() and devm_clk_hw_get_clk() return error pointers
on failure and never return NULL. So IS_ERR_OR_NULL() is unnecessary,
replace them with IS_ERR().

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spisg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 1509df2b17ae..665f889dc8d3 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -647,13 +647,13 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 	int ret, i;
 
 	spisg->core = devm_clk_get_enabled(dev, "core");
-	if (IS_ERR_OR_NULL(spisg->core)) {
+	if (IS_ERR(spisg->core)) {
 		dev_err(dev, "core clock request failed\n");
 		return PTR_ERR(spisg->core);
 	}
 
 	spisg->pclk = devm_clk_get_enabled(dev, "pclk");
-	if (IS_ERR_OR_NULL(spisg->pclk)) {
+	if (IS_ERR(spisg->pclk)) {
 		dev_err(dev, "pclk clock request failed\n");
 		return PTR_ERR(spisg->pclk);
 	}
@@ -703,7 +703,7 @@ static int aml_spisg_clk_init(struct spisg_device *spisg, void __iomem *base)
 	}
 
 	spisg->sclk = devm_clk_hw_get_clk(dev, &div->hw, NULL);
-	if (IS_ERR_OR_NULL(spisg->sclk)) {
+	if (IS_ERR(spisg->sclk)) {
 		dev_err(dev, "get clock failed\n");
 		return PTR_ERR(spisg->sclk);
 	}

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260308-spisg-1-f342db88b67c

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

