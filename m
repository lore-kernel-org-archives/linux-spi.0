Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637231;
	b=oTRosBpj4be/91pwdTVAd/3X3pbgTiv3+aSifncRyq24rfXRuQeK27dWMDbo1DnPFGIG
	 mlx4Q84fbZL52xL6OtSEsTViJrAKetOJHEQ88tvJyqVpndyXuE0PCJ0MKTRNlCUHFKtae
	 wi/ahOtDq2Gpsx5m1Q41AQbZcFeYzseoEaRI2/z5dX6SUtUTs5wIXxBXXlKvV97suQ+H8
	 K0JGYtFBEeTvgI6SSklH9d+bqSouip9GDTua0bErryVg439RONZ8hm4cFcrsDE3icNzh3
	 s7E2Ildz+Clr3F300sWgoYWr+O1XX2VS+ky3hj+jfQRkMr/+DVUVn8GxZSaeRf9i7RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
	b=2R+RPaYT+e9wabglbWf6xgRqaS4HXHpzUwZaEO/UihXg/L7COuSM4sYMs+GyRd6CU8v5
	 DcXEcntmSEM8V0hG/8OEWtN4SpdDZUIsq6p8whfXQoBYu8Ej0JhAj0HLV7zSGJO2h8jqh
	 p77rwoXisglK2Crc3DashhHsEbH/CYqacVZkG31I3P5Jgpj0wt28TxnxCDnLf3Nu0y60g
	 TLHc7hVY94VPmY5ujQXMA6P8gkSekSrILWAic32YwI1BT4UWSWqppyItK0VnbWnhiJTe7
	 Clfc/9xivqHpZp3JyuTZFXTdeomLVXG1zzbuWkNnbupoTQWNj72kbWvlDIpginuXy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcBRjtd0;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142160A0C90
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C142160A0C90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcBRjtd0
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so2146020b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637230; x=1794242030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
        b=CcBRjtd0AvsoPzgWq9Q80R3XYFb2aSLnURrqxrhdXzkqtX4K3EAQl1srbBuEdcWd6w
         FNWhq8L3ZOZpulDYKH6DJVhM6T51gTOZ4fQ3Calj+vwryyHkm5fpbLU886ovOE677rXW
         cWpcN9srRoUzRU88z95ugwRfLHZ1ZNzzmR4FKU3UcIkwq2F6XLBfkYJUjLEZQwQzL9GP
         +WoP+zPO+4VVn4Z0HN3uUH9YcWbdg7nrvAA8VQ0ljdc4H9DIHj+8j6yWTxvAz824UBvY
         dmLBn786yImTL6enGtI05RqIK2ITcJKK7ZaD0AFMifpVFYRIwvMoqQGKSRZvt+baFjSI
         5HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637230; x=1794242030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
        b=B2zSGjDqKqa3pqmIxx+AIEgep/HUOMZi1vvzVA75aoQAu1yMytBkh+UsMBDW/8IEXo
         LJx4MwCseqqI7AczO/0AjPJnIGUi2DAdJMyOMksSyxcXNmJnKnpOeFIEULDSY+rES+xB
         fawUvVwl32ke4uv2Qsuzsws/4c5ozOKQDZz0aOIV4GX8ckbOwPT2LBCZ9Sbw5ST1539r
         fltldQYOWEXBtmo0anieklpWuOxgurYxm6sg4YT2MFx8R8lqgICUFkldA0F5tQxQt3sz
         1JkormCNlD3mSwgpv0j6V9sxWNhXyrxolEUFYJvc69uBD6bM8KF3UlqYi446QgugC4KQ
         Frjg==
X-Forwarded-Encrypted: i=1; AKwUvBzXjB8rmvEQrW9tGj+VPZYlHuwvbpD56zx/7OI7m/HgwNGQAkIbThl8zwESGn3NcKfPBIz34Jiv+3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XSwggp6PTe5hBnFEBEb7PMneKkMLKnBI7iPaEUrC2bs3UqGIB
	LO7FJdF7sRwdoOHSQSH04RriBeyOyPStciUWj2SndncPAIoTVy0Chsx/
X-Gm-Gg: AYBFou19c2kfLK6ixJhytSazyPtfS21Ghid90jM53F55Zlre7xalOhBSiACt1hqWYe6
	Xg3RkSzeUCN5iiiuCwuKnRc4QdxiH5wVBJci1SeJoXZm+lV7GzyQDcLf0bRTk0mBUv01T5HilwY
	/fE3L3nelIo/i+w2RoMkKcOQuDEaJTg4xhSw6zlrfHt0azZRMhLQqte/rzXbOjp0di1SVJKH4PP
	jGafgEd1t62bWwxZOzPkRhBagEQujDbo7FlgHvyrRldsCSHg3FyL1fCR1osEvGFWVihg1FyhNW/
	CCXPL1QN30MKJfkGwgyAknNcBqGDYtH2pdrA/UvQDJgySavpJVLaYj9mGYzocUEldqaZORLgnep
	4siKkO5nVIzrk/xHKbN0OC1e8mAOC8SgB63CdU0U1nevithv3RRewBUoGnUS5rw+7CAJfLF0Mu0
	WUNi75AoMvqFZnwOvhnFP7oqbnDTGuVeJXSgecj3emWpnKuqvU8kfIX7hTRTDgJWPRPOG8cnCQ5
	hHkj7OyjqPVKTn5vFdspbJc103dK8MUHwhK8MqbFq6EjrJsJmg6BqW5TGBzLghRudwN4ow4gmT6
	LXDrKduf0ejOTS8Rb0UTdOqFgVoFRh0RDlDxcLlQKMvlfjn/2CbGLq3O5bQhKmVW8/1OwI/K6Ur
	wvOZlu/tQkicsd0jsylVP0fE8ZriVfYh2GHHzgZpsGrarPkVDBNp0PDXU4ONQQikkq1KdzyOOSA
	fci0dseEVKUOryqScvKlixf5v4ZoF2LGmf
X-Received: by 2002:a05:6a00:e11:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-8a9bb7a0b64mr9114119b3a.12.1793637230136;
        Mon, 02 Nov 2026 08:33:50 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:49 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/14] spi: unoptimize message when queuing it fails
Date: Mon,  2 Nov 2026 16:30:10 +0000
Message-ID: <20261102163023.2574632-2-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

spi_async() and spi_sync() optimize a message before they queue it.
When queuing then fails, the message is never finalized, but finalizing
is the only place where the core undoes its own optimization
(spi_finalize_current_message() calls spi_maybe_unoptimize_message()).
So the error paths leak the split transfers and the controller's
optimize state, and leave msg->optimized set. A caller that resends the
message then optimizes an already optimized message.

This happens when spi_async() returns -EBUSY because another device
holds spi_bus_lock() on the controller (for example mmc_spi), when the
controller's message queue is stopped (-ESHUTDOWN), when the controller
has no ->transfer() callback (-ENOTSUPP), and when __spi_sync() gets an
error from a controller's legacy ->transfer() callback.

Call spi_maybe_unoptimize_message() on these two error paths. It only
acts on messages the core optimized itself, so messages optimized by
the peripheral driver and controllers that defer optimization (such as
spi-mux) are not affected. A queued message is never unoptimized here.

Tested with KUnit (spi_core_optimize: spi_core_queue_error_test,
added later in this series) on ARCH=um; builds with W=1 on x86_64.
Not tested on hardware.

Assisted-by: Claude, Gemini
Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..0d36460e2c87 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4906,6 +4906,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
+	/* The message was not queued, so it will not be finalized. */
+	if (ret)
+		spi_maybe_unoptimize_message(message);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
@@ -5009,6 +5013,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status == 0) {
 		wait_for_completion(&done);
 		status = message->status;
+	} else {
+		/* The message was not queued, so it will not be finalized. */
+		spi_maybe_unoptimize_message(message);
 	}
 	message->complete = NULL;
 	message->context = NULL;
-- 
2.56.0.317.g454f8302e1-goog

