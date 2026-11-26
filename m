Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674456;
	b=l5+pAb5pFdU6vqtmT9XewjlGviE3OtYzP3YT/KWtVzu91WxsK+QYcUX2CPvjUJsF+X4R
	 /VJl9EB4Rc+VUxqg4a7h0ERdeXw93J/Z7qdDa5ekM6J0Cmf1tX0b/D13K+xDInwtBJcE6
	 TfiKKUA0Eq3YwzXyp4TzuTRvuoBAWkLAax79W49fZzcv6yXKpg9sS1qjhjKRTleIPB+Qw
	 sx5C3A/5Y/nfOJhonEHfjw2FXwnx9QV3J363/c7c/mKnIBuIxeCUkQS4ot/be3H+ov5B4
	 zIyIal8RBBSSn1KJWUKfm72BfG+kVb+SHrddYDA6HONKeK0SiMm8NJZPVJ4U2b6VtPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RsKnYZ2E8rNUTMuCEjickezj/V8M/hHJIbnY/NMWVcQ=;
	b=JEEAG05csxqIYxafXaZb6hZl09Uc6Xgwba9BNrV2jI4rPz0pMsIZp5+pP6zOkxuhRiE0
	 FifwQnj43QWZfE+fEYL4F9RjNYNNtx1dvbE/9aMgW57dKBiS/02IfbwV9AsO+99c6phT5
	 vL0roJyCAMCy/URdiza+Qo1KuGb+sz2XMpW4xwzQUN7ziHAW0+gmxkuYrwXaeIiOjuJP4
	 giB+91LQZwS1Dj0ErT/0YMLDUGDUqDQwDK06DNBD3HFwKONJ0fb4lnnc2oJc3EBZE+fY0
	 MxZFwNAhGbjutxE6W4CttiNgMckiB/E9pfhbBSv38skyyiJcT6vQwE/nEhKTaEY+4lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XOwnmCz;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD0606A31E
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 06:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XOwnmCz
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso3184276a91.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 22:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795674454; x=1796279254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsKnYZ2E8rNUTMuCEjickezj/V8M/hHJIbnY/NMWVcQ=;
        b=0XOwnmCzTDGf0x9VRmaVoGzWAWioDzfvw2VWEQkPAUNR/EJ/0ZlL+63pXnpiFWeSGl
         Q+5rFbQBZdVduicnpEUpyFwMPLn3fo72RFmD5O1ofYFicJp1GuHDj2M4XStk8hO5S1No
         Ne/mcRkiOwxEPsTwwIrFF9bRCId0EtiKb9+d/twj2c0fpNrF2MZDeog7IqeJxvd5VJLf
         C+zKKE4seyjziIS6DYVPBSLpQ8zSwn665Wx8Qn1zNHdPgGXqcK7igekTOv9nz47J4m6P
         VuyKZkPUBtiSMd0gV+Hi+/34bzN1KUtV3radSm/f3AdjY+13+Fdt6YOSZxTaZCzzU8SV
         sCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795674454; x=1796279254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RsKnYZ2E8rNUTMuCEjickezj/V8M/hHJIbnY/NMWVcQ=;
        b=OaqKRkSk7oPRUONrjBteSySG2VPD8p0AoPkJ0kZ9D/HiazDeQUAp83ImvcPE2FqJrM
         PAYxe6ERJ+5UM5wwQwGjwFMVDp/UP5Dccl8q2g75NMkLQmmon4YU9TtP280clWMNn77x
         AEnD9KUdeKFCOeKK8+X3MYqMfvzSdyBLAFBtJyo3TJpTlIk83TBFOpo6TZ2VF0EbR/T4
         reaI7CxaUmmoYbJd0BxyWx1wIkr3CaVxqZwoem9yrqrU0yyi/CapFwVev1NTw0oKwMaU
         GzV0vuOUVdB8JTi0zDrpBh3FGrWhB3b4GM40dpeAh6SSnmuSpbsnlJp8VFbarKD2DCtz
         SKqg==
X-Forwarded-Encrypted: i=1; AL+hErE7zLc3WqespTIQv2e47QxLbDuwrzPC6q3TkgHRw6cDVG4Vs8UP2Ib6OOOfMfKv9XQ/0EawN+uucFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HmtRBpeih2CDzZ/tgI0QshBvFM79rW/K8W074iR+3xb3M31Y4
	BpNr5z9r9rqKtOqd8X2gUZ0OecVi/uJkrjoIpl16Q34Df9EidNpYTMtx
X-Gm-Gg: AZFdTZcSaqy12LdI2UHsDUfK2vUWKfktetmaWWEZGtpsh18ak3jU3gkl3tMJB2QuxXD
	SSNL1yj1fKxmiNBjb3tpOz87mj6+IZmZypAVv5P1Y+dIE26p7kAkO1EZh+SXGPe4PsGWWnirrGg
	UKDY7fSZDA2EftLlk4kdboL35Dx45xI8f43kVXZbg/8voiCI0gLqGahVaaSObggqflXoQnrsu9N
	/jwXen/a8sLLSfw5DyHAoc7WmTymkd/bHSBBIqfMiJwuw9m7lO20EJvxekU6zxF0+fkwtOuKzcH
	jxFU6e3MnK1eFvIZugk8a+Yv4rc4cE4qzM0GXfEKkYK3MMlNKyfCP37RHbgMNkp883ADNKP+c15
	ESG5gaEGhYehw0NnPY5SPG/c0xOp1OWN+w1zD7Wge+aqoBe52yJn3Air1y3quv+rabqya81qExV
	YdeWk/XN3vAc7g+RranW3WVgbNnq5DRYepdt3RiFnwXnJJZfd2DmEdqvPcTQ6u+pk2CFMrEWirm
	Qp9ooD1A975RElt8czarnY7fn/q5dyWEYZeOnajI28ajRVVnLg26PL9+mu80tvork9qWOTemBfa
	v9+AaYKDcsWFfqf5zStvZ0uDipyjhX2J5itin2xlCRmrtDghuvoy98jVbEtEeUWdx6n0pBbZQMc
	rlqhCfWfjvA/m10XJgN8e
X-Received: by 2002:a17:90b:5287:b0:3ab:9c73:12e with SMTP id 98e67ed59e1d1-3b41c7c22c0mr19868266a91.6.1795674454345;
        Wed, 25 Nov 2026 22:27:34 -0800 (PST)
Received: from LDYT9Q2G2M.pvgl.sap.corp ([2a09:bac5:cad0:1caa::2db:4c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm34221015a91.10.2026.11.25.22.27.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 22:27:33 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Zhiqi Zhang <zhiqizhangg@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dln2: validate frame sizes reported by device
Date: Thu, 26 Nov 2026 14:27:28 +0800
Message-ID: <20261126062728.82734-1-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dln2_spi_get_supported_frame_sizes() builds the SPI bits_per_word_mask
directly from the frame sizes reported by the DLN2 device. The response
length is checked and the count is bounded, but an empty list and each
advertised frame size are not validated.

A zero count leaves bits_per_word_mask empty, which makes the SPI core
fall back to treating the controller as if it had no explicit mask. A
frame size of 0 makes BIT(rx->frame_sizes[i] - 1) evaluate a negative
shift count. Values greater than 32 are outside the u32
bits_per_word_mask representation used by the SPI core and can also
trigger an out-of-bounds shift.

Reject an empty frame-size list and frame sizes outside 1..32 with
-EPROTO before adding them to the mask, and use SPI_BPW_MASK() to make
the mask construction match the SPI core convention.

I found this while reviewing DLN2 capability parsing. Codex modified the
code, and I reviewed the change.

Fixes: 3d8c0d749da3 ("spi: add support for DLN-2 USB-SPI adapter")
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
Tested with ARCH=arm64 W=1 drivers/spi/spi-dln2.o and CONFIG_SPI_DLN2=m
in a Docker gcc:16 environment.

I do not have DLN2 hardware for runtime testing.

 drivers/spi/spi-dln2.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 60085ed04a..ec673c650f 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -71,6 +71,7 @@
 #define DLN2_SPI_GET_MAX_DELAY_BETWEEN_FRAMES	DLN2_SPI_CMD(0x4C)
 
 #define DLN2_SPI_MAX_XFER_SIZE			256
+#define DLN2_SPI_MAX_FRAME_SIZE			32
 #define DLN2_SPI_BUF_SIZE			(DLN2_SPI_MAX_XFER_SIZE + 16)
 #define DLN2_SPI_ATTR_LEAVE_SS_LOW		BIT(0)
 #define DLN2_TRANSFERS_WAIT_COMPLETE		1
@@ -336,12 +337,17 @@ static int dln2_spi_get_supported_frame_sizes(struct dln2_spi *dln2,
 		return ret;
 	if (rx_len < sizeof(*rx))
 		return -EPROTO;
-	if (rx->count > ARRAY_SIZE(rx->frame_sizes))
+	if (!rx->count || rx->count > ARRAY_SIZE(rx->frame_sizes))
 		return -EPROTO;
 
 	*bpw_mask = 0;
-	for (i = 0; i < rx->count; i++)
-		*bpw_mask |= BIT(rx->frame_sizes[i] - 1);
+	for (i = 0; i < rx->count; i++) {
+		if (!rx->frame_sizes[i] ||
+		    rx->frame_sizes[i] > DLN2_SPI_MAX_FRAME_SIZE)
+			return -EPROTO;
+
+		*bpw_mask |= SPI_BPW_MASK(rx->frame_sizes[i]);
+	}
 
 	dev_dbg(&dln2->pdev->dev, "bpw_mask = 0x%X\n", *bpw_mask);
 

base-commit: 7ccb044c27720d48175577080b851f047ddcfd1c
-- 
2.54.0 (Apple Git-157)

