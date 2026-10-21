Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594916;
	b=nir/b9XismOmullt51VA3LfLW5fNzHhZdcI22Ugsk4BxYcOY6Dd4BzBpS/7cDIpUoqOB
	 o3s7wPbxarx+DQgkxJnQc4bmIIYeTvqErard2fmGNsv/PfUOlY1iT11HayXlxv8cqSRUH
	 Z6rTK2uoq8KEGmSUfQZcGlg5mUIJv43D3NnolsEKXoUPNKd7rtCghJa+oBc3LdV+zu8hC
	 fEkwIcqgPXA3m4o2pHf0MLkycde5YDyNGe8oqq+dU0cJdxu6Lb20xV4H4MO//KiKq1iYd
	 gEt0Xa2yKalK5RVB04j4HAqJeKZJ11h9gvoeKVRyxkcqznYI9vushvzmb1ZSDdn6UBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594916;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:Message-Id:
	 X-Coremail-Antispam:Date:X-CM-SenderInfo;
	bh=p9nrjK4e5tANDN+95PQbLKMF9LMQF0ZHU5hRCppkci0=;
	b=xmlUFp+jnlGbY/DKj6uicc1W2ztVth3W94BAS/w/ljVBgYYbJ2IiJOuvVuv8SR6o7YPm
	 J0u+N6SXawmZy88Rwqh00DNs8zmF0i36blQN2/UBVrHErHxS6OEJO6AY30YBfPqlzsih8
	 1Dh4nIYN2GQMsO4qEHWbW9BRSJULI/9ZkPKhj0iAlT8yBG8mvn2B7XY5TCmZMNkiRljmy
	 RFXFjZeDJcqUokActA4eqQt4PdiOgZcGGqT9844wdTG2R++t6vkNJkuHNlRePdv7YqCPV
	 +yqsReYoH6UF0o9AhMd1X1Ils8QGnpbM0KBpznMRXHt157+A4PbHjUiNoGEK/IpiQUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQ7CUTOh;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54620606A319;
	Wed, 21 Oct 2026 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54620606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IQ7CUTOh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:MIME-Version:Content-Type:
	Message-Id:Date; bh=p9nrjK4e5tANDN+95PQbLKMF9LMQF0ZHU5hRCppkci0=;
	b=IQ7CUTOhRdfJUsIi1LrJyRnNqRXeoukexknFzz+F3dCTMi8VljkdeT7f9EpIK4
	sgZyhwy02zQ91HR89VW5aobtD24dqu6W1ZiTMKvqMBsTsZ3xlyhBI+DXVSclmvZz
	vA+sY/p37Z6ncDtFXXoCVIspX5Hch7fFhXvNLfy/5vrjM=
Received: from zcf1810-ThinkPad-E420 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3P03Y09hqJX7vBA--.22114S2;
	Wed, 21 Oct 2026 23:01:44 +0800 (CST)
From: Chunfa Zhang <zcf1810@163.com>
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
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgD3P03Y09hqJX7vBA--.22114S2
Message-Id:<6AD8D3D8.0ADCD5.20255@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw43ury8KF4UWF4UXF1rtFb_yoW5Cw4rpF
	WfKFWYvr43Gr1xAr4fAa1DuFySyas3ur4jg34fK3sYvr4UJ3sFqFyUW3yagFyrtFs7ur4Y
	kw4qg3sYka1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdPEhUUUUU=
Date: Wed, 21 Oct 2026 23:01:45 +0800 (CST)
X-CM-SenderInfo: p2fiimirq6il2tof0z/xtbC4Rj7m2rY09hKuAAA3S

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

Signed-off-by: Chunfa Zhang <zcf1810@163.com>
---
Validated against the fill loop with 20000 random combinations of
(len, offset_in_page, PAGE_SIZE in {4K,16K,64K}, max_seg_size): no
zero-length entries are produced and the segment lengths always sum to
len.  Not boot-tested on hardware; the reporter hits the BUG on a 6.1.158
arm64 board with 64K pages.

Resend with an ASCII-only sign-off; the patch is unchanged.

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

