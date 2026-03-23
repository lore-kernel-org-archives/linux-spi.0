Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89A3BE645
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281693; cv=none; b=r4LnGEWnk4Qy/LByuSZeVJwcExGoHALFys7Gjiv6JK4i6SYXUhYfCwA0OE3ltjIwwAc6xa0cIdll8nOmw5EnKtcXmmoGcoBhziGNB71Y9p96uslWDO13t2Q00cpDXdcHja/h9ewVCV62c9A3s4fiXLLQgxZZ2n1X7hRDE+DcwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281693; c=relaxed/simple;
	bh=F6O9RM5RWYDbuGEigv+0eVBvS1g36eOTG/dr1zB+7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkE2BpLGSY/c2TOOBcCtbyxEzv7ebnzgtw1tODpk5rE286+VKgZJ5kOcaUqOs/+v99Zicdzcay9txUONWJ6EtDXwAsPUSTGm7S3Bx3vP0KQr/4XKBd5J/j6Ht2JXvnu+OcwdE125N8MYp7ngp7DacBJ95v3dDgXY+KYaVMCJMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tQzSNPtH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tQzSNPtH"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-679f6ee3fb0so1123401eaf.2
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281691; x=1774886491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evO293Sdaw2AMQFWujbeilLvnGlR8j74Ybb8MMUf0FA=;
        b=tQzSNPtHXeGHglQAz9Wt7Z4K1HBpA5+SwfBQmd1UiP0BIZy9gAQy3k7FmVUhCJrd87
         3AL0qbAtH7xLtXOsD3MVt75VGyp1EPE+FBq+Q+kAbA+lRpEPFe1CZ+Ku9Z4X1Pom0aEe
         KWw2HYsSgRAR0wIiky8YUyMFd53BX6uQF6jGIaRrDwfChApiAKyY1N8+AI4ipfKIiUmy
         xJx00qdxHCxud4vOYuJCcG6bFhwDyRXIhnhumsr/bcHsIO8/NCQlDSN0xQEqL/NByssc
         PkKz4jryEGfselH0SUKjmx0O/zjmnFHI2qz0aIkB3VQPDkdBMy1bi3hwPA/h1hgjpTw5
         CKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281691; x=1774886491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evO293Sdaw2AMQFWujbeilLvnGlR8j74Ybb8MMUf0FA=;
        b=IRziKB5XD2zWq0ztTWPy5U5K+RFzDKj4Y+M2aLyuy1YCNSlxtZCOjlUYhJP1JBdmjb
         jHiH4w6JWpS/ECz6B7qFCa/HNmaC3s9S1BbxcsIGwdJiVGJOAdT2cSDf4ObqGq5maCh1
         iACvcG+FEWOmWiweIc/oy/eUGidAewdiqJaN+5zvveB0hCzpZF/SBMEvosZck5B/Zwny
         4EmxvzAUKTrP2W3xAu6sadrWKbQ3tLoIC5U2xvIChYeZ5Rw8s8L7WX+i8LZYzOF54tMG
         TsX58EgLin2IUZEvXCRR1G8iEZtE3SBLUL24uGrQV7VViGbYUdOGLj4DWy8M7u7XWeM2
         GXhg==
X-Forwarded-Encrypted: i=1; AJvYcCWtUciQbX4jl85QjuKvg2y3N7qkQiGlSAgK5JPp2BEC+Wm+oCIOPmqcGo+a4GfVdPk5Kw+rKuUAcLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybqfB8DJbITwAHi/k5V8iZNFItVIYebjd8hRll/Y4SwnXxb7HD
	SHDllfu8QLAP+y521n+RxbLXBCrV6l66LbKC3ckNzf4owCskP0F1DEIhKkAcafTYCvM=
X-Gm-Gg: ATEYQzxy8tr3RPfCHElY2m4hK8qqdnxQ3oxJmjFZYmA3uekYMi3/bHkN9pv9xn3iTKf
	es5Uqy6IE/i04icCIg+HTgztWBs0n74/ZJdAagKd3LZ4IozvFRKF9WmH/K51mLXCqYyjnD6oD78
	oSZ7QqQK0zT6BTydMsISklj9i/2BWTWZPtH7CfHHjMHyaA39Jtq+fCgBDUAy+k0Ok6Fxrqxtm0U
	+Vil5xQ9hQChKHOBwUJXpiyVRRp8QA+XDfChFiTyjR7EnUL5ukInBMw3bPuk0ObgwhkC0eM5LJa
	j53RaL7WVSDK07Ii23yy6Tr+Jl0YKwMUD01oeFeKnk8RRkweB2uoYv481GhDTDgZ0arv5gsnpA/
	h3HJIKad+DF0SQes1iVxAJ+ZZ48qMCRI+06cJDh0nXCQPONzcKOUjmB+KBNJTB4vs4FmQpRKv2X
	+XEjFHq5IXI9Anv5l0Q0f0xHrOCdzzX74H0A0cEizdrWJkqjFsU0DmyaOTDi68pFYnIg==
X-Received: by 2002:a05:6820:2016:b0:67d:e9ce:cb3e with SMTP id 006d021491bc7-67de9ced1f2mr3792594eaf.40.1774281690800;
        Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 13/19] spi: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:32 -0400
Message-ID: <20260323160052.17528-14-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 48ee5bf481738..02bbc5d0cfc50 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -953,7 +953,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_start(msg, xfer);
+			trace_call__spi_transfer_start(msg, xfer);
 	}
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
@@ -987,7 +987,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_stop(msg, xfer);
+			trace_call__spi_transfer_stop(msg, xfer);
 	}
 
 out:
-- 
2.53.0

