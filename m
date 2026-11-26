Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720298;
	b=OTyj4WYvnRXiYDIlzRZitPIBT7HFEwUHt2GI9Sm30Q+lCqVS8T34hJdXpmjKR5nwq+E8
	 2/5QObAUjiAnL6qPK+odYeFXkfiPar/RDcZ3eGlQJ96U73p0QCet4yMR9xBQMteRysAZa
	 w1nPtpDdr1iC1r6DiZVooKooLduWyk8Q5Gww9QVUzv2RGZhBd6ScSzHk7j/ztmfKSDfNl
	 16Y99TGGVUXO63dF68irmYzaI5s+W2J+wAlbTlpFkjlAqqxAlYbVk7BT/iQwTcOVs1b2B
	 wL/lnitlvPw4u0pAtALr4NyUGJE7c8NgBY1/3aUY02WwRSsc+YdFobbXrKMafs+rkrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720298;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=i7gxalmiLhHmcckVMO51VU3QHF8nXJ3bZMl2E4pLf04=;
	b=drzehDmcSYWWBc1qnVLIhXF38HjgdEEQlVU2KTLMAPtTF9dq5cPb3rMGnLlWr939nVS6
	 hczKCr3pODhbZu/n76z+zT44BRvF7b7NAtVSRA/zKy4JuMmIM7ypSbgJildT7JvFe3bMh
	 +0gkzhPeMKwt+n7zD0lpA59qGmXrmat0bLdu0WJXcK4Y4SQS8XOunW4KxUEw/k1v+UBD/
	 wxL/vTIZsD24e/K3OZgA/yCDyV58E++nwMlcKAWGLTfB/Gp8aNAoxjJD90cg9QCrIOwzJ
	 p7oN5m94QAPvL7d9CGGLdy+5pKj+lPBiyjcwQPKlBnSeOgyY4/zL/jHICX2SOSIIKuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K7OM+J6l;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F090606A32E;
	Thu, 26 Nov 2026 19:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F090606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K7OM+J6l
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1F5FE4E417B3;
	Thu, 26 Nov 2026 19:11:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1FB360558;
	Thu, 26 Nov 2026 19:11:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1306911E691C5;
	Thu, 26 Nov 2026 20:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i7gxalmiLhHmcckVMO51VU3QHF8nXJ3bZMl2E4pLf04=;
	b=K7OM+J6lB0c+4nh0y3NjCEHqWix2fgly+ZZg86tp40mGcmdLgHcI/pJQyUEOLBwhQs0l/0
	K0GDwg/dK8ZcYbEgJvPnd0ff9FJOLSWN+BvIq+V5cYJv1zlRXFRddROCPqDK/A5Ye6A5z3
	Nt8C35I9mt2LVleBtkSWzrTYkfsBYy3m9DiQNaNVNjNyaA8tRmEJz/WbBFl4EQeLBwmYZb
	3z0aMjWZ7M6ROfSf4mjfe0J7e3P+hVIlR5teOmfYNelxkaM6PRFahOF+OhYImOhY6hF2cJ
	+B2VMT09no4OdsXZs4vsclGbC+6a6Xvf8hSWsSp3Y3mwOqHgRWD+A6jDN3psOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:29 +0100
Subject: [PATCH 10/12] spi: sg2044-nor: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-10-ca8e924cca1b@bootlin.com>
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

The driver only drives single-bit dummy phases. Reject operations
asking for a different dummy buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-sg2044-nor.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index bc9a8ee9bce4..2cce15d07835 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -435,7 +435,20 @@ static int sg2044_spifmc_exec_op(struct spi_mem *mem,
 	return ret;
 }
 
+static bool sg2044_spifmc_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->dummy.nbytes && op->dummy.buswidth != 1)
+		return false;
+
+	return true;
+}
+
 static const struct spi_controller_mem_ops sg2044_spifmc_mem_ops = {
+	.supports_op = sg2044_spifmc_supports_op,
 	.exec_op = sg2044_spifmc_exec_op,
 };
 

-- 
2.56.0

