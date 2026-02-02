Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE13378D8B
	for <linux-spi@vger.kernel.org>; Mon,  2 Feb 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045317; cv=none; b=HPoPxBnf18w4JA774rTCl60QY7Z4KGEl+zPgqoRdD6tgYx/YBm+8nYYTrXNzC+uQImC9I7WVP+XUo55UE+/QBooB5VyrKkEHyNA+zAIo15oIjKS38f8WxxOWbXuIW3GpFGggj3H4VFtfI4PlzQNi3EfuPnfmwQD0+600qxsY88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045317; c=relaxed/simple;
	bh=bvebXC9I1YunyVizTunm4VUkYNAA0NAldv/+neltggY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ba59ymoNwCmFhAHO+ajcvoj3/QC1MP5Bgijl84vv9OO0PbAdcBTl2WaWTe7AWdFAyTs2FVcgnh/HyXh9VT6/V0onceyI6D5/4bqtGRC5DOUCNHNE68XOeNAg7I9jVdfZLd/VjT2iMQq4EIgplqo6yJVqh9ynr/g3uszCsZu1sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0Pope1q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0Pope1q"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2371522b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 02 Feb 2026 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770045316; x=1770650116; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9kCP8AYJvV0FCCtJryUeF0RXTCUXttv4p0WQQ6IQJY=;
        b=G0Pope1qOKuzGTOQaQ2SnSjC3CGLk/J83Vt72SUKlRazsjymZ3w7fdzL5YfBzn2JS3
         VVlFYexvf/ASavja3tjkamYIfmeoM+LwKRl03SEgH58a496iaJ4cd2EFzqlOdbq7cJnj
         28psD+xi/rnn6I05bpmqVNcR4b8M2Mpao5cAAA7dStP3MTWeIA355JaSanX5trjMEWtD
         tlvhk3sB6rfG3qbVz6cTm3ZILD7pE7/JxFieOsjWzuitHpzqMWgcbBbssLlDw/517vSW
         c/TGtoASKNpQxOcV5RWBAcTnqj7lgZyqRZRWnpWvKPNgMdyFKlSFVtSJDMwayD995cFp
         Z5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045316; x=1770650116;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9kCP8AYJvV0FCCtJryUeF0RXTCUXttv4p0WQQ6IQJY=;
        b=tsTrbGfsJswyD3SYFM+F3KfeksfYHHI/XXzTXIl6CeNuM4pfqqF5ojHrJUURycvyuI
         bHYw+jsvceB46wsseTtm490HQFwbQvoPCmCwv5qpCuOaF8ykCDPrxRjHz4/boFjc3W1h
         7YrnUCsFdlRX5U13hfUXlx+uB6VyYSlD8KpuKC51cYNtTGP822EsmrnwAC/28kGAz07J
         iVnZsXh9NqcdOlpEB+IYMsaraNBOpPMCFs8JflaagdQtNbg3ye9WLzprobwjV7Z8ATjw
         HnwvIWkgS16PlBSWrNCvncUUogPkbJjZpkGDrOCQqXiGgURzyS69ObXBMUQzpiiti9g9
         Xr7w==
X-Gm-Message-State: AOJu0YzSWHWRG/WA/WVdTNC4WSlmMdzrXpGMa9hIeTfiAibVkZyXB/uT
	P4n5Vy/EZtaZeNABeDQ4Tils/0paP7yeZdGkMSWDZOkP2y60nMb6U0vu8Rtg2MaK
X-Gm-Gg: AZuq6aKZRHNjgmqPzOREzogMp3PbODWWS6oMk2DLrSRiwmwzGROMfPmc2ndOR2qptuR
	+tpeL7iNrSW4Mcn666MeIg+kEDpCSnJGG94Ixuv2+eAMij2FomZWhfvuVLgcZ5Lh7cW1N0mQbC2
	xox2aSCmGMzzQAX10k+LTJt1D4HIlTCIpKx1I/i0Q8p5UjSaXvGjfGdGPpxqiOtVAofHNq3AUGt
	qnZhAC49yuqkmVKP91BTvm1QcdW8pBCgTrSANvKGYrahxoI51vALC9IL4v19OcRAvgXNnpnkOXq
	jQMvU15JcasXkrSUTPTdzX+8C6SxQrtTz3+maNeXUPxeNk+AAlKiSrK0pHd5pwAhyl61nYfoEOq
	XrPu6vjJYo+YK12B4iqo33wVnGfs22F56Emu5S5Hh3BUFTGf5+U7JuSLNaN47+pgFalmBpRtHGY
	km6HYXevNHsqWWAiBqaiCkPPng
X-Received: by 2002:a05:6a00:430c:b0:81f:45d3:adcc with SMTP id d2e1a72fcca58-823ab6711b2mr10981332b3a.18.1770045315622;
        Mon, 02 Feb 2026 07:15:15 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:75c1:2c3:72bc:6bca])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b277sm20326364b3a.29.2026.02.02.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:15:15 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 02 Feb 2026 23:15:09 +0800
Subject: [PATCH] spi: tegra: Fix a memory leak in tegra_slink_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-slink-v1-1-eac50433a6f9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHy/gGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIKFbnJOZl62baGRkmWZuYGFmaJiiBFRbUJSallkBNic6trYWANEcs91
 XAAAA
X-Change-ID: 20260202-slink-a229f708611d
To: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Zhang Shurong <zhang_shurong@foxmail.com>, 
 Helen Koike <helen.koike@collabora.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770045312; l=1186;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=bvebXC9I1YunyVizTunm4VUkYNAA0NAldv/+neltggY=;
 b=SrKmfrJJu5wdKj/0AnKy6+wPl99HR0H45uHq+W266gYBHWR7sR1GNHvYcZbohI42hJhC81YLz
 rEgRi3wC5MgC5EwMrgt8aZaK7zorFByUycB7MkGLuzPhlCNPB5+zMNj
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In tegra_slink_probe(), when platform_get_irq() fails, it directly
returns from the function with an error code, which causes a memory leak.

Replace it with a goto label to ensure proper cleanup.

Fixes: eb9913b511f1 ("spi: tegra: Fix missing IRQ check in tegra_slink_probe()")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7d6f3fe8b7e3..8c608abd6076 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1086,8 +1086,10 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
-	if (spi_irq < 0)
-		return spi_irq;
+	if (spi_irq < 0) {
+		ret = spi_irq;
+		goto exit_pm_put;
+	}
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260202-slink-a229f708611d

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

