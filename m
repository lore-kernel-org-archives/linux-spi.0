Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B562D0615
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299584; cv=none; b=oboNoK18vAnNpI2XaTBqrkHRu0LdZtXkaCqi1YzwLFqdXYx/q9hsO37T97BgL9fAgxp9RG44ligob9IHGfGl30RUWqjr9gKgaT5NVuD/d4EnmW8M4HVv21F4ukJsIRD9Uz8eyEmQBDblcCzeD4MZfZiy9+JSFAzF+62Nds8Zfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299584; c=relaxed/simple;
	bh=OIPMXvKZwuWAWDHePcauH/eSNbDXWC6yVHtpY8sqHRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oPgxVsFH4RAP/eso8J0KL5vK+l9OLhFZ3MvX88QM1RoasXkYdQgoVBZVWfYjDb6Vkt94c42us+fbhHZ48VYb+Wwv25enhnhNHLJ89lxD6y3HIalk7aK0gWVLR1M0SFZBzwpKEm4rl0LERrNeYFSZk1Ol2ugDmsOb2EnX6w51vfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ55eadi; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ55eadi"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485b358552so8708876b3a.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784299582; x=1784904382; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m6JMxGAMeORwl1SYUzJ4Avq6RnSUEQpdwdVOG9zM+x0=;
        b=ZJ55eadiSz/HA6N8F7GM3oNOwvUQ4fXvnr9pQ42x/t2tDJRjDBgB9ohwqcsvlo0EkW
         6VbVAAsqo0X7kXHLGESOZTDr7VntuQjcBkHvX7kKVrKLh7WsZtECGIoAyJbBp9WJiBj9
         BYyivlAwEqaat+131a4d23i5CyXxhXjBOLvgXtFM+XX/Oh+3uhEAALvrGYzlzp4C4SsU
         MsSAZybjB1J1eVvO6maX1oFMg6UzBxbLbPRj452a+bpmF1ktg185yHulzJd2FvgW9FLu
         NK9S23xiFR58+SPNAwFW5OmfJa36eaSYbo2SuD/h3mYIbRtisgdVGc7HptM3HOmJCRLk
         /drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299582; x=1784904382;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m6JMxGAMeORwl1SYUzJ4Avq6RnSUEQpdwdVOG9zM+x0=;
        b=rCL7LCin0NJpTfhj0fy+YmoRwoDv6GWhz5SQblTXjF88ro4kGDIRiSqGkK8s7mdpg/
         B7vs7KKMXiWS1OupnNwrto/3e0bQG85va+zfE7d4btlRsieEKUr4cgXvhiEhN3OSyPn1
         fPF5oanBmjSsHLwWpEFvhfpGjuaQLY07O6MTVNobcD7yG571NtcG4CfPjiGlmCJO6jcb
         8fLa2d87NIyLmdJnDtATzIZKNPDWLRx7uvkRsbST75ALyuB260QH8BfSRmKa3oaUMc9I
         d3IvapHbPFZVDDB8UI1KAA3wa/W7OjtAXh0SI6Z6V7nlIz46j8j++Od+yM2MV+shiTQH
         4MSg==
X-Forwarded-Encrypted: i=1; AHgh+Rpu8ZlCMK+SWX1IQz3u/3ciu4NaA06XM8h+42eqGS22msPwf+ApyXWLKnEMHeDRwck4lYuEKkgI9ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Yvvn1Eo50od8EN1MlrThixjQOCw3Q39HjinhOy/MwBqCg89j
	uY/rrfMarf25aatjOFgtMKVoV4jSrVuOMhDG0Hsj+FxaHTvfmhP6alKE
X-Gm-Gg: AfdE7cnXhFXRZP7knhhZuyoKlOk9ij3GVxfwcQDL1bL7xqJH1/HJnjEJOAHcq8zfz59
	I+Xfy0hSIRziZuvYPMI95gSj3Stj2UEP3iQOqs4yIP8JUQadg/Ujsmd5k6q1TM2GUcP+5x3c5J/
	0OoNb27IIf/v8nSe5a5YE5CFoBf/MpvMbvKLGaY4w0RkfxR84nCApr4ut7nU0Tw8PYrs2HBRy01
	V9vLDSWC6NOJXxaObX2mIoGGRzZenx/p0AspRImbA/1h8+IONRy6X/507LkPzKF0izQCV4g4/6j
	GYA5HjPXbPkmZlHnQ2a1zE8fc5xv28AFyXHKgZ1xrBwoyxXi8lWdvUSbTJa4z85n4+BQguOIumz
	Ni1sSWQRvFHs7v/Q9uppG72yFwFnWJWv5+enYwBWZi313NiKSHHpsR4fBDqRBNNrjkENjw88a4T
	lF1Q==
X-Received: by 2002:a05:6a00:1784:b0:848:65f3:23c0 with SMTP id d2e1a72fcca58-84c2923a63bmr2877553b3a.1.1784299582194;
        Fri, 17 Jul 2026 07:46:22 -0700 (PDT)
Received: from [127.0.1.1] ([192.220.14.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6d519sm1166408b3a.40.2026.07.17.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:21 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Subject: [PATCH 0/4] spi: spacemit: support K3 SPI controllers
Date: Fri, 17 Jul 2026 07:45:24 -0700
Message-Id: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2N0QrCMBAEf6XcswtJDIn4K+KDTS96im3JaRVK/
 91UwceB2Z2ZlIuw0r6ZqfAkKkNfwW4aSpdTf2ZIV5mcccFEG3DbIg33CtBRMEU4lOTQeozrnl/
 4qybGvAud9T4bqodVyPL+xg7HH+uzvXJ6rAValg9gBWi9jgAAAA==
X-Change-ID: 20260716-k3-com260-spi-v7-2-rc2-b4-preview-20260716-077f86d144f0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Alex Elder <elder@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Zhengyu He <hezhy472013@gmail.com>, 
 wefu@redhat.com, liyeshan <yeshan.li@spacemit.com>, 
 Guodong Xu <docular.xu@gmail.com>, Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=OIPMXvKZwuWAWDHePcauH/eSNbDXWC6yVHtpY8sqHRI=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqWkAt6LQ1BMVvY5sduW/KRV9RVz2vmM1p+9bjq
 P+2is2xrAaJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCalpALQAKCRDN9pw2gLgN
 2LRYEACGXe+KRwOLl6dDegR3fIqUbV3Spz7oC1VhGZo+Ogpb4C56+sLl8CngaAHlpFyyv3gyqpQ
 q58zd8HxcznBK6W+syG9HQzhCaeQxpceyb/WYTeEb7+UoKPbZ0IyhJFSn4dlqdFdIpaZgmYwCdM
 xLQVaG36ffyc1/u/6n3b3REhKzWKKhB7P+Sh/8V1ZF2aDbDzGpr/E6DSKQN3Wo4RtSuTemi+PJ+
 PwC013IrNg4LLps7qPu5IqJ6RQ8y9MH1thoFIMHAUoWi1/b+Ixajk0xRYXJ9X1Mihz1MiJWKrd4
 wGPAKrayGl0CjOKI6wjqEw2VnHdHEOK/0w+PMGWzsLtBILZCFSL0ZBL2rpv0bJfYvACPmFT08PR
 QCao193VhuW0hQHbFbH6Km+tzmg921cKQH08Y9S5vQkz+Cj3LHS+pCH0M3D3d0ssf0tFxnMIuIF
 CMiAAE2XTH5vPZE0HQK36n7Ez1p+POPLhQZx2MhpX9WeSErDz3LRDH+vRe9lOgXZK+T9jv7k2/l
 4r6s0ahnqkJUaI7aw0zZG/+Dn6QhyduANPqsIvruZmZdaq17su/+3rgdiDX9sFcJ8ixJ3lucdn+
 MQvbvaV/5tIsgDiX3p5iGNlC+iE3oHHB7pKozFtVxrFAKIiYGuzVaSvAyqtedi4HIqBrBZXPGLj
 GtbxA0tYKjHBjig==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

This series adds K3 PDMA request numbers, documents the K3 SPI
compatible, and enables SPI0 on the K3 CoM260-IFX.

This series is available here:
  https://github.com/imguoguo/linux/tree/k3-com260-spi-v1

This series is based on v7.2-rc2.

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
Zhengyu He (3):
      spi: dt-bindings: spacemit: add K3 SPI compatible
      riscv: dts: spacemit: add SPI controllers for K3
      riscv: dts: spacemit: enable SPI0 on K3 CoM260-IFX

liyeshan (1):
      riscv: dts: spacemit: add K3 PDMA request numbers

 .../devicetree/bindings/spi/spacemit,k1-spi.yaml   |  6 +-
 arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts     | 13 +++-
 arch/riscv/boot/dts/spacemit/k3-pdma.h             | 83 ++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi       | 21 ++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 49 ++++++++++++-
 5 files changed, 169 insertions(+), 3 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260716-k3-com260-spi-v7-2-rc2-b4-preview-20260716-077f86d144f0

Best regards,
--  
Zhengyu He <hezhy472013@gmail.com>

