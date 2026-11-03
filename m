Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746547;
	b=vKprcAVYM9y9PrE/k6US6EFBEPZjH97DGM9wL57aKwyVrZmPYlRAwKgSBFy3m6foUvGz
	 M926KPfyTi+tTCRJ07gKYzEE00Qd2smkBB2VIMTrAOhCHdoOtC6l1rLaJwbR0SsNlrzmw
	 xjqCaOQkLDnPdxLL7Y3l+ddbw2ATODJXEhx0C3HDno3XVyzJq5oTC4ZN6mNgBDpNtZBqT
	 K8Qtb+TIs/ahdJLraPpgYFIayjUneBrr8JwkSe+4NXVBgyDzakGbqa6WIyiLsKKHxdW5Z
	 TaecccZSvBrQkf6lNAhB4K+UUwH1szHpk0xIGkCzWEu3jodWGNuWj6oZ1ifRhqgEv4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0V+U791qdeXkMyRa5K6Bk1uZxomIz+x2FpYUsA6nE3I=;
	b=XCpY98we4Jp/FAz0qQLDr0qTJZYNSBLcF4kEB0VJ8iXHW8a5Pge1IYlt3bfvTtcrP9re
	 qruX972Rco3IaXv5UAx95acm11Jwg+/PbHB9yUfttz+VkBy+8BWguq2sdXrSYN1IYbWSA
	 GC1iTZswY+Z1wlqyUU8SN8BKdDU+p7wmh7Bf0fQhSqSOlVOccmnLKIkYPYy3q+LTWuk3H
	 RWV4M7K5pFvua+gyV0RuOtoVAcb0adnrkf/yzdrhHqqmnYHSe1+6cbRVL200k4/3SX+gC
	 HZOH8WcqbPzef9kvZk5DWNIGzJRFPRMgwAxzoBUGn85WDY4ROt8oruCLgWikchjbW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVHDm1aH;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FC606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139FC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aVHDm1aH
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so115824b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746546; x=1794351346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0V+U791qdeXkMyRa5K6Bk1uZxomIz+x2FpYUsA6nE3I=;
        b=aVHDm1aHcOX/OLqLKddlOAS4oIhn1hyZPja5HnDfIhR0QoGGW22/TgacMqGplQr/NE
         Aj2whngV2j/48EAf1nTbMDNqf3G2cfAXa8tAualKEsVF+ySIhsKTfesxfAGF1sY8SUrQ
         wQPlZUsq2bI+TvVRUHNevPaus0OAQjN0uXI0ufAOuNFB4qzjUWJMZjfzh6jUi2UILlBh
         xEYzpkgE/6IcKGdKT/gifLTGcIWZlKiVXqEVBuDzvVuMUDDM1JqW+0O2Hah5fIbI/erq
         Cdx27XG8KwysZVyTX24rHEwxDsu5FFP4W2Uh2oKxwSeP/2riE7ThTBy7CoudN3UzKMsA
         zSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746546; x=1794351346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0V+U791qdeXkMyRa5K6Bk1uZxomIz+x2FpYUsA6nE3I=;
        b=FDKixFwspiQToJ4pnJsIpFWn5bqCtNu7uQQkIbVI+Du7l+Yxh0dO5ovQPF+wwgS+HW
         lVfAmgJSm7MEvp6FKjB30b2C6KiLXiwF+JfBgl0BJjRZJxo2MzzP4D9Uw1bPYyRRQXE9
         l7nq4MVNl8d10hVT9TeUixl9XWMnPc8QQcuq6B9/pBH6RjL5yWnHvwihUOBQg62QtnAW
         yAKG/2KI0oO+cPut9O/nTlRR9d05S1Ycs2pOjk/Md9uvKBUvzIMbT3lM3sbta0Sf6s3o
         6miQ9Fm4ZrSb3f5QqZ9KpAvfdEws9iOSONwOCMcZESQq9UImeuMEo2rg9Z+vPgqyV0ve
         2Vng==
X-Gm-Message-State: APuU4Z9LyK29+TRVFraiYZ/qfTF3pdQuLamxq23ii3Vk5/dmU93BJhR9
	V8GCV7C3SPb2ygcnvoUsVPUlYkvNkNpf7dw3fok/ngOB5cwTXNz49azA0oQfdeEiTSonRYAd
X-Gm-Gg: AYBFou1yitjqiR81nbSpOFIySB/NWtgI6Z/PeULVOFct6NU3peKO/epvDBHLhkwL69G
	pH9PYWwkBKFPNHLhsP3aGG7njHOd/cL2k1XkwIri0ocThT0IXwZvgimnT3RYQbmpeL7qv3ULKiQ
	rrpArciQO2RmdDl7S8clhAqZQTfpLARjHgnyYT2pnvymDVwzMtCV8q7Bw5vl7E+XUZXmbH61R06
	MpliDJO7fz90lcSIuJnLl6MKDwjKhjNXz4wsWypsmJker3y0x2fBu9mioeKPg6MPkiPpNQ8OtKS
	VM+FVtLZY6YoBThjyPd5jiKYlwMhzsqeUdRF3CMpjff2AtsNPpbh8l7FFZCP67bbPe2JGahfgiN
	vdPgFO1eUQc0PPW4yUmiisU5N4sYOupuV9d9v6gTWBrpDNxlrsiK1cJdkV9bHX0JRSfkf4V3Wsi
	lJaHREGQhxBCe9GfHgCa/Ay+iqCdveARFCiJVZeMPL96MmoEgjIOs/6VyefvuYYylkEbKMnBg60
	NeM01v+BM0gfMUByepNHUCnxyXZyKmKhesYvq3TRECNXWpEpsm3IaFV422uC7AJF+ptfjs7g+zc
	573RjEtrFjJ99/3LDzajBZxjOHT2bRsdQvyDZgmB7xcrQ5ExrgMUmOmpc5IIo75Ej2UEEiv2tcj
	r7spYJ6xE8NhacuNZBEqkLuBF5HCGBNQVj7W1BI8eoilnoEyjtB2jYpOlhBOQAVc71MfW/5tKVm
	7IALvLZrOx7ilSTO96O1yteQcQ1zpOyC0FXKadMSkxzsQoM48peoNOobrn3Fmn/yoJAg==
X-Received: by 2002:a05:6300:398:b0:3e2:b092:c3dd with SMTP id adf61e73a8af0-3e928d5c41bmr11542154637.44.1793746546378;
        Tue, 03 Nov 2026 14:55:46 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:45 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 1/5] spi: Split spi_write_then_read()
Date: Tue,  3 Nov 2026 22:55:18 +0000
Message-ID: <20261103225522.3643901-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225522.3643901-1-jctchan@gmail.com>
References: <20261103225522.3643901-1-jctchan@gmail.com>
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

From: Bart Van Assche <bvanassche@acm.org>

Extract spi_write_then_read_buf() from spi_write_then_read(), move the
buffer mutex to file scope as spi_buf_lock, and annotate buf with
__guarded_by(&spi_buf_lock). Eliminate the correlated conditional unlock
in spi_write_then_read() to enable Clang's static context analysis to
verify lock balance and buffer access safety at compile time.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi.c | 95 ++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0d36460e2c87..85089b0ebf4b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -5135,7 +5135,39 @@ EXPORT_SYMBOL_GPL(spi_bus_unlock);
 /* Portable code must never pass more than 32 bytes */
 #define	SPI_BUFSIZ	max(32, SMP_CACHE_BYTES)
 
-static u8	*buf;
+static DEFINE_MUTEX(spi_buf_lock);
+static u8	*buf __guarded_by(&spi_buf_lock);
+
+static int spi_write_then_read_buf(struct spi_device *spi,
+		const void *txbuf, unsigned int n_tx,
+		void *rxbuf, unsigned int n_rx, u8 *local_buf)
+{
+	struct spi_message	message;
+	struct spi_transfer	x[2];
+	int			status;
+
+	spi_message_init(&message);
+	memset(x, 0, sizeof(x));
+	if (n_tx) {
+		x[0].len = n_tx;
+		spi_message_add_tail(&x[0], &message);
+	}
+	if (n_rx) {
+		x[1].len = n_rx;
+		spi_message_add_tail(&x[1], &message);
+	}
+
+	memcpy(local_buf, txbuf, n_tx);
+	x[0].tx_buf = local_buf;
+	x[1].rx_buf = local_buf + n_tx;
+
+	/* Do the I/O */
+	status = spi_sync(spi, &message);
+	if (status == 0)
+		memcpy(rxbuf, x[1].rx_buf, n_rx);
+
+	return status;
+}
 
 /**
  * spi_write_then_read - SPI synchronous write followed by read
@@ -5161,11 +5193,7 @@ int spi_write_then_read(struct spi_device *spi,
 		const void *txbuf, unsigned n_tx,
 		void *rxbuf, unsigned n_rx)
 {
-	static DEFINE_MUTEX(lock);
-
 	int			status;
-	struct spi_message	message;
-	struct spi_transfer	x[2];
 	u8			*local_buf;
 
 	/*
@@ -5174,39 +5202,21 @@ int spi_write_then_read(struct spi_device *spi,
 	 * keep heap costs out of the hot path unless someone else is
 	 * using the pre-allocated buffer or the transfer is too large.
 	 */
-	if ((n_tx + n_rx) > SPI_BUFSIZ || !mutex_trylock(&lock)) {
-		local_buf = kmalloc(max((unsigned)SPI_BUFSIZ, n_tx + n_rx),
-				    GFP_KERNEL | GFP_DMA);
-		if (!local_buf)
-			return -ENOMEM;
-	} else {
-		local_buf = buf;
-	}
-
-	spi_message_init(&message);
-	memset(x, 0, sizeof(x));
-	if (n_tx) {
-		x[0].len = n_tx;
-		spi_message_add_tail(&x[0], &message);
-	}
-	if (n_rx) {
-		x[1].len = n_rx;
-		spi_message_add_tail(&x[1], &message);
+	if ((n_tx + n_rx) <= SPI_BUFSIZ && mutex_trylock(&spi_buf_lock)) {
+		status = spi_write_then_read_buf(spi, txbuf, n_tx, rxbuf, n_rx,
+						 buf);
+		mutex_unlock(&spi_buf_lock);
+		return status;
 	}
 
-	memcpy(local_buf, txbuf, n_tx);
-	x[0].tx_buf = local_buf;
-	x[1].rx_buf = local_buf + n_tx;
-
-	/* Do the I/O */
-	status = spi_sync(spi, &message);
-	if (status == 0)
-		memcpy(rxbuf, x[1].rx_buf, n_rx);
+	local_buf = kmalloc(max((unsigned int)SPI_BUFSIZ, n_tx + n_rx),
+			    GFP_KERNEL | GFP_DMA);
+	if (!local_buf)
+		return -ENOMEM;
 
-	if (x[0].tx_buf == buf)
-		mutex_unlock(&lock);
-	else
-		kfree(local_buf);
+	status = spi_write_then_read_buf(spi, txbuf, n_tx, rxbuf, n_rx,
+					 local_buf);
+	kfree(local_buf);
 
 	return status;
 }
@@ -5371,10 +5381,10 @@ static int __init spi_init(void)
 {
 	int	status;
 
-	buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
-	if (!buf) {
-		status = -ENOMEM;
-		goto err0;
+	scoped_guard(mutex, &spi_buf_lock) {
+		buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 	}
 
 	status = bus_register(&spi_bus_type);
@@ -5403,9 +5413,10 @@ static int __init spi_init(void)
 err2:
 	bus_unregister(&spi_bus_type);
 err1:
-	kfree(buf);
-	buf = NULL;
-err0:
+	scoped_guard(mutex, &spi_buf_lock) {
+		kfree(buf);
+		buf = NULL;
+	}
 	return status;
 }
 
-- 
2.56.0.385.gac671c819a-goog

