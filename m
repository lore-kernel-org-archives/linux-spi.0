Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A449552C
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020489; cv=none; b=sPtRAnm0UtiADCr8CqxhxdzctvQfg1EiI/sa9mtSQ33go089OMHrPM4EyTQVOhQvj9eogdAHVVvLekCaYNbrG8GheGp3QfcbEtR7zqO0TrfVtJ6TSude1fy13zBNhWtIyQFjOBVszgRb3ya9TaJ1fP7uZYXPe6tg/pbOElGz6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020489; c=relaxed/simple;
	bh=KhTvHbRmKUEXS+WXMzh2xQpT20B+xE8lLutqnW0K87g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUIVlO+lnS0Q7b0aw1GXYaWgxlR1QnKPRvYMH3kSAIKkv8OGgI9cU773wOI7x65eneKSD1b6IwEdt5Ab/58igHBSRwbklQNK1/PzrRQmtJTB5CD9PdaFuoqH1mo0P+dNEaRKXIt+C4SEa4JLP4FqI2ZSa9Hkki6NBiM/zU+ClrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5s+HQZe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5s+HQZe"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4905529b933so62119385e9.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781020486; x=1781625286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtLhNP/JYbWvZK0JJLLTL9lcnhVPXd/ZGsnix6syTLk=;
        b=s5s+HQZeJNYJ687v9i1h7WP+QpnxYcZzyo4qjoVquvdAwh9ETVm2RvKZi8SIAy7QI2
         hDby4t/p33Mb+nOGO8IhRf8DwJdZ2Hki30/EKU8Dzw3JsXW9o0KQuTdX5HhCKvY/vFXA
         9LYcZUL4kCkbzl+ysZhETozrJZfi7ZZUY8+m9SI9QADX1b7YFMBuYXxesOR8kWcWM5ym
         swB7oy7RU/IUZlv3IscJ9YmpIokyodVHnXjffv7YpE1Eg/pAMNlChNTJ3crAy7e9rHwx
         75aXEJu9WyrkwWDlIM6KgUZpiXIyb6EZcDs2+M/R181v4vzJOj2ODk0y9eeuUPYK/rGU
         IFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781020486; x=1781625286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtLhNP/JYbWvZK0JJLLTL9lcnhVPXd/ZGsnix6syTLk=;
        b=BhixMrhJeJvORAP8ccWSx5u4roQoad8kTcfzTryk98FV0HkWrwoXXjmUNvV5ynyj53
         r5k5tKVox4z/+Q6Y34+4VfXfSf8x0z87EVkMY7iizWUmazA5pBsvXvs1c8LtcwCpf3Vr
         CJqPeX4dw3/Obxnz77Q2WqjV/1OAFhyRp1t3wlbLSmDVfBADYii2uVQPSSWoTANG2h0W
         ta7ItH3kWpjIPN0ZAbwr2CK7V4YFEIHvj7LVC5MCfYanjZ39IoN47j06sWA4TISm/UaI
         gyXX3CYutq22O0lLtureuRUUPPCsmGWjYOwu2QkrFs18jhAEIFlWgwxmMo2logtdJ361
         9EHw==
X-Forwarded-Encrypted: i=1; AFNElJ+EGNU5df31hyRdcKqbzuP9S9SIOC50cKAhvl/ECf1ARY2Ln4lgd2nzGurfvtMrwmVYuksSc1fRvVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRLIQcgNgCcido5jRDhi6Y8Ytk6uwYTh90WCmob3lH4HcMToa
	yaFZmXks7jFwBKs8yv4jWy7gp7oQ2nF8jOsbLrhcC0orvvDoBJxWt5wb
X-Gm-Gg: Acq92OEmsgN+QT5e5NWQPiATw4W6f19qUlLnMcnqeFnUtjzWJPwxMO0Zcv4qvMFYoua
	pc6u8SIUREtO9yUTs1lXiH2eiKrX8b5wYIuTTn2BLbo2v1HdAtpgyKvJqNd1d5j5oOvrtv5ZHcJ
	lBoWGsga0K2p5cWRgcCFmhST/w4jdt5c9UDBBioFT/bJph3pL0M/cfafdGY0yHEZ7vbORxFJOgm
	//snHpLIabK9x8+nbP+jj8rOV4EmAq5aZy6aGSP7R/QLLjbZs9c8Py+yg03fDIlcgqFy3Cyd+UO
	vtwkSv8fSw2uwokmJ+T7+U/hB0zk2zTo3QN5hKtsOBooxXFKeRS5JDcJOVdHGqCjABLsDg4n4VF
	GhbpXO/5w7fcqFx2DPOzJmyLUPnv5RkrU1Q1BjPIgvD9jJfEIwzWlcKSU2JH/kn6O2+0sROWMOM
	Qihg8jvYhx9ZRL23dPvWwU4fDGKheL0EBjflYUXLtXh/mF
X-Received: by 2002:a05:600c:5248:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-490c25604demr339249455e9.1.1781020486137;
        Tue, 09 Jun 2026 08:54:46 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm545506645e9.11.2026.06.09.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:54:45 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Nuvoton NPCM FIU DTS fixes and binding conversion
Date: Tue,  9 Jun 2026 18:54:35 +0300
Message-Id: <20260609155437.3285042-1-tmaimon77@gmail.com>
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
nodes and removes redundant clock-names from those single-clock
controllers.

Patch 2 renames the schema to nuvoton,npcm750-fiu.yaml, explains why the
direct-mapped flash window is optional, keeps the requested example
ordering, and simplifies reg/reg-names to the ordered minItems form.

Changes since version 2:
 - Drop redundant FIU clock-names from the NPCM7xx DTSI together with the
   bogus reg-names cleanup.
 - Rename the schema to nuvoton,npcm750-fiu.yaml and keep reg/reg-names
   immediately after compatible in the example.
 - Explain why the direct-mapped flash window is optional and model
   reg/reg-names as ordered minItems arrays.
 - Drop clock-names from the schema to match the driver and updated DTS.=0D

Changes since version 1:=0D
 - Drop interrupts property.=0D
 - Drop unused label.=0D
 - Keep reg as the second property, followed by reg-names.=0D

Tomer Maimon (2):
  arm: dts: nuvoton: npcm7xx: Drop bogus FIU reg-names and clock-names
  spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema

--=20
2.34.1
