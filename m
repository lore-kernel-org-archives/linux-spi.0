Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794761814;
	b=nl2bNaBV//+sav26XtQQAzBfznu3Md0hbU2V183EyA8RTTQr4F25//mL9sexBHlmt2V0
	 4lNBNoFVtctGml2ADPid4NAX2YgF3hu6OCG41erZ+UVZNQ5+LMLCGd2MGWoicok30+5u8
	 Ep7yF9Vc/ovVQdtkZ25pSmfGFqe/1WFVAexcIL0gUtCRH37+AJZmurnhAXjEw7E6owG3N
	 yOlGizWBQSnLGe2+BGre1CRHR6AD7EqStt08FZlNgkiAd5lorbwqsarIb/TZntQryC8kb
	 zraGAyevszn8QI6hfJHnopV93P/XM1Fh0znxwJP9Q4BsXZMJs5h9H2lFdclk9537BeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794761814;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
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
	bh=jwfAv9KT/gvVyFrTHdgfsAqWsfvLvjtF8C8JwclUSFY=;
	b=i6Xq3J3n3cMIvkvpsunvRUvhT6r3beuUJZ26Ow5jxIyIIkhvW5n3LE6FNHBTI+oA1X+c
	 QiV/t935OoOKzyxsUG479IVHvVnJlo7GkeoKAqs4GQLygXN+318WNSlscFcnN6TlXxIkV
	 q5ICgIlipBtcte1/VAfZGICurONX+eVL6Ci/MMfOV/JuTrM9ca1BHJTkpIFnLv3wXkepu
	 +2OQdGVWN0mB1Xz9yKh2lRIdAN23KJVIaeIIRXbuLYfhYkvWt2xXXbKTNx5ko5HT6d4aO
	 hgVAoFk/hAYp7HbCOABC3n6RbEmbpaBB5Xyguuv9RLRqcf18RpZBAx3lWZAMdc4wB1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="0a5Ve/5g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.56
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F354606A31E;
	Sun, 15 Nov 2026 16:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F354606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0a5Ve/5g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsh3GbuHci94F706eFHMfZUSXCUrzESsMg+VBKeGrdabUOXluufJrmMD+rsm/AUMoVzyGSHI5rHf5XlTicBqztzBnu9DVBvXBcQ01hFsehfP+EzyFWBJNBwScKTd+g/1yE+0Zyc4w/WB9R1mMk6gb0qkVAe2aQBZJQmPk/wRRxGBrB8kDb4uGh9nJ3LfEAaUwJUn2Vqp1eMenmalw5La272uvknjzJvS47i5PQ+ZF3xvgxqsY+0G9sivJQCl//vskUc2yJU0oSJKntmMRaK68A6FUpuU26TKYTsEei8PXYYwieb9etLrhTBtRYSB8U3T+c7zEFdZgffdTGbVNeT27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwfAv9KT/gvVyFrTHdgfsAqWsfvLvjtF8C8JwclUSFY=;
 b=Xms/duwmcigQG39YJ0EB7c3zeEZfAfFN37F6xfmA8bCE9ANOYbC8sKbQilensN/bOkfyjYU0NpirCvx3EgB02gYxGpB4wyGPmgahOjTfx1MD12Ttr2KeI/Ygq37ZO1UphNajq5dFMGPbEdILU32AFYylvwsvVaoPZUW+VgvqzC5uKRqL4mclOwKcTAshwwA6YUFUxB1w6nZGR0FKYI1BEkDVAOvdtMoino3SGR+S7vvNUP9Q4ToqwBXE3jxlzVOUQOR1faQTyufbiuTXhlXZgIGBUT7LM4MeZQN3RADtsfiQX9DGcVrZGwVenf1X5XK8Atoa9zu6WMoIhp4O0eQp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwfAv9KT/gvVyFrTHdgfsAqWsfvLvjtF8C8JwclUSFY=;
 b=0a5Ve/5gH3oFvfbudJMneb9pMYnMYxVnXkbqiN/PNqUxyK+a5enAlrPhv9ky1GwRQSqRakhc5o95KfmdyAgiSINqTpqr8vyscE3qHi8OVmMob5NTr8FEJebjBdpHk9RI0nOVv9lnDuBvOlGDEIbZ51YblWWRB6e5MkcKnh2WDxc=
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 15 Nov
 2026 16:56:49 +0000
Received: from BY1PEPF00026959.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::53) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Sun,
 15 Nov 2026 16:56:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026959.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sun, 15 Nov 2026 16:56:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 15 Nov
 2026 10:56:47 -0600
Received: from xhdsboyapal40x.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 15 Nov 2026 10:56:45 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Sun, 15 Nov 2026 22:26:40 +0530
Subject: [PATCH 1/5] spi: spi-zynqmp-gqspi: Factor out
 zynqmp_qspi_disable_hw()
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
Message-ID: <20261115-qspi_14_11-v1-1-23425ed177bf@amd.com>
References: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
In-Reply-To: <20261115-qspi_14_11-v1-0-23425ed177bf@amd.com>
To: <michal.simek@amd.com>, <ranjit.waghmode@xilinx.com>, <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794761802; l=3494;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=eUdFmEA2uwXKj7sDr2IechKU84/eSHhk0pPowcwOHjQ=;
 b=/TNspH9cHieoYg3SoFZFTwpzdQNCMbNyLeAd6V+XVmI7UJNcSgERq9+uqsjjMhJSxMV6xC30p
 CMW0tHjjerUCNapW2fDuczJzXCfVKrU3ixSg8C6jLP+INA8F55Crg23
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026959:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: f72d8dd0-75dc-49af-4df6-08df4339707d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y+43pP2bWsA5I+yBe+0WIRkHncb1FZYI29TbWgQspq916F/vHk//y33OU7fykk8WvwL85c9EAWK5CdHi/mZ91eNQYoMUSwIb+UO2ZzbDJR0Z/yXCB4K7tF/1w5/rybHI9B6uPPVrUAm7ttBFvNusxGKgbK7Th9Q5jYxF51qFzb7Z49WMLYcKRaG9TlDF8CsbaVoNAcIdf4u8sNclakx9O2ECth5souueBxZeWbFASU7qrfU5ZOhzYddWuYg6V09YiOBdvqW7HLzVg91Xx85kcnTM4d5JdKO0cPFIogrYFyhsXdwlotAF6v1spJtlyDZhRUBABWPiUH2VmfY6TLtpCIq3xzzHoXFQ5jeHEKtHaPy6+NPvtE2OTaxWlhrbnCpXeyxybG4NymnWCweXc50x8QPuNLT4m16Yn/MkdMGIzY36CvfQEoXYiICaP9ngGpLMPw0Nm+Ni7xuuw0tfvUwJ39EleZWImBliUJQcr6RwvUuyS8a96AuKUm+7toK6JtmpcdZHxZQ3bQU+jvR/JtVHzybrk6QASny9zhpmKJ5UkKwSUD++xbheEQ63LHHHwplAkzaTPZasBahF84tAM4e9u/DcX1raGPATGKvGAJ6mjjyPENBRdEI5XUwU9yW6mTfhEk6tldqhdBTzZj7+rQ2/1/5K2nvTXeUQ+8gGpv/lK1C88Mh3vJZPayYqDrRIF/DcJ3rvxwnbB44ukF/OTJIkfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K042Vc+rrHGrLMQciqvItAopGFGXcpSMsOfuk/UX7Xxga6r9VcTWrwFdctdmIW8nTcthkzCoQK6decPSPWRsxXvxxymRrz48N6O8ne45oX6Cta3IxpzR+rgnRfXy+ifU1kKidWlKdV8lgi4s92xjDLnspBGgNoWLQT189jYjPL2QBh03NHRmFpCimx0iJNbXrLVZdBhy1EIh5tY4KhPO6dtZDSfA5wmk0/jUgIwAePPgQyMQ1sAKoZ/AH9em8u81vuY2o+8mVrM94S5aws/M+mUSud9tjqOZfi+miwk26jVVKDd5IG3W+ikkI8kviik+HLNsavPlKJbLfAn1VOSqvF1Cee9knGhBRodPVL1Zl1601CoLC2HZ+lIlO4eWwMMxxBffyVeMiSHjRWZkZkMadcGBchQff9ZPfStc6n6hY+bA1l2g3+PwCc5AhC88Q9Ls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 16:56:48.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72d8dd0-75dc-49af-4df6-08df4339707d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026959.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132

From: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>

Move the clear-mask-disable sequence out of zynqmp_qspi_init_hw() into
its own zynqmp_qspi_disable_hw(), so it can be reused by other paths
that need to stop the controller.

No functional change: this is pure code motion, zynqmp_qspi_init_hw()
calls the new helper in exactly the same place it used to run the
sequence inline.

Signed-off-by: Mohammad Zeeshan <zeeshan.mohammad2@amd.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 54 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 15e9d3ef8839..0da44ebaf39c 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -280,6 +280,38 @@ static void zynqmp_gqspi_selecttarget(struct zynqmp_qspi *instanceptr,
 	}
 }
 
+/**
+ * zynqmp_qspi_disable_hw - Clear and mask all interrupts, stop the controller
+ * @xqspi:	Pointer to the zynqmp_qspi structure
+ *
+ * Acknowledges any pending GQSPI and DMA status, masks every interrupt source
+ * and disables the controller. Used when (re)initialising the hardware and
+ * when handing the system over on reboot, poweroff or kexec.
+ */
+static void zynqmp_qspi_disable_hw(struct zynqmp_qspi *xqspi)
+{
+	/* Select the GQSPI mode */
+	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
+	/* Clear and disable interrupts */
+	zynqmp_gqspi_write(xqspi, GQSPI_ISR_OFST,
+			   zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST) |
+			   GQSPI_ISR_WR_TO_CLR_MASK);
+	/* Clear the DMA STS */
+	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST,
+			   zynqmp_gqspi_read(xqspi,
+					     GQSPI_QSPIDMA_DST_I_STS_OFST));
+	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_STS_OFST,
+			   zynqmp_gqspi_read(xqspi,
+					     GQSPI_QSPIDMA_DST_STS_OFST) |
+					     GQSPI_QSPIDMA_DST_STS_WTC);
+	zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_IDR_ALL_MASK);
+	zynqmp_gqspi_write(xqspi,
+			   GQSPI_QSPIDMA_DST_I_DIS_OFST,
+			   GQSPI_QSPIDMA_DST_INTR_ALL_MASK);
+	/* Disable the GQSPI */
+	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+}
+
 /**
  * zynqmp_qspi_set_tapdelay:   To configure qspi tap delays
  * @xqspi:             Pointer to the zynqmp_qspi structure
@@ -355,26 +387,8 @@ static void zynqmp_qspi_init_hw(struct zynqmp_qspi *xqspi)
 	u32 config_reg, baud_rate_val = 0;
 	ulong clk_rate;
 
-	/* Select the GQSPI mode */
-	zynqmp_gqspi_write(xqspi, GQSPI_SEL_OFST, GQSPI_SEL_MASK);
-	/* Clear and disable interrupts */
-	zynqmp_gqspi_write(xqspi, GQSPI_ISR_OFST,
-			   zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST) |
-			   GQSPI_ISR_WR_TO_CLR_MASK);
-	/* Clear the DMA STS */
-	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_I_STS_OFST,
-			   zynqmp_gqspi_read(xqspi,
-					     GQSPI_QSPIDMA_DST_I_STS_OFST));
-	zynqmp_gqspi_write(xqspi, GQSPI_QSPIDMA_DST_STS_OFST,
-			   zynqmp_gqspi_read(xqspi,
-					     GQSPI_QSPIDMA_DST_STS_OFST) |
-					     GQSPI_QSPIDMA_DST_STS_WTC);
-	zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_IDR_ALL_MASK);
-	zynqmp_gqspi_write(xqspi,
-			   GQSPI_QSPIDMA_DST_I_DIS_OFST,
-			   GQSPI_QSPIDMA_DST_INTR_ALL_MASK);
-	/* Disable the GQSPI */
-	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+	zynqmp_qspi_disable_hw(xqspi);
+
 	config_reg = zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST);
 	config_reg &= ~GQSPI_CFG_MODE_EN_MASK;
 	/* Manual start */

-- 
2.43.0

