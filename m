Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C5478870;
	Thu, 24 Sep 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252854; cv=pass; b=qegNJhhOtzY/Mnhr4S6Au/D8TYxRMpJ69/hnllPAhpsHUNI9qVMSd/Rm96Sxe8oToUy4143zitE+k066wlxeHcg8KDb/D6KqZc2SAljNnxaSj8lo72MJQcAbee1P8uVpFRAZOJxqIfYgcjmJA7vQos1P/zfxvMzYtbCxXZcVWCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252854; c=relaxed/simple;
	bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrSQyIa+x1Zq1dH1xPtErYHLPvfp+3yKVcwzqG2xub7Q1MKcT4w8NaOmLR7sFDs1Tf63+v92FnNN0Pol0BoWfGU1EgM0W96AHcTaYmRVM1WqpjZUWcb0wuDr5pKdyxj7GD3MW1sAhJqdrDRwevCoz6Qi1Q7fXXZR4Dguv6YtzCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ax8a7NJo; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ax8a7NJo"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 15BB3202108;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=ax8a7NJoOxQMzOxcz0/JsAVwKmC2J3Gi9mIx4PGJGsT4pnxWraO0Oxed4+GmON+niXX2j/
	IctD0rH4aWEo9hMzrnvO3YZcGi6uFcGthRACtfwMvwGO0HelbcFR0uXwBD9V05MoEwrgU+
	wO6TmRK0WmXWJp2xNDdAo0hhq/Vtf2NAfNi20O5ive4aDCnZodC16tniqyFQewr2Nsqnfu
	i5VwnWLZ8wr42B3Bzc0KPtK/ChPfmQiCLSl7dHs5fQkSJB/rqFcu0DvHVoyaLWuE1oKdr1
	IHkqH9N7iCwbC/rtj2Z6mWZSrpAWbV6QWBS3gRBHPMFoL0PImBd2wW3Qgto/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=aGifIxV9H0r5nDUr2mS8j+dEbQpGo2eXp7IZFc4lj9FqdVNgXi1cj0c8nHW1vIbeX/COso
	26jJwhUPQ9/6zVzFjbaoH4nHd9Dcrd2Cdov0g1KKWtYKAys20u1iIQ3g7UhaZ5HrN6bGZ8
	RR26K26ZhPjXyv26h5NQahtBrXjA3PrGrE7H5TPQ/TFx4IA/lyMs9mMSTK8OGrvYrf8ccP
	GrxN0FG/DSfjcqjioodEYlb11l5YDxZ/enhV3vEfsu5jiJOI5MnQAL7NunUw7Vg/qqrHQ4
	DIFD0F0vDOiyvNqeu53E7GKYrzayrx3Zmf+bMZKxbPO+qhOn4m2k3o2qFkLxaQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=XEEgxFxnF1LA6pBgg2HhDuE0ddzRwwWlhJbO1uLYabhRrBT5rFlo86XfhyLbrD488U+W2d
	OR3xMlKTH5W9si1nWfTDJ7Bi4BkGIQI/cTB2JBaXOWJeojhRDf5ZTwVN93GGCTNEKKBKEY
	zEmATxBk01Jkz+6DG+JItFXpTmvK0GssO9OMWFnFT6lsRI/EGIX8vezEeBITHvNOPl5Sfg
	jP/XVPYXGZimXg2FJ6eOD4pBhHbd61MMJIqS8JBIelSPG7QsK8pXip8J2i7Yt9f2ZNNPqP
	IcaBdFxUIlYwKGHZbxlnkA8rn4W+H1UCfPElJCGElSEDoyx0+aySjDbSqm/z9Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EB7F93802D0;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:17 +0200
Subject: [PATCH v6 01/13] spi: spidev_test: include tools/include
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-1-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq6Vfubvg5fvDXmrW7em3mn/94l3I9vHLT+LhWU8W
 vqsTMSPdJSwMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACYyWZ7hD+fRI9lGM7Ud9epe
 BcZnXWNYb3Baa5Fy1P4EyQXWovvuyDN8ZtHQsGveeUTy/Emp/5aCvmFu9+9JNYgbifu/mGwVyss
 PAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Add tools/include to include paths to allow using macro helpers.

Use ARRAY_SIZE() from tools/include/linux/kernel.h instead of
maintaining a copy.

Remove the obsolete comment with cross-compile instructions from the
header since spidev_test is integrated with the tools buildsystem since
commit f325b73dc4db ("spi: tools: move to tools buildsystem").

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/Makefile      | 2 +-
 tools/spi/spidev_test.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 7fccd245a535..8cf21ff8cd03 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -12,7 +12,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 
-CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
 
 ALL_TARGETS := spidev_test spidev_fdx
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index f2135d619a0b..bd5ee7a6ac82 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2007  MontaVista Software, Inc.
  * Copyright (c) 2007  Anton Vorontsov <avorontsov@ru.mvista.com>
- *
- * Cross-compile with cross-gcc -I/path/to/cross-kernel/include
  */
 
 #include <stdint.h>
@@ -22,8 +20,7 @@
 #include <sys/stat.h>
 #include <linux/types.h>
 #include <linux/spi/spidev.h>
-
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+#include <linux/kernel.h>
 
 static void pabort(const char *s)
 {

-- 
2.56.0.rc0.108.gf0ef1b96a0

