Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746551;
	b=XQvx9ZA+D7aWcCn5fACuQLPezkhjLIwrhzgyPE1KTaIoMxLt8tuDmaqrX7aPTCZb0504
	 gI3qfhM5YQioMyszryB711rkCQttEVjqpDJa8j0gESLGPKJNFIdyx+cpEw2clhTowspFN
	 tzwYM0CjHLEryyLpdW9kegeD63EftcQBjsneQiffmrvPX/cUB5uRoMAe69cfRQnsbjBFp
	 4YChurb0ExyTaHG33/Kl5I99O7vIjurkr1Z8ZSXjf5hq/X2YsIkgxhyXLPTi+9ZZnfHb4
	 3cJ3P/V1tdSoelUrY6Gs6Z8EysZa/RbcHBcKsdhi7a04c/3CmKCE5KkO2CD58e59ydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J5Z+o+lqW6hWD0H1y9v7jP3od5eE76Khz2ERCwR6aUU=;
	b=xoe7r40DuDWW7ePW8ys371GLGtIFcSPMhVXzv7BphTkSBJlZ84p+IuQRRu1fI0Ro5IPl
	 HpJ4gIbq2krSZgEtH0G7Q1r0JWKkRf/C5DBry1iNZhvA3pnxVFqddShR0e02qH+CjYR82
	 O/yoJ+XODZUsqt3DyZFBKKk62P2U7CfTe+kt65hnBoaroZ4OD3PAtT4OjKaGbCXLyn1HL
	 rOoE0uknF+5TZekdcQu4e6ug5W8XCE6UBudNIC5PuduFPT3kxVH4rezGW1faGGqEa60y4
	 VWi4PM/mgv22OxxB+v67U9W+SX/9fhTrXjkNCi0+hsyqBrzeIROKR3W64r2+F0aYSgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dakbp6Mh;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26B606A32D
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D26B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dakbp6Mh
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso60104a12.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746551; x=1794351351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J5Z+o+lqW6hWD0H1y9v7jP3od5eE76Khz2ERCwR6aUU=;
        b=Dakbp6MhTcPQ8KDILjgHzHCPiO39vy9gZoJBZTk3fLTcckAZh6LK6wsIp2zR1xb/oT
         zA/FpQdctb0jrESGc0pyRetFDNvjvZRaom5tURvNDlAf27ujIsSvoIRmQXivEyyShRb2
         hR8yQJSPncRpxxX0z6xbPhpQ38uncwwiYaHQJO8nZjR9MKAl6blySkAPoyLUxouHE2fn
         GeW7ZRQA3cc9JSUROOSErzRS/MLBl3sstLmH8d/f4mqdxo/9L95bPR9p/KkHVWvGgyq5
         jwCpa5zEa33YEraAUwLIRAef9tkd8sc3vYCE8XaPLkorw8cLqOCgRmMGsQFyYNxlTDQL
         eBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746551; x=1794351351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J5Z+o+lqW6hWD0H1y9v7jP3od5eE76Khz2ERCwR6aUU=;
        b=xcBTnQODNpgUJi+PY/+GsJHDE5GuAgQjZ6z3L+fb3YI92kW5WzWcDBUyZ1WC/SQviZ
         lFD2zsJR+k2bp4kK6U4s5I7RllFCMZp1rV78Yxnx9PG9l8tt/JxaD6akm8Z9HXeZKzYd
         HRvykSCgJ7Uscl9Ux7mbVcvsEvl55ybDfHJloo8/VUghBsnjLxA5ns8I2wbkg01FKT+Q
         6ijORifDMlbKl6EWaWCZ8NbftpNZTf3yOB+MBXE6S4nh+30xE0WsxSt3hcqP/kpdhu1X
         Cl3Bw7od0HT/Qs0ulPh5J4xy7IV9UZiYcZh3GwYqI+oVHsVqWYPg41iTtsNifxyHaWPh
         BH0A==
X-Gm-Message-State: APuU4Z+8LbYgwyHI+YHkKC5XaU6hxqEPvNCDEPbCog4Q6eFbx8K9OqZh
	fHJl1m0rH44lRUxXpwYhh0jbgCEaxav3H4oR338ncBV3ZeTtR35l8A18
X-Gm-Gg: AYBFou18CXTaAtxxdtGTA230R7aeHeJJW0O0WVaowEJKerTdJSdQpaw6HRe+gvIDDa4
	4PSTEH6LsDx3EvuyNLEUK3n4lIJ+u/IqdBsq9kSxO8C1t8wc5vWBmzmaEFFhwAzeLexLgi46J5s
	DPOxIgZoUmpBWRsSPrRyJqTwWoVxdURikkrKfsfUAgrrEjmOa5PJrGXFLG97wK5U9hTroG/mYmp
	zL2QGHXOmjFb8gyDr7uzGZNiPLQIVw2lMU5LeMY69zYC/Ea/yMIMNhChr59WSoUlNISbqC1P0Aw
	ZNV31g6xnhc44npEynqyCyD20BUQUQNgLa27ekGKUgMRhG5x6kLrzsB1Dcdj+HhLknTbrHPFbzW
	FxA373wGxho+Ldx62VtJx9xdvhkhZGkKsFIIgw4Dre+iyPpBT1Y/kNStQOE/2GU/YSWDm4aWxr+
	94vPnaBxr7EngO5XkME5nMydDfSgqTbQKnhxVIF9DmyB2+QPph5BlZDcpYjTdNJGvWGTZMDRR12
	lKOpe62b1ccseGCai+nnYmSfZRN+WBsgsVm8ZWzy9KXB4/4h3Tq98mUAuocc9qEzdnp8Y2Cg0Ax
	c5T8iulcc5jDVJLQZ+dyJP48vT7n0rxeWtn/5VP7aEJGEASjTkWAswiubWb63c31U/wESHF/q03
	v3DIaaPyET6fegmtfvTZUMEFBTE3HOwDzFCJbjrqS2x0Zv54FVrbUCUWos9KO/N+wyxlr8NIFM9
	9AzFms1jfDUAZAh5TrU2xDWsHwkvs7vgkx/FQZ1bEZpKyOOtj7+j8QedamiEEHzNG4NA==
X-Received: by 2002:a05:6a20:4326:b0:3e1:d874:7c1b with SMTP id adf61e73a8af0-3e929025a41mr13102640637.49.1793746550626;
        Tue, 03 Nov 2026 14:55:50 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:50 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 4/5] spi: microchip-core-qspi: Add lock context annotations
Date: Tue,  3 Nov 2026 22:55:21 +0000
Message-ID: <20261103225522.3643901-5-jctchan@gmail.com>
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

Annotate mchp_coreqspi_prepare_message() with __cond_acquires() and
mchp_coreqspi_unprepare_message() with __releases() for op_lock in
drivers/spi/spi-microchip-core-qspi.c. Document message-scoped ownership
of op_lock across SPI core message preparation callbacks and enable
static context analysis to verify error-path unlocking.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index c0ea65014d2e..a3143d966538 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -603,7 +603,10 @@ static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+#define TO_MCHP_COREQSPI(ctlr) ((struct mchp_coreqspi *)spi_controller_get_devdata(ctlr))
+
 static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, struct spi_message *m)
+	__releases(&TO_MCHP_COREQSPI(ctlr)->op_lock)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
 
@@ -619,6 +622,7 @@ static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, struct s
 }
 
 static int mchp_coreqspi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
+	__cond_acquires(0, &TO_MCHP_COREQSPI(ctlr)->op_lock)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
 	struct spi_transfer *t = NULL;
@@ -685,6 +689,8 @@ static int mchp_coreqspi_prepare_message(struct spi_controller *ctlr, struct spi
 	return 0;
 };
 
+#undef TO_MCHP_COREQSPI
+
 static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
 				      struct spi_transfer *t)
 {
-- 
2.56.0.385.gac671c819a-goog

