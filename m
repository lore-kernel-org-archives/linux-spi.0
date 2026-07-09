Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F6414A07
	for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596024; cv=none; b=uMphBtqaQeMqq4ogp6Dim9X85EXhMyHbYIxvcooffzby00miwzlFiMlbjpLxF2XBHuhs6plulQydAQa4OaioFn7poxkGG/RucLvOJDADRyLKcNEYVJVh1SiSaDKdbIi88Uc4zA+TUcWYtfa0ThWdOXTtQas6FJQC/FNu44rJw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596024; c=relaxed/simple;
	bh=YerxN599C9K5/WkW/n/MaJlm+4DTVduUUon9gz0fQMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fb1R1MiQeX0+5YOV7YXxNIaRUXZfn/K7eHw7R5fzAlJqSFmMtQQzBS3s39+19+t3/T4ZXYTmw0SD5S2NmI80O/e7NYDlRtFHfyyIOmRFAmssbopE4p3bxTROA2ZYkzcEKas7cjMw6Ldzmji/pEHpihrai44ro2ItD/I3a/+o3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=jdZsNiCo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="jdZsNiCo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso7005995e9.3
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2026 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1783596021; x=1784200821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9Qpcj/wkj9TypLUNOyfNd+pq1jx929AEvSS7+Vs/LQ=;
        b=jdZsNiCo+6BTDfnwFVKV6FilhibyrRSCHHhmmNXasPcRUZbRMvTC0FQM0tpeYVuaI/
         p97o8OsYJiwVImBWXjmtjgUss4hdr7W/7mg8E9Ndx+OEeDbFkSozfbsFpT932ak136gS
         NXgY3lFAI7gIEUVvNGi7NcZnTu8n14yXqldQjNUEmglBixY70GRiTQzSrfeyWIpWz23g
         mDSnChRZKQB6t2SzqUqLRLsPXhWgZiOL2+xHx211wuYwJybe6y271H3ZYsYZQVqEdvpT
         znLkKtxfM5nmhvYmEY8p5ZmSEHwb9ZMsJcGBHj4E09GTKvIA1fJUWMSelULa6UjQrQ+k
         zuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596021; x=1784200821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9Qpcj/wkj9TypLUNOyfNd+pq1jx929AEvSS7+Vs/LQ=;
        b=aglorPF0GbXC7RiGSR1aEtLMtrWaPzBUZcWapHRnC5JnFMxKzBeJeLmonorpDzwPIW
         ZYPI0IJCVwEnEdRncB3D3rbNHioulwJihIeO4d2kxa+hccUFu+FkSTwzpKob/Ld4Wnja
         4f7TebzSw6zTlEKKsNy6k6+4DMZOinXQNQJ04JLewFGgrLnGJqhO+6R5LlP1BZ6l0hMu
         R4HJhZ/pY1HO9Eum+ypSrxOUvdzo1+THBjpg3xkq57AoJmM36bsJJD13eH8T+p5zIc6r
         ZaTCnEbICQfylPDeseeFrE3cVbYmg+qQQH6qhFXHb/Wi/Y8ckOR0B5H7JW7WbEzwjYVL
         lJpA==
X-Forwarded-Encrypted: i=1; AHgh+RoxLpiqAXKLdlGiz5MrX3rNJC/u1EMMIW+1Tr6O0Aupd5tiwTIeWAwfdZQV2NZE6po56lNyDmjL2CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aFtIwQFp52RdUKa7HTq2KHkVpJjOL06bgdzNGcbsMWCuuIe0
	vJ89jWcroyg14QiBlt1AUmda7ByL3j47QHTz3W1Lr/e3lID+4UmMz/7m8uZKbs9rLRU=
X-Gm-Gg: AfdE7cnyaZtdUXss5cXG7H0u438aBZCUFbZsadnqKQcZvZX9EY3PveuA31BSAhDufVt
	Nkfs6w774J2HCTWRfVp4rA7HhdxGE/3VHcMStQQfNNqwNdYwQ0XypOBFk/aODpD1W8n11+FC7Zb
	BjvEVZnmg8aG+EwWdcwR0ARpZ7F8M99/hXxMpekKeyMRhoRSi0GzRkh6OECGT6gs2WgF6OqJdiL
	aMHpAZxyfSIOvtccTfF9T9RPH2giHlB8QoU4T1/ZtJQjl2u0Y74Ovby3fYV9DU7ARtiv33K/hS9
	UhmlJI70qShYPhrhLbN8zjsuHoYHwPJlQgHZnFjYyqFh5dCjJO/dOwNM3Ezm8l6ghlpGAXAAgWd
	sVLJRCc+q4Ijx3eeq9v88o2h0poAKarJUu7TmYUGfYtjpsYqDfyqmKYWVRxCf0EQF2FMhFAgjfg
	v0c8XIEmziolTjv/SpsQ5aZxhTS2dSQS4MaKrlW4hpZeGCELRNWnBUjLgvxafNNHu5aW7+iPDAt
	+D4tUydP94ZQnOAvDbiKeViZVtYJVUWOmENfPofyCNx2IZdQi8peg==
X-Received: by 2002:a05:600c:8b6a:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493e88760f3mr51787825e9.34.1783596021331;
        Thu, 09 Jul 2026 04:20:21 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-57.xnet.hr. [88.207.15.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm53910475e9.1.2026.07.09.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:20:20 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	tudor.ambarus@linaro.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/5] spi: atmel-quadspi: use init callback for gclk variants
Date: Thu,  9 Jul 2026 13:19:09 +0200
Message-ID: <20260709112006.390742-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709112006.390742-1-robert.marko@sartura.hr>
References: <20260709112006.390742-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assign the existing SAMA7G5 initialization routine to every generic
clock variant and dispatch initialization exclusively through the
capability callback.

This keeps hardware capabilities separate from initialization selection
and lets variants override the sequence explicitly.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/spi/atmel-quadspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 62ea84d234d0..d1aec14e3978 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1159,10 +1159,7 @@ static int atmel_qspi_sama7g5_setup(struct spi_device *spi)
 	/* The controller can communicate with a single peripheral device (target). */
 	aq->target_max_speed_hz = spi->max_speed_hz;
 
-	if (aq->caps->init)
-		return aq->caps->init(aq);
-
-	return atmel_qspi_sama7g5_init(aq);
+	return aq->caps->init(aq);
 }
 
 static int atmel_qspi_setup(struct spi_device *spi)
@@ -1576,11 +1573,8 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 		return ret;
 	}
 
-	if (aq->caps->init)
-		return aq->caps->init(aq);
-
 	if (aq->caps->has_gclk)
-		return atmel_qspi_sama7g5_init(aq);
+		return aq->caps->init(aq);
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
@@ -1638,6 +1632,7 @@ static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
 
 static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
 	.max_speed_hz = SAM9X7_QSPI_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1648,6 +1643,7 @@ static const struct atmel_qspi_caps atmel_sam9x7_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7d65_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1658,6 +1654,7 @@ static const struct atmel_qspi_caps atmel_sama7d65_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7d65_qspi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.has_dma = true,
 	.has_2xgclk = true,
@@ -1666,6 +1663,7 @@ static const struct atmel_qspi_caps atmel_sama7d65_qspi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI0_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.octal = true,
 	.has_dma = true,
@@ -1675,6 +1673,7 @@ static const struct atmel_qspi_caps atmel_sama7g5_ospi_caps = {
 
 static const struct atmel_qspi_caps atmel_sama7g5_qspi_caps = {
 	.max_speed_hz = SAMA7G5_QSPI1_SDR_MAX_SPEED_HZ,
+	.init = atmel_qspi_sama7g5_init,
 	.has_gclk = true,
 	.has_dma = true,
 	.has_dllon = true,
-- 
2.55.0

