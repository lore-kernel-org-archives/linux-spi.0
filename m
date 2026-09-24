Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565247F763;
	Thu, 24 Sep 2026 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252857; cv=pass; b=W2TtBjvLLwbvfritksdSBG6swhVKhdpXKqPj7GPyGSvv5MUFJs5CZ3OExz0xdXIPCkJkzj2gqLTNNRzH+kjP6MjTd234goRabz+L/EtcPWDWElm/ArLxsU7KGiFVJJ9dR1nE+VkCXfWXd6NtGuIudIcRhbAPZH/KQAS9ywimPok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252857; c=relaxed/simple;
	bh=aLJdTcfY1SJeao33nULpegw/broOjWVZMJ2Yyqfb+BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SawLufLPuo0UzoPbcuoCBVVZXg4HwGC4010eXcsY2XdCVd9vG7mHyCjsw9DJbIlfe2/sU0bSLnTx6S+MUwSNbJJM4/U/0uIhVDAGs4dxEZGJN9B6OTv15NVTeGejyLOccXNKSyrWFP/+fJnhlEMVYl1Ej0U/cGmJpeIMBLaP/jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VYn0k+VB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VYn0k+VB"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2DEBE202139;
	Thu, 24 Sep 2026 14:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4dO0JnHDZwqU78fXcDoZdrLvSPchXUhEENin9s9QI=;
	b=VYn0k+VBo4wXMzEoRAVrf/9TinztPXG0IhotSVv6L1h7KMc25/sna79GupGpL+UmO7iUiY
	fN/ZGT3kKah2iSm6V9qTYswc1uuLzBmlAb4Np/tAtMMZZQtMTWZEDcwXgP7ilWZF6S+5BB
	aHTqeyR36Lt9b7xlUAgECBvnu356OXiSS6h5eEh4R3Jo1BAs6ajD+luJ25vCTtsv86TqzO
	bOFEgCWsCN2BAfhgNPoirtxN3+ysAjzQlVYC+Isk3hZd2xGvJlaGCDO4tKoqa9hLepZOxU
	7ECUuMjGO/jg44iKLLuitI80ovu4PQ6C6UBtMJGUqUEvee0r8NydJKFmIdzNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790252849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4dO0JnHDZwqU78fXcDoZdrLvSPchXUhEENin9s9QI=;
	b=KkTLODAK/kWcYUrjfEyKUZjMz1w+5TbRGOxRWQiE77oo6Cz7Us2SqLKmQbn14BTegPmYNb
	1+xbg9jKN3uaqSDKAmnbCHNzcsFNyKsDEjNEXR4x8Yc059qMxi23sk708j5D3MmO+p3FfZ
	V6+xrTQ2l0eweQqbLhE1RDva9M7M3W3SSh/B+feobZytb9/ZKhlzu1UwV2GoufwIApAi05
	JEpVC8hoCLfY++9NWOdWXmP1h55tppZlNJlWrlIf18/8syVEyNZ65f+JIKE28Cbn7FWWBP
	rFUy06pNZvLmE5KGM50QsRv/5RE9Z5lH9moBmVAzyK2rG/uS7siDkYNIWAEIhA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790252849; a=rsa-sha256;
	cv=none;
	b=XTcxCs4LjnwXvF1Pi5ILxC24yXumNkK+jThQaV8VamdmXwz3moPh3tdnuRWLNSwEC4a0XX
	/X+2DydYrtIYQe9W78ZC6mPhdNbFtjyq+lw2OCR+cDi0muIfQJ3ubb2EeQ18PjEXdWVjZ+
	PdH83UWUmeWGRIapRcMVgGHtD8odWx8faY57/TtSUcuweZw+hSV6uD0ZIKHQZDY0jdJpgP
	b/ba/qPKw+dz5XwQIaLkOfNWh9m3DRbs1fsVcksOzM/hP7r8ZSEM3oYyM6DSRSMpjT+K+C
	gT7xsc+zgQ0lZAgBzjRMOPb/3KCA4zPsyXRDwJmU1tnElbv06RgxIjSoYSyOOg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id ECF42380600;
	Thu, 24 Sep 2026 14:27:28 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 14:27:22 +0200
Subject: [PATCH v6 06/13] spi: spidev_test: always compare loopback data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v6-6-f9c3a8bb8308@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v6-0-f9c3a8bb8308@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=aLJdTcfY1SJeao33nULpegw/broOjWVZMJ2Yyqfb+BE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaKq4re1DUTYvhOuOC6sctNdEfveqqdfK+CbrNSlwuV
 6r4rsC9o5SFQYyLQVZMkSVWTU5ByNj/ulmlXSzMHFYmkCEMXJwCMJFOc4ZfzFGKXE0+/xKumQsK
 8htujqnn0lJVWfEg63ntmZajxkKnGP675At3Jzal6an7Jyowb1X7nXj/+8RlGj84fTN3bLv5ewk
 nAA==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

In loopback mode, spidev_test verifies that the received data matches
the sent data. However this test was only performed when random data was
transferred using the -S switch. Always perform the test by moving it
from transfer_buf() to transfer().

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 97d09bf4dafb..e46eaef4d2ab 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -173,6 +173,15 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 	if (verbose)
 		hex_dump(rx, len, 32, "RX");
+
+	if (mode & SPI_LOOP) {
+		if (memcmp(tx, rx, len)) {
+			fprintf(stderr, "transfer error !\n");
+			hex_dump(tx, len, 32, "TX");
+			hex_dump(rx, len, 32, "RX");
+			exit(1);
+		}
+	}
 }
 
 static void print_usage(const char *prog)
@@ -435,15 +444,6 @@ static void transfer_buf(int fd, int len)
 	_write_count += len;
 	_read_count += len;
 
-	if (mode & SPI_LOOP) {
-		if (memcmp(tx, rx, len)) {
-			fprintf(stderr, "transfer error !\n");
-			hex_dump(tx, len, 32, "TX");
-			hex_dump(rx, len, 32, "RX");
-			exit(1);
-		}
-	}
-
 	free(rx);
 	free(tx);
 }

-- 
2.56.0.rc0.108.gf0ef1b96a0

