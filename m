Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795628646;
	b=ZUXegLKXmXSTNx1AocBVBcI6xABcSZRg+vsapgLb0XAwaQfRxqC99qPSwFYyVlb7PjFn
	 oVV4+0womjrGKOYo7FVvfrT2iHX4uTkGc88cwq+AJAxedgkdur0eqeCdw7w9HJIKGK/RQ
	 pDQR8oIG7+fU1R4+AX41Nj0pQURlb7yktYJ7tC9dI3kHm/XDmGytry5x41ok7DYjyNwk/
	 qOww0EVTQFnxYI8xiL9W73x1yaQj6RbLKAqnvrN9C9tV8cR2Jadvmc6A+Vm4oFMqvGTfe
	 bqrSYTsvhI5qBeYzBNF8IaUIQDgyfJnyUvUxJSU8lEAb/9RAzsupZVBDN9Fa7im6LgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628646;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
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
	bh=FHk2urJn+OyDYOfW68RBQRlj2cbrJUg5FuXKryBzEAA=;
	b=ZxveoU4gTnZLZKIFThvKYc6tYqRlDir24mWYfOLx7vVh/DeyoyxP9qbQCxVBcsKmyfPX
	 2pgBLHo/MURbzZ3rG7w7YC11tbR8/5mVsEwvHu9aqM6ZjUGvRUKdgdpNDKNrmNSSi9p4G
	 08N9BgXpWd+gCDDZu3QMCL3Ovb6V4EQThTAxbwD9wED7+jkwMh6kIS+fPwdKyE8q0a4/7
	 7eRNVXsfrVw0soaHVKoPeLSg09PJQ4b7IZt1mKxNoYWRtLvqk1JzMeftgZEZDSmG7ZTOJ
	 fhHr3F2sbs15wGCSt3woC5BFgnaqMEvs0xXZ6gYDNY+dHSMOQCKpUKZ0QSzvhxF4DPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="0GVe/hxF";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.53
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4616606A321
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4616606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0GVe/hxF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3vsbc+1hTA26HCZ5mwiw7y2zuz9YQB9cwIiHeakWj9kJrzgwOz5Q3DdI9QoCAfwXRncH+3Pu9/8WTcExNnGzjyFoLcOZ/eA+1o0scy6K40NNqwZWoobAbgVwZfwwQ1/nNnRu1xWD8CNOj7L0EvuugEPCEld4SY+AZMKF7D4kN4suelEV/k2le87iFnoAeOyiNBiruWw08tFlMQ91465Bz5WDpNeJ1f9noB2MVVPGJyJrvH0SuUcmVdFCI/OaXdRmKhbG2leONP55evmHwqaRfB9a8PMoxt72UrrMUjI9/lxfkDWwBxGrpyG79uSBs29kvPm3YuzIYLVkFeEbbZWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHk2urJn+OyDYOfW68RBQRlj2cbrJUg5FuXKryBzEAA=;
 b=d/UuE1lMl7mFD/finDQ3upukhavu4VZvsoTyxSWENVMOCRsK49tNfCYmzMwfP/MzaWpTtQqNVcjGytsPLFSRPGjxxzt2lIwMG+yRGOvwgLqIBXFSWvICqqnhtJomvBr2oF+rP7CLLQzG3cVn97AcAu1A74hHi3yUODCosVzMa+wocKXz6odSgOwaR3MOckTbV/YNBsPP+tY9NY8CjNUg2nKIKkcIRiEi4JTrlA+b5enJNOmdKvmV5qis5cDUBaB2fpur5pQLabqkWmLb7isV2EK0thwM5lwK3e2Lut4CKOnwoX6+2MrecQDCDYIkq993S8sj9775uLd8N2GP1DVLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHk2urJn+OyDYOfW68RBQRlj2cbrJUg5FuXKryBzEAA=;
 b=0GVe/hxFJ0iNgdu6LkrOZXJ+JWX2pwi+5Q0rFu10cS8shaQG0bi+ovMVvDICrgwAgGC0Au580RkPqHsmAFjS2Ti9LqkjD91G3qGu9XFpxabPDi6UrxxtM7T49JHjFP5rXSba2yhfy5DYIXggdXCfw92mo8022gXKT9RGzC17gfk=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by AT6PR12MB065114.namprd12.prod.outlook.com (2603:10b6:170:117::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:42:56 +0000
Received: from MWH0EPF000D894D.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::9d) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:42:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894D.mail.protection.outlook.com (10.167.249.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:42:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:42:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:42:54 -0600
Received: from xhdlc220225.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:42:52 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
Date: Wed, 25 Nov 2026 23:12:50 +0530
Subject: [PATCH] spi: spi-zynqmp-gqspi: Initialize padding in partial TX
 FIFO words
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
Message-ID: <20261125-zynqmp_padding-v1-1-bc0f925fb898@amd.com>
X-B4-Tracking: v=1; b=H4sIABkeB2sC/yXM3QqEIBBA4VeJuV4hBUN6lSUWy7EmyDWt6IfeP
 avL7+KcAyIGwghldkDAhSL9XQL/ZNB02rXIyCSDyEXBuZBs39w4+J/XxpBrmTLcKoW1ltJCinx
 AS+sz/Fav41z32Ez3Bc7zAti0JVZyAAAA
X-Change-ID: 20261125-zynqmp_padding-8d1f88eba55f
To: <broonie@kernel.org>
CC: <srikanthboyapally2026@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<michal.simek@amd.com>, <linux-spi@vger.kernel.org>, <git@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795628572; l=1837;
 i=srikanth.boyapally@amd.com; s=20261106; h=from:subject:message-id;
 bh=sZb4TzGB4VSaty/FF4ighgPg/UeQfvEKi3+bJNsPiEo=;
 b=/feWYjOFFnUFyLkzrZuHh/W7188O3agVo4KCN0wloSj3S1Hb9ahZeGapsVCRuW7BTvZwDqa5y
 VNHA4KXvHOqBj7akYZBmLxZw7wM7nRJAOVuOatnYaYCAEA0k8vQOJ3/
X-Developer-Key: i=srikanth.boyapally@amd.com; a=ed25519;
 pk=VZiIwz5+m6FvZJ+3hzpXDQl0u531OPVeBcB2OVGeZVk=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894D:EE_|AT6PR12MB065114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deed269-711a-4b05-07f2-08df4b1b89d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|261009221227099003|261009221727099003|261009223327099003|261009223027099003|261009220027099003|18002099003|56012099006|10067099003|11063799006|261102123227099003|261026130827099003|261026140227099003|261021135927099003|261021130227099003|261026135527099003|261026121527099003|261022113327099003|261022115727099003|261022075727099003|261022105027099003|261028144727099003|261021133027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	e6l0UZuixhHiE1MvzUdkTmcKQ1anMRY0599sqm5bhWUiZ5o7pNDslyIB0ewmHI5goTiL6iYOqe8akcp9yGrE3NP8+2LebOBz14Ii02gVLNArziZm2rQIq7nGSn7SSjKKR9BGGHOJNGxFnq14nQYxNz1mUmFCoWi8zHXQfSH9dbgQ5B2GovxFfJj7P5BnsDXGjOiS8j1MuSm6I14br9OkmciCStfkpxfArqVVaFZEmGE35lzpdIWMhK/Ch9/WYRCoWs6Yx8ySl2nsOuFoKbCpdmQ9W0SCwSDtg/anpsbkc5Hdj8HNVK2ApN56CeovcgPGQF9ycTOcTouMEZ4MW5OzhK+UljMVsbLlt2ZT6w0IiYuABVq6/oRhxCosjWBMZn4SV+CAKr9+r4ckHTeLOCdxbs49eM+RjU7saRRZJmyRZNQak9XUjBWhaUdcwvRPkw2DzO3zt5BL7m48JB/yZxlSd+T6fhxYaoJZSEQekKWx1Wp8clRR2v1gy3L0r2e/EZcTIUMC1HRVhhL1D2+zuYEK2J8NLVyfM2wKzkwL1vBGPB1ycvVOknjFGVXO3qRYJLvCTyySpj2/o7ea/EjFvpg2W9zFdBg56gF871oOTaX2/gJ6nzjC1bvpBBPmvY2PaDSLq3UXr6sB8U5ZcZE12H8CEyk2GhKcMloqodx/WChpuOeqSeA3K/NqRbLXGOMRAmdOrSDn5I9jqezSQIxr1I7F+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(261009221227099003)(261009221727099003)(261009223327099003)(261009223027099003)(261009220027099003)(18002099003)(56012099006)(10067099003)(11063799006)(261102123227099003)(261026130827099003)(261026140227099003)(261021135927099003)(261021130227099003)(261026135527099003)(261026121527099003)(261022113327099003)(261022115727099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021133027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qY33hBvng8v7DWFZ97+y1/DSJmEnN8ficoGdNWDJbjZMhToYpyUitDeN2fcrrqhIwLJq0ykmVF9fQZomV0p+0KKbM0agKiyNltjnNwz5ANTxsfO2i0ntGVaXKfqskuY+Pvwh6BNtvr6qvhC9jFKZWUf/BWI1xQoyNAw1gIegzdlSnFka+r9uu4alFWulIvQSDYKBWqlpXNv9Nf4RYncPGCUxOfhaH0dwbt+X6tVgE9s/K43gcL69gx3Iz4zTeasyDwuU1Vqxf9tYFc6EefmaJMXXxgvS3hZmOPXh+Yp0wnBt9j+j2iZcdU1A0VI1GSiDJb8vUi9cAdXYXe6p3PkdoM1eY7OzZAKDIDBft8rEEWU0fwwCA+5Ll9BlbSLAoU7e/NqjWOJnJx5n7OLA23HDy7240bvA6j3u4RPje2ZNTrdTHch+CXbmWSEo0Oszo84M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:42:55.7051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deed269-711a-4b05-07f2-08df4b1b89d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB065114

From: Liyin Zhang <liyin.zhang.cn@windriver.com>

The TX FIFO takes 32-bit writes. When fewer than four bytes remain,
zynqmp_qspi_filltxfifo() copies only those bytes into the last word.
The remaining bytes can contain stale data from a previous iteration
or be uninitialized if this is the first word.

Initialize the partial word to 0xff before copying the payload. Add
the remaining byte count to count before clearing bytes_to_transfer,
so the final bytes are included in the accounting.

Fixes: 2530b3df4326 ("spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug")
Signed-off-by: Liyin Zhang <liyin.zhang.cn@windriver.com>
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
Initialize partial TX FIFO words with 0xff before copying the remaining
payload bytes. Also account for the remaining bytes before clearing
bytes_to_transfer, ensuring correct transfer accounting.
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 8e4d940a7785..0411dc6a34ba 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -638,11 +638,12 @@ static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
 			xqspi->bytes_to_transfer -= 4;
 			count += 4;
 		} else {
+			intermediate = 0xFFFFFFFF;
 			memcpy(&intermediate, xqspi->txbuf,
 			       xqspi->bytes_to_transfer);
 			xqspi->txbuf += xqspi->bytes_to_transfer;
-			xqspi->bytes_to_transfer = 0;
 			count += xqspi->bytes_to_transfer;
+			xqspi->bytes_to_transfer = 0;
 		}
 		zynqmp_gqspi_write(xqspi, GQSPI_TXD_OFST, intermediate);
 	}

---
base-commit: d8c1f1ad171d0e5844b6579054fa19ebf6cf7d17
change-id: 20261125-zynqmp_padding-8d1f88eba55f

Best regards,
--  
Srikanth Boyapally <srikanth.boyapally@amd.com>

