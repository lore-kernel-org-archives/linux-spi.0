Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6F431A55B
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426158; cv=none; b=ByEXQfbymc3zjMS3SbsydejiV1JoPqGbzCO7FkiYs1JuJ/uHREKoS3A8MrKUPc3qnmceUQNIFuerGEhlZvtIJa8NuM2BiA1S85KW75EHzGehCRihBu6Ibk451vILs+0qBZIvPZM5/qsBmS+v9xxLOMlX5Ehvcdg1E1K7tAoLVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426158; c=relaxed/simple;
	bh=QvqgdZHeqgEEqc9cqofJhBAJO9XcXQK5dg3RhzWhdyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpEh16gW5D/HmFp5Z3o3UjggxgdS47hqt2EI82MRZvfHe3+FrmtlbRsSpJQPKH9ShftSV3W2C9ackLDqMevsuu+go4ah/5De3DQEpOHE2Tj2+pw0ow8RwJKM2/PpmSxguI4EFhR9VJ99TkZf5TfJgdIS+CY48Pmy2vveoW34O2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4DRH9SM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4DRH9SM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84234c83142so1052075b3a.1
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 01:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781426155; x=1782030955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REc377Cx8g8BwECwGCoYljt/5HARM3EnQdjrMGhJHwo=;
        b=I4DRH9SM/IG2BWx27d95q7AB1e8qZtDnMz+O0+UJM18PK6GHT0Mt0jk7aNFCX600Y7
         1B2THWFaBguXks37AJSnezEGfjrtOP9CA3HAqiojVDUMeQj4l5h41Nc7oimJFgQvarwQ
         oRU8lrPUicVGst1NkOwZg+4d5xgvY0nMgVEKEeIgH70WkWDWCTyuPsxpFXULyv1hqS3f
         tSLDcNZtsSgu/tpY44Jvzcq4at5OVFlk7RF29EMbMaMoiSt6PIw+ABYe65u0/gC3o41n
         LaVKu67LEga+8ZbwLVYcYjojP3qCMzz1Q5dYTUJLdbA8vxHLqnWEoEaA/fRXG+O6nh/N
         DmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781426155; x=1782030955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REc377Cx8g8BwECwGCoYljt/5HARM3EnQdjrMGhJHwo=;
        b=TK0G8TsaTYIM1Lp4edbQ5XFxTWs1z8o2qUZdrAxZz6Z3dmVm7KkveiLb1MmjN/0mpu
         wnd07aEwUkBJkB3x49euRP56I21jXkGh5IOWvbw5jthOsJECCFDKUci5cHOXm3gYSrke
         4dwxP5VodJBAeA/6ejjeytlfT8RpVT9NsGlZkMdJq8KStzHSuDv4MBfC8l+rfOmijixn
         UFWDPXTpjQqqiL9gIFJIWExRZMdMB3hrO6nzxpr1dxqSeVo7J9L1MQOWZx1letB6R8pK
         LNJFc3MU4UlSGwHaGP4XlnScqoVOET+cVKNpud7KDt4cyvLzxTnaZ6pqdYwZcV94oFUt
         P9sw==
X-Forwarded-Encrypted: i=1; AFNElJ/xUx1cgbKmJqdHVS5xBNT1GrDJBNRXTM0kU+C0vToRLmCL7jG3mO5lCfWw5DIRtuw4ekmakE7s5ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQw080+G87YQ9wX3TwtpiwSR7oMlgx2JzRJFWg5hA8RYml1Ci
	oWgZj3/q7Dc3Ccvnf2tDXTruBND0IRRJheXDR9AyrqOmzdSsanbOtYLb
X-Gm-Gg: Acq92OFs+r5JY7uyYf3UakK09sKKLjKmD8jaApR2IBGVgb275Nc/ZLt8Dzng2jIlHn0
	JuKPsYBglTaZfwZDU6TJYEmoUvZnNj5oCFuTfVz0uBQPD98cL0Y0IvND6g9pJ3jMdniJoEJr39c
	+LpgFm3Jb80Urr6ltJYUO/jG9L/td36ENQFxm7zBkb12uzkBtEn1rIkWTTHIeWwUwz+2xffomh7
	ssfChZBrb/yGlSM0+vmjbWBKjplUrMgr7E1KDKvcyomY/8PN9yqR9xp8azXbcQ9SMrzkwDQ5Xy5
	8F0q+2wrLCGiXvG1LLHM2ILm1gwCngtmLEiuBG811Ga4FG5RUBysqLb6qIbQgE7ISChH9NF63Um
	DATg10siIWI0v3wMvOGf5A8sledH9Vl9pK5FhoPzA2/wzc1okHlXp+XySJ6kiI1+0qaG8akyaVN
	SJo+0P9x6wIw0fUiaivjltow==
X-Received: by 2002:a05:6a00:238c:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-844e1a2af43mr7234263b3a.21.1781426155058;
        Sun, 14 Jun 2026 01:35:55 -0700 (PDT)
Received: from nuvole ([2408:844f:2361:d7cd:deb7:4e0e:26d0:4076])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8fc7sm7263053b3a.37.2026.06.14.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:35:54 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: Add property to force GSI mode
Date: Sun, 14 Jun 2026 16:34:23 +0800
Message-ID: <20260614083424.464132-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices (such as gaokun3) do not disable FIFO mode, causing the
driver to fallback to FIFO mode by default. However, these platforms
also support GSI mode, which is highly preferred for certain
peripherals like SPI touchscreens to improve performance.

Introduce the "qcom,force-gsi-mode" device property to hint and force
the controller into GSI mode during initialization.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index edf399681d7a..80e394c1c715 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -45,6 +45,11 @@ properties:
       - const: tx
       - const: rx
 
+  qcom,force-gsi-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Use DMA (GSI) mode, even if FIFO mode is not disabled.
+
   interconnects:
     minItems: 2
     maxItems: 3
-- 
2.54.0

