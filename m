Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CDD480DEB;
	Thu, 24 Sep 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257453; cv=pass; b=eeAo5i1rGx/dGPS6vHu0f1HSnTwBfde+//L+qpQijBDxqxiSuzfubXAPoqTgSR4p/+oCV1ZhJ9bBmmHJClOh6VFc+/Hp4lEgB+t/GVmeoilwLHgxLh6RP8IKxyfwMrZbZq/QsSglBS+WCr5Eu93o71Lo2Du/syCB3x3byGzYxXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257453; c=relaxed/simple;
	bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CaxiHaeXKPxyjBam9L0iC9ydcax6sJyqcJfunlrqizhWIbEceA/w3rpfSaAoQUcvUjl17QPq79qp06qxt/eLf4LGycQLiczfXWMztmHGzH/jBeZyd1uZGspSplmWYsvAcpml7Zm+Sq7SolF5WoTMuhiEGDYujDpMOHNBdjmw0jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=PFS60yD2; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="PFS60yD2"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B2C26202108;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=PFS60yD2CbzMngxeDHzfv9F8+9Ig098P2fhVx8h8IKhm2wLsXBCiDiDq/tplKJncxHfiAP
	8Sb6MQa9tn4RKiRC19CcVyvvm+DdgGktz746A9w9g4IBIrCBzeQVsejFe5vHev5tRCk2oG
	t5/dM6Ciona1pyzRvAb4LFYSm5hRwAoA74jVY9OmLFr6WK+6JOOWj2vvPSabEdWbxhhVyz
	bbdHDLuo+ZpyNl9jV1O/JKLDe+NJ2WevhqK0UPJettGARVGwrnDoppQAqACt49QfrOtAVY
	IQkEaQZ7NezU+8YXnNPqaOt4O0Th3oovegYO2COLhAe1lKsMHd5SXhMlwUqlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=WCJR5gQkiqC0SRNQUI1Yh3jun0qATawBIw6PaxziJTcVqKw44cHVZYWFKH8galuPWlcZlO
	sGZGinBoDZedImuuc/af7P8jT3kb5sdDXFYw58avqdAIXaa8Fz/VUowtEjeq8QHW+8LfRp
	ZwIgeyZwkpajP4bAepOLFeNrgKDyRxB7tLG534vQ0/Bg8abM8dG25/Wrlp0feq76mbdIWc
	/WLXRo1O4kfMjh15cea2BJpTJh2Uh58rdD7SQ//zIpMjDpPAEaynSRlzuApzbPPQwVvrqO
	/flno9oPV9hr9zMW2pDTpjNZeOQb9TqoOodhhvwHlroWc4tZ/EFRIb5AOAho9w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=LHsotmozPWkO80wY7y6PPeBx7tPrNd+1S0JlgwHrZm7S7plmHVC0J/QhBNe86MPG31dFTL
	8i6OidKadOBts2NwWJYYHFggOJ8InP+LgcG8ch1uNED0R4DL1Gf0srbXgnHSObnB8oQMt7
	sjM7u9E4Ntt+nrBimcEKlA7P3xWWzk2Iious5veN1XKV/sFm9IWZqerBQhpznKLQ86KBea
	8byuxKs/gY0x4FiOq53Y9dpoYKVRRZPCwC6/Z4IwnX3cA2WojiZFEE85CMyky1RJ1saquc
	nuQE/q61CsNn+cxyEW8XkZVP868CI+fAnb5a13e7bD7NBOHAj2SDgPBplIVZug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 943A2380260;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:51 +0200
Subject: [PATCH v7 01/13] spi: spidev_test: include tools/include
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-1-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqmYp3RF734T/4bZjU2Xbq52T3zQtMCvr4V1m3Pws
 WOtEh6HO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABO5e5qR4XHKcvvvkR9OXb4w
 Z9bLW6JZK5R+y/T/v8gU+nLvtenrpx5n+MOn4VpwXnbt4qg1Ic8q448fMwhP//LReb5V7Lo35y4
 96+EGAA==
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

