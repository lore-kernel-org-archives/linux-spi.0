Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3C257459
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374714; cv=none; b=VLgD4pJIJk/hTP0ZAQB7H/+WaB4OBpoRldmxMkCuro//Ajh/tkeNtTVVc2YuLimVIWwFP0XycVhNMqjb8NOjR5UVtOGLlwPqfAjgYidAgoyzg3jDSzm7A2AMOeshin9tfuGSnmt/Kw2UDEGUeaZMZ5cuum4KbsdSt+Rhk4tDESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374714; c=relaxed/simple;
	bh=5WzCzpQAfauvNBfuz2h93m3dBjmIB6B+A5Dq0d2HspY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QgXmRAqMlBjbx4Pv1t1bgo1lTbybGL+KLI9V7Xkf13gpDCnnf6qKT3FdQPgqI4RTHF9V2rHdBeiT4nGVJptJAiuDqPMg2Y6v7vovQxjk5vhGeoVNMKq036Vguutha/Yp5Zs6I2sfiR/M1i8K+qlxyWcTjp6mM9StztjBx7kgO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9lMi2c2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9lMi2c2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bab82d75fdso30723715ad.2
        for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374713; x=1779979513; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWXyA/icX3UC/cu3pkBD8KPyWdonFkYMhFuMrf7NsXM=;
        b=N9lMi2c2/xHHLq9PEKkJWwQMsl2zYR4OKf+N+otpsW7P2uXt/KfWTjEpT50vhhKKt0
         m17B4FAC3B562VfCII7MY1tJfwRfxHdiZAad65wfw2nVPlKzTcGb4F1DYIKLjn90Z3Er
         3nragKSbfX5HdW1ppILe7OWJF/9rmEBUIML7hgnOAZlPQNFxS+F5A2xMkwhHaptFyYEV
         XMsgn7cu2qY62bhhP2+VS9SFLduOMfPSS3rvwVlR0+b1g9xWpV7tG1IoKlBXJRlPhTQh
         0dYFqBt5h9SrGAC6BoZ/mMlMLR6qVMcbGyzI1mlATAhkZ23mtZtbFXbHXn0+4k3OG1wj
         Mxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374713; x=1779979513;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWXyA/icX3UC/cu3pkBD8KPyWdonFkYMhFuMrf7NsXM=;
        b=dZeSU79fbOxc+G9M1ZunOd+kQfcWq7mo62ICCCnBmvZYCR9WwOFkp3vcbMECRKzvx9
         BROM9aE9lvthXVBnVMYwpYu046SMBIqiaIOtbLAKHIlBonIRPVIeh6r40BzqwwFzPt1E
         /dHQMNPdif3mYxfdTrIdlJqw6FvMmCYIoh5SRZt3HnS1WeVJ7yEQqbqSOK5Kg0K6WAvr
         vNWNGpPXNcO0oAHUN9J7VUQQxe0CxGsAo/NM7+aHYqJeD2YDgGjmwoPrbfJxqF4gg95j
         6Yz/8O2AM8+LIlW6qfSIkZQIeEcCRAqHzCLrNby0N6uNLkxgzzf/DnmZrsghuyr6NgtC
         bNZA==
X-Gm-Message-State: AOJu0YxEOveE/Q6rSmRMup0IdGVN77ZkzOw/XtTnc5hNakqTWBdo2vTL
	t97Z0im8vs9DJoEtcAZB8EPkmmr6Gj3QzsSU98Xgwhn1tNlPLfugRORV
X-Gm-Gg: Acq92OEzvzyrraHHCKKi9d3CIdGE4UzSilfuoFvdodDMEZDkePAOD6kB9u/Akq2vxwy
	BsyYiZ3w3BYkeIqlYlgbGySVyHZMnydH4El1b7b0hYVBdCQ5fduV1D/nHisWh+ET/I2FMPulhZI
	z6iNigjZxV8HyTTmEmVHwkOmrtynDxsJOqIrsnj9AJSWmudoHSUCEmh5z+iyc4Vugkc6C4qqfWn
	kDIkFy6VhFLBchOdDq1HyJfXxvtZCvsn0bP0JLp1pvPCYZC8/BW9gUSVB8kJgTnLFK4K1aEkCAN
	GB014o0M0UhzS+eU8zhVrlrWeY26/DLFtQ7wZgvuf7n+a0tC0f/1zgmWOCD+j4AAW3j6JYHKqDL
	+lRgSPsefZ91UcDtIByYG9olj9oDChmIif7X2PJaChwa82YFf/WQu7oQqNvHv+qzoNqaECh3IsU
	yDJ5om0nbTaWpFLiVfaPJpAaiGetN3dQ==
X-Received: by 2002:a17:903:37cd:b0:2bc:db91:f5a7 with SMTP id d9443c01a7336-2bea30a8697mr30793125ad.11.1779374712767;
        Thu, 21 May 2026 07:45:12 -0700 (PDT)
Received: from [10.240.146.115] ([2.27.148.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea990f667sm13261475ad.62.2026.05.21.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:45:12 -0700 (PDT)
From: Zhengyu He <hezhy472013@gmail.com>
Subject: [PATCH v2 0/2] spi: enable the SpacemiT K3 SoC QSPI
Date: Thu, 21 May 2026 22:44:44 +0800
Message-Id: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NwQqDMBAFf0X23AdxrRL9ldJD1dUuhSQmIgHx3
 xt66HFgmDkpSVRJNFQnRTk0qXcF+FbR9H65VaBzYWLDnWm5xqdB0MlD94wtBcXBWHyEk7zjb1n
 bj/29ZjPblkorRFk0/z6P53V9AWk2ROR3AAAA
X-Change-ID: 20260521-k3-pico-itx-qspi-v2-for-next-20260521-889b94120d85
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Wei Fu <wefu@redhat.com>, Zhengyu He <hezhy472013@gmail.com>, 
 Cody Kang <cody.kang.hk@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=hezhy472013@gmail.com;
 h=from:subject:message-id; bh=5WzCzpQAfauvNBfuz2h93m3dBjmIB6B+A5Dq0d2HspY=;
 b=owEBbQKS/ZANAwAKAc32nDaAuA3YAcsmYgBqDxptfRkZxF1rnjUhQ8FwCZSHP6DrxrqQCYuh3
 peGvWJVYuKJAjMEAAEKAB0WIQS9XD2kxy1NmfC2u/XN9pw2gLgN2AUCag8abQAKCRDN9pw2gLgN
 2AmeD/9sN6/gePDDOupWgz5WRXZXq2IH9LVJ3VYVv0qO6fQoGTRp/dXRlj+B0jlX8Mbc+we9Ii2
 f+XRROGfSiHjakxGUqSu/F6DpWRMkd28p28GN21cycRHdxeOTLOt76FG6xFNK4SQMFPHLbFa8M2
 80mgRd55xaK6M8sUeH9kOsHwp/xMWctxVaTMK1EHHDUnk+jJzIx2jXF4E353f2ZaebwhpXFJTjo
 IgGw0Ab7qplYN53/QIp6GrY8UG7yOWOGVCCLsYWZI4TZ6mPTGXSuF43wo/alHvZVD9ys0EA5oMS
 AN8f05AyVPtduTYxub51ooGB7er0I77C8rVUP324npcoZV80p55+hmAEMdCAjL5TLcw3HiwuyXL
 6hh+sERko1zGUVUs56yDEWjk8TTT0y2GLnWQUrDKBQc4h5zya5Ii1b9JIno3Z/oGZrTBm51IylW
 yGuVUIa4OhWWEYggVqvQmatXOrHC2ZUfDn38/zC4ZrDPR1iodsL6nBfVZwHqqGr9t8E5X6gbUrI
 fzh5vdU1vJ+S35Bkc/ZXR+zMUq7Ko3+kD+h0mX6C2+E3pFtsbrjHRX0HGhyuko1ECVxOJx1wf0N
 2SWk3UTaxyaoLm/+nDreQq3B84C24n1yGV+vPCnXhB3ggTqcCBgtlKwumHxcGMslxLQM1imOe/8
 GeUeRkkJ6T+M0xA==
X-Developer-Key: i=hezhy472013@gmail.com; a=openpgp;
 fpr=26CA97B1A229C229822278F254AF850165158959

Add the SpacemiT K3 QSPI compatible and enable SPI NOR flash on the
K3 Pico-ITX board.

K3 and K1 use the same QSPI controller, so the K3 devicetree uses
"spacemit,k1-qspi" as fallback.

With this, patch 2/3 in v1 is dropped.

This series is based on the for-next branch of:
  https://github.com/spacemit-com/linux

This series is available here:
  https://github.com/imguoguo/linux/tree/k3-pico-itx-qspi-v2

Version 2 addresses review comments on v1:
  - Use "spacemit,k1-qspi" as fallback for the K3 QSPI compatible.
  - Drop v1 patch 2, "spi: fsl-qspi: add SpacemiT K3 support".
  - Reordered Signed-off-by trailers.

Here is version 1:
  https://lore.kernel.org/r/20260519-k3-pico-itx-qspi-v1-v1-0-c32afeeaf741@gmail.com

Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
---
Zhengyu He (2):
      spi: dt-bindings: fsl-qspi: support SpacemiT K3
      riscv: dts: spacemit: add QSPI support for K3 Pico-ITX

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  |  3 ++
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts       | 58 ++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi       | 21 ++++++++
 arch/riscv/boot/dts/spacemit/k3.dtsi               | 17 +++++++
 4 files changed, 99 insertions(+)
---
base-commit: 6edd9a0d32e1ef81133b8cb5b3bb3157a44da4d1
change-id: 20260521-k3-pico-itx-qspi-v2-for-next-20260521-889b94120d85

Best regards,
-- 
Zhengyu He <hezhy472013@gmail.com>

