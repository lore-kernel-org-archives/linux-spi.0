Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A139768F;
	Thu, 24 Sep 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257458; cv=pass; b=sAWg/na7TYaqsYdMw/iCmpxZL4VcgXn4vApCz4XIA/wLq+xlWryiUVfmdbYY6oaAGHC8lYnfzsSA9sYgIDjyatOkvviUnaBCV9Ca5k//L/6vRriSLsoNv9z5Pb37U9ylTuftpAJHzQdHbROd18M2jbHbTK4Dciq+6RPaqINc2NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257458; c=relaxed/simple;
	bh=aLJdTcfY1SJeao33nULpegw/broOjWVZMJ2Yyqfb+BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZuUWemj1rzNkmiq7m5bfKuq2Pa+GY3H0bs90DdrA+OkewKQloAkVlcpdiLI8yBCugTBrGkO3GXMw0dUw22Uzj7KRpgfg3SueofgfrWDc1fFUvFSWoOAPNElgIKXUfDLDkDRnfV9FTFn8mVf4R79bf3d+wr7jNrwaMlwPEGu/Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZnvYhXn+; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZnvYhXn+"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C7AE3202136;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4dO0JnHDZwqU78fXcDoZdrLvSPchXUhEENin9s9QI=;
	b=ZnvYhXn+UAo9D9zE5B5rMZAa85AK74OkLG8aBWVrO7MDCQZ3vRooKNJiTiWaOe1aWdDoSM
	fpVnLdUnI92lZKTSLFro+KUEOekQJZf3hZvk06aD1tbP9fc9ZhIVbDRpnb1oHVkUkesrK1
	DlGUmKwmd6irj4ACnvly8X0PmrZzTjnKpUPlKqU7sTG/cu0ASTEyHINQLRkeXZBsIYbe3Y
	ekGqn3+cgG0OmtXCQvKvd9/M3JG92As32MjLLp1vyTfOGQBY28WjtB7r+lro2LwWgVhwK5
	OQYrdyUrIeETR2k1VdxEHXfJcNEjjDeLRwu8HDlTJ9ARHd5YTw8dx6drbogr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5m4dO0JnHDZwqU78fXcDoZdrLvSPchXUhEENin9s9QI=;
	b=WZIVEJeJoQ5v8xKMAFPEj64BUC8ml67Ac17ivX68YJuWQT7akSypOFBZF7lc//ZB/GCdZ0
	ZzMA4jPY1scaydhIaA+fxUj4bLphvczRVb2N/j9aKIX4HIUpHH7xZjFlFlMuq0LrcuuBFf
	QDZgzpLYz3S79SE9VJU6VUWwlGpOqtqd2jShVi5x4Ls70Le08rT25ErvANlNKQJSl3vvQ4
	mlH0BSEZ1dVj844BgPWfe63o4uZ/2WTCLjuPv4cyAX5NIsReQHjz67l3ev/VyDbP7RI+mJ
	iMxnAKBDOg4wsXPOXhuQlvISjgzgnMs9yTIo7iT/qOGbMkWNFRq4tNUG/o465g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=UM6MBHxt2srIJ3lkl38Vghm3pzsOy6FJiH469NC3L2AEDpbRc6HQVQDkobknCphzcDaI30
	PTlemSH38gHHL1Im9Qz9gj3fKNECbVs6kcqySo5zLgOIeY0aReo24lej0v8gzisCXKdeIK
	+W1HAco9z8cAvMXkD53i4oGJylBezPUPninT3IsELnJfWY9XU1jmUQMV0ekjVfB8eJtSGC
	Wkely3NQB10rS2uxh1bu+vWaCSm58Va6fSTnYGDq3ahE5hVLuMwmCzGy3HIMBvPtsYgEUV
	3Kex7J6FvVQhjA5onMjyQZL23vD0KhcEwFme5TNBrZQhM+0aU7Cs+WtHXn82bQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 954FD381110;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:56 +0200
Subject: [PATCH v7 06/13] spi: spidev_test: always compare loopback data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-6-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=aLJdTcfY1SJeao33nULpegw/broOjWVZMJ2Yyqfb+BE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqkc/CB7bp3OFr1pG9nurdH5olIy4YdOaouM5Nu0h
 Xtf1zeVdJSyMIhxMciKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACaiv4SR4SDrbYY14ZdFMyqT
 Xv6eIZZ/4t0xRo5nbyS38Ma/OXzkVCPDP80NUr4bbsg9e138cu+Bo7eFslJ42pK3prH+cl7yy8F
 /OicA
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

