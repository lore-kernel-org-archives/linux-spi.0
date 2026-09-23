Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842B583AD6;
	Wed, 23 Sep 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194541; cv=pass; b=M/RB0Yro9GaF/bqosQZ4y5mJGgBIvge9Arx8nokw3zqWNwE5W49So946s4lVAi84pjYPwYY+2Zl5F+DDIwkJQ/BM20+qXFOZOWRzD+gGKDaVT+5l/ETYYsWTHj4eb/Sy8fVSj6hK5sWnDbcpvSVuYZPK+JadR0Qn52qMamCuhtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194541; c=relaxed/simple;
	bh=F6iuSlRBHUPpEkzHoyAb63btQbaFk4ykHXlzVsIJeTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfVFcbGIirU5G3CLoRZWhRZvvDqbacT511N4OHo82iPmNrf1d553MFv/q1/Ft+smDmsgTfrudwjauJenEfefC/Xgo+k6XmemCpaBrssJ/icR1IhkQGi3KhZOq5i7Tua90BbMAiAxH/o63OmoC4jhwGBN2xPFGFO++dfue09KkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NoX57OTU; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NoX57OTU"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2FAA32001BD;
	Wed, 23 Sep 2026 22:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz3gekaE2Dtt1mrgsQJUUQGDaLI+/G728euVd05MQ1A=;
	b=NoX57OTUHw3ywTG1SfiFKa/C0W0tDK8exOHapGFsOFLRaoODZl/T+KEHm6A67BGpjnQYix
	UxVSOgCZSsSA9aH02zxzkdAO/jXRYh4FCOtzcI/8G+Rcf+3sBn1PHIrB6Fyycprzy15mV6
	Z0LoBO0EOln/a1owhWj267EPZbxTni4eWDTZvrMcEl9AS2kVvINNb6HmwTA6NPBT/IjUy0
	uZYhKnCU7xk8v1XXhk6O+EOcX1oZpsgx8QKHihHvmczwk567ntnRbz3iF79wpUpRYl1jYq
	vbHJzfGCnZxmTS29wwqj+FoWbmiApD1TXvRTCuI4mlw5ntZoA88JdXnjM7upUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz3gekaE2Dtt1mrgsQJUUQGDaLI+/G728euVd05MQ1A=;
	b=bl+5wqrhWWwIsFXtlM2YLY0qM7BmuIYEYYmB2otP4V5a9kzfE1K3mlFc2LBHyjAaWVfCVM
	BE4a0i3FuNNALzHLZm/HWRaAfuOwRgjfAG6fM0yFC692GF+TV+BiS3mJRUMs4WH6KsGUe6
	6C6XONJiTBAttZMY6tmts8fDjs18FRyvRvJt06SLpkWrEXkI9RlsG25+BNkPNmUibpE/Op
	BVnYFQ8C3cAvWePHSGbhzE7qDbsDC7chLyu9gcji9FcAqMZnfXD3SS1gRllKpGLurVHd2c
	tgEpP2/n9N0DULCjh4oAobIdUt7PBVgWErrC8vGxLFlxlNHxn+gTHkPKVsoncw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194528; a=rsa-sha256;
	cv=none;
	b=YY4u+WLkONjS76qQE1UBka0s/y3u5GZCyz+GZyXOUS4txbUVQQ94DhvqBYpTWxa29l/xKY
	hfu0mjta3xCl1/bsw4WByCeNaXWRz0Cp8H7/Cdcnf5g8MwZLygcsL4Cr7CJjkRl5V+wJzq
	T2XcvD9vFB4A9+tF2OQIU0nEHa/vHOAaWqdunXgtrj8bm7mYO2Ux/+c8D+GRuyX2lrNfM6
	vP9AH1AjRyVTtqSwWJDcFseo6ad8n7uMS2pkRxYCPLd7I5UWlljVuFIrblonIqI0N+HnFz
	ePNGg+ZR+UKdNh4V49baRCoCjgccOZgMUVax2kAR/1jRhLSri6Nz/Sj+B3DZHw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-2z;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:08 +0200
Subject: [PATCH v5 13/13] spi: spidev_test: rewrite unescape() to stay in
 bounds
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-13-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=F6iuSlRBHUPpEkzHoyAb63btQbaFk4ykHXlzVsIJeTM=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiTnt4pr1y6vayVL1Vm/lM2b47Ngaq7XGs3r39c8D
 5q5we4Af0cpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAi4pMY/ilpvfioGvin4886
 7YmyCxbHV4pws2y7WXnlZOM1g5XThSwY/qeLzu22+2aZbjv9quSsb7/2H9wp/DPlYfOJ9TJxnZu
 el3ADAA==
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
index 6f9e04acee9c..68fe583c3f7c 100644
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
@@ -96,28 +97,31 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
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
@@ -439,7 +443,7 @@ static void transfer_escaped_string(int fd, char *str)
 			pabort("can't allocate rx buffer");
 	}
 
-	size = unescape((char *)tx, str, size);
+	size = unescape(str, (char *)tx, size);
 	transfer(fd, tx, rx, size);
 	free(rx);
 	free(tx);

-- 
2.56.0.rc0.108.gf0ef1b96a0

