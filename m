Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746549;
	b=x4zyZkW3wYYwlasePA+C/MwzLF+y9HcXmBM/BIgS1I5UobZpzmIoCnJFTjtJLru0AhSi
	 B8evcAfZyR+wpuj2VcZkdbrxvJCfz6oqkunXSTbsqxwwCew6JztZrR4gyUsM9+ZZUPxNb
	 Fx/xf6M8etPUOL42Eg7+vhQmFjlp+iJ/lyho/XIQvvnv+QjrZCMZQ3r/hFySSpnv2OwKk
	 kAN54poq5juEQgX/gCeCrriPCo3VqPy2hLxgtb2dLEISsG1TEPALk3zJZLwlrb9zbqHkM
	 4wPLJDBlcFqm+wlvJI69kXAQ4xh7MkE7irermQEQiiKB22awZESw7qralzbKDFY1KqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gpT5lQ6dNlkLqYuyqv1dJpFV1XqL12FmHoo5lKvfcMI=;
	b=gzUrgB6Tr8VZ6Hd3NsLjMTyl6xGrwLtai8REzJPjsNkTGi0gMw5spIwxWKoJuURhtx3E
	 l9IFwI0h4wuEChNg7PM4FiK0Hzbm5Ht7NT8+dwQ1iIiGJoaD64li54k20hWJpFtkdCx5c
	 eZQoFHn4h9IJDYjGNLfVYfNsmulEcg9vq9sIDw6SJv34OTicETerIGiWJLLeyq5mrpktF
	 t+AkNeEweHat+5NchyH6t+O441H/dHvE1vM0z50CijmoOIXDhERV0KE4+cmLkmMJYYsp/
	 gpUPXDG5H+eboEvLNU1MUeTpDNlifUCAgLZD8tgGcpvadCUbRRyQIN65pTBFz5T68IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SSdeG/R9";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D53606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2D53606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SSdeG/R9
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so115848b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746548; x=1794351348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpT5lQ6dNlkLqYuyqv1dJpFV1XqL12FmHoo5lKvfcMI=;
        b=SSdeG/R91QDdK4B8lVjuCRzYC72qJKGsqtn4tqYMBYHu4cB9vxnL+Fu+32MisK5Yz/
         CGHkJngzgptLWvjUq3E+pUClaulB2VPk/cErt0fNRpvK4iIhJdCnZ+LgNPhgSPBo1IKa
         LKOtbONYHXZWE6QczEa9IJ+ni1FZ26tF4vR9T7JEHzcYiDOkJzI/M6qnyFhOCIQ6z7kd
         V5HapuDrWXGnKPm5cnyYQHz9j24sjrYa11I5fv6WlLC6ldWm7zr29lmO5/90JgFoOlUK
         tVZA7zj6AKLkC386UbsbGWSb/yQEfkVFaUdCaUJr8qIGiN5v+iKDd5ImTZyNKfcZLCxB
         Jy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746548; x=1794351348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpT5lQ6dNlkLqYuyqv1dJpFV1XqL12FmHoo5lKvfcMI=;
        b=cAfBX4VYglpbVBMeI/shezL2FSkDVngLj4Bkyt3IhGMJ16APFPgBOR9zIel7q2wifB
         OGyCv0YaCZn6qdoVOl/rXs+SdhWKRdwctnfW7mKw+h0whLqx/0oZgK4VvJWTvWvUTOTu
         HYNDaCmAl5GpUvf5kfMhYUN3YHN7D99pKpjWSUi8YacZFUHAwlLw/ZBgN+yK91KaJlxg
         sJFdvQQ8j5uGINREwfz6+7m98FfidxejLNXxlYryLGm5xcwCJXPPAB4yB5LL3i1adZmq
         MC7cBxY4KWzzJdxwi5XhouMzU7uTAWROow0rzRQh4vv2dVDYBx0rLs9LISqoSO0UpQi0
         pL4g==
X-Gm-Message-State: APuU4Z9KXm5vZkscdCCl7VHgjJM5HptzRTm1QFCXqEQ5o0/jnKzKj6wC
	Whm8zARmMbJBoARdW9ZWxZA2pWY9v4ITr2BK4c5a57Q/eDZbXFFfHp29
X-Gm-Gg: AYBFou3wneVm6FJAsC3DXNvntqQgnr3pHnD41IXfG6ejXPSsv+mes2sEc3gVvQq+9Hg
	lUOMDoJ8JSAYr7JwQKGrhXazdMfQE+/9MYJaNEwGQsOkjYLaP6wp6i1HxSGVu1M7q0rBLc3n/5g
	Za5ZYUCsrAHXcc8yU+BCiMmdxkWExvU1UHRFQVurzex0UebX2Vtrjul8GBSPk84rWOG9BDMT2AF
	j0+o78fPhWITDFgNvt/lwNsYh/mJJLKoGKsFcn4n6JqP0lfZsH2czWX3LpDZbiL4gwd7NvPeWaw
	PY8Sflny0Ia8G8nS1ibPM5aH8M1dnzDr6JFVE6SYPh0LtSDOgqn2X+HzYQrKtTfFUz6BDNGrrxN
	Q0j7gwfzakc5+yYrSLQc6UYIDTYmW9pGW+tSVXPW36PBntRHjiNH8y6ZMR+XHIUY5V6hsrYCgaF
	QbP7HHWWiX9pg09r4w3c86mApqOQwbp0mNS8P0SmmmEMupK52sk0BwM0Kwrwt5ZS+ZqnSKyg/5l
	eeGvX682WwxqcQ12dZX33mgv9F5jgPLfpLjJfZmNi7vxWkqUyEMn9HMjA0e0igHlBYm9RQ0qVp/
	GyNcTY9sjvg/8DUtpgmvy1mInkhrUbU+22lW34wuz715h4ILYQL9mFL4Zrqenl6fHw/dB4j1S4E
	1KT5w3gHIIlprxXyFdsj7oBkD0I3Gzj7IlsbWKhICFwy9NB4freIK07CWrsmLJhAC2LxdSTmuaV
	yptbgppzY7elxlERZAw8SpiUwM2NZ6hki14wziMsZpagZOSmJwRAkOT7gZpTCKQOGCuyKv
X-Received: by 2002:a05:6a21:e0a7:b0:3e2:97d7:bf2e with SMTP id adf61e73a8af0-3e928ccea08mr13543078637.29.1793746547968;
        Tue, 03 Nov 2026 14:55:47 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb467f6668sm272976a12.8.2026.11.03.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:55:47 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 2/5] spi: Add lock context annotations for bus_lock_mutex
Date: Tue,  3 Nov 2026 22:55:19 +0000
Message-ID: <20261103225522.3643901-3-jctchan@gmail.com>
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
2.56.0.385.gac671c819a-goog

