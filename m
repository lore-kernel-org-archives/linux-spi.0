Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607953C344D
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770606; cv=none; b=ssNMMvfKMMTAB81so69QRhqHbnXuyoSCkpxu9qrhckXWvFrfiCO4425GBH3MuX/nIdfOFtAllrnQFds4oDYEaHfodU4le2DNsy/KCuSsTHLOb5MUNQajbYMw/a/RAJKlJeIrNE8k59nrSeQWS0H/TNM+vfStED1yB6fpmGfbnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770606; c=relaxed/simple;
	bh=16ZCF42qfyfecp4FE6xDMCEwifOTFXd6LvfmvaYgqJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XN+0KKkZwkbgzG2MeL0jUkuZdf4mtD+h9fF4nyLNDcgln0kwpGaqtX1EwYwRo2YjlNvfnViIQOwpdzDT6K2NxNY87yt96SaL+K+WeW2tUC2ji8LpRqkt8lP2D73obRlVFJZVLR27uh5QAuUMZHmfbQ1VKfUguCsDXYXPm5Kqcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1421427a91.2
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 04:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770604; x=1784375404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hk5V5J+DbPG/Ee/w/hWVnY1n/ftwZsWJmMFAPAEy6a0=;
        b=FoBDJAwwCdMoMCdjVVVZwIlZWdfHeRxo6lWGAg9+++jhwaJtq/0IDPtJ3NRonN+7ye
         k6dlqD7r8JNmVkrwS/9eCpXfWI67svDbkmCvBEONVQX3vm+RgVpSc/AOBooYhT5swmt/
         Ig98+m8Xe1DzXLoclfnyRGFR2U1CLajFbsAvrdGh4PQA3tSnx0EDhCd3bKCLnvdWuSba
         dXWSe9A6Sq1tbXV6Tm1z6u87vkeb2PO5E0MNUfrQSdDJSQIt7d+JJbOfXkdDYeQDSjgt
         1LLYbDAbuMDB0NXSD2M+QiQcE+0pg247eMzDToyBEkSpaGT2QUIW0dXXb7U9myoxq8Bl
         IEvQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3CcalcrFGl/5ZklVeAFuJH0qL7ciJ89RRalcPG3qFkElW+ajFyChnGO5RRtShSSJfNJ68mQe1C3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVSTJbZqYPThgXtO83H4zuKWK+2tdzNd2I3t9rgO8/90hbuZ/
	fgeXV6qsi4c8uwhXnOfU8frtHkfcJ6FB7znCIsZURvCQFRIgaFvtvjM=
X-Gm-Gg: AfdE7cnI+S5jTXGErb2TQqY02fP1Dx33D7jgv2V1RmzE7ShgiX1eHGvdEbTZTyjdP0y
	ctT0/mFJFnyJHs8vHNAYGqMOurMKl1eEd5sH355sULDnueywu6AINiDPqodXT40upGkR7oJ3N/r
	szBTTwAR8oUVtRGYwCQAx46qUs/Nm0Yqdy3rdLVWGxdjklYx4iV3OFGuaGxTf4Sk80/GcvQQWkg
	t9YtKagbTPjr30aoUvwTeGlCYvXRfWBlsUCQF+VtL9cDsB4sr8ArifbuN/cMJvOSh6h6lPR1p2Y
	5fbnPeaujda/GuMcLLG39NGIuOmsAxkbgvnTZugKiuDhZbkX6Y5XHGS37Ibb+S3MvDPy8l2Wu8Z
	8XD5r5rEBvhZPbHegKaKA4rNZiSLuGODDY/FZ9w3vctYTgQDQ57/mmGSZdPOP1gs25/edG7WOwa
	UgL9k8PYTRShUHtT8Ku6BwAWK951kC0WFAEyCDyFNrh1/Ugy9SwTTtVeJRonVv6jYBSXVfCUvKS
	g5CJikrI9UZB2kDI7mrNAPucA==
X-Received: by 2002:a17:90b:58f0:b0:387:e0db:bc23 with SMTP id 98e67ed59e1d1-38dc77b82bemr2604555a91.35.1783770603661;
        Sat, 11 Jul 2026 04:50:03 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:03 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Shih-Yuan Lee <fourdollars@debian.org>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] Input: applespi - fix NULL pointer dereference in tp_dim open
Date: Sat, 11 Jul 2026 19:49:36 +0800
Message-Id: <20260711114937.16670-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711114937.16670-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
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

