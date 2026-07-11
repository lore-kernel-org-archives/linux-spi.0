Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB543C2B8D
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770603; cv=none; b=LEXpm7BgjZA95GignvvC97LNf43+Nsebbob41NeO1Qx4NuUhgT/+G2deUo7mKBZxpf6hPsbprqBXAUYVT6sDgBJ6sT2eo9rOSqlPA4r9gKGuGnp/WjV8a0OSYWk8O9zHOvSpCwrOd0KFeLsykGHerqhBRMc1mHzYic/PulU57nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770603; c=relaxed/simple;
	bh=o2Hiy84rnP/9UMKURCEIhcD7/nHJlcIAPilhOK3M2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EI/hI5vWS/7swyOtS6ok/pqRI3eTuv0IUc7JTm4/a5JR2VQMNDA7FE/OpXpUXRTD5JL3sKHsutpg6LKVTii5EXJzOR98OUVCemfkhSgzmeeUDLrrSJfsZJyQRmIiaEu1uErAD3dBg6XMYnN5zn/XVIaUiZs8vEFvPLOXdTXrfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1810667a91.1
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 04:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770601; x=1784375401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJ53oWqRjCNjVlROCxKHTEOJ8pLHHBllpxRR0nGEHyI=;
        b=hrAT3CPCs/zSoRhhyfxHs/oVsQiOkm+2i400MwkKKCBzg6GbODBCFIjNnL/GEafmcu
         XhQePYOTjb+s6vU4V5WELYYVML5NZyeEbKE6NjtZo+gcGqc8ISiBD8xLZD9gtBVLiScG
         sdCXJEjA6NYAkze1lxFVBwt1e8GY5O4BAjOzy/+AEQLV2U6ObNI1oVlwSbxk86benKaN
         S4Spe+l5wihToOiH0zuSxpIRsLGKmDUbRHZp30hoflWX3z59MBw2eS5OIHhw55ko+waw
         FnnntlqcawCfXTM7Yb2/ZM6u2CWXRskndTDvop/VJx+uYLG9pu2vZDR+isD249ELz/bF
         n3Cw==
X-Forwarded-Encrypted: i=1; AHgh+RrNeSx/jcwotycfoGU/1bi+8qfswQ8oCZpo7iO3hfIQEXic8Fv0wRLCfrOMxx9dNlSReR6qRhIyE58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh9ZnP3CQuuDibu3AxERaXh0xxZeA9ht33Dm58BUw9swL7Js0
	F/XXJWzOtwIiOS2Jz0snhZg7EpwuuTdvz1g7UfKt5tWWPI5YPHZaYUM=
X-Gm-Gg: AfdE7cm5x7sWjzlYR9+8VDE6ePrddcnq8USauGZuUDZNvmHF8e1T/HElV0bNduwSn12
	hJ+wR8r37gEI3FqKbuVSl671z/Ay3P6esbzUMiGG++v73kvTrKXQuS3TUeFBvuQqPdTW3rqsr1F
	nzKIR3QGZ4oF6R/E7dEG0U6334NNvD6QVXhmNTR81H/4ks9cmE9Z/mQuHD6nR6RrWCEInmuYp6T
	kxoUr5R2q1lDTpt+X6Gt9uonT3vrSjMT7xWo0uC1QHpF5TkJuttzPD/VV71agwtknVEICMEBgy7
	dor3cZFp046m+BWPMlkLQiXWfdMTMwbdncFRgD8xI3AzqApXuI2MPT8ginTHxDQtJ7JFddtpwIj
	JxqcdTBirA9miwdDXv1yt7luHUxpU9aCNm0jGPqVxZioP6jySrVhlKexGADL3RkP4bxEIneF0K0
	oB8CTgzsldiXdYKoVV5MbdRL1UeoP6iLPqi0fZ4ctUAFm79h6j/01n4f9JV4VEseMDo6LCzk86u
	d0SdNt9aVFdm8YqDrJBLUOujw==
X-Received: by 2002:a17:90b:5344:b0:381:1b66:4734 with SMTP id 98e67ed59e1d1-38dc75d0b31mr2658787a91.6.1783770601104;
        Sat, 11 Jul 2026 04:50:01 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:00 -0700 (PDT)
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
Subject: [PATCH v4 1/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 19:49:35 +0800
Message-Id: <20260711114937.16670-2-fourdollars@debian.org>
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

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

This creates a use-after-free (UAF) vulnerability if a pending or
running worker thread attempts to access the private data after the
remove function returns.

Fix this by explicitly calling cancel_work_sync(&applespi->work) in
applespi_remove() before cleanups.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..3bdb9e7cfb8b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

