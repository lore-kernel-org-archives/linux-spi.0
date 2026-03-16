Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93E38229B
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650398; cv=none; b=QYRtNgfXXN9g12arrRCozdTbHZaVLovS8vcuibRfU8nReFBhNUimEsuwtWwv63iPj03TC8OiMdFiP2fO06M4ZBMTX/G5QJGFoPgKt9d8TRi7ixX7yhxOWnsbXY7lsOpaM64F+rEhyEMjqMooZgn5uLrNV8TyGNa/oG7OhVYGnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650398; c=relaxed/simple;
	bh=lXUNGUc3oMf6fcKTpcyTQn+I/dkgp7Q2clB33fEtKlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iR3bsqSSKhYYv7KhKboPNslzT6ieixtH6OxkV6viuQVjmjNpCXAWlbFhm0G5f3xii7N4IQzSt0vq9EXKpXt52xPNEzeJgx2v2FIGcc0V2758SlS7iD36F3lYsWTOXQ0GYJtUtdD/S6R1O7x9fM0CEpa7CSRHluS3KfeZgiu8lzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005S5-H8; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-000XVR-06;
	Mon, 16 Mar 2026 09:39:44 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C060F5049C6;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:10 +0100
Subject: [PATCH spi-next 09/11] spi: spi-fsl-lpspi: make struct
 lpspi_config::mode u32
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-9-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=lXUNGUc3oMf6fcKTpcyTQn+I/dkgp7Q2clB33fEtKlA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvBY9X/VsvQyjk0aPaYpO3wj59bdnx87X/H7ogkWy
 yU9XI9XdJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAiESsZGVYtfZ11OPj19HVz
 Cha9E9daPJNbntXCI/a/zSZZtdYbkc8ZGVb+Ybn898Pdbvv3fCxua3guGQvN+XZnmmzSJ70V+tV
 dfcwA
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
index ae06bc06f626..9ec5554b4fc0 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -104,7 +104,7 @@ struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
 	u8 prescale;
-	u16 mode;
+	u32 mode;
 	u32 speed_hz;
 	u32 effective_speed_hz;
 };

-- 
2.51.0

