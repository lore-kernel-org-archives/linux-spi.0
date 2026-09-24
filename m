Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0638947FB17;
	Thu, 24 Sep 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252860; cv=pass; b=sS7hGo+l4MEj65OEYDNL0jQfnKNaJg/fbzJ/sOLuNP3yluVYtSOyPftKlcIf70yji5PReAA56YwUtT3UtvJ1lTw/V9evW8YEcY/9xvZDgPKvVFRJ9X5/ACxxpeu+jeTk+Dr6myf8k1nqJYsh4cDo9KZqXXrDPcpHqZkdAnVQEMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252860; c=relaxed/simple;
	bh=wLnuZWLOIlkfUcw7e90HDZh1rMjYXdmGLWuS+rODuBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxUjmZdisyKVKTsskN4CC9UdBAsML+2MJpMYWCDd1Uotz2LxYOy1O4USXkKvDLMZYrX6cDrbWPdpnnvPXooZjdbh5v5p2JZpyMTQQz5CVDHLbalNKKmGV4b+T7oBZM9a85fmliKToUX+6LGDsvkBTqgdFO/dYJKUKOqzhMpYhXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Q5lMG33L; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Q5lMG33L"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 460512021F4;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHEoCgXHfCtk+j7UEFuUAPf2u/XuEGD7yYuhesPUneI=;
	b=Q5lMG33LK6sNq7WK6wZTxiImure2Bm38xT2BOXpVumG0Vl6zdU5YhMm0Fji+DSOJ4F8fUH
	9+ykT5TqrtXiGVd/rj0BuRiDFcMV0KFIPMnUpnANyDg0ZpZBiurhFcVJ1YrrsxLCFEqqXY
	pTkyLdQBTbxIt3/tqWXWfwps25dbEIA3l8M9JY6Kj7C/d++Q+5mclRjbds0ifg1fszqrN7
	v8T2p4GrYVtmhIPmPUggSwLXumuJXYh+lw1OaaewIwZPwyf4A7rwGYzVZqmJPZQLfgq/Ae
	fAROGlccvKB8PoGr1oLl8vV1KTRIbW6frWMMo8aiHdju87WOoWiDkFHum1F3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHEoCgXHfCtk+j7UEFuUAPf2u/XuEGD7yYuhesPUneI=;
	b=eA65/e5dzxV1Yfz9+dBGMVrGPJOZtaZxxEBC9XlYEs4XddeICQS8/dERsf4bFIo4L33sa2
	TKtmfvS5WkUs2kyMbTy9bn6IvZqMmGK2IML3VKskJkgXuH415tndrrCEC1axNQA91E6Nrd
	an/H/oa+PSeYonSEPVBbutpOcHYHhUvU0ZRtco1aVJK1lOi1QNlSHiUHDHZMJ5rGyXMgs5
	ayZmHfF3Q9ISLId3OVI1YObd/smHrPUT3sPT0ahtosD405ok94DwqZc/V7feO0GxcwZzJS
	+N+KTnryE1YtvZ5Gid8GFU4Qq0XzX4dk0ZmkjzQMLRF/VQ369M7ZVfq4rNS5dg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=SeXI7b3oVZbEcUHHo3aa9xgDm26XYvswjg7TiFOOYtIT3Z6uk07qygo3ULAyvAH9p+SWnP
	Hztl+ACHTmj4yeTkogTSxXbbXOKyY02qFgaQmEOUUKomys2u4XZioxDQWe/qm3QTRp4Ebv
	JDS3kXrlu7RDmmM3dmBTXk+k2Yf2n0llcaD+2sTzfz0ZUl5J6Xi2xmBHTMMAJG267k0oHM
	4q2Bogbvk9U+BCy/kq0zBsjeMpQd0odi8ZxELERUYzByw5qlTZmOG1Th/Mv6rVxdY9N8rU
	s2sfXbY6cl9MTNBMLsYlI5WXRYYU1v7F4xNWtbjqbwhnZZ6964Nh7rBfmyythA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id EF05338184F;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:29 +0200
Subject: [PATCH v6 13/13] spi: spidev_test: rewrite unescape() to stay in
 bounds
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-13-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=wLnuZWLOIlkfUcw7e90HDZh1rMjYXdmGLWuS+rODuBQ=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKm5Q8FrYUbJm4rOcpAxpvoSJf19fNJnVsfR+/H3Rn
 54mT94t6ihlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzEeQojwz3nKSzdKfy7d4ec
 Xsj00eJwv6fFISu10L3yRskMH5dqGjP8Zsv+o3jIRi7kk2/LS5PYXQz2F3w3M00In8rkHHqKO/o
 1GwA=
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
index 2295daa37b63..089208c3330d 100644
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
@@ -452,7 +456,7 @@ static void transfer_escaped_string(int fd, char *str)
 			pabort("can't allocate rx buffer");
 	}
 
-	size = unescape((char *)tx, str, size);
+	size = unescape(str, (char *)tx, size);
 	transfer(fd, tx, rx, size);
 	free(rx);
 	free(tx);

-- 
2.56.0.rc0.108.gf0ef1b96a0

