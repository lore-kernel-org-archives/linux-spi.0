Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832593D9DB6;
	Tue, 29 Sep 2026 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663906; cv=fail; b=ns2B/yIlV/frnJdnrJ3KwlZrT/Sdc0Rmo9f1jm3SXL98oHD47xE12SG93qL7iC7CQTXhJ2zKYTSCjceTijx5I4zplaZtvqeAMeSvMo92LG7TocMkYdw8RUnbEwtUqxMU3yAVg6SOla1L4xy020ZSlwR6sf2MjPvQbV6fqfaVZw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663906; c=relaxed/simple;
	bh=3kpAtf65yQWseh+mW9giwODuTbPyCT9XUoD9Q2TVS3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5v/xrFN1qkfr0DTEwgvE00a8YvUyiSKXmGnWpTQ/aA2mFtha3xaa303/6SXhfBtPzfbJ+fNuivgZP4PIgOCw+gZmGAEkv3jojt6PFCKsx0eKh/FEGmlo3IB9m5aVJdQ2Jrk2LWnH67jZPjMALnmVUufNElOf/VH8uEYrutdw1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jKEnig0m; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=g5PO6PJ1; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jKEnig0m";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="g5PO6PJ1"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46Fws3557315;
	Tue, 29 Sep 2026 01:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=50czZDQQh/9/PaYM/pt0oDyeO0UvW+XPXFpNljAmm
	Qk=; b=jKEnig0mbNfMykm88Qp8T5vHXLOTsj8LL7STsMWfVBkp2klLzyPjwgckn
	W+DU/5PNgQWoKjaqWur7ovOefwL2klvF6SVWrIKwPAN/nE0ut2nEkeLbv0WtYtAf
	ipv7qejmnl1Erbinh/YdGyEaQHY5pi1Yz4h/+G409piWIi/Rpv6ItUzXUi5J4Awz
	cLO4Vw/RKHwANcxxN+WoOX29SoNaZ6/u6qcGD6QMO6FO7hCSPinqB3hL59ph1ezN
	nA/eA19k4qrx9Q7xaLzPwebRdCCJ5KIZKjGOpfJVVjSUofBhHJs9KVd2AR9uLH+s
	KMhcm4BFGtKt4M4WGwL74/ScEni1Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gyyjw33ak-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:38:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP+6g7gdp1aORCzRnxUZNuLQ7iOBpFo/U+2+veth6Bq6pqqEpEc9C6Zo/pPYTqa/eowv7X7gMw2D1E6m9A8bVgx/1Olge8R/pvPBLiAdeWFAw/Sy6Q7+WhBt120Tx/LwTB0L5K97cvQY8ZXIbmuyOVtkk+RaTMtMYfcgGO76B57R2RjxDRF7j/2/wcV3CI9JTUe/s7/qXd76rJ0bKMvuPAObDlIPvvKvJ3GXZ02jHxO1z+d9wn/ek2bxs/QJbskylKfxvaKRI+6wZ745qv15UaYKWYDTJ2fPx8WmtKNBqQFgW5d0H9oVgK9M83HslnCSQNY6L50/s7weM5OKOwGsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50czZDQQh/9/PaYM/pt0oDyeO0UvW+XPXFpNljAmmQk=;
 b=DfWeCywzO0keT1a2MW7cr16G3QmKOqedRa8MiMpW3clULScFst3AIc+lp7CMkZmhALmow7dNj9GInHU3glnXhInew4FgzsuGjzCpOaWKqkSHDTwOW0w1xU829EbxBm0TDKdW6CVKfkK1WPYeJElnw7FvAk8YDUd1ovwN1sOBiqlY7obMBJI3LGNO452dXPeFaMIuPmitUngfmvBZCm2da7p59TqljWaI254MPkudKTFOwHbp+vAX+uM2cVCIcYXDp8rKCqtOXc3VIr2f1vx/HjzjH8eaB02OJyKvDpNLUPkuOa3lXg2w90HyBqn5mvFYrgkLRcQREavmDgegVR+//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50czZDQQh/9/PaYM/pt0oDyeO0UvW+XPXFpNljAmmQk=;
 b=g5PO6PJ1R4C1hSwd8KumJ7+3cjDes/EV9SR6M6n67E9BDOtRtBzE+fpV2ipg6LTJnMCZooE7Fl3/ZXyd5nRddxyf3k2bE/x4frR6FIOW5QYaUQ/8TM+qiVI2UKObKxqjJZ+5ZL+ob61jhmCdaz31u0GnWuF3ktN5UQ37gkRYhbs=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by MW4PR10MB6300.namprd10.prod.outlook.com (2603:10b6:303:1ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 29 Sep
 2026 06:38:01 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::51) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:38:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:59 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:21 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:37:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:37:21 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnI1395904;
	Tue, 29 Sep 2026 01:37:16 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 18/19] mtd: spi-nor: run controller optimization before dirmap  creation
Date: Tue, 29 Sep 2026 12:05:28 +0530
Message-ID: <20260929063529.1235417-19-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MW4PR10MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6242f4-8b38-4968-c5c1-08df1df4347c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|7416014|1800799024|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	/+XPojVoGu3jKsCElx7hJqSB2kI7wEJx5CWKsz9H16Yjme4BUQhBnfTmfkEnbNFlRhgdu4u1m0Uaw3wAnbd9UWlk0WmJBn2FD3Tjn7zzWbva2CpXa6Ca6KF5Pas5Dn161BB5JjLdZH285efNdxncC88qyP2pN3aai5+MHHoMwZWwjrtApyooyaUHGCTLX2V98ZRJW/kFB0Wr3H3Rp0cQIH8L38OufZeVTYeaR5beMih0LpvywtWdDAUQIgqmr4TOAWEEjvEujZv33NvKHuqK8AgPpD+qB1jyU8IHYor6xl1W+HtyyQMoeSXPujYFw6Wzc4wNPd7Rxt7reB96LwOYEn3kViklY7Rc64TVVrv8rGGVmgN/bPARkznrxxAQDmcnZVBnrlwq9UIDfE4fCV2bCRox7T6Tscj0kZSQtqBHsRT32/42FMXx9NCEVcxbK0JteZH8X2dvvGu44ii0mJkSweRFUqHlUnoP/j0/qCecODKRCvj97dcoyGmEG9iex3q5aT77nRZlNCu2krPStuwg1aiKmvt2C2XH6F8AVL9OsgLesCTYwdGHZQo5IjzF9wPBNxbL6SL2efNQq80/LnKtdUQ1dWmOwlpUHx47mIelqyC+p/eCQAX8kr28gnpYAtydgwS77KP5P5ILuT1c2BvbHVLara18g+HllBQhcgH3477D8vRwoeNQL6L6kdRAxHcymAprNsG7VSN9oxxuW2B8ZhtxqY1rbeUmhhVYqA0Aomg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(7416014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WsEHkaOgQ/qaac8/L/z3JcHc0jyWycJ9VHbsKmtHRBAiIO/fsZfsMaQB66lzNlCi6NztGZXTN21A5vbBll/WZDhjgJkvobidykxH0cg/tcGocn9gP2Ht8RXgkFJgsqwkoVPk2aAVh/HdZXkg6mULxlvvTvvyNFtd/BVySDBt/LY2LhqJs9gCuDVrR9zsYWNJTc8mvc164NbO/AMmSWN6/9l/6o76ZnpGBXNRPhYDm+BG+OjpKuiopEBToIv0NwhnlOo+fmckxoiF/qu59T++aYowcayx90XGtG/husJGpB1DJM6Ib+dn9E8dx+WYMI4ZKjFNaFj+nvm9e1oDQisgTbBhDdzNe+vjo/KWH38AXkYdCwtV+Uz8elATADHyNdWAKgmCjS7CRUJk27AI941rQxnVzUfRuLYB0K5Q7utanw6BVSWqdf+JbQ/U7xE4uREk
X-Exchange-RoutingPolicyChecked:
	CGZMaluJtB+0dOdnTGHyhTfLM8Ia1dSrXyKjuEnKVak6lFxnazfB5CH/ddA4nN0yi33NveAajfiqV3ztg4TZBLYXf8Oc5QMkLMwjfRVtAA4GCl4nzeA/vjvcFpWCoah/v6EZ0yAa9ObNjJ8U7HnKSzygnsT89itKFJ3xK9hYZa3lvkYctLqpRcWDiCEjrgZaXPOHjvUFPXx/Kory0DU8QWaB95AqPguz8tWE7V+lUIz6mDSnThDgIBdrIVB7WAfVWHpT3S12xfTjJKMbgehZD7R1WEii2ZuHdVr/pomjH2X3clX0c2VhNpqWVlRlDPIPsoiYqwYYQ9qVBrrqpodB7g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:59.8341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6242f4-8b38-4968-c5c1-08df1df4347c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6300
X-Authority-Analysis: v=2.4 cv=X6LHu2Te c=1 sm=1 tr=0 ts=6abb5cd0 cx=c_pps
 a=m/LAOfpIcXRJv0ug5Ru3ZQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=3Zgdyr-LJFxGGd3ZCiwA:9
X-Proofpoint-GUID: JAXc1e7-rBmfOSqx8F_roL20xSr9kkQS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX51UPn/ihBCfm
 /2I7QeRo/+IwPva7ghxs2/W4GWWMt3DEyVK9yXMXihFPxEVqLATTdNVrvEVGxpZ1J9NLLOlc0kz
 uZsoYYBT0S3WAs7OfCUWoCApwRACsXw=
X-Proofpoint-ORIG-GUID: JAXc1e7-rBmfOSqx8F_roL20xSr9kkQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX71OSsi45NPR6
 6iR6LCsTP9NsuOlsbTwvb97nz9dK8KzIIO2ec95SCMspoEnTM112pgksM0yw4IIHqd7S4db0ywU
 nxG2CVAajdcJ6HZ6avOs8n9qEiEbOs1raGaBdAkqPZ031kY320empky+tuHTbp2JxB1cKC177yW
 kopQD2k0/j35f0cn/K0V0cV1Kz+vwzJdo2znbkuOL86yoj5lPcD7OdD68zYqCebipgKXEXsgXHF
 jp+kEPiXX4YLlZAu41JxbzlGihVpBDRUEIKHnBJ6i6S7f9CsjRv5H61tKgKzl8MgNmOnxQy6Boi
 6IIExuSSqFbsI4kIqwpQMhauuE25vDVK9IN1s4y4XQXwSt27Rfa2Cnhvg/EIwg2Tg7pX8T9yKFE
 pc4lYUT1KmHbg9JbaFe1qURsXAAl+CFRa0XCyVrl+HGQmTT5aBuQL26AKIYFyvhbfbGyRtICIHW
 WZh7TzVMPCwOx4UL+wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Run controller optimization in spi_nor_probe() before creating dirmaps
so the validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate.

spi_nor_spimem_get_read_op() propagates nor->max_read_op.max_freq into
an op only when that op's protocol shape (cmd/addr/data buswidth,
addr.nbytes, DTR-ness) still matches what was actually tuned. Callers
such as spi_nor_otp_read_secr() temporarily swap in a different
read_opcode/read_proto/read_dummy to read a security register; without
this check, the calibrated frequency would be applied to that unrelated,
uncalibrated protocol and could corrupt the read. Ops matching the tuned
shape -- the dirmap template and regular reads -- still get the
validated frequency automatically.

Optimization failure is non-fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 28 ++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d114d828a788..4597f07a207f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -217,6 +217,23 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/*
+	 * Propagate the validated frequency only if this op still has the
+	 * same protocol shape as the one that was actually tuned. Callers
+	 * such as spi_nor_otp_read_secr() temporarily swap in a different
+	 * read_opcode/read_proto/read_dummy; applying the high-speed
+	 * calibrated frequency to that unrelated protocol would run it too
+	 * fast for its own (uncalibrated) timing.
+	 */
+	if (op.cmd.buswidth == nor->max_read_op.cmd.buswidth &&
+	    op.cmd.dtr == nor->max_read_op.cmd.dtr &&
+	    op.addr.nbytes == nor->max_read_op.addr.nbytes &&
+	    op.addr.buswidth == nor->max_read_op.addr.buswidth &&
+	    op.addr.dtr == nor->max_read_op.addr.dtr &&
+	    op.data.buswidth == nor->max_read_op.data.buswidth &&
+	    op.data.dtr == nor->max_read_op.data.dtr)
+		op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3622,6 +3639,17 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * Populate the persistent template and run PHY tuning before dirmap
+	 * creation so the validated frequency feeds into the dirmap op.
+	 * Tuning failure is non-fatal; the device operates at base speed.
+	 */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(dev, "Controller optimization failed: %d\n", ret);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b3e3c6b10186..1f8aff53a2a8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -374,6 +374,8 @@ struct spi_nor_flash_parameter;
  *                      settings that can be overwritten by the spi_nor_fixups
  *                      hooks, or dynamically when parsing the SFDP tables.
  * @dirmap:		pointers to struct spi_mem_dirmap_desc for reads/writes.
+ * @max_read_op:	persistent read op template updated by execute_tuning
+ *			with the validated operating speed.
  * @priv:		pointer to the private data
  */
 struct spi_nor {
@@ -416,6 +418,8 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

