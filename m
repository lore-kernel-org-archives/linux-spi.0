Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FE22A7F0
	for <linux-spi@vger.kernel.org>; Sat, 14 Feb 2026 21:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104513; cv=none; b=H/qsI6fqOQNEL5NLKtfwgZRZwaW8Kg2QJ1TpG1BExd6V6mpFN2F6pENmLOoodeGTqQXwg1DoYIVTNxUxc3b6QNgmrDtxlaWdkNGIvKLn6AYuMUj2n+7KlaI4D0pxAMMqTtYFeTLsihA96EDAWAKNqp8TPl+DnE46f5u5cFy/7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104513; c=relaxed/simple;
	bh=u1ZddsI/WQhI8eaEqdPF0fJQVKnOzdHVPnDYp7Y+e1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1ALIhYjalKCpO6vGuu0OFpKJ+nZmvWnukoxYvXeT6mmjruKU5JjlmQh3zHe9QKw5cIIO9KVRMftrWjDsYr97Hun85z/kIpJs0WygKT02n7tAaZUksds8/o3p33bOnTHeVTsx00VKXbAfofdTQTecZ9aIg5d/Eq+fvZ0zXanYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP7zf9kK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP7zf9kK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so15719345e9.3
        for <linux-spi@vger.kernel.org>; Sat, 14 Feb 2026 13:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771104511; x=1771709311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwGG+83RjUTUC/08TDbxavNHPg+CZ56Ung4dLehxmos=;
        b=dP7zf9kKUMe/Su/W1ZhPwU5Vs/G3Pb0w/wyJGdTc1zWFGfiwo2xhcnIGQo8eXWavzK
         d6+fU0ACh7elzqOjMi/y/SITYpU7gLVwAzQlkgOOXnLDbVBUJrT7X930mzkSMnfgWOcn
         KI/esFe670lnHeiezxzly4GwFMYxNrm/kOMdLUznH+EWlanN95y7gSy0QHYS+YtEKnKO
         ZPCL0YVkwXhRk7+xoOaq2Gv5+HSpCIjEO9oD3zsoGBhxIFd6GtPj0gYhpQeVlZm17QK7
         RhhYPd+sgfmsxh8PR3Tt0ppFs0cmGhpsSquvhKOLne2h7FL/P36w2ZvNXgMcOhjjl/t+
         aciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771104511; x=1771709311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwGG+83RjUTUC/08TDbxavNHPg+CZ56Ung4dLehxmos=;
        b=EYfgZlLlnRXPYDHGAJPXpWcXlcCkyqfqFZ0hospRTzc6yi/sf+PTGgcel4PoOa2Ctp
         VOuuLUssdM9J07Lzbsd75gZOj5swONjgh1+MrGgWmf7kvFZ3GX4x1vnnkcCmrFXbovvi
         aNVeqfa96rCs8JLuTJu2D7m06NJRHbPDgMeuT6VHveHS7iPGOoXRMII/WE2hFcbRvN/d
         AkGuXaxYaXvfu5gTrSwv3EFOUQ+pBrSSu8CiwQ3sSIxZ9JRqGEr9PgGMWaJPeGbX1ct6
         qWA8LriVnxh00QBIFAeVjTbxQiLD+3g+ZSmlzcZEbKkm47sT7NrZACPsZAc04VHrtcAI
         /Lfw==
X-Gm-Message-State: AOJu0Yy7JkLjkdCWOnZEHox4IKszTjcN5IP5fnT6BOmua4rbzpcPXQtR
	BIC35/AZCHCJTco6I0neqdhMPhZ9a6bzPU1Goh8EY6fTSeKIMUjupyoj
X-Gm-Gg: AZuq6aIKaNC+Rp1A/etDfbf7xR/7uEZF8zna0hlApjaIqTD1o7q77FMsNR1hdiao8Kg
	ZBmQtTF/KwOEb/Cd+gmU7n8oZGlF/SBthhMAuWy5pvWY54pJ+hcQzEitQ2O13ztB/shsnk3+vPq
	4+AONM0wwbC8Zqo0T+sqPo2a7MqiwuonPQbXK2fHMb8j7YpIm7wKvqj1rjQTyvkJlOwEGRg87s1
	KWilcWubTJwJNh0uLlwFwT/jSjkValj/MUu4k4G0ZwLXk9HNu+Zwkty5Y0DknpcJiR2sKyT8jeU
	kaBGSTTPX8dpdcgAJ04zJh5tyjw4e2WQyroDMX9newnrkHq1J5E3ZtePRs0bd8dzSlo9nKxsD33
	mjr1ufaG99RJo45R+qQ1VlKuWF+Noql06MDigEaBgPKxoBu9uqF1oxGlNG6CfkSOVos3Sf3QXHv
	JfD7/nPeq26hX5YrPBK6B5Qke4oEU=
X-Received: by 2002:a05:600c:1da1:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-48371085c9dmr105939355e9.20.1771104510547;
        Sat, 14 Feb 2026 13:28:30 -0800 (PST)
Received: from antoniarch ([78.212.149.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm15132661f8f.22.2026.02.14.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:28:29 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH] spi: omap2-mcspi: add support for 3-wire transfers
Date: Sat, 14 Feb 2026 22:28:00 +0100
Message-ID: <20260214212800.262461-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update omap_mcspi_setup_transfer() so that the driver supports
communication over a single data line for 3-wire SPI devices.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

---
 drivers/spi/spi-omap2-mcspi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 70bb74b3bd9c..bf4c3770bc7f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -943,10 +943,16 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 
 	l = mcspi_cached_chconf0(spi);
 
-	/* standard 4-wire host mode:  SCK, MOSI/out, MISO/in, nCS
-	 * REVISIT: this controller could support SPI_3WIRE mode.
-	 */
-	if (mcspi->pin_dir == MCSPI_PINDIR_D0_IN_D1_OUT) {
+	if (spi->mode & SPI_3WIRE) {
+		if (t && !t->tx_buf) {
+			l &= ~OMAP2_MCSPI_CHCONF_IS;
+			l |= OMAP2_MCSPI_CHCONF_DPE0;
+		} else if (t && !t->rx_buf) {
+			l |= OMAP2_MCSPI_CHCONF_IS;
+			l &= ~OMAP2_MCSPI_CHCONF_DPE0;
+		}
+		l |= OMAP2_MCSPI_CHCONF_DPE1;
+	} else if (mcspi->pin_dir == MCSPI_PINDIR_D0_IN_D1_OUT) {
 		l &= ~OMAP2_MCSPI_CHCONF_IS;
 		l &= ~OMAP2_MCSPI_CHCONF_DPE1;
 		l |= OMAP2_MCSPI_CHCONF_DPE0;
@@ -1179,6 +1185,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		omap2_mcspi_set_cs(spi, spi->mode & SPI_CS_HIGH);
 
 	if (par_override ||
+	    (spi->mode & SPI_3WIRE) ||
 	    (t->speed_hz != spi->max_speed_hz) ||
 	    (t->bits_per_word != spi->bits_per_word)) {
 		par_override = 1;
@@ -1486,7 +1493,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* the spi->mode bits understood by this driver: */
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_3WIRE;
 	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	ctlr->setup = omap2_mcspi_setup;
 	ctlr->auto_runtime_pm = true;
-- 
2.53.0

