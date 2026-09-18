Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A225038E1;
	Fri, 18 Sep 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744995; cv=none; b=Ea5bfdPYvfUbxWRah6ZhrraDrm+MJw+LtpXlhUwxm0EnHjSQCt3YS7z4QNM1u31KYXWDnBScySXUDf/Cud5TTFGxtSahUGiTrVq7D9jRVK+FPtk1VAjZ6rscurPv/u1z6a0WzDnTEGQOjF2maeZb4chhinVCmTv3Z3O1Dgu19p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744995; c=relaxed/simple;
	bh=wnXKMJ7G5RW5vLHYwJMCyFceR++MFwHGc1EJvqp7jJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCqzAEFDNlcmP5g57w0Ysny/tYFxM6HOV6jhunU1rAlEGCaQgmNwFO5PzYGG3WLId3YqvmYXLnC0f7bOVY7M70vjKLL1Gwj6Y+fwX8NJguIyWsRd/CJOM23BsbykAS6Y3JQrZhTs7OD1HQ21RCWrr/Ep5j6KA7ZEFfE2zMRd7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8C27C201E03;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-1S;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:55 +0200
Subject: [PATCH v4 9/9] spi: spidev_test: rewrite unescape() to stay in
 bounds
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-9-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=wnXKMJ7G5RW5vLHYwJMCyFceR++MFwHGc1EJvqp7jJE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx7yT3XZCWH3HeHsStxB/pPvRbzZIMUU5xlZfJB5r
 dKeJXMzOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABMxS2JkeBS+uS1F83SN206j
 PTKLtSc/bxJUcSvx9/436fdRN+06KYb/qQyrPyz8+9Z1WZNjf82fBgmtZ0s5914vXH5i8W7pLPY
 UZgA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

unescape() could read the source buffer out of bounds for inputs like
"\\x" and could write the destination buffer out of bounds due to lack
of checking against the len parameter.

For better readability and consistency, rewrite it as a simplified
version of unescape_string() in string_helpers.h. This includes
rearranging src and dst parameters.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 1910facdd3da..95d5d37788ba 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -11,6 +11,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <errno.h>
 #include <getopt.h>
 #include <fcntl.h>
@@ -95,28 +96,31 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
  *  Unescape - process hexadecimal escape character
  *      converts shell input "\x23" -> 0x23
  */
-static int unescape(char *_dst, char *_src, size_t len)
+static int unescape(char *src, char *dst, size_t size)
 {
-	int ret = 0;
-	int match;
-	char *src = _src;
-	char *dst = _dst;
+	char *out = dst;
 	unsigned int ch;
 
-	while (*src) {
-		if (*src == '\\' && *(src+1) == 'x') {
-			match = sscanf(src + 2, "%2x", &ch);
-			if (!match)
-				pabort("malformed input string");
+	while (*src && size--) {
+		if (src[0] == '\\' && src[1] != '\0') {
+			src++;
+
+			if (src[0] == 'x' &&
+			    isxdigit((unsigned char)src[1]) &&
+			    isxdigit((unsigned char)src[2]) &&
+			    sscanf(&src[1], "%2x", &ch)) {
+				*out++ = (unsigned char)ch;
+				src += 3;
+				continue;
+			}
 
-			src += 4;
-			*dst++ = (unsigned char)ch;
-		} else {
-			*dst++ = *src++;
+			*out++ = '\\';
+			if (!size--)
+				break;
 		}
-		ret++;
+		*out++ = *src++;
 	}
-	return ret;
+	return out - dst;
 }
 
 static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx, size_t len)
@@ -425,7 +429,7 @@ static void transfer_escaped_string(int fd, char *str)
 			pabort("can't allocate rx buffer");
 	}
 
-	size = unescape((char *)tx, str, size);
+	size = unescape(str, (char *)tx, size);
 	transfer(fd, tx, rx, size);
 	free(rx);
 	free(tx);

-- 
2.56.0.rc0.108.gf0ef1b96a0

