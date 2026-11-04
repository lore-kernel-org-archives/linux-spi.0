Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776820;
	b=TvpOeIRWvKMHdi5Hh34PSCNX5b94Ww+3WcAlNcoxtWMLNJOKDZAXkBYsaL0MNQI+6qvM
	 7iFEquTHXYmepm8mPrWlcyFQqOj5AIM+vcfcah1sbLk+S0wOZsBjHXPgKcdzSMNIVQSpU
	 vpqD73zvmLirdDEi3ci/AA3UYJ2409vUKDob9HKE+DR+e3cImHa33s+Eviy/H4Xv0qUBj
	 3F9XVHpP4wQ/LC3p4uhUTexjXAQO7HinhmNpNFVp27fa5o3UebjRqFb+bqi/BmUsvtUCH
	 45dnzCfLZhAbsZtsJsTzqavru3Zrnul9ut8ZsyRHOP8vQfWsVvdeQav1Ahz2ThjVNJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776820;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=oIv8sMpd96xMB0TLIR9uYqirs4Q3bvdAmLNlpjQDCzE=;
	b=YiFLS3AvuL5yjyIqkEyqLUSkh2TdO9CCPmcr6EFb6Lf96OyJE/fE1quY/tZhBy/CG/Qb
	 uJfHd5u0HPyOCVcVexFeYPE4C2qo4NFGemGzRPzZ3G64APBzd4ItF/xSUiRMBHPuOiLdT
	 OSdKEH6rQo9QEbInB5hl+DRqqqaINCstdj++Umyno1UJuTh16jmhFH6PjQXGJR7Y4nXwC
	 jjnSZ9fCimJ9Q3CC4xJpfOtihoIvaIbQoWcOoFIqDxOwyVKIeudVBe35/I5GwcMwXsFFc
	 gb/9f8ULbFs4caa7xdts8iHz1/0jJBa/Xc581S85SJSNrghYn+IkhdU0CT/e5h6ZBBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cKTD0gZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.67
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25828606A32C;
	Wed,  4 Nov 2026 07:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25828606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cKTD0gZQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWP4gmc7sQrMWzgnH2mS1yPYWsUYM4444F3ZRitlQcwtr2GrAlq0Y4saFWyL2t7Xb7dUf3UJD72HTVX8PqAkVAdsRx4oLTKpFBcBS7a3/HIRTUanGX6v4Qhar1vAkhmG9t5pBAnE3BaWtOGqBVE+acU+kY5ySwYXs+ugS4o1sd7xEeId5thaY4lf14LnVvUJwIgshFO3WsVvTpx7I+yIH7QRDlHwR9lF6DVYX2f+vJ1TwY71JVDcAkYS0GKURM4DpT7Uw70CjNwWI+Q0ONLj6VKlcJPhj+ZiPPPwhNb4/BGvo5ekUoTzVJY5bNIJDtX+Aw7LE7C+n+8Xoab8O1Kr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIv8sMpd96xMB0TLIR9uYqirs4Q3bvdAmLNlpjQDCzE=;
 b=mBssVi8wuzb/1Ez21psfYPK1GIpAhDjcEbza6laSgCmIr64guWsmTpbbHFlsk7op82C0ubaiujRwDVwPMf2uBAqq++q6sWFVJVv5uaLm4dlkrDhbO85tIoW38HqfkdPd9jDfkExyL/yd+XAAYB5ygMnMgaKNCqt3zTApSo5+HWfX+xgD5jwjb9QuIMNkubLZ1QwvNuykRlTpbEA/Mnd+H5cMkZVhHr8JGhbGBOmjJLTdJyARRVoxrcySzkZOoP6oGFZE/ozRhkJIJJWO4zemxsjRmP9Fs+V6gsPTVHO7GLhJGhcoBBARDT+y0Z3glfCb3oSuRH7tsttFGXaNQc+98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIv8sMpd96xMB0TLIR9uYqirs4Q3bvdAmLNlpjQDCzE=;
 b=cKTD0gZQtQOAtinPVMPqwxoieaI28rD9p4IAQ3XpObx0KDSLx56sV+0YKaUioJHYFguFc3Dn9BhMCtWM9E6cpaf21QcEg+IQosc/sYYEVspCKDUXEFQmb8XiBrxJLyzbXEY5eAMXOE2gKVhuJkJ1Zb0sKubGKBHulbZxcDXsoLU=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by SJ2PR12MB8805.namprd12.prod.outlook.com (2603:10b6:a03:4d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 07:20:16 +0000
Received: from CH2PEPF000166C3.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::93) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 07:20:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C3.mail.protection.outlook.com (10.167.244.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 07:20:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 01:20:09 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 01:20:09 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 01:20:06 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <broonie@kernel.org>, <lakshmi.sai.krishna.potthuri@xilinx.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Frederic Konrad <fkonrad@amd.com>, Srikanth Boyapally
	<srikanth.boyapally@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH] spi: cadence-quadspi: Fix race between DMA completion and transfer start
Date: Wed, 4 Nov 2026 12:49:58 +0530
Message-ID: <20261104071958.2405117-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C3:EE_|SJ2PR12MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: dabcc2ff-c568-48ec-df27-08df3a441324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261021123027099003|261026140227099003|11063799006|261026121527099003|261022105027099003|56012099006|261009221227099003|261009223027099003|261028144727099003|261021121427099003|10067099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	a/GFQxFyance85U0gtuMfBphSWQSZpHfowHqQbvj3hWmNHQBxAEBMlV0j1D2cAAgXll65sWYJRmf5zN+mivjgmYUN/FlEAUtBOFIreBtnfM4SkYNWTQtt9LYNQu0bGNgHN61HFkM3pLeiRy7YgKUg3iEt0HSvYJBhXyHcjXuLKVg7wQmY0hX2WpABSvpy1OKkUe9kN++pyHoEH8AEXBEpop7dhcfz5Vgqo3GDcsa629ieOtnN/nL786T0OxjFfTI/5Fp9VzjSH6Ohdvo3O4H0jogqd11zV+W+JWyt7BrLLt5uLbdonioEmw2AOXaDx1gfpm4BZYholCDixUOjSkzf+XGQgQRcoWynWscFnGt8Q7UhmnJFzA/TKv6Z50TAGFJ2FUYHuw3v+DvHNWrmgYDLzBnne5l3ldeO+KA56Ho/3q+hpvLVqX99wvaHHfyA49TYRHmvblmYViQojng/n4riJP9/CK9yuk9zRzG2vKmui88Lccr7u7qHQONJwLoYWhdKqim9kT0YfCr84PWhzWS2S4qXuj7DpR93ghkb7SBi+bD8WDUmokd5VGjtSxSvcGhOsKeRCQz7uYS1YQmWOlvUzYeh11RYIVzt/MCNXt1If03Qp4LjF0h79bbOcWFzd4ILDdikLQeU3mi/LMSkeWI6ryjuhPPemWfdZ30Wc+jZkBnz4HOeC9+XpA8ubcbVCxwHhlaItnGtBdQb3eSlsq2nQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261021123027099003)(261026140227099003)(11063799006)(261026121527099003)(261022105027099003)(56012099006)(261009221227099003)(261009223027099003)(261028144727099003)(261021121427099003)(10067099003)(18002099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	As2/XuFIC41IBhTkCzMwZB+mPpZLqrMfPSA4by/GqrYEO+u93DyzD4hV/27CGVpcHtKLz0MR1ZLFCuOIMBdsg480U7jsK8C7sOm9GcTCR5qaSKNlhwEfFNMnd3MK0rTXisOpbbEzhMCv/WIgxa6r06lb0MPp+qH7hR+OMcQyU4V37oUTfn/GUFHlyDuRQJCwit/TFsulGTflf3KjlEyE7o0VaNq3I0QOb+qhcJ4XsIpRBcsxSWy7CPaNf0RNULCijwfyqcCM5+ZmO4hvP+NyTBPlTPhaXDR783S1BRuvnghsKSgMRXFQAk6bRjIa2ZVriijct6c1y+q9cdYBQFCxO9dQAEBJ+Y+r+pf+T71UgJlT0XCmRJYmJvBSMPOGR+uvTMU7HIHAvf6ML6Vqa197gWU5mK/WgrZ1LwHYqPTcgApRhxzBN2iEarenH4s+xd/W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:20:16.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dabcc2ff-c568-48ec-df27-08df3a441324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8805

From: Frederic Konrad <fkonrad@amd.com>

In cqspi_versal_indirect_read_dma(), the DMA transfer is started by
writing CQSPI_REG_INDIRECTRD_START_MASK to the indirect read control
register. Under certain timing conditions, the DMA completion interrupt
may be triggered and complete the transfer before the completion
structure is reinitialized.

This creates a race where the completion event is lost, causing
wait_for_completion_timeout() to time out even though the transfer has
already completed, resulting in errors such as:

  spi-nor spi0.0: CS0: operation failed with -110

Fix this by reinitializing the completion structure before starting the
DMA transfer, ensuring that any completion event generated after the
transfer begins is correctly observed.

Fixes: 1a6f854f7daa ("spi: cadence-quadspi: Add Xilinx Versal external DMA support")
Signed-off-by: Frederic Konrad <fkonrad@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73ea51c41f95..44d96b8cf8f0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -955,11 +955,11 @@ static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 	writel(CQSPI_REG_VERSAL_DMA_DST_CTRL_VAL,
 	       reg_base + CQSPI_REG_VERSAL_DMA_DST_CTRL);
 
+	reinit_completion(&cqspi->transfer_complete);
+
 	writel(CQSPI_REG_INDIRECTRD_START_MASK,
 	       reg_base + CQSPI_REG_INDIRECTRD);
 
-	reinit_completion(&cqspi->transfer_complete);
-
 	if (!wait_for_completion_timeout(&cqspi->transfer_complete,
 					 msecs_to_jiffies(max_t(size_t, bytes_to_dma, 500)))) {
 		ret = -ETIMEDOUT;

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.44.4

