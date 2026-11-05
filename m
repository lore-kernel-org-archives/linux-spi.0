Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876382;
	b=bH0/q+G4JnhTh3mdFVXy36nbHxHHYpg2g6SRpDfG19cPs7NffV4AlsRgkpLR70Um6hnI
	 B9eNqVF0T4kaF0y7zTZJN2kseH5W0hLAFOV5Gw0Ui+K7qfkOhWg2kJCmhHZti5VDf0YPP
	 dGcmvmB6UTVAD/W+UeWG2JAITAmOpeEug0UoVqxK9YKOBpgBMfSzIX4Bdad/xPdMEMvkn
	 f5aVfcq4uKAG7LYH9H4IOEV0mwJdkAWYOM9MNtu+bK8vwtG+poPs315GFpwS5+ZksGkyQ
	 E6s5ZSvATkaPoQFGDjWcmSi0cbJ2rLleK+SaQM/pU3rea7ajF0M+vYYojPYVyf3oD7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876382;
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
	bh=VGzcO953zQlsRJFz6+vno4E4iQ4V4n8BNfZvHnLjV7M=;
	b=1FAx9A5PqoTw+W9qTvYmC6TkKLTKUCxrWsn1ryVrnPVfTOyJAbsn2mgFu+qcID9NwZ46
	 jNpIbpCnYosTEfzaXUZQzYUZ3KlESn5EzaZkTa6plbD/9yT60P0lZI8d6rJj+T6nSknqg
	 SaJS5790ACbpeUprcs/V1/8nroWhcYZqle0fb8UQuXG91E+IY39EatceEqpam7bTMxsJb
	 nxrv08JHi1Gp+2+IlRpTvKQPtNF9eKYn6ZcM6AH1Ug/LGbtH36kCucE1oC3T16HGJfkTE
	 RdFDeAkqG/+4Nmyl8Ajr5GEkDhWz1IpLMuOdHarH1bTefNpaGGeu/459u+z0n8et4uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ac7kE5q6;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PV83d9GQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12666606A326;
	Thu,  5 Nov 2026 10:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12666606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ac7kE5q6;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=PV83d9GQ
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wGZC2214932;
	Thu, 5 Nov 2026 04:59:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VGzcO953zQlsRJFz6+vno4E4iQ4V4n8BNfZvHnLjV
	7M=; b=Ac7kE5q6oIxZyAC+GXlRDDrw9TdFjOvauMPgMp8U+P4sBC58LCfqxrUZM
	ugbr34G6UOvwq6r2YCdBxtr7SJRD84+a6PE/tQpg9J9wKhhbhE+YfP/TyBXaAm3K
	w8pt55c+E90Zjg5a6RMCHxW2nJaBuwrD2/GFQUSP0GmR8DvxkCN4bLvCDDQ88bvg
	V+tRj+utbxtaTgczPuCfkXJt9xdMnqUbzS5ooSX+LKE3tq1QrmYectIfnIF/jZHv
	uRVe22JrZ3T9taXuyVjyXWU5gH8tvlgwPyw9ectCFD1fomKsIiVx10y9np+0u2Pv
	tWvU9lNWD3reEBKr2XrTbSnxPd2fA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k1vs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:18 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju2p/DcWu27kvJ2E5twrWWH+A72afskN53CIXMgnBlocP8E6bJg3zBQRyAbD4y+9Wx6TXb7C2qZvbJH848vMGeJWDucZ1axFVnbA5pmm5tzf5mS3Fxp8Jv8pWDkLObhWW/1caO0+qGFAHolnxCuOVLwIrrr5pvkuXW4n3gdoZgZWZa7O4k9WnTDQUn89yZzQFUILD2sJGINS2oDNK7B8pdQcl9tHy0uf2z38NZ1aiETwsQBMqZJiRpkh9K3fqb58N1oXv4Frvd0maURSrEfc0NWyrKGECHv5dsFgIPYU9JYGy4O2wjimzGPfLYA8/blgEbsqQ5YYzUKoWAoWpe4x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGzcO953zQlsRJFz6+vno4E4iQ4V4n8BNfZvHnLjV7M=;
 b=pydiB5+kFHpI5b61InfPORZOL+a5FOLpFoG3Amy9LdjhofaWNZw0CW1n6KiWc5HqBLSSFg1rthB6H70d0CjDdSfMrIhkpKlE9KNfYOj0z4eflnAoOM8qhQw5qzgrEvAn1rxmzsf3zJTbyK4NuSjb4OJJav4VpgphSTdIhLVFutwpxS1+o9Me/phPWIAtFvCR9MgQWJ3BaVfSB4ywROSJGMpor+HOiH77gZIxQuLX6N/A7e3BLgwmp0Xs/8mjYUsGh83u05yywIY9VOaJ1Fx5zfbWDvWLDYXwcsMYdGZ0fro/qLngrnTy/qVVaahpbSOWn9kqOHWmiTpbd8KPfCFPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGzcO953zQlsRJFz6+vno4E4iQ4V4n8BNfZvHnLjV7M=;
 b=PV83d9GQxLyn2ZuANLDZTv2Ajt32pI57hNkFYMUrCjdNwjMd5GrTf2+KRJ/6vY+TyU5nSWdkxBTW7xSlp5/OvhGfy0yMlKT4KEv2DGq/qsYul2sR4rTLBIVMlBh2QckoYiZAsEY0/59xz89ldG7f+EE/nxhonPZGRNUoH55QJfM=
Received: from BN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:408:ee::15)
 by IA6PR10MB997658.namprd10.prod.outlook.com (2603:10b6:208:5dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:59:16 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::31) by BN0PR04CA0010.outlook.office365.com
 (2603:10b6:408:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:16 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:11 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:11 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2C4171076;
	Thu, 5 Nov 2026 04:59:05 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 04/19] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Thu, 5 Nov 2026 16:28:17 +0530
Message-ID: <20261105105832.2134313-5-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|IA6PR10MB997658:EE_
X-MS-Office365-Filtering-Correlation-Id: 43303f4c-5521-4667-4faf-08df3b2bd588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|7416014|1800799024|82310400026|921020|5023799004|56012099006|261021121427099003|261022075727099003|261009223027099003|261102130727099003|261102123227099003|261026121527099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mnFSaapLMYm+D9/S/r+wVWW8PElBAMJ3H2aHh4seZEmSL39dYh41+cDF4kXIZLhc0icwyRwnSBZPawtDHH8sA85W01qUNOJAQPuVaOmNOjrqKFtEQqf2+yLsahcZIhCVt+9ddC2k4ZbkZFqBuQ/W3sFv88IgCu/HbfmEIr/lCEm+9Or/3NYmLsqhpJzNJUty17GcWkBezdeHmF3WwWO5/WuIY0UD+PGQ5KrG81Idyy8xjRnLzC0nVy8WmnOKMU71QRFgs56Vj35peoVfHuhXANUH3OtPah/K/K0TlucDAAf81Qolh3LFB7Ohj7GpCJlIxUJqEAEZBfLQNvF7WsueoUrcWcRL+JGbCHTyvu683PgkXUaLZchjirU0GPpQUmJ6T9ZCBAQwWrS76vdn557ULL1aN38LGZArh2Fy0wGjLLtOybYVw4RaMnXf3dPqpnH+1QuWDrz+AXw2dNXwXeCeqdOlOGiXITQTFWqgWnJLhWGx2jaIN3CkEttcK8elp+NqkbrmqMvd34Qjrd/0H5VteaMQaUDrG45eEXXO/xNzLP64ADqKot8KQmfwRHzJMIgvRHlLAvO4sw30qT1juyg4b48wT/0F17vLi4AFYXA+lHU+vWb0Q5tiBnRSWooAZWeKgas/b3p8snuNGdFLJknhPsFyTwvq5v0tqoBJz880f0OkntHdnkwcBFPls0Ej9eWJSwhemhDgEwWmllRJbHDVQ9LLPwwizalAgXsNgdSE76273vOExeDqIxRCft9CXXBg
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(7416014)(1800799024)(82310400026)(921020)(5023799004)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026121527099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pb1HVcRwod+NdcmNC3bNgZzQULR6qrauheOU1o2BDuX4G1903PQOAzS7lbLpLONaAZvMbLWEGtbk6JI39kzejL2tkwKk659K1onSROU230CkJHbcrAUOgYLsRqzkmArVscUyzaKCivTXCrkslWaf3/rynZ1KCHkrgsSp2iskF+RCrKG0i2NI6ymv3xlWlERqWAz6O2R9EewOxfRLkf/VUIA7I70cIgWl7DXNHnp15+UOpX55RdQRA1bY0kbKVPK/20XolSA7Sh9cLf1F6qOi+qhE5rHFLB/3L/sz2sxDeWygMEIGP8OJHreE0uDTMMaZuJncK9VkGWe5dW2tgLluMAVEvImq6B803lshJhT5K3yXomoQUSrBXmdFq3Ktf/RPXTymBdSoiv+0Xni7oWF5civZwZjnjc48C4PTqwCG85gmbpMuO0kdP0Rxv/ANuNTg
X-Exchange-RoutingPolicyChecked:
	HMwEcVG6m+1TfXaEXZxULGBrCr3CXlcQfLf1Cj5GOusp51BRQ6EptDdWVAEkoycA60If2RTHwEaM6krHrCMihYJLTzVbc1LIkYszutGSulNvkwmiTHiJ5YQ4YXJ2yXfbb5VXkRKggAgUdCyhkof4d3CcSvkERixFdd6OD7OwP7nUc0Bn8nWx1BPKWsR3uBIv5wfsXxOjlROErqCYE+k857MkUDHX0wsBFj8RD0RpP8xsdy6LfwWBgzD8OwH0OGB77E8sFs7nty4Hp/Dywi+XnH+ojIQMOLYvPkuH3EsS3un3MQBeGoA3noCl9VFU9OBqmBg3raXoGbBbxKyjbTCcWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:16.0771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43303f4c-5521-4667-4faf-08df3b2bd588
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997658
X-Proofpoint-ORIG-GUID: 6apXIsf-ygOEuedpuJXZOqFMuKcrVb8b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfXyC1Mu6RkGyBP
 wlE0ys2BtDUJHPv5CINnTh6hVf98V+OU2IPclkgg/xycP/jB1e/nqb/4wOyNFzWaoOXTEZYl4+/
 YQtsIQETUsc6fEYFOZp4VqdzBkCcPG8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX7l+7StTLPTNz
 tzq81Pups5o4PYQEUk8bHqQ1lCtdFR33xBCBkYn28smMHEV+1al54ktiyccsmRR17hJEkIMNPgu
 HyxTpvCE8jaxDIA85yzejlyLi8hgNkfqDRTqDNHz6ygDQxq8hQd3s9C+kXHjE/nbmUKUYinI9No
 +yqy3ei8QcAhpMjq8xbkv3ZBBsLOrlRN+SvaAzoFTHSyEoQ6PAKrwWeQLYWEUnQ5zt1kqhZNVAg
 ADeafNN/VIknePunwvd31N+gNGj0yKznCPqE3WR08dgBnb6NscCNSSjSu+QhhYzZmlVCKsp9k1q
 PQvkkJhFT1GQ6tK18dOtBWWPzXHQrVYWf5tPF8Zx/1tmYdfvd3eVwNvt8AdE5neoNVEU9YFvwyW
 ttGRRev5Tai17gDJpd6ou4CNpcejYTv6jOy0XjrIp8CQpe96OtHjwzbpO6o/IpQrF4nOE6ujACA
 5IZjNWOdXrzEF5m2ufA==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec6186 cx=c_pps
 a=EaWthEyNNaJ7GkMLLYePaw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=gHTh7DRQwxBKnKwRL7cA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 6apXIsf-ygOEuedpuJXZOqFMuKcrVb8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Extend spi_mem_adjust_op_freq() with a bypass for post-config ops:
when op->max_freq equals post_config_max_speed_hz (the value written by
execute_tuning on success), return immediately leaving op->max_freq
unchanged. All other ops are capped to max_speed_hz, the
always-reachable base rate. This places the policy at the single
existing frequency-adjustment point so exec_op(), supports_op(), and
calc_op_duration() all see consistent frequencies.

Also extend spi_mem_default_supports_op() to require per_op_freq
controller capability for post-config ops. A post-config op runs at a
different clock rate than the pre-config base; a controller that cannot
switch frequencies per-op cannot execute it correctly.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index b94680b60af9..7916387a4f1d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -206,7 +206,8 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		return false;
 
 	if (op->max_freq &&
-	    op->max_freq < mem->spi->max_speed_hz) {
+	    (op->max_freq < mem->spi->max_speed_hz ||
+	     op->max_freq == mem->spi->post_config_max_speed_hz)) {
 		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
 			return false;
 	}
@@ -627,9 +628,18 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
  * Some chips have per-op frequency limitations and must adapt the maximum
  * speed. This function allows SPI mem drivers to set @op->max_freq to the
  * maximum supported value.
+ *
+ * When @mem->spi->post_config_max_speed_hz is set, ops with @op->max_freq
+ * equal to that value are treated as post-configuration ops (e.g. PHY-tuned)
+ * and are allowed to run at the full post-config rate. All other ops are
+ * capped to @mem->spi->max_speed_hz, the always-reachable base rate.
  */
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 {
+	if (mem->spi->post_config_max_speed_hz &&
+	    op->max_freq == mem->spi->post_config_max_speed_hz)
+		return;
+
 	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
 		op->max_freq = mem->spi->max_speed_hz;
 }
-- 
2.34.1

