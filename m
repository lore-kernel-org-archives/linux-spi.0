Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C24E4300
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553010; cv=none; b=MLl4HG6t+uV+GcVpoepMX5BTtLarNA87+kTg3EiqYhSLdPQOra/2O76qP1yXUd6Rwa8Qro7IwkrCnlvIY/G1UxFs+J91cT/3FE55Ex9wm50be5q5b3PrEMi4UWmUDWW8u+zEssSXTv04GKNDiX3+yY8/Zzsk7ajIoY6C9s4m0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553010; c=relaxed/simple;
	bh=C7/YgkaQNK/zcq0qIsUTnbAeXOmVfs5H3Xn4Tb3ZKts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbJyEQCTZCOpTsnWr54T2sF0wAsCqt7bly+DItwLa+KlruN78GP8hR9853E6B53vjkDFIYmkdYFKmAORXHVDW9u4RfglPjObjEGKA5a+wSVSGh0JgG9zwy6ziFGLM2LrVpLPMkyM9fN8X76ui7OI7qqoNQ3bhUJbdhq1LfqZ+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e7006bbf77so14407215ad.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553006; x=1792157806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xu9qlzISdqBsfG/KDIT6cAt4DBaAq+fPmh/ka5nGnIg=;
        b=tOgNSK8hx1FpTQlysBuerduVjzMVS3faETLfkuYlIHiyo6Dd3UWVvcSFn3Emkhm1hZ
         nXQJ7fOdNhmQEq1PefE3GJhZKrlI3j4jBWUDAflfsV9XrmgnO5GvL9iJHgpAuZighhnr
         G6WxKhqgsszZnM6feW+0CZOgM5ElzsYqyt4nQScUneOu39tzVLW5YAni5eA94NPgOWjw
         cvVtKVcSgkQt3Km4nbKSBvp5UCSnidRbN2WOt7IFm+N2NkKNwfOv86HxM+fSFOvU6w5H
         YDQ6dLOhDtU3rNEGxaBaw/fGzXqDON/uuzbq0ObelWy8B1pLRbqu/+L3AKcPotNKIpQD
         n2IQ==
X-Forwarded-Encrypted: i=1; AKwUvByHklABuXs3IOO8rPh+iZaTQ2kXZU2rnEKULnHLbtY3sTrlRdkkRGeIX5qFtKjkQHXs6+6R26/Y9Kg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSjsMNABLJKjXqzz2DC9uNpQyHX1n+0SVGEhhUx9Nbzgj0oESI
	5YpRvS1DF0BhSL0OYcgVRyg4/WEQslde7qd/jloUGa/0WNRRwtPjAQAi
X-Gm-Gg: AYBFou3p6VEdMGWrLsaNLuA3Sg/CklCTPasytsTgaa4yjW3hHlKDwo+AJiDnAsiR8u9
	vfkgheN92panjAcgJNJ+hnF5uwOMGlYo8Y3yK7uB9KFY5RqcV+JuPZggQSD38YZMIzUf9cXdXNC
	s4XRbvvgriR9V4kEcFHEycmNKvFqMinI4MIArzt9WqiZLBZFIBtTjWYwbbM048nbIqNchbJPvDQ
	pu/Ruc05xiYUG+Hgh4a1hG+C6HTNPPdxoEI9POfov1yZW36u2M0iVscWIEEeoDwWy6lunedFIT1
	p4Lcc50mHUUiIikH7MF/9YaPntJV7TJQtEQeKaa7tZJLROsUjp0sdhlF7P4kZaTs38TDVg2odjg
	moNtpXk9jVrUzvi5CVHbjyqvkmUXnZfU/i/npu6rJr8IG7GceAqXH+Iv9jtoyAuMd1qIak3k4al
	X2rni82k9vHjB8jQKH3YaLSpVrFvkWR80luWuVYo7VtDinwSGwu9pahgYDnnc=
X-Received: by 2002:a17:902:d54f:b0:2e6:1a6c:abd3 with SMTP id d9443c01a7336-2e8427f0cb1mr17510535ad.6.1791553006254;
        Fri, 09 Oct 2026 06:36:46 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a05f70sm9260455ad.7.2026.10.09.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:45 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 2/2] spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()
Date: Fri,  9 Oct 2026 19:06:31 +0530
Message-ID: <20261009133631.579644-3-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009133631.579644-1-code@aayushk.dev>
References: <20261009133631.579644-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-bcmbca-hsspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 5dc9e0f21..8c0147588 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -129,7 +129,7 @@ static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct bcmbca_hsspi *bs = spi_controller_get_devdata(ctrl);
 
-	return sprintf(buf, "%d\n", bs->wait_mode);
+	return sysfs_emit(buf, "%d\n", bs->wait_mode);
 }
 
 static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0

