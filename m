Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637241;
	b=bvXpgzeLaiCxXmg6IHPIK9RzjdqpClUQySsqFfGE73KtbVO80/FRwjIgkfoXuB8b/hRH
	 U6rz7WE0N4VAfIxXeWUBdCNz3DySysH8Rsy5llaWFpEtw/Lpbb/NpnGxn7CdwnaxKtv4e
	 EkacMg3j8SCsxFZgYeG/YOXe58vwU93trIKibaMRPxXSRbtBJDGclbb0WYuEHJZcP81xq
	 2qKGfeR9PVYsyIz2xrwMef0ktHwGBB39DZcYyiq7UjpQQs2c8iWTdrnLkDcQESNR1QYIz
	 hWw0M/Vdsy6m4o9Zk2Hiihx9aNot/wXQA5wJEpgcz3fx1DfIxBakrUIKjVKt4OUmQGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DR34wVGfR+edShpxsrrYs2sxWQfKIIjdz+zYiLSUcfo=;
	b=Niko8TKvXzdtNH9YGHEk1yGSzlwky6k7vAqmm1oF3I/g7Zr1TeyX/P0Cge03e4STVdt4
	 TSU3Q+UZNvErkXLrUrj6uaWEr7tv7M4GUbVOBaIcU8RQbj9vIWyAugjawxUlQY4i37X/m
	 JRE71yfj1AygsSNmmPgS2DGZ6oind3CqE1+XBJdBmfwYNlGi30PYZunX8APJLDsCd3tQF
	 rbrVT5HYu9bATLAhpakV4v1Pv4orQ+gssgL+wtLuUvb+dfapG7gKzKNBBI4GtV7SZFK1J
	 BRuJn9wZxJwjg2j73kCXiNoJWPJ9PXKiVxc90MC1ZPq/Y30pVHDvQCn+qHqDm/YjERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8eyiR0l;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D6608B072
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944D6608B072
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8eyiR0l
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1175099b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637241; x=1794242041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DR34wVGfR+edShpxsrrYs2sxWQfKIIjdz+zYiLSUcfo=;
        b=r8eyiR0lwxrXg7+I7rym1vpJQBp2TM37nRUkAf5mu0WECSgka4naeaQyUgiwLktwGn
         jWp0+6GMUuLshmVlDk4UY7anhxpPITleY3ZSWvEUoWOzq+Fy7uXsV8qwAm5s7eNQpkQP
         XHree4qTQt9oO6zEjdzz94xbzu476OG4xwKrbibGV3ew6ABdzv7w75KSk0bY72YLUv6L
         QaJRHJvlFHpHm0HgXMBEDR9hqN+ZAFzhKf05PH4nXDC4aJZnkL/RngXiLCLsLN6ZqlJZ
         TCVkXNjZKhIq5StqPC4IUvPwk+B6LsJ8B6n69rlp+EDR1zSeo4Kvr/api3J/BHlxh8WC
         9/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637241; x=1794242041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DR34wVGfR+edShpxsrrYs2sxWQfKIIjdz+zYiLSUcfo=;
        b=vZi/p4pf2EZnwNbLEOARkGAm5mvNd9genY/vyB7Kxx9bFueIxmSCQykdRs5bs6bmmL
         PYdLjg0KhB+vwkyykhhYrN8wjcaT38otlgXQJP5AbMEZQFId1PrjUVzXfWQ4LZ0eCOwl
         gv5lXrM2YXehVhDmPTtsI2mi5/fqUS+DEALlkP/y6fN6Pdfj8xXpYbh6CMBw5fwMmVIu
         XOLiPetozLdBeJ+B02aaaO7J4zkPAPsriMhyBN0rMqbfEGcGw3Nbv5gt5rKZsHLSjvZ2
         Jp/6GkaXgQGfrTNNhXNu3kGI7Hxs7JX8nwQWiWEHc9K7fDSz5HauI0KTbxcuQ7a937lE
         jucg==
X-Forwarded-Encrypted: i=1; AKwUvByeeiTCe+XY0/rHxvmkdw6bHWFZqQ7jCU5wwhnZ/+nfsXLb2KaOKzJ5lkd6wMIlmYoLbOVu9u340Dg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+y0Ef1QeFVrq+VS24CXgoAYucPZGdKUDpK2uVLOYsm/WDlA+Rn
	S6DP92vZCBHLAaSh1D5+nmiaDJrWrV05ZqxDYZkp+/3IpwX7U8plHFHm
X-Gm-Gg: AYBFou2I6ayuTY5DeQDD6Ch7lGGanZoyC9YCBZMYQMxnB2TzbqpYUC94TP1aAIdfOSf
	KsAgdEnLafSktB/7izzh/7ENo07wL1RAv22akzC1JZXKrbj1sYGnC/b/RmCM8yUO1T6e5/NxXLr
	RyJ6fCfUC/93MQU8JFdmmOQvpAjTViHLaplLALc15Lmdy7tP3C0KDisqLj7kV+/F5QCqWua+NlX
	bJCqWXfnXwkNqjMavdwogrLzo0PoDZN/0ZfEtgWQbZtbffwCgPlhLujb4aztD3nX5fytPhbhQFN
	6q2G4rOPaVn2i/HVnNADP/eqfItKtLPN6XtQMugo9JkM3IMKsJEv7y+/y49MnkVYKWIsVV3DsOR
	RaXyKC1zIQOCXeiBk1voTvJgzRiLCOf4Vh8ji6cDAQzFLAw9A6vjSmiONrbkxAgsgmTCV5gkymN
	3EF/OEPnFRtNdawte8gS94AtVvQxxUp3JegBlhf6m6mxTiCThBaRRF/c/FqCLK+AuBTuZG9iSaK
	m84a94sv8/RfbuBb9Lv8gVV5CAOYyaGGygwnFif2JoADxnxDzpslFjZ4ZZCK72MEOCZ76xINQ2W
	GkDnjoBUjt0CHRMI5f6IdfWr9Gfrwl74Ab7cHvU5vNMk56TZZuNnI4wk9qEWJknYhQzLtsbH8eZ
	YQmxsjwhLTyL+7/5yoycZVbYcq3c62BLmTHTX7ePoFdtaPXypCOLqUY8jQVb4uraYlY8xMZ6MJ1
	DZnNHgKIrycJd/GEU/DHLCfVtAjkCeIg==
X-Received: by 2002:a05:6a00:1393:b0:899:27b5:214e with SMTP id d2e1a72fcca58-8a9bed5ba40mr7221747b3a.30.1793637240971;
        Mon, 02 Nov 2026 08:34:00 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:34:00 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 10/14] spi: Split spi_write_then_read()
Date: Mon,  2 Nov 2026 16:30:19 +0000
Message-ID: <20261102163023.2574632-11-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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
2.56.0.317.g454f8302e1-goog

