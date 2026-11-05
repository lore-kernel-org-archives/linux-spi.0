Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876491;
	b=TXtWhM08orF0CGj4ZtU/Dl3MskUiKLxX6NI1PADGcwHrxxePk9XqHN6x9/Ql7EtRLZJN
	 eR1NMlLz0I1lfquAqLfC6nFlSlFZaoan/ufqSxgVvrFT93yeBcxsKLuKuYTgwzM0vWR7a
	 FyZ03nmGjTDH7OLIPoYUxks361iZkAnZs2J+hBztVmhNMRulFQGXYbSEIkNFB8IbXjIbD
	 TrJ7S9PmOwQ2ATq4oJFKydHaGm5u0XQWh6Hdjz2owdFxtiCrxodgVP/o53EhEoOx/Z+GX
	 OtORmjr0SStDUYsBTClp+L56QXS1zny+ZEGxabphwaryKOHgsDwcxU6TIfJYh2ScO/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876491;
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
	bh=0IopOqW10dlZZdSRpOXr/bCmuAOHvNZxEF2UWIPj7ic=;
	b=BT3CCcM0b5PvMnLXedy+8GEQ2xJdGds3tihiFZYXR1q31qTTmItJ0jNBj3WAw2Padi4Z
	 1gCWMics4xvAq49USBUAi3OEIfi8IN91fREoqZzvTo2y+DnX6Xq9k7Zb0erfYSI2xtxOs
	 ZWr8OuDAMDx141PvDMcEeeykoL920VFoNs9SkgEAxCz05ouTwWN5rmru9ajsHCBRQY6kZ
	 nEL6Rcn4Uo/QWO3F2VmuPE/++MYGyBLE8Lp8dxLjKEf/34O2w3EQGxUkPkGT22puDJwm5
	 PZujVdrPoGJR+0UhgT3gBBfkcDc3NJUh5LoGDwmea6icwExn+HZqVcdI1+MZthuWibw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=eYk+rePZ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WHVMbNS1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C4606D821;
	Thu,  5 Nov 2026 11:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6C4606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=eYk+rePZ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=WHVMbNS1
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wHYt2215002;
	Thu, 5 Nov 2026 05:01:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0IopOqW10dlZZdSRpOXr/bCmuAOHvNZxEF2UWIPj7
	ic=; b=eYk+rePZbUC0NR/gCdSOMjIf9+sAoGp36cdgnOxViIIA+SD+w37MYfNt8
	icabaPNVKk4MAxRvsZj+9DFPj8CZPZ+nfRhr18w+5qw9fmJGSs2br27pI124QSdu
	nJ5OqnlxmyRut21ERvmV+AbdPTP/6NjQH60ETLbKspGuxTQOEjEKkPefkYAZFi+7
	pntDYJcCu4DZEoK6Shm25G7hsFeYUEWj4W6OhMzoUTSd0Z1EkFTi0qxQe3zCMu39
	0WkJJHxJ6Rc1QdNsZuZTREv3wwG2rjcNU1/yCMkeD6OWKJJuO1YbfftGi2Yq0oK3
	MVT7Y812JWKVSYI9O593SxhmIP9Ig==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k26v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:01:05 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=povDbYkNiS6lJtaRHTXp3Iu2hhLM46xi3fvoOWq03/BfMpH8tXH1AWBMP+q57fEcL7WdvlyNMZIU2x8DSED/418n/t94X8smeJIqyBZGmQVxdRdZUUcLX6bbJn4+V+KKex/OH2Q0iZvRdJtH4WMg94bsJVzsme/jn5ZrQDLfbuPPUV7yfBo17dHrAvOSyS73oCnsXv0nSFqV9L1FnlyMJemPgajs8mTcGQCIsc4bk4UPk4f5VzcJLC/3x0p3SV2bho3ZtaOMrwPGQ/vTUXiuMxUSTeSlXfGH6XvThIuSbGwFOjW5Jey20y/bftjTib+o64HUVcVE3zUCpqm09j7oGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IopOqW10dlZZdSRpOXr/bCmuAOHvNZxEF2UWIPj7ic=;
 b=g6L0K1JmVoCSZXAmT1iaTjuxGPXzoOTphl1eYaYvd0kIYE+cbypm/Ud8PEUKpFmDOqzFzJW6r6sXb+1ZwYStl+aKBKxBGVCEndgQQTJT/iu8LzOVQsxu5stpVdW3AZaln95evJDC565NklRm7XCCHeUjkRJIrsHjh8sLBjWd0lW2qah8QiFRnDnEwh6PMJnfpOvFNTERTyVIv2knuGxYQD6TOrPqMfLjqc59UwVg5M/nBbFJlBg4cJFetweW2Oa/cEhYBNXZ+JwwKTcMfjr8LpXqinW7S9AmG21KL+Y6wDwLUnjO0BO7S2ANgTEySnjO3/pl6ECUkMMVt1kNVsiitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IopOqW10dlZZdSRpOXr/bCmuAOHvNZxEF2UWIPj7ic=;
 b=WHVMbNS1niq+hxd/juFbVE48WvapS1t49yUo/RlMUeXLHadUFiYBhEyAkAu7ZmGvJ1LcYI9z7edTLoaAhi2vcZH3CG8DT3araTGUCa1tbaqlI1HIvU1r0lTUu5Ezwa/nmn+uk6IQ6kzR/5DTelML5eIquVElXN65Jhe1Mn4jAmE=
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 11:01:04 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3e) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:01:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 11:01:02 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:12 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:12 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:12 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2N4171076;
	Thu, 5 Nov 2026 05:00:07 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 15/19] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
Date: Thu, 5 Nov 2026 16:28:28 +0530
Message-ID: <20261105105832.2134313-16-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a0e5da-0463-4b59-3aa7-08df3b2c14be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|10067099003|56012099006|261009223027099003|3023799007|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	WMTLDNSiPyEKpSTsN/MkB7Pk3KDigfe8hD6Gz311PqGvAoV0yqlDPpQyT3bcZ7bQDCHa90ILPFNviYYzSyrbsra2iqq10cm47KQUF4oYUrMNqFJNBVBl3E0fzwXj062To6XmE9qMR4/evz1VnQBu6A5SMUNCuz40u6GWeeYkteJnee4/yck0FDe0PIon5k6h2ooZDP9QWcuS1kbXbjdFui6tXe/TnWtdaGW9ympxXLcrrBJWsYRjKZr0jz1c7QOA6p3/n4zGtwt0lJLz5xJU+t3ohCrZI/uNuuFp5xAf4XxFiuDGO6I63uTTpWhMDK7gWQJaggJ0uHeCn51yKhaaxw6FDYKbGzp2b+2LPPElSctWPdb5GZjP+fbGAAEDYx7jPuiVaVGvpQItjM6ff12D6GhdCEi2GUivjDulQpL9zRSXR0O+MU9TDQAsrEs9wlsENygm2MxA/eGek8CMGbLs3gRjBD6Ke1M0gbxyjlQey5yI9GFLxonnTquC1RKnwJ2/zDBjpqpx5/3m+ucCAaPTxX+VDWbuR68YbGbMweL3mUmKCqFoDaw4p+I3EYhUUVrkRkTePcljPIytYTtDW8jinIkCAns9hZ04ymPKIM/3e+4rpVC6LiNpuyoxoT3+mzLaKhEfvip6RLvSOPeORR+XS42AYDiXWylnoa5MOqBTmOPyp60l3dARMMTdF/rjWA/rcaxD2ac4J+0c40fWV732zjMiZR6qXdJpv7Wman/oz5WDIK9tps/d2miXMaDVgUcU
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(56012099006)(261009223027099003)(3023799007)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7cs1LgCqN+AhLcM3HGjRMrBBs8xuGjJOrHO6kELTHhiVupW9PbX6WQWiPqK2qmDilgWDdo3k8DBuxV0YHH5PwjpBlKrivHJ+BdBChsUrwM3Wi0CHsf8hDmFI45U5T5OKwckQTSYHzdXe0XvpBeEKObBAgzOGRDKS6Exr8XfuX9c2eV2fEvuxbwR5xhcMCge4Y+IFL/ueE/udKhmAxTGtUTFit2/D2KTYDXsUTmxjoAElVlg4oFfqMHUqb7icurH8CJNa1ir/9fgpJawCLKtcn99ZHWXi8S0UThGyGGhXlLuy+p0ys2sQK4leVN22q6iiuHnnt6LoZWMMMsk8T+l/46wvM3JOYUtpYkFxG0uGaOSFzeabsIYtKDQW2gDbv+kwBCxbiyTPM4tRMRwqWVdORaYCzldl/HzfvzDmo81p5auH1DH1GhTp8gLD/a+7Xhh3
X-Exchange-RoutingPolicyChecked:
	y9Piy0SStLsIEKPEJn2mQY4Pq/KT3AvaVge4nG44UKjbZa/03gKO+LDixgaabpOnaNFk7/rPRk1t6vbwOMLJ9s2juMkwF2F92+aofXs8LgTbxu5XJSFb6w+hU7ruqOFBpLGfy94Xjjd+IdcHNjBPP8o5fdnELE5SN37zv/6XlzQU0B1JNPFDF+HTrohMllCraWDBI4bVdHaaPNdlHVUfpc3nzU80FxU6VT6sE03xLPVRK37po2BV8bzsllLwLUHo2AwPmByLPoOmQ8Yifo2Lhcwa4v2rneGuN287zRF+pXJiKHP0p6oF8WdIQu9bwnKLkYBeoofvhWjzAIYoh1ZCBg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:01:02.1216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a0e5da-0463-4b59-3aa7-08df3b2c14be
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-ORIG-GUID: eVzfHMzRzBP8awdfjCswHQrllpQcfX8m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX9vwT6/ll6xYp
 oDD+6twWfy34PveQ/Zq0/V2lPmFmcSIKE2FPmcuCMRhozdUUEe7WbEOKft3mHerNXggOs8sbmeq
 LQgP8TsUxnCDTpWrGkbc7kLooNjlQMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX0AKpMja9LAKO
 vPUu3nX4I6mEQJumevFkzaKUkGLWXC1FEaiKgvKh4M+qVorhVsX5C40mJEzKTzIjN7pLYk0ihwC
 u1YI+K91fxGXrGKxkDllOEdKMusQS8Iz7DYZUr/0q/O5ZT7wk8K0CYVh3cPcj6z9DhDTBY891e6
 s5Yr0q7NV3L3/W4y/3LvDRm1r8Ums1iHRobKSWvwyfJLTBaWkvVCFJaG3+pdnWiBL5o0LyCg5Lf
 Ny+FIHyugGQvYzBizRnnpSKdeVLsw1ThPxmVKY6nZMtIoFt/83v3cREPJaPU+q+hLxex75LY64A
 B3Kl60KtUi9zHbjSipfIMmaVsfFLdAIJVbYcIH8j8D+oZqdkde4D0rU1iHhGoyqPc6+kGcEAR7J
 QUQJD7WIw7+t0WhLXC+ZFkWqolymw+0usWsS0gmLrcHPi/JsizDc6VsdR7LMlVaE5Q8h3PjObdk
 ywlNWCcEyMRYSmHU2hg==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec61f1 cx=c_pps
 a=n3jZDpZxtfjojidyQ1a5Gg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=mFCyQ4P7OL-0BhijAlUA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: eVzfHMzRzBP8awdfjCswHQrllpQcfX8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Refactor spinand_select_op_variant() to extract the inner loop into a
shared helper spinand_op_find_best_variant(). The helper takes a
skip_mask bitmask of already-tried variant indices, enabling callers to
iterate variants in ranked performance order while skipping those
already attempted. spinand_select_op_variant() becomes a one-liner
wrapper. No functional change.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 133776ba53da..9dc43c8c4162 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1559,9 +1559,22 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/**
+ * spinand_op_find_best_variant() - Find the fastest eligible op variant.
+ * @spinand:    SPI NAND device
+ * @variants:   full variant list to search
+ * @iface:      bus interface to consider (ODTR or SSDR)
+ * @skip_mask:  bitmask of variant indices to skip (already tried)
+ *
+ * Iterates @variants, evaluates transfer duration for each eligible op, and
+ * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
+ * no eligible variant remains.  Used by both variant selection at init time
+ * (skip_mask == 0) and ranked PHY tuning iteration.
+ */
 static const struct spi_mem_op *
-spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_interface iface,
-			  const struct spinand_op_variants *variants)
+spinand_op_find_best_variant(struct spinand_device *spinand,
+			     const struct spinand_op_variants *variants,
+			     enum spinand_bus_interface iface, u32 skip_mask)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1569,15 +1582,16 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	unsigned int i;
 
 	for (i = 0; i < variants->nops; i++) {
-		struct spi_mem_op op = variants->ops[i];
+		struct spi_mem_op op;
 		u64 op_duration_ns = 0;
 		unsigned int nbytes;
 		int ret;
 
-		if ((iface == SSDR && spinand_op_is_odtr(&op)) ||
-		    (iface == ODTR && !spinand_op_is_odtr(&op)))
+		if ((skip_mask & BIT(i)) ||
+		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
 
@@ -1606,6 +1620,14 @@ spinand_select_op_variant(struct spinand_device *spinand, enum spinand_bus_inter
 	return best_variant;
 }
 
+static const struct spi_mem_op *
+spinand_select_op_variant(struct spinand_device *spinand,
+			  enum spinand_bus_interface iface,
+			  const struct spinand_op_variants *variants)
+{
+	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+}
+
 /**
  * spinand_match_and_init() - Try to find a match between a device ID and an
  *			      entry in a spinand_info table
-- 
2.34.1

