Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400440629C
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093915; cv=none; b=l1cVOv6xbKimkzOPf21lltN2icYA88FL/xlGRYBpHLhXxIYttZNcC1fitl5jLrlQtrReBig4z9oaJFxHiAIQw/0QEyUApz50nTpf1UpeL2cXQooiTb4ge+jf7rIhK2yTcocbpDlyQjMGszFEVEDA95XpDN8lUb+QWIpmwr05oVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093915; c=relaxed/simple;
	bh=Nu8HpBISkhyyT78YFJLyyTWj8tTNef3kNVTDFyhfXic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YZh3tb9PjG7H/BgvMmSe6jM4oou/nBy5tOHaSHybBP/xdBxqysa6HfY9RCjK5rr3OQzDSFSgYuwSf6Ap3IWXwT3kEr/bl+PcLhzY+LlztuCXCOZWR0ixNKrQMp+E9iNVyo2rpTKRgEpkPvRo+KeIAGiXyg4ftFLVu56KOUFfjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JszroMch; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JszroMch"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b915ded5so58208215e9.3
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093913; x=1781698713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0VPo0DaS3Hezc7yA/0Ri7xBuqxAb55K5gZJtR7wfkmI=;
        b=JszroMchCWBfh0pJQhV3XUqYP4c1meYDadJdffU6n3Qdez4b+s4GfjSCnclOyTqPLd
         V42n/usgKmbhir9bPt7E/0o5r5npnaZ/ALqUSMewruW5zsyg1M6ADqHxN0yz5IRjnD+M
         jvUsBVNzPlpAGpdlavzA1R2n14B8Mmywu5lRZdwjzAiriD6Y5mPo3dJ5SGWAfS2BnLsq
         NVcQybrEgdmcHRL++wJ4sOzmHRL+/PYNQ3ezb2PZrwE7d8Y37/in0cCcG6waTc3wZnT1
         kgLfX1cqCJlXCk1IzpR9FhPBa4my8mbCG7Vpu3Z7JSZIBQYdMp9fIZvueWG/zH1hcddK
         seoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093913; x=1781698713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VPo0DaS3Hezc7yA/0Ri7xBuqxAb55K5gZJtR7wfkmI=;
        b=TjElLHg2nrDTc8FXUFfdAgCRz6hpfirCzFst+bRpbt+VhwQkX7r2cIcdwPY9ntJPM6
         hx1CeCiSMkI/0LHWXmYc87dV4EFUv4Ekn/fufECNpyfEhoHQY/A8Ddr8fV28nMqDWWgh
         ukidDCQKcT1YlhCO8pa3Rs/qpLf94qCkeAe34UeP5mE4+SO2FQUPK2zB4OZDwZUb/MoQ
         3if97PPHj8ojbbI89Q6f3509ruvyX/7sInR/J4gIzrLOEsZgVyk/Qt9N02XGSaGonfFU
         janAlNrq3L1nrOIe6eJNVp2h3vo3heBpy5fvo7Y4rHYK/8PEvIawsMc9mw9bxb4sOalb
         fDvg==
X-Forwarded-Encrypted: i=1; AFNElJ9nqIvjnxMl9uzchoAJshIFM16BYzwFSRRHIJ8Kfv/E8svgbW5qFZr2NGOzPrGsorp0gU7J1seG+xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FMZO3nDcBOMLPc2G6y3HeXBayk8nfqgT1O1OdjoACTFjHGax
	CY3Utarzw5zU8wOuA0NBe6zQErihyCoMZFiYTtJWoDbmpWp+j1ySup0/
X-Gm-Gg: Acq92OH8Q0NpQ8+XHaoy1KrP46DGIQxnZLBcj6C65zjYFsUwwW7q4uweMHXUSSo0sgH
	C+bCkOYTNOK85WISz0RvaUGgpVflrgb2tlKrLYHXDZKJgTueSqcdcLHLeXdevY5L5HT8oOfU5R8
	0PsCrylnxEuZkIbiZ0gbPpHofbkiwmdlxTmXp/96GXZw/3ee3YqKxtkRaj8+PKcYanwlqqOS+NF
	b36nq2yY8gdhDsueZNPov4+B7t4SnRo7Le81kz9bUi45NHbqNc5ATsuyEG1uMbfl1s06xKKipTh
	QEhzHo30tasXNSiyL6//EbvnXA/uzV2LT0fHSYYU0BRJPsOmxeZio8CLlIJakuT+qP12toRdN5B
	mKRdWrZjgKaSPiOM8deINuhGhZUhxWTzmnEv8miEjMvP97TFfJmnxOi2zcNa/xMXOnl9/+S/sOn
	G23JoDyRnf0d1lWxbSJEaE8bM0RMsgosF21dch+sWC/REh
X-Received: by 2002:a05:600c:34c7:b0:490:bb45:79ee with SMTP id 5b1f17b1804b1-490c2525299mr414522655e9.0.1781093912703;
        Wed, 10 Jun 2026 05:18:32 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm566553095e9.15.2026.06.10.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:18:32 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Subject: [PATCH v5 0/3] Nuvoton NPCM FIU DTS fixes and binding conversion
Date: Wed, 10 Jun 2026 15:18:19 +0300
Message-Id: <20260610121822.2524634-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series fixes the in-tree NPCM7xx FIU controller nodes so their
resources match what the DTS actually describes, and converts the legacy
Nuvoton NPCM FIU binding to YAML DT schema.

Patch 1 drops the bogus "memory" entry from reg-names on the NPCM7xx FIU
nodes.

Patch 2 drops redundant clock-names from those single-clock FIU
controllers.

Patch 3 renames the schema to nuvoton,npcm750-fiu.yaml, explains why the
direct-mapped flash window is optional, keeps the requested example
ordering, and simplifies reg/reg-names to the ordered minItems form.

Changes since version 4:
 - Rework patch 2 commit message to describe the DT binding rationale for
   dropping the undocumented FIU clock-names properties.
 - Keep the patch contents unchanged from version 4.

Changes since version 3:=0D
 - Split the DTS cleanup so the reg-names fix stands alone as patch 1.=0D
 - Added review tag to Drop bogus FIU memory reg-names commit.=0D
=0D
Changes since version 2:=0D
 - Drop redundant FIU clock-names from the NPCM7xx DTSI together with the=0D
   bogus reg-names cleanup.=0D
 - Rename the schema to nuvoton,npcm750-fiu.yaml and keep reg/reg-names=0D
   immediately after compatible in the example.=0D
 - Explain why the direct-mapped flash window is optional and model=0D
   reg/reg-names as ordered minItems arrays.=0D
 - Drop clock-names from the schema to match the driver and updated DTS.=0D
=0D
Changes since version 1:=0D
 - Drop interrupts property.=0D
 - Drop unused label.=0D
 - Keep reg as the second property, followed by reg-names.=0D

Tomer Maimon (3):
  arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
  arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
  spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema

--=20
2.34.1
