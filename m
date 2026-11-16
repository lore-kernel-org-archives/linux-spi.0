Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824946;
	b=BLrKsvGvHFQt1HDt7SJNHiIYfCMT5aiiHTZop9+D/ZO4Yanz2VlNT/3p7c0u4idTWvm3
	 76sihxIpdCt6Hr5nQ76OJ1IZcv0NjPoachD3cp2HDm6x15Y+YUTZj7Og6gLWxj6pIDCkc
	 ZzwezZLqUw0ALfeQpcDMFCPfC/etyaFd00z761ZOfAz4IVfR9xDk6i08DZoUjSLD/u9S0
	 SznL8xykETnxF6CF2qCCKihfuwo7Jge/GSMDfAT+lipR/PxhK33b0GRmNUQPV9BTcV35B
	 utdT2cZfRzx8GTSGyPybh7VrAsvQEwtt66/ROaseVHarZKy/bvAlKaDO1dkIFEYxsLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824946;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B/X4pFUER3BjjgRE2JYjOFuKnCPfd8nH8P99ehyPdKc=;
	b=JhQF7uDLewd7g/91Gzrum9XyyZgwzqmfzTcftI/qgAjS6FYdggq2oMn4zu5adOxIsymZ
	 9pn5od4tYi9F0TWK7S+cpHydR6Qj+BSyQXo8+poTcP40pvhx7DSQ3ZfUQYexCvjsNHvYZ
	 sNLKemOQl7HTKSajPZ0T/1TTj83m/Q3f+A5nu6wom/wUAPuGMR2wIxo411RxAqqNO3xUC
	 Ha5N8WbtHl8+jrcm+ZHnYzbMVnlWiLoRzuU8beqz+eusi6/sW8FguX+Pn9OVKyMtJL9IU
	 +VRdollPfXpmYo+21gx/T3TScj0ZqiL+FIPoGpOrSX+NaAbHBZNd9xzwxvbHowjQVhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=RNJ9n4TX;
	arc=none smtp.remote-ip=115.124.28.97
Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE34606A32F;
	Mon, 16 Nov 2026 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE34606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=RNJ9n4TX
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794824937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=B/X4pFUER3BjjgRE2JYjOFuKnCPfd8nH8P99ehyPdKc=;
	b=RNJ9n4TXhoY+eFhbqTsBQDZ1KZJZ0uFo7PBoRlW17R2BYt78dctV/O+s3oAUIEBOjVulKcSri8YAd2hs04J+NOZAi++F/Ie0qJHYOZyLjFQNveSHfL5kXkfhtKppz3iI95QFJfV1+3Zvqr3H0XhqSTG1COgRF6eyC6RrX3x7ljnhxxQRIlMB4No5GDhjs/PPtTSHZvcWlHOhpy8+FvaYOh3jph27TtVwZdc4Fi6ixRquWTWKoFe2zBOyC5HH2MIxudCdulTarWJfZ2WxUEhh9jTSBOsDrQ1PXWYQur2Dv42rEnzxwiScFatpU3ku8nGmIEttIHGEQ6Lx60dhLZ7Xlw==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07444172|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00233692-9.41925e-05-0.997569;FP=17156062801562223770|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.k35E.g1_1794824936;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k35E.g1_1794824936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 18:28:56 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH 2/3] nvmem: at25: support panic writes for FRAM
Date: Mon, 16 Nov 2026 18:23:56 +0800
Message-ID: <20261116102357.4127825-3-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116102357.4127825-1-chunyuzhiqiang@yinhe.ht>
References: <20261116102357.4127825-1-chunyuzhiqiang@yinhe.ht>
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
index bc2cfb75d..230e78c62 100644
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

