Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614684;
	b=DdFjE20bwi5xzYvQ6rY7AwYAaUmbYHDNZfkM7QaT8TSCPrKYnXtqQ//cYA58G9TAOzJ9
	 NxCvs8JbCaWcwMMvm3ZcK9YcI+YuHunq3B140Sn9J02F9eg/0h2IHjGCBYVEhT8mUmQmO
	 FozV2UiKDKGrEYVB8ib5Gv4h7y12zegkdktuAfsV2SP7Wbu2LvWUNE/ieAu3DgLP5Tkem
	 qoAfTeKp2kBfP9YzKB4Z52gd4uEtUP8KaxSUsQzQnS6QXmKfQkUYqOC/65SAgjDonCRA4
	 xquz3XGyxtOOXlCTGQ2P3dV1GK/Lui8heZPo/zCSZS3OEE60OYVWpIx1s05hw1B9cxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614684;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=3Rq38XxkjACL0/OGLR5KBDTwPVooeMif9uBlERBExiI=;
	b=1+qopaKL+rrmRcQ74QC37lw1vONpsTwsvaErt9msafHyXJkF2mwEOSo4qqHDMyBd923I
	 0x9Xn9g+v6Dz4jpseO5wOIi+oLcHSRq+g3VwQ8e2pj5oGicXaU6Sd9tAaoanPaRAekpws
	 l/18yzznuGoR5urSc0PDZO11iophrh8JVNUHQ9VlPrk8j1K2v021eZMbNy4kDASiSY9D1
	 OttctPDISBC6eBLlSBfWvcFMcDJP3oMF8UXp3cEJMfAOE4IgGLbt5y+SnjGAJ4MzqAlBD
	 U1Faj+9reUgKKMqyKqikJyqCOjWDdEVByi7Jh4j25q3PSiP8x9bWcmIkz+g8cvwGI9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=aSILj+Kx;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E443606A31E;
	Wed, 25 Nov 2026 13:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E443606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=aSILj+Kx
Received: from abreu.harnackhaus-berlin.mpg.de (hh-wlan-01.rz-berlin.mpg.de [141.14.51.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 00B4B4C442F960;
	Wed, 25 Nov 2026 14:50:44 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: ljca: Do not wait for an ack after every write chunk
Date: Wed, 25 Nov 2026 14:49:38 +0100
Message-ID: <20261125134941.309622-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1795614645; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=3Rq38XxkjACL0/OGLR5KBDTwPVooeMif9uBlERBExiI=; 
	b=aSILj+Kxq3vsUitNkqbp6gn9PVYdP6IJaxX90u5EFyMmx2xfOIcObFC7UUJBWIteu+DQZzyvy4cF
	qFQ2BVrZYhd/v25W9fwPrXeay4VJi5AXYHzriuG8EMtTRZEpRlO6MVX03PXEOSPto0Sj8J5gqwiMdG
	uryBmebZ2UGZzA+/E0yM5TbKxayELdGOget2V2jQylQ1Zt+HGm2QoVB4RPIj7FaGRYjJwTFAXBKZiC
	038jHUoDMlnRiPrJmrVuNHP0RyJcvMg7DcKPPxBULkmL1tQ30zCWeUEbyFKXCqLXQ4cAD1swhMsoNR
	4j454Tf1cuV5XLX0rqHFpo3ll/S0EpMA==

The LJCA adapter in the Dell XPS 9315 (8086:0b63) is a USB Full Speed
device with 64-byte bulk endpoints, so ljca_spi_transfer() splits each
SPI transfer into chunks of 58 bytes, and ljca_transfer() waits for the
adapter’s ack after each of them. On the Full Speed bus, every such
round trip takes about 0.3 ms.

This is most visible when mei_vsc boots the Intel Visual Sensing
Controller (IVSC): it downloads about 1.7 MB of firmware with write-only
SPI transfers, which takes about 12 seconds. Tracing `modprobe mei_vsc`
with the function_graph tracer:

    SPI device statistics:   1730864 bytes in 3407 transfers
    ljca_send():             30085 calls, median 279 us, 11.1 s in total
      usb_bulk_msg() (OUT):  median 133 us, 4.6 s in total
      waiting for the ack:   median 146 us, 6.5 s in total

Only request an ack for the last chunk of a write, and send the others
with ljca_transfer_noack(). Bulk messages arrive in order, so the
transfer still completes only after the adapter has handled all chunks.
A write chunk then takes 112 us (median) instead of 279 us. Reads and
full-duplex transfers are unchanged, as each of their chunks returns
data.

On the Dell XPS 9315, with Debian’s 7.3.5 kernel and only spi-ljca.ko
rebuilt with this change, `modprobe mei_vsc` (mei_vsc blacklisted, so
that the IVSC is in its reset state), two boots each:

    without this change:  12.28 s, 12.08 s
    with this change:      7.56 s,  7.34 s

Both cases transfer the same 1730864 bytes in 3407 transfers, the IVSC
boots, the IPU6 finds the sensor, and libcamera captures frames.

Sending several of the 64-byte messages in one bulk transfer was slower
(8.4 to 8.6 s for 8 messages), as the adapter seems to NAK the next
packet while it still forwards the previous chunk over SPI.
---

Notes:
    The analysis (function_graph traces, the A/B boots), the patch and this
    commit message were drafted with claude-opus-5-5 (Claude Code), asked to
    speed up the IVSC firmware download, see
    Documentation/process/generated-content.rst.
    
    Only one LJCA firmware was tested, the one in the Dell XPS 9315 (BIOS
    1.26.0). It honours the missing ack request for SPI writes. If other
    LJCA firmware versions still acked such messages, the late acks would
    complete the wait for the final chunk early. Lixu, Sakari, can you
    confirm the behaviour for the other adapter firmware versions?
    
    The hardware test used the v7.3.4 spi-ljca.c, which equals the one in
    origin/master 4dce97c6c2655 and linux-next 3dd8c790a7b70, with
    the same condition; this exact commit is compile-tested (W=1) only.

 drivers/spi/spi-ljca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
index b1babd43adda1..37050d0b01bde 100644
--- a/drivers/spi/spi-ljca.c
+++ b/drivers/spi/spi-ljca.c
@@ -100,6 +100,17 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
 		memcpy(w_packet->data, w_data, len);
 	}
 
+	/*
+	 * Each acked chunk is a USB round trip of about 0.3 ms on the Full
+	 * Speed adapter. Request an ack only for the last chunk of a write;
+	 * the bulk messages arrive in order, so the transfer still ends only
+	 * after the adapter has handled all chunks.
+	 */
+	if (cmd == LJCA_SPI_WRITE && !complete)
+		return ljca_transfer_noack(ljca_spi->ljca, cmd, (u8 *)w_packet,
+					   struct_size(w_packet, data,
+						       w_packet->len));
+
 	ret = ljca_transfer(ljca_spi->ljca, cmd, (u8 *)w_packet,
 			    struct_size(w_packet, data, w_packet->len),
 			    (u8 *)r_packet, LJCA_SPI_BUF_SIZE);
-- 
2.54.0

