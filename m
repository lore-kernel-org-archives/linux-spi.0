Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D7194C98;
	Mon,  3 Aug 2026 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726174; cv=none; b=MVbynZx6THefLaBcUNluiy3O4l3+MpethAYS6voKp9OoGY91u8VqvpwfvDh8M8tu+QYhLNL/itYACU8DnQKKe1gg3gZY728j22cFjFcMnY6CyviWnywDmJsO9RjrLiW1dPd8e8Tz8hsxvuSzFtR5cr9KGvcpnNdwPWvkFEtlQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726174; c=relaxed/simple;
	bh=eo06UpYyuW1lWB+qrrHCuHTfBVjsF6wEWGGnZsfNnfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YqPXRhopJ/KaMEspQSFqzIL0DcttzsyHfNLHzP9WLp3DUdLAGwQc0eu/fxwo9fxThcsIOaDBBicqsqS003T3LF6Hd7sccWYREhAGc6/itirFvXy5cAb3z7Xdhf1Neu0/haBQjmNuRT9q6LR8Vo3pywkolMswUmc55R97rhRqDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0vLO2EAk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0vLO2EAk"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67330gwK1716826;
	Sun, 2 Aug 2026 23:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/iDTm
	Ki/BO1H1dXQlS5qcuwglI5x2oVcmf2bNyz7bwQ=; b=0vLO2EAki5l6XFc58ejXL
	W2iGNR5ScGfjVWcMysMlHM1DvOgY2MDeBB4DQSmgycocpIgt5e2IBC5/fRsd+UW3
	3xE52c9zAbWdl9YdmVq0/4z3NhtC5RDoHymslBBScNTlxnaYKMUySaTaVd2b9Ent
	XrMk8v6vLaMkjZqL72gpzpS+Oo0qG5aTix3rnnrJoZmG+dF6Q3BkAJJPhJobRJuw
	tuzgxwW7vb23o/Vp05hmJhZR30v5tWNpjyur9bEvO8eYvAkg7I4caOgu4Q0TtPqH
	aIZ+0qKRzUXEKDQe/2ps0lyIyWPNyCEgfykBBiQ91yGlgWoCXEaOo4A5yRi7PSqE
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fsamxmw03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Aug 2026 23:02:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67332mi1035422
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Aug 2026 23:02:48 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Sun, 2 Aug 2026 23:02:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sun, 2 Aug 2026 23:02:47 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67332Z5A011649;
	Sun, 2 Aug 2026 23:02:37 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/5] spi: spi-engine-ex: Add support for multi-CS devices
Date: Mon, 3 Aug 2026 00:02:29 -0300
Message-ID: <a595944fda10f801dd3d11640f3a3726401c40d9.1785725359.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1785725359.git.Jonathan.Santos@analog.com>
References: <cover.1785725359.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX4tjDlGewoT5i
 zMz5IIvsLqIiI4KAH4BIH/wS0mEq7zbfCsQrHDGTB7hcECPlR+GPQ+QFl9O8jseqaRe1EbfksPJ
 fsyuYxhoHeHA+iQx5ty5kOSFd8VBjVsgPU5IdKS0WvWhfjnaiJa0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyMyBTYWx0ZWRfX5KFNOPQp8SGD
 1SPJ40HtAGllKhcY60MMK759npUhCYnEcn5MxANGs/poYmT0/sjbQxW9HQ9Phlo+imQfCXFw+oZ
 CumtbWl44CTncDbRQHGrEl1+o5PNA04n+Y7LutD94OlqE1Q8791dbx81inNSzZrVVc3nmgR6vsC
 Bc4bgnBVlf45cYFHLoysv3C4StajFNCrfIAqCyfGgb1CoNuoWc/JtTX2+OYfeyuezddUjiLha/l
 p+GsoIriKebWdMrQNMCYdOTKhSfO8Cw1A5JKrhfkwgMl3AcQwfMWH/flljly+7tiTp5wSqJfey1
 ZSymkEcV2yo5PLUAT51i+B86LBF+YFyaNdm1SGwQ1MJNizwXHj3d98+lqBkNy5ko7ZYB1l57VFG
 BoX+ajD9WkS4e37RvqveTuIxe7FDGxMeOl+Yyu4I6BfAa7SsLL9rd/2lzFD2HInSpNNsbpmZ041
 x3izX8EL+uh2epZMoIg==
X-Authority-Analysis: v=2.4 cv=daWwG3Xe c=1 sm=1 tr=0 ts=6a7004d9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=ENVVfsUtpBKDjCfSmAkA:9
X-Proofpoint-ORIG-GUID: AowrSaE64hGZqx0p1x_bEysYRjDOe1_A
X-Proofpoint-GUID: AowrSaE64hGZqx0p1x_bEysYRjDOe1_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030023

The SPI Engine controller only handled the first chip select when
asserting CS lines and configuring CS polarity inversion, ignoring
additional CS indices present in cs_index_mask.

Update spi_engine_gen_cs() to iterate over all set bits in
cs_index_mask and toggle each corresponding CS line in the assert mask.
Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
applied to every active CS index rather than only index 0.

Set SPI_CONTROLLER_MULTI_CS in the controller flags to reflect the
capability to the SPI core.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* Adaptation of the patch
  "spi: spi-engine-ex: Add support for multi-CS devices" from v1,
  discarding the per transfer CS mask and keeping the Multi-CS support
  only.
---
 drivers/spi/spi-axi-spi-engine.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..8a2cae81aea6 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -46,6 +46,7 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
 #define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+#define SPI_ENGINE_MAX_CS			8
 
 #define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
 #define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
@@ -281,10 +282,14 @@ static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
 static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
 		struct spi_device *spi, bool assert)
 {
+	unsigned long cs_index_mask = spi->cs_index_mask;
 	unsigned int mask = 0xff;
+	unsigned int cs_bit;
 
-	if (assert)
-		mask ^= BIT(spi_get_chipselect(spi, 0));
+	if (assert) {
+		for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS)
+			mask ^= BIT(spi_get_chipselect(spi, cs_bit));
+	}
 
 	spi_engine_program_add_cmd(p, dry, SPI_ENGINE_CMD_ASSERT(0, mask));
 }
@@ -886,12 +891,16 @@ static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned long cs_index_mask = device->cs_index_mask;
 	unsigned int reg;
+	u32 cs_bit;
 
-	if (device->mode & SPI_CS_HIGH)
-		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
-	else
-		spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, 0));
+	for_each_set_bit(cs_bit, &cs_index_mask, SPI_ENGINE_MAX_CS) {
+		if (device->mode & SPI_CS_HIGH)
+			spi_engine->cs_inv |= BIT(spi_get_chipselect(device, cs_bit));
+		else
+			spi_engine->cs_inv &= ~BIT(spi_get_chipselect(device, cs_bit));
+	}
 
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(0),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
@@ -1222,6 +1231,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->unoptimize_message = spi_engine_unoptimize_message;
 	host->get_offload = spi_engine_get_offload;
 	host->put_offload = spi_engine_put_offload;
+	host->flags |= SPI_CONTROLLER_MULTI_CS;
 	host->num_chipselect = 8;
 
 	if (adi_axi_pcore_ver_gteq(version, 1, 2)) {
-- 
2.34.1

