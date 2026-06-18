Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D93D301D;
	Thu, 18 Jun 2026 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768300; cv=fail; b=PJ0XOB5CfSHoB8z3WtZ59v0/M+8xx7PwO6N/NNARO93+jBpc3WTr/ZtOumCUQN503ZFNCvUvda/dzF0tYHUu3CTp5ODuFX41FCPOlshG2gdEz8bSZGIAfkdinvgR40P51V2xa7wdjGxPla/qex3ZuMOToNFX56RsIyXxD2oTQNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768300; c=relaxed/simple;
	bh=Vu1teNYjRv4sFo36XLDl4erWEbvPwLbZv3uwiHzCMqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgeCaU9W8QbRnQ5cyJzB4qOMZLsg3kCprRR/sVU9k5dF12jMrNyR9ZlQi+1wOo4pI2rNXqPU0EtOehNwsZAIkGdxsBYy4vAj0BLXCaQHJ59QB+cZt+DU3r+pbfHot34ELxz/j3Cdd2QFd0COkY4kHf+vwi9zeEz6EKhnEyDWeLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GY/eLEbO; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W2egxUxZ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GY/eLEbO";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W2egxUxZ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I6iBrS3435899;
	Thu, 18 Jun 2026 02:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mqbrIgldhLr+OttscChTubSiZsBqcUGXMqM4/HbER
	OE=; b=GY/eLEbOgnt9kC74FvoDiyguzf72pdgPk4rM3/2G9D2V1SMLzmyj5yTIx
	z9YE4AoLx320K4NQb3Mxn21E5mcdyiB1qa+A8p34BbKGLWxHeLTE1XyyBJ8uwOtI
	aRMAR5RuXek2q3RkGRR9eTuF1o+tk6z45UcgJ3MHf8H2GYmM14CYbpZVB76Ao4Lf
	z6Ns95LdDWfVew8gmkxTvo7GqED1Nw40Ol4u+ROZcurjZQnbF2GRg8vDt++0cD7L
	JdK1VwUEWknX1LyrtU2o7ecvyHOzAMMF3JbIdkFmP+l+T8VdZ5z+sgDoKlkcudxR
	Q841IQpnJiJNHBWXJZzAZlddyZ0bA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rj0y5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjXV+qNV/FfQp1GZ7kV1T065ZUkTn4pCtDobjfF/DeLiA2AuZyqKIUXm7otHIA34E/+I3oHDE7WJF0rfBDvTfkOg+LcuIu+1sXwcdATi/wqo2aozSlbsrXtHoQhn8TsBkwaRf0Cc3z6/bLv1xHLuIfLXCTcxexNKbL1C/VHHklIXV+yhAvXpxDXrlRKCrJyZvewdll6VZnOM/Ow3T7aDgU2UZaxm8S3to1v419SAi1xbejPrgI7l3fcD2Fk8C2N0HdaqOld3MS0Y15yWNfMmsuJSgjv4yrDje/noE6KIQbNeooP5vN3Y25HCIZJB7rOARi7pr9HIoB+Xe4epprVAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqbrIgldhLr+OttscChTubSiZsBqcUGXMqM4/HbEROE=;
 b=sVXRT7/9YgY3rJXPMYPK3x6SCCmIvSTdSnulISJUn9ugp42zZz6SL7ZzWAwOkZ0/qPSzvgc2jT6xGDxWgKPvyQxcGvVXOdRJT43GWbS8E7uNIqpdd4M4a+0y56QJkF51/IRQj2muiWhq/H+qORU4wQLQ306U5SK24wBUuRPKSQr9T3FzMBdknJDlgRfeOnOUmxAOPYs/ZVGb27zSmcFhqWk2e19gooblbO3edypJFh9OJrun/59bv4xAiCokvfU5vqDvVr3TsCjG/TKXzXLWkRCvzN5ZfzecxG2vhQjXHzAEKniAhk46PjL8Q+aLrzvX1j9vh1F+f/qDl++5e3fJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqbrIgldhLr+OttscChTubSiZsBqcUGXMqM4/HbEROE=;
 b=W2egxUxZ6fLt2InPb4tI9bQcs4RlVEBIEG8U7jxEWRV2pi7hHeZ/DOqQwoa6fXEV7F5SK0PpmWy/exdDm/l4AToC8Fso/LAGe0KnS4tnyTVk3Alybi6QRJsY9I/pykaQQINKtue33wNpT3s1VLuag+sErH/DOw1oy+aIXqKVcD8=
Received: from SJ0PR13CA0113.namprd13.prod.outlook.com (2603:10b6:a03:2c5::28)
 by IA6PR10MB997584.namprd10.prod.outlook.com (2603:10b6:208:5e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:37:59 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a) by SJ0PR13CA0113.outlook.office365.com
 (2603:10b6:a03:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:37:59 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:45 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:37:45 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvc3521710;
	Thu, 18 Jun 2026 02:37:40 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 01/16] spi: dt-bindings: add spi-max-post-config-frequency property
Date: Thu, 18 Jun 2026 13:07:10 +0530
Message-ID: <20260618073725.84733-2-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|IA6PR10MB997584:EE_
X-MS-Office365-Filtering-Correlation-Id: 458b389e-275f-4eeb-cf6a-08decd0c8542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|921020|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IFvy/XAbPZWnHVOvMvqtuYf+WM9zdgelb9mij4Rw2/F85+vDmitTmTQ11TIqm8ZD+g1CCdxyzO1BGz4ICjQwqd9FTjoI2habW1Nrd1uHlvcbK5YCTcVBIVcAV/jG0oAdqivSPewlev6RV8H1rFDSMzGSILIj0rjACo3DHvYvt7VgqbZTjsEAR38Xf5CInVAeyti3hwhDBLma68B2gFFOXheuiByJSdIS+BkJG4kP39izphNyva3plv7zCo8sC9Iec9G4+I1yPabWYtRvjHOMmpkYU0KwUTjl+n3DGtk8PHKYgbtvrvQZQYt3hB6HmLeE2E0ecFbLLYN4xEe6nBIZtVfg4sfk7GA4mbXjtHaZEw1xUmfS5HtdJtyxfv5i1yvqgwaqszncFoDO9R0/9vLtHJR9/azzO0Z4gXp/+i+xeiw456oLjVkdq6pX5wMbN0VQgRzkv6vqQMHDpcaVLOAMQUcDoEjKQ0zlD2xPPRQkzNzGXdopnfWt/EygqZ5rZ/r1cwj4/vxanyAYVccEIozbHaqqSM2MEgSfRuLb2y6GF9BsNs58Lm0KcxJKgweYrFOud4ra5hX2tFmM34HVMNmJBFIk7SbyxwthMss5orkYpJyL7ws6TaOcE1NqmC07VVi3PqDrURSmlnDzJfmVunJUYBIOsJKFbTvXnYTrlnIW/m8DpDDNE+LuhYM56zxuWyENGgFUFU0mPPWxkyL+EbWuwRiBBUPPJnQ1Pi2Md7r57tMY/yD1CDC9J14Jduz4FJNzWpO0r9Pn/772Hhv93RueNA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(921020)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bz5aeyxvhQn9GjG4qBv9ELUjhNWCwmGER7y6oErV+LlS/jrA9D2196jO299bhXgsAsMFFzniiTjNFqj19qDCP6wbAs2SzjoR42mGyCJzIvXnJr2kduWQTvvihjxpSe/+oxtVs7uJCjOJ5l/mtr0baZ3QN0TJ11V0VdyS0rn54Y/43pxSRWqVy6wO8IzwB3CQvU+oxO+Qj/Z+EvxM3BdJHzt424wEC9jq2gMe6LdWu/Hmrvzv8YiFxXsLiwqZQf7cEsEfnQGgZzPpFfjDYpfc3XzbuDFvwgbeBXqhAD/gHTutMXEh9T400v3gKa5Sx3V26Geb3WXCrcpXZTMq4J7cX4tIHBQkxTehkzCik+h0/k2xDX1+priXfQWBIr13zNp2b2MIznarSStlL7dz7tX1djTUcEUHkvtqH+L1h7QEg510THP3M3DZ1KeH68iTuzCN
X-Exchange-RoutingPolicyChecked:
	XRMV4SKX5+5O7zVoNazkaCLyD9XPX0a3yzSBBVmCkDEfrX2i41xDeo3DRTexLzEVLK22t1oYR4D4EXp67RG/q7iZN12S35kq/+kux/a3GrRzC3oUnprx81tD3zFKG1wjyqwemAPqxqNX/+FvFr3Geok7pokQ12d2nlFeIkPZClPxCWDoT6iFu2+jaDiz0HFz+H34Sk0QyfPBcJYtaMRBub/kaqSoyYPAUs27u9OtlgeGGUF3x5JpbKF0R2REbH8DCA2Oj4nILm6gDtuuC7cEfCpdXNZneitrn3fyCpyeuTjsXMvpKABhPaIXVabfQGKr6BF3TfoA8p4f3nCxPQATfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:37:59.1002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458b389e-275f-4eeb-cf6a-08decd0c8542
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997584
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a33a05a cx=c_pps
 a=a2CzU9h33xTdk3q/+L33yA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfXwEVlVTXonpFD
 tMoQ7WMIEQ9mSvbBZ60zG/xeJT9dH/X5F1pFqppYxcwSecaptqpye+8NU+ewlDAPLPEylcjI9aN
 1R36iyzcLyAqtWGn3/4Yw2K8WTwETNSftmuMfp5nxAkMUW5l4e4VGf4ThxgpRi5eMw+n1UP8zaT
 Fcvn2gdB4pXdTm0NgO584dIPi80AdW8bHsUi6rrL2++zJtlrEbhNua3kG2Gyc1QS4K4dhLGdDOH
 B8AWXQgecQsdF1V+hcs6oJCUwgBOOJcWsR/0IcM4y+Ub54FaPCmJ40RcmtpPXzC3VhYscKtce+d
 mzQ0b48tfaOVYbCQQgFbhRexudwsc03YvlZ3LuJ6AMbb0XewyKvy3qj53VV4kHOT+1O1fuAzsxy
 GWewPK9X+4eD0Vb0k9e52407Lj0eJfa171b+KXchGFmt8SVtMQz2iOArvRCTfREF4b3HjB/CbwW
 99N0MZj+uvodYhrfMFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX8iK1QittEkMW
 vWXbmDhl9Ar2HQAs/Bow7swiE63dxZtBZFg6OS9YYmZJVrYaOUBMWi4KZ0paqmv28z139S1Gs9J
 aCJq1c8lFc2gbONQQmfqLw0Ka3akT7M=
X-Proofpoint-GUID: IhGQLUSPCDMcvcm1k21WT270NwOSsIj7
X-Proofpoint-ORIG-GUID: IhGQLUSPCDMcvcm1k21WT270NwOSsIj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180068

Add spi-max-post-config-frequency, a generic uint32 property for SPI
peripherals that support two distinct clock rates: a conservative rate
always reachable without controller configuration, and a higher rate
reachable only after controller-side configuration such as PHY tuning.

When both properties are present, spi-max-frequency gives the
conservative pre-configuration rate and spi-max-post-config-frequency
gives the higher post-configuration target.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..ece86f65930f 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,12 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum SPI clock frequency in Hz achievable post controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

