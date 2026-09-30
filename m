Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878731D5160;
	Wed, 30 Sep 2026 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790734677; cv=none; b=E60WiT7C1wOqpZiWZqcq7vU1f4isJGGFpn3kDs7U7IZxYXWCp3giwmIVZxNGfQP3N9GczYlevHEwEL6tTAqrrczj1gvpk49NHyTYdHO5kKHmYNr4SNHzs1F7z2zSudsylsU06TqBhPrNIxIEMV1VWw8PYEhl8Ye2FxIfw5zYHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790734677; c=relaxed/simple;
	bh=sAraZ2t6Zs7ParQAYz8Z5WshAjBQcO2mEbUNgKbd3ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iL2aSsjGpy4oT+7/GchgoK0JQklRbVowF6FgUSOHQmELxbxtMfob2MH86WQ0yf4O4K260UeZqkX7DwQdxIzIWdZnXbZNC3YMOtP7sc9IToSWPhzPUAzAzMC0ZwUZs/AXsI925S46slA6/EXAZrbShLcKE/jmiLCjaYU1V6oC5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CyJTxQfh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CyJTxQfh"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U1Xc2K057587;
	Tue, 29 Sep 2026 22:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=a4/XZ90NyURzAvNorJZPopYSwbH
	CnIRTgCSX/1nlaP4=; b=CyJTxQfhOzn6U6WLsYISqEmjKzowLBgBCddCi9dmPLt
	T+fPc13AMhvpJ22v0fawLqYEbKMkL5E3dxzhXosUWvDTvJn5SCkrudL13Dx4Wv/n
	/xeyA3K19uweq6dtdRrKL/BiJ6oenenUR3oUxy8hDQup+GLUHiHMUuHIBrU2yhGT
	66/rJOhkUXuurj/sMkPDn78yCNDnGD93VwFMfflEtrN2SLgkqAk+exST+Riy6a/R
	I4GsvIzMXZTzppElK5B80/3AI2ud4/nbtaPgRw/Gbzy5Xv/IgAkbPHDYS4J8Uyd8
	Vbm3JAegf3plA+dj85gunAmj2oz4Wjnsaz00rd3YUBQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0rvc08et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 22:17:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68U2Hn4k047880
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 22:17:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 29 Sep
 2026 22:17:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 22:17:49 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68U2HaZT015845;
	Tue, 29 Sep 2026 22:17:38 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <broonie@kernel.org>, <nuno.sa@analog.com>,
        <michael.hennerich@analog.com>, <jonath4nns@gmail.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v2 0/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Date: Tue, 29 Sep 2026 23:17:06 -0300
Message-ID: <cover.1790731588.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: 2T73B6cPByNweAye4_FlrdfWaB0dzh21
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfX5lIDyX+gApCz
 1GNgiSY6gOpJllJBkaW4QwpbfCXKR4b71GOPdUSpxZ+4LXjHHJGlN2NY/QlxtgLoxjssLlMJ/N8
 vm4kChOhQl1lydrGyc77gZXQHH5fWc9g5OK2mZDwma70zN3VmH6Y
X-Authority-Analysis: v=2.4 cv=VJlIDNPX c=1 sm=1 tr=0 ts=6abc714e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=3EvmjnR45BohH-wPFtUA:9
X-Proofpoint-GUID: 2T73B6cPByNweAye4_FlrdfWaB0dzh21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwOCBTYWx0ZWRfX3p5vF26ZZR2s
 sbbBqIVZL0+r1mKJwzD5r3sGNMmsrh3JX7/c6TJuW9SQw1Ats9Ulv/yzp1iyR4lBUBYe8S07xZI
 fSl+hlEiLgXdRvbnzbP8f2v3khirq/tBhbw3iTgdra41LHExGLgcMAfO1FbTN1rydeL7aDwTytl
 xvRvo8iBUwJHLDB95O8N7GIHNENa/oXog/A3SB2GqGX1HE2eBGVibbT4tH0vF+mJOrAC5EEwTAT
 byIsq04Y2UfvIGWB8zV/CbRNCNArmWDb7+0aCE+yb6lRugFSANDVWC7qumTCGJWkQlL7FQPp+6L
 8j9fSswNO8aTAGtJBL1x995Xp9lEF+CTaqhI0YTvxe1lRWFcDbdLzfWRBqyxVS4tJBi1JzKKJwX
 wexn+Z17pDXpmLUZ8CVER/psR/VF/fPz41njnFCsvF79fuYg07ZNnzuNO9aYrruGhJZR9O4Tv5X
 XwxHgUYZ4wHa6iMIsvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300008

Both spi_engine_setup() and spi_engine_trigger_enable() send a SYNC(1)
command and poll SYNC_ID, but never clear INT_PENDING[SYNC] afterward.
This leaves a stale pending bit that fires spuriously when INT_SYNC is
enabled later by some driver, causing premature transfer completion at
low SPI clock frequencies (more likely). Fix both functions by clearing
the pending bit after polling.

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

 drivers/spi/spi-axi-spi-engine.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.34.1

