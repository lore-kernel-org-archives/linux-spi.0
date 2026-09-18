Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D8340260;
	Fri, 18 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735525; cv=none; b=l1CjpIEcw3Cf3GBR7pHcv40iOQzQNvLDhe2G3ygcMiRvEwe9YQDxf0tg91Q3hmRqNwk4YyZjJeaLYjQc/ENk2wZ6evrp3vUfUfoEBlLbxOvhg+3PJnrpyAbHWie2kcduR84Vtb2WA91wyNemhYv9GUU587u4CFhxrdLMT917Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735525; c=relaxed/simple;
	bh=EqMPi4ZVzC7cGNVME5Mq0PuQ5uT/iihcHbpfsjrz1Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sh64yCENroQNTq68KOzDq9tbodJ2PhYM3Ps8EtdsHJt12fqouf9pPnN2LdZNl+STr+Jl3msaJ5tGoTCJQToh80diTcf3hoCbWbhjSTyt/VPQ7/UY8PUFG/aFmldQUyBd/3w5X7dPUcfYhM+2b7WXzlP7wRCKMkOoooElFYUam8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 78F5320102D;
	Fri, 18 Sep 2026 14:45:12 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7Xxo-001Zaf-1K;
	Fri, 18 Sep 2026 14:45:12 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 14:45:01 +0200
Subject: [PATCH v3 7/8] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v3-7-d3ca218d9f76@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v3-0-d3ca218d9f76@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=Z7jsU2ZPr2fg0qvB9saNI9I/cjK4cAO1XrpxoxrZUyE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaaxQ+eYvVv8Nb7x82vfOveYHIbc6q992ZJ6qTiq6+f
 DUrgTXhXUcpC4MYF4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAivBIM/yturDu5Mqfp+rmF
 Di+SEzOuRl57W6Y6T/9d4hSdNrFb2zwZGTZpH87bmFJ25P5WPbmWXOFXlyy65398USUqfN6o8lr
 YR1YA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump its first up to 256 bytes to the
console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 6fb67021ae14..9dfd33678d89 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -174,8 +174,18 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), &tr);
 	free(tr);
-	if (ret < 1)
+	if (ret < 1) {
+		const size_t dump_len = min_t(size_t, len, 256);
+		int saved_errno = errno;
+
+		if (tx) {
+			hex_dump(tx, dump_len, 32, "TX");
+			if (len > dump_len)
+				printf("... (%zu more bytes)\n", len - dump_len);
+		}
+		errno = saved_errno;
 		pabort("can't send spi message");
+	}
 
 	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");

-- 
2.56.0.rc0.108.gf0ef1b96a0

