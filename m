Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795166389;
	b=XYaJsgzjB9IAlZMG3PNbHuFuZr3O6gOVfrS8KSyOLaEi6nh0PQERfP3yTF9VbucsSy5h
	 e+rsl7lJZDkRjwweRMfNlG1gR1sA2+Y2tP2fY4ri8LYvyAN6xsB3wtRx1dz1ezNfPICuS
	 Snn9kEXjnCFzkL7zUtCZD6QWZhAIsMDTqnAfnrYPDj8sXSSdn2HRkyVcmQdb0cSfDnlRG
	 wI/a0AjnPE/7M6/4DvpOPhMXnrzVU7ohwzh0QB79MYilc5E9Y8CKNn8BfgmM2Kwjmky92
	 r7C8kicHSkSNbkxRp740qdpDNiAIDHLSaf6fNCb5SRZcQQCOj+LgWqDU73yva8VxL+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166389;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=slz8MpQ4QLb+WyKX1ypMEjpgLcHUFEnkA/QJmcIuTs0=;
	b=wV039qdWLc9rVgBN66eARzZIkXT76TjuQC/rfuWXcjOLck4qst56UyiuG/HkY7I9ADIv
	 QvBD7Vdu1ZgTHNDxeJQEjyD9d44+Gsk0ciLfizH+M7bMRVlFC8FbGhfMOLRfwJzqFncsF
	 gLj4rIiOdqvuvzlOpACadF0N4kz7ys/RhiyozCjMmRpBg4+vHsozG8xKSGmXOa7vxc2q5
	 /1HiK+grQAx/QAFCz47xFBosKV4izU/qdAoCzIpY0aNN/I2vbVUHXCWMPW42C/IH76D6X
	 vVupjerFrP47n8RL8KCejOZVtry7rLqIRnI4+WnEMn+7NsECALxdPniS0aJntlv5ZVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2KOjZz41;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B18606A320;
	Fri, 20 Nov 2026 09:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B18606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2KOjZz41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezFcP+IyCQgAdEUfPpmw4NdtwbNZBRfysA3qXfrtpAxGgHpfaCNAgP91FiiMMAl4+wivaAmkdEsxSuBjSQyukCqcw3yLyE2b3pHL2Gr4xYMemSPZ+6HrK3TnkEd/kMrT0AbXJnjEEHW5xMTsDPM+5AF8M8pvLsUJzzzgSG5WYEOg7Phy7SqZ91gWG9HY0sQbCoRehWrBYccQuPYYIy+8E2n78cU313viZShdTiy1OWt0ofARc+40WJnDSiuW2NSR34c2i5QsEddXH6IZ8zkzv0pT6CzjKGl7pmbi8y8IZUCR3fA4Bk0sjAi8o/Okz4sfBWigbtWVAwAWptkXKz6FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slz8MpQ4QLb+WyKX1ypMEjpgLcHUFEnkA/QJmcIuTs0=;
 b=cG9MwpjDaAIBbtTviqdCkjIhCQwOEhsc6KhrWQnoBhVGefEw+7Ze6256fFGLifnFJXrBNUlBsqdr4g3VLLdPqlYOIJy0wqFQU+urXc3MgsOKJPcdhaUqe8UCU38wZLMsnPMZg1CWyKj8lRCuFED96WjzS3hvHoUa5niDIVYMo9lbkaerEIfmQy17y2/GsGku0MkUtQE0Ig2NGRG9Bk2yfcS43ue8/lKPRnOR6KubTzQc5pEn/r8/OiWv+/ZpS2qPiyATiD4fJ/ygetkFyX+AsId2G+24TCXhsGjkbKDhnXueh+wAT0Fub4UE2xQJFHvqrjEW90SnrvythzCNZjaOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slz8MpQ4QLb+WyKX1ypMEjpgLcHUFEnkA/QJmcIuTs0=;
 b=2KOjZz41SVlTJKDSDOgqbeLeHhysp/Jhe27pBEbGTyfleyEzEogHRGaYiZ0pz5oYDR1dwQW7eudd6Px0jvTI8jVEBhXoAOa4kNKrXkr/xJUt9/QdsYUHO0r2EamfIAKU87MZkQWqRs1FBXOMDZnyQ+CL3bS1qpNe4fWLCrRk0DA=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Fri, 20 Nov 2026 09:19:45 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::24) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 09:19:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 09:19:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 03:19:44 -0600
Received: from xhdlc220225.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 20 Nov 2026 03:19:42 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Fri, 20 Nov 2026 14:49:26 +0530
Subject: [PATCH] spi: cadence-quadspi: Bypass STIG for Versal and Versal
 Gen 2 OSPI data
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-ospi_stig-v1-1-54f4d5f9f7b9@amd.com>
X-B4-Tracking: v=1; b=H4sIAJ0QAGsC/yXM0QpAMBSA4VdZ59pqmyx5FUnDwXEx2hkpeXfD5
 Vd//wWMgZChEhcEPIhp9Qk6E9DPzk8oaUgGo4zV2ii58kYtR5pkYQbMnbWuHAtI/RZwpPN71c1
 v3rsF+/gO4L4fVptFqW0AAAA=
X-Change-ID: 20261120-ospi_stig-52de3a66a8f5
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <git@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Srikanth Boyapally
	<srikanth.boyapally@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166382; l=1944;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=lV3rZOQFdNdm+7B0BZaAaaqtQ2y6joNZoEyNP+nYujE=;
 b=6aOVjyREbCuUipWqC/fN5xdTNr+wwdLx2HEfqWyv2xxAdl2Y2oQYG7cWa7Ev//5GkxwCiDhuz
 hi6AtulTKhbDdtruAFhPi/o2BXjvx6yvBNTOuhlIOyUgA3/AgNhWFY2
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 1126e624-a002-4a42-180c-08df46e76aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bw2x22PYbkleH9kQhT11wbHf7LSQJEwcXmmKeUoZd5QmIJEp9vkqnzLzJRiRyOUh1jOLaPJ4sjT242R7sbdB15eHEM3cR9slAB0iX9rWarsY5q0FeF33tYtDbUZQrxbrss4UTNq104XKLKfNaLShCklWg12Y6YZeRAToes/96rWpcPnavpygUg6F/QS1ygtXXdInl7ifrFL8sFBqG9EEfL7oIGa7RsIt1xoxUAa2Jj0rit2KEPWHvXwV0vchRrfpnRX4+s58qdHjPXbQmh4hDJ4Po7PNrXW/Z419WLUxSxGIERw4gjZ77urj5nuYLZS88CGIRL6wzUX45pqKTjnBBst4zjwAajnvwjdNaJpbH2ef9Jwgb3PdA8KzKUUZncMsxPJwkIe2EPr91M5v9xQQAdk42kaBL12mqTfoT/c6jTs0PO+zGLI05+BqVWxVZ6+xzyetG9eryG0fbJ3cSBiaYw25FVCohgeIBZKZ9554Zctf1W+0wM+5g+dj/Mqzsc1Q1PnrwKQ9R134Pu3v40g86DSGYeRVYdW7tUolMAhMdHFGmPKZWjQpuvsq70gQn6NHqQmYj0Cb5z52cZjataTScQx1jiO6XSPrh0os/yneirVyCaQjtSBtSYkp5FaszxgD6lrXDJ89RusVJP/WRA7OE/uZ2yZv5W43bYSWsQq8FKyL4gIit+Ham25PN9sOnmDmNvTll+/NpcAvme12i68uog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bOgIfVcmSKe1R7z5PJwveADMZiYNJySVAzIRGsSh9LRpTjmfcN4jno1CkbvsZEdTwyy3y9BBbCavSI5/p9qXacLeFK9oEXKOFHAnQYcea9R5E5kxH4unbi8rafhdFki/WXgt0vdtm5DkXhQhE5/Tvd49sprDHOnkxaUHpcWnkYoWbm3g0qGuEOh90VXsN5lCCbWds7D2IzJE/z9nG/SsHsNJvGEgcz6joaGdFvzJ9A7FLtt8QXSAgGIJ+8lvyOTAQ6eNHWjdbfqgt2aIZ4Y8vcNhWFwoa1BVRAgy1hNhX18A6kMSgi/KYJrQcVFJA0AdnlZBObofQIi1dvUk6wp9he4Q97NUODa7Rnut9esHekwKfw6IP1Q55vXk6xG9mv2phuGBqULkJ3HGKWqdpS2iDMg5BYGjvRWIB5NlPj4MJ4RevrnK2pZVqYUWkB9wO0vu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:19:45.4278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1126e624-a002-4a42-180c-08df46e76aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

The OSPI controllers on Versal and Versal Gen 2 support STIG data
transfers in 1-1-1 and 8-8-8 modes. Short data transfers in 1-1-8 and
1-8-8 modes fail when routed through STIG.

Set CQSPI_DISABLE_STIG_MODE in the platform data for both controllers
to route addressed data transfers through the regular data path. Keep
STIG for register reads and writes without an address.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 844df97111d7..4e2ae41ffee3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2122,7 +2122,7 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
-		  CQSPI_DMA_SET_MASK,
+		  CQSPI_DMA_SET_MASK | CQSPI_DISABLE_STIG_MODE,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
@@ -2130,7 +2130,8 @@ static const struct cqspi_driver_platdata versal_ospi = {
 static const struct cqspi_driver_platdata versal2_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
-		  CQSPI_DMA_SET_MASK | CQSPI_SUPPORT_DEVICE_RESET,
+		  CQSPI_DMA_SET_MASK | CQSPI_DISABLE_STIG_MODE |
+		  CQSPI_SUPPORT_DEVICE_RESET,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };

---
base-commit: 715e17fd0157db208c893de8afb5072b86c0a562
change-id: 20261120-ospi_stig-52de3a66a8f5

Best regards,
--  
Srikanth Boyapally <srikanth.boyapally@amd.com>

