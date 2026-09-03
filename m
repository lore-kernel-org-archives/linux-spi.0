Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC724A4838;
	Thu,  3 Sep 2026 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443408; cv=none; b=Qb12ET9iJc7Vk0oGfTnERQEGsPV24c3w9/9E8ROAI213aZGPJbAPQjsKLseUvlksQ07xEGmq7c3WteWIIqj+zOg+e6rzgaYlNbr1HvMcUOWOsfPy4S+8crjC1CXamq9e8RXqVnSi70JLDvsWPf7K2Zd9aDah9QJFr2i3ZGvSzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443408; c=relaxed/simple;
	bh=dvFenngRmaPtZpGdd/tngd/26rtcmdp7n/S41Lpog2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRybLc8qhM2ezOHcNfWuiaXDg3RiKqWseRf/L/ul2dKY6kSPn34vOoguX/DQXZ00im+6kqG/4kCZLqZMIEme2q+v3ISSAi81L/XdsKhs7b100seYjpvMV1Gaio4UC+dmqHpHIrHSfPxdgf3AwdIZu+h9oEmI8Bj/WJbqcbXIFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AZVZCZkw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AZVZCZkw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683D5b6M647857;
	Thu, 3 Sep 2026 09:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GFcvXXkmZlpLT+kGIVrfEP8lqK7
	Nu//noRmKfbRH/Ss=; b=AZVZCZkw2K5uhCuxKclnD33BzgYJOAryvpfvJH/AzsT
	a6L5/xFguwjlep4mPH3oukkErFskXK79fgIRkKXbr0lJywBJ3oDS2FU7S6+exu1k
	4xeGKXm470u1TgyOmruLU9sUrp3qrbMUSkuAmHHXW6eTtDOGavqzWwXg553ibZNW
	JyKB9tXr+nB375C/I+Gz0akTVeAA8Mi2jGpN9oUPhRuYDYsk1O6GpUyEVm2ElajC
	svz8eVxWOuxwNzwA6J1Bq9fOjQ/X1ZHUb7WC+zftzDuQfhq1rS5p1xodVhlO4Unt
	VZ8iMWL350mosjVyaiwDdP2xVZYaC3/rNG28z53BYiA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1sbw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 09:49:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 683DnnHH020357
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 09:49:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 3 Sep
 2026 09:49:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 3 Sep 2026 09:49:49 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 683DnWa4009290;
	Thu, 3 Sep 2026 09:49:34 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.com>,
        Dennis Heinzel
	<dennis.heinzel@irs.systems>
Subject: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
Date: Thu, 3 Sep 2026 10:49:22 -0300
Message-ID: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a997afe cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=0GyDL0XGWyQrYU0KOQkA:9
X-Proofpoint-GUID: hYleFw98JQv1PU8JsvHvpC2AuKaFl-Wr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyMCBTYWx0ZWRfXw1LY7ylAvMgs
 kx55hWqMAN/dpiWFYkyYrh8ALzVYlFi6i966qcTopdZ2pTWdi1ZNJY1X6d1m/g6Px/WZ1oODDZg
 aJUJHRd0/C/ACiWpHDoes8qICr0gj9wBC0+dbe/zmpEqQY/qPrWB
X-Proofpoint-ORIG-GUID: hYleFw98JQv1PU8JsvHvpC2AuKaFl-Wr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyMCBTYWx0ZWRfX3oX4xNc7Rk1v
 jD4AvZTGynFGlchp4rfuVw50G73kEEzdHB/woYoUgQRgEQa0NDDB+Q30aB7zASIkTnXW3ukaBfj
 twEiRKhVzRV4yDY23/1WspnpodzO+ejDIr8iQD6OVIojvFY3OaJxvgecheqhQ9wyUV6QPqszZKL
 etCPySW2+YTi5zctGfm4KqkZ8CwbAVRgrPay/OIHyziCBvP5sEdq6WvpZwnEjsqkYxb63FhXhBh
 82q9gqpwqWVu4r1KMgxF7FIQ1/IZswU9tWR9tifdKo6aJv7EKWVxJMYi8eGUnFtMhrYPi7x4HCb
 SvDwD8KG2gJN5L0YvALqBvf0pzwTWVIa7FHpy1JHVs6VIB+8uWBWi37oTgx5Y7OuTmDZxr9LpeO
 /G2BPj7L9vw2/R53yvF8FWxqBopWic37ckjVys71kOkmPV8ji4JgMqJDLchsuvbN7RDRxPyDJX1
 qzA7Lzn+5hfPKaD6eVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030120

spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
it was parsed by the FPGA, but never clears the corresponding interrupt
pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts
and INT_SYNC is enabled, that stale pending bit fires immediately, causing
the IRQ handler to see the leftover SYNC_ID from setup, match it against
the current transfer's ID, and prematurely signal completion before the
hardware finishes.

This race manifests at low SPI clock frequencies (~2-3 MHz), where the
FPGA takes long enough to execute the transfer that handler is parsed
before it finishes. At higher SCLK rates the transfer completes fast
enough that the issue is masked.

Fix this by clearing INT_PENDING[SYNC] after the polled SYNC, ensuring no
stale interrupt is left pending.

Reported-by: Dennis Heinzel <dennis.heinzel@irs.systems>
Link: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..9e9bbe109ce5 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -887,6 +887,7 @@ static int spi_engine_setup(struct spi_device *device)
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int reg;
+	int ret;
 
 	if (device->mode & SPI_CS_HIGH)
 		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
@@ -922,8 +923,13 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
-	return readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
-					  reg, reg == 1, 1, 1000);
+	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
+					 reg, reg == 1, 1, 1000);
+
+	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
+	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+
+	return ret;
 }
 
 static int spi_engine_transfer_one_message(struct spi_controller *host,

base-commit: 183f05a300eab41e4578337eac59335730dfebf9
-- 
2.34.1

