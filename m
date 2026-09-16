Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E54FB9A7;
	Wed, 16 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580524; cv=none; b=jEuTg/IZBfwQbpasINLg9j0yIWXlcVdTE2henwt0EOf6/e+516aBe3OFS2bqyZM+//KEnDTdGPsZ7bzjyS7wo13K2E3pc/nvOJCb9xun3W6nXRp6M1wuYuKQ6Ca7WC/i1JLUZ4ZvhVmTh69GS5yJ6bF8LnQF+5jXDQ1RPGa5ZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580524; c=relaxed/simple;
	bh=k8uqCdrwxAKZWOP0WarryWspJTDMEfd/+4102GV5LOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpknbBAKbirj1WKK7ajBbQmUQgU+GapXLgW8zfhaJxEkJbIWeXqqWe+X8YHGZWzJo2I8NtrgojkYqbDgxP8I+4JKmZBLcamUIsadfV+aEn4VNVuD2+VT2L+5szIxtasZiVbu3CmyVt/l+PG/vGVS9WPloFP/cyFeP9qUdNztIog=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DB46D2059F1;
	Wed, 16 Sep 2026 19:41:29 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6tdR-001Gol-2X;
	Wed, 16 Sep 2026 19:41:29 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:41:26 +0200
Subject: [PATCH v2 8/8] spi: spidev_test: rewrite unescape() to stay in
 bounds
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-sun4i-spidev_test-v2-8-e7d25bf96e4e@pengutronix.de>
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=k8uqCdrwxAKZWOP0WarryWspJTDMEfd/+4102GV5LOA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadeXEkZk/70z6E68140fM52lXv1ZJal9elFO24kepw
 6YnxpNPPO0oZWEQ42KQFVNkiVWTUxAy9r9uVmkXCzOHlQlkCAMXpwBMpHAHI8PzS7sXZO76JGcx
 h3F34+31PAx7Px1PZVY3ahPXTv66cpkvw/9S44rfKtMLAhmOL2+MEcueXb/OqEpRbmKjvOT8W7x
 mgUwA
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
index 93867ebf39a0..a076fb4037e3 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <errno.h>
 #include <getopt.h>
 #include <fcntl.h>
@@ -97,28 +98,31 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
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
@@ -421,7 +425,7 @@ static void transfer_escaped_string(int fd, char *str)
 	if (!rx)
 		pabort("can't allocate rx buffer");
 
-	size = unescape((char *)tx, str, size);
+	size = unescape(str, (char *)tx, size);
 	transfer(fd, tx, rx, size);
 	free(rx);
 	free(tx);

-- 
2.56.0.rc0.108.gf0ef1b96a0

