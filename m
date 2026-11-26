Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720295;
	b=GPYV97qbaBRsuFschVaw45Py0Vd95+nzdDQfA7gMgIc72gY6L+V9QDLMmlp+pxWxW13g
	 LxBf3pvF1jr3TnYiYbjgFlGnjfR2ASepXboxZQ7rcaT/v5bIpdQR45VLpo3YPJ1X7k/xk
	 5nH2ZIx6++azisSC/4Jw6B3tE1SmuuwVcjmVTjbggo7gRFxHBSkz7cLQUKV+XqflSrr/g
	 t1LDzezd2Bvh+kdo/1DUpLDt7FhyuabxCsBxhkWb1v5lJH31yVE8i7c8Ivh5cZH4grLBa
	 2G9Y5Vkqc3lLqj5mT5DuslwPBfshm2LCA2HV5BMw9ZvU4QOXczdhGElMYitMpBhakUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720295;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=J3cxwMSjfPOfECyzSF0/c9jEyI6ns/iThNgz9XnWfH8=;
	b=yu6CRNzfjO3MDymDrPh+prvZpwetyyZau+tNiNEm/zvx3CdWx2LdWOC0j83Yuj4ddaut
	 1s9PSmPg+HtsXr+wfxWn+TwUtXwxecits+bKtSHTvyLApbvX1opY1HCSHGi1bpMCXn267
	 AyylPUZ8i+gV6+WanCC5amL/ZwZGiVLxecNWHkXFfUj4ABK0aed8bs4i4qKnBNblEPk89
	 nPQLY6fBd3wJyWRMpeoxBqpsys0EAq++Keq8U6KixSqq4dQPzFPBQfiDtgMp3nzD5VUU3
	 EUGgPp29ErKLNA/XVv8jLF0qx0wGDsA1C026RMyhKWgZZSQ0gR6+nbeONg0jYzfMYgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="174A3/ER";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB7606A31C;
	Thu, 26 Nov 2026 19:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCAB7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=174A3/ER
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 799CF1A181E;
	Thu, 26 Nov 2026 19:11:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BA2F60558;
	Thu, 26 Nov 2026 19:11:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99A1511E691BE;
	Thu, 26 Nov 2026 20:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J3cxwMSjfPOfECyzSF0/c9jEyI6ns/iThNgz9XnWfH8=;
	b=174A3/ERrUkIvgIWug2p2tUsHS/lB++0dxxlCKdVMV+0MQXdyO8lWS1K3qyRl0ofvGa00c
	zCobdVMEzlFwpBlxd4Qr+kb264D0XGXIyAgwLkO4MgqCSLQ2UXJBjvRow2RBkPFurjFA+o
	FQiChGR9MvudZKcERxMobRb/LeppKSOaoMCIwseO4cQnFigLR+ypqSqMcV8VLN5FN40Asz
	yx/T6oPghjdCCZ+TJ5OhSlowT1bkXvORv/i7QJoi41Qqxj3WVHeyELJJchueOyU1fJy6pi
	+KBKni4xKI6mN/kXHTBjunMYLs8OstioERtiX1j/adq40Qouq/DHpc7iWU6eUQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:28 +0100
Subject: [PATCH 09/12] spi: mtk-nor: Validate the dummy buswidth
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-9-ca8e924cca1b@bootlin.com>
References: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
In-Reply-To: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Mark Brown <broonie@kernel.org>, CL Wang <cl634@andestech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Yang Shen <shenyang39@huawei.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The driver only supports the dummy phase on the address bus; the
read mode is selected from the address buswidth. Reject operations where
the dummy buswidth differs from the address buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mtk-nor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6b6e55d68048..350b47fab7e6 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -317,6 +317,9 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth != 1)
 		return false;
 
+	if (op->dummy.nbytes && op->dummy.buswidth != op->addr.buswidth)
+		return false;
+
 	if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
 		switch (op->data.dir) {
 		case SPI_MEM_DATA_IN:

-- 
2.56.0

