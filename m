Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420BC481FCA;
	Fri, 18 Sep 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736018; cv=none; b=QdrdFwfyllR1oFnhZVolmZuJmL0ptNopuWxpPg914Iu108NH0lDbYTJZLZRu2UhbYTik1O+L4u037aWEYveWTPH6UGTGZD6Cxx1OeCCZ8Jw32nf/Ob2LuxeHg7XRrNnre0537F+ey6JjJUrNU19WVrUraQ/83W0quR6phbx3QWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736018; c=relaxed/simple;
	bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFi4K3fw46C7u3nVhOIFyj81Onnh8UcSYxsY0wQV7Ll328Urv0Rm4FCy+X24sIhpf2d7FOgN1ZpfZa/AkdCfZ0dTYPUE4Nkfm4YkhIq+bX+4wsCs9rvh/wesZOdYmEoVLcM9WXwN0dO+O7gnGdcc+xqkYazHmZVF8tHbm/1liH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 35E1F200591;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-0M;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 14:44:55 +0200
Subject: [PATCH v3 1/8] spi: spidev_test: include tools/include
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v3-1-d3ca218d9f76@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XzJjoVhnb/s7cdDvuM4wM0NdbOkb23/JUb5yHGelLtw=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaaxSieMOjTeFWXgfH3QN/z8/8eV7n9eo9mvYxF0IsZ
 LRcwo/Jd5SyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACYyrY+R4Vta4PyHgp+vcv9t
 XutbIpn/bYduXuLH3fZVN51UDffHuDD8s23K26CRVv2mc8GFo3alLnlSkoH7Gc/sWJic3MKnZH6
 XGwA=
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

