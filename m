Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6534DAF87;
	Wed, 16 Sep 2026 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580504; cv=none; b=VCqQ5d/z1CsuT8ti/Yt0OuOZmXWcV/H3aJk5uNSNax8izEu5tQjCQTNqy/Y+t9SdCWdn1jl3+j5M9co098gttsjM0da3e9lGCgo+ad2hfF+FASLFk0YkaV1715Bxxr0nzj55FelbrZ252y6fAX/0O5HExHsoJ8UrY9g425Zdni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580504; c=relaxed/simple;
	bh=AD1URK+HnrOJEzAB2nmAHcQI6H62TNiIISUuQGItQUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+L3Jl0Zd7lH9gaRIJ1QjzinmRfydw79lNQ6mcYROFygqD8yVNzZWcph1rL2y8j3cecfIeRdN67SnUJ+vyE/dGQamPJulMN3N97xVJkhsHmZWai8hyM6mm4TCyHz8gcJkwqvybUsDZcGK+XW2K9nXkb6J8DGdcHtqn7XAWDKUV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 91051200A7A;
	Wed, 16 Sep 2026 19:41:29 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6tdR-001Gol-1Z;
	Wed, 16 Sep 2026 19:41:29 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:41:19 +0200
Subject: [PATCH v2 1/8] spi: spidev_test: include tools/include
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-sun4i-spidev_test-v2-1-e7d25bf96e4e@pengutronix.de>
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=AD1URK+HnrOJEzAB2nmAHcQI6H62TNiIISUuQGItQUQ=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadeXopK0iroFvJmpoPcq8s+anR5DZvECPPycbpufeU
 JwhYHqbpaOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRrfWMDJsVLpSGp27ozDSp
 OjxP0y/O5LrN/rdHZq//H/0n8In5h05GhmUP/6oHL7owyW6/0n5/TfF7Eb2L2W6mftHUFH7ropZ
 ewwcA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Add tools/include to include paths to allow using macro helpers.

Use ARRAY_SIZE() from tools/include/linux/kernel.h instead of
maintaining a copy.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/Makefile      | 2 +-
 tools/spi/spidev_test.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

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
index f2135d619a0b..8058a7830b50 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -22,8 +22,7 @@
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

