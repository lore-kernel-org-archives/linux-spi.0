Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724088;
	b=vLxmQ879REZFdNUQ3NYHEkTXfuWGivvq2RsRW8xzh2Bz2gl6H6D/QoQ2sxFS6J62PJ1c
	 XvCXdLN/RcBLNuiwRa1PJObE+fnWbA2xqbhmP7xPgA2cQdCoDGh75mNS1+ewiyMD0D0sg
	 URtk+OJ12km69ML55X4g32RB+6TbPW6rWQiKeQMGremr0v4wQO2i0Vpr6ArjNkagoHFc+
	 NJ56ucXL+Cn7RajlIVrK8TwxnvfAaQUlDSsz6ZjdpstFCk0oOletZC7Ga+aR8bTwPrCtr
	 fB84D4XFMbCh0OLzY5DRwONA1ZrEE6N4/hCY66DJgSAp0T8akkh1fFNP2tYqhXE5nCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724088;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=SLNTpCyghAb4B3Y0403I/XoUUpQ3tuWwpHZKcK1fslo=;
	b=ZebCCm4CmVbNC3nuw5+lnlWc3FP3w2/ACFrefOuVT+3HGYC4DDSQU6AsqVBT3M4vE0px
	 pOOM7hE3sbugPil+DsV/VeXvpQLpgW02yy8nooIKSzH+l66MCUNrqDfZ31WBIQllPTgVR
	 +jNoY0MSUakp/LwToouMhWBfNvQsNap9uJItKkOqBrMW9jZtrQyOG8UPZP+ZDPQ4P1Bz/
	 qLZkIuRHBW6xhOqxRArnj0c6Qqv22zT+y8q5K27bQaz6X9TWWLTRd6UlsQxlZg4DlJ1Fl
	 b6PY9m/5STdHUGTqO/lM6BUFjn7B+r3ggezhDJTnmYxsUT3rVfePnMvgLusnlnoHy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Tnvlmjae;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62864606A31C;
	Thu, 26 Nov 2026 20:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62864606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Tnvlmjae
Received: from abreu.speedport.ip (p5dc555c3.dip0.t-ipconnect.de [93.197.85.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C21234C1A256EC;
	Thu, 26 Nov 2026 21:13:51 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Hans de Goede <hansg@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: ljca: Do not wait for an ack after every write chunk
Date: Thu, 26 Nov 2026 21:13:42 +0100
Message-ID: <20261126201346.21258-1-pmenzel@molgen.mpg.de>
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
	t=1795724032; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=SLNTpCyghAb4B3Y0403I/XoUUpQ3tuWwpHZKcK1fslo=; 
	b=TnvlmjaexhSijd+MYGehYH3AmtEALH5sE/WoaM33bWnYElAOMSZHXJJN6rVPWMeXyY9kY48Qju5a
	mffTuZTmYY2qu/e9Gi1SzmA0uwHk5tRBbrojCsCZfg58KJnx4EdjxKRNHOXMuRb8Q90580D6Zbz04j
	UYaqHFT6HUhkzviWSEPUlvKWgMPgsVatFta0B6rSU38nyIwpeJ6mpL0zaLBK72mK+AmUK58lMg3alx
	NINuCYGoK/Uw+h0vpvU9qg7iW4wLbylIoCCs/d/A0IgzC9FG/m1X7DiPnjpm1zpcHCSAJ3DWJ/xluk
	rJ3WHgofBF51LkwFcnUkAvQyrZw4ELag==

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

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    v1: https://lore.kernel.org/all/20261125134941.309622-1-pmenzel@molgen.mpg.de/

    v1 → v2: Add SoB

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

