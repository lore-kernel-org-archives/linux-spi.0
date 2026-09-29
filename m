Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588990;
	b=SzVfaaBZCO/K1SPDPmyfSmxCWm3+FCXlzcrzjSUElHwkSDYDQBICC5iFvqF8iqgJZRCZ
	 QTVkrXR8/DdWgU1EexPcPtqQjLdBOmlq4ZPjCObj3G7pBzmf7iU9GcjGFvCQUqjUamzzY
	 WzIjCY3Gt3YpYon+AMTzi89gnLU2JnUmPRRJP++h5eLMldz9n5YenPe2Co2PnHpND7Dh/
	 YxxQpuECtHBHCtcpWF89g9pYRsSLtkdSznmnv/7ge9mgZoxUDwVkbzLc/lTePCuRIIDde
	 EOfCLjx+SZjZzW9SqvHj3WfP24VhFFr84FMpplwrlxESgR9yksAr/nDpSK5WR2GetsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588990;
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
	bh=bKgPOF6PlYQXYTVhbvTsKFZEghhz999M69LVKRlQXqw=;
	b=z9qHubb5G53MHYtwiXYJOrrBpNlY7LiYcbodQ7DxyP7nqO+nkVJyYvRHudLCXImcAjop
	 qeyahKJv/1XWO2VeenOU470l+IldiOu9bqdtcmvTnvEf6EEHH2TcABlxpBtsa7Alm2HD/
	 z+SM2eX7GF5GiupXaf0d09XKUecWPXqEYC5hbKD1IpahHMoMlD8+kbAD8WVAphx/0OF53
	 z3fM0s+NASYTHZM4BULQoDsIRBZWRDu+O4dzrSFYdYNKoK3YxIIOfnP+29JFEEbQu2Gsf
	 LEkq+Sc3RJvX/QhPiGiVmup/oZjNeuDS9Bi3CZ63rBy6A052va7/wTR0q7cFNpWOoEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YOA60CGQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.19
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62088606A325;
	Wed, 21 Oct 2026 13:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62088606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YOA60CGQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVFPs/X3zOxxma0GYxjItSGCDKK1ynwlon1jWXaQtGDY3mpAJdZwdsbTU/KPXuAGZEuWHgqXPvTmhVhRi7II6gL8guYnY0UUsxKFIAe7pAG140O6HXplCE9j9xRd6G92r3lVT4dnYXkfJvEmrAc+1WIYEWylWN3jEzSmf8mXmSBipTZmy/8LcdOcYea4DP90sfrBiqazRHiwobJD4RHnSltlMGn6rgySSAWrpGCfW9ZeCzWorACfhkk2b25HFrWyMR4BFGlcdT8sESqs2/sLveFJJUG0xm2cRI9Y+8hZOvmzkjBt/AQxH5qjptsIvvOa6YLcokFAJpBXA2aYNj5wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKgPOF6PlYQXYTVhbvTsKFZEghhz999M69LVKRlQXqw=;
 b=V8jUby2Wj7j3O0qo1gDYpsWucPdi3IF6xSxKfyoQw889nn2Wosc5zXtVneNykCx+Js9Uu+pzr7DKi4t7Uda2ENZvGwCiqYicgep33noUsaghv9iL8NJtcg1t2sPJddje/5bxgOvL7LyO+11uPQc/qyhOImstTRCXpbb+0EyBLtVJPm1nPOE4qu/XQ/7ZzxknWG1PBEnn1ZqlAuG402vcA2c3P3omUsfAYtUJJBu6pFVmSwTItYj3faUsd95IhwQgQczLhY9+gwVXlC9L+A7nNoMDAcuKEwr3gjNj5hhwTTO3MgEkSL1JEmL5pLg3kEMfJmw+rF7A0nIFw7I7FdrEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKgPOF6PlYQXYTVhbvTsKFZEghhz999M69LVKRlQXqw=;
 b=YOA60CGQCxtJwPDy0GOSTY7PEgUlF+srqitD+2pyE4PpXAQiesDCvDZg8jdGXW8ZJ+ssT87KONnSjAUoaq6yPiXwy6TG60F4tc7diYUGDduBLxqss+5DTwsDIY3hJSFr8CAFNDFo5xgzpq6oE/Lv7pLxSMuC4DlLTT4XQQ6M0Q8lcwXp+Po+jaRXY0plGPaf5OQGsNVW100ID/IvT7nnrVIFHmJTstIJ+1bzvGnx8FyFd/8k/0NlFYEBDLWXp2iMgXF6L9rji35F1lOreWHESFmSvGnzeINoB72giQlDmCuTMUvWM8/UGX3UBIi9NxTDBK4hbM2hKTYaMfI29oVNMQ==
Received: from CY5PR15CA0169.namprd15.prod.outlook.com (2603:10b6:930:81::11)
 by CH4PR12MB787885.namprd12.prod.outlook.com (2603:10b6:610:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 13:23:01 +0000
Received: from CY8PEPF00000055.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::23) by CY5PR15CA0169.outlook.office365.com
 (2603:10b6:930:81::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 13:23:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY8PEPF00000055.mail.protection.outlook.com (10.167.247.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:23:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:37 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:36 -0700
Date: Tue, 29 Sep 2026 09:41:56 +0000
Subject: [PATCH 3/5] spi: tegra114: Assert CS between transfers when cs_change
 is set
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.8889609503901872860@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000055:EE_|CH4PR12MB787885:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb9b56c-c87a-4449-b76d-08df2f766e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|10067099003|18002099003|22082099003|11063799006|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	00FspwpDk05Zrxv3H79e0++6/FkU/t9N17I80XVtAtlxsU4eFpBk5ZVyNYJ/i4445q8msYQtv+7nzVbbzrWdIB2eXMZtysL8LKW1DUdaI8NiljrfwML8ArgPSBTPJUzk1rpr2zCNg69/khjcRu0Wb1spEs6aGG+ST7XMXUzKyvQCNjOUPrNWP92CwRZzaKLtuBnu3sZ3yaw5ebEc9SSNUB3FVBN4jWi0OL4YiPsy2sk58CtoG+RWhYzFypOXUEB3rDXIttMt4sgknPQrvOQjc1mhsiLmrb5gSOcQUytGIXXgT4yP7h2AdmE9h95dOZQJsuu1m+thNLPRqV2B2jH/Ndxo0vpPSHJb3fntMhN6nNmIXzhUs5UeYI09sBHycIZLhWoJ6rucUG6bt//sRdmz5I8ItY5/C0Lb23xiCluIq38dJugtHE7QaAokov+gj/wtSZgymIqZYs5AQrn5qSoc0zZcH+ybCNler06ucPzoKAN43hHrzzkO3XCAMNgRcF60V6IjIqYBFleFJMKzIcV4lokfZPNirl6q2LaBSCza74DOuO0A5m0WBasbehNy8MP5Zjo1hU7wpJ1gRSSxCj0t62z8HTGHn5rKSBNZdMCALo+ynbJ3Ctnpqe2dLYPYfFh/+hJ20bkvcfwuSoIvWq8pfdTICICO5xq9IY0QLUdmQboLcPUC7plym8IGyST3uC8nElR2UGzmuSvdIsMrVrSJnw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k80lwn3APpMIQfiO/sDbYcY7Bt78EVdQPIRcUkdZhyiWQum5v3o0i6X+5Soi/wZmpqFZg5ieBqvX0aBcZCd+6H2HFQ7ddyJwaigeMNb036mJD4icLzWB8xZkYEkAIwKRnftHCbx5B+UcxTMW3bZvW8N56hjKhTQgKmAA7TZ/s1llC4HKXgr74Nr0U17W1HJtV1Q6lqZEkbXtOeyfbbKxi7CH5XV+PgyiOuOwPmOj0o8262YfvzlDJdPJEGEpQvEmmo9ofoq6WI7hKTkKMLlrpJkxPjGaN23Y6okUyOVtZ/gIeK0EdefkKQXYLsW3xVuUoVZ1BKz80Nxgx5Uy8d90KIxo8BOVQB5Jh7SCQCxgD0lGNgDJV9NX6C0ulfdGF4w/5Uuv5TzeWB3cpfNbCNd3AyZvxdrojUbT46GDXQ8HCorkfjElMELIcvTBS5KRQsCK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:23:01.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb9b56c-c87a-4449-b76d-08df2f766e33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000055.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB787885

A spi_message may set cs_change on a non-final transfer to toggle CS
before the next transfer of the same message. The driver deasserts
CS in tegra_spi_transfer_end() and, until now, never drove it active
again, so the following transfer in the same message ran with CS
inactive and clients received garbage.

After ending the current transfer, run the CS-off gap through
spi_transfer_cs_change_delay_exec() so that the core's default
minimum applies when the client leaves cs_change_delay unset, then
reassert CS for the following transfer for both GPIO CS and native
software CS.

Fixes: f4fade12d506 ("spi/tegra114: Correct support for cs_change")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d1118f1f2cb3..bd7b13c7f5df 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1110,6 +1110,17 @@ static int tegra_spi_transfer_one_message(struct spi_controller *host,
 		} else if (xfer->cs_change) {
 			spi_transfer_delay_exec(xfer);
 			tegra_spi_transfer_end(spi);
+			spi_transfer_cs_change_delay_exec(msg, xfer);
+			if (spi_get_csgpiod(spi, 0))
+				gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
+			if (!tspi->use_hw_based_cs) {
+				if (spi->mode & SPI_CS_HIGH)
+					tspi->command1_reg |= SPI_CS_SW_VAL;
+				else
+					tspi->command1_reg &= ~SPI_CS_SW_VAL;
+				tegra_spi_writel(tspi, tspi->command1_reg,
+						 SPI_COMMAND1);
+			}
 		}
 
 	}
-- 
2.17.1

