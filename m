Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588985;
	b=LKP66IiXPymOq+LaGAcd1qM7Zw1B6Hn7IxDaF6U7BmEo9BLd5dnB0uyqxoHyPndl+gta
	 gGhc8+3RWyMw0jpD/SOqzMCvdkVB7UpCq0ZsCtKDI0E/fBb795VojP9ziPvt083FQdD5m
	 Ubn3NJP5MA0nWdSBVuaBeweZ/0myJj+BzQ/gb4c72DzEsb/cnLq5wZT9qKFn3MyL4k2sm
	 pFl25vQIzY7BbKuF7wr15/oglABJlYAKnVwmZ2//i906o7rDx4qGC4AWIR55umDH7ot32
	 GPb+L5WPEpnZhxP/CMjPiUrY/T4PUWrzLszc84/PcEtJYYIWmqlp8ik0ci8rr90PjEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588985;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:Subject:From:Message-ID:In-Reply-To:References:
	 To:CC:MIME-Version:Content-Type:X-NV-OnPremToCloud:
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
	bh=lzAni6VQtVo+0SZhL91wajBQOIVHo5for/wg7l7Dl2U=;
	b=b/b7gSCd/vlrUGqjWz+4RlmQOzNkABytX6Dm/6HBy3rAWEcquwPWYNPnlvQiFs+rx+Lf
	 LPehXvY/Dji0/jR2FisS787RWUp6HnQ4WMB7XJIxWtXfNaW4+DH8WjxYFeR1BzYrWHlwd
	 IUjHqLcPmkixsFoG3hOZW5AojVLxeJbxp3ZfAu4fezX9EnqJuPzXOKItYRIMURAw96GjS
	 atWokGrOtbfJpnbzBzAcjup6yv2/RzLo9LVj0y64szkGTgRwyGCdZGspbD0Q5aiMldxCL
	 7FRQzXY4HD3+kIHox30BXyAN0U6EUkDQRgCoq+deVEoHsk0WKu6umoHFygFxNGVVkCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H4Q4Qysn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.41
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C6606A324;
	Wed, 21 Oct 2026 13:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9C6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H4Q4Qysn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EewtIH123VcSvF7vnJO4oFwudyyQXHSB2XBamuXy0XYErkqufIviHFj9ROKg45F7/ym7S8lGkDR3TWnFcqGYVP2onbgPO4ZH0nu6MMHDMxfafr4xQVHRPzss6vPWnCAyxVQcu3yQIwjJ6gMSlRoAjp+9jgPDM1UuerU/ZFKUp89B0SHd6B6kmEmDNlR2OdzJyXXHJegjmWYZuHzRKZw2AlmJodmurht7O34XmjnbpWru/AFDCt+kWU+eT8qMjtnVY2fWflZG7eY/El90Ne02HhGVKzCisT/1iMTaNN+qgQoTH8NEqDJfQXbp2ek5UKTnjoSCFh3OD8NoTvpRGcncdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzAni6VQtVo+0SZhL91wajBQOIVHo5for/wg7l7Dl2U=;
 b=NelFw8D7u9gdZPQQyMPNW/Jnc73A9FhkIf1/xS79JzP+2aOmvryi5I4Hxyr66IAvbOD9IPBcF3aZvpK3r4kRiMNbp60i8irZTrhTsqiWbQgyu7L6BitYIaBlu00BPotTWiEXaO3pfBoE7x4dlTxVnevsqDOgb5cr3Hp5ccbIci5THULoeWMLf1AGXxRZgXiD03MOlDcKkxLlUYkNGYIWrFRCha83TtVh5TzEK6zSMNZtWPoNxtompetOxS3Q0/bgyRpvvAfRYH9Y25MOQq62MqEPB7XbdnevD7Mjpc6DKBgwK3PPBkt9nElzsrm0tdrwTHYVaGuhLpQsuHTxSZ2Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzAni6VQtVo+0SZhL91wajBQOIVHo5for/wg7l7Dl2U=;
 b=H4Q4QysnfgwW2WZGU0mlnIkItfLhAnn/LqRd83qLBqG0QrfACEqymRE20DmwCS/kwbbMcwRlGrQHaPLqYYIuvDEl32pJtZDz6x9mShcs5ZQEciYfnDMVmQ3NjOIJBqvr42hEkVOcynY2wcrR5cXo5EBiNIDS4vUcoputW5yIvbM82v1ZpEHupa30AfaWE2e3HKd4ikcj4RrDt5U/nXNEIz9Vp4oBOECmTzinC5I6VYXVRdqWvn27MdB3Orpfv1zHNOcjOFnJ72g8WQFywq4S/f0W3jrWNAyIK/UpNv6In0vbbPfsY9sh6rqk+plq4ngVWAcCW5hNKtX7NOOLkN+zMA==
Received: from CH2PR19CA0012.namprd19.prod.outlook.com (2603:10b6:610:4d::22)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:22:57 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::9b) by CH2PR19CA0012.outlook.office365.com
 (2603:10b6:610:4d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 13:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:22:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:38 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:37 -0700
Date: Tue, 18 Aug 2026 14:55:51 +0000
Subject: [PATCH 4/5] spi: tegra114: Decide the chip-select mode once per
 message
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.18165349705554836759@nvidia.com>
In-Reply-To: <179258895296.403962.3492255118456900623@nvidia.com>
References: <179258895296.403962.3492255118456900623@nvidia.com>
To: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
	"Sowjanya Komatineni" <skomatineni@nvidia.com>, Rhyland Klein
	<rklein@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, Krishna
 Yarlagadda <kyarlagadda@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: d945ae52-de66-44a6-1aad-08df2f766bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|261009223327099003|261009221227099003|261009220027099003|261009221727099003|10067099003|261009223027099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FkneY/QnqQNkQrCUyG++xCBPsxW4JBJa4ygG0XX/n58C0r7IFx0gYJ99fOz75oAnxrVtzqnx/qIUVP61OG4i7jYRK0KOOgw4H+QB3LhiMAhdjvi0FaeWYgtb1gnCUo+YG6lecmbP9e+EjA5sxYhIDxlaAONZlJqJL64DAWR2kGONxIPbqd5YXIcpYArkpKgSaEtyyBUFrKyVEjwUBEOSyS72YmkxlF+PD6VGqhtkuSZ+8Xzs2z7EQZya8vGE89SbtJgCtM7HWcYJeGuypESgNB7C8qToJlSY+GwO8/Xi+s2Aq1JBesC/XrCrP1pAGkuU44B9kt0bfAtr0GH8m4wGRZdLRzwFD4RBRpykPO1qoBs2sMqgzhCDCC/lb600OJnBdLNSnjsjLVslfv++yFuWqnouS9fmoo4x6tqvBFMfc10hH//lkws6NGiGLymuZQVCfT8y7L3gAeSX1sCunQuX2UHGhzjgjM+xSbgYmQdVzf55UnfDFWswUNSYf+te6gjLFHMqfNv3rEARH41nnn3zRm/ZvXG75koXnZ8rdy6H8LK2gl4/jpGfrw2F6vVDS6yEaZub2J+XwJmPmefE6prRzv+yMrUHKOfo+IIVg1NCIGlzyMdbTfw/YHAOVPF9qhbqR1DE2fIo4OGLU8hVwFHtFvRs8XyBbqsXcppDuE49mrATWOVYKSoxq670YpxhZ0QitGr/C5Nrj5Tulqm9HtIF1g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(10067099003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bm/CXcAtGZLElGyjM5/lnHmBdGAU8b5Fo2OlZhuJtvgoddv77deCijDVtlvWXega+1ehsg8hCtaHL8MKYCe3g41AfTHPiRV6niK/WNEHEt5xPI0U1ccW3EMklnc8NaAxrkWeS1wl6hdALKjQYhkqXtcYUy284UdMx0XzBZR7M9DhZYP5VO0g2qcb+YdgKIw7DJLUyFFDyOYdUEh6N3fFEcue1ZEXCOyoJ7VzRZmNhkePLXOdKCp708eQiapNMVDdJbYwLMQENWSmGHdz48P2FrLxRPjECG5g/joeTufLzpaPz8DSgLJZkHnWsFZ4NSUwgz8cd8I5l3uSPUw3H+SDws9xxdBJ1fgvi54eAtZgXWxc2uR9QRFprfJOyWrjiSpL3QIDNk76JHHpx4pYUcy6BoAY74qkFK89HFuG2SCum8mZQ+YkwUyi40zXA7GO9obu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:22:56.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d945ae52-de66-44a6-1aad-08df2f766bb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

tegra_spi_setup_transfer_one() picks between hardware and software
chip-select from "is_single_xfer && !t->cs_change", re-evaluated on
the first transfer of every message. Both inputs are properties of
the message rather than of the transfer, and the next change needs
the chip-select mode before the transfer loop starts.

Compute it once in tegra_spi_transfer_one_message() and pass it down
as use_hw_cs. No functional change intended: for a singular message
the new test is the old test, and for a multi-transfer message both
forms select software CS.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index bd7b13c7f5df..389dcdf15923 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -770,7 +770,7 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 					struct spi_transfer *t,
 					bool is_first_of_msg,
-					bool is_single_xfer)
+					bool use_hw_cs)
 {
 	struct tegra_spi_data *tspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_spi_client_data *cdata = spi->controller_data;
@@ -829,7 +829,7 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		if (spi_get_csgpiod(spi, 0))
 			gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
 
-		if (is_single_xfer && !(t->cs_change)) {
+		if (use_hw_cs) {
 			tspi->use_hw_based_cs = true;
 			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
 		} else {
@@ -1038,19 +1038,30 @@ static int tegra_spi_transfer_one_message(struct spi_controller *host,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
-	int single_xfer;
+	bool use_hw_cs = false;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
-	single_xfer = list_is_singular(&msg->transfers);
+	/*
+	 * Use hardware CS only for a single-transfer message with
+	 * cs_change=0. The controller treats each programmed packet as
+	 * a separate transaction and would pulse CS between transfers of
+	 * a multi-transfer message.
+	 */
+	if (list_is_singular(&msg->transfers)) {
+		xfer = list_first_entry(&msg->transfers,
+					struct spi_transfer, transfer_list);
+		use_hw_cs = !xfer->cs_change;
+	}
+
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
 		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
-						    single_xfer);
+						    use_hw_cs);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.17.1

