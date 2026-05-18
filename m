Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B783265621
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123954; cv=none; b=KmE0T2NAky+9TW/quI39fQbE/l8xYC3xk6CTLmpZDuinya7FFIJ7r0vmcNCzcPWLapw8bwgZ3xPgkCafKPrSVe9/bsJCsgXV9DYBxQC8ejqASkVp5+bA1oElOWBPC5FWbxk8BZ9Ifn9mTYVxYNU09jyDs0wPHehZ68ntXoWucoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123954; c=relaxed/simple;
	bh=v5OIJNsk67U76wJjPC7hqs+G51U6k0pEBy58uPTbPjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XI+P/MfGNt0qL1pKJLcHtU6o6y/YdzjVpbAWfkk8cEeHhPSWsKyJ0uTCtj0DCF8QjEccq1fw0VTKMQdQEOCDVZd16Xc3dV/M6RPoSRbc6ietVRBBpTPqrXUMVlrFbuzhkXQCaqfTTEEohYe4R1bdXnf3jMZBUGI3+he6/DSSmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I5vgKXhe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I5vgKXhe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso29224415e9.3
        for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779123950; x=1779728750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WTijTnfbP2QXvo6ZSkaGvHIK1QTeCa7hz6oIw9U70KQ=;
        b=I5vgKXhe8+X2Ncsh1TF2iZU/fuAU3iHy4ovIDVgYmxjN2MHQNGZGkGkxAmjIpURQCe
         2+EfxOx4VcSfOBEVOgjbn+jGhQjSmRR+HvqkcVUvYjr1vxeKB6O7zfv1YAWuJjfZt9s3
         YcixrKJ8E3ZyIZnMysl7LVEJuH9ucocPR9IPPgNn7e4/Zm2a3taxxxJdZjJ9/3n0q6fc
         j7/ZPuLG3D3Blv2E+eMEAfNgxI3Z8O/7ObonaFRNb+nOflAA55Uv2hyEgymhsGoEqlSe
         dALgGczSY1WgCkZHcFY7+1cTzYA41VOwfe1oH9oCg45yHopOYzHiPwpFR9D0QMHPErNO
         sJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123950; x=1779728750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTijTnfbP2QXvo6ZSkaGvHIK1QTeCa7hz6oIw9U70KQ=;
        b=WE8bQ7iJ+3xPbRGbV5hCp7qG7/qtdAYsVUJ/DKmmVYWiarjrPYwVs6v/3NKrQmg6Ry
         qaLWYn0k16NKfhoqe36pgUxWX91NoZR1HAD64znIM4vqFGlKq/MXQvwpUIEx6ETaLccu
         6OdFFN4xdYf03EI6E8Rq7rZvft2iASbzaq+8FYg/LisNzD4JhZiKgMGvfacYzjCmu0L9
         G4JtUGtb/PAwj9Qvc7ROoEpQrql4neC0lSzkAcYVg5JJoZOXIouswl4BNRPr9nXP/JyW
         5lehC66T3m55WXzNK8LKhokFPCE9S63GJz69pypLb28oGJ+pSW0KuE8L/Th+M5v3/03u
         GNhA==
X-Gm-Message-State: AOJu0YzszbakTy1BhOvj4d30K7ok/AHMeU8JFyZBH1YIXsvPKG13UWgc
	OJlR+idkuCCxcWMAYu+uEoBcUBO9pq5L2Yaif+I7Vj+J7MCRqLpQk5wihCsWI81TwPY=
X-Gm-Gg: Acq92OFQxGvScGC8NkZE3adCm3xuET8pWi3M451UQ8/tnB3vqdvOmMQBUDt2JxInjkJ
	TbaAGWyu5vY/tDlOGwwwNOpSlAz0GG/URnX31KmsDDIdHeQfBfAQTzHCuV+q5TRIy94TltnJvls
	tUnElt1fY47xUnY5EoXiggmZ4ZQvpZHm7wDvsB637x1k2novdVqkbSF/JtR0HBAvki93axc7dlZ
	PkDm/QbFJXGQK7MgtGEiz9EEMcabicnlKRDoONU63lmEuJyhImrepSMwBgtibuBKQVKDWoFdLr+
	NyOTGVuIY+Mch+8aM1Wed9unHiJNXULAL7yPft3LlqrAG/jiSN5FPzL3l9ncW0zuL1UdM4C/1Zo
	Kf5BPO7qrVdwwKMohBE4jEmROCR+W6qgIFuM/bYBQSpjgnHKKVoNMVYeCPxDMARmO1O3eIQ3vxW
	7xD1ORde/Zlu7upYJPMz7Zd58k6kEUXpsbom9i/zudBM5SLUmWMdkiOjeiBbuP3AA8V4jT7927C
	NIKGLlNHqY22Q==
X-Received: by 2002:a05:600c:8210:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fe6322447mr231303205e9.19.1779123949856;
        Mon, 18 May 2026 10:05:49 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe5694fbfsm465987925e9.6.2026.05.18.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:05:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] spi: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 19:05:41 +0200
Message-ID: <20260518170542.807843-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4615; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=v5OIJNsk67U76wJjPC7hqs+G51U6k0pEBy58uPTbPjc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqC0bmXvyH81515D+CX/H+6I//tUMvr92ExiOop G2sRnSQisyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagtG5gAKCRCPgPtYfRL+ TvK8B/9IRB81AvStNb7w8AuHuvgqfkw59qFh/d5a99r1/iDEtPdXzfDHsyHb9XN0452A+XK0Z+5 Ii6ZKhmjAbV7R1q07j+FOGIG1Z7WHa6adlu8ptqjFetQKbUAkvttBEadHS/BaqKhfk5cXDaIH7C 1mrCC/zDcNvtlAMxKRBGJkv/2bl+Hm4Z80qZry9onxsCMRtyd8bUK6NrZ1NvLHF4QDTgyr3Kppi ks3Em2yGDaN1wdU791CRHeeNU9ubQR4hAb0hSYwoe9N3hU1rWx0abqpUKWzFUMkV5K5AfKYoO9z dma+OsINGmJC1if5as7hQnE0W+bW2ZDDqRBYAflTi2gCJ8gU
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching these arrays, drop a comma after the list terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {

	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a spi driver that benefits, so this
is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

 drivers/spi/spi-sc18is602.c | 6 +++---
 drivers/spi/spi-xcomm.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 78c558e7228e..ae534ebd5e87 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -295,9 +295,9 @@ static int sc18is602_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sc18is602_id[] = {
-	{ "sc18is602", sc18is602 },
-	{ "sc18is602b", sc18is602b },
-	{ "sc18is603", sc18is603 },
+	{ .name = "sc18is602", .driver_data = sc18is602 },
+	{ .name = "sc18is602b", .driver_data = sc18is602b },
+	{ .name = "sc18is603", .driver_data = sc18is603 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sc18is602_id);
diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 130a3d716dd4..e40ec6ebe4e5 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -269,8 +269,8 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id spi_xcomm_ids[] = {
-	{ "spi-xcomm" },
-	{ },
+	{ .name = "spi-xcomm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, spi_xcomm_ids);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

