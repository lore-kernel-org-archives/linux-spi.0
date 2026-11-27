Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765489;
	b=ES7CVio+4PsbKHZNM7PLI/NncDbFJ/yvrazrXXbxa7IgWSGDlHbqpBTwbMNQj6rRzX+1
	 tTde+5oJwCxu+naEXQlazB9kUCbi7WXO6nE6py7rFCDrAGyCmqjJxfODUC7GxwjdEam5v
	 /zH7ePGcMzRHd0Gh+wHl8bog76tGmD+Ry9vt7vpAR+SfVHb1WGwDBQy0hzhb/ain6PWvZ
	 Z3vHOwC5JwyLJT+9Ls4fU5QeRhfJ7PybEZiPYDUZVMnBYf7uu8AI/iNlenHnqE/jrT7/R
	 jLfNPO0n0Lf1HJxA04rAfrM+69Okd+ohcJQM11xEP/KaLnvHboFHuWLz+oshfEsUmtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765489;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OSQYUrnfBGdbVjZa+JnHt3NoDwSNqZeqgLz9oImuqXk=;
	b=pRQa6/ovxqEhCItLkxfCx4xFWZzn+BOJIaydwIFhVBDfoW0T/QfASETaCiK1MC2ue6aL
	 ltYNJwt2VOZvlT6SZ9duaqY/fa/p+itj2BJZIuPChwQ5aloH9ykScK3h4p5QIpsrJ9SPu
	 54mB4kLltfxOTKDbP70oDvBBJwLaYdsNlsNHkwQsU8Hi4vYCCkBonyITmySRjt7typJsz
	 zf6+S+Vmo2efoYqK52+a8zDklMVf/MMJedn+NksHWAfdjIOXWV9BShLcqFepVDKJLMkOy
	 uZbr4Cp79Fmt36cvyptdYu4zcD4cgnctgQQADVp5YPglfhfOkxvTbykpMP655QutPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Q3DzM3qr;
	arc=none smtp.remote-ip=115.124.28.220
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACA606A32C;
	Fri, 27 Nov 2026 07:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AACA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=Q3DzM3qr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795765484; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OSQYUrnfBGdbVjZa+JnHt3NoDwSNqZeqgLz9oImuqXk=;
	b=Q3DzM3qru4AVkjTJGiEK52PBKj4qzj4xuswCzdyYymJ6iEVYkdS2zEZG9R0KzOEqCaTzhRp2iH+p0hRAmN8yqgM7/9lSCMhpJUr4aDpU6X24Vgd438w7LcNtXHzh95DaUQ1H1cd/TdV5RfUspTd9GpCoFDUbhimq6o8A3chV2OlLfdnYYFr0HpsBsIKxoq0Y2XNUEvh6bVGZn5pJ1lTpcJXAFKAx3ndB8Uye0s0FR9tSn/NhuNLlOHvxmdZp7qumbRr7oVVgNkxkY9U5sLLoImcgknWwSMnKxm+iQMd+9x1Tt8n1gFmn4ZIJgl2eQAoyc401/n/9+eqJNPOYz1B0OQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07445959|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00233692-9.41925e-05-0.997569;FP=17174077131352229018|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.kBFoymP_1795765484;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBFoymP_1795765484 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:44:44 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/4] nvmem: at25: support panic writes for FRAM
Date: Fri, 27 Nov 2026 15:39:12 +0800
Message-ID: <20261127073913.353407-4-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
References: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
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

Implement reg_write_panic for FRAM devices.  FRAM has no write cycle, so
the WREN and WRITE commands can be issued directly with spi_sync_atomic()
instead of the sleeping spi_mem path.

EEPROMs still need status polling and are not supported here.  The
callback is only registered for FRAM.

This patch was prepared with AI assistance; the submitter must review it
before submission.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 drivers/nvmem/at25.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/nvmem/at25.c b/drivers/nvmem/at25.c
index 72240dabdc3b4..b45c8aa58a231 100644
--- a/drivers/nvmem/at25.c
+++ b/drivers/nvmem/at25.c
@@ -328,6 +328,63 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	return status;
 }
 
+/*
+ * FRAM has no write cycle, so a single WRITE command can be issued from
+ * panic context.  EEPROMs need status polling and are not supported here.
+ */
+static int at25_ee_write_panic(void *priv, unsigned int off, void *val,
+			       size_t count)
+{
+	struct at25_data *at25 = priv;
+	struct spi_device *spi = at25->spimem->spi;
+	struct spi_transfer xfers[3] = { };
+	struct spi_message msg;
+	u8 wren = AT25_WREN;
+	u8 cmd[EE_MAXADDRLEN + 1];
+	size_t cmd_len;
+	unsigned int i;
+	int ret;
+
+	if (unlikely(off >= at25->chip.byte_len))
+		return -EFBIG;
+	if ((off + count) > at25->chip.byte_len)
+		count = at25->chip.byte_len - off;
+	if (unlikely(!count) || count > UINT_MAX)
+		return -EINVAL;
+
+	cmd[0] = at25_instr(at25, AT25_WRITE, off);
+	for (i = 0; i < at25->addrlen; i++)
+		cmd[i + 1] = off >> (8 * (at25->addrlen - i - 1));
+	cmd_len = at25->addrlen + 1;
+
+	xfers[0].tx_buf = &wren;
+	xfers[0].len = sizeof(wren);
+	xfers[0].cs_change = 1;
+	xfers[0].bits_per_word = 8;
+	xfers[0].speed_hz = spi->max_speed_hz;
+
+	xfers[1].tx_buf = cmd;
+	xfers[1].len = cmd_len;
+	xfers[1].bits_per_word = 8;
+	xfers[1].speed_hz = spi->max_speed_hz;
+
+	xfers[2].tx_buf = val;
+	xfers[2].len = count;
+	xfers[2].bits_per_word = 8;
+	xfers[2].speed_hz = spi->max_speed_hz;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	spi_message_add_tail(&xfers[2], &msg);
+
+	ret = spi_sync_atomic(spi, &msg);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 /*-------------------------------------------------------------------------*/
 
 static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
@@ -545,6 +602,8 @@ static int at25_probe(struct spi_mem *mem)
 	at25->nvmem_config.base_dev = &spi->dev;
 	at25->nvmem_config.reg_read = at25_ee_read;
 	at25->nvmem_config.reg_write = at25_ee_write;
+	if (is_fram)
+		at25->nvmem_config.reg_write_panic = at25_ee_write_panic;
 	at25->nvmem_config.priv = at25;
 	at25->nvmem_config.stride = 1;
 	at25->nvmem_config.word_size = 1;
-- 
2.47.3

