Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517C36D9EE
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941278; cv=none; b=jsvEjUNmRT9nJlwE42BmpigKzz+HnYsDKmq6uHhR5KVr3D1CVNapJTj5LKpCNdFjGDKdcWmNotP4olagw79rUtTc1Jio+4nwBzrRbkXFOcBxHcT1QoQHP7aA38C0YNt9S+oVq8m9ZouGDMoELH0LC8Xi9hfBLGZmfxyjswaBaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941278; c=relaxed/simple;
	bh=ked5OFQixMHOHNQU87e3oVNysEwBLn+3N65tqp0ANF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u1Cd7y68ucZ5VYglZrchhcezc4Gv2kTgIigO6HPizLum+sGJvKRT8rVBS6+dWSTPB9gpp2DiMAAwAKqoxe35Vxeeywj+2X0mSAVX3qCjmR/JWW+DgGyrOSWQMXGnzoql2SUVrIS3S2mDr+JcKPOtdSERTnDgy76QY6sZkq/wHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9Ajl/G+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Ajl/G+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b7866869so53487575e9.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780941274; x=1781546074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGF7+QWpJakGRZT4D0HON+vY+LPOCmvLkPwggXClSNo=;
        b=Z9Ajl/G+7Y8g+uWqtvrjDCLjSu4ebwNVhHEvkQ0N1FjYMGsHjKpTLYK9zrtQWuq9S5
         lMW7+uBt4luRz4o15tQ5FyGntnVCzJeEJ1VF3t8OQGSfXt83IP5VC5K9NiMIrDDctBHw
         UYxM7Bcj4m4YgGlQoeFasuHS/50Neyv6EVrqpNnveKylzCBSy+4fKPSw/gjca4uMg/9/
         T7jsdRjocGrAQ5qEv8EhA4CIXF5NSkBx1WjFimOthCZWbpyUpPzHf8gD2ZHDyOF62MtY
         EkWDJa1pHp5h6FU6hN4MD8zPhy7bd//GrNIyz8LBc986S2IHOddDDq2airShaEOQCLUu
         QVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780941274; x=1781546074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGF7+QWpJakGRZT4D0HON+vY+LPOCmvLkPwggXClSNo=;
        b=bWIOFrD+/botpxu/P4zvDfV5sjiQHR/NEFTZJuDyaQKMGo8WcD0oPurQVZiBDxQktO
         A5oe1FzYO9wlkFsX2WivBAK595so4ikJsJkn9pzn1zPoNJVF9tfDvLg+TJpP1aCOOiJG
         sTFvs6Pes8hCdb9pVEIy+Aty5P6CipyAQDQO26cV4+kSspC5Q43Z3EcOtIy+vg5yTKCX
         vvcLW8CMz0UMZD4+ISyTVnSn8h0ORCEBiUlytoXxm6nTvCvtxruqj3iNW11vS58pb7uo
         OLKzKpfbXuH8dQzj5htAGPhrcMz9C0dKyjhCmjL9RzaNRYNVBIr3U/bRKf5cI+v4WDyZ
         kioA==
X-Forwarded-Encrypted: i=1; AFNElJ9jod/JvbtS+57H0wS50oVS2nna+cMDKM0HP+z+UEoVGaorSPqsG0Z5CPBzmiqDcWTGJ8ZxgqYvC8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOo1f7mZHfkrwvQTjAG4OFJbI0aywb1kW4GbkfLsx0gxy9pp7p
	p+YjKnbMIz9mj+BMwKsMQI+33QpkGE9fb/lxhPefd175wcpMHrRPPT9V
X-Gm-Gg: Acq92OE3uaQAnYQgpGM2S17GfmKo2wtdbPjgi1UzsZtG0sJX01Sp+f9uieXS7lPQ90n
	VDXwVFhz4z9BbWHzJV6ybh35HgFXaPhq/dP/IT0rTo0PJSdAsOy3592y8lDye0BamoCoNiX6xns
	ORfEONw5g2KQlsYmYbeaQT7vWLOGai1NFDJGJ93to4rD5adASG+qBLrIePCFVs0ioyOMmEab/3o
	Sw9W1ocvJrFWOm1pyRxCs28X8tOQoBrMrou8QcB8pxVPR3bv1McsYs2j5v1MYoPM5mM+6Ts8uK6
	/Ij1p30HgY9WYLhIoLC74Y3N5m16FhsWWTgKNRo/Nqd0+svdmLKnhP2RJWNZXAaaNQA4HCF17tm
	SjVXNPbZiWcgh3aRXmbjR2nknKuaEmTGylEOU+hWG1LwyNjrhQeZwoi95UgSgOz4X3ScSPOayGR
	2B0OYv2orGNH2laSDuo9RzRvGvCFsXF5r0SokOQFO+G+v0
X-Received: by 2002:a05:600c:818c:b0:490:b0e1:2161 with SMTP id 5b1f17b1804b1-490c25b39fdmr304459345e9.2.1780941273354;
        Mon, 08 Jun 2026 10:54:33 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm56269275f8f.28.2026.06.08.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 10:54:32 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Nuvoton NPCM FIU DTS fixes and binding conversion
Date: Mon,  8 Jun 2026 20:54:16 +0300
Message-Id: <20260608175418.1936892-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the in-tree NPCM7xx FIU controller nodes so their
resources match what the DTS actually describes, and converts the legacy
Nuvoton NPCM FIU binding to YAML DT schema.

Patch 1 drops the bogus "memory" entry from reg-names on the NPCM7xx FIU
nodes, which only describe the control register window today.

Patch 2 replaces the TXT binding with a YAML schema, documents the optional
memory-mapped flash window explicitly, and accepts the existing FIU
clock-names used by the in-tree DTS users.

Addressed comments from:
 - Krzysztof Kozlowski : https://lkml.org/lkml/2025/11/13/473

Changes since version 1:
 - Drop interrupts property.
 - Drop unused label.
 - Keep reg as the second property, followed by reg-names.

Tomer Maimon (2):
  arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
  spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT schema

 .../bindings/spi/nuvoton,npcm-fiu.txt         | 58 ------------
 .../bindings/spi/nuvoton,npcm-fiu.yaml        | 91 +++++++++++++++++++
 .../dts/nuvoton/nuvoton-common-npcm7xx.dtsi   |  6 +-
 3 files changed, 94 insertions(+), 61 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.yaml

-- 
2.34.1

