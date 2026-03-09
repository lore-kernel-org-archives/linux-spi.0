Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FED3ED11F
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079301; cv=none; b=j6RI5ITtbDIANjghPcyVOBQ4GAM8Y2NjItNJuaUpoaQEtpn6AVrUkbgvbT9UorhWiltwvR76vIFZ/3bN2dZI5HULQR5SJ0SFqjTJ9Pz0yc19iMMyVU1mlYffEQylVM1qMMVrRxTq+QUIF+J3od3/bgVzNIVYefFis8+9cwRN06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079301; c=relaxed/simple;
	bh=maxlVA4oxzDMZWxd7ftlkv5zJkOpC9hH0WTm1wcE8xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O7Vj78aHbcDj5O8npqrJp2JdCc3XaV+h84env2HdRPsFH4pernw6naewZSV+wLIFeL3BWTizQcOXHVARNvJc9xYOPke86oeqwZ61m56ODJ/oSHRdM8v1x3dr7Bu//dfp7W2jdivCHaNCeU9x+PpoYRsBttTeKylGn401coNl75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6VVdMvH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6VVdMvH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso38016655ad.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Mar 2026 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773079300; x=1773684100; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5ipli13t1o4xLS734cGrlylkoQC1n3PL8/KZ9gjCPQ=;
        b=W6VVdMvHy0rLr6CLIe9cgBalTez9Mk/u7CDAMxSN9WgovY7pE97yKxzlHFPbp6BrsP
         apUr5+xlUEdkr6DzKw+LVe418+ekevTYs+QmVKA2d66dNZo7jvQZIhvh91qa8Gu8gn8k
         9pPGy4blP2jPpxDS2MQWZlMyvZIYrUeH3t5BA2NPqF9qSJKNX+ZSbqogAUZOvXzGJWDh
         FueQPaA1hqVIa9xB8P4UhM6Gd+adxua7VOsx5rtL27JnSGgMyyJ5JW91CuFDA4KWJYbt
         i4l5uEIXX+intMtHRfx8grUXV20J20Htwz0l+lhgXDKdF6gViz1gumfd9mI3QNbws3Bb
         awgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079300; x=1773684100;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5ipli13t1o4xLS734cGrlylkoQC1n3PL8/KZ9gjCPQ=;
        b=RoHOSt8fHKhm15jEUrERfCAyRMB+5PsqrwjOva1mfSTNcUWwW6Vi1wySiAqlbKdOgf
         KqzOAVVU1bETKkzXX4ZaXnKs6fwu8lAH6iiDA+2IeAeITkHxPOo7D6d+1PtSqGLbfQJm
         TDJ11pPheeq3P60iStv/EDn31D31s7q4KNORSDqKcZltRAtKeX0F18KZ+mtnmidamY3n
         6nQpuaA/d6uB/osxmA0o1mhrPaO1qd7Q4QAwU4uGCZGItOsniVG5uQ45PqrZ11Yt3Yun
         bBBP9+f/L7QMNLKjEqAzyyTOmghnI5AyzfpipPe/Tt6l73GPC+nwZ0+r6dQPvkrTmnek
         tnZA==
X-Gm-Message-State: AOJu0Yz/QEGYNsOCqekc9ubxYuBwsFYGGP4nP9REKZhuhxcqIuMAPTc+
	yBjM/vQ8nMzd5X2bPV/dtw2dBAmEhB+x+z62dDtxuzedeCDkS/WKglTT2+NRZf8F6Mo=
X-Gm-Gg: ATEYQzwKMvaFJOtUqX8NlLcSmNWMRzHdD3s3tLbXSyvbkRiosYrdoJx1qpv2z/budFM
	/bNK9mmxx2fqpIvOyLMTV9HASlor2Jwd1/78okMMFT55tNbP5/A2bhpb0savFbqN30fYXzLbk3X
	Gv7v1+GyxYgb5xpEO0jw4VBSRwMoodRb0hWfEmy31gt2nVFry42cXovlAqKAD3hOBLrKy9ls+hT
	P8IpV+cnC5Kcylph5QL4UZcYeA0BTNAAtIBsXwhUmOpKDGaUehZuZ5j/k3n3+AYhlrE5jZKUszh
	0jUs6sESQZDrTDU5KqznGQ1DoaAXsqpRW+WWHUW78HHybtuf1/Z6SQqNJjF4Np375gLOSYkdUYc
	MAqg43WYv/f1b4hARmfQ78IvJ5OTM9xsiwbecR8og4OveAzABQvbMtNPlGsaklD22PgvKd7/9XU
	WpjkbpDmwSN4Yt+qgtV/xX/9OxdlfSnCd+7M25pu3bObzB4Lg=
X-Received: by 2002:a17:902:e549:b0:2ae:6d9e:ed5a with SMTP id d9443c01a7336-2ae82439431mr111745765ad.13.1773079299326;
        Mon, 09 Mar 2026 11:01:39 -0700 (PDT)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:a816:d74a:dc19:1ab8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b1fsm163828605ad.12.2026.03.09.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:01:38 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 10 Mar 2026 02:01:34 +0800
Subject: [PATCH v2] spi: rockchip-sfc: Fix double-free in remove() callback
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-sfc-v2-1-67fab04b097f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP0Kr2kC/1WMyw7CIBBFf6WZtZiBRiiu/A/TRYWhncQ+AoZoG
 v5d7M7lubnn7JAoMiW4NjtEypx4XSqoUwNuGpaRBPvKoFBpbPEiUnCiRWOwI+udNlCfW6TA76N
 y7ytPnF5r/BzRLH/rv5+lkEKHR9A+IHXW3sZ54OfZrTP0pZQv5jq+npYAAAA=
X-Change-ID: 20260305-sfc-307708e9dc67
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773079296; l=1288;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=maxlVA4oxzDMZWxd7ftlkv5zJkOpC9hH0WTm1wcE8xY=;
 b=fNA/SvWU8RLkVmDt2uPXlgA30FSBSbY7QUvh1H2Ow5wXz38XGvEZs8Vw6XrRUMUi1rV6Zv5HI
 iR762V88B/FCeskYwi/m6NmJ2m6uoE1uY7cO43K8C75RhUrG8Wr8isl
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver uses devm_spi_register_controller() for registration, which
automatically unregisters the controller via devm cleanup when the
device is removed. The manual call to spi_unregister_controller() in
the remove() callback can lead to a double-free.

And to make sure controller is unregistered before DMA buffer is
unmapped, switch to use spi_register_controller() in probe().

Fixes: 8011709906d0 ("spi: rockchip-sfc: Support pm ops")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Mark's comment.
- Link to v1: https://lore.kernel.org/r/20260305-sfc-v1-1-6fbf6df0e899@gmail.com
---
 drivers/spi/spi-rockchip-sfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 2990bf85ee47..174995042f53 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -711,7 +711,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto err_register;
 

---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20260305-sfc-307708e9dc67

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

