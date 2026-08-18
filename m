Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588986;
	b=02WdJgntd9Cg6FuRyOHk+DrR4PKbat+dtaRXIiPfLjd0jiv2RMszQCDJd58sVDBWgAv9
	 BjAelhUXBGZQy7U6aXbXOvAh9EpB5/6Xc+qSFkftUpZz1L7QG4q8HCOtMJ5E7koCMoGad
	 o4pdoniMH0+05jPIGV/yOLTlIOnAFW1x5LxQM4AgOymAbP9tJSmNtPIDIYo0lpuUC8VCX
	 D1qkol/CAJ2VNXI+6OO2+VnzkYwZHgL9IYddzegIJDJfAZGxSS3h8KFtVCp6pwl0xVSXt
	 RxjdrWsLWg14KxKhMPHMpSSxBLGTFqvATYh/JcLzNqHrpc8FBl9Mn/xJNChOC8YsWbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588986;
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
	bh=7NY7V90rNmjQwYQQeS4sCAcBVkml262ytvNa+1uKN8w=;
	b=dK+JJ2fuSiruj//B+1+OSnpm3W08aFlvosyjMj+JmuJbZwj3EvfkOTxhT/e/4n57IR0f
	 WI4tWXalnQErK2fvC6sdF0v623bXY6ZGJSfkP2EubdledLN+cwuI/yOuGBzIBN9RA59OD
	 dbwq9X0JpDUJIsmx8iTlOk6WvdbHpYonbSESUpMGT4Fp7tXuVGZqUWdWCBhlQoBIs17io
	 pbRIDx2lXFDEpy4S4fny7McR+9dpci37Lk1XL3ukip+67UuoORv+45Fw4gIvslZ87tMjy
	 97Z/2Km22Yhg+w6vAC0PnDdm07b6OUyIc9wAlTxb1bI0T5lbwJFRraHUFIyj00Yan8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=stNn9L5L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA07606A319;
	Wed, 21 Oct 2026 13:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA07606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=stNn9L5L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtGatFlvIOkeppv3p86Z4lkMX7o+NbDoZhrhO6t8g/WKpXMdyic6OQaqegfLae3WLExXcNcccNkAWnYHR1FMWBZzgyZDYS5Hgzf94OlCq+uR/QK/ypZX0jN+0URrnL0GcbfLt13zy3xp6bGISCEwRWfzGePnRkNA8FmBfKBj9xqKqFHsl19z8NlwN8fZuHzQl0CfIuM0S3YioUQswWReFas10UrS5ijY9ANBryff/W02hnFxS2jpGl0vq736msm5ur2Shcv0NEoyyFUgwDILUdh95fUMbpO1Ycr2mOTEwlR3K8Ml8ZgaTVoAU4T73/jPwM07LbgQDVFcPmFeadB/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NY7V90rNmjQwYQQeS4sCAcBVkml262ytvNa+1uKN8w=;
 b=kSry3QnA03eUbk9DRrU63kxNBioUzw/YDX5Z5UU8cQWo63mDKacoPZby0BGI5j3886ZG2gJLyrlUFQft4m/E9D6nG02ihoaoxOTmZeEqsZ8ZtmXF5QuG/TIjdNhKhNNGJEgQQ8DvKxn5O52QelONbbA/U9dCkScgPrqRAUVQ0oXzp6yqai5CSfzyQAZMV/rj13srsIEdi/mVQ1vvV9YMXsKn4zafFajRFO8AYaJ8kRZfUZMYAsvlrsC8Xcb9cN/yf1hIRHtovCMZZYqLL/1zYMJFU3AJXv2SWlM9YRwlLAOyYQ85ZZ4ZKYcEaMBdh6cYshMIKELjA0emop+oX/Z8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NY7V90rNmjQwYQQeS4sCAcBVkml262ytvNa+1uKN8w=;
 b=stNn9L5LPkqOlbW6LD03BTsTpCeK8ZiXKocB61Dil9cEBD8qdxqTuZD2VVXa13tUuXw/btJBPRpqvIGtcM4TVQ1qXpePjeSThPh2R+FvSJIxi5v0C9mBgRfImj2qyv0CfdTy2NjVsgux0jOxVYO0H2PPBa6uoEQZPHxjegp0fs2wSipmN/QmqnuPeo6Dh4yiGpH3D/LEYs0e8pe/drwxNwXlLXH0XtnfD5rRf+C/RSo/K6PEkINQmnHGLqlWVhth56DGJRTKEhhpfdMQkxUu5wP8cXeBhHQpk/Jj35t9veXQpl6QOP3OFsv0M++SHn2SWjG5RjlVXtNeECkSqmVfNw==
Received: from CY5PR15CA0165.namprd15.prod.outlook.com (2603:10b6:930:81::7)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:23:00 +0000
Received: from CY8PEPF00000055.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::a7) by CY5PR15CA0165.outlook.office365.com
 (2603:10b6:930:81::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 13:23:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY8PEPF00000055.mail.protection.outlook.com (10.167.247.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:23:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:36 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:35 -0700
Date: Tue, 18 Aug 2026 14:54:42 +0000
Subject: [PATCH 2/5] spi: tegra114: Run per-transfer delay before ending the
 transfer
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.9495742918567488970@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000055:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccd813c-8f67-4acd-5c2a-08df2f766dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261009223327099003|261009221227099003|261009220027099003|10067099003|261009221727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v3lkqDfEoBSVooUg53O+XFb9JuV81P6xDlJ1TTFJHtXjc+EJLev3OR7G71SHJXmqQS6GxfdXK9nJZj47xok3NrePOs2Ng7hBfbEiL/t61SlskGsRUZaoChWsYVdZuGHecoqmq0U765ubxYcQw10XBnKtDTMRSgxJVAKtCfYkuwHxeLJdOhhmkh8aSUAuUOI24E6VCbJxvF/WpPdFxo2DEsGSoSfetgx0jTOcQslySrEfj4t0duUBnVb6qZhwl0HIIgS80lM5QgsnHLel2WxXshKuH3SDQ2277J9LZ1ayhX8UNOp22DtUhOp4yNyU3IDlwlfonKbXs5fR6Ko1u0eQ6LgsTTYee5GLEwzmgoeXUKDFfVsp0rfl1BZrUeV8DCGKfApjMGfH8CGwygWUQHcIoY0dHuNTxyd+5nXDELIuz8Cm9ZIsZev+eylkcMwkmJKPFq9N2F6dlMl3xbfLGCDCEv6IKG1ysYgmu4zXyeAUcuvxuHfl7wf+pVbq3CCmQeSIEbX3G7goN7AofGgsyQKQalC1H1urey4pu2QHdzt1Q82H6r4Rbc7p+GDivpbyRuaxeQmA4Rd6G+OARBFTF1grL5GpQAXep4kYfr+DaT1DQrtdX+kNN9DnlAq/AbIBzdS817b4rzMl2wP9TZC+feOnLM7MYXXI61wEB+P+pGEU4qP5aF3nu4OPYmOGUycKE9PtA4igyMmbI39jyzDTsKDZyg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223327099003)(261009221227099003)(261009220027099003)(10067099003)(261009221727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DY5qYpuUEY+IjbbwgOgaL1GCg0JOEiDE0FBc6jfCAkyiR98QnT4cImDZf/+1rpW+CJCDsqZkwoC4ihTlLyYdXKGx3bWw40ZqHlCgbqiegDos98xKIyp5sqrIDb8roZIOyTCRDtfcUNyx/XEuYCjtXMIG91bQergbIbONSQIo0NC0FXM5zq07AxGBYKOoUFMkC9/uN87CS/81eH3NCpcv47RyiZvfjbFIcWFNTUTbEY0rs17sEJWpS6Gf1q5ZdN0Ry9T5OfFGl+vISiQ0bJ4ipnkqYlUDg8H50D1z4TpuPqmvT8ACAhDaF7J8B0Kws+rzU/C5wRHmEhqzcg2g6Enp7/WLEoLcqVqALyZjwE4ejtUNddFfebrXPeSCFlaxoEfR3ibuEdviFn5Mu/e0LB8+LiO2Epj9QFCkfUPiJuAwn3a6qWjyFDsMOeD+XNhWlNNF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:23:00.3136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccd813c-8f67-4acd-5c2a-08df2f766dc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000055.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

This driver implements transfer_one_message(), so it must follow the
SPI core sequence for the per-transfer delay: spi_transfer->delay is
the settle time after the transfer completes and must elapse while
CS is still asserted, before CS is deasserted.

The current sequence deasserts CS via tegra_spi_transfer_end() and
only then runs spi_transfer_delay_exec(), which drops the delay to
after CS has already gone inactive. Run the delay first on the paths
that drop CS.

Fixes: f4fade12d506 ("spi/tegra114: Correct support for cs_change")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f9bd783cb4dc..d1118f1f2cb3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1096,20 +1096,20 @@ static int tegra_spi_transfer_one_message(struct spi_controller *host,
 
 complete_xfer:
 		if (ret < 0 || skip) {
-			tegra_spi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
+			tegra_spi_transfer_end(spi);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
 					&msg->transfers)) {
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
-				tegra_spi_transfer_end(spi);
 				spi_transfer_delay_exec(xfer);
+				tegra_spi_transfer_end(spi);
 			}
 		} else if (xfer->cs_change) {
-			tegra_spi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
+			tegra_spi_transfer_end(spi);
 		}
 
 	}
-- 
2.17.1

