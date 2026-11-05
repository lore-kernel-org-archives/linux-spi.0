Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876402;
	b=viB+6wlBmuI6RU8gRwQZthc3QWkQ7AQsKB9EpCweNJ4KFD1OOtc8Ay982XM3cGfPkXQ2
	 jZR1tfgjDsCSnZdeKWhelwP1KbgysjCZbzoeBvUESM5gk9umNpmo+5sa8iK91GLLXTUDj
	 9sIlvl8wkD2H1iYl1kIpqKa1LCCJ+wj45M5AwdeWiQ6BxGzCI8YiPlfBKKQevcvP4wDmT
	 IYxFKEAFBuJdTTeqekNypEP2SKa+0k7FpBVUdBqoJOHmwc5sqX0KMOVR8PYBsknq6PpAK
	 0v+UrrujQOy+ZOc9JaggO3gI18vfmWJV7HZUE9SOkmKlFIo9evzu0pCvwgTjwATn73Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876402;
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
	bh=bb6C9kOC64s2IRPO5y14e5m/AhIFjhvkAOiqGxWwgRE=;
	b=duFqQG7ZZJsD0PEEwzK00fiYpXB4NECG0/k8JoniKdG06RBIqzRbPi/mlgDv5mtmbLe9
	 rhvAV0tGFbMA+b2+nkiFCsLpdWbxHbh+nvwlUo+LB08OBXKeQzfcJ9TbWGTnj8n8gS9Oy
	 uYgnsAo4MFc1bTZIox4w8mxUtZa79M/ZoJp6ZZ/rkXP+bg3AE3fYoyAH9U2x/V2uKG8M6
	 JY4JVvGaN3QAyUNicEaqBh1jccCzcQjYWEEIIVNJ1MUnf/WJ9WGMdkxTNpXDafbN/pCbC
	 2cGuSaDW18oCumqbvV/asgbQWfpAUQ4/fN9l8VIC8uWmrptshAW4xDAxIZf/IjGofAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cTobI68O;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Qugy3fU4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D86606A326;
	Thu,  5 Nov 2026 11:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cTobI68O;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Qugy3fU4
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59w77I102227;
	Thu, 5 Nov 2026 04:59:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=bb6C9kOC64s2IRPO5y14e5m/AhIFjhvkAOiqGxWwg
	RE=; b=cTobI68Oa/T0eSk+gV+dhzZ4XmUNfXwahgwVM833zgm3k9niV3o7r9fGk
	JJEX2FdOCQb14Cu+q7JbXvRPj4jGWfG9UpMZvZzjt2RYACGnxHBH69qjgQRLmE0s
	C9unVGWIW1A0suOPuzhQ1QhTzAo4dL7vkkkePoYBIXQaEzTPnF4CgoNumuoSxBv6
	ebTRmFwUgYRIH/QCsLxMGGLHgcuPRAIw7ct824mj2R5mh9GqV4xyURiI4CiCqNE4
	wtpAwR5+SQJIIuOFbNyZJ01kKL20AKVaehdbClLp+AdMBFQPNh6UfxvOsxZtzLvn
	CelkB4qqq0oSaDN5YqyGnlbb+nRVg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrdte3uw3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:42 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idshylemRuektnJAJZoYlBgtfocpAG79M8QNZPGObIUPQeIV+Dk0RdAzJ/oHA3deo63hsHN+vGoi3y2SR93sMhep7s3xSW4jKfIiYD/Lk7L7IMzYD2Ex6wRxHSUbrwTseyYtK+aCcxlLkWzNrpURs+akWs36aFYSCsZzWCRkDWtS2q4uAviQdEv3QQA8Zx7z/MgiOCVHqcXTRGKsYfhoC/krCMAnEBAfem2DDokZgL3V2YHnk8q1o5tF1NjGPNTleFy5nBC1qplQ4oQ4BxXCSHrGIdtpJ2NpUgbsMx19TasCmk8oTKsGJ0o7PbhhGWs+D09Nopqqjc5c324ynMlFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb6C9kOC64s2IRPO5y14e5m/AhIFjhvkAOiqGxWwgRE=;
 b=hwtt8Fy0KGvyEGXh88xOjBSKGvyKnnRODnyNMDW4A+EG+DqsIishpGfAoDXoRt4cUgB+W/58N1NFrOkwpeLBV+QJhXizlAsoy+nhYGzdhGsmVwYfdofO4NydQ6Vlg9gInyKeIrSRuq6dL8A3tmIdTxP3NYFYjLKsE6cH/Dk23tPR7VeC7ywFg3KZqoJa2+hZ0r8KwmfJvVj97N8jfiAUKUydiNEmJ0EBGnmETGPrMzBE9Jcg7HuFN4FH8ExhovP4tup1s0p1JWjioyFSWuLG22bwm7+mDCxdbA0V9ELwZTLqodiO1iF+Ar5QPSIfY6rw9tEkx2Rj0/VXkx+szQMbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb6C9kOC64s2IRPO5y14e5m/AhIFjhvkAOiqGxWwgRE=;
 b=Qugy3fU4zf7uirnjqju9emzvQW3jp6P3g+s9cd/DpOEoFTztKXygogSPkI4q6AffX841rXiihY2x0+bM5QRHVF7XyC9HrJUIrBvXWD54K2+6rJ1JB0KU3j0R+X68rvtQ+CxBW00PBz61nakt8iUj8jtn53S1R0ephgSqA5pv1RU=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by IA3PR10MB8372.namprd10.prod.outlook.com (2603:10b6:208:575::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 10:59:40 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:1f0:cafe::86) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 10:59:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 10:59:40 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:39 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:39 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:39 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2H4171076;
	Thu, 5 Nov 2026 04:59:34 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 09/19] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
Date: Thu, 5 Nov 2026 16:28:22 +0530
Message-ID: <20261105105832.2134313-10-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|IA3PR10MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 19aeb313-e2fa-431c-2a83-08df3b2be403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|13003099007|921020|56012099006|261021121427099003|261022075727099003|261009223027099003|261009221227099003|261021123027099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	D/DNVeHNPPl9GDEHA7gMhDsFMmelIzrvDscOOA58QHQpr8gWSCgXREf94Yxyq9Bg4f83TUN5Qw0ugXD/UtMjKL+wwtVT5jdoAEMJ60/wz3CQ9Qr12ZFci5qLFFhpwbx7wdqqdO9oHWqqGb66UUGu6GV5n942SGrbsmn3SOB11kAxT9dpdw0jz/LLmtgqeR6fNDFu3FKpwoPS6NqgQ6uw1Jdq02KvqPt3eBzqD5F4097erznrtCl67BCkrXRdC+NkRj5mtUzHXlJ+vgdwVx5poKihRUoSWHji8vDt/lxGTRm6yFoYUDy+d6ZFBJ91MB6KOm8VByzSi29jmyD+zMS3SUcT3FJhli+yPb8ijtnp9qS2aNPVtHHAnDqy8VWzPqIC2ZsUogQkSuZhoL7ndb33T4spUdfro8gPSJP2wMoMa+GSObUsOz5W3QDMcwxfKY9dDzL5U3PFrj99peFBh65TK18h694VytwWUuxJS+CERDPhPHPlqMEtCOlQrgalIxD9/SVXprdkZEo53rYFRxe7VcqUeKZJUB8h/2X906V5aR4wcAaJexrxMX3zl0NhimE2QxYw3iJs2Ll+W5YyH6TyXB0IEs5K04ZERIa8eZrxxWuCQEyXgpx/cyZQffjbTk1xsrmLjMtJRs2OxrSnArxmTvbzZwr5lNkHSIozT1XcFRrTtFiuSoiP2TZUa/IVxXrk1EFBtSR+pbrxN7F8elTFZw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(13003099007)(921020)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261009221227099003)(261021123027099003)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vg/hIiTGjkG/qivfTnQuj5TsRB5rgtGOTbWXm6/hnvwNTJQBPZ1eEvYJSXHS/b6QnBy6CazDG+9nbVibeBZBlmkcXfqst7H4jGRzSWRn3ktPmKTrwcAisq7lMZstnTJRDxCPZEU/TIumdkt1hYJM+2sBkJUVV7FmdJsvrCPUX6ZS+RNpkHkVuTB1ngMKok8H9yIW+DbtqGFNqJrGHjLVzCUD8tSU74oNTaQSK7LFj66mlgwcLx/lhdB4H6tc3h1xmiDETClJ2qLeCzPihd23HaqJ/YsWOpxa4uD4lHFgXva5z7+Wflx7e+5uzB9lNLNL1VUwU70kwW5dQDg2cJq7jt4V29mQbTl8wmsplADncCm6qD7ClvZaZqzuW8njuwuXQHWbeeh4EPyp/Mt16mbMeoRazyfJ1blZwY4s8/gY8GgXabY7VUZFcNzuDcwiH+uU
X-Exchange-RoutingPolicyChecked:
	3gogm6E7BAd1d6z+ELPQW0hG539QlMm1aTSqVBwh0soeoJOj0t6Dd3vaehdj3S58EOkOfZ2RRwxx5Inrb5EONincYlzmOWogeqNroUponBWJsi10O803SxxSLfxrICOeAIiA2N83ne7iIka1IrNbIzJoEZlgmysccTqrZNQpCKcDseazE0Doxu3UbzJrEh8M11xYX0/qViYhtrmjnjFkkvwYYbJSnOVBlS4LniWSObqd75g0GhtcvxqAaUOhb89MAE2Pvy+7Mnzllqared1AKbXxXpp6uU6hkUVRdsq3pTRsP6jz0MDa/jlu8F5V53hwOnDrkr/Wz/IkC1ROPm+HZw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:40.4010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19aeb313-e2fa-431c-2a83-08df3b2be403
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8372
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX+ldRwtEDn7HL
 GN3IImXkdUEGzGopj2H2NE7SLvklEIhT9988dv+rYoSGSNNeG0BC82CHUwU5O0HQ6JBittA5QCB
 0bzrgNmEZdZH71dqwes1xJ7g5uJUkSFN0+rrwD9ztqEkO8y0OWH2VCpzfjyGdHzAbJTo87SJHIb
 UaXKMDm3ek8kAZxXB5e72EKkFxtszo4VqIccFXLxznxJwozSc1EEUfmVxuXrB/FpMM8ZJd7DWHh
 0MVv8hHM+XKRe/1NuNiTjYJK0Z8ipPQ6lRUUutAAH6bMTHl9CHvvo9Edj9I0YBL8DBYpQ33Fs9A
 dIKyolFYuZrvSZNt7i+YlvuKv6qiI/TxSDVmV8S9kLRsc+3VbkrAxQBZlFNA+K0WDlOMuxmNtAB
 q6fNUitWS7IQKI+SIk7MFyseqljlsIT6xrh7tTc+8/SMPLJxEAPV31AwJhy8nNbdCGknKgP+V8l
 CooPN70d2LXskmrsTQA==
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6aec619f cx=c_pps
 a=r1suf/lb2duQPz5POPReZg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=zd2uoN0lAAAA:8
 a=OJyzgt-6OD-cy7zLIBEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX6FOLIXqrSkxJ
 5ZipOyLC7H8lLoxo5uNtG27GnmwCL1Y/5bIOQ4G9af4O/lMQ0ZrmMH5465FsbqlSVO4eDDqS1kz
 Drp+5/Hf2y3fmrm6ze40eqhsa1pbPnw=
X-Proofpoint-GUID: YJvfJ816r-cEabDKpHQvkwc1iSGqxtRh
X-Proofpoint-ORIG-GUID: YJvfJ816r-cEabDKpHQvkwc1iSGqxtRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Erratum i2383 on AM654 locks the address phase in PHY DDR mode when a
2-byte column address is used. DDR PHY tuning must not be attempted for
such operations; non-PHY DDR usage is unaffected. [0]

Add CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk and check it in
cqspi_am654_ospi_execute_tuning(). When the erratum applies, return 0
with read_op->max_freq cleared -- the op-skip signal that tells the
caller to try another op variant.

[0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 46 ++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b0f01621b323..7993029207e9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -37,19 +37,20 @@
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
 /* Quirks */
-#define CQSPI_NEEDS_WR_DELAY		BIT(0)
-#define CQSPI_DISABLE_DAC_MODE		BIT(1)
-#define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
-#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
-#define CQSPI_SLOW_SRAM			BIT(4)
-#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
-#define CQSPI_RD_NO_IRQ			BIT(6)
-#define CQSPI_DMA_SET_MASK		BIT(7)
-#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
-#define CQSPI_DISABLE_STIG_MODE		BIT(9)
-#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
-#define CQSPI_NO_INDIRECT_MODE		BIT(11)
-#define CQSPI_HAS_WR_PROTECT		BIT(12)
+#define CQSPI_NEEDS_WR_DELAY			BIT(0)
+#define CQSPI_DISABLE_DAC_MODE			BIT(1)
+#define CQSPI_SUPPORT_EXTERNAL_DMA		BIT(2)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION		BIT(3)
+#define CQSPI_SLOW_SRAM				BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR		BIT(5)
+#define CQSPI_RD_NO_IRQ				BIT(6)
+#define CQSPI_DMA_SET_MASK			BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET		BIT(8)
+#define CQSPI_DISABLE_STIG_MODE			BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM		BIT(10)
+#define CQSPI_NO_INDIRECT_MODE			BIT(11)
+#define CQSPI_HAS_WR_PROTECT			BIT(12)
+#define CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR	BIT(13)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -3178,6 +3179,8 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		spi_controller_get_devdata(mem->spi->controller);
 	struct cqspi_flash_pdata *f_pdata;
 	struct device *dev = &cqspi->pdev->dev;
+	bool op_is_dtr = read_op->cmd.dtr || read_op->addr.dtr ||
+			 read_op->dummy.dtr || read_op->data.dtr;
 	int ret = 0;
 
 	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
@@ -3193,6 +3196,18 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * Erratum i2383: in PHY DDR mode, a 2-byte column address locks up
+	 * the address phase. Skip DDR PHY tuning for such operations.
+	 */
+	if ((cqspi->ddata->quirks & CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR) &&
+	    read_op->addr.nbytes == 2 && op_is_dtr) {
+		dev_dbg(dev,
+			"i2383: skipping DDR PHY tuning (2-byte address)\n");
+		read_op->max_freq = 0;
+		return 0;
+	}
+
 	if (write_op) {
 		/*
 		 * For NAND: write the calibration pattern to the page cache.
@@ -3235,8 +3250,7 @@ static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
 
 	f_pdata->phy_read_op.max_freq = mem->spi->post_config_max_speed_hz;
 
-	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
-	    read_op->data.dtr) {
+	if (op_is_dtr) {
 		f_pdata->use_dqs = true;
 		cqspi_phy_pre_config(cqspi, f_pdata, false);
 		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
@@ -3842,7 +3856,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
-	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR,
 	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
-- 
2.34.1

