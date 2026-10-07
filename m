Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28E39E6F1;
	Wed,  7 Oct 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374239; cv=none; b=P+FgGsbLJdndykXETVLFPa4O/S480S1JNdmw/ieiaMkucpEEm7c6hfTRyzdsbheWcLM64eTz7zC8ND9K81z4p5xBC3dYKOb11MlWXltNQM5KWxEuVQo98gpNG6eoBFUgCow5AvxlO6baeYxMPewv0ign6qBcLw48Gl78P40KrGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374239; c=relaxed/simple;
	bh=vl3EgU/1U951cna/v0403n7gwunz3Fg+WQL8D5Mdizs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUqif5bvQsE/fzdGZmMVnFebF5pazs8RrjcFvjW7UPOl/pQI/jMhj6Qoa+BsMZFHiRj0dP1xrZkULPN8V6Rh6NsgRC2wQaCdnmL2a7o1BwMPAd8tTNLsr1mFeUPxaocQUYObS5d/tA8gDyfEl7RwC5R3axP6BmlmvzznNB1NUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=AZfST/7R; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PO9xTWns; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="AZfST/7R";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PO9xTWns"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BXgM83805062;
	Wed, 7 Oct 2026 07:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=U/XyTH/LKQRiyWca49QV/vDCauWuL6jtDtOR75ZMbBQ=; b=AZfST/7
	RxzrrwAF2tgXcCUwG7BcB4WZB1y4j+bNTJTK2WHNFxZK+nUamVKz9YAhdDqVGf8K
	+0u5Se66ShMWldN5p9jx7rWXwLAFVXCj41TELxGooRgQbi56RvDnYO8sl7d0yeMo
	BTPvRHrepoUMMvZ0Az0/K8tg5GDnyYV1gakBW2Fs94drP5zi8oXZ7aW7cj/MtHLr
	BulrmJlrUoQNYI00WJDLFNghYnKFwTGQvmPqTmPTmAGye2HnwyyHeySLyhLyjxFr
	6gMl85xdnq9cyNz1heB9DwTvBblLVeKNsRvKWJPz8T8/LJ88oORCgyMMjGMrGJ/K
	ytl+fi/rs5bNc3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U/XyT
	H/LKQRiyWca49QV/vDCauWuL6jtDtOR75ZMbBQ=; b=PO9xTWnsQGjJMwJI2cgmQ
	8M8LJLEFByAihPiWC8L1hoxkgKjSxVfVgEfMEsq5WgDliIo/Tw1nPPVZxEqS4ISt
	so+8Oe4pdq2LIgmrJjUFHX1ZmxOapS67kX8NWe2WOkMqazwxJ1ed4ckSE1xmVRJL
	qS2PnAVHt949YcmOnnCasgjTF+KehobmVXiQc3MxZFLE/kGY40L7gnyoZLZ8rU6+
	lKJEJ3UpO2Y5zXJahqjmSVc44kFdwyPcD8HpZYPPcV2ZDfJCqowZzErvcudsf4kZ
	CbEAtwJ4OL1RexD9ZdmZ9mzLNdlIXnlwsopJ3nQ7LowzOpK6oNcZ/8fINfa3zQXA
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h4ub48t1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 07:57:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 697Bv1Od022764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Oct 2026 07:57:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:57:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:57:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Oct 2026 07:57:01 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 697BuixR012203;
	Wed, 7 Oct 2026 07:56:46 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.comls>,
        Dennis Heinzel
	<dennis.heinzel@irs.systems>
Subject: [PATCH v3 1/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Date: Wed, 7 Oct 2026 05:52:26 -0300
Message-ID: <d3033a01a695c915e4dc5952dfe0587b2f77d733.1791361360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791361360.git.Jonathan.Santos@analog.com>
References: <cover.1791361360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: e2_yXvsi7dpOF0uzSk2qVpLg1zhi_mai
X-Proofpoint-GUID: e2_yXvsi7dpOF0uzSk2qVpLg1zhi_mai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfXykBOx/PINTy+
 H/MZJ05gQ22jgOJ/RpID6pdkEZzptQj3uwCYXCtImw9HMMW5Jcixr2Y7G9CzijRrtvhH63IT5U0
 neEOj8uo37BU0QY+VAeax3KK5WxziadQHadExALZnSLIcQPZCznr5fJ8leoD70CQs924+rRqaAY
 YxWiHd5OunZcZ/Ibxyanjg3XSfruYZNUuZ79aGRaLEogmyC0qV38jhYyQSM/T22GXPESrMm+o/w
 AN8UuGsgQnewwEeruzvMdPp671JOSS4zqLV5JL6jF4YbnWvaS0XmY3s2KY4hpxJuw7MBly1oSL3
 ARUCiHAo4neVh/ef9dx+AoGU1MkMV9Ou77QI/lyt807TR06ueT71F24Ups4shzaUULwCnG1bifi
 4RZDhBQHsI4KsEGLNBXdyHa++hBbHyCO0WST9lZCTrCKJ4XMBGfx6cXizjxRj8EQlMd8VG0Cp6Q
 Kj3p75AR6x5Be/G4nrA==
X-Authority-Analysis: v=2.4 cv=O46sLx9W c=1 sm=1 tr=0 ts=6ac6338e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=0GyDL0XGWyQrYU0KOQkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX/4rKfL2IbV0s
 YyXj4n/o3V1z8aRXMquvslvXxAjqB8AfZpcNjj3Ey2AXZac07KjBkWWHqKY6PJJ6VbySYEBCFHO
 rrOmbgnfs7Hum3IJGDJgJhDxu9wU39CayziBHMeVHCTJpu9/b52S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070047

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
Closes: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz
Fixes: 1d0ee0c9df31 ("spi: axi-spi-engine: wait for completion in setup")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..87c05cb064cc 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -887,6 +887,7 @@ static int spi_engine_setup(struct spi_device *device)
 	struct spi_controller *host = device->controller;
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	unsigned int reg;
+	int ret;
 
 	if (device->mode & SPI_CS_HIGH)
 		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
@@ -922,8 +923,15 @@ static int spi_engine_setup(struct spi_device *device)
 	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
 		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
 
-	return readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
-					  reg, reg == 1, 1, 1000);
+	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
+					 reg, reg == 1, 1, 1 * USEC_PER_MSEC);
+
+	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled. */
+	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+	/* Read back to flush posted write. */
+	readl_relaxed(spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+
+	return ret;
 }
 
 static int spi_engine_transfer_one_message(struct spi_controller *host,
-- 
2.34.1

