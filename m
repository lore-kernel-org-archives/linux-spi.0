Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF163A0E8D;
	Tue, 14 Jul 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997823; cv=none; b=HZcuGZfifl98cBInCnpgleR0TDWRLhvWz9G6Xig1Deu93i/fQIoGCNZmzx4p4PM9owzacQkfv9wn/4U7N+JdtfkJcE48LOs+7ZUHWCe55QLGM+Rj9FE8RWFyvdgx7rpBpdKwCLwVTdUZfZ1bynttjkLoT5wLnX7pd991gaYThHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997823; c=relaxed/simple;
	bh=kHRjz7nCtRa/IfREJjOEfVpttp7Tat2D6QpnZx0ljdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRSI/fqNTA+5JxTXrZvsKDEip2oEfvcT7Eg2RVWvwF/sI4shS/P4JulZCqnffFhVn9/YecYeQuBkfxsgYYubWhOUNgux4x5s/dLEzke4drBQEDkA474Jl784zDd5KjRC837vBJrOIyu6GoW7wNP6i977XlGfUKPlFVOBQvaWZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jAumaHMR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jAumaHMR"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNlvXM464861;
	Mon, 13 Jul 2026 22:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XfgZ2
	VSuLA/PlsMUfWq7fPsvFgA+FczH45jgiLjLFg0=; b=jAumaHMRhGA3CIKigITRj
	QJfZXph1JLDt2K+iJudsGJrxfZ0XQ+5/UEyden6XjeHa7RjP+whWQ1kUlmE/JV2G
	/rfgMsXHC1kR2K7eM50LAkRF2SR1lf1yDQ3Q283BTIVzJNARro40Ojk0cZO2STas
	3Y94QD2+yLML0/UHaldoFQRGu4QYsaKOTIl6eIZuCX8k8IqY0DP7LGpBTLVw5xi+
	n16UCZO199flMrM+LfXEmJz2qpAHFyIFtMKfOilAi7UlyJeZSCDR0v+pDqvMtFi6
	1Osro7MxjwbryYBLg8fp43/bfXV3WMrzy3QkzDoiNa5ts16TGpI3igoeyIqiPe8q
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fc45bevr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 22:56:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66E2uvAJ028397
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 22:56:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 13 Jul
 2026 22:56:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 22:56:56 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66E2ujL8021220;
	Mon, 13 Jul 2026 22:56:48 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <michael.hennerich@analog.com>,
        <broonie@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <andy@kernel.org>
Subject: [PATCH 4/6] spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
Date: Tue, 14 Jul 2026 02:56:32 -0300
Message-ID: <f936bd60312b29b9ae101758e4844326bdb1e1b5.1783729282.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783729282.git.Jonathan.Santos@analog.com>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfX5lHbqlR3F2oE
 lU7UH53+JG+WEMUVU4fv6W8alOuUNfme6hgFABKmD4ywrrXZ4AduFt+uEEM3Uj6lgQrdlQrYZLS
 CfRWaCAbFCNydMWP5qByuMRsOBZLQCLz5+sRVM/cmjcf7JtTfFVl4KJJexS+U6KYpfcxMyHlZ/S
 JrdnOjXD3ql216UYYvu2Mcp7xXpvz1EbBkKEXdbupjntCkoiYo6FYlI++lMJQex/bAIl/LfzBC1
 eRS5HxtKSxix1yuXDtwR3Kw5QODl+DeDCJQzeoUdMzRAV9vUG5EVRWAgMC5caqLIjhmu8mC/PiW
 8KfcpyEdSfwwIHv5Zu824xagjcmC8VRMsSJhv/DGqrWgXHsx1LhummQ+oCy44+zvyNhvqs2BtWm
 eAD2ff9pLOb78RWv74Vht4Bq84qSmO8MIEK51wRQRBoS8xObH3TT1tokrPSYVdZ1aSCsMVfF7x+
 CsBbwU3gM/cmg4tSKFA==
X-Authority-Analysis: v=2.4 cv=CcA4Irrl c=1 sm=1 tr=0 ts=6a55a57a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=0mcEFCcLhlBvgAM5AW8A:9
X-Proofpoint-GUID: pzE1988QdX72CQMvPdhEW9defhn0DtQx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyOCBTYWx0ZWRfXyA3fV7vFjPFv
 96udWy3hZ8rUmTFrPD4qyG4HbRs6z1oidLCyWJZiGo/Qa5XL0RBCL1gHiyBw2Aay3Sc2v6jObNq
 rH8HV5CMiHATToEH9dYb1dCYkDh3+gEkVf4iS4QEgcQ6DUvZxm5X
X-Proofpoint-ORIG-GUID: pzE1988QdX72CQMvPdhEW9defhn0DtQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140028

Document that when either rx_lane_mask or tx_lane_mask is non-zero, STRIPE
operates only over the active lanes indicated by the mask. The transfer
buffer must be sized as a multiple of the active lane count rather than
the total lane count.

To maintain backwards compatibility, when both masks are zero, the default
behavior is to enable all lanes.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 Documentation/spi/multiple-data-lanes.rst | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
index 69cb532d052f..578a6a8e4380 100644
--- a/Documentation/spi/multiple-data-lanes.rst
+++ b/Documentation/spi/multiple-data-lanes.rst
@@ -200,6 +200,36 @@ The possible values for this field have the following semantics:
     After the transfer, ``rx_buf[0] == 0x11`` (word from SDO 0) and
     ``rx_buf[1] == 0x88`` (word from SDO 1).
 
+    When ``rx_lane_mask`` or ``tx_lane_mask`` is set, STRIPE operates over
+    active lanes only. Buffer size must be sized as a multiple of the number
+    of active lanes, not the total number of lanes. The mask must be a subset
+    of the total lanes, bits that correspond to lanes not defined for the device
+    are ignored. When ``rx_lane_mask`` or ``tx_lane_mask`` is set to zero, all
+    lanes are considered active.
+
+    Example::
+
+        struct spi_transfer xfer = {
+            .rx_buf = rx_buf,
+            .len = 2,
+            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
+            .rx_lane_mask = 0x0A, /* only lanes 1 and 3 are active */
+        };
+
+        spi_sync_transfer(spi, &xfer, 1);
+
+    Each rx wire has a different data word sent simultaneously::
+
+        controller    < data bits <     peripheral
+        ----------   ----------------   ----------
+            SDI 0    1-1-0-1-0-1-1-0    SDO 0
+            SDI 1    0-1-1-0-0-1-0-1    SDO 1
+            SDI 2    1-0-1-1-0-0-1-1    SDO 2
+            SDI 3    0-0-1-0-1-1-0-1    SDO 3
+
+    After the transfer, ``rx_buf[0] == 0x65`` (word from SDO 1) and
+    ``rx_buf[1] == 0x2D`` (word from SDO 3).
+
 
 -----------------------------
 SPI controller driver support
-- 
2.34.1

