Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885C31E82A
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989316; cv=none; b=SmBQ97CclAfVKISapyRyaKZxKVLtHqgC7G8C2BmToTDcVdSF60guhVuFOuT6awP1tEDvLmkwcp0T3swuMSqgYfW9+QcT9jgOMgObKdrgHeihocT2hKDPQH5bmz33dMJAGtN5cLSoVxkF3P44GrzCVNJk5BywblVehKCh0YQ4n28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989316; c=relaxed/simple;
	bh=36iZnvTc923EPRXPcsIAXwyaRN49ElQsHpAHmsLxlBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2Z3YmJ4WhgAsxzgaBSOJryBbczkIjv6mmx1S9Ns9mTFxG+ebhWGMKXViRBC7FaUnz+HnYXbqUjiFk1MGy6A8EhU04vWwvcF+G4GfPcdSBzg4S/Gaxqq5oVutbOLomdfyAhA4qxWvvgxu1f2xOzen7eZJ/RsGekGFMaNl2RfbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=husGj8Dy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="husGj8Dy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so55766405e9.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780989313; x=1781594113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQ9qZd54/Lmmr54V4cXUb7WR3Uefj23Po4HWaeBJsic=;
        b=husGj8Dy5d3rtU/oK0DzSRz/cjjHvjDFxIVLU9IbY6+QNCel/XZJMnnCU+Owmg2upX
         WmOCFyuwQfAQaChugLSa23DCsDEFHdH24vA/js0nSBg0mqmOz7qHpzEjX7uD972c3xV3
         tBHQU7S84zmLuwQsrrGTZiCivCHAHhT1w1jxUXMCSzfJ/X2M7uaf+vrmMzQto8Ni1BEH
         0un/AB/jSjnAAQprwt8wubEHwrGX2lSiSho+yhhBBGkbXfQB+vtITOyiqEU4dIoBNm7H
         ZKQO6LonGrBwDCczurjgk9fQ3DsDUupoGPyS2t8NDLd6HEyVoaM25f+5EeRuWZKLPYtA
         zkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989313; x=1781594113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ9qZd54/Lmmr54V4cXUb7WR3Uefj23Po4HWaeBJsic=;
        b=LmRniVVn/PSFjA37ICx8rVdGl3JVRwsAd7hKubZ4mCtm94+ywBzEmHlrlWY5po6b32
         HhXHXZBAQoZycryRfxihiLErL5c48l32DuiC9EfXRj+iHgAeTpxttnsAOVl6+rPMiFQe
         4I9bh11PAacwgPIw0vDKiaXGem07s4CRppRbMOLeYaFvks6FAr3P2wacsKc8+j9bLwsM
         crq/3xSEWAD7FQLQ4q7cRzZxXjrUoFg5p894HewFh+U7W8SkoyCIcUzXAkbr10yIGJAw
         ayKnq7NCcXyNlwEY++QNLaqiPJN6l0GWvcqlSKLcZpAYxMQimDoYQ4hQKNEBm8V/IDXS
         ZBrg==
X-Forwarded-Encrypted: i=1; AFNElJ+k592JIXrZmzJBxoSR+BDde2nUmOj5d7CgNffDdoaJfaEe18WXfT7RYFj19wybmBwuxrOnchqwFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzK1PP0AhZZsF2nVmW0RsEVxdNbQVfdKXtPmPrkW4lNHDclf3O
	tO8nXhq6dNsNRCM8ZnElmvJawv2LrVhdGRbwMe2F2Vg5K8xdyvTJ5wDi
X-Gm-Gg: Acq92OE9rfOBBd3rretRzPSUcqpFiIsM21GW4rC07Qwb5iwViYqUrPVeRJOPHW3ehTp
	Hw+fyamcAd+5OcKu1ZP8Fm3APdMYhPubtTOE4XBPJdVmGaNYZ1LS71CjD19cNB0ditFDIHo9IYE
	hL/+k6t0NiRAJ8Kfw+TRFCF8ok1H4zDYQrluUrFyh6w0w/toLaoPcCrSxZhR41miZTkYNPy/t9A
	a6Niamqvv0CqhMW/Jgil22/ZPznHxfRapVTic53S92h/zJn8SrKYwzbjaM6s4DstG0DfiJMUHoA
	MZFc++LS3thMI/CcZStspDYoZraGbYZlUKvtjQVv+nO0w6rPXy12/JFDn6MKgvO2Hu/v/Wc6PDH
	YFc3ISIWIJbJ3GKjaKG3sJV6mJtnRbwRVjJVd4yKme7iIMOutsWiBUXRPwhz2DoTRhG6Z/v0r5W
	3w9vOSn4u/v6kEu7vXyJU8Zm7SvPp5wAWknr/4Ep6/JKN7
X-Received: by 2002:a05:600c:34cb:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490c25afa03mr299042535e9.7.1780989312636;
        Tue, 09 Jun 2026 00:15:12 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm57909918f8f.12.2026.06.09.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:15:10 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: andrew@codeconstruct.com.au,
	broonie@kernel.org
Cc: openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Subject: [PATCH v1] spi: npcm-fiu: support dual and quad UMA writes
Date: Tue,  9 Jun 2026 10:14:58 +0300
Message-Id: <20260609071458.2692482-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The manual page-program path used the UMA command byte for the
first byte of each continuation chunk. That forced command-lane
semantics onto chunked writes and blocked dual/quad payload
writes.

Switch continuation chunks to data-only UMA transactions so WDBPCK
controls the payload bus width.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-fiu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 6617751009c3..ebe3387d11f5 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -393,7 +393,7 @@ static int npcm_fiu_uma_write(struct spi_mem *mem,
 {
 	struct npcm_fiu_spi *fiu =
 		spi_controller_get_devdata(mem->spi->controller);
-	u32 uma_cfg = BIT(10);
+	u32 uma_cfg = cmd ? BIT(10) : 0;
 	u32 data_reg[4] = {0};
 	u32 val;
 	u32 i;
@@ -403,8 +403,11 @@ static int npcm_fiu_uma_write(struct spi_mem *mem,
 			   (spi_get_chipselect(mem->spi, 0) <<
 			    NPCM_FIU_UMA_CTS_DEV_NUM_SHIFT));
 
-	regmap_update_bits(fiu->regmap, NPCM_FIU_UMA_CMD,
-			   NPCM_FIU_UMA_CMD_CMD, cmd);
+	if (cmd)
+		regmap_update_bits(fiu->regmap, NPCM_FIU_UMA_CMD,
+				   NPCM_FIU_UMA_CMD_CMD, cmd);
+	else
+		uma_cfg |= ilog2(op->data.buswidth) << NPCM_FIU_UMA_CFG_WDBPCK_SHIFT;
 
 	if (data_size) {
 		memcpy(data_reg, data, data_size);
@@ -464,8 +467,7 @@ static int npcm_fiu_manualwrite(struct spi_mem *mem,
 
 	/* Starting the data writing loop in multiples of 8 */
 	for (idx = 0; idx < num_data_chunks; ++idx) {
-		ret = npcm_fiu_uma_write(mem, op, data[0], false,
-					 &data[1], CHUNK_SIZE - 1);
+		ret = npcm_fiu_uma_write(mem, op, 0, false, &data[0], CHUNK_SIZE);
 		if (ret)
 			return ret;
 
@@ -474,8 +476,7 @@ static int npcm_fiu_manualwrite(struct spi_mem *mem,
 
 	/* Handling chunk remains */
 	if (remain_data > 0) {
-		ret = npcm_fiu_uma_write(mem, op, data[0], false,
-					 &data[1], remain_data - 1);
+		ret = npcm_fiu_uma_write(mem, op, 0, false, &data[0], remain_data);
 		if (ret)
 			return ret;
 	}
-- 
2.34.1

