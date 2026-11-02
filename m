Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637247;
	b=sHfYR3jFBxSXim+IloIaa994YboApdw1TxJZMCeDsQd7JAQwWWfWyucQM7kiewqLTGjI
	 pc0ukjvvUtR+MIT7tMoVgmJZ4HztBRISvY1XwtqvVfXycq8xs6XjGQkxNLX59Tm/V5doG
	 EFkdFO7nZ7t7GT6DjVE6XybauacRsKmnWCfSXhwbCvA4tIGKJV92zRg9MBZp5w5Y/zHQ4
	 n8U/sTpyrjagKLCmVdRY2f60PiERQSVOxN3yMTuxgWIVBNd1iqndTqq/9oe4lxvw7YF9Q
	 w8c6vSJiOOK/jnHYEvgG5Fqw5rEmDeupiz1pkqauehAdUfQrxM1i1ijgX9aas7RZgOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=husvbJKKfTlpaUunpSaadfP16/aB1Jpe2bl9Xoqvm1E=;
	b=QYVB9UkkcxF7VSohamCw4etF+aGeBM1UQop2qiJmJfe3ZkAd/WaJ61DjjdwaKskj8vth
	 qzmx/ojLEACibd7jPK+suk+xluW+AtjtRExD2bWuTNYpMH32xdtBardJG/g1VBD7wkoX6
	 2L8LJWJdm+5t7mMxaiX34mfUxDT9kvQJVgLbk+Wa4ao/QqN7xHAUjiiD6uoWXj3Tf95u9
	 ZhEMs74dbISbGaxIgWukTJhRWWlAlILzT+OF4iXscNnO/CfPiQP5WWqhzUJn+x2A3MTqg
	 BHoEhtXT0CL6uHT9Mft6RH539nrGcfi/Yz8cEVENHzCjvf6qZ7DKvzBeicf9nCO1xSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ezi5RI8Q;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811660A0CBC
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A811660A0CBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ezi5RI8Q
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06454116eso1345558b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637246; x=1794242046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=husvbJKKfTlpaUunpSaadfP16/aB1Jpe2bl9Xoqvm1E=;
        b=Ezi5RI8QTEqKRBFFLqucGayOLYr/oj8KIZnmDNbDNgk5zIfBbtnWObrGG7gMJZW3vq
         plXxYpNQgrjuY+MSruxwTO4AeYmzcj3g7ckMlmBNRtNiV/NGrR0h7678yPYyDw//YwSW
         Vu23GxSElCTbScYmGlGO18/6UjMv+qGdwDYEsoBn233rackHJa9nTuk2hzlT5ESYU/Va
         kVNJvieYAjG3RPEWr49FdO5Cqu8tplyTDmeMoRPcyLvg449r7ojjMAKw1IJHs+ME1UPK
         o/Azl0Qx9g8OjfDCV2RL/3CcqC2T5Y40ntB1fH7N95N/8N8xjOxPRvFRy2LVyCst1ngI
         NC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637246; x=1794242046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=husvbJKKfTlpaUunpSaadfP16/aB1Jpe2bl9Xoqvm1E=;
        b=EHh1dq7NxnJZ1LcyX6Z/E+6TBkUDOBjPE6HxQQMMUkM6urfq18K1x6Kc7epV0H8XRu
         cuS5Ksa808VazVh+2+ouv547+6koEAg7qNxXlkAPZF0XJ3c4MALbUMau6J6MvXWLrOBy
         1oRzI9ljRfu3KXSNdW1kOAaIRx+pbsGUKefc+TDvQpLEgpBwuxNX9LPtEuL2ow04XFDN
         xpd+vmUlo1lDsyVSpF2RsWUDGevFagYzQTfOtKy2xyTYYMhjOm+O06xumljacI0Ln6xH
         lyq65nD9lVjdH1/furHS8mLz7R+nYdRf9cAy0rbKBGxKCSTOTxl7/F/rHvu7GY4xVrPc
         kXLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXOEA2DY3XjUi22XgWaPXHo8o+6xBIRHUUGiGnHDZebLY428KtIzXLBLqGJ5shcAUr5ZIC3zjYnXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+O6ZoO/kivTnVNClvXLDflB6E0xopB6npkHHx7ljXkQYqKv2UY
	BbLA1X8TqrRNAVAe/PCaTVg1STzbTIWQD2PXf818utP9J1fFNHvfzxxK
X-Gm-Gg: AYBFou271KVTuYepmJQtdD1itLjjrtht5+JwN/gCzSXi5uXSS1WRa6sG5HBqTjbfneU
	lxVix6SYtjEeDZFEDwOvlgACl0yiQsV/HKtkwOqVMlZOiTV9nTLj3a8S+I6I/8swzj9dd6QUyhY
	SeQLu+/wodHy5yGaFAkXsALpVZ7AguFE9ipqy5WIw3cH8PcXvo/KOo62XsWTLIZC8xv6RhMIoHa
	VmmFXYjaxB+MuUFOTxHXHtTBaBmtlCUWW6hXMOzI2APMQNJ30lAaCDc/wJM9xrxPGlS0Cpk9iE4
	cXsuJ+kuURtL3CGdA1SIZfRJppT6ZgJFeF4rSI7s3EExL0eVQWlGjsmlfeV2fIBX9jupLR6x5nm
	EcOlFWs6YLCtFYgdX35UG4lUV03nMbXZDdp0cbPMC7Pbl/MCsQhwCf0GLOvNnhVwpKH1mPNqkNE
	LDImjj44uvHyZAD0Vg7w9bvu+XwO3pz7OIjVMcadh7KFAKl/v/I8Zty0MNwVfM0KeQbLXHnv/GE
	AJkW5WPx7dcmFXtG512xZIGprprvV7HMcFOXMIKuWRTwQ1yf5Vvc6ViHTtdmg4BGgIfMjZca8Vy
	4DuUc0FLtr7vJuOx4HKD7ErFmh/Af5oolJrf+CgWquCRogr4ssSBesfgS455PKq4nvtAQb7WLiS
	SHn6SN0wqoghdr5i6wFFULIE3XltUa/fhBHhGeU2mYhKBdxFX6BXjUtAoubQ03XP1Zix37iN4+i
	3+iusxxdVXyZlV/OU9OAARm5q/qkv2Dg==
X-Received: by 2002:a05:6a00:2282:b0:892:d40c:4f7b with SMTP id d2e1a72fcca58-8a9bdeb9396mr9057991b3a.10.1793637246075;
        Mon, 02 Nov 2026 08:34:06 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:34:05 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 13/14] spi: microchip-core-qspi: Add lock context annotations
Date: Mon,  2 Nov 2026 16:30:22 +0000
Message-ID: <20261102163023.2574632-14-jctchan@gmail.com>
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
2.56.0.317.g454f8302e1-goog

