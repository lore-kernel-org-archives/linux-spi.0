Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A51A01BE
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339986; cv=none; b=ilSDS3Y6YrE+HFOi2qYtk5+oypxmBGxq6LFTPA2ZdHrqa2fjZMg71oPyl+sVZfmH1OLj95a2f7RXuxhILytdyslNf8LCJgDwY4M/m9aPg8lAtpRMrfVDRw4wuyKSQQfglTn7cH/EwIjAxmtNaDs7rc9ihTXJzlJkWR8AwOkaPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339986; c=relaxed/simple;
	bh=XB1YmbfqO9Kx+UK9NAZHUwfreTrkYt0BW/+tigI6sTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gnRXmrMuJLBLWj/2oD7Ag97zeJvyo5bTAivfZhtk/rZtnHYGzp8eMyVPbOqvgsTztwNsK/FryLkgqPfTWKgMTUYHTawVdZ6TtUQoqJ3XzMTvHgDpKE8wCPBBeJ7pEFAruhsfF1h793Il4ppkXnPT9F/FJpPMxkZi/eG0qvsagEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsHd59RL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsHd59RL"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35e576110adso369291a91.0
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776339985; x=1776944785; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ak+ZDEB7WeybsrLIOMHRS67N6O7QONYYPEi13P7yBA=;
        b=YsHd59RLfT8TgMEKzG+SHZohG68tHP3bIHun/RMZx32EfIYT2kkZi1KYWh74wbJIa3
         donfcUFwcdtZsU8o7r9TpuWP12xL0DyPEZHNhmLvoiFbhTrwgYUrh8KxtQrnBn1NhNOb
         niJROhnS/leHWroweZSEGmMAzrp+6fBTFMeJd3z96CyOUTBgjb8ND1XDuxSCA9z6r3AF
         f7IELBvRowN0uV7WNZTi4KRdOWGxb1Q20/0j7d54pjtuArDSG1HgxK1c9hLNEVjkgaQU
         0OrbVBgynDXLIYd8YOFEJaXbMnXQ6rG0BirTrO2HccXtlhh2kJCotzmcK8jMMToGWuDN
         pEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339985; x=1776944785;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ak+ZDEB7WeybsrLIOMHRS67N6O7QONYYPEi13P7yBA=;
        b=cUV5ukw7fYc0GNvBhSWRcya8na3w2pz7gN+HumbEHaF5S07QkA330sU3CWjqGc+vci
         mUqSKKA7Hmx/+hghdg3EMmgKoKWthHmnSFKHeczUtr5wPznS+P5N1//vyTlYiqVp/P9C
         /q21TTCLHtoGONT5VSgsBJfkix3fsc+tTDqhKj3cZL6IFxwdc/v922Utz+u9kbRhTyqm
         UNS8SixMf9oQx++s+5x9n3Qq+/6b0R/EnQW3MvMlPwD0l9BDSxpZ5Q+4tKgdQOO0vv58
         fPwME8pxNswTbDxh8o16az2pu0ZPWu4QD3UbzpV/Oc1Sebb5EiIH/NOkM/0hMdjBv6FF
         HmCQ==
X-Gm-Message-State: AOJu0YxQJ2+ZOuun36xcGNkDc+Zwuc9Thlf74YtRME868s8Z7oROxl8R
	NNvmEI7YwHMpF6CjMzNk851wCzFebyPFo+FRJBpQQIl/uFA8IhRDoYby
X-Gm-Gg: AeBDieuDFJ6xf1KZTytjShfJSNLDEh6N7oyRkIqg7dwpsWjEkBSMjQoCKmtECqrD8Pu
	K/KOeOJ24x785RKD44t1sL4edOsqBr1kTMN/Yy7INYS4hAd9EKEDg6Ijt9Q7l6UkJPJGCaROAY2
	6N0woC6aXv5GWjozwP3wSRPHoQKm+XkjsQoey3/XhhjnTVAAXGoFXASbTW5zHD3HI9X2YCMUbx4
	uRpL3E4uJGWx+yI3EAbI+w/y1TBV8HghNU/YeSEJYDneHlhFxedr6aIVZmn+TQDy6HBv7Xzzf88
	aCyvLe4vKzLD7D/fUJTDmx35wIqfAufrc4dcAW5w+W2L1AsnXYvL9QxgZ8DYVPiPyMX91w6rT5o
	E8fnIqO6Yu1/ArrTZ334PdLmC/qF7N1+xuPWpxeyIe7r6yxp+MUmFVVzv/B7AlN64uagv2wulJ5
	8Mk2TVspOs5WC9MNMDqyF5uwQAEPmiPyfkBmgR/DWOLlmTmuN4ld2rS+DMxT9pRvVxiP8SuT3fy
	NVnDp95ayre/NB3Saft1khkt+1GsAs=
X-Received: by 2002:a17:90b:3952:b0:35d:aa02:d776 with SMTP id 98e67ed59e1d1-36135c6d422mr1195562a91.2.1776339984508;
        Thu, 16 Apr 2026 04:46:24 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132d01150sm3055586a91.14.2026.04.16.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 04:46:24 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 16 Apr 2026 19:46:20 +0800
Subject: [PATCH] spi: mtk-snfi: fix memory leak in probe
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-mtk-snfi-v1-1-fafccfd288f9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAvM4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NT3dySbN3ivLRMXTNTw0RLCxMDA6OkRCWg8oKi1LTMCrBR0bG1tQB
 NXuIaWgAAAA==
X-Change-ID: 20260415-mtk-snfi-651a984002ba
To: Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776339982; l=1399;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=XB1YmbfqO9Kx+UK9NAZHUwfreTrkYt0BW/+tigI6sTM=;
 b=HdxlppJCMd5S7npIE2p7HIyJ3C1bLlGGm6txyaDjoKu/faflIykPEP+jl5yqiUDjiXFBSkwmA
 W+GU00d+C+uCf5klSZDikIGK9NNNS+RbAUxEafQxqJZTlPGQhcbnlqW
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

ms->buf is allocated in mtk_snand_setup_pagefmt() but was not freed on
the following error paths.

Fixes: 2b1e19811a8e ("spi: mtk-snfi: Change default page format to setup default setting")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-mtk-snfi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 73fa84475f0e..a728cf571b78 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1447,14 +1447,14 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	ret = nand_ecc_register_on_host_hw_engine(&ms->ecc_eng);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ecc engine.\n");
-		goto release_ecc;
+		goto free_buf;
 	}
 
 	ret = devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
 				       &ms->ecc_eng);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "failed to add ECC unregister action\n");
-		goto release_ecc;
+		goto free_buf;
 	}
 
 	ctlr->num_chipselect = 1;
@@ -1469,6 +1469,8 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+free_buf:
+	kfree(ms->buf);
 release_ecc:
 	mtk_ecc_release(ms->ecc);
 	return ret;

---
base-commit: 936c21068d7ade00325e40d82bfd2f3f29d9f659
change-id: 20260415-mtk-snfi-651a984002ba

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

