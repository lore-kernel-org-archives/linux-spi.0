Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105043DA4B;
	Wed, 27 May 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904559; cv=fail; b=VdhB+/Zja6t9cG6xw3hSo2uvvcAEUaFF6jJINo6QCg0a5GMT6ODs6+nnld+W6zYLNqVDjW88LVM8Tc0Ruc1fSUcw0Ge8/yIOYTd9dDyA2ssUXi1mLuY8JTKPI5zz8JJWDY0O9AuleJCbmrgRnjpn9RCu+RCXoEBgrDqKMG2+1GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904559; c=relaxed/simple;
	bh=bpXjMp76giZmsQeRuJ/WTYb3ZoJT4jNOseQ7aUCvYeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ8PkBJevFdqa+rSVkmlfpjTJL7lcESfmcIp8pJHXC3qN3o/3Xh49vAsEGevlqMFhDNPRYD5CLv+4PhitJ0xwFxzRWmPm7je/eUgyKq6TtAkiaWVgxeeXDUor5wSXY3sMpWGdN0BTnI4sxfbyGKBDxwsgvfbd3yHuifrILt71B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wbYgDmHP; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wbYgDmHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qE1dS9QWxWnr6MgP7Il/AR6PETcUPuSmZ7nSGkq4fsYy8cK85WTckKyb0Kzf/wffBuGF/baRXry3p1KLrFPVTRscCjoplxahgc8JjdKpvLfhEamDxluIASmHQdegPFqIHQIbW/GIoBudpltr37veDXzXN68XR6ILhsz4Cp3oJ/qOtsPhrDCvAbOiA3dJu1DzmZZTlhLyIvlf10qS9qHjS2ygf9nQBCLWXh5h3xR89xvDykTCXJ9eJdvCySy0X1/Z2fCnety1cg8WES8F/CKTd8lBQGjXqSHmLwAvPSanKQwW44+gfSC/QsekvSfxWbIwVQkjPF1Otxhfrtc2N81mEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1fz0pGxnj1ULB6Oi47+VwRRlBZ4WvQIPMf+/fWGCGs=;
 b=uIDZMqEp68yzLKOyISe/PzlJeJo0ZOwJFX7R2HMhXYt0uW2MKYxbSEfq6vhgGW3vymRNg0AOJ6VfAraNF/fot/2BdTr9i0q1MCVkd/NyGLBtHj5gajBAyIyJW4jAnCa8TMqR2Nb8v67Hhz/9G+WuxgIYZ1HGFKrzCulz6vPZarZ/v8LghfAggH1HCPlVP43KbtCFCGEPI3avrFAPOVL8yaTIwdtsEjakIOVQv270UqEbTcL0bE4cUEtSHxS8viAkaurr7dcBWU5e0otwtlVFZIkvHAmuIHZwS+EcGnDzjuj+6dzMlKHkWIBPq0wnfNrxGlp10VY0vI1u22ABEH+V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1fz0pGxnj1ULB6Oi47+VwRRlBZ4WvQIPMf+/fWGCGs=;
 b=wbYgDmHP31oBe1oMDsb67lOe40X1qdu91vXCESOfNrFgJmPNl9ECgz7/p7qk7ykpD4UzaqqiUfQ/j0zq38LaAcVuU0Fbk/QEaQgY94x2hukf244uNzTUABwa089Bf1Xy5IpArZraNFV0PtrnSJEQ+ueW2jdBPO7XqJMV8WYqV8E=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by EAYPR10MB997925.namprd10.prod.outlook.com (2603:10b6:303:2d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 17:55:55 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::ab) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:55:54 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:50 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:55:49 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpe4052476;
	Wed, 27 May 2026 12:55:45 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning pattern partition property
Date: Wed, 27 May 2026 23:25:16 +0530
Message-ID: <20260527175527.2247679-3-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|EAYPR10MB997925:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2edc95-9842-4bfa-e300-08debc193320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|921020|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KEsEFi3GGy7/pdMbgbaGuDFORB7t1h64V9EAzo5WXcszPdd4/Clr2PBeGQCH20LxBnCOQCvOMJisb4yuTG+mypErOKYsDq5iyj1eY5HgsScWBlKpyrrxGvu8KKdlgYgW8F0uM5LxEVV7Cv4WM+2Dqo1FmcpQqRiKOzkyhAEwnPHeCeHf8WtUkeSmVuIYYUzUvYsYeqafrbl5UiIMuj5LNyHiYVHKtpSFvRUwivfNJm9BhHq8nnEMX+j3F3gNINraPEAlpM2NPzxsvCfCmw9LCnbVB5+vUbkCLecFbSY3lnQIrvE7eGO7dAxgGiHpJkB6EnKndkZpAzQpvYWLI27E5hRqvTXhjmcxmLc683gOlDEAfHiYGMUonIpaWliY9RdDmpr5JdpBK2IGvFAafokrPnWgKl+Q4UuRKahhavuOki1rF+3FQq7evDg2G9MVKALRf4M8qnkYXiRmAVk7j6iQYgaKeJOhQJzT0pKFNoRfaEY4Ft8fwRkGap0b15mPwoswx+mTZjYDrL8rGsETzE72qyAaPKFHOhdFdMQnR8YHJl3CfmZCT8o+xRCyCJALtFyNLLqWj4nyoHSHI4aiafCTsDCGyEzqHBghHIRWYwoOoLFL+AbnQzG8KD0xm0Rx4+oiqmhM4x4zhO1+/5+2wTPcbI77Bv2BSMnLPbAl2WWHW+cTaigbhIjvJVcLcjsW+8orNco902LsxHiSRkTJSsl1xivDxFASoujZcS5+C2E+BHic13oVuIRJN7WDtR7qukXHSLiseQRyrWy4b2bPIG9JyQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(921020)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U4grYMmWhgih8p4HROpO9X9NS5QDgyXuT6mYuf4CiZ2VlZMUAo/M42SoqnLNcSD6OOYE1ck5PyRfYkQGc17RCTUdRPdMQ8GGPUO5zLGKirrmxIdMiMrhjs2odlIE4V7V3reoWT4uUEeOKRLn29BtO9KNnrsewcCkcibGfs06pOBeYXDFUt/be8Gfcd2O9N5NTft2QRLtAlNKoU+QM1MxcNL89N/6I49jUOHbYWHp2iTk7dXKMRwUgwWVZPe3QgXRPyoLx5bz7xj/st5mSyjz9LGGQKRWLa/SNjzZXUCqIbhak00GxIB7p1D+XN1eCNtd+shrA4UTh7loVj7y3yV22D7DiM9NGzeKTMlu+fjC1ML8lYoiiv4WAUrAMe+8CwCTExH23ENsEIEWg4R5CQR6QY53coB6xpl1ofI0py/aQKbaJ2E4f9GESsz412TePSFh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:55:54.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2edc95-9842-4bfa-e300-08debc193320
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997925

PHY tuning requires a known data pattern to be readable from flash.
When no partition is explicitly identified, the controller must search
all available partitions to locate the pattern by label, which adds
overhead and relies on label naming conventions outside the
controller's control.

Add cdns,phy-pattern-partition, a phandle property that allows the DT
author to directly reference the flash partition holding the PHY tuning
pattern. The controller uses this partition during calibration, avoiding
the partition search entirely.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../bindings/spi/cdns,qspi-nor-peripheral-props.yaml      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
index 510b82c177c0..0ffcdf5b00d0 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
@@ -39,4 +39,12 @@ properties:
       Delay in nanoseconds between setting qspi_n_ss_out low and
       first bit transfer.
 
+  cdns,phy-pattern-partition:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the flash partition containing the PHY tuning pattern.
+      When present, the controller uses this partition to locate the
+      pattern data during PHY tuning instead of searching all partitions
+      by label.
+
 additionalProperties: true
-- 
2.34.1

