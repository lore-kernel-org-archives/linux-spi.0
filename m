Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED63C2B92
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775512; cv=none; b=in717+PIj575YV3GeqE6WSxPYpl+/cRRFTL7Kc2nECNY8t1PUdY7mRo72nxr0Voo6Y+LtBmAv6T4AItarWkTshg5rIYL8d3rTkLQRTxkO7howKx9NLxYVoBqWGz3akXqDze8i+geA7bG5edRehK8rsJkfBrNKsNvu8pDbPbEr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775512; c=relaxed/simple;
	bh=16ZCF42qfyfecp4FE6xDMCEwifOTFXd6LvfmvaYgqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfcouPJr4c0tPAr0CSHiWAFGToDDSGcAy5dFtpH6MWNIhZ5/JeAfUdgupvsk2qn1BCdbNI3GdHWHGdgvWaJ9ZAARyW9texU6UdOV3KOvbywPX71fRoHG+TxZWCPCoAR7htbWR77tcO2bkojZlg0w+2RerAt4DZzwT9XqxhSSKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3090210a91.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783775510; x=1784380310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk5V5J+DbPG/Ee/w/hWVnY1n/ftwZsWJmMFAPAEy6a0=;
        b=mnbCSiOCtZ1oMKsLP1PZaEKiUpDEF+Vlj3ZhZ2rHGHYRvuNm+Tis9jNDNxOOCsP2dp
         iJHQ6aLKTrCZcGCdq5QEIIgvwG67DPJrGEFtHHUSsfBBiA5wr9odjeKJP7faIDi3oO3+
         6KHeIrEgUcqJ1UTs3WsAYkupA8Odf5++QoIg86kWuL8tT4N4xAo7DyX3dT0KeDIzBVhc
         8qkCWjptZRGOFS83W8grJWZJEEh+WLWZfGPk7F9TF+HsqiNMtUZ9CTuzJnobKya4sDBg
         1zWtr2yjXk9QugETymmxWKuySMG1/ZemmiLoCIT+AfHnAlw9UPJyv57Q4Lr6rbkpI2d5
         yEWQ==
X-Forwarded-Encrypted: i=1; AHgh+RocuGok9+2q2S28uOr7WXl3acZrbYH9MqVJiU/9SHsu7W8HyWdoPPdFobYs4u8iMDmiddP53mmAO2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1OkzC/DYCxHk4icu5AXPsxgIo5dNZyluhJEmMk9XKQeNoF/+
	p33ggrphlwP5OzfC2Yc9tWSyaDB/cZNMYVV0QyK7tDM5uKR9WjiUTHQ=
X-Gm-Gg: AfdE7cl1AKTVaSzpAIviSOr4kuGqqY8b/Q4JUmfEg2Tn8pRTRJDDKw724Qa0H4hxYSD
	gT9RtVl5Z++qMoK/BEFo/qwkTaUmCGK2eKUMBsuScBx4tP5PSeUsY+EkXR+T7PxybsK4dEIGFE8
	hjjJlTPVa2v4GKrgQ9bvnKS1pJxjOMQbt6ksHSrKPdOmYSaKo7UhLqbFENwtErTNce4IfEQheon
	k5KUhp4WC+W9mGXbCdmDWvpQyskCSYWHfInz5pNuXS/SgB7jOADWb6Kea53WA6z0eBtn+wHYqVt
	4CBNcXAPzAjnRry+Z7SStGM5l9nUxlWo4UiEVE7s/BsygdAx2+9N7MhmNQqyroCg82Q4h0OMzxt
	eXQNudVHbwbXAoLcfKXxPnbxLpIgCEN3IWERRrs/7Gl8lRFF44OgHWsbyFQ9M3SzikRT5HiR0IG
	EpmtRu67Gh1Ts4qgkoEBCOhBR5mEWlmw0vfdivEPJDh9LASUoaI/9oolbTF0oqDWjl7qAkFZ9u2
	5Ac2G57jnquQDhta9PWPahgeg==
X-Received: by 2002:a17:90b:5590:b0:381:5ab5:b667 with SMTP id 98e67ed59e1d1-38dc7819dc5mr2677196a91.31.1783775510256;
        Sat, 11 Jul 2026 06:11:50 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55557f25sm4136221a91.5.2026.07.11.06.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:11:49 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v5 2/3] Input: applespi - fix NULL pointer dereference in tp_dim open
Date: Sat, 11 Jul 2026 21:11:39 +0800
Message-Id: <20260711131140.18777-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711131140.18777-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tp_dim debugfs file is registered synchronously during driver probe
in applespi_probe(). However, the applespi->touchpad_input_dev is
initialized and registered asynchronously in the driver's worker thread.

If a userspace process opens the debugfs file before the worker thread
has completed initialization, applespi_tp_dim_open() will dereference
the NULL applespi->touchpad_input_dev pointer, causing a kernel panic.

Fix this by using smp_load_acquire() to safely load touchpad_input_dev
and return -ENODEV if it is not yet initialized.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index 3bdb9e7cfb8b..4d339445e9c7 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -963,12 +963,18 @@ static void applespi_debug_update_dimensions(struct applespi_data *applespi,
 static int applespi_tp_dim_open(struct inode *inode, struct file *file)
 {
 	struct applespi_data *applespi = inode->i_private;
+	struct input_dev *touchpad;
 
 	file->private_data = applespi;
 
+	/* Pairs with smp_store_release in applespi_register_touchpad_device() */
+	touchpad = smp_load_acquire(&applespi->touchpad_input_dev);
+	if (!touchpad)
+		return -ENODEV;
+
 	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
 		 "0x%.4x %dx%d+%u+%u\n",
-		 applespi->touchpad_input_dev->id.product,
+		 touchpad->id.product,
 		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
 		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
 		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
-- 
2.39.5

