Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E44D6B4;
	Wed,  7 Oct 2026 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374231; cv=none; b=rGukKAdcLlQbdNNuiBJbCf6bo6n7NHN8WTkX+5gKlN3+OvVkK1WPL+wDkNRkZxL/qWHy8wEszdaAwFLFhsP9+zwJcLlbtM/2H0Occ15ZuXQtRK6HZlQP6LnCB+y4ZuGA/kMQv4QR48pEA+69wStgCnSSkA9uDlMFGTolznNJTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374231; c=relaxed/simple;
	bh=o2zzp/CXqD3o9N9LjQHPEjAmvrdw47DRLbkl13PtnIE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhHOM28jjvCv2jRipR/dip9MnaOuTLTOyaXhe/swfDYqbMU7VRTuvFgkvZEJ/Cu2RMBKhggKFaaYBsvcB/vCABWD+98EcQAauxQFZ0xzdGKLBNF4H4FNFuJXtcTtXawgbkWrTEXE2wtgghR52ZhYHfpzE9W74weFDYl0WJKVnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=tPfsHv9X; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MhrnbqqW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="tPfsHv9X";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MhrnbqqW"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BXmn41257626;
	Wed, 7 Oct 2026 07:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=LR7AbHg1WDHR+3rN
	nTNDrddJaPvZWR8p1wxHrtwnTUw=; b=tPfsHv9XJ0s5uo6q33CKvD/2z5eFx32a
	VoVmbdujBdxnOd2aG1SN/Ro81AdPdcdFKCkTZtHtB0y2LZJZal6IEpixPNazt5hu
	56Rr3u9vt+ueQaW81Y4PfTf2Z2kPd+AfmTAdbC64tgSVMNJkfV53FFn1r7SWTNiu
	aVJPJTN/7nNZt1YOT9KUwZ0BtpMsv8fE0YwX6W3LVvjpBzQSJKFsUZJKyeVl9LI9
	GGRIghliQSfC/diFjTebA2URgxHa6V//bEOvAARwGnJaMXWFLg4miGHop9XOZ2SO
	Q84L+0gvt4FXDS7mMkm9ZWAH1vBv1xzjlPb8Ec55VfY1OazLl/QZYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=LR7AbHg1WDHR+3rNnTNDrddJaPv
	ZWR8p1wxHrtwnTUw=; b=MhrnbqqWZqRlnZXJJMXliy+MA+vcn5rfFxyJlrHz0p2
	eo7ta62jog8MgcGFDmKCBjGxSDKXJzA6j1yVxlcLkQReCx+l3gocwVA9laZKHXD5
	QcE3fdUzFO5A5am/mjmTZjSvgEgLtq7iwr8dock3mYRCBj7RbtF3HJrmb4aVEivH
	XQPBGXa73A+h1IxTvsrg8IHwb0s/3b2/rVGNwD4BnZR9fzuBLveFRbYvXd0/TNEY
	td0VZxidVO3WSW+4Vc5EErWNBSMylQCnQhB9dNOmhK96YXQgIMiZPrUor2smzRIB
	Uiioi0IrPOHByLr0ebDiCSq1dJSzrsDhttu4hWtBGCg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h591yc44y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 07:56:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 697Bur6A041602
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Oct 2026 07:56:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:56:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 7 Oct 2026 07:56:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Oct 2026 07:56:39 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 697BuOwQ012192;
	Wed, 7 Oct 2026 07:56:26 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.comls>
Subject: [PATCH v3 0/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Date: Wed, 7 Oct 2026 05:52:05 -0300
Message-ID: <cover.1791361360.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: TwynuX7hgpfUHTe9wO3FpTN1OWP72HLZ
X-Authority-Analysis: v=2.4 cv=N/S8hG9B c=1 sm=1 tr=0 ts=6ac63386 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=3EvmjnR45BohH-wPFtUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX6GxZ5A+jodFv
 Z43D1z0A6kWO5EHJUV3uvZm5GYiXn0i9dzUPiSmZWnCMnR5FDsp9nVkyL/4Sm9Iv+3PVSUWhFGe
 F9cME+B/IYtzktQtAqU99uUmqzrVbj2WR+SbxMzg7HgQWPmqGzHapE6q5dGvTPNXHSmGLQW3xHt
 8PBfzdb11gM9oxBlji/IAMDChsa8oGl7KVaFu56CjcS9eaVkMmIbGM+a4wGZ6xa7pPydITifKDy
 XuvqBt1PtxZ3EECKQqwkKprxJS0BPQ6OBKQX4Q4ayft7ZNG7zteQuEbsjfBNrMuMwswCL6h0P2B
 9UGDIr6QUkeelDLb7W1We73LzRbPZO89RqKGVdiFvN3Og+ZP3obZ2to459Iy2Lv5GuBJOuxO5YF
 DhzTfxKA0+f7kPfxsLNo1njjEvXtYB0y8lwAwgTK9SnN5RZMZTkfQHFYyudrITb5ErjgWwxWmmD
 eopNv7m53HuVcE8xJ5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NyBTYWx0ZWRfX/dgRcx8bfNeP
 McCf+O78c+mBYmTO1NTLRKVmRFR78KF/oraxind3ALT5M5vZt0LFPEYpZafeNrO+8h9kc3+xjF6
 zcaFs3MHulMqy1N9tcVlup0Ytbvtum2MHGnjGMlA7t5lBL6KK3UK
X-Proofpoint-GUID: TwynuX7hgpfUHTe9wO3FpTN1OWP72HLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070047

Both spi_engine_setup() and spi_engine_trigger_enable() send a SYNC(1)
command and poll SYNC_ID, but never clear INT_PENDING[SYNC] afterward.
This leaves a stale pending bit that fires spuriously when INT_SYNC is
enabled later by some driver, causing premature transfer completion at
low SPI clock frequencies (more likely). Fix both functions by clearing
the pending bit after polling.

v3 summary:
* Added a dummy read after the clear command to flush the posted writes
  before dropping the lock.
* Link to v2: https://lore.kernel.org/linux-spi/cover.1790731588.git.Jonathan.Santos@analog.com/T/#t

v2 summary:
* Replaced "Link" tag for "Closes" tag.
* Included "Fixes" tag.
* Added new patch applying similar fix for the spi_engine_trigger_enable(),
  as pointed out by David.
* While at it, replaced plain "1000" by "1 * USEC_PER_MSEC" for better
  clarity.
* Link to v1: https://lore.kernel.org/linux-spi/04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com/T/#t
Jonathan Santos (2):
  spi: axi-spi-engine: fix stale SYNC IRQ pending
  spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable

 drivers/spi/spi-axi-spi-engine.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)


base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
-- 
2.34.1

