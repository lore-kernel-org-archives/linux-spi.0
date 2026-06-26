Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9843F8ECA
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489761; cv=none; b=cpjuDha6bnWlx+9MNgDP1TiNYDwpuSg3UfQGfTZGnGdo6ejI7jTcc0vKk4blniiy84NKM/kbEF2pn9Xz/jgo6M9V32v23HRHuFi+y9w51CiysoCQnJZiG7YWchqgc/+GybeHlPYQxtGp2IesdlVqXGKg6YikUQlEZ80YQxb7xYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489761; c=relaxed/simple;
	bh=i7UN6NZmlk87N9g+MUwiSXXy8P7EDhqDhWuLVQnXrEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=De3DkLmd+SjMgPVZ7sx6f5O0zOGynUJlGEEBJpP3WTZDaLYc+wjt4hN9z7Q7yiIwk6E49zo3Iv/m6/6dPZ3+u6rqttCU/02XlnB1+g103ybWD6/rWgznlyNQUhjNY8BgpGs+tMWhD8hbnhBTEknM+5XBC1375PY6C9GrhAuuwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdRjeBD0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdRjeBD0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37e0035aad3so580157a91.3
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782489758; x=1783094558; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nB0N03rGfVExnQtJc3B4o4XRNHfaU9SsB4IMAxp8xSE=;
        b=fdRjeBD0YjvUKrEJ4BESbAsGDWS0wJjxvKFH22rDFQevIfjkTzFuE6Pcg4CgQk8eSL
         9T/dZz3+Zcw1IB4rA726tASBs2svXd4HAlgBdHwN3yHCE7EMhljfgKnWGMcvVXkii53S
         NV9aFddQxRENflXmYnQtlWpHJenu5I3niqOV+W/W3DWrK3KG5Y3h+DkDFma5mVs5jEXT
         cZbbioEV4hBL/+8p472ufGQaUbfgL8R5hhzPi8XZ7vNooQI8i4a44WpKONOBfclgp4/2
         3RixD+Kgc4byZ5/RqE2x7W14d3GtGOmdc8CFH67DIHc4+zfWRwfSijFgCtth5GLHQHhD
         uu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489758; x=1783094558;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nB0N03rGfVExnQtJc3B4o4XRNHfaU9SsB4IMAxp8xSE=;
        b=EXh+C9mX40E4aK4yHsrGKkyCTDOo4B8L0cNGWi4TVyaarNUlpBxL7bqfC576QvV2qa
         UXgsRWkta3dypkZAepqcLMLckPCnFT7M1wUqvbo2uOBc3FqOpGWD4RxRXKqAtJFLfk4l
         q+pJ/RnspZzjjpVcwY449DGM4LP1dmAMhyGuf4811RZARYi2KyiBYWPYbJPDOc+oraSF
         PJKlAwxAv1VT0CDeDsYGQ7La26irV8Ud2pFtLXWG406fTwL8lnlhjHbgp3z5RJauucev
         leatDhu66d2Kh4y7Cfq+DAnlTuN+AXfWi37+nkxV+hMWG4ojD64if+CZbc9lfHLUpQRT
         +DwA==
X-Gm-Message-State: AOJu0YzCqUVgnywKp9u3c2LCVNas/S8EZsicfRv7+ZkW4d3qp6s8FroM
	RqR4mvg1ReTAk3l8Q9FDaK2yPVjPUJTqaXwXm+194ADuHb/+w4ECgXEtHYdMi+kC
X-Gm-Gg: AfdE7clzRtVV553KSeBJq6eqAUkAJdUABWDm9VvaqBWOBWZ4rnS3ODIhA2jexvxHpja
	cypv3rpaoy8P2IHfdy0sSb3ymNSycxITYoCyQllxEvwW5AFUX5YYmnkK/5GuXvUhS/gPwXUu8w0
	rixvVhy5QLSp9Ew6p74Lx8YUwaoNLQhYIcIqJbItL4TVyLjTNOKIuVZX2fOL81Xe0pridp3m/2V
	drzdK8MLvHL+8a8MoOWvM6F0hnuHPUdReRMtP5xD9FSH47VAaW2xYmyawWgi02Wl3bSXPuuqGh8
	o70vQS3sLoZgh98+yfDbX/4WmCw0+g9BaYLr5IG3uKa7RJ6FPdY2S08MjK7lINfZTllRrz0QN8/
	uDuXm0dcnCJW5IMPnPR4BlORm8lAxWlRHhFO/S5NtHxJ8Nv+FpfOpNtBcrKJUMwr8i+OD/eXd+K
	BKyix6HoPC/98hi+1+syFeXfu/C6Ry5Dafv/A+uGw0CWg7kMjVN5xiYunqIZTUk6GjiS1vEYzOA
	WQ4MZfDjWp+MOZbMA==
X-Received: by 2002:a17:90b:5826:b0:36b:b4a1:2939 with SMTP id 98e67ed59e1d1-37dfa251534mr7269381a91.15.1782489757620;
        Fri, 26 Jun 2026 09:02:37 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b657b3sm4149363a91.15.2026.06.26.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:02:36 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 27 Jun 2026 00:02:29 +0800
Subject: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJSiPmoC/yXMQQqAIBCF4avErBNMaBZdJVqYjTUtTJyKILx7V
 ssP/vduEEpMAl11Q6KThbdQ0NQVuMWGmRRPxWC0QY0GVZLIymvbokNqyVkoaUzk+fpu+uG3HON
 Kbn+3kPMDCWDmUmgAAAA=
X-Change-ID: 20260626-rspi-f0a56c6e5eca
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Mark Brown <broonie@kernel.org>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782489753; l=1399;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=i7UN6NZmlk87N9g+MUwiSXXy8P7EDhqDhWuLVQnXrEg=;
 b=ZO0A3r26F72IgnWv9fDl+OwU5EUI+bhNAfMK24m0PF6jGX+ZGxsDpS9yssQnG8VnanG6MC9RE
 FZE2QjPAY29AuBMSejrmJjxrpfWD6u0y5Db6QoWAH7r79JGIDv3kYFF
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

wait_event_interruptible_timeout() can return a negative error code when
interrupted by a signal. The original code treated all non-zero return
values as success, which would incorrectly synchronize DMA channels and
return 0 instead of propagating the interruption error.

Fixes: fa08b566860b ("spi: rzv2h-rspi: add support for DMA mode")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 0738d448160d..daa4239b0fe0 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -366,14 +366,14 @@ static int rzv2h_rspi_transfer_dma(struct rzv2h_rspi_priv *rspi,
 	rzv2h_rspi_clear_all_irqs(rspi);
 
 	ret = wait_event_interruptible_timeout(rspi->wait, rspi->dma_callbacked, HZ);
-	if (ret) {
+	if (ret > 0) {
 		dmaengine_synchronize(rspi->controller->dma_tx);
 		dmaengine_synchronize(rspi->controller->dma_rx);
 		ret = 0;
 	} else {
 		dmaengine_terminate_sync(rspi->controller->dma_tx);
 		dmaengine_terminate_sync(rspi->controller->dma_rx);
-		ret = -ETIMEDOUT;
+		ret = ret ?: -ETIMEDOUT;
 	}
 
 	enable_irq(rspi->irq_rx);

---
base-commit: 30ffa8de54e5cc80d93fd211ca134d1764a7011f
change-id: 20260626-rspi-f0a56c6e5eca

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

