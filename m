Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5840DFC7
	for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186204; cv=none; b=E9GOYfjqc7N8pDtLaZFVhLz2lG/eiamKl0RKZQAR30QYTQ9iBtN5EMINzQFQISmhvluyHVmH98zcxfb49p2QZcSnH0hYKhTsmlJQyUv4pucRDV1FxV6oOCTMcn+rt6VuZykcFmgnHLu3QhBK3kiNiE+CR71mEWw0BjmQVMbQ6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186204; c=relaxed/simple;
	bh=IgWmy4QA7Nns3VcVuEiMlxkNPJRgKy13zfHehRaQ8LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWadm6PcJGxgDZAVozNexG8xdtDmmgJ6QYkugPfGjHr5QDoQLBO64kLaTgfcbzFhXTBUcXRCs+uZZ2x4YonxZGDt5d6ba4LadUICkKNJd/V3IfMkXX6PWCzTEEmjHIv5n8F38qMFTDCkY1YGFYvWZOMlGsbHfKYibdJUSl5nxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Of1TD8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Of1TD8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso17026145ad.1
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774186202; x=1774791002; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrIW8xtAyVysxyWJhbGBQFiTsDupVZxP4JLEp/IdUF4=;
        b=d6Of1TD8mp2u0u/cGK1f2MdTb4rhOMaCZekqhTz6b1dawbJz/nhchQgaThfrAepWDR
         tfK3nCHf4m2M7jRlmZCS3A4e/LIqGx2FvqBh42pbet2THMX9iahVKR7nLFCBU6rChTBf
         bgoxXVZv0vYDt2IOVyeJJkl3tEk+6Yt/9LjtmTcvO129zUb082LzL6A6Epk8o1+v+wxf
         GnHmZmUjcMuB22GNBB8jRaKLGPTjAVFS37qzWui+S/Rh0QO15abRKlalV1mrDDpwybXw
         Qn86m2UFUgo7il61jzo3VtQp5j8n20YoLrzZ6gGe8gJWFzXoqspvtOiuPwiX+zzKztvt
         c2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774186202; x=1774791002;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrIW8xtAyVysxyWJhbGBQFiTsDupVZxP4JLEp/IdUF4=;
        b=qwl/QKpsBsTKPvThGuGviHlAR9s53sZ57s91Fp6EoGhjx0szYhP5dhbx8KXTLVgyYb
         dzu7bHAMYxanmpfgqP8M5GHiG7mm3DvnAFimEVC1AI/uhJmgrO5R2YHN/LIADwu1qSyR
         v+lq34omUIIFiPaA/aarrtPFFLRqt+dIscoiZRp0G+yLy6/QZ+RqvQjxJma2phDaLSwF
         +p90OcofnLZHxF+rCyuYRb4NTeDW4vVWl2HL47nhVNuI0wCfq9LD9zCSuTgzkxMpj7ct
         SETdjcEUIQrsXpzaWxkYk0bN4pA5qqmKxiqF9k3GC+2GM+O1Iit2hdBi0Lkf7ykoznRE
         v1PQ==
X-Gm-Message-State: AOJu0Yz7+WtU+p7YUwMi9Y0o16+9DdkZhOoXAar22PK/pSUqd5YwsDtU
	5BzM0QCtj+X5lQCu72iZ7G97BA6U8EJT1h5+pUrLWOc+fGY0wOleP58Z
X-Gm-Gg: ATEYQzy7OP8adj4r122Z1SSe95EW9KSsZaZ5sAW5x7ym3LyN2MOFCXBVscc6/7nnuxM
	dWa5asBi7i5P4h1DqrWWixUE4hpw2Y+8MYUq93NCM+H5Pt/YoAvk1t/qYrertc5jpGJC1/+xKBB
	x2N2XwL//POhU2S3yFsRH/kgQZqrEz7DB1yxjlUPRfleZtOrvbNoaMjLFMW1pOA57nMIVIpfJBK
	u/58LjTcBFCzFmv8FLEXVmZmk2U/mWzUlOFwlhvBJNmjvAsbVyO92Cj3FFvEwtLWvgnjP9PyTzl
	+xMECb/GnuJOIHcOZ4jiJZL/8bj1JoaA4jMwbn0/ytvrLwCmAqtTvVQGWJaHEvxZSpwaU7GUasN
	NvJsPTPPa+TrIBJhbdKzpI/eNa8L8yozUC6mWXiv+tIHDbYoHNUn4jA8le10wJ66HOpxvc6V/7J
	6iiNnisF6s5KpeUsJl0M84eHGIkYunpfLI2aie
X-Received: by 2002:a17:902:eccc:b0:2b0:5472:ac85 with SMTP id d9443c01a7336-2b08278b1c6mr81255475ad.26.1774186202363;
        Sun, 22 Mar 2026 06:30:02 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352ae70sm82428685ad.23.2026.03.22.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 06:30:01 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 22 Mar 2026 21:29:56 +0800
Subject: [PATCH] spi: meson-spicc: Fix double-put in remove path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com>
X-B4-Tracking: v=1; b=H4sIANPuv2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMj3aL85OzkjMwCXaNEMwMjQwsjM0NjcyWg8oKi1LTMCrBR0bG1tQA
 QXofoWgAAAA==
X-Change-ID: 20260322-rockchip-2a6021826137
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Dongliang Mu <mudongliangabcd@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774186199; l=1052;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=IgWmy4QA7Nns3VcVuEiMlxkNPJRgKy13zfHehRaQ8LU=;
 b=dLgftTxPLhBEjASFdBodKe9Oa/2BVSKKuobIs2yLPKcz6YEYlPHAm2ZONouYTQlHozSyDTzz4
 Hbhn7HkyqvYB/ymGHGdt7PmckUH6vjxfwNcoNmgq+lvWTlIbDGTgtK6
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

meson_spicc_probe() registers the controller with
devm_spi_register_controller(), so teardown already drops the
controller reference via devm cleanup.

Calling spi_controller_put() again in meson_spicc_remove()
causes a double-put.

Fixes: 8311ee2164c5 ("spi: meson-spicc: fix memory leak in meson_spicc_remove")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index a7001b9e36e6..57768da3205d 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -1101,8 +1101,6 @@ static void meson_spicc_remove(struct platform_device *pdev)
 
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
-
-	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260322-rockchip-2a6021826137

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

