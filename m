Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5933EF0A7
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939376; cv=none; b=kr0s3Jbg5kK0KMbgyWoFrwQ6pVf+/UENDOnsj1j/n3nTBz/eLRTNOqBwFceioRg+yQ4TPcyeFvYImfvaNe0bcGhfkNNbOzSRG9hz0dT8sI+QkpSq8jvQBYZwUI9+4DXAVSbJGIRqr38M9ua60sQMfnUhqSgnF8zfITdKjvR4vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939376; c=relaxed/simple;
	bh=dy11iQJKxpsIuMdWWq+CSR2WKBQnNeC1vmiLhqqUDtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7I613HRoGWM2LdNCR00RI9sfcrJDunPsWeML2LNE6GumVK/NonuvLzLWehtVvR9O9wB13JrbEQRAHpYYbqfHtZxIUffyJIrWTyvg2aT4NYX6+CGvemwXdJPVjkpermL6dOvhsEKq9KUnV2CFE54VVykxuKt+rG18eqpV/LrEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-00054C-Ij; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-0016iH-0Z;
	Thu, 19 Mar 2026 17:55:51 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B8D18508781;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 17:55:39 +0100
Subject: [PATCH spi-next v2 05/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd():
 remove obfuscated and obsolete assignment of TCR_CPOL and SPI_CPHA
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-5-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dy11iQJKxpsIuMdWWq+CSR2WKBQnNeC1vmiLhqqUDtU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9Vrvu5mXZNJ0I5bP1l/bv8c1m4YW9/W0TU/rn0r1
 47jE0t6OkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARdQlGhm+OnjUzUmobnulp
 blslM8G433NVt3H8kkNBnf8CZ61NSWVk+PXiivXqQG/dO9tjtRds0bac2vRQy8Pa88TaTU6KLU6
 bOQA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Commit 7ae4d097b752 ("spi: spi-fsl-lpspi: Handle clock polarity and phase")
enhances the driver with clock polarity and phase handling.

Among other things that commit in fsl_lpspi_set_cmd() explicitly set the
bits TCR_CPOL and TCR_CPHA bits in the TCR register depending on their
corresponding bits in the SPI mode (SPI_CPOL and SPI_CPHA), to configure
clock polarity and phase.

That change made the assignment of the lowest 2 bits of lpspi_config::mode
shifted by << 30 to the TCR register obsolete. The lowest 2 bits of struct
lpspi_config::mode (= SPI_CPOL and SPI_CPHA) match the corresponding bits
in the TCR register (TCR_CPOL and TCR_CPHA) if shifted.

Keep the better readable and maintainable version provided in commit
7ae4d097b752 ("spi: spi-fsl-lpspi: Handle clock polarity and phase") and
remove the obfuscated version.

Cc: Marek Vasut <marex@nabladev.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c20376da1d37..4cf73e56d2f2 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -294,7 +294,6 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 	u32 temp = 0;
 
 	temp |= fsl_lpspi->config.bpw - 1;
-	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
 	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
 	if (!fsl_lpspi->is_target) {
 		temp |= fsl_lpspi->config.prescale << 27;

-- 
2.53.0

