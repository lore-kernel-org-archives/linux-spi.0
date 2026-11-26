Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720276;
	b=hKBKMD4ARhsTUUeqpfVIDNokzzt4aKORKyfueCbMTECcJ4ypIheGmupJOXLyRate8Wrx
	 97DdshHLqQfJ8xo8KydsYfc/D2c7AQf2WgZlCXClz6a7OucYc+0t7l+WUXXjbCi1cI+az
	 R0CyQDqJ86YCbyLCcpHmM9vlLxZSYtAxvbpNbW9kHWbOTIi/MalOq89xUx8BwN0e6hPbq
	 5RQ774Izj43+7vZPIoiVosFY+53U7kGK0ZkbYbGgSQnWWK1WcBUlI+HUj9H8vEAiyz6xx
	 TrTmQsMYEpN/LKabpAR3kca7M15QeO51ACc+WwP2NCMjcexGeOYW7DhRxu4wH/mCWXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720276;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ZkEjsyv0Cfkvd8f7cD7poUzh/Ooh+iJ1ptYcpqpt/Co=;
	b=nbhAVi/Jft3sogNTdanl3meUOmLfx1oMHHKrs1gODes5OA/wkmm37OsynbM5H6mxtvaQ
	 UuGpXCl+Y72ka5GyMy5TVv4NfnBFddi0kEtPyfwIIUK0CdLvQ2t9g3/XIA6ANmyofGXoa
	 vmLSzepaloq3RqeKX/VGJyzsO8KkvRreP3GluSScXhg2EAqlmX1v3sixsU+faI2Vw315B
	 QIjeJmGAImAzfG/C6j5U7RzyhFo3mrugn9xTFH9FYDsIXh4JFGsZcwKe7EmKESsdmax+W
	 yQy5G7X2s6aN4jVCU6r7n7+hQrtQA1UZHX4PFUWe1B2JlW2y5z29VPJEAy2u4uf3wGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v+eLEvJg;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F4606A334
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC2F4606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v+eLEvJg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 91D104E417B3;
	Thu, 26 Nov 2026 19:11:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65F0A60558;
	Thu, 26 Nov 2026 19:11:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF33311E691BE;
	Thu, 26 Nov 2026 20:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720269; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZkEjsyv0Cfkvd8f7cD7poUzh/Ooh+iJ1ptYcpqpt/Co=;
	b=v+eLEvJguOcqRS5QTc68UKAmP7cgXkWSQvtrJP10gsrR4GIm8jUgJX7n8gS14K6eVigD/G
	vqfhzN4qnO0s8svSIEmi+Wk79WlTZY5IFKIZ46B7FZCftqWyF7fVNZ+0VmQCf5VmD7wOPm
	ChiqXYHcI7lVyp1vJloiBap5Ww0o6W8jIL3e0ZULAIPmk/1rzoQsGDoFr/8I691UKeecFA
	2FHdOKHPnRFP39mbL7g6HA/aEvyDZQteRAMk4WcmTwA3tfsm/fB1P2c2UYRgZr6RiXgtH6
	gisn9AB+cqu6VLCBrqBkFyORX3vua3b1mrY93Ol+VMetMyMG44aJSCanQe4lUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:22 +0100
Subject: [PATCH 03/12] spi: atcspi200: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-3-ca8e924cca1b@bootlin.com>
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

The driver clocks the dummy phase with the data buswidth. Reject
operations asking for a different dummy buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-atcspi200.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index b532c58c0ab9..dd39323eb37a 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -396,7 +396,20 @@ static int atcspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static bool atcspi_mem_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->dummy.nbytes && op->dummy.buswidth != op->data.buswidth)
+		return false;
+
+	return true;
+}
+
 static const struct spi_controller_mem_ops atcspi_mem_ops = {
+	.supports_op = atcspi_mem_supports_op,
 	.exec_op = atcspi_exec_mem_op,
 	.adjust_op_size = atcspi_adjust_op_size,
 };

-- 
2.56.0

