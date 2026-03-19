Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483913F0752
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939374; cv=none; b=HTO3pbcqSxfIymk1gywXoRMfwI48UPv7CcG/3zgzlPx+4jTKDF+zGiiInFgLoAAT8R4pFyklmOwQMxJy1/L22rnfD7BfTvwnakPqQ7wZVKEqcVOBm+47/IM4ZiQVlptHyr23/dxlUeq43PLOJ0VWGNBkURcYK5pJkJx7CFqje+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939374; c=relaxed/simple;
	bh=9AlK0jWUTCqrbfrUGkLnLcrwP0phLj9S1J9p+IZJm1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWxUe8FS8ZDfE3h3ufrc15kxKMIbWHf7meeadkbQpKgx7h0YmxmIrY8o5jardHY74Bi9lw5owVwTLsV+QDImuaO2TFlb+qJS+YMu6+A2Z9YyO8LiRyzvJF6IPQC50VO7LCQwabq3Rw8fqIhhvfEol1ih3jUdU6QW2aOk+XWp1kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054j-U3; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iU-1U;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1B42B508787;
	Thu, 19 Mar 2026 16:55:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:45 +0100
Subject: [PATCH spi-next v2 11/11] spi: spi-fsl-lpspi: make struct
 lpspi_config::mode u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-11-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9AlK0jWUTCqrbfrUGkLnLcrwP0phLj9S1J9p+IZJm1k=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcozXl79nT2i3zBMvvVj+aeSfoz0HmZ5f8Xkj/mnDtX
 EX7PylJlY5SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMJDGLkWHR5M7NHQ0fJZrf
 LpQ9Ezlb4NXlK43zrfaz7xDa/7vnSiAXI8My9s9mL/4LL/X/smJCu1+FnEx41SQrQ5P2PakmPPY
 881gA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

The struct lpspi_config::mode holds a copy of the mode of struct
spi_device::mode. In commit 937e6d756422 ("spi: expand mode support") the
struct spi_device::mode was increased from u16 to u32.

Increase the struct lpspi_config::mode to u32 avoid truncating the mode
variable.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 3265618704b0..2c7a1c4db4f1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -106,7 +106,7 @@ struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
 	u8 prescale;
-	u16 mode;
+	u32 mode;
 	u32 speed_hz;
 	u32 effective_speed_hz;
 };

-- 
2.53.0

