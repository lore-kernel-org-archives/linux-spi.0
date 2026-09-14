Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F72480353;
	Mon, 14 Sep 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397481; cv=none; b=bCB/Dm+KxaiW0rtI3LiqL8M0OMbG1q+TE9E2smn3swDTPIJjVm8Io4HLW0L17Q7Hm0B/dqmcFAaBiJ1NHOTYSchETbZPN8soIxKp5bXnQeIBxGm9kyz79jLMcXaVDQxCA/EOL1spJNCQU5RFPXc4eG0QAtky5lOm8kx9OAan5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397481; c=relaxed/simple;
	bh=i7nVqLKILpxVpHuKbhfxPrfth93N+P5gXgDMz73NGXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PK3aPK8vDk89h3T9e0Y3RVV9ozSmqBJu4/QysFr8TMAO+EcUklMzEudAm6y1tKwn549poBZx408ocz6W6UP6uIyBNQKDBl1RpAI2XhwSDP86YJ+PsCYw8GmLaz2P+RlLazg9yAu6uiGTlp7I1+n8noSAbOo2sIk8hcWwoK+dSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5539D202899;
	Mon, 14 Sep 2026 16:50:55 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x681H-000v8b-0s;
	Mon, 14 Sep 2026 16:50:55 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 16:50:46 +0200
Subject: [PATCH 7/7] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-spidev_test-v1-7-72d6a3b38cee@pengutronix.de>
References: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-spidev_test-v1-0-72d6a3b38cee@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=328ZDv35tysIK4Nb8SjHRitkIjJ1rI/eN5uNPgFKQAk=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshawXluzveaLx9efLHZH2V6b+2XL76L45TyWsS3f3W/6
 LAqzKXUpKOUhUGMi0FWTJElVk1OQcjY/7pZpV0szBxWJpAhDFycAjAR1+sMf+XClnrPmRZ/sbqc
 zenMokUTNu+zn9rtlJrssvTGJ8vrK68xMiy8GBqzZG3mzNww/97zLdVdNXm66S3ZvSuDvuvGX3y
 ZxgUA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump it to the console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index a07c05f2d8b8..7f5b314b9e67 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -175,8 +175,11 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 	}
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), &tr);
-	if (ret < 1)
+	if (ret < 1) {
+		if (tx)
+			hex_dump(tx, len, 32, "TX");
 		pabort("can't send spi message");
+	}
 
 	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");

-- 
2.55.0.806.gb8242b093d

