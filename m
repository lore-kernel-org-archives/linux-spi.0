Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37183845B3;
	Tue, 11 Aug 2026 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473258; cv=fail; b=ZwIyZ2RFTAy/BCmmDqtT3go6G9d3YMIdlvEQmg42+dVGGtEETByePqjI19fFxasTAD3mEs4F8TrbzAMxsBCMUL9/S4x/FT2O1Gc5XI7ML9JUKcxT3LlXKdY1d/b0LkNSxR2Q3e+s6y0VpfZYni1XkSAe4TLjoAX50KDnjFMSUX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473258; c=relaxed/simple;
	bh=T5iG/osPd4SmdfnjzfYz5mfXPIArTtH9q8l+2WYL280=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xcn/pGeY6H3Aq6yhUGQjCn66SKhuIutwuimm9KTngQUzXhmEd9Npg3hJX/sH/ORgqPckAm7gLe8UeoU97dIbcq506IFNNV2MgjD2U/uajIpfEF0i9q9s8cdAl7GYFohq005jYExA9Ry4EyB1wy7bIb3zJVIJ53J1tz3pDr1ag+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LRdF5VK3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vF2xoFoC; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LRdF5VK3";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vF2xoFoC"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67BGM2Ec2459496;
	Tue, 11 Aug 2026 13:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=QULyOCZm+lfHwTvY04ItXlm9lRRerGZLH3MUpV3h3
	Oc=; b=LRdF5VK3VRMN8D1vjpVCkjHH/Jmy3t5r9puwxVie2Y1O//R5nfJFOCRFb
	wYl+Bt+X7Wm7Uqfjyf4i85Xjz/Fl1ZZRBJBod9hjMtx/zvAXM6Vbkgs4JbJHQ8SH
	ISoQ75wlcS4woww5IBwqiLciAIJ3hn24hVTPuXVSYXZP0L51XEZbvOhjIxPrLBlo
	AHkS571iB1ofjRS+BYg7a3XQQ6BwKTj2svNFkC/M4VdyrrsrVwp0IlxMAGZqlaDu
	oH8oXeDsest75eMTz0uKfC0GOddkdLI7MNmFTNRaIXQ11TKaltAMzx/Qet3h3l+z
	+8v4kTorR0SVg5rLkwkzyyI4Fa8pQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g00wu3h27-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZvmH8maTpCo7klOJQhU1IiOY4OKbeSITht+2DyPTaoNOevRpRDmfuscj0ilbSDploQ3Q9aYUQ95PdLZIDvHUnzys7xmOvEzgHRHImfr7/PBIXPFm88d26tzDhvHKdE5kojUEptdorx439WCGlxA37thKqLdwdNDo10uwaVkmOZiQ3Eb+XaM3GfaZn9zULwhc+kiydwfDpi/qhFdZM2Msc2VTbLOSUWk1YhQMdfDO4ky1U5rCvvLNRrsqmpqHUWW45+GcUp190kjrXr8cAqRj0YKxeYSSBq5D9q0bTkEJZUR6zD0jEsEEyXRt+40eyMEhWdfqjJhBlWEmfP3r+ftSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QULyOCZm+lfHwTvY04ItXlm9lRRerGZLH3MUpV3h3Oc=;
 b=CsS21/73t8N/jqlsKqZdb7Lb9w3Twb9FhC+gyEcPInM/KS7XsUHxhp0U5fbZ5N73ml2deo+Tg2FlQm7NPhQeFFJ5PnHJAvHrrFQYx9HxSiJofgcvyyQHopcZIy3Ombwnr8RkojY5gXQNcLDHt8+QRjl7fN5nVsRD08rlyl+3jytQjfmXLQqVxzhSLbfukmetnPRd0TP8f5ytpRU4WTbkbmdgYwzaSz8/xQWeyXWJnvfgCxx/emiQmRwcRU+m1W9Q9/AwVLIeMTJaHwTOxPqj+qhEyQmkO4o2FUzdM4FBGiI1eMEB1hEUKdBQKLpiYWJFPoB/cNrKySsaVGgmuym3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QULyOCZm+lfHwTvY04ItXlm9lRRerGZLH3MUpV3h3Oc=;
 b=vF2xoFoCOAj4PsjHB4mBNV+FViQvd7oktH7ycTWh2hnQGbIbLhytPCVSN0I6z4+39ctnnkEgBioh42AQELXxpmcDsHXlUfahoppliZw7/vbY76SBs+abWbU2RBpZ7bAf7+LxnXrJaYBaxX3i8NlZZhW9LNuy5fw/1BgrW18G+mY=
Received: from CH2PR07CA0041.namprd07.prod.outlook.com (2603:10b6:610:5b::15)
 by SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:34:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::58) by CH2PR07CA0041.outlook.office365.com
 (2603:10b6:610:5b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 18:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:02 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:48 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:48 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdv659766;
	Tue, 11 Aug 2026 13:33:44 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Wed, 12 Aug 2026 00:03:00 +0530
Message-ID: <20260811183313.1550425-6-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA0PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3b394b-16d1-4812-92fa-08def7d71e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/8t3bGijUhKdwJmo9KUW1PHjbV71PpSci7SBDYfYnBe46Ox+cNaEionrs0TArvRjbCbMJh3GxnWA51LHGsaBNNbnPI/h2QT2kK9pFdtwuyLn7IZH+bnRCMy2PB1NbxG14v6eyKy1cxDbE2RbKdtqQtEenRMqH15bPLEY2A8e3njTMRDOrE3Nwt2dZjWZ2KP2ydqXQRP6szmDCtMprwKJW49vIynFtKTkOUqvhOFP+qVqHAKgigtEL/NmynSIZReyvuCItc8lAE3TjW1uHSzcmh2vzbKF0UzTCzO2/WTObjnDvfZ1sFL/2V3fia4LytnGJOijCw1VDfKbmQxj7J+m1BA+Xl8Oj9wdYxq9KYbyuziNs3e5Wjr9iNKCjpZFSVg0/IXJ245ASoV3RRwoPjy/qqRkuaAABwg/vBICXexffAaVUT2U8McMnRDTJkC0C9dxYLE0JUGJs/QGUUHaF4v3KEYSvMfC7tteYRUPQHPTZ9uCau264qMJVhbeshixl7PnomAsghHTB1060XXlX96UOOxUNs0iSOIfY/4kue2ASGQxvZVkRCxcYVPNSKvtt8n+z2yAyZH0ZsB102LKAaMKRRtUzncfWMqiHEDCIWDzZUS5RE9n97zNQ/qXYNZ+jdS/DixrYuIikyYRMkjx+OTaYMKbYsk51K2C+j2v8beKaF5PXMltBjeWScYinNcarTUZNAygAymb/gqHo4NwNB9OOlN4Jj+gq6nZd6I0Gf21Gd7Q/0pau4qy7/ii/NEOjJM9
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QtH+3mzdTifNhvx+LkQidOvm7k1rXLn48f5XgJndfL7lpexA1qXmNd3DyxJayBTqbdZNZVpRKG2F60ZhY5yi1boCrI4SvsSfI91bkqsZt80ockRwUXLNP1njk066sSogWCDqM05Yon4Zy84aKbEVSxFm6kzJI4qhBG56sQ2cHYjYcP79cl0spKlYd3qUwgO7EqICSBdQYxqEExFXoz/wlx4JqvCFR1zpzpLXW+UfJO9q0MvAvF/UkyBrsMh17HADpj3NN5S61aUwzPJ5gc1Xnp1lKTAzQuLmEGvvDh6AzuJE28UTjPcdmzW+pxSus0rbo/3gifRX6kozLKh4/X9+M7RtpuqtDPU2s14KSHcahhlIhXHx4i/kT3HdbsR08FefbLE92sXTWu4PpNbo0LMczR+Uipk21Tu+iCxXVsNwmW+t4VOvZKwvAZgxw6x3eT0y
X-Exchange-RoutingPolicyChecked:
	cDVWkL/n3v5kjgzTOhinqyDstqNmPaAvhdgtVRSsZwkdcPLe5w0q3hx4bATwHaHNRvYVAyDSzEbP7llsiE5k6v7sW522Xnm+AApAZJEChqaJa+CujdkNtshJDrq01zvXKq/kWid/uSZFmchWrCTJbh22xjgXF1GCHLo2b6LuIq+JkXrrXL2NrUa7dDYlrP2+LjGSHEI9OjosZROPbo/YSFHXF1v2v2QjBcYQOQZnZZZ1I4Xmav349jf0LP3P74LA74KOpiqQmOrZQmOnfZ8skXVjgz7XfYApLuFMLoUrCPr4Ogi1GbD/YIUR+eehuKqqvXDFFwP7vVCWSHiqz+lyjQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:02.9475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3b394b-16d1-4812-92fa-08def7d71e3c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6425
X-Authority-Analysis: v=2.4 cv=M+V97Sws c=1 sm=1 tr=0 ts=6a7b6b1e cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=XczTfz52Gg2yNcvB9tIA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 4IBH53ijcxgtg9nCtSpYg6WqeTSTyRWQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfXx1g9zYes6Fi/
 NpMwmScG9wxin9Vw5tXU/0sWa864DjCa+Z+rDa492zhgcgLQXZIw2dENZBDZe8Dsm0mlTJTWNB3
 2tfQR63jOL6W9o6N1MqITjdliEu0YGc=
X-Proofpoint-GUID: 4IBH53ijcxgtg9nCtSpYg6WqeTSTyRWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX233FFjBXCctZ
 R2ot+bvkcZWzrULw24zvkKOsIjgeHzzbwPR8Segtl8Scs12u+6uy5Y4apYIBEdr7HfI7nyxL3oJ
 1ZFUVr04DPu09SRLnecuoTn1g0ZRlan3bE/cWuel2itTSFbr2kvmC6jd94q4c+bGSOGqab0RqyI
 UfhUx8kNgBEAQUM1uQKN3BAjIjthwRXpTHsGAFdjEuQntda7TI+SBAD2/nVEvgIOCk6BEDeWEke
 rLUn/LVtxu1+mydF6f3BIJgQBFhs6/Ukkooun/gG/f7JyX8o0znkFpES6x4F3ENGbhNQVekULz4
 aM5ChOmxUNCu57RF/j0sgyx8C0yZbPFwBA8Ku7mqLiRpODfpB9l8c58xh408pLAdKxZA/+9suQv
 OUT+m8gCAIZ4uq1lnbW2kX6WNBjQYh625UmZJX9V9jVP2iJEQsd1QZkV91WoGB0jwJxLZrHdBAj
 8OAr7vjp+GV7oD52aUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110156

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate. A callback return of 0 with
max_freq left at zero signals that this specific op variant cannot be
PHY-tuned (e.g. a hardware erratum blocks it), allowing the caller to
try a different variant without treating it as a hard error.

Add the corresponding spi_mem_execute_tuning() wrapper. Like other
mem_ops paths it serialises access with spi_mem_access_start/end for
serialisation and runtime PM, and rejects GPIO CS configurations which
cannot support hardware-level tuning.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c74858e58073..32773a4372f2 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -661,6 +661,49 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if the controller doesn't support tuning,
+ *         or a negative error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+	int ret;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	if (spi_get_csgpiod(mem->spi, 0))
+		return -EOPNOTSUPP;
+
+	ret = spi_mem_access_start(mem);
+	if (ret)
+		return ret;
+
+	ret = ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+
+	spi_mem_access_end(mem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f660bb2e9f85..ef5a6d60bae9 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -346,6 +346,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -376,6 +385,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -465,6 +476,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

