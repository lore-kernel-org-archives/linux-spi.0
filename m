Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677F547059;
	Wed, 30 Sep 2026 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734702; cv=none; b=DQJA9H/QyxTSZeVkfJvgWJLzAQ+DBwJzBD7q6DF633lO0c7yV3HI+Zx2gtYoN2Y68q8ksWPKZa4c8v+zmX2MTJ4nbXuWkhQ1TH77VojqqUM+XAEo5NMJjOBjp3TF0aEZdC4CGK2j+HKvFER52Dfq/jlSqYkLp4lNFs2ECaR9OyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734702; c=relaxed/simple;
	bh=j89VJ9sI/MVdU9xvASnbZoJ72wKsCVsOKGOXCKDcyAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btqCVuzW+Rdh/XS6QuZP6FWSZ8sqmbiCbrbTdm+2XuUgM9v0VfkFhyB0xUzZKq76/i9MZCuiBnORgk5ER2n1Y94jWJSMzn0OpDGG1Chjhpk9jDt9vJynfWZY613vIsEcGVtNgFZWTj5SO+TmnSfqS9naw6NqSap/klXT0MKw7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hbSyciSN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hbSyciSN"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U2FZH22836384;
	Tue, 29 Sep 2026 22:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eJqcP
	xUg3IO1VhUzYlRekknXmaJSHARRakY6FSo+opg=; b=hbSyciSNax3otshQ78+/4
	neraBiJP5jgxoTNnPCSKCoPSGEqncKt3vyBNOSzWCoSa6p2slW9dHuBgGjYyMiyV
	VejIWHfJoF1lqHHGZsWE25kVZPmBjzUWYpo8GqP5/UgjxvuGb0Eq6kkGo0AIe+Mz
	Y+/EFSGa/Ju4XwLGxCItn2SV+49AXzOh4wiGko+/L7BYlhlc1sbDAeCqdCgdFjhT
	lZ+BOi+AeSozMirzdFev4udHHUFI79YXSWrzQwJf9fik4okxu3XBvtdiTGlvgRcr
	E57wPt3I/iVqddsk7hTDQZi18Wf1cvPZgoGX8iYCRpI76Q3H//vQ5Dcy3xs+1Q2s
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gyugbsx7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 22:18:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68U2I9D1047941
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 22:18:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 22:18:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 22:18:09 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68U2Hq0h015851;
	Tue, 29 Sep 2026 22:17:55 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.com>,
        Dennis Heinzel
	<dennis.heinzel@irs.systems>
Subject: [PATCH v2 1/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Date: Tue, 29 Sep 2026 23:17:23 -0300
Message-ID: <a577a888c21ce4ea383dfb91b79eff719416272a.1790731588.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1790731588.git.Jonathan.Santos@analog.com>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfXxbV7rM5SZstd
 jQPGVD0Q0kcqnRR7FwPRn2n9A0JhG/U0EDb+gmhf7etjdHJVbeFB6qidPZldMfF494JebWQFtM6
 7hQZXdQeAEzVTWwncD7NW78CzG/KLo6M16nwT8kcBNhpKxezyavZ7GgOLMhpMqJcbV7/4HM7sE5
 Crgq7SZ3sa9UmbL+Rcn050Zj3WISRPvo84IZlZC276/JfmCqjQhLi/4DXC9w1Ea3rDH6Agw5OMO
 XALIQDvylKqOsE+DTr2uPke30wBGJBieMbEhSUhBzWYErAKUMmKDtRvcWx5DZHS/gtSrs1xzARo
 NYJo67CjelTsda0heo5qD9A95GEoRhDlKZbgpInep5uA1fiNM+pfFmKi/X068jSFQOEmFIi0fN3
 KBe0xQ5R4uJGSSZSJtwKCwWtWbt4O16GZ0cU3HMUdCdPA7FFcslf/3X9Xu6PwFOzRtZEIMXG/7L
 6zZNYiqR/qUlzT1fGUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfX9i3ievBWv4FW
 0MmOuMHN4QAkh+loQHM6w7OjkTSx/Q5p4qWkNw+4sndMdjrkr1hZFleNQqKGRZku7V6RJQy2BAx
 HSwEQKC4eKA4fuJrsRStYtOcVer+Yyt3eOG3yFuzpzAlXOUkJ3gp
X-Proofpoint-GUID: fWInXBAqYo-RNio-sAfDHmSiwlXacc0U
X-Proofpoint-ORIG-GUID: fWInXBAqYo-RNio-sAfDHmSiwlXacc0U
X-Authority-Analysis: v=2.4 cv=Eexd0/mC c=1 sm=1 tr=0 ts=6abc7162 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=0GyDL0XGWyQrYU0KOQkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300008

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
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/spi/spi-axi-spi-engine.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 02bbc5d0cfc5..0de3af5c429c 100644
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
+					 reg, reg == 1, 1, 1 * USEC_PER_MSEC);
+
+	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
+	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+
+	return ret;
 }
 
 static int spi_engine_transfer_one_message(struct spi_controller *host,
-- 
2.34.1

