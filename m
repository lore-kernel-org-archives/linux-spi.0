Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6D3451CF;
	Thu, 16 Jul 2026 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784181901; cv=fail; b=MwSWPdd+TrXWHTusjhEYevGYfPi9hCmcotN8gK658AvDXZEh1I6kNaz6V4yU2lCDJp7TBy/K4jo0yyr+fK00QvK9Wohis4F4IX5ehlH4FDKiGuEMO1R3Lxi8Uj1jItgHAxUk+Lzv5tRYDF0tDaaNapgqAD4ZwdUrBTku6Llgv40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784181901; c=relaxed/simple;
	bh=Nv2xssf8072j3Yqtv/UlG0F2dfUh0ui8xjh8la9PE5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aa7tslBgkhOGro8eeYpxKcy5T3FPD2rsH8JI4LzohUnxF+DMQuOQrv4u+mUIDMQeibHsq+uUTn70vlLqIDwWekA0BCUZ9sLAahNeUiDTtT131u+rVgl1YEqZQ1RFxztxVK26ZouL4ck8cZ3kS3O1jnDH14WuguVfl8Jd0+cfvx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dKBcJgNh; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fvl+TEiA; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dKBcJgNh";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fvl+TEiA"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3uH2A2761660;
	Thu, 16 Jul 2026 01:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=qGdElnU2qZEpYj+0XeMBPys5HLfaKq+iwIyVCzvUC
	oU=; b=dKBcJgNhN2xC/Yb82Pmr8bEDKbaSh170jiZz8vNACskHhaimr761AQtj9
	RM4fQ9ixQNbdQ5QIBsncfz9ZjhcGpVVyii3fU59BBksuZF36T8QqxHYsA7OR+ccj
	Iiz3/hQj1E5xiNhJsGnn1jvxKNRn5KW8NOAv2EHRv5wZb3oeBDv0HKMfhhRDwazH
	JnyYQMyhnDxjKteoBur9uB8fYtEV7uO4FjKCO1XuEaQT9iY2oCwBFO7Kzw6Ax9BB
	06ccG4UNqTo6L/ocyA1bPHl2w2/M4xmm+IWNiseGd6e9NjOb7bx2WSggEhNz5FAT
	0tVNjK8eaAnUtnmeHK93O+NXbRWLQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fe96tnra1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 01:04:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPM3YyZ1D3re+Kjjh+s+tlIxQYdJ0RHVr6Jtosnd/WXctYtzC577gqiFEy7107XZZvOC/yknltk8mHdBm1OJKpvuv5gSMKAg28Crvff2ndwHNboZ/5sMd+r8wOBR6vQ3hiluofzGsrynqb6oaI7NeoFAr0K4BpFOUGQD0G53d4W0kkS+jB+i0ywsB+Ehgfb022X2Olo8Xl7yG1KoSyL3c59m0RPlt+F5ANOG7N4nbhcbnegjlpcwNnuI/fSUhSE/lE3f7lvj89BnNwc4q81AqIGj8cCzBaqQUS+SUmZ7bMCRw1Dza26kk6vQaaK4riOPrzhoYzp3FXiGA5/G3+nCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGdElnU2qZEpYj+0XeMBPys5HLfaKq+iwIyVCzvUCoU=;
 b=t9V5T0M/q2b0JHdRUDEygA9P0gDBjEl5YX9rOZ9rFwFK1VnWAMNcXZfY5Rh+iC7HZ/HkFekjjr5jYB6YxYIKdM+IxJTTrZeL1Dy1zNNLb7ESc4oZmgXl7smq2cHcFkauCToxTsDBDL0qMuPVllJRoI5dO805AJ41bz8jooy7F4eLz98S/sktkmuADWYMClI02qBT6CPMr9PSlDCrrPTG6NtQTelxSJfcXh0lC2lovbX77SzMUm+N/PvDtblh1Ag3C91N6x/JMWf7c66DA0J+SpveAIbO7MGhNASTMTVCpcDXCeBvdpdiGDd2wyJ8Z6eMKd9a7qj+xlVQ7jpnGW0qgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGdElnU2qZEpYj+0XeMBPys5HLfaKq+iwIyVCzvUCoU=;
 b=Fvl+TEiAJEeqNHv9VYIAXOpxgaAH2OHa5NVL2SiOW9+2xI/sihr0FpmAAgouLYM9ks13IhQE1Z9COifkvg72VyNOTD8BvcdXN1h5AIheBw19x2U9YU5Om5D0ehf5ioBn0OWTmq8jWem1K6niAkiejykx+VkDUT/cCG6ccjAMcsQ=
Received: from MN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:52d::14)
 by CY8PR10MB6850.namprd10.prod.outlook.com (2603:10b6:930:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:04:41 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::2d) by MN0PR04CA0024.outlook.office365.com
 (2603:10b6:208:52d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 06:04:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 06:04:40 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 01:04:19 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 01:04:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 01:04:19 -0500
Received: from [10.24.52.55] (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G64DCe650352;
	Thu, 16 Jul 2026 01:04:14 -0500
Message-ID: <13926125-5e55-43c5-b502-4e487d561ee2@ti.com>
Date: Thu, 16 Jul 2026 11:34:12 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] spi: cadence-quadspi: add PHY tuning support
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "miquel.raynal@bootlin.com"
	<miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "pratyush@kernel.org"
	<pratyush@kernel.org>,
        "mwalle@kernel.org" <mwalle@kernel.org>,
        "takahiro.kuwano@infineon.com" <takahiro.kuwano@infineon.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "u-kumar1@ti.com" <u-kumar1@ti.com>, "a-dutta@ti.com" <a-dutta@ti.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Amit
 Mohapatra" <amitrkcian2002@gmail.com>, <s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
 <DS7PR12MB9503EA13A8FB71938556F1CDDCEF2@DS7PR12MB9503.namprd12.prod.outlook.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <DS7PR12MB9503EA13A8FB71938556F1CDDCEF2@DS7PR12MB9503.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CY8PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: b67831f3-6c39-4b31-0617-08dee3001fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003|10067099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	ohFMQk3Jcz3MxcJQnQZEzAzazpSax4JHWPmT1vBsS+juY5lNXWxBmuFfSnHglOrE0cF2tfyB9D6UuinnRGp4e41AQJZEYsXGaLNH/Ph9mLdQoqhcb+DUPf5D/P60WcocVzdoq1h7FugTIWTLYjuEekOTkrYs25RUB0a/C2dWqM/Ra8ngf32fp2VAehEd5FY1LFTMFJOXXUDsUpB7CScOsSoyRSa2tBX8uf6VO0KJ0m7RcZZLKIcy4WWkrbyBIzI0usfKux6ozrOeFJxjdcFm//cUScujQytbE+Jm8F/I6a+2BmM7EJtaSToP7a/zbPfTGLN/c5VOzNGLzD8uwkwPC+61PSqrTC+8el7m4HuFkbW4GQDvXVs30vYiuE2DXaOeV/Pf+tclYQVHasxZf+vXzudwso6MVIIhJfidfD/lT3V0WQ1qGnLkhjf0kHnJ7cKFtDTeT0Rm9ImrrQHbSv798IcQpTjNOs4NEQG6smDFOPFRwayNvaRhNop9kqyP4/VfLjlvx1wxPOQTuv2NdMtEzOHH9HoiRnHOdRuHOofljkjbBClv/Rj7QrO2vF93oeihK3gDYYz3iJi6SnchXkoyV+AFAT7MY4cwvgGSOLXYgEARgzPPKO2u+S1DhRMNUnkUUaW5wbsvguEo4+9A0Y+Dz9bDzFjKPI47zOMbDQvYfRKrqQVEMOCSHQSIdi7gSRkzRDftrdyTAVLVxOEWDQ3rnxXeGiwg68mAdhTYx8pP6qltLrERfyWXE920+eHGU8rJ
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rgDETYq0NfdGwHiqc5B3xuY1Mmu5Z2AWW2E663hnmqOVbUQ7s3Jtnw6uYLr1e44ZeRcQfiX7YhFuZZMHaGyOCH7iYjdqMoBsgGq9nKi7yJ4l1uhjAmzIXEl890mv8n2CKTKhHHGef6/Q+AAoWUzRsXA6Bwy4hGb3VzU9N3Vck6LHGXhitpwuvkEJHVmT88XJhPY/olYByba5Zaz2uLhhyvU76wTuHd46Yyhn8e/TvBDhxDSRn5/JfdqDNkMwuuYr9StrUjjOF04OqK0Nke3BFsM8foFrrw70W6FijyzmRv1MQQbR1l8+eTHAQLLFV1EBlwdyITl00aC9iCsyV8KLniHnLh1EN/lUcBUcGAun1WFBr1qafc9nSN0ZAh+3V5tcJqBw4y0mSWiO+0AHh/fmtGWzPOyYAVkXT6sRPNVq2aK20TAsv/IgKKcxBmzQkAiM
X-Exchange-RoutingPolicyChecked:
	PVVphsQlsCvj7hNKp2iMUAvo0FsxQIrU29+qJAihyRbwtSyNHtc5y4h0CvcCTGZW9SuEohAUUq0ZG68csAsTBJLdB0Ae/PUtIZ9HXerKeKr9AACXPXzmkTtTWijL+lkRUEVZAY69/QnMBYEBn69MMCfSlFDtQFc2eulGFlQ1cALRXdgKWyel5HMeMvFxPRq/jMUve1R8MDekHIV7isG2hcj9zPdAmEyp7/b9U/RdIBiPD33pOrBnJSIVLycTi+RGLyQ299nJrSP5xB+MTOplJN8pFf9lw/wjhS3Vsm2ntuzYIs0zlrlWRi4E9YeoK6Mz8ASzLA1QjkdcYns53Xf4aw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:04:40.2110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b67831f3-6c39-4b31-0617-08dee3001fa0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6850
X-Proofpoint-GUID: LlpobBVooKixfrR2w2NR3X718C8HmXwR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2MCBTYWx0ZWRfX4K2BWogglavK
 esYValspUn9flouChD8FNqUDKFHjXNY0GqP/JDKdxppxS0eJ+dUPSg//eAMYMxGLsmmYt81WmEU
 2C0k2Szzt3cp9LgHHq2GUaQ/NvNEM+0=
X-Authority-Analysis: v=2.4 cv=VbnH+lp9 c=1 sm=1 tr=0 ts=6a587480 cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=bUQKSiCPAAAA:8 a=JfrnYn6hAAAA:8 a=Qen6o5WCelmsuRyjQiYA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=-fHZXUhsFbuwFN3fwQAr:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: LlpobBVooKixfrR2w2NR3X718C8HmXwR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2MCBTYWx0ZWRfX41l9GMl3O8pL
 AoEf/sznnP3wOHUt1Jk2wu+6VAd5JTV3Z+JW+rT/QzWj7Trfd+2k0XdqbjXX6Bo5NVW2qYDDgeG
 GonH6m0hf7dW/CotUiV77EqcvGKmdtffHy+4C5d0kDLko+WhavdZa74S2108wfM9m6o+704zJtw
 VD5/5qq9kwnifP22PBmHWSU70+34HtoWwIJ40k4i1fwsXyJ6N6AKLXJlpvrWwNgPPh8R7chbiVl
 QhplnIQMOCnj7P2ihtkNPS/kzo35jM8/5zidFfn+GSbX1xIVcFh3sI1MK0rQ6lWbH7WLT/YJLiW
 2vQqMgljVWKnXxUYncblVQyuViPRyN4WMDzBy5FyVq15wlnGCKlpwsZtEDLtjP1kYOMdM/OJ6PI
 1vaJdI6SwgmcO7eOqJg7WzTWtaK0GFHX6qzsw7RpjR+ygvwYx3OdfNyLzBe8KHqcYqQ/7PPmWcv
 2jEiCB0ZbJ5bTPz66Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160060

Hello Amit,

Apologies for the delayed response.

On 22/06/26 10:00, Mahapatra, Amit Kumar wrote:
> AMD General
> 
> Hello Santosh,
> 
>> -----Original Message-----
>> From: Santhosh Kumar K <s-k6@ti.com>
>> Sent: Thursday, June 18, 2026 1:07 PM
>> To: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
>> vigneshr@ti.com; pratyush@kernel.org; mwalle@kernel.org;
>> takahiro.kuwano@infineon.com
>> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-mtd@lists.infradead.org; praneeth@ti.com; u-
>> kumar1@ti.com; a-dutta@ti.com; s-k6@ti.com
>> Subject: [PATCH v4 00/16] spi: cadence-quadspi: add PHY tuning support
>>
>> This series implements PHY tuning support for the Cadence QSPI controller to
>> enable reliable high-speed operations. Without PHY tuning, controllers use
>> conservative timing that limits performance. PHY tuning calibrates RX/TX delay lines
>> to find optimal data capture timing windows, enabling operation up to the controller's
>> maximum frequency.
>>
>> Background:
>> High-speed SPI memory controllers require precise timing calibration for reliable
>> operation. At higher frequencies, board-to-board variations make fixed timing
>> parameters inadequate. The Cadence QSPI controller includes a PHY interface with
>> programmable delay lines (0-127 taps) for RX and TX paths, but these require
>> runtime calibration to find the valid timing window.
>>
>> Approach:
>> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>>
>> SDR Mode Tuning (1D search):
>>   - Searches for two consecutive valid RX delay windows
>>   - Selects the larger window and uses its midpoint for maximum margin
>>   - TX delay fixed at maximum (127) as it's less critical in SDR
>>
>> DDR Mode Tuning (2D search):
>>   - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>>   - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>>   - Defines valid region corners and detects gaps via binary search
>>   - Applies temperature compensation for optimal point selection
>>   - Handles single or dual passing regions with different strategies
> 
> Thank you for this series. I had a question regarding the Virtual Concat
> driver patch series [1]. Now that it has been merged into the kernel and
> enables support for multiple flash devices connected in stacked mode-where
> each flash device is probed and configured independently-if both flash
> parts are required to operate in DDR mode, each device would need to
> perform tuning and store its tuning data separately.
> 
> Given this, should we consider this use case and adapt the tuning
> architecture to support it?
> 
> I'd appreciate your thoughts on this.

Good point.

The current implementation already stores the calibration state per
chip select (delay line settings, tuned flags, and operation templates),
so the data model supports independent tuning for each device.

However, the runtime path that enables PHY mode does not restore the
per-CS delay line settings when switching between chip selects. As a
result, consecutive PHY accesses to different devices could end up using
the wrong delay line settings.

This can be addressed with a small change by reading the currently
programmed DLL and reprogramming the PHY configuration registers
whenever they differ from the calibrated values for the selected chip.

Thanks,
Santhosh.

> 
> [1] https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-0-5e98239bb55b@bootlin.com/
> 
> 
> Regards,
> Amit
> 
>>
>> Patch description:
>> Infrastructure (1-5):
>>   - Patch 1:   Add spi-max-post-config-frequency to describe maximum
>>                frequency achievable post controller configuration
>>   - Patch 2:   Add spi-phy-pattern-partition phandle for
>>                NOR flash PHY tuning pattern location
>>   - Patch 3:   Parse spi-max-post-config-frequency in spi.c; adds
>>                spi_device.post_config_max_speed_hz (0 when not set
>>                keeping all existing DT fully compatible)
>>   - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>>                op->max_freq equals post_config_max_speed_hz, return
>>                immediately leaving op->max_freq unchanged. All other
>>                ops are capped to max_speed_hz
>>   - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>>                spi_mem_execute_tuning() wrapper in SPI-MEM core
>>
>> Cadence QSPI Implementation (6-12):
>>   - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>>   - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>>   - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>>                verification (NOR via spi-phy-pattern-partition phandle,
>>                NAND via write-to-cache), SDR 1D and DDR 2D search
>>                algorithms with temperature compensation, AM654-specific
>>                execute_tuning entry point;
>>   - Patch 9:   Reject 2-byte-address DDR operations via a new
>>                CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
>>                AM654 OSPI erratum i2383
>>   - Patch 10:  Refactor direct read path for PHY support (preparatory)
>>   - Patch 11:  Enable PHY for direct reads, split the transfer into an
>>                unaligned head, a 16-byte-aligned middle section with PHY
>>                active, and an unaligned tail
>>   - Patch 12:  Enable PHY for indirect writes of at least
>>                CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>>
>> MTD core (13-16):
>>   - Patch 13:  Extract spinand_select_op_variant() into a shared helper
>>                spinand_op_find_best() with a skip_mask
>>   - Patch 14:  Negotiate optimal PHY operating point before dirmap
>>                creation
>>   - Patch 15:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>>   - Patch 16:  Execute PHY tuning in spi_nor_probe() before creating
>>                dirmaps
>>
>> Testing:
>> This series was tested on TI's
>> AM62Ax SK with OSPI NAND flash and
>> AM62Px SK with OSPI NOR flash:
>>
>> Read throughput:
>> |----------------------------------------|
>> |                | non-PHY   | PHY       |
>> |----------------------------------------|
>> | OSPI NOR (8D)  | 37.5 MB/s | 216 MB/s  |
>> |----------------------------------------|
>> | OSPI NAND (8S) | 9.2 MB/s  | 35.1 MB/s |
>> |----------------------------------------|
>>
>> Write throughput:
>> |----------------------------------------|
>> |                | non-PHY   | PHY       |
>> |----------------------------------------|
>> | OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
>> |----------------------------------------|
>>
>> Test log: https://gist.github.com/santhosh21/fe98754e52970287eb9011154100b62d
>> Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v4/
>>
>> Changes in v4:
>>   - Add spi-max-post-config-frequency instead of extending spi-max-frequency
>>     to accept an optional second value
>>   - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq()
>> extension
>>   - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
>>   - For SPI NAND, execute PHY tuning across all operation variants available,
>>     perform duration comparison, and select the best resulting variant
>>     by taking controller-specific restrictions into account
>>   - Move i2383 check from cqspi_supports_mem_op() to
>> cqspi_am654_ospi_execute_tuning()
>>   - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
>>     cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_phy
>>   - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flash_pdata()
>>   - Extract DMA refactoring into a preparatory patch
>>   - Rebase on v7.1
>>   - Collect tags from Miquel
>>   - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1-s-
>> k6@ti.com/
>>
>> Changes in v3:
>>   - Drop spi-has-dqs DT property; DQS is now enabled automatically when
>>     the selected read operation uses DDR signalling (dtr flags in the op)
>>   - Extend spi-max-frequency to accept an optional second value forming a
>>     [base-freq, max-freq] pair; the presence of two values signals PHY
>>     tuning intent and encodes both the conservative base speed and the
>>     calibration target in one property
>>   - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
>>     two-element array there; single-value DT is fully backward-compatible
>>   - Move frequency enforcement from the cadence driver to core: new
>>     spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
>>     the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
>>   - Propagate the tuned max_freq to dirmap op templates after
>>     execute_tuning() succeeds; store persistent op templates in
>>     spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
>>     frequency writeback survives across the probe call
>>   - Replace NOR pattern partition lookup by name with a
>>     cdns,phy-pattern-partition DT phandle pointing directly to the
>>     partition node
>>   - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
>>     ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
>>   - Remove RFC tag
>>   - Rebase on v7.1-rc5
>>   - Collect tags from Miquel
>>   - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-
>> k6@ti.com/
>>
>> Changes in v2:
>>   - Restructure the .execute_tuning() call from spi-mem clients instead
>>     of mtdcore with best read_op and write_op (optional) passed
>>   - Add compatible-specific .execute_tuning() call which can be called by
>>     spi_mem_execute_tuning() if exists
>>   - Handle tuning requirement check by controller instead of spi-mem
>>     clients
>>   - Add support to write the phy_pattern to cache if relevant write_op
>>     is passed or get the partition offset which contains the phy_pattern
>>   - Add tuning algorithm for DDR mode
>>   - Add support for DQS
>>   - Restrict PHY frequency to tuned operations
>>   - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-
>> k6@ti.com/
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>>
>> Pratyush Yadav (1):
>>    mtd: spi-nor: extract read op template construction into helper
>>
>> Santhosh Kumar K (15):
>>    spi: dt-bindings: add spi-max-post-config-frequency property
>>    spi: dt-bindings: add spi-phy-pattern-partition property
>>    spi: parse spi-max-post-config-frequency into post_config_max_speed_hz
>>    spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
>>    spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
>>    spi: cadence-quadspi: move cqspi_readdata_capture earlier
>>    spi: cadence-quadspi: add DQS support to read data capture
>>    spi: cadence-quadspi: add PHY tuning support
>>    spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
>>      (i2383)
>>    spi: cadence-quadspi: refactor direct read path for PHY support
>>    spi: cadence-quadspi: enable PHY for direct reads
>>    spi: cadence-quadspi: enable PHY for indirect writes
>>    mtd: spinand: extract variant ranking logic into
>>      spinand_op_find_best()
>>    mtd: spinand: negotiate optimal PHY operating point before dirmap
>>      creation
>>    mtd: spi-nor: run PHY tuning after init and update dirmap frequency
>>
>>   .../bindings/spi/cdns,qspi-nor.yaml           |   19 +
>>   .../bindings/spi/spi-peripheral-props.yaml    |   13 +
>>   drivers/mtd/nand/spi/core.c                   |  246 +-
>>   drivers/mtd/spi-nor/core.c                    |   80 +-
>>   drivers/spi/spi-cadence-quadspi.c             | 2265 +++++++++++++++--
>>   drivers/spi/spi-mem.c                         |   40 +
>>   drivers/spi/spi.c                             |    2 +
>>   include/linux/mtd/spi-nor.h                   |    3 +
>>   include/linux/mtd/spinand.h                   |   11 +
>>   include/linux/spi/spi-mem.h                   |   14 +
>>   include/linux/spi/spi.h                       |    3 +
>>   11 files changed, 2493 insertions(+), 203 deletions(-)
>>
>> --
>> 2.34.1
> 

