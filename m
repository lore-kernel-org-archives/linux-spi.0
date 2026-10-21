Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594666;
	b=ixYE0bBImTu/1ZCsqqNB3JWGLpvLNO5ndVIoOM8UY4i38wy9GA4HntQrvsiN2Ia4/H2z
	 InKpPYgpS6BPa3M7q37+1rbDtL0E1+4OAqJ83kMRYIkXI7Qm0DP9cA6V0WvhSr/wsaE/1
	 mk+QrlO3SynSnyM3h/ingv56AmYr0SggeBBr52GL5wJa6b+sSiQdCY6JsYcV4gx74C5lp
	 SO8QLwPbOkgX52XxTJ9soWnif/bfSfddZfh9lpFWLft2wTZDgHWB+ns8fTQdlct331Kxs
	 361ZFqJe2yRFKi98EVYXuHuoR/i0gFsRxf35TrF6IvdD9yp4Dci3TKcBAhm3Tzcs08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594666;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:Message-Id:
	 X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=A3JpIqT2+1EzyiYNHDD45G0KQFQW+6bD47SqsY3PDec=;
	b=h4PKsY2DbrsvcKZ3915OZk98VBv9ZnFl05IgSKiXgeLrWGa4N7R2NJy+cpw7SIZaLQnq
	 ESXnBvqGMivXXkodjUmrb1y4Lja1talVe3LcjZeoOLKBuwFOpWEdORln+2cbBy/jVFn5h
	 pHaIORAPP35VwyrBPcMD5tlUNtw3Mtmwd9RWX4qUbWItyX/FhKV3A7nRRcDEbheSyuinP
	 GFmysZUXc+rF2l8ZGMeTeKXC+9uXG+bi4g7ndtHCiA5dnJ9qFqT4f7nHV6ophlB/q/Q0F
	 2eCyQCZKLWzYDS0lv54a9WLPsXX+QQDnHk8bOwUuQDWWeplEFqR/y6uNOFxp2oscWLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="RK2cbAd/";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61B606A319;
	Wed, 21 Oct 2026 14:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A61B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RK2cbAd/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:MIME-Version:Content-Type:
	Message-Id:Date; bh=A3JpIqT2+1EzyiYNHDD45G0KQFQW+6bD47SqsY3PDec=;
	b=RK2cbAd/EBPVtMGtttUPYu/Oe3frr4qsvsTVZhONntomEs0iZCgxi98nJn9tCz
	B/WwVUloRQpd1aRc0y62RBfma7I3UraQ4MRLmO6dTC3SXSMD6lkVELbAAVWfsaJc
	AneHuUw61ggwsW1EU5YalT35njUnPOacLF3NO9wwv7x8M=
Received: from zcf1810-ThinkPad-E420 (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3H67c0thqEYrLBQ--.14072S2;
	Wed, 21 Oct 2026 22:57:34 +0800 (CST)
From: 张春发 <zcf1810@163.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fix zero-length scatterlist entries for vmalloc buffers
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H67c0thqEYrLBQ--.14072S2
Message-Id:<6AD8D2DE.056C35.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw43ury8KF4UWF4UXF1rtFb_yoW5CrWfpF
	WfKFWjvr43Gr1xAr4fAa1qvFySy3s3Wr4jg34fG3sYvr4UJ3sFqFyUW3yagryrJFs7ur4Y
	kw4qgwnYka1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UE1v3UUUUU=
Date: Wed, 21 Oct 2026 22:57:34 +0800 (CST)
X-CM-SenderInfo: p2fiimirq6il2tof0z/xtbC-h68XGrY0t4VrAAA3H

spi_map_buf_attrs() sizes the sg table with

	DIV_ROUND_UP(len + offset_in_page(buf), desc_len)

but fills the entries with

	min(desc_len, min(len, PAGE_SIZE - offset_in_page(buf)))

Those two expressions only agree when a page boundary coincides with a
chunk boundary.  On 64K pages with a controller whose max_seg_size is
smaller than PAGE_SIZE, a buffer that is not page aligned produces a
table that is one or more entries too large, and the trailing entries are
filled with length 0.

dma_map_sgtable() maps every entry up to sgt->orig_nents, so such an
entry reaches dma_direct_map_sg() -> dma_direct_map_page(size = 0).
dma_capable() computes end = addr + size - 1, i.e. addr - 1 for a zero
sized mapping, which is false for any buffer above the device DMA mask,
and swiotlb_map() then calls swiotlb_tbl_map_single(size = 0) ->
swiotlb_do_find_slots(), where

	BUG_ON(!nslots);

fires because nr_slots(0) is 0.  On 4K pages desc_len always equals
PAGE_SIZE and the page boundary absorbs the offset, which is why this has
only been observed after switching to 64K pages.

Fix the entry count to match the way the loop consumes the buffer, and skip
zero length transfers entirely.

Signed-off-by: 张春发 <zcf1810@163.com>
---
Validated against the fill loop with 20000 random combinations of
(len, offset_in_page, PAGE_SIZE in {4K,16K,64K}, max_seg_size): no
zero-length entries are produced and the segment lengths always sum to
len.  Not boot-tested on hardware; the reporter hits the BUG on a 6.1.158
arm64 board with 64K pages.

 drivers/spi/spi.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1339,9 +1339,34 @@ static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
 	size_t min;
 	int i, ret;
 
+	if (!len) {
+		/*
+		 * Zero-length transfers need no DMA mapping.  Leave an empty
+		 * table behind so spi_unmap_buf_attrs() sees orig_nents == 0.
+		 */
+		memset(sgt, 0, sizeof(*sgt));
+		return 0;
+	}
+
 	if (vmalloced_buf || kmap_buf) {
-		desc_len = min_t(unsigned long, max_seg_size, PAGE_SIZE);
-		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
+		size_t off = offset_in_page(buf);
+		size_t first = min_t(size_t, len, PAGE_SIZE - off);
+		size_t rest;
+
+		desc_len = min_t(size_t, max_seg_size, PAGE_SIZE);
+		/*
+		 * The buffer is first split at page boundaries, then every
+		 * piece is split into desc_len chunks.  Sizing the table with
+		 * DIV_ROUND_UP(len + off, desc_len) does not model that and
+		 * leaves zero-length entries whenever a page boundary does
+		 * not coincide with a chunk boundary (which trips
+		 * BUG_ON(!nslots) in swiotlb on 64K pages).
+		 */
+		sgs = DIV_ROUND_UP(first, desc_len);
+		rest = len - first;
+		sgs += (rest / PAGE_SIZE) * DIV_ROUND_UP(PAGE_SIZE, desc_len);
+		if (rest % PAGE_SIZE)
+			sgs += DIV_ROUND_UP(rest % PAGE_SIZE, desc_len);
 	} else if (virt_addr_valid(buf)) {
 		desc_len = min_t(size_t, max_seg_size, ctlr->max_dma_len);
 		sgs = DIV_ROUND_UP(len, desc_len);

