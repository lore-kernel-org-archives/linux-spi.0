Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746417;
	b=F9WHRTOKawKRWNTpWa+lS64+Ey3bWLWYYjtw5KyUvccOV4MZP6br+lvEM9+S4vCowL2o
	 cFeBONOagEAk8APsFYN0LrfEYZkT7pqn0LssOjKJTDuNmEjXgRv8hoaNYilHufaYPeDxW
	 5XE3HG1lVKhF49iDeanbdtCqaEOOuA0jEacs0CSUtEpV17uyjyYjm48wbslScLCqLJRsA
	 x81YvHAfirvX2JK9YdkaXbGMIr4vEn46O/vCWfap08FrqNVlTEOGVGm8qhy7aSOwkq0pJ
	 sod3+Epo73q9TjUYYA7EWgGRDeHXfbr7bam/3P1sezZ95lbSIBKUlFtLas8sKJer2Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jpps8381ifkzHksnTUTwn2ddeN/eubgHj6TnTnbvjn4=;
	b=ig70xWEyewgIyJW6ihCmhv7O0XZNTksOhVEPGVhgqMJixp4mFQLMKIDciu2ljlgylfsp
	 O1W7t/A93Fw2mcEcQBLp0Oc7XtoZGIrd+AQDfQOeRk0YUtNvJHYcUQO1qCYsgQCHHcytf
	 SMTKc0GE7JKCsGuf4wL4Adeu6VM29IaHS28H4RYjmXHhf6WNCjrSHdymkHLO2aRzEbLy1
	 0r5dCWyqhvCoeHbXa/JBJWWA3uUaUqeJrfxnGJxmZttNJZfEE+/9yF5XUjRnuIK1SLCS4
	 4A1tlARDB2mUWa9TIN7XdsZOu+UrIVZC1v01irND0HQIDPGvgFyaWn92Lc4AUtWZ/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfHF9I0j;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB596606A328
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB596606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lfHF9I0j
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so135788a91.2
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746416; x=1794351216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jpps8381ifkzHksnTUTwn2ddeN/eubgHj6TnTnbvjn4=;
        b=lfHF9I0jerfdlC+KQiRmARRYB/Im7ZyKQF1nttDlfx2dT4jZpERuk1+Ew8WcT0G+0t
         RkYi7ei4BWRAYJ1gJq0Y2C1HHAgF43wnSzRYGZNJZmb5f8qENeaxIyHqq3jL5ogM/iAJ
         xGGs9UTifZ/+fn9q32ezIr+nD1P1dsfBwP1C8EsQQunPHgYj5EbowXRC++u82p09oqNe
         /N4cIIEaixhTqR26IjSQdNXWzTwydNBxQyH/j5wzxaMItmyWMZBlg9HFMFv40qv9H8dd
         cILOusOZo1hJQTX3h74b30sFN5HD7x8jTmgQgu4FPsmn1/VpE6bMdMA1IOkopu+DTqqv
         uifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746416; x=1794351216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jpps8381ifkzHksnTUTwn2ddeN/eubgHj6TnTnbvjn4=;
        b=pGW3uWjG91Ps0Y3g2tVbnV2v0BlWs/d565l5hX2YS1M+K1v/3+9vCrYFZZrtExHLI3
         EDR6tgEt5A9hEa8FbPseAY3bV0godhIMjCZzaEoFcRgavjuH1hbP2c+unq1KYqYceyLi
         iFWpdAip5GbB0WV9ZiIkxbKyJwElmLCRQryB4dWLWW/cLWQ7EE9+uWNoZWPDVdN6ejUx
         i0dpwvAWl2K3hmawMUtpOZEOcLahulxO2uQfcMatQ4/cv3YTkCcqyPPTwPprvVP0zg3W
         gGeBqgc//m01ds2F7lrYMiOJcZLuMSDehWKBrZMVh6yVPpsh6Im2ddpUaKVssQx2Y00G
         tO0A==
X-Gm-Message-State: APuU4Z8he2lSRV+x+GunCLzXI+SRSqVqhqc9+9mBU28nqXg45Aci/YXC
	OcCB5vkZxvl1pX89OpIMLStqXCfw/xHe/Q2rQzJ7hpm6gDOqbM6Af14D
X-Gm-Gg: AYBFou2Z8tp8xXqFVA7veX3xQLI0SPwijfX6zcW+6MiprngTMV+QuSAX7dvs1zcEaXA
	fBBASDyBI7EcrGTwYqSfLy8cZtNBOIYQlEkgHWuSYh5HalyPnwDGKXk6pWcPHNi0tW3CT/GOVct
	urTLzTcuu2qAmG/CtyI4qUV7kRgwsB6gXF2ph3ZkRkrlZpDFkkQmCLiGgT4MrmnMojaqw5JJdjy
	qybNgPl6IfOobblTWNfZBG3B2nxWduDWy+gGP3sTViO4QfKvCyybqxjJt440LMY8QGKcrcdT5BM
	b2no6BmHwerGBggn4NefayiI3zg42Xg+Y9HrszCnJZq9yRfNwQ2OQnIGHmaLIQpUFjWXkZqlZQB
	NEiwKeaA5yfdOSLWIIuvHr2VZaaeihuD26/oAuqUfrRC1rzKT3+FZpa4RmcQcT5IzlgfMvfO0+e
	DshEcFfTbbAUQO/Q+GxYtepTuQ2XIhhpZUIcLqEWgLlubdqa4fU8xMZUR0jbN28Yjd2j5ynepth
	EGtaa1u+0GVQtP9JeGXjBh5ESUVcw8dPEvzUwNSmRBkQHf2q5X4mf5NNhdm108ET/IL1QiTbsun
	3014YcrXopFWltelajPKanKr/okcVwDwepqx1TZl1eQu/8+OzBFOwtqe2bHokiuRNg2BNVqCq2A
	8614RoptTRIsNGFWujyjIpfEOHt0BScSty2IBf9UJIkvNG2yl97DBuThZvGelNgvLMzdt9GV5gE
	AaD7FCYGcOhqHsTw0Pf98HvStIUqdo+L+aslpDZPn3Q0XRj4BrX8oKwROPwuOxqDuPrA==
X-Received: by 2002:a17:90b:3843:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3ae89812f2emr12451140a91.38.1793746416049;
        Tue, 03 Nov 2026 14:53:36 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:35 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 4/5] spi: spi-mux: pass child CS and word delays to the parent
Date: Tue,  3 Nov 2026 22:53:07 +0000
Message-ID: <20261103225308.3633046-5-jctchan@gmail.com>
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

This depends on patch 2 of this series ("spi: spi-mux: re-apply
settings after child calls spi_setup()"), which makes the copy happen
again after the child calls spi_setup().

Tested with KUnit (spi_mux: spi_mux_cs_delay_test and
spi_mux_settings_lifecycle_test, added later in this series) on ARCH=um;
they fail without this patch. Builds with W=1 on x86_64. Not tested on
hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Fixes: 8c33ebfeeb59 ("spi: move cs spi_delay to spi_device")
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
v2: Updated the patch reference in the commit message after the split.

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
2.56.0.385.gac671c819a-goog

