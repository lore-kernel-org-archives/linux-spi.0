Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876385;
	b=L8CXc49/ge4WUImZCamOVNxS8YaaDbpHuhv1TFHkB9jTQXv0HG4s89QMrTjyI2wr22pr
	 akMWMjedKbQWLqDx6QWrIFS4mPBAkSv3CWbt7ZfdfLlSwfBn5v/q4lEHO312LDinOGrCt
	 nNPNK6QhvhxEuoqBJ7pwY77lWSRqy0bHRJQbDCBckmvH072XTT/Sed7bwbhP5oepF6m2X
	 mroJsoRPd/DnjlDG5OM/9ktuTpfi28kzg3/3dGHN3AKEqriaVdisD3xm2zcO5YcEPMgOi
	 gcQJ8jr/0U5f2xhlPuIKZ9HrElsop1n0EOWJKxnGDBPEub2a1kMawsMdDL3R/Xrr4sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876385;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZgJJ7E1dXWk2ihmaSvjmbCVyiI7d3xmeVVnyoTqeoe0=;
	b=DcvL1fldXnJP4BNZzOd1e7lubFk2Hu6R3+B0nfZPZkxv2X7BC/jZD0Uto9W9BlCXKFG2
	 PX1z7dRN/QltrJL1HshwF4mT4yYTCOYEOa5+RMo0VRv3YmmV/O+B00dicHpTCi0bOfSnH
	 L3e8NQBKZdDV7gsORicqImtjfTrFQEHfNeRUFP5cSfK7slL4Xmk0dtlCbVB+2K94g7aND
	 ihkZwMqTboR2jtV60L3POZsa6jtc80guiFTFWvFtRH7Ciwmg0JgIXtvpTBgMxPuZih4QO
	 CI3N8nkorjWFur7wVVF+R6+lLV5L0yXoZB11u/Qw2dC/i0gWsv4znwX4PYFVX5ZvvHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZF+jag8H;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZhlmctKj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B63606A32D;
	Thu,  5 Nov 2026 10:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B63606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZF+jag8H;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ZhlmctKj
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59w8Hb102469;
	Thu, 5 Nov 2026 04:59:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ZgJJ7E1dXWk2ihmaSvjmbCVyiI7d3xmeVVnyoTqeo
	e0=; b=ZF+jag8HNOPEjxrQPVqZD/A4RS45EO0haxctehRD2RThmMELr+16mAFjf
	jEM/cNDu0GrvccSlOXE1scIc7010scQbZLWyhFrUcfyC8RBDtk0I3JcwU7U3c02R
	lAgEuSq7nmFsOfyDtdHOSajUy5p5rCPnOfREMuVlJjgCai5ezh1unyUhmhrsU8yE
	MDGhry+Eh4Ti5fHR2ixQ932dF2MWwwkgYYuuSx3BQd9Q9SnfayU9TL2MDHZQhFy+
	AmiE3RQfss3/jCrotVNqDHSRtYWRZ2lhLKH4t24klK4A9QtzIXaZFRq1I8Hmz25l
	pzEYDZsWpkFTfBUlys3EoIxub1QCg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrdte3uua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:20 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6VYxWfAB7W4rDDenn/yGiY2aVCb0JolT6dginOsZEssHSX2yh5HZRKsSzb7nbED+P6u9qADPlJVeMUNOcknnBAhc59bppS21IQBFXvmkNs49xne40YDvT6cjwHLRH1wdlA7WsIL+yFQmrijnFKgxMlf1tw1QT4j6VYuxNh6ta//nU8+vUnxr3fqatP7v4Jt2qfivQUubj8mgQ54ghHqSuxx4rucxZDoCPqfWiluoRVzjMMcBNkhmP7qpV8VkbCPm/Vk8tDx9zYWQnKg15sDEOPB6T0aU0YNxWeQ9QAFww/hLHuRndA0m3zZ+9H7GAawmR0nXrUV4CPJe8ZZl6bNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgJJ7E1dXWk2ihmaSvjmbCVyiI7d3xmeVVnyoTqeoe0=;
 b=F/y7bfpG0p+QnYHvrotpQ+On/BE0Ookq+mc9dZCoZEU4u3eAQWQqLKk1zuhoHXMULRx3lu6tyuArYxTY96G7Cpp62Msr1tBA4PSqeVKxHHyqa/1f+rtkfQRscKnpXvJPlKLyF7v/PBsI+e4f3/EcWALLIekEPKz0F7QYfzsrrCVYNCVd9j6S7SnKJLA3pFMWKFO33w+5LwltZs5OoAC/cDRR0ymDanIaDf/4/0xI8+McdOjTJDyYmGxTFF+Jbi34vnkeUs5yWG1CYwlArpkL0va9czRuMIha5/jwSyVJN85+713Tdy1+1ojV1CgfE2WWWbePnR05Mg3GHaNNEFXzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgJJ7E1dXWk2ihmaSvjmbCVyiI7d3xmeVVnyoTqeoe0=;
 b=ZhlmctKjYzV7b6oAzxf6nz1CO8NDRNsnEXlBdbKRT5TE8knrcc7Ywr8QtvbYNQGfh6OW0iEYnagcAhy9oWlqXqA9c5dFBhhkrxHiKEDG/FlTyCdk3stdVXDejXsJ1dYiLrUdZAbOMewy26Mam0qJhMtFvcohZ/Kt5RrPh+Joy3w=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by DM6PR10MB4121.namprd10.prod.outlook.com (2603:10b6:5:21d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:59:16 +0000
Received: from BL2PEPF000352CA.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::54) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL2PEPF000352CA.mail.protection.outlook.com (10.167.249.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:15 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:54 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:58:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:58:54 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg294171076;
	Thu, 5 Nov 2026 04:58:48 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v11 01/19] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Thu, 5 Nov 2026 16:28:14 +0530
Message-ID: <20261105105832.2134313-2-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CA:EE_|DM6PR10MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7985e454-3109-435d-3b2c-08df3b2bd4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|921020|56012099006|261022075727099003|261102123227099003|261021121427099003|261009223027099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	E28ircQvfZ8/uVF0Ey2EVqYh0i9prYPS2rhpLFqo0PSxFEkDL4MwUKmt7s5l/Lwd6H0xtuc0LVdu5koeBi8QmVRwOL7eJNNRMxa9vLp39+yiltBLIHVGPqcugsYOCjLRzYlq7wfH5rSUzSQUVwbZjKgPAdIdRMHCWZVMpAzSVB/lzB9rJCTnj/54bb95vRo+NNsICdfyPZQ30OhbSiOMzZsKENDBv27k+p+NzL/UdtpcHA3ZZ1jPQf5htR6fuZoYjNij+oOuTeAun045ZCn+zxwfmMjNltBihdMFihyPKntlR2LZgAhP1AprlndOo3JLDnwEOzeNRPOFJyee/re0ThUQEQb3wc7VK4OC4S+QdyPmrCnSeQynQ/TvQDCgOQBpjmaScDZUmX61OL8FJ5IwNVHSCnLRSBgOmH+m87Y/WgKsNFueEPpCBD1BzYVZFAorVyLKEqvgP91+BGuIpHTHdcSoyE44qLXceXfvZ7uAsuomAToGWnBNo5imGmnEAcelZi13Y5fKHvq61M2AvB920PX8QSC2hj5o9P0gzAzOuAe5fWSde6wobZP6uH7Fh0iVXrtcVACmZezVfUuglXgkP7VXpYaOxLmiwi7CzAac2yN7KZyuVHwnlN8c4JicD7zIau9mNjpVhovI+U06iwmbC4bBJmQoYHwtNW1kTRXVlKiBkNhNdmIfayv0h5pcGHCPNZujNmE9A9tGRFs+sKmJdwynd1kILx8xOEs8ajJgINKNHAjnS5klfppPZl1cMTpq
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(261022075727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zuHgly9Q2IV75Xiqa7ugJEr4gcuoAqdnhQUquuXZ0e1Gjrl8rrJsZsSv+OqIoNhgczm7pPAiTBYEdWzyYOSH7Cr3tmURRQ5LyzYTSSC42E7FHKsZEU8PeSBx6dRWlh5lef9m9nTy3mLRpNLIwd2QAArxtQISIHf/UXHddD7utFSbiPSkNKUSabIkUJVYudeV3tBZBPFRpxiFf4AAPYRIJE6AEX0MB5fm8ibqHYVxx3qlvqT/HdmYFbmBHbXXWkRPqwx7Yg/IIvzWv6ao7NkDxw9CBBRIfjX0WwRpR99VtVje1LNcrItIRT+s5mkV1mUMecQlnycRnqFM2VN/Ng0xvWQ4vOIzjnUJQnOCUWHwiV9E9Ck7N9103bNEjfXo2gxCeLznbbMAYeuxnIgcry10uHTOYQ2mdwbr4/tQsudWIUv1UxbjWyi3lV8wYbtrvula
X-Exchange-RoutingPolicyChecked:
	UeEiyN1zY3oUFlpRvjSTASP0jgqKvx9Q6x8/uSoW0YO74LUpKSHw7w+GMFuwQBx/r9xI7R9OAfa5x5GbfZugbPrDL27ncamBAAY0t5L0WkV1o+6qcVjVwgJlUkvQxsFyq/+DPmdPdyGbuXBU7NrGbyCQFweFYhfAHkDyHn8kUK0Eg859SpSs2N+uHHvx4gdi3KWpswpqcB4YhAb7KjaLHBI56BU8iDmfiF2pqR1UWaCwhcLbCI/if2HbOCj/DrAgqrdCHiMv5uXhermKvaUSD3Tg61fqLOsqWLS53SfStj791w4O+Ff4LkaOwd6c7y03UsnGJ7SwZnke4yBov5wi2g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:15.1529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7985e454-3109-435d-3b2c-08df3b2bd4fb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX8sRUcxUmWDzj
 LTEqJqb4KVJw57cemY/YpqXE+tOVFemvcO9Bx1+hhdoAbkR9xcO8hLoLqe3C8h3csEzP2YFT0FB
 pzaUe+HrrcqHyIxeOgnsQ2gUi+mX3jbnISqbRcY6GmNoywXluH13oWBN3LwwgIgqrouloUZ9P7B
 Y9iqhbDbq3N/LzsSLOCb2fi2vApsaJn8x0FqOO6X1PAJzholurzBjHoMYUGvqfxb6YXFCsrgUek
 rUPGRmlG17gTvehMu4eEN93ive3/oZZ9rkUNgqEn9Y9meSXBgSZr6VMixdGbo9eHFXiqQrbNvsF
 l3tcOZRmMMoAhUlZ5BI06lcEipjIN3j5hDL6MnH13KjG+iw/mUXbi3a1ahI3KS7akBsexDiII91
 z3UODoYqikiYOzZBWu2iWFJvAXaFE9wMbjRA8Md9cp03+kvlnjCxgQ6MzYMrnRBUKhNaIXlpgRC
 Lx6Qbv4XHgPiYoGaqSQ==
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6aec6188 cx=c_pps
 a=S+V0rrE8P+iIDgN9m6arSg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=XYAwZIGsAAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX/YfjOBpfOAuz
 AqVXiCVi/RYAk1ynZURTHn7K6uEivWhr0+Vos+7uieKam4De8/xZLE9PNwKPkCxfMrSmzkZa6Jb
 TG0sP6gwKF+joQ07iKkpdpPyY0jV77k=
X-Proofpoint-GUID: Fl8pUoXD-F--13hhD3CpdSDoY9hdK0M-
X-Proofpoint-ORIG-GUID: Fl8pUoXD-F--13hhD3CpdSDoY9hdK0M-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Add spi-max-post-config-frequency-hz, a generic property for SPI
peripherals that operate at two distinct clock rates: a conservative
rate always reachable without controller configuration, and a higher
rate achievable only after controller-side configuration.

When both properties are present, spi-max-frequency gives the
conservative pre-configuration rate and spi-max-post-config-frequency-hz
gives the higher post-configuration target.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8f4b4b202e1d..ec91d5bed96a 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,12 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency-hz:
+    maxItems: 1
+    description:
+      Maximum SPI clock frequency in Hz achievable after controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

