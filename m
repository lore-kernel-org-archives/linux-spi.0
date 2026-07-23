Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC9459AEA;
	Thu, 23 Jul 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804588; cv=fail; b=XnWate74MfBU0D1AEI3ccAUDjOHMernRvq0yIORGrvOFSZQAAbAKhsd8TmlEQU2Yu/Bo4mKavRNGNAg+ADKIpAKIamvq+HB5ggz+eAUJTB9AgHErgbaPJx12aehjZIafpwN3l3ffJpAeDp/x5tkOBqf9OA0Zs2beQ7Ia+aBoFG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804588; c=relaxed/simple;
	bh=aF/DbrmPXM4j0mLlW+L8B/c0eqWu65juxQfllEXfCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ce4tv3EdxLms4qlqsUNCI4sDQzgt1xCgNygmkVW294Rldy3qPo8gw6UPnPW0uj47xLAiFTwTJORMP3g/YyRUcIS2ohYdMDyVG2ooXY8+GkeRcfmCqg8Twopx0ksq131x3zBB8ahvCdwWahL8pt+Bc3dq0ztRuAMx37kPZQdKmhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=F0tLFVaf; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SZGLIf7x; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="F0tLFVaf";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SZGLIf7x"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MK4n4111149;
	Thu, 23 Jul 2026 06:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQ
	lA=; b=F0tLFVafzzdtbupgOGRFzprrdrX6dBIJgNPfwkpI6+EnWSL0Wy8drPVYX
	DIayrvY22dnDvtzCHVQP9bI6Ozbr1GlPJuw37OjoS+JbCcnoaqiUEEiua5Ic/ypk
	HVUnN6IQ0meactanZGz1+bpNuQmzwzL6YLe3jQ1vWRlwwkwzVXb6DqkmzdqVpZSD
	LXDIci8D0NsTfC18OZX8uD0/hG+UXhVUObF4+W6wEoi6P+P5t1aFfWu2loIjv7ky
	7PqugoetyKRMJ3wOrfAHBHieqD7dSp1XGiQjoEU2g7YMui5ufXrNriXgXeU/qfmC
	7F1GOHrprDMuH/JQr0v6F2gMUyDMg==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908csx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:02:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC/pfl1Rsc+7YfNywFWqiw2NI9fBmCV1LloQJojPTlXv0Sp9lI9WOdAu02PCE5gXiHK1CVs4JfkOz9aWlF1sBhpjprIbZ7JF7iBWRCKKfX4Xi1DUWULjcvsP1PRYMjGRxhu/P5rUDHQEujYc9C8CFrretsIfXB/29+9iVRVAipfNkzx9l+cMeiJlvzMtIbFcYeERUg4lohLw/fk180H5Tmc8d9Rhd6XR9Gon47RFXgT9Ma2wPLFyrAb8sfywA9faqnZ1aIsy0rwP+1PXOKnPGgAJajSNieveRC8X2irCN3tAd8u84TFFkUVrcN9OqBz85uQE9z8tMVb7yr3irh8TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=o8Il9Wyq4y9ASEh9dnfo3bcPmUMDofF+gwndNYxkdw3YXJprl87zNhJkC3hZUP4DhsgPAYj48lMxrOy4uqSR5nO3RIY5qNTVxwx72wc853euMySPUlMdugW4iv3UmYsH41jRpx1xPAqjazFxD0dOrlp+zXhDGhRXANGvzH6dLcC/ws6LClVetmFpplBX8XLT7IMsvrN5k1sK6DEtlxMq5ruuvYp569Z3oC564zl7DSVYkEiz82rgg1hmgR32IJDIGSM8YDBqPdJor+OKXZu1ku8OYp06eWiR+u/wgJHCLtdR3SFcxOnKc74lLfSeBkoB4/4D8gB6mlRvUG8fRpMzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=SZGLIf7xE9XCqzWpSDcEVPgehCjsPp7CGBDv9mKcUvQoTzpbvPzunahAqFDGaIsjCaYCfZ53CSPfA3DEkZqlWdL8rzOm3GcRcWw2OuB3wCm5jFc72VoonNXPiTtqhdjm/6Y7upXnOvtAY33SOkJCig7bTeGyAyNREhQMmWtrhfk=
Received: from SA1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:2ce::27)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:02:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::3a) by SA1PR04CA0023.outlook.office365.com
 (2603:10b6:806:2ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:02:42 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:41 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OVw1577597;
	Thu, 23 Jul 2026 06:02:36 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 02/17] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Thu, 23 Jul 2026 16:32:04 +0530
Message-ID: <20260723110219.3180747-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3d1eed-f7e5-44bd-37a9-08dee8a9eadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|22082099003|18002099003|3023799007|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	cLS9Ev1KoyDz64xHgUvTBZLHdgZ5y9QuQTN8NLbJGuyB6aDFzierfafd9AN/UzldVGdTgC0eyOZUsHrmDRwJhTTiVC4paKSI4WTrbrmFVPx83DnG7DYnRYRHH/N+Bvmo7XTIk/oxV03q+nFDx+040gJTCAqVvbI+KvVqYPlOgW7oUSWdr2AmyGKWEVTcgjkH/JS8+6hsLVx07jalZOLYiZiwJp6D69JXUhIERrYUCRmXZ23UPgt/zJhK6aRNFMrhJDjXFKNfF+KN0ncStImKJRy7QZ+ipViRy5c3BCfGGP4HMIM9rQ1UwOKrB62H/iBlITlGlK3uEQ2e8rs8gINF4EN1M7b3eCvDEScqwOiuKncb56q92KLncYhjkEphfYNTQdmi1IuRywHvX2OyuZOkiJYi2GpcK4jz7xaLNJUBWB9ogrFZ7HrA1v9QKIuHsLUXB7jAJXQKmeCubNMsu8WRqZWpnPLok8fOl45GBoKvql4ti+dr06nZGendZe7ESp+Caey7UZw8Sx426MYlTdxoVl1odanN0hLMkd+ydyv0l547R4kn7TaPP0f7wvmeqA+0eWbzELjyrGkA1n3kBNbUDmsRm0Fmb7p09b/3Fhgc6BU1G7bWNv+45E/XL0f3PjMLd25pet2MzNm6g4GQTDK0/+YsdyuOmKwbZNNXUrx1OtFBjV0HdEVRaHm3k1nz6/wxRRCwYDfyWJv8SMs2A1aDjddo49uWgQ5cCP+WynA1/Xmiaqd5yVHqK7P1rR61M0vJ
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p2jMmK6xJC4nQlEiQeRMthtsOGaZdScEGCGsv27KE9xkOC/7qD5Ame+nFE5t08jDIwTxha3cn7oosncCGwHB4jrJEpvbpiuLSWhMRFDE+v3MngP09AUxPdqBCGjU66fcjf0J/j/32c8SfDsWWuqwvyFQySD5d1UBDSz3QLKyHbQtQBJt4h9mx1/GmrdVUHKEpHthxn/tfCVzhERmthCyx3yc1KoJHEcKKeRtSqZlMAyj2VKMVQFe5HckAQEpCZ2DvVL9g291m985t1gkiPwB/4XY3ZH9uRcbYptYG/9bIXk6i6ddPpSCSfnBZvrj19hmEeDpJGT6rxyFUzVpvqJn3dBM5blPdUkY3GwEUoJ1ned2At31q5PRyJpz3M0NSpQqIxa4TSBx5NXX/fkgFDZTW1nE0FDtbkJwtpif4/eALWbahLleqefJR6BiU75ojEDg
X-Exchange-RoutingPolicyChecked:
	mfOXPy8fsnix18d+d0JKCIv95iwX1x3VOn/8pGKqXYb9kL+P9nnOxGxZxBJLC9iIOXuiGCJgvnlznhuI3lWEWPvSGhnzAsp1uvvyS0Ult6HO4SaR+1Z1xmS1i8dJJMdSUS/sn+8k1iB0ImokeUAM5klznz6jdT8xi8kS/OzOu+sqynLTnvoBDKrfQZrK86YqRa4VwkyL7kaaZqDuJu7AaP4BwT/d5ZM5nyuLl71HXucHUluo1Mf9GDbfdUHFGf4ciP2TYqsML+fZTZdAuZYYePlVW6uN7pDu4JvJqBKz6fxxLHwnr1YBTHPDd7tgKBr3gr4JHebwnzjZeu0Ip2kblQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:02:42.0136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3d1eed-f7e5-44bd-37a9-08dee8a9eadf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX2Dy8RDq+L/Wc
 oRnEy0h6LtPrktKIQ7Z8cOuZbHOqb65Q2uc/FkiDhIPsxijBnptJF2laKOxj9sY6cuTL9XR4aH0
 2y5HsAqaSuWiW+FIKrfhhvQG9TkWek1vCaH4lVEqCIouU+1ZzpWmbZaHSt8o08eQjbHa8KhEFMB
 aSDB1aJNhRUoUMG12j8X9DyTDCHohf8wKnvfkD4M6G2p8spJFbcdZSHi/OsXxHZgl2HAdkLEHp1
 QC4l3bN3Z24LzqWJkwEVjrE75RXXH+0K68JohpRVvRA3M6Pv45E3Oc5IPY6oFEv283/okDJb99t
 1XCELryWPOX61vMt8VwLE4GAB77Xsf3VxPLuwvQun24SN8TPTpLvrDxXeLcxOK31EVT1Nb33h75
 aX2Yc+HrwtVfRiHTaLCVD0cGEnfPoHoD5Aj20kZw4A0dyuenzCqcqqBaqeU2EwLUyVFslJ+Cv1Y
 uFvJmFq39LG3iiNr/FA==
X-Proofpoint-ORIG-GUID: hekhYj6kS-FC7lL-kkSsXIrdQ29X4f7V
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f4d7 cx=c_pps
 a=/2P0sUepIMZl1V3lWabuzw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8
 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX+Ov2A6KtRBLX
 9sVRJT1ThCKdBCUeai4m171B26HJdxrBhdy+bU+WtztOR7gNO9RQmMBQpNnLirhV2eXijFotXgZ
 HprRsBeNHXV3j81Shf7w3srJ7261ydo=
X-Proofpoint-GUID: hekhYj6kS-FC7lL-kkSsXIrdQ29X4f7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add spi-phy-pattern-partition, a per-device phandle property on the
flash sub-node that allows the DT author to directly reference the
partition holding the SPI PHY tuning pattern. Used to locate the
pattern data during PHY tuning when the device cannot load the
pattern dynamically.

PHY tuning works by reading a known data pattern from the device
repeatedly while sweeping controller delay parameters until the
capture window is stable. For SPI NAND, the driver loads the pattern
into the page cache once using write-to-cache opcodes, then reads it
during the sweep. SPI NOR devices have no equivalent opcode, so the
pattern must be pre-programmed in a dedicated flash partition. One
partition per device is required to keep the procedure unambiguous
when multiple devices share a bus.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml  | 17 +++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml      |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 891f578b5ac4..277dedcd4246 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -209,5 +209,22 @@ examples:
             cdns,tsd2d-ns = <60>;
             cdns,tchsh-ns = <60>;
             cdns,tslch-ns = <60>;
+            spi-phy-pattern-partition = <&phy_pattern>;
+
+            partitions {
+                compatible = "fixed-partitions";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                partition@0 {
+                    label = "data";
+                    reg = <0x0 0x3fc0000>;
+                };
+
+                phy_pattern: partition@3fc0000 {
+                    label = "phy-pattern";
+                    reg = <0x3fc0000 0x40000>;
+                };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 84976fd3ee1b..cc01b643fe9b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -123,6 +123,13 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-phy-pattern-partition:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the flash partition holding the pre-programmed SPI PHY tuning
+      pattern. Used when the device cannot load the pattern dynamically during
+      PHY tuning.
+
   stacked-memories:
     description: Several SPI memories can be wired in stacked mode.
       This basically means that either a device features several chip
-- 
2.34.1

