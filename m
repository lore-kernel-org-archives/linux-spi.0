Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D03D47A0
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154268; cv=none; b=ttkUGywt/U1AdK1aIJpzjzVoQ0FPisC1hfXjHBXdFCN98oqVkkaqm1UrkjoQ8LMJk5eT2J+LCgd5pSVEysZMmleJ+3w54IQnUXGncxEmzjtRzpV80AViUxPbvEc0vBQ7censHR8jTIhxZIQWooWrC6OkYZOx2hrTXp0yA7z1gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154268; c=relaxed/simple;
	bh=nu/mr1w3NatjahLjEdAIObZx3UpsrcSmvOjxdVnI/Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Nlu9bJycEjxPmhatOF4sSdJ2JYRp1bDBx8OogoPKzXLgihWsux2YX42hJ7syB31siEKbJ7qdmneYa9DyAtO/+u8JEHIVhdDFFanUU/8tnaSPB/PrBuvNZ7MR3etsR2mY9Bi/HIP3PbIWXdwi89pGxbCZlk0xOdEE/MG+fX/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY0QXd53; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY0QXd53"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4720d22c94aso2883952f8f.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154264; x=1784759064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7wn2+V5yX90KO7wkjapPWJb+BCChpkYDpDV4HrAyTc=;
        b=iY0QXd53VTRhLW9GNlduk25UMkZUEl+uNE/gP4hheTnmwzIfyPjaGuwO4BX1M2zxoc
         5hYiVm+zzlo+uccpXP9wFMGS1Aw3A/58G4XEyDbvJ3piPRa2wJdbX94q01adFnbtk1mW
         1icWbY2GkO+ybnEY8vY472nbTkgEZX2KeNAwu+qIbItv9+VyiU3yRsKjnCT7fKKB09t4
         pboZCOCJ3JCA4jAOjW8BB8V3jhsiIwMTJR/MGErEIiOS2ieCmo1xu4qGxnPmNy/Rmlzx
         +aCLwrIzxjDfe6Ejh/i0onoX1Ezt2Q/XDY6CZ7MlOLn5CStPQQOfbuUM8+MPHvJZeF5i
         fq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154264; x=1784759064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7wn2+V5yX90KO7wkjapPWJb+BCChpkYDpDV4HrAyTc=;
        b=M2jZ+OZFcmeIG7IHnQO/BzG8LTynqRO8E4sf2f33InUXheC+nLU+1QOnssTlj0BNoe
         zBuSihjs18ueO88Uoq1xYW/mfxYZg2iZDCtmrrgnb/Y7mgfYJdDDYojER1067bxt4JQs
         DKAOZfvUVAtQHi1/UqAIuxRU/1xQxPRNXcYr4PXen4VyVVOfKM2u8eNJ/h8LzWz0eEQ+
         bWIvlVs9TqPSWvrPxXDkQry1lXFAoDWxIYMWSEe4R/YzobHzIksMHedm0xporVWYjRXn
         q8o67NrP/wS2xuxBSivaH2Yq+ttGd3Ovs+qlrHeRIsY4zMibMfF+w75Rrp5AzZ9aaKpi
         AB2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr0XA0l+lsPAoSwJ5OUT/ZkxWLi2jxjdEdVfy9hNg/AgVNHo57DqutliicXa77BGJGFIChqOOmgxCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bpji+gNeOrZ3MXHloteBQKJqW2s7BPq9vRziju0EdiErnldM
	TEtrGsjY2FlmfVWhTj3V0mm8WalAeS8SZzi7kE3T5+nnCtb7cbHJ8wj0/Gnb2AkS+Ak=
X-Gm-Gg: AfdE7ck8YgEZOse23XI84YVPe3PkjjiZM2JPQGU/0UFcdrKzp1vNQPbhZAGPabWnibO
	5PmfBqgGMlVbbFYEF0TgYF+Vx0asnDFTDIESZc0sktDNqXlDQ7qs4JCoF3pYKLwylnv0b4+ypor
	Xf7e0tr2YpbuV/FNbIo17D+O/4G9jKVqAmtcDNPOd7OOfnvoZx9w9dRLNgvv+KbGNEkEXD10K1L
	XrQubNULoq2QeGJE7SK4O7OcqEFlDXJAZFw8ad27WQ/1b+wBZz9P565YCv3ShLuGKxk+S8rRgy5
	559diPBsCX7U5JQii/8W5SqM54Vg+rQ2M2CQUy085xWKemkll41WJgjTIsVDP0ATXXWVqMAJmoq
	Nt91yUn3qrqJHkxvMIk3rH07FY0bTB0GeklWlyaI/6o4Cf7NVmIwjmHV3M2z6NfxQzhJ1YjmoYc
	Uqcrco/J38vqf2ZvbXVvasdqJ97aPs5EL8ZTUSPTcbzvwAcqNkUQsXXSM6T404zS5Al5P3L0VGS
	yBUXZ8q7ZAMCXlhzi3Pjxw2pno=
X-Received: by 2002:a5d:588d:0:b0:47d:f508:42a4 with SMTP id ffacd0b85a97d-47f2dcb5c6fmr22018675f8f.1.1784154264234;
        Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4/7] memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in read path
Date: Wed, 15 Jul 2026 23:24:14 +0100
Message-ID: <20260715222417.2997712-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Program the XSPI_CDTBUF0 fields used by the RPCIF_DATA_IN transfer path
through a single regmap_update_bits() call.

The existing code updates TRTYPE, DATASIZE, ADDSIZE and LATE using
multiple read-modify-write operations on the same register, even though
all field values are known before the transfer starts.

Build the register mask and value first, then perform a single register
update. This reduces register accesses and simplifies the transfer setup
without changing functionality.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index e406afc42616..c768e9c18556 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -697,30 +697,33 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *xspi)
 		while (pos < xspi->xferlen) {
 			u32 bytes_left = xspi->xferlen - pos;
 			u32 nbytes, data[2], *p = data;
-
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_TRTYPE,
-					   ~(u32)XSPI_CDTBUF_TRTYPE);
+			u32 cdtbuf0_mask, cdtbuf0_val;
 
 			/* nbytes can be up to 8 bytes */
 			nbytes = bytes_left >= max ? max : bytes_left;
 
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_DATASIZE(0xf),
-					   XSPI_CDTBUF_DATASIZE(nbytes));
+			/* clear TRTYPE */
+			cdtbuf0_mask = XSPI_CDTBUF_TRTYPE;
+			cdtbuf0_val = 0;
 
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_ADDSIZE(0x7),
-					   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
+			/* program DATASIZE */
+			cdtbuf0_mask |= XSPI_CDTBUF_DATASIZE(0xf);
+			cdtbuf0_val |= XSPI_CDTBUF_DATASIZE(nbytes);
+
+			/* program ADDSIZE */
+			cdtbuf0_mask |= XSPI_CDTBUF_ADDSIZE(0x7);
+			cdtbuf0_val |= XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes);
+
+			/* program LATE */
+			cdtbuf0_mask |= XSPI_CDTBUF_LATE(0x1f);
+			cdtbuf0_val |= XSPI_CDTBUF_LATE(xspi->dummy);
+
+			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0, cdtbuf0_mask, cdtbuf0_val);
 
 			if (xspi->addr_nbytes)
 				regmap_write(xspi->regmap, XSPI_CDABUF0,
 					     xspi->smadr + pos);
 
-			regmap_update_bits(xspi->regmap, XSPI_CDTBUF0,
-					   XSPI_CDTBUF_LATE(0x1f),
-					   XSPI_CDTBUF_LATE(xspi->dummy));
-
 			regmap_update_bits(xspi->regmap, XSPI_CDCTL0,
 					   XSPI_CDCTL0_TRREQ, XSPI_CDCTL0_TRREQ);
 
-- 
2.54.0

