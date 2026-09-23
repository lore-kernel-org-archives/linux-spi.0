Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCF579832;
	Wed, 23 Sep 2026 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194227; cv=pass; b=jpHyVl3lkXOLJjj9TjjP2l7kewxEnCyRCqOLdBNcgUHDWB+/xnrEpTcOMbcnXnh7d7XFVCp/bX/isiD5LDy9AAXhXP7kqq7dfQlxDpc9wXA8WpVO5zzrF4zq2kHmXuTBo1xDTUQtx+nU1n1R2RgF1yX5fJiETNszqiu0+d2q80U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194227; c=relaxed/simple;
	bh=BAf6ybYHqGLaY67TLJairVs+OSZQm+hqyxN3QmIs8WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGoiGhVhybV4cLzHs9kgSpEWo32v+YKHLpM64TMNh0xsj4IuNeUkASjRkeKHU7HUAsBQFTn+EDWhmAkAOgZM7/tgewGgcxiNKYMPBbPfqpdWa4Nrl3v+AfCj0moMdEo62nFa20XKAWdgF71GeXJmS+LpAIojG8kPzRRHUAsCoeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=SrLf9jCU; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="SrLf9jCU"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AF7E820203B;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKV6zegCMXeZcEXRIitHSXcCkbJ9Sz412lcKIhbFRRc=;
	b=SrLf9jCUSvZmzRo++pjvvJOA2Be1QuZms1CXsmIkIQFRZjojmTzNXkeFj5j1Kj0nCkclTR
	JirlZucnEpkdQ6h6H+q3ml0XiRK2jKhxndaUIVUhruwx7dlOOZ6JedZIi4jvXU/ltvORAC
	OXqVarBMyvI9HVHOwUki84okePkHnb8Xr+0DM5fV+4ChzPkyHoeLh5rKzuEQpPoYC2MqZ9
	s9OI4A2r/uuSu2g9RDAghfKXhfsbUXoMnoco5qxTvVTWJyt/W/jQA8StHTX+4IhYLMwJlc
	HaJ7iEBEW8euMvnfXGiTRZqgFO9HuQXsQ/4gwPxykkFHOY2MslWupUcA/XYRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKV6zegCMXeZcEXRIitHSXcCkbJ9Sz412lcKIhbFRRc=;
	b=LQN7n3NUOf4A1xpvNZ03zvefOuCWbEPa2DKPtwP9H2EILYVSn0F3KjX+BYAlrcuh4KTarW
	TWS6tyE10Jk72mBRO8r3ScIEoE3vFFLPi8lcT5VHvWAYXEGcRCpz4RGuhSvIuleQedQgnS
	yhax7O9hLK1jWw8sA0yGDuaCdYnTDktyPUfcJ0aPi4VpzoP+daiQkZ5Ifa4fZRrfwwhns1
	/YKjMgkbq5UqIy3X6izQ2yB3gMKWj7feduppkwdp4ImdGeU9Zj1l5OM0GrnEEio6HKAnKS
	cyJqypN28bkinSmjjCVKwT5oNnStUkraKUI/e0rn2MCZ+4jUG58MjnOLH2hSvA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=c8hMLiR360v/id4u7Y1rGSh/FmPefjXj6hZhFu0RWL27N/gYZnsALQH2MgTJjT8w26dwSr
	c7GiY3e5VEwF4woVqfh6mefCNMRZuGPAr+xEt8bVIDnv1qsyarDyzGtZbcD2pQvGsni7p0
	96f+RE57PrCz8pNU8H+/bqNvbNObqPtguL5jDuIrvU+xtRtlZguUZCMg9hQuHY6giHZmDn
	93vNRL360DQ+Z8NQjs4n1kNHLAJuSBubUVC5uzAp0cmpQXBCnpyUB89ruL8ujGDB+Ipu0m
	z4XddhG2DMwz7oTBJpiHx6EdYM9tboIY8r+fVzA/iISet3kL55sowVh/FjbyOw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1z;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:10:01 +0200
Subject: [PATCH v5 06/13] spi: spidev_test: always compare loopback data
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-6-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=BAf6ybYHqGLaY67TLJairVs+OSZQm+hqyxN3QmIs8WI=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiStfka/7sSO0+//xy5RtJhmFbTr/pcD7dWLXAXWx
 J1MOlu+uqOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjCRQm+G/yWprXsrrveL3Nq4
 ZY71icv/mf5vdmzoefblzOLf8XX9X3gZGW4aMfj+9T+bcHJNaz5TSI/ChI1rWt0/Bn+wtYi/vjL
 zIwcA
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
index 45c2b691bffe..b413c713174f 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -172,6 +172,15 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
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
@@ -434,15 +443,6 @@ static void transfer_buf(int fd, int len)
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

