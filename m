Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9F2CCB9
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137970; cv=none; b=dflxfDbEoH0oKGTgV5SdNpoY4jzBcxUqVd7AljNj6wpgRprZAth123PaBY3Nt8yqa5ql42lb34LVWEDQ6zuyIK7snl7CN7vqz8x+n+Cyzw202qEQrRpB98TYoqzKduax5wRHqeqHUswfDocXLnNFGB62FWlQ4kpk72P1uDQfgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137970; c=relaxed/simple;
	bh=+OlgXi9Skov+ThY6+3dH6KQ2ROhe9JPBW8e/CCW1r18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KM25t7HIP1ZjUT+g/xGQNNYtX6uM400GknKIfJ+mIXKYl2eeFj0eFsfDhJ3Fzu45Gkjohq96DW4K6CzXeYEFVbI1W8wyWCDchkUIaNinHLH7ZUkasO5r9TKQJbeT/5oN/9Q8ZinwMhTun1LXkDVLfXhRq8zYjppzFP/MMQYnZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMxrBDqO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMxrBDqO"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b9318997so54144655e9.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 17:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781137967; x=1781742767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTDFl51zdYZl6YO+uZhWWOZC/ibEg4/Hnu0SEvId+tM=;
        b=rMxrBDqOn5W+sQZso8paGXGtwpTYtzVS3cawNenSU9RPNPglftWmefTVvwYBhPZ39A
         sx+exT8UuNMTnFObw4P4q1Z1n0BXnUx/EF0I3SSocLtsf3/0ebrbDuyInI4GDIw9/aeF
         HwdztzgK+/JWXeNafI7ZxMdhjEDRI4fk81M/5oL+CoH4gS4R+J+by7d5yHZ4zMo/bWDk
         j/UC/62BZ/SAJ+K3Swe6Q3fjuGmPIfJnXsHNqXa1P1wucDSDsCMIacAImRdEwxnFBG65
         sDkXhu0DaGU90phm3KKPrd7ahUBmUnbJav9K3iUXa3BtHuFl1Ex2of7E1AG1aFRR3Rhx
         USHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137967; x=1781742767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTDFl51zdYZl6YO+uZhWWOZC/ibEg4/Hnu0SEvId+tM=;
        b=O4AjTRsnlV75kF1OOKSlTuJyYWUChZ4GlMgq9fM6+V3aR0fEaBFQlLlOgCaoG+Nwkv
         VNctde9Gkbs/c4yYU2j+52FpncZfj9t8SxmTsp1s3Hn1Nu+BSQXDjqKiqa8YOPThG29j
         rgbqmJygtKyxso/m2zvrjmMhBn6QWO7TwRbMZ43xXJYDWGnov115Nauq1gKAWuxFHI6Q
         OCDDfDdME9KpKcftgJ1e3RXOB3p1AVlQ2cqDYRUaUqTHsHWAeVeXJhg0GoxhipPxHUQY
         M0Epg5W3Xg8jhrc9pjws3J/zVxoarwYs+rDj6ptonmD9eWHVwYAYBjvJZQVBbB3VM208
         Hw+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LtGrqqwUSnovNSEZPX92uNPz1Id3dVWj/BFsMdNLCJV79/b9yAhlKiqA8//fn8ZbXTxfbUJlpPdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7AWkuZuhWejT919jaYvd9abMmDty/z70QCb7g6FQmIsBBmPY
	d1KuWlqtSQ2vtZAGJ8DZcBzaYQaNEWnslTOkfVDK5+SFhOgkDK1QPC+e
X-Gm-Gg: Acq92OH/qPn0Y01DBb0+pdHP3J5V32dvQ6E9jz/eB8QUYJO5zMe7ghqo2/v+lr4c1DP
	eDzAG4/Wekn8G/Ei2Esqdru2cMHWErFQDjT2kDLNutkpiGdfr1GTylgIFRuCMDRKhVGQ7xJZp5Q
	14kVBO2yGj33Rx6zncEpldwkeALJIWjzta/ileb5m5mSaXwt3cnOzjewUxfn9N2ll3b0WuPMY4i
	0j4VdcxECgw18zJ/d8f2b/vyynVbMSgi4BfJK7SavFFXDzlXKQIOBls9GrfYd/vAgovHxznnegd
	/QTvNUsklVCI7SxGFbLxEVlIbYHLpm447yvLrdvH/B0gcSJ1zCMWASZjx/3/m4wt2Dml8iWm4Nj
	edhmdWg1CKvUISFvrpnRo4QJe9Y/ON7LAlW3HnHeAuUQBsHh5WAv3kelo1iY1P8RKA1mJaWHmob
	mwgxHwS9I5rtdM2d8doDNKdisrm98d/44peP+boQZSKRdf8uHzVvRLT/CKPQFCGt5XMOWjb6/jA
	6R1SDuBMtx282gHfSOoEDINIQ2HaEO45w==
X-Received: by 2002:a05:600c:c0c3:10b0:490:b06a:649e with SMTP id 5b1f17b1804b1-490e5611c60mr1428615e9.25.1781137967032;
        Wed, 10 Jun 2026 17:32:47 -0700 (PDT)
Received: from linux-kernel ([2a01:11:f30:3290:a00:27ff:fe92:9192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm75807409f8f.20.2026.06.10.17.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 17:32:46 -0700 (PDT)
From: Diogo Pimenta <diogo2003pimenta@gmail.com>
X-Google-Original-From: Diogo Pimenta <diogo2003.pimenta@gmail.com>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Diogo Pimenta <diogo2003.pimenta@gmail.com>
Subject: [PATCH] Documentation: spi: add SPDX license identifier
Date: Thu, 11 Jun 2026 00:32:41 +0000
Message-ID: <20260611003242.44820-1-diogo2003.pimenta@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing SPDX-License-Identifier tag to SPI documentation file.

This file is part of the kernel documentation and must include
an SPDX license identifier to comply with kernel documentation
licensing requirements and improve automated license scanning.

No functional changes are introduced.

Signed-off-by: Diogo Pimenta <diogo2003.pimenta@gmail.com>
---
 Documentation/spi/spi-summary.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 6e21e6f86912..23e07ba4f8cc 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -1,3 +1,4 @@
+.. SPDX-License-Identifier: GPL-2.0-only
 ====================================
 Overview of Linux kernel SPI support
 ====================================
-- 
2.53.0

