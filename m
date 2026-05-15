Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A843D090F;
	Fri, 15 May 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840847; cv=none; b=LCg9SN8yb02NninT2dmdPZYQDYTHvZBmrsc/nluVXcDflKctVr0yN45H2+hO+4IK9Wa0ZoFCfCgif1/TVczOBr9Suom5useIgNmaxX+pX+iXBLNYJwRbb7FGaYzg805qGgvUokD6728fTEtq2hebC1b/Kx6O4DNbAIlpRaJXwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840847; c=relaxed/simple;
	bh=N0MpeXVggpdSvGIZo7r4q3lzs5oPRKsPc5NjRMq3JAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r4yE3NwB7LnA3/Y56vr+kSHDbWwnFBfQuFpPYYD5QBrf/9uigMnS6eM5dL8PB7EWu/6/k2vMJEXRaGO0JTZqOmvo2m5/clyqbGbbiJofAmjFP3/Sz8rT6hIYQ7qiINBoIULfGtchiLv4drCF29R5pN7NhBdK35L0XzSWs14lMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=c/ChKAF0; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="c/ChKAF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778840809;
	bh=w2XlvVVUSZJ7S5C2n+QUlhcKejKS7GxjQp94ZlQZVls=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=c/ChKAF0yz3pmnPV2sxj9VoqRIPzKuJepLbo7bYVbJPp9GTE8Xa62PCfgVsMi68BG
	 EvODDb4OAWHGrZ3D715bq+7mU1iag7Hd8UCEyVQ7GNlXBfYa/b95SQMdNdhPxxb6jn
	 9JXy9Q5pGPkP4XSpyOdQK1k9TqzEymrsvOQbBAUA=
X-QQ-mid: zesmtpsz6t1778840803t0500f61a
X-QQ-Originating-IP: fkm09Qhq7R7R6uGUGV2qXXuy+5tR1/wAvwSyAcJqi0I=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 May 2026 18:26:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1817803177890170576
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: shenyang39@huawei.com,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] spi: hisi-kunpeng: Use dev_err_probe() for host registration failure
Date: Fri, 15 May 2026 18:26:20 +0800
Message-Id: <20260515102620.1926930-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ndw/mc8X39ObLYczeDAmBLaaaMEP4/1C59+YOyXokc04v8iUKH86snJo
	NNL6Z8vwssLAH+8JisF3SfaJe2tG0b2VpXpbwLqbAwTKCsnj0J1ZaoYfkLRwJv3PuNSrDoQ
	9LYJMOUK9spiS6yaXYrhYZqz+pxt5l1U9Bqj+6lIwjV+cZvntqByyJiGaRYOZhCINC2vbuc
	J9T3R3AYlgt/z9Svr6aUVslgZNaTMwmvIz8SakZt+5ZbNxIoZ/o3D992KCV6N3CR0IKV7Fm
	PQg1x0/d7PoNc7TaQPrKvhJD60OTsyg4J6KmzHQ8cP9QQoUSEFD2CzSN928spt8ouWM3vg1
	3YC3CfYMtFFQ6TLuus7uMancZo2MSOpPzp1/XEEmIA3tec/jmDhv9gPeG/ZQORegh0FZtas
	HKDBc6E/eMRZmP71UibF8fcYmByEzzL13pkXytcbTZGPbMhRRq02tqqSy93SozEswBRUEBk
	f631AigFeMjNmRWyIirzbkposWmvwJkWbmxqqB4tKGX5z65rH3A179dFCcufjeKmJV/bZeA
	oRGGbMlEKSLzrOKuZnB3yXVupoGWxwXliEnYRvvRxrNNnKOvLiGptW1rEMM2aDX/BtUoeOm
	H7zuYC0ZwTPxU4D/L4TvO2j1t6wfqVCi1hyd4Bv+Q6n/WTRUSsePgxbD/p8+7RZmYUfEJEs
	LXz6JigHN9uqRsjOH17xyK6AObh8MreAvUuD/wK9KlUBHG+gk07yz5HuTC3foHzT/1yATLd
	q3CHO8lT3OF6ppSkjYdxLUblJHwY0oyS1TjBgPBMw4N0Y39wtmaLw9xt5AbKezDkfd8gM/r
	ECIrcU4cSfTZ8Zu2dhpZkrJFL1PEEBCq4UiXqO9kpQCE+G/8rXhr5AEmimnRf3ChNvRE9wB
	b/eEoXslA5NNqqoM/IqFZFkO5AaI6nFHb+kmqFVfBN2zGdNVLH1r+2+HBT7TdpCZMIzblM5
	0ZoB7o8EDFBj0JqPwlQOeUjBEcMxHvdQScD+Z0rK4vV1zqqH4PGMHvCRQE+NX7ib69Nj8Wz
	04EOi8bVGBXo24X8A7qrGfAdNXHZs=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

When the SPI core registers the Kunpeng controller it may need to acquire
chip-select GPIO descriptors. If the GPIO provider has not probed yet,
spi_register_controller() returns -EPROBE_DEFER.

On a Kunpeng system this currently prints an alarming error even though the
next deferred-probe retry succeeds:

  hisi-kunpeng-spi HISI03E1:00: failed to register spi host, ret=-517
  hisi-kunpeng-spi HISI03E1:00: hw version:0x30 max-freq:12500 kHz

Use dev_err_probe() so that -EPROBE_DEFER is reported through the deferred
probe mechanism instead of as a hard error, while preserving normal error
reporting for real registration failures.

Fixes: c770d8631e18 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 046bd894040b..395214b81179 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -520,10 +520,8 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = spi_register_controller(host);
-	if (ret) {
-		dev_err(dev, "failed to register spi host, ret=%d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register spi host\n");
 
 	if (hisi_spi_debugfs_init(hs))
 		dev_info(dev, "failed to create debugfs dir\n");
-- 
2.20.1

