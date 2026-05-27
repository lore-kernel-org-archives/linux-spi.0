Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2C4534A2;
	Wed, 27 May 2026 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904616; cv=fail; b=uwQOlapdWYKa06BJVY6ZWIxkuc37wmED+xqLElQUq8q0c/L+tBP+fFfGkpco61tbCRH7I24JVH3mkvYzrnSIEkjUS796KPBdt+P7QaJDmysgalcO7zyMgrWAOP8edhGeY+VsmDLp7StoWc9lgAthsQswM9sIAohlUj0IGOwhzI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904616; c=relaxed/simple;
	bh=j7x4fhL5qBiEOu1RN81ffi2c/xYv1rD1g3jRS7KyS6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go01VDoxhQlHP7O5he8jQAkCZHm5BBvCWhs+PQHXS4symG/LfzjH9QvNmYXgEWCVcP47dZX8XkIi0T3VvquCZ1kGobsl3Sd6j6IG9Aqn3mEOlRnfKRArqeG6NTQlxnOF6iogw3YO4vL3mAHo6HWwu7mES0t4pMpfkB77dHuyChU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fiIm3uI0; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fiIm3uI0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUupaBTKKm5M/D6aRIigzpmJFNtbQCm+EgknL/dFQyf+WDOtXOMLM5gxaqu17+Lu0m8hTPIAAk6UMIL6x3/PM3rNs6BBcGMEDUsnyrdbNt2iDr3WIkfN45Ncf8sa0iBxWRViXL5/yBSLeD2qjYiBYQWzer1kmNG1ircwY/tUyV4z/cX3loBedOJ84xH2cEVW1Tq0WgluVAnSspRWfcjYWyUwdeHCkcHuFK8pr0cC0HCOW/BzP7WX9J4nBwc8khh4BWrUE8NuT6MjnXEHxqzlYAQXsdaPCngUjhIfp/LG0pPk+JOa/sJmLQrn/43ceHSI8lsAbFVd4fXMK7wXkfe9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcSrydGSONihnxK+52dlm7a6KcXFBq+/rJkl7Fv7mWs=;
 b=uGRRlVgqtUlAsW7JASWtQUdt7A04vMW5YujGgDOFCkDpUIaYhd/gRvYzVmOqZAJk90+62ozR6FapIfvYVw6CfGajSC9AgZCesTM9lCZaP8ZjV+qlKuOId3+GBMR3nonxIp/d+bT6ReKcMb7dmWnk5Ds0CPIoF52Sw8cP9097MRmHS0M8BflcoTLXir1au7QyyN2qTXcBFn7Ipx7jIzmarQcC4DPCxjjtODOYS9JP6uLQdIPScsWXGR2Dq3mocB1VW0lXB5LC3f+WuqWxcm+PDkUhGjMPfGL2jl5j+M4hfK3UU5hbEFwwdXk7YHDXZpkyZu3DVNa+zN+dd/slT7cmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcSrydGSONihnxK+52dlm7a6KcXFBq+/rJkl7Fv7mWs=;
 b=fiIm3uI08mquooIZm/rSfEBzfyulnohw4Qqf5At+3h1HyhIuzyt2Wgya/F3CYcUkQtd+llA4ctjPQJyaMC9/HPmfZ27sd7VxiFjjXVMrLSEmmr7y9HamG1DbDvDHaclJaF/Bp4Pm82vRQw9uo7jfK88C9c+kSSA2M2sdDnt6u8U=
Received: from MW4PR03CA0181.namprd03.prod.outlook.com (2603:10b6:303:b8::6)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 17:56:52 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::43) by MW4PR03CA0181.outlook.office365.com
 (2603:10b6:303:b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:56:50 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:46 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:56:45 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpp4052476;
	Wed, 27 May 2026 12:56:41 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 13/13] mtd: spi-nor: run PHY tuning after init and update dirmap frequency
Date: Wed, 27 May 2026 23:25:27 +0530
Message-ID: <20260527175527.2247679-14-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527175527.2247679-1-s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 396d73b4-b233-4502-2a33-08debc195464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|921020|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	G4ETrd+YcPvD7xvQJDSeJHpY+6Dn5rhLqgTHB2d3djaZNrKBVcJ3nIYv5vHfCWdTtFao+CEkwle65qQygxaHZUPbP9+DlHCkYHkeqhLX7IQNt3sTlcWd/VE7hkOEwnm8nA1YwLmNLGuSCq1bX1CGmPMCzQpHcQm1Kgbr680kF14Ml2OtFmi9v/96RFWmA1cPORnO877k4NQP4HcZ9a4m3e8sL5VZ1iHJkb7btrXsa26WZv4yq0UZ4SIJ3f+Hq8oLPkbx6WmBV+YlJqnxZAtsG4002RddCGjWjQn3MB9htGQ2hERG8iEH+z3IuSPnq+bz/xAT9ek7a6AJzWjuKnWG7J5WYUkYyrErgp7CYFqAtf6Tho5rF/y6JgpXT39GH22Ff+56xROLNBvdH6rYJ8xHSkMFj8IaMDn93DW5LxbVQ/GqwuXR4I8EZdJQFotda7vW7DsaioRWQ6J4ayx55AGWfn/Q5LurPIEbgqCUSpjODiWp8AqD2evycKbFPsXHBL3edVMuLpGotwPh2vYVSq6vbb8MULTnRtojGJUXmVENxAQzG+TM1km/E1A+41zIvDSAXsSrSFX8Zd+U69ahTzlzsssbohHWkfw5dJNDZ8+VXnPLHtVFU71jb0znzTBNVw3SZqITAm2wN+ZIKLmFElXcNKPVYDQCa51frEgBmIpaC8lGhbEW02/Na+yO79saAIzOlza8dk2yaTcwXmiwsvjhHLTvLoWt2jWVTAF+r9xTH34b+o5QNArgo8puIpo8ktfEUwWPPcLBrqwmPVIr0IxxpQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(921020)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BFPJHT0hc2SjcMdLPQ2XdMDduW+VjwxrIlvnvJW/PHpL4tS6kw0EJuuzOLngiD7pzEnZRy7aEwu1EvnnSlpvBWyTpIqZ4bfRGoe5A7+se+lyeIp2tHjYL30+SC7z7nagVZbpdm8CbCk5rSGemCz/N/8pzNEfg7bDrn8G3okSEbKxAKznCWkMPmGRqbIN4CKYjiDrn45o4E0cL3KxSIzsDIdcmfmldUX9Ldthck0VftBeMlI2dOzSj+PYkwkxzbTh8rKeWR/EObTCaMdLPGhFy2TCHm58txWIIcA4ELOwu3ENRcv5/egNX/yRaQCoeX02paFAkIiPTvhD8rc6NteQ5NM/E6DkrD2Wgm9amV+29xp1e3r87vHkd5AV0jIDdc70i0D4sAvnYkFCl5uG5b2gxLdYywzbiHtM3QhECmoyl+9rg/fabr/yP8yi2PBMerbT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:56:50.7991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396d73b4-b233-4502-2a33-08debc195464
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573

Introduce a persistent max_read_op field in struct spi_nor. Populate it
with the correct op layout before creating the read dirmap so
execute_tuning() receives a fully configured op. After both dirmaps are
set up, run spi_mem_execute_tuning() to let the controller validate the
read frequency and write it back into max_read_op.max_freq. Patch the
dirmap's op template with this value so subsequent dirmap reads use
the validated speed.

spi_nor_spimem_get_read_op() is updated to propagate max_read_op.max_freq
into every returned op, so non-dirmap reads via spi_nor_spimem_read_data()
also benefit from the validated frequency automatically.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 19 +++++++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2c9859fb0794..207e0679549e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -216,6 +216,9 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/* Propagate the validated frequency; zero before tuning. */
+	op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3773,6 +3776,9 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/* Populate the persistent template with the correct op layout for tuning. */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
@@ -3781,6 +3787,19 @@ static int spi_nor_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
+	/* Tuning failure is non-fatal; the device operates at base speed. */
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "Failed to execute PHY tuning: %d\n", ret);
+
+	/*
+	 * The dirmap was created before tuning ran; update its op template
+	 * to use the validated frequency.
+	 */
+	if (!ret && nor->dirmap.rdesc)
+		nor->dirmap.rdesc->info.primary_op_tmpl.max_freq =
+			nor->max_read_op.max_freq;
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..6a11625f7b2d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -419,6 +419,9 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	/* Persistent op template updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

