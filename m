Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637237;
	b=ILylxPXsKnNdVZ9vtGXDozWFz8i9bX4tuff8XzlAo8FDGl2k094YKEWigeNVJWbVfAbh
	 P8qlbGVqzXhHPPpWssR3zTZbZi0+rR03t90L8T/NZ0CZM65DeCY/tBt7NEhnyzonA4etF
	 mt82ndBAlxFbFvkRG/PnhOoti5ZkEA0yysbJI7p/eH+x6lhACgtlQab4mGniNTWwl7ThD
	 Re7cE+MWjGKPa9oK1eLg+/HEEUsnWwUogwTbX2M8djguLd/kvTJZK8ly7xZfEY4DRO6EE
	 6umPBrIwIKrHnzYaPMPaS16ix7EWncqpDgTqXc2HprmwOoPl8qNocqMNkwEyhlo1PUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MT60OsfGQSjD25J9g843wJQgS5ppstyzDI51QY6S+Ro=;
	b=Qe87np4kM3ZPSoPEvrrmfk0j2Mbd/Uy3r8BcbylWQI2l6wdIrBpZFqOFXYLVfv8ff2EW
	 g07+C1rzMYM2NgF+1AnGTudDPo9V3k4VGxipG/CEBRiZZ0Z/B60wqtyhz5eZ2/5KcZNOH
	 XLNyZlZzpt0yr2IBEU2lZaxCoKPmpXZIOt5mPkIMMUFlhWYLV2/lYqHtY4ksypR1EMCM+
	 N4y2Bm214qgk7f8ZbCgteXIpeICUS8qr3D4ZX/r3mjeKLqzqtVbJlxm1IckB7fGzJxcsI
	 3Bcy/T5F2GKisAayyPsH8cJ0ocr0TojfdHt3Dlw6Rh3DBmL/2Ir74MVE7vFfoHFbe1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qFgj9cUO;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578360A0CA5
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1578360A0CA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qFgj9cUO
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-89f639ba307so1147141b3a.3
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637236; x=1794242036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MT60OsfGQSjD25J9g843wJQgS5ppstyzDI51QY6S+Ro=;
        b=qFgj9cUOFxlE19oVKXkOJx3lHFJpqyzsU7vUeyVMGyiB4MG21iML24keRz7DgCbve4
         KMbgzp/DHdp3+8t0WfruLxv2mkGyezNFn/Je6UjrJh96uU/BDzivXrUZKVwo64bH8YVN
         rewSN64wZzjAr/VYTZWxFXk52bpRy3b9wQVcIgM7DFoASWs6xh/3Gwp5nTuYbSiuuW8a
         9K0aFMkCdb+e2EaBG6en/Cdih+Q6fS8sf7pOgWZi7L2BVwFIVrmt4oEvjJIee8FGezbo
         ijBBn2XBzgfWCtlkWPaj47DVUAlGqWfqlgN+eTDPVPUPd/PG7LK0Y/kpo3U7dYTv2BUT
         q6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637236; x=1794242036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MT60OsfGQSjD25J9g843wJQgS5ppstyzDI51QY6S+Ro=;
        b=fv16HdssK87XOSZ1bfmRw5ueXl1fJ65JeY4O0y5l4ZIJm6c/aTOiCCL7TBKddthEqY
         0lUBoVYy7bFVFSrXmu5Vmhj3OmMiOyXaO5A65wUrwKtUtge/Gr/kwogI34DSwN6BSxTG
         DFc5isBT+B6Wj2C4fkouy9rQPXiBIN9SU1TTbd107x3G02chuZB4WYsw2pTfhwS9qxyX
         2KyZGUTxwVosTnrz7zHIWwlThtLa57cxJPD9kbJkQj3rA4uYXFktcIvlh4HspsKOuB7D
         +6UOwxWcrlqeCu8KxbgOAZb5tk6HS1sifzonnsu5yXX3qidMekHjiD/9AWTencZ8we8o
         wJvQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3aZB6sG+Xoqbx7Lu50fJs8IwgP/cnbArNuhYeO5+aEbRpUjmmAQl3L4zN3WQHxtpiFZal3yWdBKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pws7zmvIqeN1aJqWQQuIzw2h0j6AUjbkrNwt5DMFpYbNd9mNb
	I0bDY9CLKV870MtpVjH2NUWz2Tcb1R6ZKBCQ/M8gmfo07fbeMrZkmqLnsqHbaDpYLAcX5m/z
X-Gm-Gg: AYBFou1laC1PVT10DsCCqJWCkdsmFXvjUhmA2J1P6sEzw1AJnpHNJZ9AK2Ph7DoUTkQ
	nwh0qsBuGpjmLafHBJbbifY+nt/qMeCaU3okRMOTeQi3yt3MmUFMBifnRO+KOpoyiqf5LPFf1B3
	pahol9MmlQQ1vpzmdDVTw6snOOO3DcuhBi73VtCLu/zMalHs2K1QP5Qt9nJl+pvL5FbVGn5Lcyi
	yHluWFzL1W5o3JDhhPV1ExejMhtcPf92YAehCD70uBnB6Iyo/fcQLt35F3YrzpUknV+wFNT85eO
	Hole/gdvbgnZEb3g1cg9f7FxQaQJKLkoNQrMK+Rg1KJmUJObwNwQ50vkMQprchI1Ys7PrbxIB8E
	GeUlasAawhc+4S/DbZMgzr2Fwyf3pPr5e6xO2dUgyTFJmVMirlxxm1dYTLdU1aHb00HMUybEsgp
	cOisggrWfKLrz6iPCUPSCyiER/R4Z9XidDoNVrldD1JanyTel8PPDAR50yXDSJm31qgx6ng+a0R
	CeQYObwErtMS4faYmB8NloJn2Jx5smfXEJI1QZt45zzG4vYO5v8vRt4GIv9jcRgI9I7Z88ewDU3
	uxw79ls0wK/vmXM9OFWLqWhYzNKY328bD1lh4cpcSZIfs0uic4ESk3TArw2Gd4gnL89IYchAEIj
	QZKLhBGSo89bONNVLF/d6wOAJYTyAchNum1flNUZ0wEVDNFRIdHwgT1n9lrrzaMtTTDr6spHBrO
	c1iwuRPL9IG7TIV9NlJB2FHAfc4ad2Yw==
X-Received: by 2002:a05:6a00:ab05:b0:89e:8915:24a2 with SMTP id d2e1a72fcca58-8a9be965b90mr8917391b3a.29.1793637236269;
        Mon, 02 Nov 2026 08:33:56 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:55 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 06/14] spi: spi-mux: pass child CS and word delays to the parent
Date: Mon,  2 Nov 2026 16:30:15 +0000
Message-ID: <20261102163023.2574632-7-jctchan@gmail.com>
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

spi_mux_select() copies only max_speed_hz, mode and bits_per_word from
the child to the spi-mux device on the parent controller. The child's
cs_setup, cs_hold, cs_inactive and word_delay are never passed on, so
the parent controller uses the spi-mux device's own delays (usually
zero) for every child. A child that needs a CS setup time or a delay
between words, for example from spi-cs-setup-delay-ns in its device
tree node, does not get it when it sits behind a mux.

Save the spi-mux device's own delays at probe time, and when switching
to a child, merge them with the child's in a new helper,
spi_mux_merge_cs_delay(): use the longer CS delay of the two, so that
the needs of the mux and of the child are both met; on a tie the
spi-mux delay is kept. A delay given in SCK cycles cannot be converted
to time without a transfer, so it cannot be compared: a child delay in
SCK cycles is used when the spi-mux delay is zero, and otherwise the
spi-mux delay is kept and a warning is printed once. If only the
spi-mux delay is in SCK cycles, it is kept without a warning; device
tree only gives delays in ns or us, so this case does not come from
DT. The child's word_delay is used when it is set, else the spi-mux
device's own. The delays are written before spi_setup() on the parent,
so they reach both set_cs_timing() and the software CS delays in
spi_set_cs().

spi_mux_select() overwrites the delays of the spi-mux device, so put
its own delays back when the driver unbinds. Otherwise a later probe
would save the last child's merged delays as the spi-mux device's own.

Unlike a device directly on a controller, whose CS delays are read on
every message, the delays are now copied when the mux switches to the
child or after the child calls spi_setup(). A child that changes its
delays must call spi_setup() for the change to take effect.

This depends on patch 3 of this series ("spi: spi-mux: re-apply
settings after child calls spi_setup()"), which makes the copy happen
again after the child calls spi_setup().

Tested with KUnit (spi_mux: spi_mux_cs_delay_test and
spi_mux_settings_lifecycle_test, added later in this series) on ARCH=um;
they fail without this patch. Builds with W=1 on x86_64. Not tested on
hardware.

Assisted-by: Claude, Gemini
Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Fixes: 8c33ebfeeb59 ("spi: move cs spi_delay to spi_device")
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 0e770137b5bb..45d8920727e0 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -34,6 +34,10 @@
  * @child_msg_dev:	Used to store the spi_device pointer to the child
  * @mux:		mux_control structure used to provide chip selects for
  *			downstream spi devices
+ * @mux_cs_setup:	CS setup delay of the spi-mux device itself
+ * @mux_cs_hold:	CS hold delay of the spi-mux device itself
+ * @mux_cs_inactive:	CS inactive delay of the spi-mux device itself
+ * @mux_word_delay:	word delay of the spi-mux device itself
  */
 struct spi_mux_priv {
 	struct spi_device	*spi;
@@ -43,8 +47,55 @@ struct spi_mux_priv {
 	void			*child_msg_context;
 	struct spi_device	*child_msg_dev;
 	struct mux_control	*mux;
+
+	struct spi_delay	mux_cs_setup;
+	struct spi_delay	mux_cs_hold;
+	struct spi_delay	mux_cs_inactive;
+	struct spi_delay	mux_word_delay;
 };
 
+/*
+ * Pick the CS delay for the parent from the spi-mux device's own delay and
+ * the child's: the longer of the two, so that both are honored; on a tie the
+ * spi-mux delay is kept. A delay in SCK cycles cannot be converted to time
+ * without a transfer, so it cannot be compared:
+ * - a child delay in SCK cycles is used when the spi-mux delay is zero;
+ *   otherwise the spi-mux delay is kept and a warning is printed once;
+ * - if only the spi-mux delay is in SCK cycles, it is kept. Device tree
+ *   only gives delays in ns or us, so this case does not come from DT.
+ */
+static void spi_mux_merge_cs_delay(struct spi_mux_priv *priv,
+				   struct spi_delay *dst,
+				   struct spi_delay *mux,
+				   struct spi_delay *child)
+{
+	int mux_ns, child_ns;
+
+	if (!child->value) {
+		*dst = *mux;
+		return;
+	}
+
+	mux_ns = spi_delay_to_ns(mux, NULL);
+	child_ns = spi_delay_to_ns(child, NULL);
+
+	if (mux_ns >= 0 && child_ns >= 0) {
+		*dst = child_ns > mux_ns ? *child : *mux;
+		return;
+	}
+
+	if (child_ns < 0) {
+		if (!mux->value) {
+			*dst = *child;
+			return;
+		}
+		dev_warn_once(&priv->spi->dev,
+			      "child CS delay in SCK cycles ignored, using the mux delay\n");
+	}
+
+	*dst = *mux;
+}
+
 /* should not get called when the parent controller is doing a transfer */
 static int spi_mux_select(struct spi_device *spi)
 {
@@ -65,6 +116,14 @@ static int spi_mux_select(struct spi_device *spi)
 	priv->spi->max_speed_hz = spi->max_speed_hz;
 	priv->spi->mode = spi->mode;
 	priv->spi->bits_per_word = spi->bits_per_word;
+	spi_mux_merge_cs_delay(priv, &priv->spi->cs_setup, &priv->mux_cs_setup,
+			       &spi->cs_setup);
+	spi_mux_merge_cs_delay(priv, &priv->spi->cs_hold, &priv->mux_cs_hold,
+			       &spi->cs_hold);
+	spi_mux_merge_cs_delay(priv, &priv->spi->cs_inactive,
+			       &priv->mux_cs_inactive, &spi->cs_inactive);
+	priv->spi->word_delay = spi->word_delay.value ? spi->word_delay :
+							 priv->mux_word_delay;
 
 	ret = spi_setup(priv->spi);
 	if (ret) {
@@ -156,10 +215,26 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	return 0;
 }
 
+/*
+ * spi_mux_select() overwrites the delays of the spi-mux device with the
+ * merged ones. Put its own delays back when the driver unbinds, so that a
+ * later probe does not take the last child's delays as its own.
+ */
+static void spi_mux_restore_delays(void *data)
+{
+	struct spi_mux_priv *priv = data;
+
+	priv->spi->cs_setup = priv->mux_cs_setup;
+	priv->spi->cs_hold = priv->mux_cs_hold;
+	priv->spi->cs_inactive = priv->mux_cs_inactive;
+	priv->spi->word_delay = priv->mux_word_delay;
+}
+
 static int spi_mux_probe(struct spi_device *spi)
 {
 	struct spi_controller *ctlr;
 	struct spi_mux_priv *priv;
+	int ret;
 
 	ctlr = devm_spi_alloc_host(&spi->dev, sizeof(*priv));
 	if (!ctlr)
@@ -168,6 +243,14 @@ static int spi_mux_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctlr);
 	priv = spi_controller_get_devdata(ctlr);
 	priv->spi = spi;
+	priv->mux_cs_setup = spi->cs_setup;
+	priv->mux_cs_hold = spi->cs_hold;
+	priv->mux_cs_inactive = spi->cs_inactive;
+	priv->mux_word_delay = spi->word_delay;
+
+	ret = devm_add_action_or_reset(&spi->dev, spi_mux_restore_delays, priv);
+	if (ret)
+		return ret;
 
 	/*
 	 * Increase lockdep class as these lock are taken while the parent bus
-- 
2.56.0.317.g454f8302e1-goog

