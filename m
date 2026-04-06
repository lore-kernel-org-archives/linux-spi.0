Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0A2C3757;
	Mon,  6 Apr 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466680; cv=fail; b=rMNnHMVAoNYDnmLIXR5weOwrv6conENyoPMUlZSxdAblt1K/4cIuTxzwUVpslWspLms9VB+8WrqmQvbngB5ppNveYJDm1POyH30vGHEtpq+mqFxhYQwUJzOT7NKKwIjxnLdEeZ62hKDdN6olNuL493X9bO8THOGnctYXoRJ7KHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466680; c=relaxed/simple;
	bh=djaHgvkAehvfhmkARJdoEoTcQadX9uzhbNpRpFMQNkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bcw6xXBLERdwMPuRMsaVU9niiF78Co2GpWRHdvym6obO/pQdcNrGxPekYSgrZT2i+IGELxD9e1+lgcnp8OqttoUB56qQZf9SGJzzxzeRT3EuKAKnNB6ummDid2K5+T4gUrGA6dqUwbjRd4yfpEEdHDPndE9HJGjQndjsw7YLgbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eeS6H2Lh; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eeS6H2Lh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncDgm2CPiB6a9Enx73cUVyu9EokDrfHFFTx8RbnbLAND4qDaWPnYDjkWHiifEnJdGdzsAGdf9xRhRKFBNnUWlusePvZk58K4+A4U96SFkz6L0V4+gSDZw9Yxz7+TnmQd2yr4ujlNDE91fLvLoV4hq2OohzS4e4g1X8wADQZqgJ0DWKTG59rXdFrkqXQgnW2yvSfYePdSfF0SM+VCoXRC7hgy8G6BXhidOQuFBoX2DupnQIXSmhUSEGkrFrrDq/Qm53w6umD3zWrnlQjcXyd+2edAnnsu0RB6kMZTgcfxPb6u/1wQw/cxdeZOqoj4R7IVSflSNb7bFg7S1z3PaBTUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLeufr5hddwSRApeZWlAvmKRHPPYSt6xI5LyWSOsoAU=;
 b=ZMN9/DYMoDGcsZDl+krRElXJeJVdXQj32Kd8TlGV+wvoMGlWMpsUbnHrDFd2a61Fuzt2B1yD+S16KshBqlzopeCd0DcsZ/EXQx2dtplxwOktMwIeQ/evhSLTLq4K+K2Kv07NNbG+9ypM1hg3bigYGOc7n0G/aIvXhr2X75piEwPvoHhMKA6AbS99yZcYO28OutU18lk38TgGeygl/Ybr0ywkYvwZ+45LJO8OIK0sV5sDPaKesdIIP7gbzWEbFfGSbgMJIKuYsciJkYZToh4PD+fYWbI1wIu9r/q+GWqu5/wyY8RndqXmP9SAvoIGgTNuBN7PFFBn25u3x3GRQaFlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLeufr5hddwSRApeZWlAvmKRHPPYSt6xI5LyWSOsoAU=;
 b=eeS6H2Lh5DC4YlST6neHA937ztv66H8xYG7su+RhwMDPGZkSU7x3t8Nl8ml1JsxsU7XRUdFTte5Blj4xtv6g2sE/2veUjBkUvEiVdDO3ayXcM9Dc7vIE1K71cPzXqbS4RmOLlf+tiM6UMDQZukqGQ2xKtIIpS26HeZyb7rTqB4M=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 09:11:16 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::fb) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 09:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 04:11:13 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-spi@vger.kernel.org>, <broonie@kernel.org>, Raju Rangoju
	<Raju.Rangoju@amd.com>, Krishnamoorthi M <krishnamoorthi.m@amd.com>
Subject: [PATCH] MAINTAINERS: Update AMD SPI driver maintainers
Date: Mon, 6 Apr 2026 14:40:42 +0530
Message-ID: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d464e7-1361-4b53-a5a8-08de93bc74f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZoiLBaGzk87XnnsJk/zzXM7/s6UIxZ1PtvKCRTXq2D0skn2sYeVO9OYiK9yZoGhcfC5fUJN0MCHu4mPwFS5vwpETY67Z/Nxnua561dgIupDcYNr4w61EElvvFeWkcfZuqlv5p4T0S3UHXq0OBKDkR+J0fZtmi/kJbdDhsL4H/Xs4TRY+tsNmMyNfsgk0IhuwBCwH374IBDfb7FkvbxT2AIphZe34OMrIayc3hQ+mZdOM0txKiMSZzuVfEw8HbNJXi6m1FtByjw5PAwC3fYq1QkPg1GrittdFOsT8zd44FCizj9zha4KR1gwwk+sDUsDiDYtGDg7nRdmVb0pDP9QhJpdbKQazKCcdSSB2LDNVnmdLreOp/+kD/EZ732O+fy9+cSdNi/oV7EgBdiDPXR6gCArNVvaKDY5WUmRpPpyNU8+Aq+5KPRq/Cdoz56r7e7z0TmQb25Xi+7F4ozdj2ye81ZNwcfZXA+fHFmmJIeUegaPyMPlfpy5Yp5F/YeZXaXA/+KhXce4A//l2TFvlKfTNM2viTipZnyZAhMHmwwu93AaZ1ydWyR8gwME9yGSoTFKINSA6O+4AuTuaJ4Qi62dmkcar7iIHrLXC8HCYrlYZwbrfVqpfY9m8apgjbxyKm7s+lCaj5B3wyRs6A0TGTo/TxwV4rTOoNc23w0rCjYtAlNrlRKFTxSSfkcozSLE1m+DBCbEVic/p2SzApVFPCW5YKzqSGp0DACLzuWvP2BVWyY9jzwTvos0KrtaLXRcUAxlt0DGAbpQXD0WBSLaeJgEBvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vw8gXTmIJ8gIvXt1w/9K3aswXWyI1qTNBm6L5kSJG8m5RP/FFeLpHm0c8yU5hu8aajHI5uKS7rHQy8hhDFXZ3R+xYLoIGhMsPE10oB6MKFE9JJ0JiqGCykLyS6m45xC7MRrcT4OFxHKAAFMxN/O5Mwdv4rVsOSYIsUF7EGKaT9xh4nJkwX02GBhH8+/FHx8XfJespcJ10SFDZpT2zL1qu33+CDBl9uW8tv6cswEU7COOP3Akm8WIBic4fNvRdDlGWJfhyZjOuy7/p8Hva0rEQgvUmloG9aQFSG4kx4nbpbpYFkOWmfbYU6wVbhhQsILA588jAvT87TQnkI5DKTWNNAS38B5aHIaAqY06m8UtLI1kOijv+kTjEJgxXFTfEspMPFsif/DG6BpZYcb00ZjezDQMoc9wXe1SP/RB+mwrBY6I4yL/OVX8Z+yWs1sYS8hy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:15.7372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d464e7-1361-4b53-a5a8-08de93bc74f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

Due to additional responsibilities, Raju Rangoju will no longer be
supporting AMD SPI driver. Maintenance will be handled by Krishnamoorthi
going forward.

Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc935838e516..971e8c299392 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1272,6 +1272,7 @@ F:	drivers/hid/amd-sfh-hid/
 
 AMD SPI DRIVER
 M:	Raju Rangoju <Raju.Rangoju@amd.com>
+M:	Krishnamoorthi M <krishnamoorthi.m@amd.com>
 L:	linux-spi@vger.kernel.org
 S:	Supported
 F:	drivers/spi/spi-amd-pci.c
-- 
2.34.1

