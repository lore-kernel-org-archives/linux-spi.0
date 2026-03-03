Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48967214A64
	for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544094; cv=none; b=FQ3rabfGjLw9lm5fDN7ouphk+4Im3vjIXASMRI2yOBL0nKwFJ5UJCNgj+B/nypkUX8rUwEdqbupdta5GkwNOnIICxp8OJpgiXx2Cu57V0gcRBWv0CGxTy1LF2+BWqARKzeC0cvzh1/g158A1yHqt/HSMisMJt+HsVXXV9Leaq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544094; c=relaxed/simple;
	bh=qQ8cVIgoJLxTfOYZEyEm9nD6RyTJa6yvfBv32MH0W6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Azec1GSstPVGL2eB8WjdGxM7km3X3akpPBgZucVOR1DcUFbPS/aKQ1SUad2aXzg30JWN6lukYprOCAAv/puS9cu7P+XDpngDv1Sp/BkDO23UioSAdzn/MbEGnuxkQ5pQyIWUVJiKLqAuasYL0JuQXekLLsAknbMG7PZp50xi4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAF3xnKu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAF3xnKu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae50a33ff8so17509355ad.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Mar 2026 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544093; x=1773148893; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSgIttgxow4KdsVl0fAW0hH1qFQjzwhPA8Ucjoz0JJk=;
        b=RAF3xnKusSwaESx5bWUqt+M3PxT4xStVRsifVb/3sL8neXrkUPHAGYSwEwRNOZPEru
         g+2wmoRvo8sUj9/4nQk7Yh65xbDS7YaWQXY6jlXkWiFI0NNhYHiC/UqxUpj5IK3/Lh+u
         YuOy9jAFdBGu93Su2QUVXgG6w5CQV/Q4zyeSKpbr0QzPPVSqKzAfuuZ/U2YEaBS+I2lq
         3AFMpHwJM0NlLMbBAAWAU/Q6gAQM/OINCq1A415bWX1N14exbH3R9kOj/90cXqxfXb4e
         EDqRC89AFOrz3Z9bnFIVaEj0hQ/rBhIgNtbvQUd5Asp17TUuJ4i0IA8xKKsaMnJ+yVlN
         RmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544093; x=1773148893;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSgIttgxow4KdsVl0fAW0hH1qFQjzwhPA8Ucjoz0JJk=;
        b=JrBjNIkSF86NiABMU6Z7lWbUNijnFNXzK/1/qYcWlViEZaHbEIOh2H1GLFbQuZyzwE
         kpMKeRxbQ3DX65tkz22sDkcqa3EPpK+WIif30bbHf9Wuhca5YoyHYf2nExqu7Nb2S93Z
         aC5rkkD2m1sqE7X9CdEMxh0pRE9sGbVy1g4Hynw/MpgNH10fpUlaPWQGlhzpNIdFac9B
         vAmkbsXZwbKKg+BHYAn6PBoBIT34n4B6UNPQ0mpA7yEIINF1DRVJ5DdN5JIJfvGeecoo
         MZm88dbilg7PucuMO+SOh3ihfxCEIbR1zgNb7iVc6oGZ2xaNX7S5kIUwfKObvNlRBrld
         NEzw==
X-Gm-Message-State: AOJu0Yx7Q+O1Q63i5Zn1lHhImxUkWJY/9JAsLg+BTHJqynUpAYdhU7ur
	tahKNqT8viBD/reELHBNZvtgD6KnqH8NfwMd0QKV3UcifQDvqf3N5RQV
X-Gm-Gg: ATEYQzxVmW6YIP6EUw/SHoCMckuFUK2GcvfdNQMcZBWE/JLFkwC2g2GiKNG6DHjFsAZ
	Zkg57LE+sNAOAA8eeiZIBosLZ5SwFSaxoXaqD3DiAqmTQivyO76n29WQa6MXeRaVZ8xtNnm8yDZ
	UaLgeODrme92PE+wKECYrRonsFuXBEN6M1xLXZYJxS6htrIrOIq78UFW2s+LeCrlMtjsnT76lyU
	razKwdsnPi3sGN2YtBrjET+w1DLkTS8CSxbkQZwDx8sJPRafy4hM1rXBeA37k8wa/31ICAuhaFY
	2/MqD9jPZcgSWqO3BWtSVxsWvAnNUyZd1+OsDMQH8Rln7CpcI1J//frvOiDMRS5nHfwVWNTxwP8
	tEE3kwcud2pYG4zzT5qSFA0flpTTAmsYNwGBiLWflpMQUV+SBzk4rVXeEfXsH+/+crhzuHwreiy
	n2zyiUJZ587mS40hFrByi3+f7KZFrXW4KNI7gApx8uz+IyvHM=
X-Received: by 2002:a17:902:cece:b0:2ae:3bb2:a8c0 with SMTP id d9443c01a7336-2ae3bb2ac50mr116402345ad.44.1772544092428;
        Tue, 03 Mar 2026 05:21:32 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:f9d2:c148:3305:e3bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b48f4sm168764255ad.13.2026.03.03.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:21:32 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 03 Mar 2026 21:21:27 +0800
Subject: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated
 operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFbgpmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3eKCTN28igLdFHODJEvzRIuUNAMLJaDqgqLUtMwKsEnRsbW1APj
 jibRZAAAA
X-Change-ID: 20260303-spi-nxp-d70b97a8df08
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772544089; l=1628;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=qQ8cVIgoJLxTfOYZEyEm9nD6RyTJa6yvfBv32MH0W6k=;
 b=oGyL50RMeoOF6bnHxpZE3ErdeVNP2WcZc4Cs6okMYfM68WGQBmcJ5N9XO49DbR7IiA5uDhble
 q8S7hIWbPYDBP4jHV+uyQVjOJ0oA+8nZvG8rzmuJu+Zjme9oOvBtyNN
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver currently calls init_completion() during every spi_mem_op.
Tchnically it may work, but it's not the recommended pattern.

According to the kernel documentation: Calling init_completion() on
the same completion object twice is most likely a bug as it
re-initializes the queue to an empty queue and enqueued tasks
could get "lost" - use reinit_completion() in that case, but be
aware of other races.

So moves the initial initialization to probe function and uses
reinit_completion() for subsequent perations.

Fixes: 29c8c00d9f9d ("spi: add driver for NXP XSPI controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-nxp-xspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 06fcdf22990b..7b2de5612964 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -958,7 +958,7 @@ static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
 		writel(reg, base + XSPI_RBCT);
 	}
 
-	init_completion(&xspi->c);
+	reinit_completion(&xspi->c);
 
 	/* Config the data address */
 	writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
@@ -1273,6 +1273,8 @@ static int nxp_xspi_probe(struct platform_device *pdev)
 
 	nxp_xspi_default_setup(xspi);
 
+	init_completion(&xspi->c);
+
 	ret = devm_request_irq(dev, irq,
 			nxp_xspi_irq_handler, 0, pdev->name, xspi);
 	if (ret)

---
base-commit: d517cb8cea012f43b069617fc8179b45404f8018
change-id: 20260303-spi-nxp-d70b97a8df08

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

