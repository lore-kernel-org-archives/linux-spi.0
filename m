Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346152;
	b=psqfHd3WnyJXNz/Ue0Qre2sOC4Bz3ZCCXb7E6CQFtDGrlXY/RDxdzyNp8RrUSnOCNDg/
	 oY6KUwovz3y+M8+8K1WWLVyvxe4KHdM20LofZKCAzTMc1au8EajjTEN9LlDMe4oAfpFmV
	 +MKPSgUKO/vMmgYHSG6cfp9ksqBLdmR3ov6CevB963lFKCwR7sIScESiiD7lqK489gh5l
	 vInviwXSu1eiISxi6imVEP0HSgNdPJlP9D7xZ6Q3br/Ei03FgfHgfsb8eZ03CYEB2mu30
	 /5aH7UGb8Ok77jM7KnMlNMs8EWxotxKfODjsw0mE7VmE7D512NVlbMZM/zTVkleDcnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346152;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=fUNT6Z1TW9+Yykt2ppxCjIsQei9YUsYiPRRoByOMs8k=;
	b=ARmJvqkuXXIk7QsMX6MVzRhARI5rjZaCVDQamFYgQCY6MQhb+1IB2r7uQ2A3OK6jVeww
	 sEAmIFgALUwcqv9lZBpz2aaxErenXzwHrSl8ehXfvVl/XkXEYx5ksQRohYd58cIjOE2KW
	 yK9Rg/DWGnjU5TSqnftL3d30tQ9uRiuaaItc+ok4XvXe4zhMCJkJoCmpbYZOZQULPJ7eS
	 MqhOhNj7NBwIhhd/L3KLVnIcz6vDCqTw93lHgCx578Lx1GeyH5uf16ODM8KzUmCdqCdTC
	 6Yawe7KpVxDmpxkxCs2HODKbkVh1DMIdhkmP/1xZT4Lpw0fqcWx+kbNsOSOCHNbtTog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ONJCViQE;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F233606A31D;
	Fri, 30 Oct 2026 07:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F233606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ONJCViQE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=fUNT6Z1TW9+Yykt2ppxCjIsQei9YUsYiPRRoByOMs8k=;
	b=ONJCViQEP+ktxKZBEokm3N/f0jcpWkJWHxJoxnfhBfHceBFmatFSv1QM1V2k3g
	gZjbJgPTTqqvNZPl3lvlgIRSmRAexeSC8xloZQkT04U3+kHtcBGAofEQ0bAsvun6
	rRMzeDSSMiszSLzk+FP35BZWgKLm+Jr3Z0dTfhkw+g0mI=
From: Chunfa Zhang <zcf1810@163.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject:
 [PATCH v2] spi: fix zero-length scatterlist entries for vmalloc buffers
Date: Fri, 30 Oct 2026 15:42:19 +0800
Message-ID: <179334613930.227576.16591083055909656623@163.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgCHjnpbSuRqxLCLCg--.37347S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw43ury8KF4UWF4UXF1rtFb_yoW5uF1DpF
	WfKFWjvrsxGFyxAr4xAa1DZFyfAas3XrWjg34rK3sY9w45J3sFqFyjg3yagFy5JFs7ur4Y
	kwsFgws5Ca1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: p2fiimirq6il2tof0z/xtbC-Rx9HWrkSlyEPQAA3g

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

Fix the entry count to match the way the loop consumes the buffer.

Signed-off-by: Chunfa Zhang <zcf1810@163.com>
---
Changes in v2:
- Drop the zero-length early return.  A zero-length transfer has to fail
  with -EINVAL from sg_alloc_table() so that spi_map_buf_attrs() returns
  an error to the caller; returning 0 there would report a successful
  mapping that does not exist and would break the KUnit error-path
  coverage that relies on the zero length transfer failing.

The sg table sizing change is unchanged from v1.  It was validated against
the fill loop with 20000 random combinations of (len, offset_in_page,
PAGE_SIZE in {4K,16K,64K}, max_seg_size): no zero-length entries are
produced and the segment lengths always sum to len.  Not boot-tested on
hardware; the reporter hits the BUG on a 6.1.158 arm64 board with 64K
pages.

 drivers/spi/spi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda00..1b87fb2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1349,8 +1349,24 @@ static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
 	int i, ret;
 
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
-- 
2.25.1

