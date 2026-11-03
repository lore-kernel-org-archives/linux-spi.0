Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746416;
	b=1ahwssrsub5Lv1qQInpoeNHPxUKGQ0L8sam8QhGJRIBUpFhkv33JZAm8K4L2UiVT4NAE
	 DSjao04UKNcamboFNpywyOVD4sC0+lcE/AR2G4gQMCq6PFLSkjnEU9lOUjKIsH1tSOV/o
	 +cFUoaNEM2N3Wdn2Kms3reSjcwKGShintoR+gWkGPkJJX1cDdYGVdTzITiFlZNV+xXTIY
	 vKV2VHEmx4HMPz/T1N0qXk+T4wNJfFd5z7ZR58JVz4jCabWw1ztt7zsSgZjwr5E1G43dq
	 LPLgfKEe0MZ7tYBZtVaGfw1usm/dMEQ9JWpzz2T4+XPzy3J5deyojgCoSkCu6U8KzWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
	b=a0l4/uh8SQwhIMUb0xAV9zlJ6PqyKoXSt0WUaeiEHKCE/poxSqL3reJJM1DNLr9GFC2q
	 V95MW/F8lnnlYaR5E3gaQJIPWWbamq/M0KMebXre3INkgHtQlKtPCBNb51GjBzuJnbHo+
	 dbr76waAHK/Y37wbwtZ9zSfuiM+plvDspuuW7awqRoStXRDyvW9MLd6h5P4FWvdbVO7b9
	 bdUGRfVHzQX1FEA3bv0eRxRBL1zBHoBJiRVXs4k7X1uf1yTBzBMdfT15UFYU2gtoqBwJz
	 HjQ7HUB2iHypZ5QzYFjIE8zSWA+f8TjAieLPYoQywu/Sj+SiBcF5af/Jf89jwnh/3rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHGKp09H;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683A606A32F
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E683A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHGKp09H
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e946155442so453825ad.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746415; x=1794351215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
        b=GHGKp09HKB+1avkemVAzp96e2ezvezM6SjbvPwIV3KBZhK2wNgjDcbhc+LP3ehYzt/
         nS6L0yz3E5rEprRbiEmc1QYT1hjnxOJCwq3/o0bM1hsHEANCGyIjqR1BdtvG4gcP8bpA
         3Z98DW3coGq+xNQW1d8pYNgThAC3YLjGiATRGzjbkWsqZIVhPYZizOexkRokQ1ESs3N+
         +HDdup2tg4/sKRCKc7zbO4u72KrHTi0MCShfUgZSjcx+dhwb3sPTOY8a1VI0mC1G3Ku6
         PH3Y7yrYeTiB98CnJXxxmCfdVJDFb7EDZqWvdEtBLp5PyCILwLooxssV7upZ8a/z6G0s
         ODJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746415; x=1794351215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ELQT8PeElS2CLCx+BMjW8wK6GMbuf7QpxZNV1+LRRek=;
        b=KXR3q0etELKTe1pD0mDGFBv8SkxsWHMqyLGn0r2xxe4pvU3lrcaIXtv5zRiXOa6zCZ
         KyPJHJN67I7GlzO0lbbD9qYwuaO+nsniecqcmXhglYgejS1+G0tqxW7EcFzxaGSn3uUN
         65SQzdS9oQzOc56gWu4ARL3XNOz4GVV+ZtW3K2nuWk25QKqSund6vS2PyMPp947Iu8Hi
         V3ibIBrrHjGQpty+yP9QpLc18Ek1+7qtDR4rBMBqeW6XoA+a58SxjpBiDN/nddDOtEs1
         UOHJb5iwARzcHliWt/vn0tdMMl6ADEzqvYpx/doJwVmXnfEGRXMsE3mC2RSfJGX4WqtW
         HtGg==
X-Gm-Message-State: APuU4Z++Z6sFuMRO+1L0D4Z/EYHs7/XfkYqvDx73hewbtSyOmMIFxhMf
	e8V+9f/SvFrC0KigzrR/QLmJX2eOVn0Z29yUi7SRXrRjqdMt8eae7Eu+
X-Gm-Gg: AYBFou2ZVyu8vnsOs0yoD+a/RW87KOh0aTw1lJfUYkvJD7ke+MYGq69lvGYYvd1H2uF
	dr08YdWcRtamdk+eod3I7t0xmOfXiw8FKm3WCbm4k6dBNNG9OSoCw3MKzr7czJv8vUIULm4mF9O
	6jcNnb6BU5AidkackNJQLrboX5s7kNmh4TJMDC0WHMKJwkVj4dFOa1RHJcFWyDRKPzsH0Sfp89Q
	JUgiwxJo7QwynxbKd/SjnS6xdGzxpcHXwtGid/IwmKeuYYaqzW5ohEMS91E/t4Ocs9PgoxtAaki
	Ox5jcNZPf/IDbgU3zGOxitnlgNwVYc3p7jx/A7RGTSkyHisaEt53A96GhzlvDg4OVMP2Hf7ogMr
	ZWgate1nRkfdkAQp+AqHfDpT1VkHmm9lmEYworfS0KgTcrK3h0ebJdp0FyYxaVBMQfXgX9P7D3N
	ugeOzmbZvmohsv/P1ECcwVE5kSqiNBNfxP/meiUMiNzKxR7A0b8hYodP5lxgkvmngUvSxilr/A3
	R641GMOErvep4tYHGV5wJInmoo2TglArR9df+3Ua/k0sY0aUaNYq5yLxHyzLyJZbJMxhQIo2VLP
	+8vGxs1/1l4Pf8+FiP1wPUv8idlde5JBy9z5uTuwNiv5Kzp8qjN+/kq/25zXiXUshbhUxML0ArE
	3lN90V7zK2d2IZ6q+86orN/fq88i8Hg/EQ8X7k6IJMNNZP/Qjp8PT4KvVlqjAnhkFGP7yzyDq48
	7e0IZesi86wNIm3o95M1xTSseFbikZRwWQrGAvw905ag4hRbvAK8KJKHqa6S5K3djl//bzWz/Hn
	/Ekkn3mXX3Ws4Q=
X-Received: by 2002:a17:90b:3e81:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3ae8982ab40mr12229687a91.34.1793746415281;
        Tue, 03 Nov 2026 14:53:35 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:34 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] spi: spi-mux: finalize message when forwarding fails
Date: Tue,  3 Nov 2026 22:53:06 +0000
Message-ID: <20261103225308.3633046-4-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103225308.3633046-1-jctchan@gmail.com>
References: <20261103225308.3633046-1-jctchan@gmail.com>
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
nothing to restore yet and, with patch 1 of this series ("spi: spi-mux:
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

This depends on "spi: unoptimize message when queuing it fails", which
is in a separate SPI core series: spi_async() on the parent optimizes
the message for the parent, and without that patch a failed spi_async()
leaves it in that state when it is handed back to the child.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; before this patch they time out with the message
never finalized. Builds with W=1 on x86_64. Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Updated the patch references in the commit message after the split.

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
2.56.0.385.gac671c819a-goog

