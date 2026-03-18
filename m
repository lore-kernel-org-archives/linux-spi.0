Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBF3F7A80
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850367; cv=none; b=Ia7Mqb+sRL4mkqr5xhhUWTFCKa0ScYaMwilEEgBE5cQetUaIDihSopJa9LTWsz7rDmBBdOdL9Owidxq83GO0eXrTbnvGYIAEoq6qbFpXE3hV08ojERvUH+eg+zky94PE/zZbn9a/h34HGnJFFcz0rsokU7Epj/uDuO9WX/54kSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850367; c=relaxed/simple;
	bh=zi/HkF2Wrkfy5CiTfwxTMFNPw3MG5goQInCNL8HtPhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGIG4Hr3te4DhKT1SOXA4epJKV8GBP1yFne6s7A803WwZjXe6FWgQUuIXvNEBDYdbt3ErjbgbQUFUjzNHyNYlL7ueb/VDzLLN09WOJGa461sT/TtzlCBliu9mCWmb+AzB9BelqWQQOHs565FXxUD72cPygPx16b3AxvSxRqFsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1/FdMlF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1/FdMlF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so84904a91.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850362; x=1774455162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scfnBMasoyrA80IqKi88Qi6oH/ECziYOs5/FKq35hhw=;
        b=H1/FdMlFYYg54dTyVpOcd4+9EtPZcajt4SPTfHuDYY4V0r1ruFFd+xlCtAl0kBj6g4
         WAq6C6fvLvJoQdTzfdGYMNbCTGX+Eh0zcYPkT9Rlpsq6cVuXGfefV0RBqOUtelGkpmgV
         RWCtr/822IZHBGyjXEoYYSNu8vRS4sC175yrKh+QFPpYcY0Z3svsKrkCkVL56akUBqTp
         gCivA7hg0ccTypWLwOfj/On3AI08PLH5UUl3fxc0WeCWc//iPdnu8OIIruKrKU8s+wUo
         DeiWT1ZYPtj2UwyhG3RYOnjuMQBAzbaFuaaSyu6K4A0oWEVcdwHvinTrf8r06Okud6g3
         F0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850362; x=1774455162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=scfnBMasoyrA80IqKi88Qi6oH/ECziYOs5/FKq35hhw=;
        b=C38cYqdul3lJJMtl70PLDGBLmfiS9/ZJeXc5gWKj5UldBhI+CZFetdDKKbyMXfSH6G
         c16VIzIOrvf/Si4ItSnJ0A3I+AnJBxrAlHcxVuFM6OphCL6ThDijEyegz4/5ipBSJLki
         aTToQ9ZJcrKgwIGTJL92CmKzuUQoOTaAWouQyF6rvSsdnp4YqKRl3aIGyoMuY16cftaK
         WZ29CSmLhdxHHVUKt7qNrhLDooO3L5K9mQ12TBcSpCEtH5bHsUdhlfUnxJKzXFFG9TSn
         lP9KGTdOIFrHJMIV96JQBHPLSY1AG4PELRlXnnPsvOhy1pXspBoUfxKdVe3fm4sL3T1Y
         5XEA==
X-Gm-Message-State: AOJu0YwXatxm+6sD6Zbr+6vwNNMa+7xiHIoUmWoU4LiwhX/LiFnKZGuL
	rMuC7XDGmWek/xm14knEW8Ff05It9MFPHNXg9RA800Ak9kLbJ++CMwabmXnWUw==
X-Gm-Gg: ATEYQzyTpZ0DQrYEfjZKSkTQhnTEAVjOBx0tpitsvFB45VO6/2LyM4vhQWzodAtQsWp
	sy+pVgZI15+wUluM9TsT+v1PFwbCKnbttpHwoeiNJt3mdOR8ljI32VapbOg0u/yMgFSH7F/4IZ9
	Urx8bXuWGgsFHNHI0NCzU1ou9wR8DCPbmtfAoDU9FUMSnexQbHoQmvx7AlJrHHex2jHZVnn/l/G
	Q9RRwOQVVph02mKiW2i3Wf+jHEHdko7o+ubxYEBQJdnAFWKCC5aSBeJq028Y6AeS66PI1LSczxW
	rYR1RjpPKTd8cePcdvYhVVBDgyJQSzD+PYuBz5WczQhF0yu+JAJFdy1znkZ8sbLSQ7cUSzjZrUS
	VD6DMHNyRCAhrWS6kfm0NDd97isKleeuF2h2cqEzlYVBMiR8WHJkm7WsWiu9e1r3HSDQh6jF88s
	GRWRpFOg6tgTyE0CQ5Rd9jo3186PAj4p8wtsJy
X-Received: by 2002:a17:902:d50b:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2b06e4353f8mr39579345ad.52.1773850361933;
        Wed, 18 Mar 2026 09:12:41 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e430864sm43040915ad.18.2026.03.18.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:12:41 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 19 Mar 2026 00:12:35 +0800
Subject: [PATCH 2/2] spi: sn-f-ospi: Use devm_mutex_init() to simplify code
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sn-f-v1-2-33a6738d2da8@gmail.com>
References: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
In-Reply-To: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773850356; l=1566;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=zi/HkF2Wrkfy5CiTfwxTMFNPw3MG5goQInCNL8HtPhw=;
 b=Kt/80OoYepkAeakLlWwJRXmeLEu7GZ66hRYgm6U94ml5XAN9epfJjHYCybbDgD2fCvosO5WTH
 A34I8ji1JvdApq3Z3Hv7BJeGpnYRFcLoYAWmk7nQr93ieIHf4X+ECkA
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Switch to devm_mutex_init() to handle mutex destruction automatically.
This simplifies the error paths in probe() and removes the need for an
explicit mutex_destroy() in remove() callback.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-sn-f-ospi.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 1f554aa7ca27..3c61c799723b 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -642,29 +642,15 @@ static int f_ospi_probe(struct platform_device *pdev)
 	if (IS_ERR(ospi->clk))
 		return PTR_ERR(ospi->clk);
 
-	mutex_init(&ospi->mlock);
-
-	ret = f_ospi_init(ospi);
+	ret = devm_mutex_init(dev, &ospi->mlock);
 	if (ret)
-		goto err_destroy_mutex;
+		return ret;
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = f_ospi_init(ospi);
 	if (ret)
-		goto err_destroy_mutex;
-
-	return 0;
-
-err_destroy_mutex:
-	mutex_destroy(&ospi->mlock);
-
-	return ret;
-}
-
-static void f_ospi_remove(struct platform_device *pdev)
-{
-	struct f_ospi *ospi = platform_get_drvdata(pdev);
+		return ret;
 
-	mutex_destroy(&ospi->mlock);
+	return devm_spi_register_controller(dev, ctlr);
 }
 
 static const struct of_device_id f_ospi_dt_ids[] = {
@@ -679,7 +665,6 @@ static struct platform_driver f_ospi_driver = {
 		.of_match_table = f_ospi_dt_ids,
 	},
 	.probe = f_ospi_probe,
-	.remove = f_ospi_remove,
 };
 module_platform_driver(f_ospi_driver);
 

-- 
2.43.0

