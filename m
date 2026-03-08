Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92B3126C0
	for <linux-spi@vger.kernel.org>; Sun,  8 Mar 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772952572; cv=none; b=hv4Y8Zj+VMCfO9zbHThcxxs2gbVBPB+/fNjCTNiXPxYKqVVABnfGhBmdPYlkpnPfVssV5VAwdBUizoW0a+EBhKUBeokds8sXeOap9Ty0rWlr5PuwPLAMqoQVU0w6Ar54X5SEC019TnWAhfLPJhTL8J4d/NAuQbOqqqY+9EaCg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772952572; c=relaxed/simple;
	bh=/BKTkOJbNK8vWv0xzW8hwFc3TcYc2Ah5zzUcDxFOowk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UpulwZQoD3n3kPsAfoor3zd0v0g+3NEfw9B3lScnWMN+DvyPQU9jYKVvLGggsLea6aZ3b7j9ZVY13THXoPfn50PgJgz0kNlHxjPqt5p8AyIRh7Qk+G32rhwLieRzL6EELauFuOqbMpWXqyk4twbU9A8C/bs2bG5fEtKPAdanFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdbopySu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdbopySu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so118752955ad.2
        for <linux-spi@vger.kernel.org>; Sat, 07 Mar 2026 22:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772952570; x=1773557370; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHZ3b8kIQa/ldmjcMemF0gGgYf2JewffGcklskFCxDY=;
        b=PdbopySuYtgWry5Mu8DmCfw+cmnHilQSUS6qORvibKCTv/MibXD+fp3zCkpAb8WOI/
         eOHaee3kuJwC1f0nQOdeDF23VZoZyL7Jv5z7ZvRBikAHnDjgzmEE7oUAAvL9JBxzoCNw
         tZDKkkN9YgKDaujAWUpthjoCktYRopWF59qKOe8Ua9HbgXDlKd9HNcR6EvNt9qx3+Wow
         SQZg6YwvxaMXhqbtOzztOjIohMAx63v8AT9zq/+MVvDpOT3491DVXuLQAvpaiSSNE4Sn
         eIoIjiSd8Z+VMluw3c1SfEMu0r0x1mRHyjZTCwgA9xBG/EPSPybeGxaHtjq3cRAluDYP
         7vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772952570; x=1773557370;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHZ3b8kIQa/ldmjcMemF0gGgYf2JewffGcklskFCxDY=;
        b=llRAXsrf22DjHK5A/tIqjuQ7q/cY1ib7rlRM+0RiE1zoSVrHp0L7NuScLA7ikicwjq
         u8vT2wqc9B574cMLatpmACYFtfBtrf7vBhZFmRIK1HgjNUSzV4KetSpQWoOC2+1eLseh
         EEeEFP5r7Hyadg6pSQrpo6hd0qpEJ3W2GMB0j1RGrpXARg4rwqtmTtXR5vv67Y/FM58y
         L02YSFdLieVlCNZpCU2og5b/f4Lt7LNtQBfMifa5CvQ3TIyF1cl2qdzP6HzMSFe068Bf
         0roCSaecLoCNFzDqvwJYIg2nTnd9wcGMGqtJIC6OFeXmHvTfOuKkRHREqnTy0mV1S2R0
         qx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWfsUJTUJ+2wz+xikwugVeFW+204TVX2bq4kpq7Kvbu+r70NpyykmZxdcrH6aZY67nzwgPJEWz2beA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kXuVbi50JHxv0mR3prsVA969dQd7Hs2wyNPM0Ouv/8XIJOwb
	kWD396lO8HQL9w7oXVB7tOvsZDiTQDONTvsybvccwRP0D6/PAh3iax0B
X-Gm-Gg: ATEYQzwLNr9Ak370m0P9H5O9Zu1VR28VYP4N59kbY0Q4cTrqqmdp8O1uLqs65zfosxJ
	cbqTUOvfpwYAuxgPbHeJYAmethLwYES5O+MVb5TP8YtyIXKTnTdOB44PMQitzxLga+TNZZ/18SU
	qh99zTv8ndJPU2AqaXhtwMdHCsuwgoaYcFJJnb8NZcWBlng/+5YUlEjdzJLAkkxqX11iTxyA2zq
	7nYFA+xPvw/Z6bMqpmGhzjuySdfldQRrO7RGt/cS+abpFv7zl8rSpP8hUwCzWN082RYtkRnZFhO
	QYnNKJ+/OxmXuLNQ6jvCEOG67OwFv9ikILljbPine7yCzESwF9i0JZDqGvh5r99Y/vzlSZHhz8l
	RaiG9XK1fNt1nBjYK1kmotZtvM26B2fsspG1YNHmH9uD9ybWkwaDrvlTQz/dmx95GIgNayR6GWn
	ikINyXJe23FrWUI5lXfpUR8wBUPk61ktlh1EnZS6usYFKj0jw=
X-Received: by 2002:a17:903:182:b0:2ae:8077:b1c7 with SMTP id d9443c01a7336-2ae8242d3a5mr82140785ad.37.1772952569794;
        Sat, 07 Mar 2026 22:49:29 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4507:7fb4:bc3a:eca9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8b9e4sm68061485ad.64.2026.03.07.22.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 22:49:29 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 08 Mar 2026 14:49:21 +0800
Subject: [PATCH] spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260308-spisg-v1-1-2cace5cafc24@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPAbrWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMz3eKCzOJ0XVNj02TzVMsUS3MzYyWg2oKi1LTMCrA50bG1tQCt9OM
 RVwAAAA==
X-Change-ID: 20260306-spisg-535c7e9d9763
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772952565; l=1876;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=/BKTkOJbNK8vWv0xzW8hwFc3TcYc2Ah5zzUcDxFOowk=;
 b=vqPfmsD3moqSuGNU//cr5LUBXukDIbjFj7/CSdRC3m4i2jFFtcz9i39Ori8w8ss8YVIkLBES7
 sJ2vompmXO+AQdSJ9BACro3T5AkTRjSLiwE1/jgb9LMxnG6ea3eBrLp
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In aml_spisg_probe(), ctlr is allocated by
spi_alloc_target()/spi_alloc_host(), but fails to call
spi_controller_put() in several error paths. This leads
to a memory leak whenever the driver fails to probe after
the initial allocation.

Convert to use devm_spi_alloc_host()/devm_spi_alloc_target()
to fix the memory leak.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spisg.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 1509df2b17ae..9d568e385f05 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -729,9 +729,9 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	};
 
 	if (of_property_read_bool(dev->of_node, "spi-slave"))
-		ctlr = spi_alloc_target(dev, sizeof(*spisg));
+		ctlr = devm_spi_alloc_target(dev, sizeof(*spisg));
 	else
-		ctlr = spi_alloc_host(dev, sizeof(*spisg));
+		ctlr = devm_spi_alloc_host(dev, sizeof(*spisg));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -750,10 +750,8 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(spisg->map), "regmap init failed\n");
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_controller;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = device_reset_optional(dev);
 	if (ret)
@@ -817,8 +815,6 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	if (spisg->core)
 		clk_disable_unprepare(spisg->core);
 	clk_disable_unprepare(spisg->pclk);
-out_controller:
-	spi_controller_put(ctlr);
 
 	return ret;
 }

---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260306-spisg-535c7e9d9763

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

