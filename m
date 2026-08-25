Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B232332907;
	Tue, 25 Aug 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678330; cv=fail; b=VFGJfMO0kYBMmm4vIq8iJ8wOb/R4MwRNH+C2UhfpGPr9tyVyuQ+haEX1PIzE35SSmNeB/u8HDeQK2H6wuBmz7PVXQDBcUkSgxfPl16p2xLtpkVDU03eZdvrbage/lijyHkk3J7o2P/C6JyURmr7VNxVSvK0UPzh+SaK2EPKxorc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678330; c=relaxed/simple;
	bh=aF/DbrmPXM4j0mLlW+L8B/c0eqWu65juxQfllEXfCQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tgb+TYyeQJtEnKaiE0HJCAKrBtPHlmUyhW9ubGZetzZ4bWHze682N0JBZ+ucHx7HIf3MeWOnzqKNYyINgxCnSbsfp2mbZybdQAkbxw46ZHqeDk/9MGBj2X8rzjdNTnZfFUyJvgjTkRhcaUkqU8XWzXFWMJ1fkG7NwhX4MpcJCBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JRwJyI+0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H3ONwIHV; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JRwJyI+0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H3ONwIHV"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEUwos1882698;
	Tue, 25 Aug 2026 12:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQ
	lA=; b=JRwJyI+0C8mh+j8fDIWViFFNnmdb0Cl0/RXQtrDQW7bFK2AJyFhiuTfgV
	gu3JA22+yUigXPxfp1yXJoxu7UYY0ntrI3my8kWWjXCAnPkc6QOvpgeoitTPfygx
	ugMF3JJvUrbwgnESWUdniP5v9s3nKL0iB1QZrXOAsYoOzj771WH5DRcKsvCcPr/4
	5NQU6aVOb/eVKvhLNEYX5uMstg2Qn+MK/faeMkv2om5RoIx+c6n5bgsxO2yMkLib
	qOq0PlhwMPC2T4f3jectofw6wWjVwDz5vB2gHwWKSNhVmPJhAnhUdcBh4t30z3MI
	UtkFgZcxUARbVD3nc05tXKNvmPhiQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g8xga5g7n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcf7sVBSk8RZkNIPX//nzZHEa7u+4rQ2Peh4qKG3d8PniE1C9ZGCqIDvM1O6OMGg8jyznFfEh6hN67+/nkkjJhl8u76N/OKfzSVNNENA5cxDUAKC4O5U8rzWYnNqWbgXcEIZyodUS0QfCL01XQ6hqw333J5dykX4Jk2vR4qeK+5CkMtpzAPfeGRgVAR/b0TghFNApmWe6gPHXFNGwOXRPwLx2I4lb/dXGqp2zV4AxGgSLJWx7hvv/dOTPmy67zDNMouYApbr95LGqO4jgu7CaatTV3Oz6y/PDUeqNSGEzUikuvAwia8Vphi4kQzcs/4uvAKEf7ORIIsMz86mSWM5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=bvN6KvW6RW02wP6WUAdxeQxQm3/SmGQf36GB162Nyr7Bra7b/MEC9fZeIkS7ugd4+1p3N0qgCKPONAJsa6drmTSXLT1CqdmeIxxnG6i0dgOU/fUfnSQwNCkVpsczlh8mL0IO3/9VjKQsfC5Jwc9RXi2t9beZrLacXy1Bq2WPm143nCk+86n8pTBTfmj9J9RR4Pf6CUzS6T8EHDJuULbGEnjuh3a8WZr0Nrt6xi9sISF8O+3pdlJtSCGVgiRQzw7qxtImaDxqhfaAYkZnDx6QHkfWQCM+WsTiUbWAW49kFo3KgwFXNG7BxFkUWiVFhNBTirwmt132FPn3tZY/dE7NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfcZ3asnTmwrkxDLnD+kXTLBg64BDPwemZSrihZFQlA=;
 b=H3ONwIHVZcCQFxff7lnBNWSeFC5lJa/LoIbCyuR7u0afA8XGstbRQUfLREDXyEGOXmOB72Ljzsi2cc7s77LSvdJu26TWmTGmuD4tLDILcF9ZUxYoOqkiFffB9Os3MWEawIwQuWUXK0PCV6pog2NptdmzWKKV3p2z24XAU/CcTFY=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by SJ1PR10MB5930.namprd10.prod.outlook.com (2603:10b6:a03:48b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:18:32 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8c) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:31 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:59 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:17:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:17:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3R1436664;
	Tue, 25 Aug 2026 12:17:53 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 02/18] spi: dt-bindings: add spi-phy-pattern-partition property
Date: Tue, 25 Aug 2026 22:47:21 +0530
Message-ID: <20260825171737.776052-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|SJ1PR10MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: bb208be5-8e00-44c0-1cd5-08df02cce2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	/1DemQgJqtpvlHvBVguUWFdIgxmM2bJirTurfBrRFXqp28hN74NRsW0dj0Ah8hwUh+S8C8ple33qpVVEd2RiyKplkgI3Cxip7vtGaVu15FFhEhQ4PwFNMdi14CwRq/SrJulPpuCVRYXYSswbJLnbUFxYO+G6U/0IGemLtI+mNlSK0s/6rFxcuu4b5rdSm+XrF+D9AoHdlgyPtPvEC0bL92Vz/Jwvjf4sNPA5ecZ1JasSKUu7dHRmBzHE6MqwRCHCcCCYU0hdsdr8w+CVtv2JVsFcy0WvAuNzr6iYA9k9z9bzQ6DKAPixwRKRIGqtLyYuHzNtdp1q8qt9H30CRp1ODqEfRkRSR2J2uNW6m35mEicboSyGSk+hvoOMUgz4M7i9I1y1tqqk3xrj6bfVyqaLetAf4ZXG5ammlULmYJOOsc0wdbz0rGJzMJfLtyGjbasfE5Rg5CLVGk4VS7X3+Mbc4uiGDTJSh3mVpY7c24DYy5GNppHoj6J3FFVCpmSFRn1CIgTIfBfWFHj7c5eeGQeNGnUfm1oqo+X3V9INsMnst4s7FlHDNE40sWuS87kSwTE65cFiiJrw3sBkUGKOR9wZ6aJ/ExUkStwoPr06/VE0+tGi4j9YIBEjgaqCW9BLxXesQ7pH4sSclTmYhWOi6x9TxIFf3vLjVbYNOLom8Fr+OvIScYpsP/GROouO4/v2GYEMEKTnsOVVYGpT3i12TUR/fy3gcQNXdbadWMD3AAKH+Mu1NOruiwPeUptPi4AkOezX
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x4kb73Q9toMcx9EFwo9/SZGrfx72A9MdMzfXpnfRUIvkGFfgYlD0HjrlRSgo7lEKOQYjk+jyy+C8CmBOafaaAnR7GNoLlStOjLSmmEq/tLcxHPIDhNZEC+W7SawE1owTgE/+HC+W2fSPkaL2rl8JV+WIPEQF0t9Jr2HGG7NlgtRG7xIiUoXX5CIuTnjiNc09feHMqJXf2IWV+hqma107zMLY/GhGlwOHQIlR9CFDTwfVRxIbfem7JRO1heacjYk7E94voOtEMKjqVBeMXyTjY4sGO08s1J0E5zzuGs6tcKCMiIMCnWWRxZN40DO8+ZAycYyB+9H7r11XWrbNAdiFGljq6dOg6d+q0o5RF0qLiGrGcbVJEFMejbbqzZBxVlv8nukhowTNDZ+/CRp+dIvsNGZMQIvc02uhYbNTOgctLysDfja15fiAOflfq9Ky7BLH
X-Exchange-RoutingPolicyChecked:
	Ej8jOIUwgHlFMaknX5YOldIXjtJPjUZVWZbh4EWV6zPMzcfye3QZE7DYxQtHD6E3JD/SiZyOrZDK+Fpm9NLBZtltxv7wjJPpsh3HqfWSduL4Y0M45h1crY9FB4ybi+L41ivuQPDr4d6u0EIYjHZ5OS25+GAIB7sLUMbyIHZz2PXlqZMBYhJ0BVT1XZ8pgd+DfR5GRTES/eaOCAgmvFyN/dYB733S4pA5WFmojwqAIMYkAYMjyRahu1mUj2Ui/MX9t1JOAHdtAkvu3jF3Hhx6ggMphpBGeicQtzPLzyDj3+9s0j4MAQeXFX4X1jvhQMwA+tx4/BVKRYLas7Qmlcm/Xw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:31.1694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb208be5-8e00-44c0-1cd5-08df02cce2e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Authority-Analysis: v=2.4 cv=SuygLvO0 c=1 sm=1 tr=0 ts=6a8dce6c cx=c_pps
 a=0NiyxO+pn7gKe2yT6URb/w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=aBuQwODoJmrdCVe4joYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX+3C6gdBoXTNt
 ASDQmiZ12sF2vHQpGzbvIfWSz1iMchrSZni22W7uXtjZwfKNPwZiUwLmr5P+/LHJLop1x0yVsxc
 nYjeuAWax18435EIsRulSXxZyDxESGc=
X-Proofpoint-ORIG-GUID: jhgcRm7vw1-TDjJ3ZdRRIrf7azbL20w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX6kMm5fDmDP+x
 f7pNo+vlmOeq1Fqdi9FIkrnDI9B5+qpYBPw+u7Pn8tcQ3tYvb8PF7Vw/fYdLWg2n0huNnAjqU1w
 RZyOdOGQ4hAKev3nm0mLVQQn3tewLnDpRrnF+M9jlSXy4YyFR4oJhABjzctsmxo2OF5T2CBn2wD
 d7ltdheAyOLhF0vgtLQECDo6bXylX9utLnDYGD+yBLAuXi3k1NPNeUj4/dvdR13ikYp5ED2wr+M
 mX6Sd68XlcM2C/ljgnc+8KARrbWkv04bBDzGDag2sKA1ZkAaYvKSZUSGLOr0HhxprnLEqjMlScJ
 3L/GZCa7HLv/iZnY+d0SxmzN6OF0Yx77Q2TqS2PyCvlKdxBLtb9CghkqLjR+4TCTYfE3guuCSJS
 dvhf0zzlf3UoFVpfp6j9dEx7uTTQVGqR/V8w48VMdNLOUMxny+uz1gQ8CL86BWL0HgVhDh/UOxB
 S9aX3LtHpohyyvLuXvQ==
X-Proofpoint-GUID: jhgcRm7vw1-TDjJ3ZdRRIrf7azbL20w4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

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

