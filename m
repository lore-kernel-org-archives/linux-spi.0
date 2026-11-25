Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629159;
	b=V2rR/m3Vny6DcYLo3bQ62yF8h2wrS3o1V20j0Hj1r5yxg1MCVaCYWAMoZHHBaaoLnUxZ
	 Xw7Qrx53ZOVhwQn3aLWT4oAilM7xog8l2NgQAtR2NlgLIeaHt97JxeHtdzDpfzeJBZBaw
	 aOtV/Xt1Su30ZJVqqlJpkj+Xo7fnsCMasID9+wMSXJAgphTpZ2Xe26qNrq54XAFgIzLLW
	 ykkPlFgMm4U0SfiomlkTpS0YkhfE7YdkjOKgq12JQBC8ussjxBbo5GEHRWx3MlvJ/PJ1k
	 AYEY9PbRLRKEs0wby7A1L9uKxoXoIj4dxvoOp5dcmlLwlLA8ByFf3b9OrRxMGD2Brwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629159;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=cB8ERaf54ceIobkfi+P1+y1V3nLqzohkwuRk0Ck5Kv4=;
	b=iBbu87oLuC1iLB/hywq9iaLlyLQCbu/840J1qBW7TN+b8k+aA/rhr8ilxbSRMUGo3EVV
	 cc2rmcWmq4D0gZfI3UYhUJI0O3lFxzpkOPV3LVgHZex1muQUmUTJvxFa44TueeJKgUeNE
	 uwzrwfVsmICE6cnOB2KUpQQXOjRwob01TQs9PjFbO/WA1ICszShdcVKGPBs9SzqPXT7IB
	 1Jp235NgnLIIe3ussw9UwBqbxvk6PAeobCgGJpvkJ8xxb7CBgmR/Mtt+x0okJrfErclLa
	 /rdnqxiB0VTviUajHYMKk7QpaPJTLm0yfAzv3f6YjRAobtYDIR1l1+mwIjMdCQ7s91Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ouWcG3I4;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD760A261E;
	Wed, 25 Nov 2026 17:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BD760A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ouWcG3I4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CF0E04E41789;
	Wed, 25 Nov 2026 17:52:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A37B160480;
	Wed, 25 Nov 2026 17:52:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D4D511E6B0D1;
	Wed, 25 Nov 2026 18:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629155; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cB8ERaf54ceIobkfi+P1+y1V3nLqzohkwuRk0Ck5Kv4=;
	b=ouWcG3I4Ncsf3bbLH8YHWAHCMo4HHl+np7P2+zwFQ/DQi3GjhcgPShJUDwCcGCVPvQ2+R5
	hpxDVOwUjlfcz7jyoawSnPcO93n99dd3b9wVvsIr3pWowOPWrTOAM6NN09QWahwTjydzCt
	jmgckOEREt+2Ws+uo20USUe8/IwrOal0NWwwK2FGsuPtFb3w3SG8zWINU8IhIKAH1AS8Kl
	wZts/MI7cV2f0FLuSPAhIkqD7yadTKc/uZZqEpo9qnP9qU8ExG+qJabhIWQ/rirWoKI/ec
	JdaJDygcx+r94a3NGaPvC7iM831kL7hUWwDT/YfxvGlPjLvQiCZy3vFRJwwsXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:24 +0100
Subject: [PATCH RFC 10/16] spi: nxp-xspi: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-10-fd036402fd37@bootlin.com>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The spi-mem layer is now capable of providing the dummy phase in cycle
units rather than bytes, provided that drivers advertize the dummy_cycle
capability. Since this controller is consuming cycles and currently
converts bytes into cycles, flag it capable to consume cycles directly
and drop the extra conversions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-xspi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 38c8d6269aad..8b836662a5da 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -392,7 +392,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes)
 		ret |= nxp_xspi_check_buswidth(xspi, op->addr.buswidth);
 
-	if (op->dummy.nbytes)
+	if (op->dummy.ncycles)
 		ret |= nxp_xspi_check_buswidth(xspi, op->dummy.buswidth);
 
 	if (op->data.nbytes)
@@ -408,8 +408,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/* Max 32 dummy clock cycles supported */
-	if (op->dummy.buswidth &&
-	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+	if (op->dummy.ncycles > 64)
 		return false;
 
 	if (needs_ip_only(xspi) && op->data.dir == SPI_MEM_DATA_IN &&
@@ -453,12 +452,10 @@ static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
 	}
 
 	/* Dummy bytes, if needed */
-	if (op->dummy.nbytes) {
+	if (op->dummy.ncycles) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
 					      LUT_PAD(op->data.buswidth),
-					      op->dummy.nbytes * 8 /
-						/* need distinguish ddr mode */
-					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
+					      op->dummy.ncycles);
 		lutidx++;
 	}
 
@@ -1307,6 +1304,7 @@ static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
 	.swap16 = true,
+	.dummy_cycles = true,
 };
 
 static void nxp_xspi_cleanup(void *data)

-- 
2.56.0

