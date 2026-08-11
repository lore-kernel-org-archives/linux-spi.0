Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE462387581;
	Tue, 11 Aug 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473259; cv=fail; b=B1lHnCrVWd3kV6A7gsH5drbcLtknH7qm0f3Qns2U/n6d21Qd5/p9eRwGsttT1Za3AqQ8q5PjQ6AZmhDUOR+XSXbDjmC2DlN6nynKY8esuw9vMsEOJlMjA+l6gRcTcu4WfZR0rhAPtsuavI1GPNjyLlEjpnHVrs3dbwfRJLy2rsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473259; c=relaxed/simple;
	bh=shstm6OTM8uQraX2XsvM4iDwrlvLb8nvoS8/Hqj4oTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9xlc4sPohb3+CqUP1UKqUkRfm+B3YmRVndlEIsWLipvRuIt9J2SigvBscDCcCljfbx12T8mOt6X4S4dU4mr/4OezQS/SUSwiJ3urCbV3D+txpMMF7R8J+8BEDHOnGLOA99EHdxG4+aMw90Wf4bCGTZbBXT0oC8Uo4QDu8IZzT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Oktkx+9n; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GUe1BtTa; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Oktkx+9n";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GUe1BtTa"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGM8o11823876;
	Tue, 11 Aug 2026 13:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=cfL4/7N30NGycxUM3IjaKjHLCNDrP70F5bdqRagiz
	MM=; b=Oktkx+9np8oWy0NhuMeNpOH5No+osqWDfgWSe4v/2VP+r9yaZR9VkHw8F
	9Sedti5DRPyGhBUkgIF4Sc34eEIRKPxJHE3vrPoXzZ2StywzQvtFCe0Wh1A619J4
	kCTkh7XgI6q7LCiGghdEmIHjjMIsl/GcqBW8R7yGZ/uYoKK9dkJU0Z10Tl7N/MdA
	zAThvermHk2ba4/GLtUQMoDk+azIS56A3g+Y3xwsI1GKBqSl0JIc9vGek5Gkcjba
	waFKbVVEZEJPv4SZ4xlpTjahuaCEp89BSZTK896PofRvzsk3RGWZZLAur2tm2vwi
	7wXITBiMV/RzWJ+sqiB2Sb32YqUGA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00wnbk4n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Jssgct2iA1oYNFPXGFSVorcvlzy29P8bOJyPrXJRWL2zH5mLDG3wsSW0xTaXAz1DS/EaJwg5EyQ0VNNBk/Y7o9NoNha8yZ3wK1xOe35xxOS245WgM+MsXdmR6XVZMorDlzUntrDpIRxbJXelbi/E/2dECOkpIr0fIFotN2ye0eS4I4Zev/LPxXZZ8j9n/GDq7fJZ4W65xYwZ389Sf8m7n7MioC17PcWoRIkwelf4L4LSTmXunLLNl1zAUZJvCcaF2hHSy3vbgI/c8vywrUcBrD9vJwkJPTbgSF4dhtK77BHWs5qOeCaeNOv1hedPyKOPOX5E28HTvt/aFW9aB+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfL4/7N30NGycxUM3IjaKjHLCNDrP70F5bdqRagizMM=;
 b=WrNMLvJQFqQ0hCL7wsq0bubM6QX2PT6KnuEssqjvWkJB477Z+kYzvGSEqtQHDzhtD1lBIVzGxyr+/5XMrsDs3zXZp4L2JnQwmcgGoSR4Nzwmf991UyvgPmFLvIPSyvHWXC/Mf26pVepx5q0zeWiNFHia0A909PvyXVQ4lQjfJVlw8DV5ri567ZacbcpMzFce1zYmKq+NhMWpGRgg6WOHGK6cuPZdC+3ypGIO5JMFfEyk0cyHMWg8OXL44To00aO2IhK7SAXBoTiKkOqMjVuh+HQvMgvNdSfBLuzbWiNv00eKJixLpnOyjs4LuJ0qR0NduHb3S/RhVsXwiJUwoxwjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfL4/7N30NGycxUM3IjaKjHLCNDrP70F5bdqRagizMM=;
 b=GUe1BtTa1UOjGBo171REV/W2TN6cGnvPoPs+C8D5vel0ZsJgBzr2NGVumawmJqx/15ICNro+cOqCrn/k9s1YeBj89TpGcjSv0nbqfm2F3KPpGHwiCHC5hTcXFNzoj+h60YwADP6Zw3HTzB55GEe11NmIAzJc1stn6nm9epXMLoM=
Received: from CH2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:610:5b::35)
 by CH3PR10MB7701.namprd10.prod.outlook.com (2603:10b6:610:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:33:56 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::a8) by CH2PR07CA0061.outlook.office365.com
 (2603:10b6:610:5b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 18:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:33:56 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:39 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:38 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdt659766;
	Tue, 11 Aug 2026 13:33:34 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Wed, 12 Aug 2026 00:02:58 +0530
Message-ID: <20260811183313.1550425-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR10MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8745b930-aaf4-4f7c-86d8-08def7d71a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	U/IXnfQuaaigVVDhJYnjXb8s3A4hKqheMsFQa9L9e+gbSlinsWmwkMMWL8ZBf6LxevG7omAXTyUTI2xGvhu6HWWxJHcY5wwDt3dsXyuhE1iGBLydjfvac+h4rHSCMJua2dDQfMPpMPOa0GkYE3CEZOcSO6046masXasFxRaSREhdf7yt/V56AA9p4/DOZPqDbt22TY89FQ6rUPzZsmlNGLvoCDlJIsS7VMJknB7HXTz5L03+oPsQxzDWOnc/Rbwpvv6m+c9pAc/AdWiI8xNaGzXYNjNSye7DdZJYsxUaahlw5n22oldPJmqOk3tjm0jhEhOB8eirrvEcQbySUyIPJEOyQYQ2+nsAQcfhFnN7pEleD/aRd5bemj7YO1YgDrgi+9YJNYh1ssceIExl322LIOeGsrycRTnjpU8jP7IIcI+bzziLs1I4nMsAMAMZZjsrmmc6Da6HBuoP80w+0vVlBjVI8X0MpMHmbZLhC5pMLz2sF9pODllLVd+2gvsb1nh9mpHpCkacYBheSRTaqQHGhHOJ7GOGsCWDwYj8zGATEeDuAgDgfL+9PGKn89DqMfwv/paFSxE63v0MlH9nwnlGv7rkFoT9Rx9byo9i17ihcRGXEJVSZbbg6FF2L9r2nWtYjlGLo7qlXoeFcaMQxAYIgm8g5bWL777AjZqDnSxwJKDX2HW0Me7d0OMjePGd4N1lynvRMLnEPwRSvPbhHMzMWY1DXsUpa0Z0dH55u5+OD8FmH1HtxLxeM87ZXqE7dsGd
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tw6qvST3geva5dMh42GdTENtX8EcCro1T7m6S+3rX4Ocv+K7SmsOR/I5fShNjKj6sdzgMe69Jip0c3kcoSgN/3Ivz21ca9hyU/3acA2ivNz4iucPGiLk9fxwq2VsqVP0DcAevCwgELHfPmhxHt5AA7T9Hgde7oTZhSVLw04sfs5OktCuJPLHSwBvp7qudLRDS1xrSGRZXt1bkHK9+BQseIWqg8geZpryGhmJu1k6DL3V0WSkvLMA6vBqNwZ0Dd+t6JcRZEjjyyRTNwxxqH1ekfvmr5QVo4GYIuhJSH2lust8n9LFRrIYqB/nbNC8e56qiogPRb6PL+/1wKbXbRXkdw9eSpeIb5O1MV4dQ4FE0d+7/dyptZJzLBGXwyWbd56m85cCOccc2dAIxBiAwLJfaoe9CIJoBVVtZ2yWOoY5iS4Vp7mVBGngs6G5eZfWhDrg
X-Exchange-RoutingPolicyChecked:
	B2mI4frORzU15EpKzK318/1lTd6qPBEJ6AWGH/UdvykDdKp2QjBlObrNx+MTmxJaKrHmvF4fFKGGm72unwfkE0by0uz9LvAHSAuunaNYeA739t1ukbnkBP6P7l+RBWyVcEGOYtkllLPK5/Rbexwb9bYnTW+3TRPW/PGN8zxL3Vn5d8tO2bwDronj8bZO8FHBozfDDruWCsjAPQ/9GrmIHQUSs/qDccJHCWMG5897LrD7qt1jjXE/1EpasXOSB2NiuIHoFe+RZw4HOtzW3Xfa8gUMElGn5scKlq1mJDH9cbN8sHSsbQGZZ/etstdud4UOxje/tqtjUbVCZd03mY6nxA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:33:56.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8745b930-aaf4-4f7c-86d8-08def7d71a48
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7701
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4o0077ypWqB+
 DMx0/wi7YGZDFu/8Lxtw+MXmx13PpVj4l4ja/VfO0QZJnbB8YSNUPUG+xMVGYlk+E/+M0B49WPo
 DCdB4u/nm7D1aQyNv1ISf1klgan3zTw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX5+AiLU+fqPIx
 17kwY0Kf7in6YFmwwKWzgeVaC4qg0k5JVzjIqhrt/hEYOWVUqcv2OcnX+/ys9TuiI8N5PZ567OF
 RImTofJtaBSwx1CSnKCbCV6pNMfk3o+o2akKf3YSUkJtKzfnwVkMYrQhb0JYYtW58IcWnpTIf16
 yME4+BqE99i4bwFbUFECXd7Db5LPERk7Fbcmr5qXnrruQVs9xMv7DHE4FMp4v9NhfusuZQ/CHfT
 FjjiGq0/Pg5bNo265fbInw4/sbIRp3oy9CpznK3KiAisr1kZwget5lcAuX+Ebhv+MUJdiOfFXxY
 EGSgQEGseBq+gIcOLgVySYITVUD4PyweYCHg/MzWs+UkQZGE3SMM1PrxIWgN0Mw795wfpgHGLw6
 SiN82L0tDwxZ6/La6PswNIsDT5lWgo+6+uhMm8iqj9qvTFcrXiWvtblctEDye1PSgRUL+XnZRrm
 Yn3a/eEPiwoKXAevMIA==
X-Proofpoint-GUID: I3WjnEGthKzcf7674WG9bE1ovTtaG4nN
X-Authority-Analysis: v=2.4 cv=cYziaHDM c=1 sm=1 tr=0 ts=6a7b6b18 cx=c_pps
 a=XZql7kJaNSG894ZXpSE/kQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: I3WjnEGthKzcf7674WG9bE1ovTtaG4nN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110155

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 07c572e1df5d..2688e987f900 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2789,6 +2789,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 88d17fce02dc..02fd602f29e8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -195,6 +197,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

