Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A73B4439
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023168; cv=none; b=bKmSx6Lrmnye5y3KwS/+qiKDEnL21FPUz77XD04leC9NClzZfXfY4Yc2HxpkS/Q6HALSIwb/HqFxXJIxnWLwYYyUA5QS94PY9E5XZ/gtgQgxyUu+sNoo9aHb3Qk0gCa26CoxMG6dVA8gCXvWj1MRx8ERofnCoj3jrvsLoUIAe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023168; c=relaxed/simple;
	bh=snDuUV8OH8pBbLO4QJ3FxHi4k+soHp+N7K3PSeQb2P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDPxmw2HTkOmQ3zKnitGmwmT0No/GFvG0/3YI/5/fTD2yg+UaNtqfEfQK/BlpacT/1Gms+31RwVgyZFrxamdt0x4DLLw3QVlvlCi6LhcsBDGyMOemwgrukiEezX1Lkl0XR7LVXxgSKVRInVio0VH7z9EF3ahEHD2+oXVmyzKpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkxI36Gs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkxI36Gs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4905529b933so62721205e9.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023165; x=1781627965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEZz4XYqJIq2oFsihOIDTN5BDVC6/Vtpv4g/jjgK7qE=;
        b=RkxI36GsduiXmo/jftvO3IkyJL+UmLGe+WMjHV+SCCKZwDScQIBAKrgCkJcj4EGK9s
         jta3tWAduXG0vhsoQcuPEsOPnqFJCP/3VXtDjL0KPspAHdMLE4YaZiB3MX7BscCXMhf9
         q9Ki80z3k2RkasCOTxai3PvPBFnwdnUcNvg67vZ6plpaN6/8r3Q24OOC64CfohMOG/px
         Z2thc9vfsGEou5FrqXDzeIngmv9qi8RS569+w4eRXzpubO1+U4pu0SHLQH0QfZssgyBQ
         ToX43lP5NiCe2dgcvgtYPqE3D8C15r3WOsE8xzJoC+RGeqDznHQMLLB8oMuPcLT6z5eW
         kt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023165; x=1781627965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEZz4XYqJIq2oFsihOIDTN5BDVC6/Vtpv4g/jjgK7qE=;
        b=V12WncLKjhaJSAM2GIcN3tNRMxgbk7aHQB14i9UHsyhqChpQsP4hOyJgr2wqVNIgHe
         BsCDXt94Tn61K9URxlgrBZCRfjjOSVlKUNrxYt6GdHwIQOYTBkRtbOvu9UykC646aJMr
         teTA7mDypWAex0GWtCZx7DqEri8aRssFPAewpcdWzaF8GgDm+7poIwOQJnGuobc/lKXY
         KoP5DYjQE7WHBlraCGb73Z2EW2Xn7qjTw0Jps6bYyyYfnXN1qEtnG0B4jrw8R7r7vEtU
         gEuVvN7EbPtCWqx9Wzl40O1oLT4N6r1D3z/kOmwNx/qD27xaY6teRQul7c7Z8BMYrfC5
         hVbg==
X-Forwarded-Encrypted: i=1; AFNElJ/lKg/luMST1l06uYX42L7s2BPF/0onjj8OCyK9IZxKwV1FmI3yn0P1KZJoF22m7/WzCwf5N8X+wjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+IIR1hIWqWk5DeL7sLz7wLygLcsiAaVIzIgiLtGBwuA6Q/lNI
	KKnJWL6PA1rkgJeIALzYLCxtSD3ogv7QaJLrpBcEClRhJPoI2wK1Wd3j
X-Gm-Gg: Acq92OEduVn/AyN+c2zrnCG5aAH7g13CiuWeHqciPcOxQpMsT3CrW8hNPkkP95xgquU
	djYM/veI5xYnSDWnJT7gOslk0H2LyNev+cxpIxPt82hurXU7tphYNoWYTssLZ8dxqbgLdku/pxc
	APzAgld8a4Cx/rY7/o+Uto1Z9VM1ziXOsbu9ePXv5bVDmDSeGl6NuI0Q2KLhz4TvXVLqd0dXx3N
	JXSKr33+JQOdzii+Ec7slArd6L0ePjMcQr65I0eQq7AfGVgdrOb7QugWNDFsCh0WBi7F8PB5QFO
	05WNuCcz8DAdVHvfe3yufnzkapUmIC3EpgN5grXIhwJ9SEDuPI/Q126pTNkbL/l+qZpUZGnniGN
	3pOQdKkto8QOn9j6elllYORbECYxntGzzy6uRv0Ncu1LG6d10CtQTTztOKd3/gN+zRJQ7/RDCpr
	AbR1b+2kUEztJf0xO4rxNWahLa9VNNAzIiJu3SF0LwB94Q
X-Received: by 2002:a05:600c:8285:b0:490:abef:dae6 with SMTP id 5b1f17b1804b1-490c25b09bcmr362197115e9.19.1781023165112;
        Tue, 09 Jun 2026 09:39:25 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d2d11asm440860805e9.1.2026.06.09.09.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:39:24 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Nuvoton NPCM FIU DTS fixes and binding conversion
Date: Tue,  9 Jun 2026 19:39:16 +0300
Message-Id: <20260609163919.3321228-1-tmaimon77@gmail.com>
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
=0D
Changes since version 3:
 - Split the DTS cleanup so the reg-names fix stands alone as patch 1.
 - Added review tag to Drop bogus FIU memory reg-names commit.

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
