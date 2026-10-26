Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013702;
	b=ytkBC4v8TtH/RvtO1r4O5jtgJmf75G2Pac+1aLSyagS0AO1Oxu+1Qs5TNzeSMBtC+p0J
	 CGVQxmzzRnMPh8SKMkPlviWmjWYLG/fZ6NF0tMC0rU+dVfxz2ggJ//3DIVm7F/hTNa6aE
	 u1MD5Ayeh3SeEVw+S1cJ4qvCHNweYmSfCJ9N3z9TGz2UuknvEmI2v/wDOAEQ902xnvsGH
	 wrh00tg+/Er7/JWoZPwQZVtYO29jnA67XWp1FWVWUADetKKKMiL+gkPi5Q9o2znkfKHzp
	 bQsmBZKlO5QnPM8dJDjEOXQYULGpSAKNRCx789XraSZyykZrN46mTtc+ae2JN86JegQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kO9MK7u1msKG5wq468IIgbTQC4+Wnaov9SdCK8DNy5w=;
	b=isq66ziFebBPNOSKBD4hO9TKtGG4OJqGTwFx1ZoJn3WkIiFSdbgt32znr7Rv9K9RJ0Wl
	 3QPo3Nqb8KGIYxdjOG5x+k2TXoGXILX8BM+Ywe2AJuc0yvthWvYcc7CX98qne4PhFvCkh
	 KZdTTgrDlPMzUIiMA/FKLmNWBb2TCEsd2JBDZ2QL0MxezDjEcKZVEQR47jRBHFqTmo1xd
	 0twhBW+x2WOuV+WjJZQzwQ5KUxpT36Elz6Wgd+WztVudcS+toW3gkvtIGgF7+ZvOWcJnc
	 9bWZoCNfhei3aF+Nsknli0DHl0lwrc171lSMBmbUE9qteMMMlkyEQPbDpENR/rWF3IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="jI/MurgY";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE1606A31D
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BBE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jI/MurgY
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so33148365e9.3
        for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013701; x=1793618501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kO9MK7u1msKG5wq468IIgbTQC4+Wnaov9SdCK8DNy5w=;
        b=jI/MurgYS34/7IbhIoD66d68h9Rkmmys5PeLBKaJbTr8d3dkfgPBbuyleYuqGQrxbh
         oym/UNVFDruB3GMKo1EXkawueBEwblYnG/Vx3Irq7farDqVikvVZtaHHzeIZkDfy7miE
         fSLM1+/yG5RaD/Obt+Cy21hc4b3S3lPqQc0Grukob98e4/Z6LkB8lHZgVbRilOmGXf5A
         +ZZTwcXuXLTgV3FHL3M98RYS2dWZZOFHhkynQC8+Knxd8F7X193ArhG4IwWcIoqfPXI8
         16mXCNaiSpD0nbHVkwvY8H1gt+7K0P71tCCbk9issRIBmZM2XQrV5gcyyifTW2nnF6Gs
         7/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013701; x=1793618501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kO9MK7u1msKG5wq468IIgbTQC4+Wnaov9SdCK8DNy5w=;
        b=RsTEa7T6DLphHsrJmgqGbpGhYmMB7hu/TERYF9G4b/INdiiwPum4JlcNLGL/DGZekA
         r9Ebqr0X3TjNFjPbfQ2aRK1aY5gCQDeYed3SV2JKtljZMieuhEKO/BACzVGB8Vd470s5
         Oj2iasQ3Vjeq9zNN97ITR9rmF7y8tiA1sE02uMCs0fhUnE9I1hm0aKoKxt70TsB616oH
         VCUu5oLBm5A5XpvHOD7tCZaZRN023bxHrT3mhFVzXyMBXo8WVEa3/k0BlLLNstuoeGvH
         an53molq7GnHcNMb/uvkfb6arGbGjxxXNFAIeC4v0/Rf4vCxB8caylr3UzD3Fjf8+WSw
         IoDw==
X-Gm-Message-State: AFq9FYJlAyJ2l+X0JmalVe3+zx1ii1MH1aPrSIbOLwik2OBagjaGvMqc
	AzHgWorT8RLXQCdEEfd2VIukI43pcRYtyKAc0yt27oWH4EhjMuSwsx8E
X-Gm-Gg: AYBFou3yeGLyPZ7UUavuUA8E8oRf/9xBWLJ5AB8UVpStls0tm1kcnU89nJfYItcy4UF
	31FHf+Carl06qcDybjQ2uyCjHNDARn5GOyuQDdw/1zS80mP0vOGrCDu24uD/iykXhL7YxtGANc5
	qBJAO/v/EfQOIdOGfxbqKtUyt1nPmXdvxEb25vIUUpuwWTDGNoF3+oumllau9+pKTVa2TUBDhbj
	BL4gQgheD9G8rKGOfoTJC2asLDsDPGwKG/i1d/Dupu8x0ijElE6vN8rn6U2QPT0Q2XlJwTh7/p2
	M9cNug+EE38d9dEwuyFSL9FOnBMY1Ya7mOKZMBrVRxULzpibPhR01iwbl8MexoWhN47hYTfqYEG
	xE/xktAiJ6csAgieBtywd8DTdqcV6M9/xALU96EVgqUEP1UeUmq16NWgdwWoYG09BWuX08YU+m5
	x8JzVaGqwxH8Hr9EXB5vCtuC+gNX9fButMrtpWpyTciWEQ4JoLEZoTDLgRXdw44zQDkZoSr1gQc
	qBOXvGPml68w4h1lHpvavDi8SScmxydd8aCqw9JZO8gwj0AXvEKTinyLzeQLu5ZHeeszGopBVYv
	B99sA8GWSZYs9s/LM+wIGcszrM1KPIDkPXYWnDEJjRHBCOUiiXiviK++IjL5Hj4OTySxtdw=
X-Received: by 2002:a05:600c:870f:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4a35ac9d1cdmr111940265e9.17.1793013700496;
        Mon, 26 Oct 2026 04:21:40 -0700 (PDT)
Received: from fedora ([185.252.220.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm16557911f8f.27.2026.10.26.04.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:21:39 -0700 (PDT)
From: Ninad Naik <ninadnaik07@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ninad Naik <ninadnaik07@gmail.com>
Subject: [PATCH v2] spi: mtk-snfi: use min() in mtk_snand_read_page_cache()
Date: Mon, 26 Oct 2026 16:50:33 +0530
Message-ID: <20261026112033.36310-1-ninadnaik07@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Replace the ternary case with min() to pick the smaller of cap_len and
req_left.
No functional change intended. Compile tested only.
Found using Coccinelle.

Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
---
Changes in v2:
- Join the memcpy() arguments onto one line as min() is shorter.

 drivers/spi/spi-mtk-snfi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 6e96e50fedad..7eb7b40db11d 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1016,8 +1016,7 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
 
 			if (req_left)
 				memcpy(op->data.buf.in + snf->nfi_cfg.page_size,
-				       buf_fdm,
-				       cap_len < req_left ? cap_len : req_left);
+				       buf_fdm, min(cap_len, req_left));
 		} else if (rd_offset < snf->buf_len) {
 			u32 cap_len = snf->buf_len - rd_offset;
 
-- 
2.56.0

