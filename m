Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720301;
	b=EtvQrRYSh5pYNnu8nZya//wxS4NQSvtiSvfYc3Xcxz30csv6t5P7WDDtgACC1TgLFQ8r
	 RWx5WDk88PhInFzDDE3b+a3NEy+u6d64TSUBUtL07QuU6LsVI7w8cyuPIJWno/6JAEG24
	 EKLDJaNztpwiNLx2j1A7htzkZRUWX/tKT4PmDi5S8JNGzPmV6LpuX/vw3wGPgtEy/McWZ
	 zsT+DLyR2EUAMQXb1CV4Ns9yGyQHrOsh07sV8Z62Zymmz5bZJuFG3Jh0NDsyLWq5kugae
	 NOYSKUnCEP5mh89iRgZfB0PmJHMio8mTBF4ohN6zGX7zvoDRoQAqfOHaw7NdD6oOMCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720301;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=lbbDUAZ42bjaI/Zz1oo3546qmyA1evX9LxfwdDvdb8c=;
	b=yzb3hsCVFtdDCqg7lKaOq2ALHw9kxDvu7LTs00A/HxnQcqxdW8kytFGleN/mw4yvwHFo
	 1XIYR6ixj/9uX/nmDdnpFF9wsMZNnZgAQ0CSd9+AJJH969Lvv5C2cGatrajZnjhgPT2bI
	 6alRSKzY3ls2As8qrzPERKfz2CFeLUkt1UNKE+A+qLbl7INmppkrDDLoD4ti4uw6FWaH+
	 k195xXl9eutZ6UdIBofoWskw0BGqWDwSATJSxr+5dOao9HQYbVxWxwpWvKG4xaOQZ8biu
	 T3n/seH0a2nKVrCyGWU29qifmaeHdFaGkD5OTaV0TsuGSC4rtuAgIbK5fpaStNbzTqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PuLVR2do;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4789606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4789606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PuLVR2do
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E29ABC2B9E2;
	Thu, 26 Nov 2026 19:11:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B7B660558;
	Thu, 26 Nov 2026 19:11:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4FE511E691C1;
	Thu, 26 Nov 2026 20:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lbbDUAZ42bjaI/Zz1oo3546qmyA1evX9LxfwdDvdb8c=;
	b=PuLVR2dojQC8Tq1JLBpLi7shyMSTTwy7V22OSKh2rrJy8a6p8JGau53CW5xapcL+Y45SLa
	bzRk6nIFSaYnHtXUUpfbozomnKODW7SnDWsLM+EIZVpILyRxUn6gDy5a0aKj2VRJ4BtxTu
	mPa/nee7hIJN5vJ3XMSXxcm5rlCaMGwwjpN9ts2qavWOL7e5w2LmBGGFyLZGNIizCqYFss
	HuC9Mo9CGOsispB0hM+a9f4uNrNP7WCh1PwAVhGMNHvQe1iHfR7Rizp/tkr2Fo9uZecyel
	jdvbfltEv45ZDYtxKWKeBg0oQMVu/s6BSo3qEwBB3GACic8Ok0iHIy8gqU9Rjg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:30 +0100
Subject: [PATCH 11/12] spi: ti-qspi: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-11-ca8e924cca1b@bootlin.com>
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

The driver has no separate dummy buswidth; the dummy phase is clocked
with the data buswidth. Reject operations asking for a different dummy
buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ti-qspi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..5aa6176a3123 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -651,7 +651,20 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 	return ret;
 }
 
+static bool ti_qspi_supports_op(struct spi_mem *mem,
+				const struct spi_mem_op *op)
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
 static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
+	.supports_op = ti_qspi_supports_op,
 	.exec_op = ti_qspi_exec_mem_op,
 	.adjust_op_size = ti_qspi_adjust_op_size,
 };

-- 
2.56.0

