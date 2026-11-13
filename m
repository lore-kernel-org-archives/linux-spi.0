Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535442;
	b=qYFVrOLS4eaT/DM9rULJ97q3HTL+UVN9T6n+g3Yi8Ct2opJuKcNl1j9EX/8e+TdixoxD
	 30pn3fImcQ0/Kr7EDNABW+2Tq1rEr0Vga6Pyl6Y8odj+wft3rnDn236DDq9xfu88ED9mf
	 vUvUHAhfnlMY/rlAaDJr2IOQ6+9aQog1ZrxC4UV4nHUAZ6UNdPmaO23M5NB2XFqZN1Cfx
	 gMRaQQPdbBTxS+sTrqVj43OBhGlaR/twFRt6bJdbPQajknutRgZg9lcQT4PT7fPWhFoM4
	 2QnX3jXNyAnO+Dv3b+gS5hXisaMxG6VoXKaUcr4F3g2VJWJKfP8EQ2a/OBZHpgUfIFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
	b=cr2FyHM8V2/BpMRTAQ4Zfy+jqb/lDmU56cci8QSJwvcPQaGj9vzmNsoAGaXHCMqt5FD+
	 QUAMOyG+yswRfFbay+1/8mPc4xLBNVOdWWkQv9oWBokUlg2IzX9If8/0tKDkg79gMlunl
	 0QLGZVRiHwLj1hvEEUKRxHVcy0fsqzcNomlm3gGUmxfDwBhsH/r8OjZnkqWrq+tGJyq17
	 5Ygnnm1XOIh6CBWVwyhja+v58JUy/Mv1T5cVZtkSE+8hzz41POEJrVWGkg2dw4ARkyAFw
	 YyMlDV/eq0oBxwVMxU/q6mmiZFv+S9UzROmzObEVJk4JEipU7J6DAYMC62cMjJxqpBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qq4tUlWx;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B8606A33F
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 02:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510B8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qq4tUlWx
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so558411a91.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 18:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794535440; x=1795140240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
        b=qq4tUlWxgxvu9FuI3nMao3Sd6WxnuMAv3ieybIed6+2qd+w5MRDY4LP8+Lz4JJUrBI
         sHe59g1WaSp8lRytNqzFMV8/dozA1HSVj8+PGlvMtJ9vr9ywpjEE6tQgWl5+FPiGD0WL
         VOaro1bUbEmaZZVcEy/kysDVL5KzjLIeMtoANpZArCYQl9dkhRygkUKmy5ar0ROtorUD
         UvZENy1uk4ELD2f4klmkH9IDP5NdrZdL2fS6eh5BZC13LmSgcw4yIzj6LXutNaCM8AF7
         NtcAxuzqWFavjOnUsdN8R3X24iP7UjS5H0YaHtu+B7xuR6lVLtMrwqPJzm8tdiZ6XSlN
         gAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794535440; x=1795140240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
        b=IMcfxz22e75Q+W7fCJsmObsuKVceLpEipmRvYzyhpcVdvA2Sj1vk8265IjPHicpxEo
         vo9D+iU2N2aLJK77rZ/6//6aveXAYPJGLOHz2Qn4GnEizjYpiAkIaR6f7gsjYUxowgP0
         F2xUNaB8kVZPNmgi0lH6KO6cHumlR3NDe1dl3o32Jw8abXUowIrLcXaVVWduK+6MS4yv
         h54qM0UDKr6OjyBQU1w7o/wt9+UUUqP/VuOW/+CQGZcu6X71GQttVkC3gWO6vhpF1WHT
         QmrJeZUAmTpAc/jkuyrA51THsCbhpyltkp/0wOznwroLN6s8xkrjxUFEpp//zMGNt48t
         RC7g==
X-Gm-Message-State: APuU4Z84Pasb6f6kqgNaSHoZo5Tmbuao9kJSPiwstL7+1mdmxk9Muw9A
	zxM0TYxV8xO2Pqhl+SuSWIYg0MuD5mloB/XIA9C9RHytsYUHFYMzrqS6
X-Gm-Gg: AYBFou2F4dWf/UJHTnzRzJlMOgPzNPy4KBOhFzSine9Gm1uVfhhaH3Zpvvye/LRWEUp
	Ws+4iFZV4yCv6cLliYAItVCltaO0Cq9jRlgzLI4jvJXCQOVOfc044Z55CpIAWZGM5poOk4gAqAg
	Ft3jwXgMLfwpi0X1vjaNUtsMwuUUr4UumOghhRwnKzoyHyhNj6B/cxNAc0+X+A7Vri8wcgYrIpa
	wPRK0vUJfiPEzoi6Fm4hXVUuSvNhiNh4xWRTRHZVg8UKzdYgboGDFJwCQkuHXb38n4E1pWb+lp1
	i+IBP7S0qlyzIZCFrXhFv5DxWNn73EakPGbd/PppNCL8DbDwNxnWQhNkJh4G5DTrw0OgE0OzXHL
	xCr835/J7sMD91iZewDq5/7zNkXsKgUMCqodqJ+XR0KEgUevlL0tT71igO5yqTDzaKdySsIoIVi
	BKWyTeovLumgFgrkobyK5QLcgri1oqH9BT3s69s5zzGU4b2xRV3ZngUzExcQEA7+EDxArVZH843
	77cmii9jNy+ZHZR98H+6tNDQnlrvizSdpDN93I52bTXmIVQ+uxGYssMRLR+w6wQ8ZDZlyIbc5WO
	tYK7mpmvgOdGd0uU9OC720RjscNsJhHSaPbBeIh547+BF7kqO+mUhLvYqvV+Z1w9Ha6Uj/tBJW+
	ZZr/3Qej75lk7gF+cT+Or8cAIqx2aiAaXZ0XQBjz7hUdnulLfe9dauiKRHzAkQaZRA8f0nKyrtH
	TxdoJaA9lv0AdnOA52Cgc+IWkOhmBntSxpwFrFio/llBSWyMOqjsWb3SzgSUsLHaq6GDXpISoP+
	ISkM+XbuDujGN5sBw==
X-Received: by 2002:a17:90b:3890:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3b1b09e69f1mr825607a91.15.1794535440527;
        Thu, 12 Nov 2026 18:04:00 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm7167618a91.7.2026.11.12.18.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:04:00 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] spi: unoptimize message when queuing it fails
Date: Fri, 13 Nov 2026 02:03:51 +0000
Message-ID: <20261113020352.1741295-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261113020352.1741295-1-jctchan@gmail.com>
References: <20261113020352.1741295-1-jctchan@gmail.com>
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

Developed with help from the Claude and Gemini AI assistants.

Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
v3: No changes.
v2: Added Reviewed-by from David Lechner.

 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a1276d194465..a6a98f052809 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4915,6 +4915,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
+	/* The message was not queued, so it will not be finalized. */
+	if (ret)
+		spi_maybe_unoptimize_message(message);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
@@ -5018,6 +5022,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
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
2.56.0.506.g506a7eabc5-goog

