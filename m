Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637245;
	b=m+4lFDltuhBS6Vukn2SgKPEJ8/Hm9puK8ZUKJvBVjo317afzlMbE3Nyvvx3sFFhhsp7u
	 P/6NMIE0iMUuJlTJZOGK6TakFJWCQM8T0svWCCAnc1cNlK0c/YOorGdAmFTyQAA/8YZAe
	 vmEV8tJSHE3czy6s7RU851BMu0bUyuhdP/L5iy/8NXGA/wEm/sepkS6DnPsx39xjKxnIM
	 NLIHx+BJ24EDda836SozL7/m8/zGttoyU8Sa5esvcL6BWUrBWuDyca4OoxeVbzHlkAhRf
	 cCMu28GSHapGCZeSXIX8qbfkYYEgPlueFbHQdMBe0zykiaVjcWdhXcTKqgiCHX4aMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=etMvQ8aSs/buCeAVzT6xuTwZdua0h6h/bW2+zhXfx0Y=;
	b=06hYGzG5Hw1JBUBtzIr/1IL4hCufkbhKKIvP52/H/TmdJ62/FILoJ4Vp3YTlptBEwQbE
	 YvCuoZ5r/By1FQeVxwPHISZO4/PcRy6OXWXEGMJY27jC2MIJ6CScYI53HNSPM34+062m9
	 95kCnyxE+k6+EEsvUtFrrooCG+/1xH0pDAFSPg50rlROim8FGvqvDhj1OYMHf8EiPKeg2
	 s3n2+yeHIqi+HSxMTGeo4k4PjSA7SQk/KRZUNLurrn6FAn/E1S3t7rJqMj6Wiem09Ex3a
	 iAvaGxyDWgzVI9DCap/SWVcyjYXikeU3sbnDP/US2YFoIzrd2o0tPkk9ku1fZ4tuL9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TzAoeGaV;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C6606A925
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0C6606A925
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TzAoeGaV
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a07078200fso1168093b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637244; x=1794242044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=etMvQ8aSs/buCeAVzT6xuTwZdua0h6h/bW2+zhXfx0Y=;
        b=TzAoeGaVR0+0++hLGxp1z3EwEzdUNzuDPexdm+cGVNrGF/ibdNMJXslOE1hjh0Kzes
         t3d/OY3Rx1xpKiCq6woHdlqzcmBatdMZndMxaBV+pFkU1mxr6tGYCL3DAvYiff3Mtqpu
         zCU96UhSVQigmt5pBJSeeDGCwIoBiqlZCUNfEOLUbKqfTcr5TLWgxEM2dU6PTS0+HQlR
         +YYMFQlIJAHqULxyEZ7kMWXR6QZP8HUxAkNpA86TRrkiXPdlfTjKulyzSr57uIUuWeKn
         DFQQJzxmUNO7e6B2nMg6cPXlCyRDQ35WFkQksP/zljGKUlSAXc7ere7MM+R6wihdurX1
         7Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637244; x=1794242044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=etMvQ8aSs/buCeAVzT6xuTwZdua0h6h/bW2+zhXfx0Y=;
        b=n6OHe4wXOm6QZqoZzpRs0avsFqvsXYo3M88+NreRj0n1txDK4dAIH3F+dyVOhrlAtq
         F/xrzfpUap6ev95gCIWk73YviDD8kpC6w4G/XUO4LA7wLq0LvtEitgoeY144pF9ZusMq
         2UeDmzk9ghfjkL2LthUHUdLEn5HxgDZKngN3zF1NDhJxsw6MXwxdnR9M3PtIkRYa3LN5
         NaBWePhctYeom029PBZcQoDHy6j+41gQVtqODtNdW2c6kkNvrB0WICesw0m3OBPraoks
         cz5c5rr/HnNKjzCh1zT1aSMigkF0MpgzjpDK5ID8SLA5Z/hcL9vStMKb8aueBV56fJIV
         IBMQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5KipWfl6QDdEBnpj8GGqUZ2OH9H3UKAYys/KH1Ooa6hg2uA9ESg6C4Jsjg8GsfGInpYVQ9eOVgh4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zZA1CVEtQ0ZhTBx5H7BGa5tlQU64gfzig9wyyuApsN9t9BVsn
	0yBDpudMn+a7pyFMRrq6t3Le1Fo7u2I84nEKJOmQmZN+B/s7JmPBx3ha
X-Gm-Gg: AYBFou1lrSDzZenl3nQEumbtYOlteMUepdt4gtV7gmcPO0QMe4MEV1KKsd8w1nhvOB6
	x2CUF2OjdzXA1JEZ8AnE+rjOCyoaxZ1GiHHwKc08uxWsVtSfyEWxB1ZdZAWBwYuzYiTqtZ7lUg+
	3ZxjXT1/ifp5rtupOfDSjouR8IqSfil/rXm3xB8uHsS/w352OUDBLIUTs7qSJuC+XiuruZHN+Xc
	LwVqHi904jHyQ0UnSjNPOCQAY1dFhc5chUNa2yHflS2h5qTcgNKWE0AFeEs6tP/TI1Qub4erpw7
	2VNrDbALE+L/N22RR4/uxEFLGAGdfmuR3uJGN6VkbHEMzbD6f9SpYwEeo7JcUmcX0y8huvzfdau
	G9ntkZzcfTDKN7x+wyjuPe0vXFDHwIf5bVRgtKZoUBCAr8d005zct6ageZYkXivA64N53nEluGG
	5ytML7WQ2e9LifQjmhita/psTpwgXpiABPNaiBaCeNnMcfOp5iWhuefBB0DuA2KvuPa0Id6ouyo
	S1NHsfUqkcb3OkWP0Ck/xQ6SaGULNA0V5KqpUqxkW78A2s1U+extMtVqdeFy0a7kbe7A0BIkFoZ
	fsBlgly5oMDn12RQlt9LTp0SSPE65CGh85Ou1InRpMy1AumgH2ME9jBVzFdbCBt+xojiQ4zuta1
	47M6CKtWivU1ZqeoNU5gO7PBE9fkJJjtMp9Q/M+kL87RVZONvlPJtuaDnrrGVaMqlKKQ9gzf33d
	r/EJZkk3vwn7ONKOsPKTJv4Mu38W+GMA==
X-Received: by 2002:a05:6a00:ad2:b0:874:708d:b620 with SMTP id d2e1a72fcca58-8a9bed57c54mr8626300b3a.30.1793637243927;
        Mon, 02 Nov 2026 08:34:03 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:34:02 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 11/14] spi: Add lock context annotations for bus_lock_mutex
Date: Mon,  2 Nov 2026 16:30:20 +0000
Message-ID: <20261102163023.2574632-12-jctchan@gmail.com>
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

Annotate spi_bus_lock() with __acquires(), spi_bus_unlock() with
__releases(), spi_sync_locked() and __spi_sync() with __must_hold(), and
spi_sync() with __must_not_hold() for bus_lock_mutex in
include/linux/spi/spi.h and drivers/spi/spi.c. Document exclusive SPI
bus lock ownership and enable static context analysis to verify locking
invariants across callers and the SPI core.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi.c       |  5 +++++
 include/linux/spi/spi.h | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 85089b0ebf4b..01dfc25c1376 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4959,6 +4959,7 @@ static void spi_complete(void *arg)
 }
 
 static int __spi_sync(struct spi_device *spi, struct spi_message *message)
+	__must_hold(&spi->controller->bus_lock_mutex)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	unsigned long flags;
@@ -5045,6 +5046,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
  * Return: zero on success, else a negative error code.
  */
 int spi_sync(struct spi_device *spi, struct spi_message *message)
+	__must_not_hold(&spi->controller->bus_lock_mutex)
 {
 	int ret;
 
@@ -5073,6 +5075,7 @@ EXPORT_SYMBOL_GPL(spi_sync);
  * Return: zero on success, else a negative error code.
  */
 int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
+	__must_hold(&spi->controller->bus_lock_mutex)
 {
 	return __spi_sync(spi, message);
 }
@@ -5094,6 +5097,7 @@ EXPORT_SYMBOL_GPL(spi_sync_locked);
  * Return: always zero.
  */
 int spi_bus_lock(struct spi_controller *ctlr)
+	__acquires(&ctlr->bus_lock_mutex)
 {
 	unsigned long flags;
 
@@ -5123,6 +5127,7 @@ EXPORT_SYMBOL_GPL(spi_bus_lock);
  * Return: always zero.
  */
 int spi_bus_unlock(struct spi_controller *ctlr)
+	__releases(&ctlr->bus_lock_mutex)
 {
 	ctlr->bus_lock_flag = 0;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fb4baa0d3398..553c32987c97 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1497,10 +1497,14 @@ extern int spi_split_transfers_maxwords(struct spi_controller *ctlr,
  * they will sleep uninterruptibly until the async transfer completes.
  */
 
-extern int spi_sync(struct spi_device *spi, struct spi_message *message);
-extern int spi_sync_locked(struct spi_device *spi, struct spi_message *message);
-extern int spi_bus_lock(struct spi_controller *ctlr);
-extern int spi_bus_unlock(struct spi_controller *ctlr);
+extern int spi_sync(struct spi_device *spi, struct spi_message *message)
+	__must_not_hold(&spi->controller->bus_lock_mutex);
+extern int spi_sync_locked(struct spi_device *spi, struct spi_message *message)
+	__must_hold(&spi->controller->bus_lock_mutex);
+extern int spi_bus_lock(struct spi_controller *ctlr)
+	__acquires(&ctlr->bus_lock_mutex);
+extern int spi_bus_unlock(struct spi_controller *ctlr)
+	__releases(&ctlr->bus_lock_mutex);
 
 /**
  * spi_sync_transfer - synchronous SPI data transfer
-- 
2.56.0.317.g454f8302e1-goog

