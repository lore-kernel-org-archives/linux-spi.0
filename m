Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F3572681;
	Wed, 23 Sep 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194221; cv=pass; b=UOGZuQKHuuKztZ+DeDuLKLGBPSa45wvSKVSVRDj8h41NuiPZ29RXeyc5Lp80DATdVcCzUW8O+qyCSDWoD/dS9Op55El3fboG32yNsUTnZHxNReqpWraNI5SoF5DWs+ocUqRRMDoQr0djzoHz0CFKVFnOJGbRoJ3jwJGFrKsihzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194221; c=relaxed/simple;
	bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcghDlSgNX2gGf2cmvzHMn8RiZW6HEki7aH+ebp11DFrSvDCiiZ5EecIMAnWNB5zMKUQvko2ufWDMVAweyJhcwFRb2AsfWapDPgAHfCBEFh8egsUDMB+sB+Ccx8k2OiTbDzhDhN7JFH8wZGhzZv3Av8nKWLHIe0SpH+upTPzA2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=QENcceiO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="QENcceiO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7819F201F09;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=QENcceiOlNBoPloKPJKuH0odVJwdGPUAA+GTaApNnKYOg62323T11UrFGsnTUvGBPWNhQ9
	AgfIB1rYMz8QO/Do1JkFQeWw5qHCJ/uazHgO89A9sP7if9pjDVUgSxwSPiillHhC1baLlL
	pox/l+l/sDhxr06qeZyhf2NrZSpbcC5T1SeeW9GBfJmp0I+Uk8HRPGUHvIvG9alL+8re0c
	n0IRgZk+VE3ud6v+yNXlA2pIZKp2XGjf0OmioI6fjeHi4tC9QGedo5sCeIuAP8kMu5c4SS
	zNGyPKCavUKBukMVURbolnIKl9jAl0m99OuToRvrOZR0axs7U/UZ8Eco2oNqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXC3cfYABYvUUoB5Rrruor3jNI2VcQ2LV9agEBgud0g=;
	b=GXWlouSfBE6T88HPU57xQNFaH2TA3OQIR0cThn1k0EO/3G/Jm25OeUkilFQgQMl3vSdzzc
	rSk1HvHUhc5tNn5Che9XQnDnJtRvGGe3ujT8TRa8g10Jsc3eXqykkBIE6PO0FB7xule9fb
	iK9vyUbgCr0n3g5tUxnNd6wRTDAjbVnRYg641wXpQ9B36H5NJeU5P9WObzBj4TEJNndrM3
	vCufku5HDBIeDbtpCJBRi6V0wieNPd0kfbAU3lkKhCQfxVZaYgDPVyFzKL4aI1MsnyaofR
	ZHT54l5PSq6ftffPt6jI5Vi3XhvM8SZfhm/U/HmrhHApsGdvEKBkjPTTPt7arA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=NbAQBWnl7JTh5H2laqpBNBG5Hfqp5s3Qy4fdraW4oQas8OJBhbOsVV/gWcY0TOX/JqY81G
	nsWHJJyHlbBJz0xXUDQZbkhODAi4Oww43U4g99qboUgaFUSX27LzmvjvF8B4MvnwKj4F/k
	Dn1Tq+i6k2dgVlaAhjkNZWnoxA97wkZR4SzrxMkrlYdlOgdyzJkVtYAIpdtwjz9UrxgNJg
	lJFk9AOoQDJj7c8iahgV5mgawhRmwf+YUkZm8xWHtS61Fabgj+FenCFdxVW2Gfq5r6iTCw
	tnuS7WtoTPRljC8IJvm6jiY3ndQvW+UYZxhr1RyehFi1eqI9rcjmLcvhLvFwNg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1I;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:09:56 +0200
Subject: [PATCH v5 01/13] spi: spidev_test: include tools/include
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-1-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiSx8/iMnzmxCvWiobezkhcprRaZGyP8iLf5Q2zBq
 jNsH2KTO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABOZ3MrIcEHjw/FKPu68HNs5
 82ZVV63rZXqq4bAgjYPj4MJrO+INOhn+px6auzP5X0D++q7a2Ulcb61nee7/23t304wG/pzmcN7
 L7AA=
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

