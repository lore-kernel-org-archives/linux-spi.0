Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746105;
	b=ILONqmrCs3E1kAhpnOhLr4HKJROSLpL/ZeomMAHpOJRBP9LAPhNRwkF58ybJT3vI9kz5
	 qPZCiDlKxVGr47ZdtXmTDKxsNaq7YFKJVrARZY1XWiBRfdgqZmBNaUTCv3jy/QIC0vG73
	 uR297EDynzko/231P9luHuU0O36oj4yLy8MXZKXe6w/h2ZyUOS5BGXDfQCE+/ChAcVUgg
	 1nLbPZLy2sRYIXOv1wOqp/azGGmbJWFrl8j70f/Jsvj+2vqkZfSYBJGOCTGmyqv49Q0A8
	 NcMmYRTkme4By8vU8pc2k9489MPFobcOxSxRI1OSmTLHv5cZI+JReRTTz46dBt86vUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
	b=1gS4ZYD1Zlh2zMyDQctOmPn9oPSqSCPG6AqCTsieQpiSO5dR9u9xPPV0Aq8FWRNn+kzA
	 59/GPwDXMzH4HJICbaW83TJdXXGnyXce9ggoYnqWfYdCN4HiFW9mi0T5krDkqGZAzgOfu
	 iQYhYFqfwcW5RliOCZJXdPsA4Z2eHSzNJ2T6MFRd+o7+fpkPhQgi8u/cLRvU+GBgWVNt2
	 pwf5bAFq8l0K4CRGYVIJ2it93Oy+iuY0sWcNG5rxFhnaFe3WMiNWnghHTrrfqvdVfeSK6
	 uYIx2hkil14eBBIPjGpwIum4z0onn+WBKZI0/Q4VTWRpfpUj9BTMN8xZ4TWM8KNZv+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpHk7d0w;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE50606A337
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE50606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mpHk7d0w
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab98332238so65482a91.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746104; x=1794350904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
        b=mpHk7d0w6Z9ihxp8ADY2A/eqF6TSSUMTNSCgppLUvmt1fkqOj/WjnGf3R3lbTGgUrh
         dMWEzDgaTlzQRtIbrPfqYWW7w/CqeyGcvBkwK3qIv5NmSdsb/SWYCANJRzuAIs+F/RaN
         YzE0xpy4Q7LK4zb3KWEJcXIelHkvU7IpofR0M1YH0Mi23Z4bxO/7pxP3JiDiVxE8++P2
         aTWnv3rkY0BhpsGTC9ejM7/kS9zdzxm2DnLpGEie5g1YDIILu615W/46vKPmY2xJQRmD
         Pb/WDE9DiibXMt4S99eeedEczc6wEXk9TtU9E5UodmAz75oYKeLOre0dzv1IqUqL0YvN
         VS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746104; x=1794350904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dARvLeluVUPCf9P8XMI0JaNPOob4l9Gy1vFeKqsjw1Y=;
        b=Seqz/L1yNsS4HvkRQ6jWZOJtMl1PUkz55EvwY8lwfWjxZcfwSaXilCHBpKPmN2Rl9i
         TQ90qjFV03ecq7VeMdXZx7JuX4Yk0A6xwcJXd158Yj07ZlGYPBE6du/a+/qHvByfTyD/
         Q0kaw3NLtT4+biYb51PufKCDbkeNRWDP2hl8/JbUqthiHVsHPvjFPYdCD4s4vC1sm27s
         BAFoSnFYuYHG7nq5INjMamDsp7D7SQmCosfa0CQEjY9tqb9yaqmd0J8qCdZ2anoFliXk
         73HLgz2G3veE521Xvpm3y58pvlPqQN2t5cWr9A6PpbDfwkfvlRBTX0EXX+UK3l5PLM+1
         8vjA==
X-Gm-Message-State: APuU4Z9D/tQjcVI3iyfh0TUH3HIN7fbYdVvJFu9i4FvsGhBTuTDaM3eq
	4BiislziPQ2sTaz+X7QXhnYNoA8p2O2/iykzDMU3LyEo9XDMgvUMaGg5
X-Gm-Gg: AYBFou0l0/U/revIPk7XWRw2jbYihLGZyt4BqyIUw6wInaViPyAf56QIEYuf1qIa4Jq
	+a1XmlsMBJ212r0C7FuiQYBq2EGf6FGiMD9XE9M8X6eoodjfmDNodXK3sFnPCWSYwAXDZ3nk30p
	655ifh2NnF8DLKQHa5bagkjh3ndBezKW50uLpKl7PEfusBHmSgiVqZfp5dyvb4j97LAJJcmTm1d
	L5BiJTEifsXMs9yEDcq207h0niHjPHk5tSDf47tZsJJcQJ9lCy7fwPcas/ATfoAjvDbaAaZW+pG
	ajCZBQjsDSJBINYMTICRlTNuVg7hjeo+dbYZ7mjwrqyhC0N3Zoku8A1zyIAOxzDmHR+ugYtZ6Gs
	chWQDuNBSgaazNkNDIJndWBapKyfJh1LxZ/B4JldO5XGxfrLRlM6GZH3K4vbm+jRRHKrwaQ7u43
	30mV8cCW24mo/wuOv3NkQRiVwaq+Rl00tklSR0GLNlunxWFMOFg3bcyEe6KNA5seGc7uoVm1MnR
	Adgjat1HAwwxjnZ2y3BFKrBDAYZAvvfzciyRSJ5LTU4G5zfk3jRWHkAdFmNuryH9+9RhBTQBo1L
	5qbgrZJl93FZyo2sVzsq+MFChNRmhhAP7pMK8RzFvDMx7VehfHF0bH5jrxNxS6I+4XHX45e/KxD
	6T05MkZbDLLJmnBzxEy70Kjk2OcPOnj/TeKeayDn+wRbgsT9vDx2vVGQcbBzsEUC8ZQ0OqW1Umf
	99vYHYQsyV55hVJORGHZ6PPPPh88RVL73rRtXs1kCAkPfB6N9/ZTd9t4gm2NnemyuRRxLYWZxg+
	5osmKXWaByMPuE=
X-Received: by 2002:a17:90b:5404:b0:3ac:b3c7:de14 with SMTP id 98e67ed59e1d1-3ae897c8bacmr11921969a91.61.1793746104533;
        Tue, 03 Nov 2026 14:48:24 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0982e9284sm129962a91.11.2026.11.03.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:48:23 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] spi: unoptimize message when queuing it fails
Date: Tue,  3 Nov 2026 22:47:52 +0000
Message-ID: <20261103224753.3610049-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103224753.3610049-1-jctchan@gmail.com>
References: <20261103224753.3610049-1-jctchan@gmail.com>
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
v2: Added Reviewed-by from David Lechner.

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
2.56.0.385.gac671c819a-goog

