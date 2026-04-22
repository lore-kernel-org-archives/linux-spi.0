Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CAB344044;
	Wed, 22 Apr 2026 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871015; cv=none; b=DetidD++QJTikqhOz+NsJsrNAEWOW0Z+t5Vn89RqhXgxx9FSPuO5188IKyai7vCOkIwTAfEGhOqtGwEOZ8XwPNlFiVDKwdNnjnLDycp/0f0BnreSC3FWmpX8tcJY5eYM8bfQCL5k2bFPDKWoYVXhpCnfItUKe0y8TrWGAVDc6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871015; c=relaxed/simple;
	bh=mm7l28cn3pCYCLf3GVDEBAVzraqXFwXdDi0avE3W0Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeBA2wtR0DorNUwJ4DBa6o1QNxVyFWiuEiAmWyip7SGqNmIOJvc+NKGFhsCZVlo/X4OgyRxdtg2Sx4zHSMYamz58tWoHUvCe29IWL2UT7DlpR+/e9ud+FzlYr7b+GDQSMrC6+x76Y/9juVYnPb62EUMcDDMQ98qpJGkbLwe5igY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPRCAYl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPRCAYl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B76C2BCAF;
	Wed, 22 Apr 2026 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871015;
	bh=mm7l28cn3pCYCLf3GVDEBAVzraqXFwXdDi0avE3W0Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPRCAYl3IEqxaXl+anejQi2GVfTs7FdWGaN7t3FXMVHbrX2wFpQXNewX0NF0e3OEu
	 4lNSuPHaeGt2yObFfzopY93ZcGC1V3s+fNn4d824Si9heoiQpNL3pFVu5z8lUMyXSd
	 YsxqPUmOaU0rqv/1IVxaI4QUVlWnapMuNtsq8kXPC0dZnOBfTf2UEYl5Ik0aehYjSK
	 Wzool//GKVKzocTEcC14O0/8YzN324j3cqWblv8ljCVfy32IBR6yswG3ucUQt0aWY2
	 DpZNhCdBTsMSlQoFRbYxexqmJBeD0BLgdIvjDEHYYsFI6pkZt5npau92VgwxtHW3Tp
	 nypy/fID2UciA==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] spi: microchip-core-qspi: report device on which timeout occured instead of which controller
Date: Wed, 22 Apr 2026 16:15:44 +0100
Message-ID: <20260422-apricot-wok-76d22d53d5fc@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qRF8UGHvy5H5R9RLjT10J+zjZQsaD/qbyylMGRr28JU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvnjlkBj6e7DNHJePXpJb9jcvkVX8zrT5a6X1E/s+2v rd5Ey6Yd5SyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAi6X6MDJM/WVmsapYtFVw6 03CF5em87baLS87O+hZz5fC3q/sPlnQy/BWbxiWu9Dxv1Z6odD0rTw3NsCVic2xvnQ+T/HvnuEr EcVYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When prepare_message callbacks fail, the SPI core already reports which
controller the failure happened on. The corresponding code in the mem_ops
portion of the driver already reports the device a timeout occurred on,
so make the regular part of the driver do the same.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index d39b04f9b6b38..629f785bd230b 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -635,7 +635,7 @@ static int mchp_coreqspi_prepare_message(struct spi_controller *ctlr, struct spi
 	ret = mchp_coreqspi_wait_for_ready(qspi);
 	if (ret) {
 		mutex_unlock(&qspi->op_lock);
-		dev_err(&ctlr->dev, "Timeout waiting on QSPI ready.\n");
+		dev_err(&m->spi->dev, "Timeout waiting on QSPI ready.\n");
 		return ret;
 	}
 
-- 
2.53.0

