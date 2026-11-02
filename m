Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637246;
	b=zFYWp1vVB+rlh3CW/2OwEYuJ+y7Bf97jF8Q+PPw9OFCPQFVnnoYW/dqgzWybzTXikdDP
	 eNRInLyQa0B1I0V1SVScxJDFxdZtnpu9yPYMB3MQ0GcBbJmqe8bA1rQDi6GYwJH5OsIfK
	 56ZRZNMPPhkG3TCB355TapVVusoNqv6maOHxvU9Eeu8V3Ud0HNubLj+OJl8qi4SKbIy6N
	 laa8QhsMejaB+6tHuvrYsz+jN4ap/574W2BivZMT4NkMxrscEidh1V21Ruw28wMZJ86V1
	 hRR876PCZC/JjN3wTb8RteRAEAp+XlqoViF/rATBfKu4ToaIDUgRLnOzZoTYmvGUGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qAijlLa37HMffqXHRY7nYfoHxDbJWl7jmFT1F+WEeOY=;
	b=SwoF/XIvFCtVUZC7FBzOQla6b11ShHJSXUHbmV4bD9KikIeUQQmLse9PE+PE6Oa8pkS8
	 6iLmo1F4nFMkp2HTelZPZA+9Mi3JMIjkSt+F2jpN5+vxziw+i2l+E5Rp0YAaP3zqLqOxZ
	 3zqGKKpUnnjtrxKGTYWRTCjsHtWT/1QlfkatFuJrC2/D1H4htHC2OAuE87+ok60q/IjSZ
	 FlAhOHZo77belCoATDYi+Ja8UEy6puloBle8sMFcOwD/kGXFJQtOsq0DrqmKCoJDvqDoG
	 X1QQSEl46IT5DHTQk1lQPgWgpRmaHzM4Y/h0JIG63ug1FAXGN4zibu9HtxQ2c5dMcIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dpp/q5yy";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C34606A925
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C34606A925
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpp/q5yy
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1260484a12.0
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637245; x=1794242045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qAijlLa37HMffqXHRY7nYfoHxDbJWl7jmFT1F+WEeOY=;
        b=dpp/q5yyK7aHs7OIurhHB+BvWi2Rmmd4LjjiSB5huUGjkqrsElhjXoXqG1bY0FmHN8
         Irq3Cz1JZuoG314yfn7GdinLLxgVvaZc0JmBQd23pFVVrmW7aYqgvAXl9gHSyVIML1Ff
         jrsx+ch5hQZGtf1QmPFJRrY+Y4wum7cGud9BmkZ9DlXZQJcYrgJftEaE5HR26hviZtlG
         vHcTGo+C2nX0GoKWys1+eidOdo3OXBfs9xoXd6visochIGFThn0FDfb/72Ex/c0Z0CE+
         O0lGQBsLNQ47OJnj4HTeJMX+JUFaYtSeuc0Np5mjR0lq5bPk9t0taUtsszZwpweDt0cp
         rdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637245; x=1794242045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qAijlLa37HMffqXHRY7nYfoHxDbJWl7jmFT1F+WEeOY=;
        b=1pxD/ey/6oKH7NU0GYasNfhUskVHUI25017/c7fiAxCLQTVDuUa35e40OfTwDsZ/Va
         3EU0bSDo6BItJu7WciXZDUcggxOS7e1nvN9qG+iUd2vwxsrSprG+bUI6jCxO2MGLxJps
         5KAlgsJ7dw/xVITHxnLG+VsCX4KcmZBsj8I/d9Ro8XhA2y1Q53F0UV8G/XQJOPqYY2J3
         qfI+0YeSfkyoWjta9fOHQx+cZqNw/BX2sptILe5H4XnN2yTC1LrzuZbCu2P7JP8KBXk9
         jL+1fmqZ3VNetTyhl1L1XQDyohb/1wKmXIbcKR6oPItxXW/C+i9HwB38Lm/9NX7yw1KS
         hHnw==
X-Forwarded-Encrypted: i=1; AKwUvBwVUkviS7GXj8aG8LScvAsSPjVLyQFAzzUDjlFlkwG72Nfw6YKzzq6KeoKoshBkaTja3kmou7GQzPM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8FUbYqJ9w4RSn3uO/vDejyhBB2900HKeWP8+jOHDk5SRZP1SJ
	FN02+NMlQy+1W44fZ1dxx9hFgOFRgqOjN5gHYRkpsu6IKS0uXbeBOcpv
X-Gm-Gg: AYBFou1c+jNk7Og/YmD7H3PKr/rkHFhSSdIPGcK/8bTZR4FjkAZfDrOfXMWJvmG1RtQ
	Y2T+fprQpHAaiw4cPEVii20H1NIPNYfpL5mUZBlucC01GgzX+in5kfZjtKi5wV9YXaKS+qHAvrf
	naLFrWYbhypMm5LfbeGb9jOK/dNAOTdwBcHExew9euh9an2bxeB2qM7XJWLbb4ik8xxN07sQTDK
	XEzuBnq+QXu7mmDppSHBJ+mtbt9wQE5ytpVYRm2uGZXOIR0Jji2Ysa52YKEnKh01S6Unz4YFp/9
	VfrjqUcXLn8OUZS0zyj6U3kQ0mZbyznfRWruMVwL2eeUaxGPbwt567O6lui0CxV1TiKf0c55n86
	Ao1qb53JisdSdOlNV/1Qtivqk2fSNgIpIxHHSa5hFE7eLgYcr2qag0YJGPsPbxEOrE1aPW2xWkO
	ucmS+CMIFowlzaOkYvWU1XEB/Kp51A2xXeXk//LCZb8ypqNyLgM0FUEcgD+ZQqIxFZ6ro2MhheR
	yboJZCsl/4WL4QGDSp2no0vOVwWQqRCNoNa+W1FGXRKD4w8fUmf5X7QqQkypOxS49V+GYg2Eobj
	y21BCgNseXpcJzqp0DMsddg+iFGe8obvys4eMRljWlujOsByRhFVlaZwY9qdXLrPUqENZ64tjFW
	cRy2FgsGVQeUN37WU8sZ7HSumD+HNWGFKs3XzlhnvLkpB3r2PwDyL9Ri64fPu1B9eS1icfXJJrC
	il+78M+7C3M8kfvPLOjXBOMiYM4/ulMCmngDrdh730WyyhqgX+00A=
X-Received: by 2002:a05:6a20:7344:b0:3e2:b295:766e with SMTP id adf61e73a8af0-3e928a2a14cmr9394111637.54.1793637245211;
        Mon, 02 Nov 2026 08:34:05 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:34:04 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 12/14] spi: spi-mem: Add lock context annotations
Date: Mon,  2 Nov 2026 16:30:21 +0000
Message-ID: <20261102163023.2574632-13-jctchan@gmail.com>
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

Annotate spi_mem_access_start() with __cond_acquires() and
spi_mem_access_end() with __releases() for both bus_lock_mutex and
io_mutex in drivers/spi/spi-mem.c. Enable static context analysis to
track controller lock ownership across SPI memory operations without
false positive lock imbalance warnings.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b94680b60af9..f115ef6bf53b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -297,6 +297,8 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
 static int spi_mem_access_start(struct spi_mem *mem)
+	__cond_acquires(0, &mem->spi->controller->bus_lock_mutex)
+	__cond_acquires(0, &mem->spi->controller->io_mutex)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 
@@ -324,6 +326,8 @@ static int spi_mem_access_start(struct spi_mem *mem)
 }
 
 static void spi_mem_access_end(struct spi_mem *mem)
+	__releases(&mem->spi->controller->io_mutex)
+	__releases(&mem->spi->controller->bus_lock_mutex)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 
-- 
2.56.0.317.g454f8302e1-goog

