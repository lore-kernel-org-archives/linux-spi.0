Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876417;
	b=VN3lrPwnqZUZdPKXKf0UcloH1ouneNCS8dECbuqxTSLJVMp5qPdJsNvXWuTjXYnMLs7w
	 jdSa9VZFZJJP1uGus8wypgzayajbNPe0vmk4gRZKHVqKaOxNEvonDKVXFtbMswwJOy9qM
	 Xda8YYNm68V22JeZasWZnmgYzcC12L/OHhGijjvNasaSyq9qb//1M7fu6I6POIO/Te6Dt
	 RoVaPgDoSQBcCWkaKSC+vpa1e8utyTlf1p/1a6Dj2KU44cYOaJ/MdGoRNxp+DI0o1GEQO
	 jN+aUioEq+EBRD0Z3axYe21IEfbGrRYoJiVWVOubJia2+BtYtW3QkZhooK+kDeW8ujQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876417;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qfiP1q5H2kE241x7tDhdD0uAyWFhD178KrAkLLbte5g=;
	b=CJH572AoCgPbgTUWP3l70/vYFuiDopzjEcT/p/GAi8UX/QrYmMhyTsxZDh1S+142Dnwe
	 orPJh1dCDpeYrrOT4WtbWcD68lDFw67typbHOqfauBkmKsNmpzEljkDotKK6XZlU28xbo
	 v0hXgWMAu46XWhOjQIEvDsJ8YVlzepFpy9NeV+R5AxB21ax732ffFehM5qGZK9dyLriBv
	 BxGIOueyDhM8rd01yx/3PWl8coICFbzL7hMrlGjrrEJ959hXL020LMGUiwSbvf2SjZczO
	 vdNoVv6TNTC2jEy8IcjXi7Fe/+g/5GmsaZ4rtEVtO2Yn1Ldw9E8YL7GVrAHLJTe/E6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Xw5lOA1r;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=K2xRdD7m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D36606D81F;
	Thu,  5 Nov 2026 11:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09D36606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Xw5lOA1r;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=K2xRdD7m
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wGFQ2214877;
	Thu, 5 Nov 2026 04:59:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=qfiP1q5H2kE241x7tDhdD0uAyWFhD178KrAkLLbte
	5g=; b=Xw5lOA1rjosv23RXg4h+6prq4QcDPJ2r+lL78g7LtX9vUeLd9/WBKgy9B
	GA2xJFV2khBd/+kcOaZE3wzl6C0zJvpmZoJN1MPo6gBFCMG0Fjj797lb6erwU7GP
	FIwLlSITtsJtkkMyGdkD5FDSjBdAC5nRBV97bGl6WqrGrv7Tl9DO4sd7mD92Yg91
	0jGddScikgObSty+rK0cObzljAydCaq2j1wZEAX6cJO1jfqcAhn+sMTH+robEyRF
	NiuaPqw/F2nDyPz/0oDew1VXGjfEXHRkDkrdDWHaROahpgpsfytxygs59pUtOAW9
	luxaBTu8mStyz87YWnxG910Yw3KLA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k1xc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:53 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSmM58c4neDKsAaX+wYcoGppBL2VSyeXOc/7CPm2MuNatvXS02xzVf0xQuU3Z6cESnmUU3BZCAZnF6VVoBFsP/FoawD/Rjn8Bac1sIsmzLCRyUJ/t0/2mfQztUrd2taRrPMdr/0O/ripNAcWioqJVjn+OHzj5T75yvcn1eKOXZG/iBimrTOcOixGn6GYA+Gzd/xa+kweAGqpuQX1sCxr3DhoPbym1At+0WFtGnkvFCPafQOzA5L07twbwbwQMby+cD5COADjBp1wluHnNcYkTDJdVGJkzBx+ZmvE3YfmgQgHePSqYn5EcPdoFIV1Ftr5MCm70mI66u7kb/Bre7Hp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfiP1q5H2kE241x7tDhdD0uAyWFhD178KrAkLLbte5g=;
 b=mSFK5cIOUrF1jGAptYxBpRiI00pjGzYauut51LrpagjRWnC2RD+JJbB/vKi7oYnWLRqZUvieyNlUkt0OIFdkmpE0VVF76MFCTFHAOKFRzRelyTpZK2Gd5AUPkB/UBnV0v5CgcowHa3e0BSqZ8+NUDOemN0qt8hOB1SuilSV4v/M22ivM2+pNPmeb9K+/qKR1a7YNb3WCctKKDW3oKiGwi7eDikDRazm3Cd8YgjYpSnJ4Bqbi/ev0QbDBk05oN63AGAhxPByKwPKXclxEuFfNvhgMRJKoVnlJ0dOMaEBl7wGLKcer/xtPUG0dJtH+e0cSwAYqWXMZmkexYjrUsfzQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfiP1q5H2kE241x7tDhdD0uAyWFhD178KrAkLLbte5g=;
 b=K2xRdD7m/PO70srgitf8fGnA1CwYS5XaXBMg4IqjrwWXAvrVrIKY6Yo25RszKWRMzgzBgw2q4VJOfAAPJkeiebcYGgCWccpOC5yWQohMOZvr0YFV4jjwEzOmFCEmaS+rIHAGf6PFLR/7dM5UFHfhQ6acpqpt5gTuG0DM/RD4ML8=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by BN0PR10MB4869.namprd10.prod.outlook.com (2603:10b6:408:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Thu, 5 Nov
 2026 10:59:51 +0000
Received: from BL2PEPF000352D1.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::8) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL2PEPF000352D1.mail.protection.outlook.com (10.167.249.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:50 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:27 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:27 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2F4171076;
	Thu, 5 Nov 2026 04:59:22 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 07/19] spi: cadence-quadspi: add DQS support to read data capture
Date: Thu, 5 Nov 2026 16:28:20 +0530
Message-ID: <20261105105832.2134313-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105105832.2134313-1-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D1:EE_|BN0PR10MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c95ed3-6893-4acf-268c-08df3b2be9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|82310400026|36860700016|921020|261102123227099003|261021121427099003|56012099006|261009223027099003|261009221227099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4HepIkTZYEQZhvGjvkwgmQ4Tbuoi0Betadb/AgWKf4exBl+L7DL0Z+xC+Lt6jgts8dvv6LuZrhVLPF4dXhZURLndHqn4KZJ403CN9U4lx7iEI4PD4U4fb6XhDRWP7nlmnIOEdxaso2vU5a0quNVoYyt958TrV9ZlMAYe/ypnE71Mg+xFvGJE1iTY1EevwDqgklVxlOHZuo1ChDgBaUmTy2w0GrxGD42nU8lgDd+RitBLbtKmpCGf+XEm7tnhJLrUNDRqwSvcoMtLwK5E5rQTIQjOfbbnD3XZdCsOt8IVcfpru0IfbK8mdC9te3m37SGMzqLhEbsnSSmXLjXNcrzc06skTTiETn8m6mWcSIPEAa9OagITVYqGEuvKfQbvfCw3ZQ27FruQYviaioQZqWYK4l06xywP9rAnamfj98eMTRkHYmsLcKxUX02ms7JglUBUp6+HoDkk4Ti703sotlM541Pxv0HMSxWaE2pNVVcL5qEIlk9GRw5xgCDJ4jm8pr8yp2fClsu52O22UsjyHqtSpYnPbDftRT4h9H9pnu5JdO1iovFxTna2+CTrHe7kfPtlpLNJd0gvkPeuAj3Q+qehxyix6pq+0V1VnGZ7B/MSb56ROIDPjL7WP80sus1GlzR7QQkKKwZ+VHzQKJx0ggLugRJl2cMmsUin/qJxOL/7MbrecOnasW8FdWkc1s83tmrag0dtqMr4FS9zkP/j9qjE8LYiZs3Ikygx/64nMElfVamYmEw3fc1RsK+bARw2CQzR
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(82310400026)(36860700016)(921020)(261102123227099003)(261021121427099003)(56012099006)(261009223027099003)(261009221227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GsEYZdvnEvGE1bSP4mFeylhQU022KLSiuBXyL5ULs4S3Ip0QZFUcxNy5ZCfj8+nGA3FH+YsLGzGxecNnOUKq+/siMSJuXT/jEvQvpt3eVA+U8422OwEmZznK4We5xMEEr1w0mwIyrlGGYQ0VxgEL3s843lM+f2WWvY7KAzR02NKWZqkwaAl4XiW1l80pxms+E2hsp44qBj88C5B5gXdBNQ3lnsBVaA5S10UzqCoM3nFnEBtcPrh55qpHqgbJPD8oZ9NDkG/rWS235kZZEq+3OLYCaYUtLEISaUBULhmm6aWmUd6gU1p7yQYViVKapyHPMe+/R8Zz2ivA4ylVq9//2dZywo5E9113386YeqRSx8K5lAsUmh7qJ0sNe7GkQUepLNQUevq5vLPB9Lzcl8aNf3cg3AenuXJZkxX/VkJGypGPRJVmQB/YZyl6wKjfB6M3
X-Exchange-RoutingPolicyChecked:
	p7shYsgzAFvNfmynsaMXbB10DBS5enwhSj3Gj6LdpLJdk16JyFYJjBGl3AK4L93nAUWiVkAynWkda63K7tBEVnA3WRTpW708UPGXfh91ELjX9VpKkSeyv+QVSz/VFTe74Av6Ffp+9DuS/o63TtASsl/xCEbyTQOXDfrl7c0aRcLc7MWykXLcgNVBZqpwPXQiZdq78OEo1YYqW7pu8LjnqFjGiztL4pFakTcKiDPC0Jv+1XlMsMT0PfuiKgy7fKRMausOVsZzdcRHSe7/hcIDdYtJKzT3hXqrnN3qrGDQZ4mBIi6+tsGxHhetAkvaS2o6C0ivZGfjSAUx1TJnTHuQsg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:50.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c95ed3-6893-4acf-268c-08df3b2be9de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4869
X-Proofpoint-ORIG-GUID: lzpBAojO62TTKWeGgj2rUU73VtSZTWFn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXwDljZ/md4lOq
 agb0uSOcJlM9SWMWavlp6LzE9E+OInteSN2EzEg8M3UYe/3aXqig6aD01DdZwB8k3+GczdpqcqA
 8F582hnLs7znGkzz8ID5TbCgJFouqlg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX7GcBYG+kG1Vi
 DTRV1Yai2t5hXtb93mGaPKZovWdoOAHSzBYIAoK96DRrbhGATjZQfuslwkJFMXuORo+59d9tTIf
 fz4Z3cXQgUvWS9alCKVOmiDV/Bt1U73OB8iE7KTvQb/fjk125SRSVKxboyISbpF2SMZa2SrbUaM
 dUBhopZGulcqtOQIyJnfx5jwkiqK/jPbjJsDVlTT1AQ5eOwUELWAxVrvv6j9kKsOuykNSVGYFov
 VfFWeGySJkV5al0Yg6Wvpa69w/cjB0hrQZw3rqbhVW30UyeA4qLCj/VTe+mScs8Ze6n3qk7rNGb
 R9qNP0Yk9nbnn39xya18YttrHliVjLKhn1Uyng0MUzAVdv9+TKXDpIND/VqqNUurlo5hxqJgqI2
 OTt+bHcou4EkczGo39Dh5OUVUe5nFOYnR3DfGUXXy6NxL5qPftfwmzMsun7k1gjoeb9G69z3KM9
 5smoblmqCGXNou9t1Gw==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec61a9 cx=c_pps
 a=cXHsTeABgwIgPhuKzetQTw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8 a=k5ekXGWVmKCJ3UHAY3cA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: lzpBAojO62TTKWeGgj2rUU73VtSZTWFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index c2c6105798e1..4be37081d066 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -458,7 +459,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -476,6 +477,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1316,7 +1322,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

