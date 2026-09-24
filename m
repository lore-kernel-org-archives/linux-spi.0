Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608FD48821C;
	Thu, 24 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257463; cv=pass; b=gmnu7lYXcjhAClUKu4Tg/e5lDZrPkbQw6oUCIA+MgeUFDqyMxhg10sHrLaWafMuEIo6Q1MroQIDSnlkltxH8PpcuW1B9aQK22dvu4T4p15mup+7GxT1no+G3GeMAHBE2jBSt8Z7b1vNBRlnH06TRvNDZOLIaFK/NMRMGzQ8e1nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257463; c=relaxed/simple;
	bh=0T7DcRAuELik/rSt1wTrbR4IY17VdO/v6iCTw4rwGm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyN/F+oWb/oq8oXlvAsZP9aO7wL7l1XpNPf3nPOyDEeDGsyb+YHjXu7LFNGFvuO6/3Hyso4Y1czCdYLus+luKlvSngHjJIi94gzs59CyFdnqYusy7dT9Rd5WMPyA77X1BMywFHmkkBqKhvRvIOWc91DuNF51gBBHDfcyLO5DMnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=PWF+SAYc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="PWF+SAYc"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E4CF5202202;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xwy3ZsDtoqlM9KQt08kn4Vry6A0bfmmb520mA4mnaGw=;
	b=PWF+SAYcOnPxfNP/4NRFK6up1eDW9HGJ9dnJLWCQ7rUXR6B2eVdhmEGju1Pm7rn7MC+pd4
	qoTiiCrizWeJjF8wTqlpnwcNhgbDhJBAJrMT7IhFcXb2+j0qjm6sT7Q0zxAHMXniK5+/JZ
	cwT/mgFWbaEXErGzoP02fICmFlMBU++oLL/2vqTfg5anqflH3g7jd6xupZK0QGBepXi3j5
	DrqdI7ncwpXKGw8zpHD0lMGIrlT+K6WA91slmxvGL6QDJtb3GGeqFnksvVpPBleZJb2zOd
	62uAyQKj9GvBtVcRGE97lsfu4+/F8ZxUmjBZE1HSkot/uRzuxhH4h9UqyXFBFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xwy3ZsDtoqlM9KQt08kn4Vry6A0bfmmb520mA4mnaGw=;
	b=SV/Nd1E4xGIxMtNeKxufCRcmWVN4RyBKJGFlFrqI1YQS+p5A/JnJGDCWtU+9otAqKzBbNw
	1FNpRr6rpt9f0eWVlmIWqUMKXCcNUGMnP5fYTCdK1bydEdk9/7D/4zWk+MuU9MiZBhbPBg
	t3GkpOSL654KGYHG9qXLjx9nSKCGZulfIU/gWxBH4Zb3sgD9tG+PvFpihb+e1dsDEs/Uif
	DJ50z5GTMwNVwxB+/3cvdw0uZ4wSIGOY3V3z2Ih6IySYF14ln9Ugeg+iMUj7MEaqucBHAS
	4vM86x5JNMfZ2jRfia3oOrnY9OCfPJre3TqCcBk924rwSelDwa0x8AcAas3NjA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=FWrj48XqzLlHhWsr9pM5v8JQJ73yRnG85+xC8QZGVOO1KlQ/IyQY+ADyEVLRe664Kf7QFn
	I4DKSkea+pBGiUG6E3yDY9VijiUiwJq/oY3xZOHJvAcCCu3YRR2LBgP3R6AAbH/odb6l0E
	MyBMeUU1Hmddt0JO7Xpo0PlBrJDXdOTrKGRNpHOS7n0f7ehwCSeSJPVZ1a9xUyn3wTzHen
	P5OVS8GVOKYl8ctJmbsYyn6Dn1IiiDIqPXJ8bpiOr1FWMmNKXgWFUbpfCjD25bk8DrJEyY
	rqUcw71xq65qvUsqowRnHt/ovmFtip6jweDtT4IfrPaVNIW3AyMRElKrnLMTog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 97397389215;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:44:03 +0200
Subject: [PATCH v7 13/13] spi: spidev_test: rewrite unescape() to stay in
 bounds
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-13-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=0T7DcRAuELik/rSt1wTrbR4IY17VdO/v6iCTw4rwGm4=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqql+jaPX+eeEOQFGjed6GN7zR5fM5zqy1fBC6/TAx
 RmaZR4LOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABNZmMLwP/BZdHNQzivHI9z5
 7w1vm700Z9hgVxXuuZqTe85lk9Umbxj+O9atn+Qa73TVkWmlR8Kp7GZ2sesFr24+FpiRurJtcvR
 6HgA=
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
index 61951ed1c908..5bd3159f61a7 100644
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
@@ -100,28 +101,31 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
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
@@ -455,7 +459,7 @@ static void transfer_escaped_string(int fd, char *str)
 			pabort("can't allocate rx buffer");
 	}
 
-	size = unescape((char *)tx, str, size);
+	size = unescape(str, (char *)tx, size);
 	transfer(fd, tx, rx, size);
 	free(rx);
 	free(tx);

-- 
2.56.0.rc0.108.gf0ef1b96a0

