Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC23E2AD1;
	Tue, 11 Aug 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473323; cv=fail; b=U35rPBB0niGm/F/RJVJCz1nhRUu9FUE2HBxfnzFFk7SBI3ndpj4TR2L3zJ2QshCZVBvuBF6YnmVbHO1nTVaU+qUTVc5nHGDftlPSUtml4dXP6xB9KCJwzx81GWOIa4tL4aHoCBqVZxlqVSNyGlw8ypZ5U1ozltFSzrxAI8I5hFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473323; c=relaxed/simple;
	bh=/36EtgSHJjgS4ho34Va/fE/UiN7oZO1CuCAHGVoo6vY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUys8AkOs5cvCYWjuNjFqqiOfHuNrhvQiAPdVnzQGVg+reINByuJtBgllFQBo2oKtSShiutfpcdKazDvlls1JTePI9T9xKWq1Q3SMvasyySY/CvmC48fC6nFOmiXawqq1BjpkO7fRU1aPCe9nvpHRMkM8OX2AD370c3A9sC3zh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=qI7EGqKd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uzp1qasF; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="qI7EGqKd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uzp1qasF"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67BGM9bg2460642;
	Tue, 11 Aug 2026 13:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1Nf
	eI=; b=qI7EGqKd1+IPxup4nZyook3Zj2tJgZkIcYB3nKtUmd5dfA56aSn94HsEq
	QX+v3uC4SUmbAeemekVjK0g+lDc3shZB/DE3qR+5/TSVWPwML7DYTXBqrM8dLOSm
	DYKXpg1qmLcYvmFC7wzzvjM0wSD9iAntXwC5/GJaK/ywhJcH4Bv5y8KAT8AjwvN5
	EfB/GjL7HFYJ76ay/QFrYLkoc1zkDU3ZpcQrPv0tNg2W/aDShJ2ps9eGJGS7O27e
	7GyHLhVcyTJVuWZGKTbRWYdLEX1a19pLsoCQasLUSXPjjpAvtGzjoLliZuL0I5X+
	W3PgRQ9n+I3C+egFtbmy3JHOuLuRA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g00wu3h84-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTt7HH6QOIXTVh8JR2Y/xeocgG69hrDwc1UeXvaaoJiREA+VlJUF9J+1qdx0CqV1DcHBvhte/fyj+aMPzmUXCEZFBf1D6NuCxGYqO6kJeT/RuF/zgX+AnIY39fbwimoIz160qTLr1UnJRRpOERPs3Jl4aT0CbnpyM8MDB7hKhOh/FvjG277M+a053KNSlAllSpi3QGUTaETDFdD3Jqzs23Ic7J86FsR6MowYCNhbU5R+vE35Yie/I/ySjha0TZFp5DVQQqPtuc4VDS8XL2OnQJV5sMuCjLh+OdCGSZj6QE2bqmHeVI5sfINgAKRqY/rnfdNCJ1RYPSsHW9WbJo17hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1NfeI=;
 b=yqyCcVvETLQJcS4XyjAyGu4xon5fQPVdNJvgNaQJejRKq9Ch41Sk3zF5mugdb3m4FHX6EdfxDZpp9XcLsde9hxVDuQdzfdxgR8hco0B+zlcE3vYEDU7T4BU3txSD5eyfaKPga7O1AnHagCBd2PZMxFErVU9Ja2gDOetTXTz5+Sfb5M9lXwXvAw4YUwmuUsAEvok+urFgeGtkQtDSXpE4BB1CTg3Q0afDZL54pTCXuIv6weTeh/MeSCFUW1E8RVkliscNO2ovYHmjQGJqbqxZdVCt+pdeCUorehOqnnHQvW70Uu7tnXmUITl/RW5w1kb/Z5u+7PsKvJiKRO1fhYYZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5jcawn8CrAjnwc0j/CFtto7zEM1fdC/gjWbyM1NfeI=;
 b=uzp1qasFLosakRijpRHswINZepceRD7yQMv2tk2n9cJmeWOPTjEDOfL/lxEVsc/rK7or8UXFzEu1a5oihiffKFCr/cyYrR5f0+BXWn1kcfzVV4YsxoIZ+r2oLkJdEh30SDXiq8NyMYtZSPQSZeJi90pFPeWzRhTKNu/95Gpul1k=
Received: from CH0PR03CA0440.namprd03.prod.outlook.com (2603:10b6:610:10e::29)
 by SA1PR10MB7854.namprd10.prod.outlook.com (2603:10b6:806:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:35:08 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::a9) by CH0PR03CA0440.outlook.office365.com
 (2603:10b6:610:10e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:35:06 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:40 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:32 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe6659766;
	Tue, 11 Aug 2026 13:34:28 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 14/18] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
Date: Wed, 12 Aug 2026 00:03:09 +0530
Message-ID: <20260811183313.1550425-15-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SA1PR10MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: c72b1846-eeea-4325-7c07-08def7d7445b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|18002099003|22082099003|921020|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	o0A/Rj9oRXDyfHdGQSHDRJcBnlu1iNx+vYzMBPb7CA8TxLhH3+rzQG9CsTsWt6EWox8fJGRVf9kvEws8xfN20+toeJpVu5Hh5eDRG4ytCdF22T4Dr0Dt8ukLoAExIueJ0uludcCZxyEdh7EY1vYR8mmKfjOrW4Ls0zZbLZTkcQE9+b+UJohKhzfF/vemyfAl//A5bttCRHa3MDQk0T0rdbLl38Y0H3ByiftBRgS6930mnikfJDmdtbRHl0X50oYIR9EfHJ0LcNPfxUiEXpbO7E9FDkhf0l+2em26Rzj9Kv3Toublu87S7WEIaWyiB0/o+lE5MNekj6mZg3btrwWaRRkkWrvOANQof4U7dlrqNBSdIiMST6xXZUJaHEwPA1DrV5yxsZ6ekNvvx82YFeOHhlNRZ9qZXfKy/C0BN1n68TW+dd3zlu5nrF5G8SQVx2bB4WwCEbp4VS65OYIhSyl78/FRfaPckLJujQ6/ytDXUNY2f8c/R6Y3LvJ/u0jgZqNgRfnHZJK2kA9VJHQgpLVhNzgaaWG1Qg/hQ6BzdHtzLEyYypJyRhVeYarEZnQZg1JILIWFN/nStYRK+u9dwQHTZO//DOJw9OflroM/N2rwUhmGGwEf1By9BKDDhR9PDcIj8dvE2vkpkxkzAvPs9MQXV2ZSYkFNH98BrK+2Hv79EHFZGyehxvAXnpF4LAu0zgMd1wuM2hU6sBBX0sKreIiNQ7UrXNSG+Hluf3yatZkZgaDE6vq2Ze4H620ls1mR6OmX
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GtsG0xHFZZce+ML8JNtq/KJERXjqxXCAh798RSpzV0QC2jk5S9Bhc8ly2awuPAc+YvUeYBqCSHK6TNGg9W24Nv8HjkTYvq2Ruy+64vX8xz6xkwFRJrqeva6NaLy66CG3gHwDWO67QIvJE3IgCQVGBtJf7gEN3G6yZ0HSpeR8XE8P9BmIght46MfnqsZz+qRYyCxgN1RnTJtiNvSUL/zXvk/XRTx7DWoJ8DIZYqpV6I1W6eaR4CVnxfAR2Yg4kynALq0moFa90nNP/z2bODoPMmjXlB8MaTrWI9Wc+TX+S9OZYTGlVeuQJxdUUBVTJ5S3fgAlJNm0No3y0vjQW674B6qX+jF57ImUzVGa67mj1sjNgRcdLPtJ+/eCtUMfiSVi+rR+re7JoD5O5HmEeAodWHVptGlD2s0giniNU2wrDFmairlDURS3Rj0WsI+BKb8V
X-Exchange-RoutingPolicyChecked:
	l9ZBKx56M9VSDpr6SQwt8yl2iwgcpCyUQxawHtYaobb+WSz368P/P2X9aEkGKUdIwaZuJFr3OEGR/J8Asm5dAtThBdqo+yyURgVQr49uYUp4culb2N0BXF2MwSiEOH9UjuLtjKQFSkRLlASPa45AGNWp69t691PTPjaGAxpIuMXb8FdCkreikyMqBTAUPiItSxckRrjYh4snpPuM6OU7js8rlNnpIeHNAWcvyXTlz1+8KylDev4XGtYokG+wp09tVbcrRrvOm6FOPehQOjTOTjnMnyv8iczYYvyrgyiis4AHcGeI8i9gXy2IPY/hLkCDcJJmLomi6DjAQBelSNsMcg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:35:06.9149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72b1846-eeea-4325-7c07-08def7d7445b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7854
X-Authority-Analysis: v=2.4 cv=M+V97Sws c=1 sm=1 tr=0 ts=6a7b6b60 cx=c_pps
 a=p2N+vRIgjjfURKXzpqLMRQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=UNEB7AwOHobNk7BaE54A:9
X-Proofpoint-ORIG-GUID: VTvCEUC_1g4hbp2WUnVmsWvcV5dzc7cw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfXxOEzLc/zdnOl
 TSVe8oV+5VQaPWLRkVdLe+Ux4QTHVNBlUQNVZkhDkxPivD1HH+nKtRO+WCeCjqdipr/FjR6uejD
 1UX+TQ1nQQD7jAAIEp5eZCGi6I7oKW4=
X-Proofpoint-GUID: VTvCEUC_1g4hbp2WUnVmsWvcV5dzc7cw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX8jJV2w3nfC7C
 U4eGctOtOwvS90VyASr1ZLYjG3W+r/BHqKTR86ntQ+jlv2H62AYAcxFHwtqmMHeLCfVvwdmPhTX
 jlQUUH7hAGobrtupMCkT4oTLUse7o0sumoHoCUjv6gAbzPDwolo8Z1oKbMHp6aFuQfgNUTorjuP
 kO/ySY+e6njc2FH0v6KPg2ucVDIsGmhhswhQFwS8S+ZU+B8bmC3DKsz+MzctMxA2mW5QYdtg1lP
 /WxaRpK1TlnkyhSlbD1vlA2Tc3xYE0VxPRYUWwturyzGLcBQ6fChPzluoCGs8D0Foyb0nqAWrDs
 lJZkjOuo/TlouC1tepCjyLATftsMehdzAqjg0eBKsPYe8EuoTNpoW0FChfvAHsJbwg7aORflJg6
 TRpuwlBZkCL6Cn3NYPjh2kzB//9Go7LyQbTkHXuIbetxkE9aXYk5LQnUqS0/fGp79oJ6ccGdDmj
 XgbZZbvEJcHhx55vvNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110156

The PHY DLL loses its programmed delay values and lock when the OSPI
controller is power-gated during runtime suspend. On resume,
cqspi_controller_init() reinitialises the controller but does not
touch the PHY DLL registers, leaving the DLL in an unlocked state.
Any subsequent PHY read or write would then fail at the cqspi_resync_dll()
call inside cqspi_tune_phy().

After the controller re-initialisation, iterate over all chip selects
and reprogram the DLL with each CS's stored calibrated RX/TX tap counts,
then resync to relock it. One invocation per calibrated CS allows each
calibration to be independently validated after resume. DLL resync
failure is non-fatal: a warning is emitted and resume continues, so the
system degrades to non-PHY speed rather than blocking the resume path.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d4181b501d8d..c78d4ce1c930 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -4017,7 +4017,7 @@ static int cqspi_runtime_suspend(struct device *dev)
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	int ret;
+	int cs, ret;
 
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
@@ -4030,6 +4030,23 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
+
+	for (cs = 0; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		struct cqspi_flash_pdata *f_pdata = &cqspi->f_pdata[cs];
+
+		if (!f_pdata->use_tuned_phy)
+			continue;
+
+		cqspi_phy_set_dll_master(cqspi);
+
+		cqspi_set_dll(cqspi->iobase, f_pdata->phy_setting.rx,
+			      f_pdata->phy_setting.tx);
+		ret = cqspi_resync_dll(cqspi);
+		if (ret)
+			dev_warn(dev, "cs%d: PHY DLL resync failed on resume: %d\n",
+				 cs, ret);
+	}
+
 	return 0;
 }
 
-- 
2.34.1

