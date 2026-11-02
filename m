Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637234;
	b=A0G6ieMgJJlyz6UOfeCx9Wi/lZB5L4r1m20KqjbnC3cHi0ayCFabhmvghTFnkcy9PH7q
	 WlET8plquCwBOQ72ZAbafeVXY4VfowXbAy5/oFDvZKcCy+f0sYmt6WIi29nygRmZZ8EF8
	 fLfX9+81gTl5Y6u9zSWXD5rfDwoZbEPibOhW/PBdmCLmyz63FhXSiz73qrsSzZJ+kNZ3Q
	 cr1qe57MW5C2Q2quWlb86vO2mYZWI7tzKUe6UlskdeM5r7Trb9grjGEYZeEk4vq7V+B7c
	 /43cIPXFT8uJKYVSy4wvjv5wO+AhhUEMNYM9JhtmIpvtCof+vgv/B+lL1gFQkQyHMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
	b=RxIjwQHz4/vzFW5vKwaYwJ24w16H8ywCYFrdUT6YINz7An8BT9s18p85OGI8tfcvjvSV
	 rSHPtdirftCpWmiH9mV1eVUub0tnPNKx7oACHX+qVX3y23pwFIg4D77Wnqt0dQD/q0gbM
	 1ryRyWdQf2HA1rrz1SBOHFpoSNHe2oERKWm4NKHd766kAhWW6yBcjBd9yR2o0BwGdC2Lh
	 QmOdnT3bHbWZRaiZoAwNUF4Uh1qYc4VtBsJ4J5YQTjiBopR1B4UNBirEwBxxo5G7HTqHd
	 aCCb4cn3Qc0D/nfEvL9ApAdYPmgHuFZPlVOYx0BoLFzSX+PL7ykCnXwtNMEZDu0xkTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrvaC8PV;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820A608B068
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6820A608B068
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrvaC8PV
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso2166335b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637234; x=1794242034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
        b=JrvaC8PV3yKZNIM7YzvffeBEM1S7IiL6Ll1G+tV8UOL9CjYBI7FQYGbPXUV7+bRdZ4
         TTXSFKBmuXgHw0r9HQJ7eCjdUqPXgiWXBoL4VTBMiykDJfLYdGCZlBGbe6LYUxg8BI/j
         zryPaqQMOKW/beJVrVtLflaYtEqOuO8RR8yeUpOOb6m17kz04bGo6YBp+spKAsjPbzqi
         0vmm2tz8MNWHB408s72/R/3YXQ7qFXHZfIiln7TBW0kTGS3WXMe+zIbn/1Xwc6wi6GRZ
         gqzApzEFuF1ljcjodFItDZNUYXydMJePxUJFWS10F7SYnOf4mNNqkNdRpXLFhWUr2+zc
         kLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637234; x=1794242034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
        b=fISImZTQYywhQbgZWj7BVG6WSiJhlQiVJl0VNHa7cBMbf7ZXvFRIusX/7J4iHx9u4u
         pwtwwOiEPv18hQru5/MLcPs2FT/oCxforesOw81Xx7rqP39wkY3fnCr8ZPvuBODw3Cm2
         K3/uYmwirOCdvGR2B36H/pt7tKKKwue/7juJXezQcrGbvZdkabo7YgykvVs3dfml+CxO
         sfP9YEaLlkYMbCuTdHbWq1FSR4H9BAw76uVPKBigd2ZMmJyB2REjkAGwHcrD8SqJg2zE
         eGKLN4E1GcyVFk7/Ghq2RNg7fFFzIBwU6wtUZYDqO6HsKuUY1/S2prDingehsPTKted0
         GmHg==
X-Forwarded-Encrypted: i=1; AKwUvBzHN3QvmfxlzJCeqKvD+YzmzSd5WkQ1m5uqlLRiOFKRxsnxiwpsMjvVtypwUOw0VP1TDz2ybzBwvOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/aMuKkSxlyOSqvXPi6fn95jMT0yPKKCSFN3Tnq1Z2AoMrbaY9
	MidKwaONTgPtCHbn4C6oBVQOrODSdABFXHGQl6K9CYgkZm3ynMjNxeB8
X-Gm-Gg: AYBFou2AM2btQP38GyEuFb1E/rzpfOIo70qpUAXwg6KCK1pgyNquTHRE0wqmg9C5eAJ
	MK/JuT2jM0MaPgnmvOm67AaTH600hWhOrji5chvLLD01qND6yyGrWhWd9djViF/sjdbFFADnkbi
	cArblGQJaL0nlqimgDwEQWnC748n4Kma3VXEuciXoqDWrvw8PpE6NQzNW9+GUp0AD3cM3vJtWaY
	QDZqlWtNfVwPF6XBTPDMMBNGsLCyjSjmMPQ4UWCpSRQosdxKfvlnglUgpviy48We82GUHM5Gkbg
	TuEySrT0HvIuHwgK5d4mghYAWieo8u+0jWoULq5BsUFbPdDZ756qUucJEzWt++QHpBGbqYnZcLE
	m2sNZfc0hkgbiaumHjPa8BKHiYr69/ZWb/BHtiGRBNeUIlyXOd1U2DRPxLEO8LEcqkcYo0hzeau
	jTLlv6S8G147qqiFQEqMpr3ImIGbrgy+I9eYQdcQ7m9mRSsWEZo7Yq3FNQJcQw9q2rcyzReLJbC
	rT8NLG0Z1brBDrxBXoPueTZZN6NQXIMKW2Ldw7TJOYDUZUf4cDMT8zlUhVSfJx/KZdqu8R4OX7M
	11xancRsq9HO9mT0gddZFPmC9bdBs89ysW0taZAGeQ6795DUwwmm0iMmEwWo8AMJAg4gIkMBTb0
	8oKnbwW/vK3dmOJdNw5VxxIvWMPhfe3K9QTqsUZOQAi7kcu0cMHO7FFWxzwc02RUVKCYD2B9O12
	G3rmoPgoUR+m5iEmkxJaSoJXnVnGmgrg==
X-Received: by 2002:a05:6a21:a96:b0:3e1:370e:f233 with SMTP id adf61e73a8af0-3e928abd43dmr9176791637.69.1793637233860;
        Mon, 02 Nov 2026 08:33:53 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:53 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/14] spi: spi-mux: finalize message when forwarding fails
Date: Mon,  2 Nov 2026 16:30:13 +0000
Message-ID: <20261102163023.2574632-5-jctchan@gmail.com>
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

spi_mux_transfer_one_message() forwards a child's message to the parent
controller. When spi_mux_select() or spi_async() on the parent fails,
it returns the error without finalizing the message. The SPI core then
logs "failed to transfer one message from queue" and does not finalize
it either, so the child's completion callback never runs and spi_sync()
on the child waits forever. After a spi_async() failure the mux also
stays locked, so the next message on any child of the mux blocks the
spi-mux message pump in mux_control_select(), and the message keeps the
spi-mux device and callback in place of the child's.

This is easy to hit: spi_async() on the parent returns -EBUSY whenever
another device on the parent bus holds spi_bus_lock(), which mmc_spi
does for every request. It also returns an error when the parent
rejects the message, for example a transfer with 16-bit words and an
odd length, which spi-mux does not validate because it defers message
optimization to the parent.

On select failure, set the message status and finalize it; there is
nothing to restore yet and, with patch 2 of this series ("spi: spi-mux:
release mux when parent setup fails"), spi_mux_select() has already
released the mux. On spi_async() failure, set the status and call
spi_mux_complete_cb(), which restores the child's pointers, finalizes
the message and releases the mux, in the same order as a successful
transfer. In both cases return 0: the message is already finalized
with m->status set, so the error reaches the caller through the
message, and the core does not wait for it. Returning the error would
only make the core log "failed to transfer one message from queue"
once per -EBUSY while another device holds the bus lock.

Behavior change: a device behind spi-mux now gets -EBUSY while another
device holds spi_bus_lock() on the parent, instead of hanging. A device
wired directly to the parent would instead wait in spi_sync(), because
spi_sync() takes the bus_lock_mutex that spi_bus_lock() holds
(drivers/spi/spi.c spi_sync() and spi_bus_lock()); spi-mux forwards
with spi_async(), which returns -EBUSY while the bus is locked. Making
spi-mux wait for the bus lock needs a core helper and is left for a
follow-up.

This depends on patch 1 of this series ("spi: unoptimize message when
queuing it fails"): spi_async() on the parent optimizes the message
for the parent, and without patch 1 a failed spi_async() leaves it in
that state when it is handed back to the child.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; before this patch they time out with the message
never finalized. Builds with W=1 on x86_64. Not tested on hardware.

Assisted-by: Claude, Gemini
Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index a7ea6585b374..0e770137b5bb 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -117,8 +117,12 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	int ret;
 
 	ret = spi_mux_select(spi);
-	if (ret)
-		return ret;
+	if (ret) {
+		/* spi_mux_select() released the mux on failure */
+		m->status = ret;
+		spi_finalize_current_message(ctlr);
+		return 0;
+	}
 
 	/*
 	 * Replace the complete callback, context and spi_device with our own
@@ -133,7 +137,23 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	m->spi = priv->spi;
 
 	/* do the transfer */
-	return spi_async(priv->spi, m);
+	ret = spi_async(priv->spi, m);
+	if (ret) {
+		/*
+		 * The parent did not take the message, so it will not call
+		 * spi_mux_complete_cb(). Call it here to restore the child's
+		 * pointers, finalize the message and release the mux.
+		 */
+		m->status = ret;
+		spi_mux_complete_cb(priv);
+	}
+
+	/*
+	 * On error the message is already finalized with m->status set, so
+	 * the error reaches the caller; returning it would only make the core
+	 * log it once more.
+	 */
+	return 0;
 }
 
 static int spi_mux_probe(struct spi_device *spi)
-- 
2.56.0.317.g454f8302e1-goog

