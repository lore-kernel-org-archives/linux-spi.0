Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0022D7A1
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724901; cv=none; b=MLjZoS5F5ZVJZty4JQ/HRbqQZLB37kmAHqFonp95iWKBC9vdKcKXKrKPDBDw82MBw9aX251HpPnMn/I9wtf0dluRddejpAHxpzPy9wOTQfK4DbZGQdG0cV2ZJLO0kYrmUCZnJV06mEOK+6Z4jzVyjse/4afj19tjatciBHZTqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724901; c=relaxed/simple;
	bh=zIrrFuB7x4ex4Jv1JNXALjQ07Vk9xYw7VV0Zi32eI1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WX9WJOIoNzp84UU3yVtvc1lg8NzIsjEoVlOwnYDiOLU7SUuUzWgGsaZSayD4DwaXWto2UCh/O8PEf3GIucGZWUTt+5RqrUY5r0tFmktNn8Axst//VLQNMVZpwAvGmjsyidaKfpDA0em1f5LcDwVvkzOrjfqsgF8Ejob5LuYNCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB/yvzXI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB/yvzXI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf27856f9cso28284465ad.2
        for <linux-spi@vger.kernel.org>; Sun, 02 Aug 2026 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785724899; x=1786329699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sCHwCKyWw8sq72dejSTrSVAee4EJg7rmMPvIvja2B2Q=;
        b=nB/yvzXImkLOEDvp/LPr1tKtecByc7rNZCwR/8djEJj3Yl8HeKlf4jSAnZOG8XKPGK
         0njTIN1C5Van4bjliTdWzdghj7CPx9ZGv817T7uSN3vSMBsAca0HocV36u+dsIibfQab
         nf1aGDlRpscOyN+dAtnHHrZVMHqj+c1iejwsKQqvtuJ7mdq9howysJXb1SwBnCd1GP3w
         DgCcexBkTk7xnOrtTZPRUoobHvPIqdgXUJQyDGQl8IJ5TbMgJfbmCpq3jCuawPsd3+Rl
         wqvBZJSN/6YtezoZmeGwv1RYf8j/nMHYKY2u4hdYr0VFkJlrf8xVM8/Uja0W11hambDw
         hEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785724899; x=1786329699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCHwCKyWw8sq72dejSTrSVAee4EJg7rmMPvIvja2B2Q=;
        b=rIPkNcuJ0t4aX9OYsuxAvQkF+lcSdSpTpQZSm9mRYFOtFzeFH+rQPBX4ZztIMoaAmK
         3ROeDmzGzjMINl7KGo17WDGBd3xKRnRLbkl71Pl+QjU8wJBzLqW6yrl5zaXmaM7fV4VE
         87MbkMcvbGZoM4uRFA8LdWn9o0pyRrJnbCpsy9w1ZyyAQQEPPfaJF10uFWAUhBWY3Iqs
         6IbmC9x6FE09DAf00D9BycXkeL3fvoyS9tgKAHP+Vfs5NJbrJdH2NgOoIYzPiLVt2k89
         Egcv6P/o8MQYmSheK+ylioVDF1CsEEuxF+XoQ1o5Tw94U/n95JK959uMWI/66fnsywer
         hRFA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8RBPvM3/IWMIc2Vnx0vpaw8nfAo2ApUmoFd1I2NTHrcPYzSbBK1vlByMnAizJL/6EmpmdlOhtYog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/o5VAVfwOkt+hKsgTWMavDJUuQY0DvPBL8xKgTVMcOF9c2nD
	+8QqY+3efA6llNfKFm0ZypIhei2GCvnabQ4HVgRe5e8SK+7xIiFOPMfU
X-Gm-Gg: AR+sD13Ax+oIZCk7w99wR4zlqszuqa+OC+lx2E2/FYiFVgudxjWvngB5eVtU7Llq5o6
	iboNs+Ph98FhtGD8TTDQKvA/N9+31DAK5n5NJkMBhVSy9dKU569jrcEwWeUEQfP6kZSwa9bNE0X
	MrgD3UYQ8fm6eC4x8Sjp4l4Jx9wcMjB77IWN8SEEPVJEE+b8s+SLPv2Ec+//LPRt3NkBI5SYi/X
	xarZaDkm31+x+lWvkQYMr7vJfOtXdrMvcZiEnf+KChTkvvqSw4OFPPJIcHIE8DqC987KODUrx9p
	ODMjpdwGFjbme+RfUvARFAWF4ehymRFnfM30FUHVjRIdMq6b6Rqj4rkHA3pA/f31Gnj62T6I0l0
	ZRBtMK7wq/DRz1UFe60GvcWcMoGTStNmNFKV5aCZO+6nsacbSKkfxKN3xkVErSRQ1Qf9IxdNAHv
	/bBrOMu1J9MS+FKkZdsfR4oj01ZznEP1I6dnUOB4wVnR99RPjuo9sGABBxpSXw6pa6G+cX6oB1g
	hSUn/vqg84CHfbHpqBgrz3kAuQXP5gJWlLOMs5OtPq3TwHWFeg=
X-Received: by 2002:a17:903:252:b0:2cf:b6b5:9cce with SMTP id d9443c01a7336-2d0524cd574mr99284765ad.46.1785724899298;
        Sun, 02 Aug 2026 19:41:39 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5abaesm30827645ad.27.2026.08.02.19.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:41:38 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH] dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO chip selects
Date: Mon,  3 Aug 2026 10:40:48 +0800
Message-Id: <20260803024048.1641756-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

The generic SPI controller binding allows GPIO-based chip selects, but
the MA35D1 QSPI driver currently supports only the controller's native
chip selects.

Disallow the cs-gpios property so that the binding matches the
functionality provided by the driver.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
index 377ccf4fb224..40965ec5163b 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
@@ -33,6 +33,8 @@ properties:
     maximum: 2
     default: 2
 
+  cs-gpios: false
+
 required:
   - compatible
   - reg
-- 
2.25.1

