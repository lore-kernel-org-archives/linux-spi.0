Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876579;
	b=hotD4eu1SN1V/nY9juOWi/0nDh+gEZ7PXirZQEhMvRW0ygUmTF5CPguWZ6G7a+xIlofW
	 bQfd1aVgq/w2w48bquEIJxWmlscPGwG6KaHyRYGFLAooBYdA4m4l3GMc+NqjKKphZT6bN
	 NX2e9I9ehtaDM5HKWg6AoegKXK2Ww299nzbPUwCJUxoeA4wnh2unonleAYqKcG5tNsFVc
	 6umpq5NqREzBroeA9Q6LKfm+6PrYSRLJPZ6/LgZ69TGtywHKAzKsbnhjy281JJ3yQuPci
	 srQIU321TVEfE/g8LWCgV5zhHkbNQ3udoqEh/MOneemknCAezwiQWQA1+EqSMQpv3WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876579;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	bh=e9CQSxszka3eKxZb0IXvrx6zLusPiYws4iMKz75roV0=;
	b=klUXW6yB11ST6vEmjauDb5bSdpuTQHrk+ckoCoP5BQAFI+isT2+sxXnRYpwd7LkJDTVy
	 Lwuvq7nMk7qe6sJMdo8fF485K9U4Avxy+gjS2rP8vvlVfyDcn7xA7XPpHJPcSIrXM6Dj8
	 pBIJc0yH+PFQBcIM0Qa9RCehNGALd2SyN80j61sxhvQ1gXN7PWC1NbA8V27VoQ99+1nsK
	 yUZERV468Lk0wcius/mWPylQRvYRXPTJwmzjVD3GBnJN2ABkvUxxAVKroozslT4O1fv4k
	 nBzBvlB1zvip0bvGfaS7rqyqmQHuANZx94s3OL68SnFGG9BgXt6C57wGalV0PBgbqWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=BgsRZwXd;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="j4o/6Dgu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94820606A31B;
	Thu,  5 Nov 2026 11:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94820606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=BgsRZwXd;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j4o/6Dgu
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59wH7f103545;
	Thu, 5 Nov 2026 05:02:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=e9CQSxszka3eKxZb0IXvrx6zLusPiYws4iMKz75ro
	V0=; b=BgsRZwXdmr6/2xVIjWaP4obwkCmkyUeeed0rcfTNFML5eh1XlHU1Y1w1t
	Ci/rM4rbOQq4PUwwV4IE6SlJ9eQTjr4ZmDXOqbsZS9D17+YriNkXkHQdVXhAg665
	aMf2k4PDSNAAzdhqEuFvskis9wzor/Q9qerKSH8fRSbgZ45cp/OJywRnzypP88bF
	DtPNj9pyqlCh3q74SbFhdnraQB+HuUJ+1TP3ZrvjNri68o0+vo6WN2x73XYEepQP
	mq+3Tw5TyuI2Z/ki84u34BYdPOAtf0bHszmARpnyUVnKl0FTcMpUu0myPB3Crt74
	DP/zlW+0gGMr25BFRF6OJuXMIcFMA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrdte3vf3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:02:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtXdtfEuH7S0WLS8ZHUZbj7+bPTmRKgklmWCqoZLHF2NXdnQkbl72Xh4jFu2rQq7vhHcUw9bJ8VLVGUohLohpzP5mI+3MmnaOOe60BL/ehqmU45Up5GX7QlC/r07JGzzNekFuHUCb539tUwj8w5BXXy1KhLQVIOExr1Bnd6Iw+yZwn0wWtwUoCU+bQ40t0dbJ4TFEkSw3036OGn76pDYYYZVcP7syAGR4oG8TA5zmFPDubPhrhk4XVJPmdkSJ8+QroFpYTIVAvZQvVSEeZKiQZPtYL8oDSbF/dcY5jbmMwrckrqgozAs1OPNk2nb5+5701zw/lssOPQHUBZc3yW30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9CQSxszka3eKxZb0IXvrx6zLusPiYws4iMKz75roV0=;
 b=FKzaVawn9lHCbbtfc4nZl5DzPs3pZ8qH7IKrfeuEOk6tVRPaQD9obbyAq4r2eWFaBTyB0kQwwTYliUgK3I4wJgaBeCDLMR995CFLKGNIRzVOYTOI2zvuYaptRRggIbfPk/+ucA6+0lD9dbu93iVWd4OZoZ3eXlfMx2vrj8DZtMgTOuzjJeexKL1vqzMPaoRcp3xvUDrr5dN+bkXBHtL7/VoCqc8ns9tIbIa9zZgZJldtDSSHV3U3/gHJzRY/jOpV4IF0WBW+HGW5xuRpA0aFnr0Xi/oHuqZvdEgzdTp7VAth/AV+Dlpx3s62mJ/iGgxFB1WMovMHUXZqEvPxv4mvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9CQSxszka3eKxZb0IXvrx6zLusPiYws4iMKz75roV0=;
 b=j4o/6DguLCNeeEbdSeYwo0gtoZVsxCeNIrePDjZbegEOSsIiUGTzU+x8E0K9ZSAppOA69TqJDugMGnhQt7iTE4CCNQE3EhY5zkOwblLZsxVMaH5fSlCtFRN0sBdeqhAjfyHptGp8vFosqteEzxZ1m6elxiRpE5bzvW9W8lf3WuI=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by DS4PR10MB997621.namprd10.prod.outlook.com (2603:10b6:8:31c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 11:00:04 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::4b) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 11:00:02 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:34 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:34 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2G4171076;
	Thu, 5 Nov 2026 04:59:28 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 08/19] spi: cadence-quadspi: add PHY tuning support
Date: Thu, 5 Nov 2026 16:28:21 +0530
Message-ID: <20261105105832.2134313-9-s-k6@ti.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|DS4PR10MB997621:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e138e7-a4a5-41e8-a493-08df3b2bf102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|921020|261022075727099003|261021121427099003|56012099006|261009221227099003|261021123027099003|261009223027099003|261022105027099003|261026121527099003|261028144727099003|261102123227099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xqOV2db7u5ISuKsLd4XCtL3DJf9IoLpJ11tLhdxZCQsW2dtsZLDi3aD51UF3rDymH086lxmkRHzaIO5r4/olaIbvU6egkEyohKQ6Tc0OT2qtBRIi/5gKBQAZTgqNgzR/LnVai8Q7m0UKjqKtoI5qxLnWFJHeRKoiufs6uhXR4XGRZPbm935eZaX8gT8VwLAYgFtu+r+khdFnihZfK61CMppyfnS0iP4HOn0umsSfFhF+IMAGTaWcx61FcPlHAhmX9dNpXPkdjDlxV4fuR9PAIlWBBODqaRYvuJQ3NZ6m4gt8GzxFsu7qre2FZBd92NOLcl2wNegFxxFQ2DKP/C3Hp4ZnCv7kPXImInZERhCvj3/rnZhOHFKZmm+8+es3jGWMes+KqfHekNDVEI1rjcYB/UCNjD8TaGUz3W4T+GWWE/HMVThPfHjFevAlPj1gfiK6dl+q1UtusqJpQLMpmAYVrEhVDjXZDjZFXPZxsCPAbu8UNYTsOauSH3BkV4DDFd+mIQqe0XrgdgfWMxHEfSRq6JajbVf8preanXtKbg4/Tmc0/GPpI9A7x1BsEgYoPzSxOYngMz9c639PoBKAmbXe59MILmq54GT6cramdV5FdQoooIv6AARZBfTMTy/LNzBrzFFBMyfGrcTJre8z3FImrGD6x2IWLW+FMMzxYZDgCWi0lEkXsxr265R8faUtBuxDPkzVT0DcmItY3RMcnrtS22Q6e/43zdhQLMXcxNdA9nqxp7ZQgMWAw7Qu/WMSnbga
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(261022075727099003)(261021121427099003)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261022105027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e2TvK25Ll4mXEdMXpK3HQjrEMjEI1zqeK4MdGpVqSzd/7N8C5vmbDTqabz3yzEYxbBre2jbowJxs9mf49zbGeEpS/X1VwPddK+FNeyhPTYT4uhAbJPlBNofNlxxZ9prTatkHE9ATvtrXeyND2xjnHDAsAMOxQca01dl78t36VxqUqOOVAUR2yND13rQ7ORfG5JHMejsYe5fGCjwSqT5yp8A0Txgubz8l61IxMeYXUZ0TFlrn4Cve1u0QL0968LmicWNDxth0M4gA4p2Taz1s3gz6vQ15fWKnpwbo5+2fNLNLw1BA8atavX8LQ2hpTdPPDQ3CpjG5qqIgX2dxoQXvPK3DWNPxDtyU+fAw1b6Fjo0r7OzFD3QbJaVs9uRPDe8D5Dfjal3bbljNlD0YN3bYVJZi3fVcMnpKiZF0kAq59DsDO9yeoJ4QsU+s/kMMB1cN
X-Exchange-RoutingPolicyChecked:
	Be7MHU7JN8dGcWnQStgfiffrnQdsKikTyK0uc+Keooag7XJFZQulqx0pFX4d37HyCxu8G2qKek7cx2QNTDuNh8mCzkO0fEdQgOrRJvkvcAMrB7X/NLnJZC/VKP4TR50lIP3z42zIAu40gHk3xs4bylcC3k1a/SgO1SDndwvnCaQTcgdi8a/hBvrmk/jAJ3C0upDC2UR5mPNGKTmTEyIjbRS06YUscSebTHaOvjyP+RfURstZvK6ROZenMtO29KvM0iggXR0Te74MLDFOEgEDbsI8Tc5tHy9OJkVy+RLdBRmlZPl4N0ofu+8Xy7yZ1rIChi/nAPGKwXZD6YxY1yQf7A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:02.1601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e138e7-a4a5-41e8-a493-08df3b2bf102
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997621
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX7EsLKYVJNXfp
 2sEqV025phApP7Jxe6MDa1NYT1KyvbPpl55qDf163S5y9X/kCw9vEcTfsc1m67jlT8Z9y6icvpb
 goXaq55XJhrjWVb4aXyqnofWw4GJ1t0kE1dp+hwgR6rCVQ/Ez8daMlqC7aEnkHLCxhhYQn+hODy
 v89/qWh8z7vH18/t1qvUf2x07Us1iAfdaGdVXVyxPVs7mg5ZHG7QwNo2Yi6qMSsX7UQ/rJUH6mk
 jzrMel5rQvIFGt3zHgNymAGTni2NgSKMgJi3ZDmyM+PZR6YUTlHwKHBiZvexhPIgxRymHKpNATq
 +zPj6mYX7RW0tGb0I52sT0zeUQ4R5YlnoYL8W46bI5KpvlHno3r7LgCtN61sgxc2VJPjqTtzrZD
 BwnVPvL9VJBtq4NrtaK2vDPjr/oiEauiXs6jvmBsDJyCl9twNVzNoxUssKH9SyMGSxq2jrA8IRq
 LuvfauEL8Fz1peYiWHg==
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6aec624c cx=c_pps
 a=QW6cWtaKxEx5aDBFEJsq+w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=MlhAJnQaR0iBW2fQ34UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX+5oCwP7YLR0H
 AVb6e5YT1/EATShIFwdw4W5UR6NfL7rNr9BZwKovo+50NcZbw9Zo626VQ7z18Gd79I17a8O89q3
 su/Fvoiviw9LrKLTf6xvhfRPn4ScHSU=
X-Proofpoint-GUID: 2kD77TogBYNSNAWQ9oH5sk_zwkwG5lJR
X-Proofpoint-ORIG-GUID: 2kD77TogBYNSNAWQ9oH5sk_zwkwG5lJR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

The Cadence QSPI controller supports a delay-line PHY for high-speed
operation. Without calibration the PHY is unused and read capture relies
on a fixed delay, limiting throughput at frequencies above the base
operating speed.

Add an execute_tuning callback that performs delay-line calibration using
a known data pattern written to a dedicated flash region. The pattern is
either read from a NOR partition identified by the DT property
spi-phy-pattern-partition, or written to the NAND page cache before
each calibration read.

For DDR protocols (8D-8D-8D) a 2D sweep of (rx_delay, tx_delay) pairs
is performed to find the widest passing region in the combined RX/TX
space. Binary search locates the gap boundary between passing regions
when two separate windows exist; the final operating point is placed at
the centre of the larger region with a small temperature-dependent
offset.

For SDR protocols a 1D sweep of the RX delay is sufficient. Two windows
at adjacent read_delay values are measured; the wider one's midpoint is
selected.

The tuning infrastructure is platform-specific: only am654-based OSPI
controllers populate the execute_tuning hook. All other platform data
entries return -EOPNOTSUPP and are unaffected.

The calibration target is sourced from spi->post_config_max_speed_hz,
populated by the SPI core from the spi-max-post-config-frequency-hz DT
property. Tuning is skipped when post_config_max_speed_hz is zero.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 1755 ++++++++++++++++++++++++++++-
 1 file changed, 1742 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4be37081d066..b0f01621b323 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -22,6 +22,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -65,15 +66,28 @@ enum {
 
 struct cqspi_st;
 
+struct cqspi_phy_setting {
+	u8			rx;
+	u8			tx;
+	u8			read_delay;
+};
+
 struct cqspi_flash_pdata {
-	struct cqspi_st	*cqspi;
-	u32		clk_rate;
-	u32		read_delay;
-	u32		tshsl_ns;
-	u32		tsd2d_ns;
-	u32		tchsh_ns;
-	u32		tslch_ns;
-	u8		cs;
+	struct cqspi_st		*cqspi;
+	u32			read_delay;
+	u32			tshsl_ns;
+	u32			tsd2d_ns;
+	u32			tchsh_ns;
+	u32			tslch_ns;
+	bool			use_dqs;
+	bool			use_tuned_phy;
+	bool			dll_locked;
+	u8			cs;
+	struct cqspi_phy_setting	phy_setting;
+	struct spi_mem_op	phy_read_op;
+	struct spi_mem_op	phy_write_op;
+	u64			phy_pattern_partition_offset;
+	bool			phy_pattern_partition_valid;
 };
 
 static const struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
@@ -117,6 +131,8 @@ struct cqspi_st {
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			is_rzn1; /* Flag for Renesas RZ/N1 SoC */
 	bool			disable_stig_mode;
+	bool			phy_tuning_active;
+	u8			phy_saved_dummy;
 	refcount_t		refcount;
 	refcount_t		inflight_ops;
 
@@ -129,12 +145,15 @@ struct cqspi_driver_platdata {
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /* Operation timeout value */
 #define CQSPI_TIMEOUT_MS			500
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
+#define CQSPI_DLL_TIMEOUT_US			300
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -148,12 +167,14 @@ struct cqspi_driver_platdata {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_PHY_EN			BIT(3)
 #define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
 #define CQSPI_REG_CONFIG_BAUD_LSB		19
 #define CQSPI_REG_CONFIG_DTR_PROTO		BIT(24)
+#define CQSPI_REG_CONFIG_PHY_PIPELINE		BIT(25)
 #define CQSPI_REG_CONFIG_DUAL_OPCODE		BIT(30)
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
@@ -192,6 +213,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_EDGE_LSB		5
 #define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
@@ -273,6 +295,28 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_POLLING_STATUS		0xB0
 #define CQSPI_REG_POLLING_STATUS_DUMMY_LSB	16
 
+#define CQSPI_REG_PHY_CONFIG			0xB4
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_LSB		0
+#define CQSPI_REG_PHY_CONFIG_RX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_LSB		16
+#define CQSPI_REG_PHY_CONFIG_TX_DEL_MASK	0x7F
+#define CQSPI_REG_PHY_CONFIG_DLL_RESET		BIT(30)
+#define CQSPI_REG_PHY_CONFIG_RESYNC		BIT(31)
+
+#define CQSPI_REG_PHY_DLL_MASTER		0xB8
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB	0
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_MASK	0x7f
+#define CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL	16
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN	0x7
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB	20
+#define CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3	0x2
+#define CQSPI_REG_PHY_DLL_MASTER_BYPASS		BIT(23)
+#define CQSPI_REG_PHY_DLL_MASTER_CYCLE		BIT(24)
+
+#define CQSPI_REG_DLL_OBS_LOW			0xBC
+#define CQSPI_REG_DLL_OBS_LOW_DLL_LOCK		BIT(0)
+#define CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK	BIT(15)
+
 #define CQSPI_REG_OP_EXT_LOWER			0xE0
 #define CQSPI_REG_OP_EXT_READ_LSB		24
 #define CQSPI_REG_OP_EXT_WRITE_LSB		16
@@ -321,6 +365,50 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
+#define CQSPI_PHY_INIT_RD			1
+#define CQSPI_PHY_MAX_RD			4
+#define CQSPI_PHY_MAX_DELAY			127
+#define CQSPI_PHY_DDR_SEARCH_STEP		4
+#define CQSPI_PHY_TX_LOOKUP_LOW_START		28
+#define CQSPI_PHY_TX_LOOKUP_LOW_END		48
+#define CQSPI_PHY_TX_LOOKUP_HIGH_START		60
+#define CQSPI_PHY_TX_LOOKUP_HIGH_END		96
+#define CQSPI_PHY_RX_LOW_SEARCH_START		0
+#define CQSPI_PHY_RX_LOW_SEARCH_END		40
+#define CQSPI_PHY_RX_HIGH_SEARCH_START		24
+#define CQSPI_PHY_RX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_TX_LOW_SEARCH_START		0
+#define CQSPI_PHY_TX_LOW_SEARCH_END		64
+#define CQSPI_PHY_TX_HIGH_SEARCH_START		78
+#define CQSPI_PHY_TX_HIGH_SEARCH_END		127
+#define CQSPI_PHY_SEARCH_OFFSET			8
+
+#define CQSPI_PHY_DEFAULT_TEMP			45
+#define CQSPI_PHY_MIN_TEMP			-45
+#define CQSPI_PHY_MAX_TEMP			130
+#define CQSPI_PHY_MID_TEMP			(CQSPI_PHY_MIN_TEMP +	\
+						 ((CQSPI_PHY_MAX_TEMP -	\
+						   CQSPI_PHY_MIN_TEMP) / 2))
+
+/*
+ * PHY tuning pattern for calibrating read data capture delay. This 128-byte
+ * pattern provides sufficient bit transitions across all byte lanes to
+ * reliably detect timing windows at high frequencies.
+ */
+static const u8 phy_tuning_pattern[] __aligned(64) = {
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFE, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFE, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+};
+
 static int cqspi_wait_for_bit(const struct cqspi_driver_platdata *ddata,
 			      void __iomem *reg, const u32 mask, bool clr,
 			      bool busywait)
@@ -913,6 +1001,76 @@ static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
+static void cqspi_set_dll(void __iomem *reg_base, u8 rx_dll, u8 tx_dll)
+{
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~((CQSPI_REG_PHY_CONFIG_RX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+		 (CQSPI_REG_PHY_CONFIG_TX_DEL_MASK
+		  << CQSPI_REG_PHY_CONFIG_TX_DEL_LSB));
+	reg |= ((rx_dll & CQSPI_REG_PHY_CONFIG_RX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) |
+	       ((tx_dll & CQSPI_REG_PHY_CONFIG_TX_DEL_MASK)
+		<< CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) |
+	       CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+}
+
+static int cqspi_resync_dll(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+	int ret;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg &= ~(CQSPI_REG_PHY_CONFIG_DLL_RESET | CQSPI_REG_PHY_CONFIG_RESYNC);
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg &= ~(CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_MASK
+		 << CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB);
+	reg |= (CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_VAL
+		<< CQSPI_REG_PHY_DLL_MASTER_INIT_DELAY_LSB);
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_DLL_RESET;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_DLL_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		goto re_enable;
+
+	ret = readl_poll_timeout(reg_base + CQSPI_REG_DLL_OBS_LOW, reg,
+				 (reg & CQSPI_REG_DLL_OBS_LOW_LOOPBACK_LOCK), 0,
+				 CQSPI_DLL_TIMEOUT_US);
+	if (ret)
+		goto re_enable;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+	reg |= CQSPI_REG_PHY_CONFIG_RESYNC;
+	writel(reg, reg_base + CQSPI_REG_PHY_CONFIG);
+
+re_enable:
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	return ret;
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1322,8 +1480,9 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
-				       f_pdata->read_delay);
+		if (!cqspi->phy_tuning_active)
+			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+					       f_pdata->read_delay);
 	}
 
 	if (switch_cs || switch_ck)
@@ -1558,10 +1717,1572 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdata,
+					struct spi_mem *mem,
+					const struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	struct spi_mem_op op = *write_op;
+	int ret;
+
+	op.max_freq = mem->spi->max_speed_hz;
+	op.data.nbytes = sizeof(phy_tuning_pattern);
+	op.data.buf.out = phy_tuning_pattern;
+
+	ret = ctlr->mem_ops->exec_op(mem, &op);
+	if (ret) {
+		dev_err(dev, "Failed to write PHY pattern to cache: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(dev, "PHY pattern (%zu bytes) written to cache\n",
+		sizeof(phy_tuning_pattern));
+
+	return 0;
+}
+
+static int cqspi_phy_check_pattern(struct cqspi_flash_pdata *f_pdata,
+				   struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_op op;
+	u8 *read_data;
+	int ret;
+
+	read_data = kmalloc_array(ARRAY_SIZE(phy_tuning_pattern),
+				  sizeof(phy_tuning_pattern[0]), GFP_KERNEL);
+	if (!read_data)
+		return -ENOMEM;
+
+	op = f_pdata->phy_read_op;
+	op.data.buf.in = read_data;
+	op.data.nbytes = sizeof(phy_tuning_pattern);
+
+	ret = ctlr->mem_ops->exec_op(mem, &op);
+	if (ret)
+		goto out;
+
+	if (memcmp(read_data, phy_tuning_pattern, sizeof(phy_tuning_pattern)))
+		ret = -EAGAIN;
+
+out:
+	kfree(read_data);
+	return ret;
+}
+
+static void cqspi_phy_set_dll_master(struct cqspi_st *cqspi)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_PHY_DLL_MASTER);
+	reg &= ~((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LEN
+		  << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		 CQSPI_REG_PHY_DLL_MASTER_BYPASS |
+		 CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+	reg |= ((CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_3
+		 << CQSPI_REG_PHY_DLL_MASTER_DLY_ELMTS_LSB) |
+		CQSPI_REG_PHY_DLL_MASTER_CYCLE);
+
+	writel(reg, reg_base + CQSPI_REG_PHY_DLL_MASTER);
+}
+
+static void cqspi_phy_pre_config(struct cqspi_st *cqspi,
+				 struct cqspi_flash_pdata *f_pdata,
+				 const bool bypass)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	cqspi->phy_tuning_active = true;
+
+	cqspi_readdata_capture(cqspi, bypass, f_pdata->use_dqs,
+			       f_pdata->phy_setting.read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	reg |= CQSPI_REG_CONFIG_PHY_EN;
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	cqspi_phy_set_dll_master(cqspi);
+}
+
+static void cqspi_phy_post_config(struct cqspi_st *cqspi,
+				  const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	cqspi->phy_tuning_active = false;
+
+	/*
+	 * Clear the EDGE bit set by cqspi_phy_apply_setting, then restore the
+	 * READCAPTURE register to its non-PHY state (bypass, DQS, and delay).
+	 */
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+	reg &= ~BIT(CQSPI_REG_READCAPTURE_EDGE_LSB);
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false, delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
+static int cqspi_phy_apply_setting(struct cqspi_flash_pdata *f_pdata,
+				   struct cqspi_phy_setting *phy)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	unsigned int reg;
+	int ret;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_READCAPTURE);
+	reg |= BIT(CQSPI_REG_READCAPTURE_EDGE_LSB);
+	writel(reg, cqspi->iobase + CQSPI_REG_READCAPTURE);
+
+	cqspi_set_dll(cqspi->iobase, phy->rx, phy->tx);
+
+	ret = cqspi_resync_dll(cqspi);
+	if (ret)
+		return ret;
+
+	f_pdata->dll_locked = true;
+	f_pdata->phy_setting.rx = phy->rx;
+	f_pdata->phy_setting.tx = phy->tx;
+	f_pdata->phy_setting.read_delay = phy->read_delay;
+
+	cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+			       phy->read_delay);
+
+	return 0;
+}
+
+static int cqspi_find_rx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct cqspi_phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx <= CQSPI_PHY_RX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_low_sdr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct cqspi_phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = 0;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx++;
+	} while (phy->rx <= CQSPI_PHY_MAX_DELAY);
+
+	dev_dbg(dev, "Unable to find RX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct cqspi_phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->rx = CQSPI_PHY_RX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->rx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->rx >= CQSPI_PHY_RX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_rx_high_sdr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct cqspi_phy_setting *phy,
+				  u8 lowerbound)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	phy->rx = CQSPI_PHY_MAX_DELAY;
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, phy);
+		if (!ret) {
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+			if (!ret)
+				return 0;
+		}
+		phy->rx--;
+	} while (phy->rx >= lowerbound);
+
+	dev_dbg(dev, "Unable to find RX high\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_low_ddr(struct cqspi_flash_pdata *f_pdata,
+				 struct spi_mem *mem, struct cqspi_phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_LOW_SEARCH_START;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx += CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx <= CQSPI_PHY_TX_LOW_SEARCH_END);
+
+		phy->read_delay++;
+	} while (phy->read_delay <= CQSPI_PHY_MAX_RD);
+
+	dev_dbg(dev, "Unable to find TX low\n");
+	return -ENOENT;
+}
+
+static int cqspi_find_tx_high_ddr(struct cqspi_flash_pdata *f_pdata,
+				  struct spi_mem *mem, struct cqspi_phy_setting *phy)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	do {
+		phy->tx = CQSPI_PHY_TX_HIGH_SEARCH_END;
+		do {
+			ret = cqspi_phy_apply_setting(f_pdata, phy);
+			if (!ret) {
+				ret = cqspi_phy_check_pattern(f_pdata, mem);
+				if (!ret)
+					return 0;
+			}
+
+			phy->tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (phy->tx >= CQSPI_PHY_TX_HIGH_SEARCH_START);
+
+		phy->read_delay--;
+	} while (phy->read_delay >= CQSPI_PHY_INIT_RD);
+
+	dev_dbg(dev, "Unable to find TX high\n");
+	return -ENOENT;
+}
+
+static void cqspi_phy_find_gaplow_ddr(struct cqspi_flash_pdata *f_pdata,
+				      struct spi_mem *mem,
+				      struct cqspi_phy_setting *bottomleft,
+				      struct cqspi_phy_setting *topright,
+				      struct cqspi_phy_setting *gaplow)
+{
+	struct cqspi_phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = left.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaplow = mid;
+}
+
+static void cqspi_phy_find_gaphigh_ddr(struct cqspi_flash_pdata *f_pdata,
+				       struct spi_mem *mem,
+				       struct cqspi_phy_setting *bottomleft,
+				       struct cqspi_phy_setting *topright,
+				       struct cqspi_phy_setting *gaphigh)
+{
+	struct cqspi_phy_setting left, right, mid;
+	int ret;
+
+	left = *bottomleft;
+	right = *topright;
+
+	mid.tx = left.tx + ((right.tx - left.tx) / 2);
+	mid.rx = left.rx + ((right.rx - left.rx) / 2);
+	mid.read_delay = right.read_delay;
+
+	do {
+		ret = cqspi_phy_apply_setting(f_pdata, &mid);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+		if (ret) {
+			/* The pattern was not found. Go to the upper half. */
+			left.tx = mid.tx;
+			left.rx = mid.rx;
+
+			mid.tx = mid.tx + ((right.tx - mid.tx) / 2);
+			mid.rx = mid.rx + ((right.rx - mid.rx) / 2);
+		} else {
+			/* The pattern was found. Go to the lower half. */
+			right.tx = mid.tx;
+			right.rx = mid.rx;
+
+			mid.tx = left.tx + ((mid.tx - left.tx) / 2);
+			mid.rx = left.rx + ((mid.rx - left.rx) / 2);
+		}
+
+		/* Break the loop if the window has closed. */
+	} while ((right.tx - left.tx >= 2) && (right.rx - left.rx >= 2));
+
+	*gaphigh = mid;
+}
+
+static int cqspi_get_temp(int *temp)
+{
+	/* TODO: read SoC thermal sensor; caller falls back to room temperature */
+	return -EOPNOTSUPP;
+}
+
+static inline void cqspi_phy_reset_setting(struct cqspi_phy_setting *phy)
+{
+	*phy = (struct cqspi_phy_setting){ .rx = 0, .tx = 127, .read_delay = 0 };
+}
+
+static int cqspi_phy_tuning_ddr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct cqspi_phy_setting rxlow, rxhigh, txlow, txhigh;
+	struct cqspi_phy_setting srxlow, srxhigh;
+	struct cqspi_phy_setting bottomleft, topright, searchpoint;
+	struct cqspi_phy_setting gaplow, gaphigh;
+	struct cqspi_phy_setting backuppoint, backupcornerpoint;
+	int ret, rx_window, temp;
+	bool primary = true, secondary = true;
+
+	/*
+	 * DDR tuning: 2D search across RX and TX delays for optimal timing.
+	 *
+	 * Algorithm: Find RX boundaries (rxlow/rxhigh) using TX window search,
+	 * find TX boundaries (txlow/txhigh) at fixed RX, define valid region,
+	 * locate gaps via binary search, select final point with temperature
+	 * compensation.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *
+	 *              |  bottomleft
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 */
+
+	f_pdata->use_tuned_phy = true;
+
+	/* Golden rxlow search: Find lower RX boundary using TX window sweep */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       |xxxxx|xxxxx     +++++++++++++
+	 *              |       |xxxxx|xxxxxx     ++++++++++++
+	 *      search  |       |xxxxx|xxxxxxx     +++++++++++
+	 *      rxlow --------->|xxxxx|xxxxxxxx     ++++++++++
+	 *              |       |xxxxx|xxxxxxxxx     +++++++++
+	 *              |       |xxxxx|xxxxxxxxxx     ++++++++
+	 *              |       |xxxxx|xxxxxxxxxxx     +++++++
+	 *              |       |     |
+	 *              --------|-----|----------------------------> tx
+	 *              0       |     |                          127
+	 *                  txlow     txlow
+	 *                  start     end
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | rx = min(primary.rx, secondary.rx) |
+	 *      |         |           | tx = primary.tx                    |
+	 *      |         |           | read_delay =                       |
+	 *      |         |           |         min(primary.read_delay,    |
+	 *      |         |           |             secondary.read_delay)  |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxlow: Sweep TX window to find valid RX lower bound */
+
+	rxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_START;
+	do {
+		dev_dbg(dev, "Searching for Golden Primary rxlow on TX = %d\n",
+			rxlow.tx);
+		rxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &rxlow);
+		if (!ret)
+			break;
+		rxlow.tx += CQSPI_PHY_DDR_SEARCH_STEP;
+	} while (rxlow.tx <= CQSPI_PHY_TX_LOOKUP_LOW_END);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Primary rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Secondary rxlow: Verify at offset TX for robustness */
+
+	if (rxlow.tx <= (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxlow.tx = rxlow.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxlow.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxlow on TX = %d\n",
+		srxlow.tx);
+	srxlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden Secondary rxlow: RX: %d TX: %d RD: %d\n",
+		srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+	rxlow.rx = min(rxlow.rx, srxlow.rx);
+	rxlow.read_delay = min(rxlow.read_delay, srxlow.read_delay);
+	dev_dbg(dev, "Golden Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+		rxlow.tx, rxlow.read_delay);
+
+	/* Golden rxhigh search: Find upper RX boundary at fixed TX */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |       |xxxx     ++++++++++++++++++++
+	 *              |       |xxxxx     +++++++++++++++++++
+	 *    search    |       |xxxxxx     ++++++++++++++++++
+	 *    rxhigh  --------->|xxxxxxx     +++++++++++++++++
+	 *    on fixed  |       |xxxxxxxx     ++++++++++++++++
+	 *    tx        |       |xxxxxxxxx     +++++++++++++++
+	 *              |       |xxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |
+	 *              -------------------------------------------> tx
+	 *              0                                        127
+	 *
+	 *      |----------------------------------------------------------|
+	 *      | Primary | Secondary | Final                              |
+	 *      | Search  | Search    | Point                              |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Fail      | Return Fail                        |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Fail    | Pass      | Choose Secondary                   |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Fail      | Choose Primary                     |
+	 *      |---------|-----------|------------------------------------|
+	 *      | Pass    | Pass      | if (secondary.rx > primary.rx)     |
+	 *      |         |           |         Choose Secondary           |
+	 *      |         |           | else                               |
+	 *      |         |           |         Choose Primary             |
+	 *      |----------------------------------------------------------|
+	 */
+
+	/* Primary rxhigh: Search at rxlow's TX, decrement from max read_delay */
+
+	rxhigh.tx = rxlow.tx;
+	dev_dbg(dev, "Searching for Golden Primary rxhigh on TX = %d\n",
+		rxhigh.tx);
+	rxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &rxhigh);
+	if (ret)
+		primary = false;
+	dev_dbg(dev, "Golden Primary rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	/* Secondary rxhigh: Verify at offset TX */
+
+	if (rxhigh.tx <=
+	    (CQSPI_PHY_TX_LOOKUP_LOW_END - CQSPI_PHY_SEARCH_OFFSET))
+		srxhigh.tx = rxhigh.tx + CQSPI_PHY_SEARCH_OFFSET;
+	else
+		srxhigh.tx = CQSPI_PHY_TX_LOOKUP_LOW_END;
+	dev_dbg(dev, "Searching for Golden Secondary rxhigh on TX = %d\n",
+		srxhigh.tx);
+	srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+	if (ret)
+		secondary = false;
+	dev_dbg(dev, "Golden Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+		srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+	if (!primary && !secondary)
+		goto out;
+	else if (!primary)
+		rxhigh = srxhigh;
+	else if (secondary && srxhigh.rx > rxhigh.rx)
+		rxhigh = srxhigh;
+	dev_dbg(dev, "Golden Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+		rxhigh.tx, rxhigh.read_delay);
+
+	primary = true;
+	secondary = true;
+
+	/* If rxlow/rxhigh at same read_delay, search backup at upper TX range */
+
+	if (rxlow.read_delay == rxhigh.read_delay) {
+		dev_dbg(dev, "rxlow and rxhigh at the same read delay.\n");
+
+		/* Backup rxlow: Search at high TX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *              |       xxxxxxx     ++++++++++++++++++
+		 *              |       xxxxxxxx     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++|++++|
+		 *              |       xxxxxxxxxxxxx     ++++++|++++|
+		 *      search  |       xxxxxxxxxxxxxx     +++++|++++|
+		 *      rxlow --------------------------------->|++++|
+		 *              |       xxxxxxxxxxxxxxxx     +++|++++|
+		 *              |       xxxxxxxxxxxxxxxxx     ++|++++|
+		 *              |       xxxxxxxxxxxxxxxxxx     +|++++|
+		 *              |                               |    |
+		 *              --------------------------------|----|-----> tx
+		 *              0                               |    |   127
+		 *                                         txhigh    txhigh
+		 *                                          start    end
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | rx =                          |
+		 *      |         |           |  min(primary.rx, secondary.rx)|
+		 *      |         |           | tx = primary.tx               |
+		 *      |         |           | read_delay =                  |
+		 *      |         |           |  min(primary.read_delay,      |
+		 *      |         |           |      secondary.read_delay)    |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup: Decrement TX from high window end */
+
+		backuppoint.tx = CQSPI_PHY_TX_LOOKUP_HIGH_END;
+		do {
+			dev_dbg(dev,
+				"Searching for Backup Primary rxlow on TX = %d\n",
+				backuppoint.tx);
+			backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+			ret = cqspi_find_rx_low_ddr(f_pdata, mem, &backuppoint);
+			if (!ret)
+				break;
+			backuppoint.tx -= CQSPI_PHY_DDR_SEARCH_STEP;
+		} while (backuppoint.tx >= CQSPI_PHY_TX_LOOKUP_HIGH_START);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Primary rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxlow.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxlow.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxlow on TX = %d\n",
+			srxlow.tx);
+		srxlow.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_rx_low_ddr(f_pdata, mem, &srxlow);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup Secondary rxlow: RX: %d TX: %d RD: %d\n",
+			srxlow.rx, srxlow.tx, srxlow.read_delay);
+
+		backuppoint.rx = min(backuppoint.rx, srxlow.rx);
+		backuppoint.read_delay =
+			min(backuppoint.read_delay, srxlow.read_delay);
+		dev_dbg(dev, "Backup Final rxlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx < rxlow.rx) {
+			rxlow = backuppoint;
+			dev_dbg(dev, "Updating rxlow to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxlow: RX: %d TX: %d RD: %d\n", rxlow.rx,
+			rxlow.tx, rxlow.read_delay);
+
+		/* Backup rxhigh: Search at fixed backup TX */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |       xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx     ++++++++++++++++++|
+		 *    search    |       xxxxxxx     +++++++++++++++++|
+		 *    rxhigh  -------------------------------------->|
+		 *    on fixed  |       xxxxxxxxx     +++++++++++++++|
+		 *    tx        |       xxxxxxxxxx     ++++++++++++++|
+		 *              |       xxxxxxxxxxx     +++++++++++++|
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *              |       xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |
+		 *              -------------------------------------------> tx
+		 *               0                                        127
+		 *
+		 *      |-----------------------------------------------------|
+		 *      | Primary | Secondary | Final                         |
+		 *      | Search  | Search    | Point                         |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Fail      | Return Fail                   |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Fail    | Pass      | Choose Secondary              |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Fail      | Choose Primary                |
+		 *      |---------|-----------|-------------------------------|
+		 *      | Pass    | Pass      | if (secondary.rx > primary.rx)|
+		 *      |         |           |         Choose Secondary      |
+		 *      |         |           | else                          |
+		 *      |         |           |         Choose Primary        |
+		 *      |-----------------------------------------------------|
+		 */
+
+		/* Primary backup rxhigh: Use backup TX, decrement from max read_delay */
+
+		dev_dbg(dev, "Searching for Backup Primary rxhigh on TX = %d\n",
+			backuppoint.tx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			primary = false;
+		dev_dbg(dev, "Backup Primary rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		/* Secondary backup rxhigh: Verify at offset TX */
+
+		if (backuppoint.tx >=
+		    (CQSPI_PHY_TX_LOOKUP_HIGH_START + CQSPI_PHY_SEARCH_OFFSET))
+			srxhigh.tx = backuppoint.tx - CQSPI_PHY_SEARCH_OFFSET;
+		else
+			srxhigh.tx = CQSPI_PHY_TX_LOOKUP_HIGH_START;
+		dev_dbg(dev,
+			"Searching for Backup Secondary rxhigh on TX = %d\n",
+			srxhigh.tx);
+		srxhigh.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_rx_high_ddr(f_pdata, mem, &srxhigh);
+		if (ret)
+			secondary = false;
+		dev_dbg(dev, "Backup Secondary rxhigh: RX: %d TX: %d RD: %d\n",
+			srxhigh.rx, srxhigh.tx, srxhigh.read_delay);
+
+		if (!primary && !secondary)
+			goto out;
+		else if (!primary)
+			backuppoint = srxhigh;
+		else if (secondary && srxhigh.rx > backuppoint.rx)
+			backuppoint = srxhigh;
+		dev_dbg(dev, "Backup Final rxhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.rx > rxhigh.rx) {
+			rxhigh = backuppoint;
+			dev_dbg(dev, "Updating rxhigh to the one at TX = %d\n",
+				backuppoint.tx);
+		}
+		dev_dbg(dev, "Final rxhigh: RX: %d TX: %d RD: %d\n", rxhigh.rx,
+			rxhigh.tx, rxhigh.read_delay);
+	}
+
+	/* Golden txlow: Fix RX at 1/4 of RX window, search TX lower bound */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w ---------><------->xxxxx     +++++++++++
+	 *    rxlow and |       xxxx|xxxxxxxxxx     ++++++++++
+	 *    rxhigh    |       xxxx|xxxxxxxxxxx     +++++++++
+	 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+	 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+	 *              |           |
+	 *              ------------|------------------------------> tx
+	 *              0           |                            127
+	 *                     search
+	 *                      txlow
+	 */
+
+	rx_window = rxhigh.rx - rxlow.rx;
+	txlow.rx = rxlow.rx + (rx_window / 4);
+	dev_dbg(dev, "Searching for Golden txlow on RX = %d\n", txlow.rx);
+	txlow.read_delay = CQSPI_PHY_INIT_RD;
+	ret = cqspi_find_tx_low_ddr(f_pdata, mem, &txlow);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txlow: RX: %d TX: %d RD: %d\n", txlow.rx, txlow.tx,
+		txlow.read_delay);
+
+	/* Golden txhigh: Same RX as txlow, decrement from max read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |
+	 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *    fix rx    |       xxxxxxxxxxxxx     ++++++++++++
+	 *    1/4 b/w --------------------------------><----->
+	 *    rxlow and |       xxxxxxxxxxxxxxx     ++++++|+++
+	 *    rxhigh    |       xxxxxxxxxxxxxxxx     +++++|+++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++|+++
+	 *      rxlow --------->xxxxxxxxxxxxxxxxxx     +++|+++
+	 *              |                                 |
+	 *              ----------------------------------|--------> tx
+	 *              0                                 |      127
+	 *                                           search
+	 *                                           txhigh
+	 */
+
+	txhigh.rx = txlow.rx;
+	dev_dbg(dev, "Searching for Golden txhigh on RX = %d\n", txhigh.rx);
+	txhigh.read_delay = CQSPI_PHY_MAX_RD;
+	ret = cqspi_find_tx_high_ddr(f_pdata, mem, &txhigh);
+	if (ret)
+		goto out;
+	dev_dbg(dev, "Golden txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+		txhigh.tx, txhigh.read_delay);
+
+	/* If txlow/txhigh at same read_delay, search backup at 3/4 RX window */
+
+	if (txlow.read_delay == txhigh.read_delay) {
+		/* Backup txlow: Fix RX at 3/4 of RX window */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ---------><----->x     +++++++++++++++++
+		 *    rxlow and |       xxxx|xxxx     ++++++++++++++++
+		 *    rxhigh    |       xxxx|xxxxx     +++++++++++++++
+		 *              |       xxxx|xxxxxx     ++++++++++++++
+		 *              |       xxxx|xxxxxxx     +++++++++++++
+		 *              |       xxxx|xxxxxxxx     ++++++++++++
+		 *              |       xxxx|xxxxxxxxx     +++++++++++
+		 *              |       xxxx|xxxxxxxxxx     ++++++++++
+		 *              |       xxxx|xxxxxxxxxxx     +++++++++
+		 *              |       xxxx|xxxxxxxxxxxx     ++++++++
+		 *      rxlow --------->xxxx|xxxxxxxxxxxxx     +++++++
+		 *              |           |
+		 *              ------------|------------------------------> tx
+		 *              0           |                            127
+		 *                     search
+		 *                      txlow
+		 */
+
+		dev_dbg(dev, "txlow and txhigh at the same read delay.\n");
+		backuppoint.rx = rxlow.rx + ((rx_window * 3) / 4);
+		dev_dbg(dev, "Searching for Backup txlow on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_INIT_RD;
+		ret = cqspi_find_tx_low_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txlow: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx < txlow.tx) {
+			txlow = backuppoint;
+			dev_dbg(dev, "Updating txlow with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txlow: RX: %d TX: %d RD: %d\n", txlow.rx,
+			txlow.tx, txlow.read_delay);
+
+		/* Backup txhigh: Same RX as backup txlow, decrement from max */
+
+		/*
+		 *              rx
+		 *          127 ^
+		 *              |
+		 *     rxhigh --------->xxxxx     ++++++++++++++++++++
+		 *              |       xxxxxx     +++++++++++++++++++
+		 *    fix rx    |       xxxxxxx     ++++++++++++++++++
+		 *    3/4 b/w ------------------------------><------->
+		 *    rxlow and |       xxxxxxxxx     +++++++++++|++++
+		 *    rxhigh    |       xxxxxxxxxx     ++++++++++|++++
+		 *              |       xxxxxxxxxxx     +++++++++|++++
+		 *              |       xxxxxxxxxxxx     ++++++++|++++
+		 *              |       xxxxxxxxxxxxx     +++++++|++++
+		 *              |       xxxxxxxxxxxxxx     ++++++|++++
+		 *              |       xxxxxxxxxxxxxxx     +++++|++++
+		 *              |       xxxxxxxxxxxxxxxx     ++++|++++
+		 *              |       xxxxxxxxxxxxxxxxx     +++|++++
+		 *      rxlow --------->xxxxxxxxxxxxxxxxxx     ++|++++
+		 *              |                                |
+		 *              ---------------------------------|---------> tx
+		 *              0                                |       127
+		 *                                               search
+		 *                                               txhigh
+		 */
+
+		dev_dbg(dev, "Searching for Backup txhigh on RX = %d\n",
+			backuppoint.rx);
+		backuppoint.read_delay = CQSPI_PHY_MAX_RD;
+		ret = cqspi_find_tx_high_ddr(f_pdata, mem, &backuppoint);
+		if (ret)
+			goto out;
+		dev_dbg(dev, "Backup txhigh: RX: %d TX: %d RD: %d\n",
+			backuppoint.rx, backuppoint.tx, backuppoint.read_delay);
+
+		if (backuppoint.tx > txhigh.tx) {
+			txhigh = backuppoint;
+			dev_dbg(dev,
+				"Updating txhigh with the one at RX = %d\n",
+				backuppoint.rx);
+		}
+		dev_dbg(dev, "Final txhigh: RX: %d TX: %d RD: %d\n", txhigh.rx,
+			txhigh.tx, txhigh.read_delay);
+	}
+
+	/* Corner points: Define and verify bottomleft and topright boundaries */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |                                 topright
+	 *              |                                    *
+	 *    rxhigh -----------xxxxx     ++++++++++++++++++++
+	 *              |       xxxxxx     +++++++++++++++++++
+	 *              |       xxxxxxx     ++++++++++++++++++
+	 *              |       xxxxxxxx     +++++++++++++++++
+	 *              |       xxxxxxxxx     ++++++++++++++++
+	 *              |       xxxxxxxxxx     +++++++++++++++
+	 *              |       xxxxxxxxxxx     ++++++++++++++
+	 *              |       xxxxxxxxxxxx     +++++++++++++
+	 *              |       xxxxxxxxxxxxx     ++++++++++++
+	 *              |       xxxxxxxxxxxxxx     +++++++++++
+	 *              |       xxxxxxxxxxxxxxx     ++++++++++
+	 *              |       xxxxxxxxxxxxxxxx     +++++++++
+	 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+	 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+	 *              |       *                            |
+	 *              | bottom|left                        |
+	 *              --------|----------------------------|---> tx
+	 *              0       |                            | 127
+	 *                      |                            |
+	 *                      txlow                   txhigh
+	 *
+	 * Verification: Test point 4 taps inside each corner, adjust
+	 * read_delay ±1 if needed to ensure valid corners for gap search.
+	 */
+
+	bottomleft.tx = txlow.tx;
+	bottomleft.rx = rxlow.rx;
+	if (txlow.read_delay <= rxlow.read_delay)
+		bottomleft.read_delay = txlow.read_delay;
+	else
+		bottomleft.read_delay = rxlow.read_delay;
+
+	/* Verify bottomleft: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = bottomleft;
+	backupcornerpoint.tx += 4;
+	backupcornerpoint.rx += 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay--;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	if (ret)
+		goto out;
+
+	bottomleft.read_delay = backupcornerpoint.read_delay;
+
+	topright.tx = txhigh.tx;
+	topright.rx = rxhigh.rx;
+	if (txhigh.read_delay >= rxhigh.read_delay)
+		topright.read_delay = txhigh.read_delay;
+	else
+		topright.read_delay = rxhigh.read_delay;
+
+	/* Verify topright: Test 4 taps inside, adjust read_delay if needed */
+	backupcornerpoint = topright;
+	backupcornerpoint.tx -= 4;
+	backupcornerpoint.rx -= 4;
+	ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		backupcornerpoint.read_delay++;
+		ret = cqspi_phy_apply_setting(f_pdata, &backupcornerpoint);
+		if (!ret)
+			ret = cqspi_phy_check_pattern(f_pdata, mem);
+	}
+
+	if (ret)
+		goto out;
+
+	topright.read_delay = backupcornerpoint.read_delay;
+
+	dev_dbg(dev, "topright: RX: %d TX: %d RD: %d\n", topright.rx,
+		topright.tx, topright.read_delay);
+	dev_dbg(dev, "bottomleft: RX: %d TX: %d RD: %d\n", bottomleft.rx,
+		bottomleft.tx, bottomleft.read_delay);
+	cqspi_phy_find_gaplow_ddr(f_pdata, mem, &bottomleft, &topright, &gaplow);
+	dev_dbg(dev, "gaplow: RX: %d TX: %d RD: %d\n", gaplow.rx, gaplow.tx,
+		gaplow.read_delay);
+
+	/* Final point selection: Handle single vs dual passing regions */
+
+	if (bottomleft.read_delay == topright.read_delay) {
+		/*
+		 * Single region: Use midpoint with temperature compensation.
+		 * Gaplow approximates upper boundary of valid region.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |              gaplow (approx. topright)
+		 *              |              |
+		 *    rxhigh -----------xxxxxxx|          failing
+		 *              |       xxxxxxx|           region
+		 *              |       xxxxxxx|     <--------------->
+		 *              |       xxxxxxx|     +++++++++++++++++
+		 *              |       xxxxxxxxx     ++++++++++++++++
+		 *              |       xxxxxxxxxx     +++++++++++++++
+		 *              |       xxxxxxxxxxx     ++++++++++++++
+		 *              |       xxxxxxxxxxxx     +++++++++++++
+		 *              |       xxxxxxxxxxxxx     ++++++++++++
+		 *              |       xxxxxxxxxxxxxx     +++++++++++
+		 *              |       xxxxxxxxxxxxxxx     ++++++++++
+		 *              |       xxxxxxxxxxxxxxxx     +++++++++
+		 *              |       xxxxxxxxxxxxxxxxx     ++++++++
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     +++++++
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *                             (same read_delay)
+		 *
+		 * Temperature compensation: Valid region shifts with temp.
+		 * Offset = region_size / (330 / (temp - 42°C))
+		 * Factor 330 is empirically determined for this hardware.
+		 */
+
+		dev_dbg(dev,
+			"bottomleft and topright at the same read delay.\n");
+
+		topright = gaplow;
+		searchpoint.read_delay = bottomleft.read_delay;
+		searchpoint.tx =
+			bottomleft.tx + ((topright.tx - bottomleft.tx) / 2);
+		searchpoint.rx =
+			bottomleft.rx + ((topright.rx - bottomleft.rx) / 2);
+
+		ret = cqspi_get_temp(&temp);
+		if (ret) {
+			/* Assume room temperature if sensor unavailable */
+			dev_dbg(dev,
+				"Unable to get temperature. Assuming room temperature\n");
+			temp = CQSPI_PHY_DEFAULT_TEMP;
+		}
+
+		if (temp < CQSPI_PHY_MIN_TEMP || temp > CQSPI_PHY_MAX_TEMP) {
+			dev_err(dev,
+				"Temperature outside operating range: %dC\n",
+				temp);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (temp == CQSPI_PHY_MID_TEMP)
+			temp++; /* Avoid divide-by-zero */
+		dev_dbg(dev, "Temperature: %dC\n", temp);
+
+		/*
+		 * Apply temperature offset: positive at high temp, negative at low.
+		 * Compute the divisor once and apply to both TX and RX. Use int
+		 * arithmetic throughout to avoid u8 wrapping on negative offsets.
+		 */
+		temp = 330 / (temp - CQSPI_PHY_MID_TEMP);
+		searchpoint.tx = clamp((int)searchpoint.tx +
+				       (topright.tx - bottomleft.tx) / temp,
+				       0, CQSPI_PHY_MAX_DELAY);
+		searchpoint.rx = clamp((int)searchpoint.rx +
+				       (topright.rx - bottomleft.rx) / temp,
+				       0, CQSPI_PHY_MAX_DELAY);
+	} else {
+		/*
+		 * Dual regions: Gap separates two valid regions, choose larger.
+		 *
+		 *              rx
+		 *          127 ^
+		 *              |                                 topright
+		 *              |                                    *
+		 *    rxhigh -----------xxxxx     +++++++++++++++++++|
+		 *              |       xxxxxx    <region 2> ++++++++|
+		 *              |       xxxxxxx     +++++++++++++++++|
+		 *              |       xxxxxxxx     ++++++++++++++++|
+		 *              |       xxxxxxxxx     +++++++++++++++|
+		 *              |       xxxxxxxxxx     ++++++++++++++|
+		 *              |                  failing           |
+		 *              |                  region            |
+		 *              |       xxxxxxxxxxxxx     +++++++++++|
+		 *              |       xxxxxxxxxxxxxx     ++++++++++|
+		 *              |       xxxxxxxxxxxxxxx     +++++++++|
+		 *              |       xxxxxxxxxxxxxxxx     ++++++++|
+		 *              |       xxxxxxxxx <region 1>  +++++++|
+		 *     rxlow -----------xxxxxxxxxxxxxxxxxx     ++++++|
+		 *              |       *                            |
+		 *              | bottom|left                        |
+		 *              --------|----------------------------|---> tx
+		 *              0       |                            | 127
+		 *                      |                            |
+		 *                      txlow                   txhigh
+		 *
+		 * Strategy: Compare Manhattan distances from gap boundaries to
+		 * corners. Choose corner furthest from gap (larger region).
+		 * Apply 16-tap margin inward, scale RX proportionally.
+		 */
+
+		cqspi_phy_find_gaphigh_ddr(f_pdata, mem, &bottomleft,
+					   &topright, &gaphigh);
+		dev_dbg(dev, "gaphigh: RX: %d TX: %d RD: %d\n", gaphigh.rx,
+			gaphigh.tx, gaphigh.read_delay);
+
+		if (topright.tx == bottomleft.tx) {
+			dev_err(dev, "zero TX span in dual-region: cannot compute search point\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Compare Manhattan distances: choose corner furthest from gap */
+		if ((abs(gaplow.tx - bottomleft.tx) +
+		     abs(gaplow.rx - bottomleft.rx)) <
+		    (abs(gaphigh.tx - topright.tx) +
+		     abs(gaphigh.rx - topright.rx))) {
+			/* Topright further: Use Region 2, 16 taps inward */
+			searchpoint = topright;
+			searchpoint.tx = clamp((int)topright.tx - 16,
+					       0, CQSPI_PHY_MAX_DELAY);
+			searchpoint.rx = clamp((int)topright.rx -
+					       (16 * (topright.rx - bottomleft.rx)) /
+					       (topright.tx - bottomleft.tx),
+					       0, CQSPI_PHY_MAX_DELAY);
+		} else {
+			/* Bottomleft further: Use Region 1, 16 taps inward */
+			searchpoint = bottomleft;
+			searchpoint.tx = clamp((int)bottomleft.tx + 16,
+					       0, CQSPI_PHY_MAX_DELAY);
+			searchpoint.rx = clamp((int)bottomleft.rx +
+					       (16 * (topright.rx - bottomleft.rx)) /
+					       (topright.tx - bottomleft.tx),
+					       0, CQSPI_PHY_MAX_DELAY);
+		}
+	}
+
+	/* Apply and verify final tuning point */
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n",
+		searchpoint.rx, searchpoint.tx, searchpoint.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &searchpoint);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		dev_err(dev,
+			"Failed to find pattern at final calibration point\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	f_pdata->phy_setting.read_delay = searchpoint.read_delay;
+	f_pdata->phy_setting.rx = searchpoint.rx;
+	f_pdata->phy_setting.tx = searchpoint.tx;
+out:
+	if (ret)
+		f_pdata->use_tuned_phy = false;
+
+	return ret;
+}
+
+static int cqspi_phy_tuning_sdr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	struct device *dev = &cqspi->pdev->dev;
+	struct cqspi_phy_setting rxlow, rxhigh, first, second, final;
+	u8 window1 = 0;
+	u8 window2 = 0;
+	int ret;
+
+	/*
+	 * SDR tuning: 1D search for optimal RX delay (TX less critical).
+	 * Find two consecutive windows, choose larger, use midpoint.
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----window at----------|
+	 *              |        |-----read_delay = n+1---|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow(n+1)   midpoint    rxhigh(n+1)
+	 *              |
+	 *              |   |---window at--------|
+	 *              |   |---read_delay = n---|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *              |   rxlow(n)   midpoint  rxhigh(n)
+	 *              |
+	 *              -----------------------------------------> tx
+	 *              0                                      127
+	 *                  read_delay=n                  read_delay=n+1
+	 */
+
+	f_pdata->use_tuned_phy = true;
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&first);
+
+	/* First window: Find rxlow by incrementing read_delay from 0 */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  search      |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  rxlow       |   |xxxxxxxxxxxxxxxxxxxx|
+	 *  increasing  |   |xxxxxxxxxxxxxxxxxxxx|
+	 *           --------->|xxxxxxxxxxxxxxxxxxxx|
+	 *  read_delay  |        |xxxxxxxxxxxxxxxxxxx|
+	 *  until found |        |xxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	do {
+		ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+
+		if (ret)
+			rxlow.read_delay++;
+	} while (ret && rxlow.read_delay <= CQSPI_PHY_MAX_RD);
+
+	if (ret)
+		goto out;
+
+	/* Find rxhigh: Decrement from RX=127 at same read_delay */
+
+	/*
+	 *              rx
+	 *          127 ^        search rxhigh
+	 *              |        (decrement from
+	 *              |        127 until found)
+	 *              |          |
+	 *              |          |
+	 *              |          v
+	 *              |        |------------------------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow                    rxhigh
+	 *              -----------------------------------------> tx
+	 *              0                            tx fixed at 127
+	 */
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto out;
+
+	/* Calculate first window midpoint for max margin */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window1---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window1/2
+	 */
+
+	first.read_delay = rxlow.read_delay;
+	window1 = rxhigh.rx - rxlow.rx;
+	first.rx = rxlow.rx + (window1 / 2);
+
+	dev_dbg(dev, "First tuning point: RX: %d TX: %d RD: %d\n", first.rx,
+		first.tx, first.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &first);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || first.read_delay > CQSPI_PHY_MAX_RD)
+		goto out;
+
+	/* Second window: Search at read_delay+1, may differ in size */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |-------|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        |xxxxxxx|
+	 *              |        rxlow   rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n (smaller window)
+	 *
+	 *              rx
+	 *          127 ^
+	 *              |        |-----------------|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxx|
+	 *              |        rxlow             rxhigh
+	 *              -----------------------------------------> tx
+	 *              0
+	 *              read_delay = n+1 (larger window - better)
+	 */
+
+	cqspi_phy_reset_setting(&rxlow);
+	cqspi_phy_reset_setting(&rxhigh);
+	cqspi_phy_reset_setting(&second);
+
+	rxlow.read_delay = first.read_delay + 1;
+	if (rxlow.read_delay > CQSPI_PHY_MAX_RD)
+		goto compare;
+
+	ret = cqspi_find_rx_low_sdr(f_pdata, mem, &rxlow);
+	if (ret)
+		goto compare;
+
+	rxhigh.read_delay = rxlow.read_delay;
+	ret = cqspi_find_rx_high_sdr(f_pdata, mem, &rxhigh, rxlow.rx);
+	if (ret)
+		goto compare;
+
+	/* Calculate second window midpoint */
+
+	/*
+	 *              rx
+	 *          127 ^
+	 *              |        |--------window2---------|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxx * xxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        |xxxxxxxxxxxxxxxxxxxxxxxx|
+	 *              |        rxlow        ^           rxhigh
+	 *              ----------------------|------------------> tx
+	 *              0                     |      tx fixed at 127
+	 *                            window2/2
+	 *              read_delay = n+1
+	 */
+
+	window2 = rxhigh.rx - rxlow.rx;
+	second.rx = rxlow.rx + (window2 / 2);
+	second.read_delay = rxlow.read_delay;
+
+	dev_dbg(dev, "Second tuning point: RX: %d TX: %d RD: %d\n", second.rx,
+		second.tx, second.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &second);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret || second.read_delay > CQSPI_PHY_MAX_RD)
+		window2 = 0;
+
+	/* Window comparison: Choose larger window for better margin */
+
+compare:
+	cqspi_phy_reset_setting(&final);
+	if (window2 > window1) {
+		final.rx = second.rx;
+		final.read_delay = second.read_delay;
+	} else {
+		final.rx = first.rx;
+		final.read_delay = first.read_delay;
+	}
+
+	/* Apply and verify final tuning point */
+
+	dev_dbg(dev, "Final tuning point: RX: %d TX: %d RD: %d\n", final.rx,
+		final.tx, final.read_delay);
+	ret = cqspi_phy_apply_setting(f_pdata, &final);
+	if (!ret)
+		ret = cqspi_phy_check_pattern(f_pdata, mem);
+
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	f_pdata->phy_setting.read_delay = final.read_delay;
+	f_pdata->phy_setting.rx = final.rx;
+	f_pdata->phy_setting.tx = final.tx;
+
+out:
+	if (ret)
+		f_pdata->use_tuned_phy = false;
+
+	return ret;
+}
+
+static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
+					   struct spi_mem_op *read_op,
+					   struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct cqspi_flash_pdata *f_pdata;
+	struct device *dev = &cqspi->pdev->dev;
+	int ret = 0;
+
+	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
+
+	/*
+	 * spi-max-post-config-frequency-hz must be present for PHY tuning.
+	 * If absent, post_config_max_speed_hz is zero and there is no
+	 * calibration target, so skip tuning gracefully.
+	 */
+	if (!mem->spi->post_config_max_speed_hz) {
+		dev_dbg(dev,
+			"No post-config frequency configured, skipping tuning\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (write_op) {
+		/*
+		 * For NAND: write the calibration pattern to the page cache.
+		 * The write op runs at the conservative base speed (spi->max_speed_hz)
+		 * so the write itself is reliable before PHY calibration.
+		 */
+		ret = cqspi_write_pattern_to_cache(f_pdata, mem, write_op);
+		if (ret) {
+			dev_warn(dev,
+				 "failed to write pattern to cache: %d, skipping tuning\n",
+				 ret);
+			goto out;
+		}
+
+		f_pdata->phy_write_op = *write_op;
+	} else {
+		if (!f_pdata->phy_pattern_partition_valid) {
+			dev_warn(dev, "pattern partition not found, skipping tuning\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/*
+	 * Build the read op template for pattern verification.  For NOR, point
+	 * at the pre-programmed pattern partition rather than the caller's
+	 * address without altering the caller's template.
+	 */
+	f_pdata->phy_read_op = *read_op;
+	if (!write_op)
+		f_pdata->phy_read_op.addr.val =
+			f_pdata->phy_pattern_partition_offset;
+
+	f_pdata->phy_read_op.max_freq = mem->spi->max_speed_hz;
+
+	ret = cqspi_phy_check_pattern(f_pdata, mem);
+	if (ret) {
+		dev_err(dev, "pattern not found: %d, skipping tuning\n", ret);
+		goto out;
+	}
+
+	f_pdata->phy_read_op.max_freq = mem->spi->post_config_max_speed_hz;
+
+	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	    read_op->data.dtr) {
+		f_pdata->use_dqs = true;
+		cqspi_phy_pre_config(cqspi, f_pdata, false);
+		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
+	} else {
+		f_pdata->use_dqs = false;
+		cqspi_phy_pre_config(cqspi, f_pdata, true);
+		ret = cqspi_phy_tuning_sdr(f_pdata, mem);
+	}
+
+	if (ret)
+		dev_warn(dev, "tuning failed: %d\n", ret);
+
+	cqspi_phy_post_config(cqspi, f_pdata->read_delay);
+
+out:
+	if (!ret) {
+		read_op->max_freq = mem->spi->post_config_max_speed_hz;
+		if (write_op) {
+			write_op->max_freq = mem->spi->post_config_max_speed_hz;
+			f_pdata->phy_write_op.max_freq =
+				mem->spi->post_config_max_speed_hz;
+		}
+	}
+
+	return ret;
+}
+
+static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
+				       struct spi_mem_op *read_op,
+				       struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	if (!cqspi->ddata || !cqspi->ddata->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
 {
+	struct device_node *part_np;
+
 	if (of_property_read_u32(np, "cdns,read-delay", &f_pdata->read_delay)) {
 		dev_err(&pdev->dev, "couldn't determine read-delay\n");
 		return -ENXIO;
@@ -1587,9 +3308,15 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
-	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
-		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
-		return -ENXIO;
+	part_np = of_parse_phandle(np, "spi-phy-pattern-partition", 0);
+	if (part_np) {
+		u64 size;
+
+		f_pdata->phy_pattern_partition_valid =
+			!of_property_read_reg(part_np, 0,
+					      &f_pdata->phy_pattern_partition_offset,
+					      &size);
+		of_node_put(part_np);
 	}
 
 	return 0;
@@ -1739,6 +3466,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.execute_tuning = cqspi_mem_op_execute_tuning,
 };
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
@@ -2115,6 +3843,7 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
 	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.execute_tuning = cqspi_am654_ospi_execute_tuning,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.34.1

