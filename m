Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2C502776;
	Fri, 18 Sep 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744990; cv=none; b=UlykrqNy3rFJkI32YjE855LGJiOF7NoPw12gBVnTQFmktYkAirXpnGK6iTwka14SoajnVG5abDKIPUXdA5Ks616DuNg8Yf/vYx9W0A8WIEN5wZBr+WWJAwfpp9Fe+kVEFhMonKu3bkutsx2bTQM3pkEJzjF8D87y+gt7li5icU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744990; c=relaxed/simple;
	bh=fL7MQlNOKmTkLIyBArEuxwuAjlxrPp4JGa+0SDpk/P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8kdxzhD9DNtPkJ0ta2WowBWc2LstirJafN3ghoMvvzg5Ao7Ub9aibtQpOemPCvXAiGI5xitZ5CjNoyF7l7RaufscMivJtLQJS8MnVHG0eZvjES5UzTmwHOJ+uHlocqHCalG/DEunrbW913g+8is4SF2TOKJq8l4nZU46H4dhZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3AA822018B6;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-0Q;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:48 +0200
Subject: [PATCH v4 2/9] spi: spidev_test: clarify help text for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-2-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=fL7MQlNOKmTkLIyBArEuxwuAjlxrPp4JGa+0SDpk/P8=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx6o8seuJ/TcRvMj5+TEvJ/pf7ZQ7fBg7DnnL3Cp+
 JO0/y/hjlIWBjEuBlkxRZZYNTkFIWP/62aVdrEwc1iZQIYwcHEKwEQ2tzIy/J/YH+3K9bHZfqpq
 xe2dU7Zc7s2WWmi7pzZaMVOEaabVXkaGR7GPnk28Gn9yndsR3gNZT851CgRvXd8oIL71OKOfbo4
 5EwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

It is slightly confusing that spidev_test by default transmits the
predetermined message default_tx but random bytes given the --size
parameter.

Clarify this in the help text.

While at it, make the -p help text consistently lowercase.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index bd5ee7a6ac82..f5ab67236fac 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -191,8 +191,8 @@ static void print_usage(const char *prog)
 		 "data:\n"
 		 "  -i --input          input data from a file (e.g. \"test.bin\")\n"
 		 "  -o --output         output data to a file (e.g. \"results.bin\")\n"
-		 "  -p                  Send data (e.g. \"1234\\xde\\xad\")\n"
-		 "  -S --size           transfer size\n"
+		 "  -p                  send data (e.g. \"1234\\xde\\xad\")\n"
+		 "  -S --size           transfer the given number of random bytes\n"
 		 "  -I --iter           iterations\n"
 		 "additional parameters:\n"
 		 "  -b --bpw            bits per word\n"

-- 
2.56.0.rc0.108.gf0ef1b96a0

