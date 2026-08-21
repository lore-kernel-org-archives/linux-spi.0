Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23DB4908AD;
	Fri, 21 Aug 2026 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313027; cv=fail; b=ASTBPK72NSGZfNf9dFWkgnkXlamzmdUBRYtQkcL/Gi+4hY3tVjdW3f8kOO5cqyZaZeH4YINgDehGhtqYyQ/gIfKwzMXhF7CYMqmIvLsIDDS/dVeqAh4QcaxHqYv2I+a/2iTfUefnTI6yGREEjlsn0pOC9yiB0Kp7K/r3jPf7N2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313027; c=relaxed/simple;
	bh=NoM6T/+m/Y8FhxNH09GR379GBnAoDkPBo1RjNaYkypk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBsAt3YNzTKOy/hYFfMs0pggjFTiKHpQmmSnEIY05TL7kQQzpR4few4E+BRdXaEX4atpEMnbplKUXhClJ3JFnBFe6KbUOwBlo/u5lDluLHwXaGg0YNPvZrvsnTod9lT8g4jsDIeC9UMwQFMfxGisv2dM3EU+2H5ZpjGlmBd6IAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=fSXHGsYF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d/6Q87tL; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="fSXHGsYF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d/6Q87tL"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KP933254958;
	Fri, 21 Aug 2026 06:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5
	FQ=; b=fSXHGsYFGh7wAqMHfnoOsrRaveEqXkmrVJjlMftN29KcytlcqeQSjltXx
	0Gwqw7GZRodA63wZYLS+oGnE+mT3h+Ji+QbMfipA38bxo9xx39Gc0ho9ppVzj4gS
	VjU/AdAWa1qu/Qu5sLpo38Eqdmti6kpWkuvUAcKAwWUlMumWo0d713fLigGIEKqT
	XFw8NE/HxAIgEPk4+tVOHbk8DBIg7FjSSceT+NmvJHfpHDZGL8FRazxX/Sv6Cfsq
	LtAQ3zESYkI1IJfWrX5ucaZ1203Fr07d1BUSVNx2OlUgs9uBuELFQZc1dz57ObZb
	H5/R+/3h5JCy7QcRICk00DL5rNCOA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1dgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:50:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg1OPWkFgfk+gIxzJrTB3cJzr6CMCxo5Q28SBz+9AJ3bG8G0eLU3SmcU6tND5MOYMzMDNs9Q740s+3/6L9yqEUgTrTJw57+pzwH3d/7H30ZIOGCUnu6Udxb1IC65Mo+hRlKmdDqas9bIt+UWBcFjCDFLLCDMuiV/nLahvabETCMIeHCD7aNN81JhmOFEk8ZeWA9SUpobHDTJRv584LSm4ukhy1uQVXzaSQV4szpaAs6AmE92375o1sZocvKipJ6CPfUR1rV4N+pO90zcC+UF6bYTQbhvd7Qc4vD5dAVQDoC6l9GJPLpiLaNEPjlmlQyo143TsnDqzbxQXaiwsob5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5FQ=;
 b=hjT6f9wO/+LEMivcB8242F/miNbzQMvRcjn/Gzi4BdLZwvR5DBvtVyWEHZH8OJSzwoi5HQuXnoNtikKvl4taNoOBARRTNoVXZXv8zy8Vg+ZVonMdgiRwvaaop+cKs9ayQoJEeQgv77jrVW6enWSm9nhXdK9n+ileQUl1ZVsBuAiI+5injPg7YDhMmMAOAYJVuP/QfcXlL9BBl5KxJ6cSSNoqBmey73tj4KAzhr/VwzeqNxsDi/85b6eqPcwn+EF2gn611X4TkmIpFiNuTDX4ERcriP/ZYiiviyRCW/ooU4/HiJPipB1R5qkypV+QE52OyWgAzQ56fDbEKcI6RzD6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG32YQOxvDCXwVziXW0kuCU2/ysyjR6Bo9aedV6M5FQ=;
 b=d/6Q87tLcuvqSnviSms3N7152sqk+XRDnVJ1rsrQWsqU440ikcHEu99D2NDYaZUtNnmEGl+P4tAD2RnrHidy0YzNvnrI5u3Lzaa2YmX4oDQaXHeUf8PI502q8NNmY5hR4DosW0IFbY7gA+kA1zOLaV+Ttr2Eo+YsZHZTv6rb5WI=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com (2603:10b6:518:1::7d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:50:05 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::d) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 11:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:50:04 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:04 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:50:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:50:04 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlr2022942;
	Fri, 21 Aug 2026 06:49:59 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Fri, 21 Aug 2026 17:18:20 +0530
Message-ID: <20260821114822.4040338-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH3PPFE6F9E2E1D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9267d0a8-ccc6-4023-69ad-08deff7a575f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Sz0JzGunXn8Hsbtmwtr53LgB2mWdoKoxFmTh3iz8gjhG6pX5gPzjwvQRjhe5ChqEljtVAtLHzViEWJE3XKhQBCHe8IeauOv2sQDlCz+FSICksdDSaRMCHGxt3ITdCIv1nAsuYa495dj3Jw25n3OC5kzqcFr4/ChyWdC+qDnQ2Ss1QBiRD/g4JIXwbZ7BR8JhUSyAc4jlXNtjUMED88Wiu7vH9yTlyDU8k9U16IGm0/diXDGkj84yNWLKKHQtlI6YZZG2urtrheZ+HhdHoVBDYAr6nY/9NVQekWw4GzsVb82SNIeRf2kPJ4VBZm90koiClYtEOXL3PIfGbnaTE4EZweFMJYaU7wJjwghPg0+H+VmG3r5c8ItE3ClGqP3Rxwa02XeCZDagrVu1oq96M5CFyRXUglAJ60KyG8NCnAFihcoTSisma/GNhKGeYAD+TNq9ifq0YeI7Tll5dpJ1dciZ8zLeRE63sRCMA/tfs5QSScQwNH62wUYVgJO0P0Ju8TTBR09O4ip0kZMZIIG1EHf2WwBuvjqoMP7CDW1akdhQTkQitGg8/U4G9vxMsrgEXHrpm+Y3T3kW3txS3/PRbsVPE4Z1SuDjM9lcs1F9MpJ/fTkGPZZF+Wtt5gXsLWnGGKvUPQbScgRZBs3SbUYXjvvZccqNURzl96mwHlwQ67ZVZpEKCshUHUDGzpeNXJs3kgfwSWI5nm4jhxPKhI02Llz2HbyD3B72yjkgjPDB/LQx6Fgmbjm6Vy67BcpNGuqfTocz
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FoXwm8C3UknNdwrpavIssVJu8T7bMwfgy2ZOqin8019RcThzOHwCTeaOzVuvLYeP0pqtaWREcbK4Bfte438JRHjOpt75E7quXC3kXQCOoadtPXGKFAp25z8i1BmTOxu7BC+7K7e11lAQiTianZL4CrCzxuYoxy04HSpiHOHeMCKQ2ULfgRZeVYT2nuVSmO8daENj2zTKDKNzCRqCPPhjtL0fHd65vG/pCVmB5ioRaSMWXhwATXEvSnY0jE388gKI4z1QfiuRFdHvMtSftP42ZZqARsjOpJjzM9rhncBp89r8FTRW63WAk3D19x1E1vCri3u8F+F4nB1EQseWg8Uwp1U6m2W9qTKnV3lnZeIaaAgLgbjax6VjBk0h3Kp+snGmA4m3LHPl18/oRSWymi0wL2HrEqv7yMC9qNCnk/0RU+jfnpkoyupKNE0Q1tNZlr71
X-Exchange-RoutingPolicyChecked:
	ZlP8wA7b8ju7msmLP5hK5LK+Scqq6AqmEeYcclOY5vYyqYe8l+XxhF3HSEoIXbRpes1NrZRboAnDErJlUTtutCpI8qfu5un/4XjuaD+7T9YzDuCrJJvEGIl1BV/aC5FoGsPLhzQgRBmd/3odBcSgOBzRXZ7O03VhSiA5JnIyOeLylJRxO1CrphV4RhyJZRPlGz+h3gBqUnzFVXapJnW/VTqX8x7HAyPpm9eYGt+uvbTRI0DjuWTecR0pz1M4GN3n+Au0FN0URHLkbYLP/0yj6Gw05w9+ylMBcQJPRNp6lps1YR9h7ZFmSVh8dUEK4KfUKVl5pv0rwAMiznHfQbHqEQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:50:04.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9267d0a8-ccc6-4023-69ad-08deff7a575f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE6F9E2E1D
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b72 cx=c_pps
 a=0PDhd3HO6khzWhHQYbQRQA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=-qpymeGUnIbieU4wEgcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oABq2ssV7IXsON27GmSictGlORRoK8r8
X-Proofpoint-GUID: oABq2ssV7IXsON27GmSictGlORRoK8r8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX1PkIRJUJ1zlX
 K0mULi2lfbrtGRdztK7Dkpoh7ie2T+YKAaBLBimVg0JJQl+yO0PC/o1DghK6LEv8IP/9fQ4H+p9
 Ft2YuOi1SYKLNstYM20axll33lojviE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX6GVEi5YcQS4l
 MkOh0TZRcSCKx8ipa+SyQWM4Yi9vgZlUvbMNaH8ZDCXtPtpoIMnHlFehHSQ6VJgQaycKRKxEKTp
 TT49SFMjtTFtgcyS5rG/5gPt9qHDQvZG7ueLB7LlsUoTAilj3wpF06yYsjZ4MXHPpslK+lr03mz
 TexMRwgVW4uVLVMumkdZK5WJAX3bWI9rjpvJqHg4nlPBrnCvdf1CPi1SBHX+ATbxDOgUCBlJZqa
 nI/Ph8pPzHOPnqTLhaEo7uKnHu2z/uNZgCK37Dk2MFNy9cpiMiM7vs/67HxmgfUXPen5zPNzL5w
 Hxga4mV0/WxIFdlxJm92/pKQa1hyzs+9lgSpiPUm722m60cBEkmN+qsFplr/yQGbEEUs1KZgPrz
 ba/fvY0YOBkQXz4BxXpJ5Wodp03naR2XOMihvndX9xWJEuuCBQqm8sYgtiTPTFTU2LcAb0wFYkW
 i73x/eA8h0KFuUUsZ8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

PHY calibration must complete before dirmap creation so the validated
max_freq is embedded into the dirmap op templates from the start; a
dirmap built at the base rate cannot be updated later.

Add spinand_optimize_controller() which calls spi_mem_execute_tuning()
on the pre-selected op variant. If the controller returns a per-op skip
signal (ret == 0, max_freq still 0), spinand_try_ranked_variant()
iterates all remaining variants in descending performance order, trying
ODTR first and falling back to SSDR if all ODTR attempts fail.
Optimisation failure is never fatal.

When SSDR is permanently selected, clear odtr_op_templates to prevent
spinand_configure_chip() on resume from re-entering ODTR mode with
dirmaps built for SSDR, which would corrupt data.

For devices with a distinct cont_read op table,
spinand_try_ranked_variant() re-pairs cont_read_cache with the newly
selected read_cache variant rather than disabling continuous reads
outright. Re-pairing uses protocol-shape matching (cmd/addr buswidth,
addr.nbytes, DTR-ness); addr.nbytes is included because different
address byte counts represent different controller configurations
that cannot share calibrated settings. Mode-toggle devices are
unaffected.

Move spinand_create_dirmaps() from spinand_init() to spinand_probe() so
spinand_optimize_controller() can run first.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 311 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  14 ++
 2 files changed, 308 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7c3341f1fca0..6e58e0893736 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1284,6 +1284,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1295,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1542,22 +1545,51 @@ static int spinand_init_odtr_instruction_set(struct spinand_device *spinand)
 	return 0;
 }
 
+/*
+ * spinand_op_shape_matches() - Check whether two ops share the same protocol
+ *				 shape.
+ * @a: first op
+ * @b: second op
+ *
+ * Compares cmd/addr/data buswidth, addr.nbytes, and DTR-ness, ignoring
+ * dummy cycle count and address value. A continuous-read op and its
+ * corresponding read_cache op are expected to differ only in those ignored
+ * fields: continuous read typically needs fewer dummy cycles, and always
+ * targets an internally tracked address rather than the caller's.
+ */
+static bool spinand_op_shape_matches(const struct spi_mem_op *a,
+				     const struct spi_mem_op *b)
+{
+	return a->cmd.buswidth == b->cmd.buswidth &&
+	       a->cmd.dtr == b->cmd.dtr &&
+	       a->addr.nbytes == b->addr.nbytes &&
+	       a->addr.buswidth == b->addr.buswidth &&
+	       a->addr.dtr == b->addr.dtr &&
+	       a->data.buswidth == b->data.buswidth &&
+	       a->data.dtr == b->data.dtr;
+}
+
 /*
  * spinand_op_find_best_variant() - Find the fastest eligible op variant.
- * @spinand:    SPI NAND device
- * @variants:   full variant list to search
- * @iface:      bus interface to consider (ODTR or SSDR)
- * @skip_mask:  bitmask of variant indices to skip (already tried)
+ * @spinand:     SPI NAND device
+ * @variants:    full variant list to search
+ * @iface:       bus interface to consider (ODTR or SSDR)
+ * @skip_mask:   bitmask of variant indices to skip (already tried)
+ * @match_shape: if non-NULL, only consider variants whose protocol shape
+ *		 (see spinand_op_shape_matches()) matches this op
  *
  * Iterates @variants, evaluates transfer duration for each eligible op, and
  * returns a pointer to the fastest one not in @skip_mask.  Returns NULL when
- * no eligible variant remains.  Used by both variant selection at init time
- * (skip_mask == 0) and ranked PHY tuning iteration.
+ * no eligible variant remains.  Used by variant selection at init time
+ * (skip_mask == 0, match_shape == NULL), ranked PHY tuning iteration
+ * (match_shape == NULL), and continuous-read counterpart lookup
+ * (match_shape == the read_cache op just selected).
  */
 static const struct spi_mem_op *
 spinand_op_find_best_variant(struct spinand_device *spinand,
 			     const struct spinand_op_variants *variants,
-			     enum spinand_bus_interface iface, u32 skip_mask)
+			     enum spinand_bus_interface iface, u32 skip_mask,
+			     const struct spi_mem_op *match_shape)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	const struct spi_mem_op *best_variant = NULL;
@@ -1574,6 +1606,10 @@ spinand_op_find_best_variant(struct spinand_device *spinand,
 		    spinand_op_is_odtr(&variants->ops[i]) != (iface == ODTR))
 			continue;
 
+		if (match_shape &&
+		    !spinand_op_shape_matches(&variants->ops[i], match_shape))
+			continue;
+
 		op = variants->ops[i];
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
@@ -1608,7 +1644,37 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			  enum spinand_bus_interface iface,
 			  const struct spinand_op_variants *variants)
 {
-	return spinand_op_find_best_variant(spinand, variants, iface, 0);
+	return spinand_op_find_best_variant(spinand, variants, iface, 0, NULL);
+}
+
+/*
+ * spinand_find_cont_read_variant() - Find the continuous-read counterpart of
+ *				       a chosen read_cache variant.
+ * @spinand: SPI NAND device
+ * @read_op: the read_cache op that was just selected
+ * @iface:   bus interface @read_op belongs to (ODTR or SSDR)
+ *
+ * Devices that implement continuous read via a distinct op template (rather
+ * than a mode toggle around the existing read_cache op) need that template
+ * re-paired whenever a different read_cache variant is selected, since the
+ * two are not guaranteed to sit at the same index in their respective
+ * variant tables (some devices omit continuous-read counterparts for
+ * specific dummy-cycle sub-variants, shifting every later index out of
+ * alignment). Matching by protocol shape instead of index is unaffected by
+ * such gaps. Returns NULL if this device has no continuous-read variant
+ * table, or no matching variant is eligible on this controller.
+ */
+static const struct spi_mem_op *
+spinand_find_cont_read_variant(struct spinand_device *spinand,
+			       const struct spi_mem_op *read_op,
+			       enum spinand_bus_interface iface)
+{
+	if (!spinand->all_cont_read_variants)
+		return NULL;
+
+	return spinand_op_find_best_variant(spinand,
+					    spinand->all_cont_read_variants,
+					    iface, 0, read_op);
 }
 
 /**
@@ -1745,6 +1811,20 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache) {
+			spinand->all_read_variants = info->op_variants.read_cache;
+			spinand->all_cont_read_variants =
+				info->op_variants.cont_read_cache;
+		}
+
 		return 0;
 	}
 
@@ -1923,7 +2003,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2015,14 +2094,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2051,6 +2122,198 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache. For devices
+ * with a distinct cont_read_cache variant table (non-NULL
+ * all_cont_read_variants), re-pairs cont_read_cache via protocol-shape
+ * matching and updates cont_read_possible. Mode-toggle devices
+ * (all_cont_read_variants == NULL) are unaffected.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	struct spinand_mem_ops *templates = iface == ODTR ?
+		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask, NULL))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		spinand->max_write_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			templates->read_cache = best;
+			if (spinand->all_cont_read_variants) {
+				templates->cont_read_cache =
+					spinand_find_cont_read_variant(spinand, best, iface);
+				spinand->cont_read_possible =
+					!!templates->cont_read_cache;
+			}
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/*
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/*
+	 * Only ODTR variants were candidates in Pass 1; SSDR bits are clear.
+	 * Clear ODTR templates on success so spinand_configure_chip() on
+	 * resume does not re-enter ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask)) {
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		return;
+	}
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 * Clear ODTR templates in either case to prevent resume from
+	 * re-entering ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2073,6 +2336,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5f4c00ae72a7..31e3a0dfe8a4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -792,8 +792,22 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_optimize_controller() for ranked
+	 * fallback when the pre-selected variant cannot be controller-optimized.
+	 */
+	const struct spinand_op_variants *all_read_variants;
+
+	/* Continuous-read counterpart of all_read_variants, if any. */
+	const struct spinand_op_variants *all_cont_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	/* Persistent op templates updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

