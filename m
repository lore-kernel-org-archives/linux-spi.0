Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28513CA48C;
	Thu,  9 Jul 2026 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582055; cv=fail; b=LOO4Jd2Yzaxzp26nU0INfswgw/JyzWZ/WIO5PCUXuQ03JOJdAF171aflW6bn5ETVkc7W6juwxM+pYGFuvdOy07a7/E0ir2Af/Y+vL0U3KoG8vAIQycp+R5Iqx0Y6uRZk31ZC5CA91TQt8JZ7QdqpYvc++s7x95skWKroITUCK00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582055; c=relaxed/simple;
	bh=sZjKLXTSvCudo9YYyPiwzcbJnfORhH/NhTSBtOF/g/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7xA9jXqAKITNGqcFrTYXQJ6RhG/zjmgadsGTEoBJlr/aJTg3WfwVAbwoxYWK7RRGKt5VRT10EUZmIzj6sBZyYjhPqwR1we7xuAflLweQqcF9kcLT35e1CgprINxTtekGGQ2K2JNzusm19xVYr+jxmG8hD8rhxS7IdleREfRccM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaELifj0PtogB1Ex1dW9EvAVXyYVbc11Nx/zt414yFGtFwniYrr2xb6/GrnfP4N470MZWjIG6ZcbU3hdo3XFgqZy1lBq1B18Yi6va1ljVd1ALm1QsVZZvmD7eIuoj3vc+fV7BpPNpXDrpiA1nmKMccnvCFZjRRC7WLoHliPy3MgRV1szQN+hjROhov98dZLjupzTHRO4otPVzJ/akOBCUF4rsqqshz0aVtCK3fYf0JqngsgYH5ji4DVKwZj/A9G4rFnf4IBaxf9bO92VTAxwRaLSXR97wQ6tTmgaWSKqblqJfgOjxO413m0HvWK3oynuzqBgEgfplNiM+CNGdOOeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jbI2nid3al0BCY74tx1mVfC1DQEwak6raNFRp6ZLdI=;
 b=WA2aSyL6v01Xtv7Jy5+ofow8GORYcYMV9ej7BvXKV7MnWaroXwlFqXUmOhRz9a3/6KhYAvRTFL+uCuYJtJI4pmk7fyGYkJSc/HcLl2nTQzQ+caOdszDIl0NPjw/oAPN27OjXBE1lQ2Qq/sXUDid/EWTHzh0BkI3/Zibco3Omdg/qfMUmjP5SDgCDBq2AhZesB1KaPuxC88ubOv1G6viMetsSUDQd9IjVQtkJO0isiim/xW5/BYaNFYbP+2MJBsrD/HS/b1j51G/vBLy+BgVl32NY0sN8x+/HS45lThlRmQOlFHiEuGGAW6kTStm/QBcasK9c/AP83uSOpcVIMc3bVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:24 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:24 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 08/11] spi: dw: adjust size of mem_op
Date: Wed,  8 Jul 2026 22:52:01 -0700
Message-Id: <20260709055204.138168-9-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: d48d26bf-9949-417f-99b7-08dedd7e3ffb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VGKUJWPB8QXjDjFAV9mRTYXg73WN12WAyNbxTpRyE5wtL7XwwwsptgmwGEqca7be11bT7S7c2JSK6QLD1GG+ABHYIsY78hD6vIqq9oQjybex4JGYKXvVs4KT2vQqyGF23Umw4VDq9w0JNmyS+WppGWiiAt6VE8Fa0B2hDkcWc6jtkilX2zOJlhiafGLe7Ajrr/cDeGMTfYlwTWJ3o3+FPn6nHAnb/v6GdLR0ecWFZcvGZ2IXnxcIgILMGNLsq7RU2AJSd6BBjzstXsUFl0vKGUpt3cGrdfvbXa/g0dDfn9i4QlVX/4BTKV2+3iWHRVxCbOfVoVHy/Of0+xwjYqovuIIPfBzCcffrsdG/Uyp/nR+hRQ1ObO7uzmUOEOySqPkFBPyzXrBmJR+ZHDpvx0/ypDrIA+0tk+cK1YGDA/kh+lwYtiXJkKqjeoEPFLatqKfGMFb3eyJeUFJLq3DLSJGJzJdh9bXrligCv6iQmkn61G4xRpzX7Q9I4K2jkyFu+3RKp1rBQcrSV27q3dlVNqXMMLLcbVcwjTouqpGknMV9rrU7h0gVeCLEbJgjN8mK15yc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDbXKqN4/sX71U0NEjxJpGMHA1riDhHkSfYbs1jBp8tDxUYY+5POahN75Nat?=
 =?us-ascii?Q?lcG81ACbz+OSBpVdrq8quO9XxsthJ17VfJgyAW6aeDQxnG52AIMMAb7mZg0J?=
 =?us-ascii?Q?vDtRtkxDBJmb2n5cpiXek2gUqY9vjtKG/xcJF87ZtKC9UdHx9ELKi8jIjZdN?=
 =?us-ascii?Q?r/hXYUroGLtx0MrTJwu2QcPDhVIIBJwgHXXImzuqw+eOWYislXVmAiYGKA00?=
 =?us-ascii?Q?ADQ7UhW81qrdoGFJDb1RssBRRw8KVa1IU6VF7Q6hVOU5afyqZ9frGsZ95ep3?=
 =?us-ascii?Q?aE1rgFVvgK+YMX7G4dtb/pr5oHvGFxOXZYoG92zgqyoOt/+pwWjwwuz/N8SV?=
 =?us-ascii?Q?vzih9koNaoDiUr8PmOlCMYofLPBiBFybd0AdpdYSBxqcRmvRYkHp+hiSCoqo?=
 =?us-ascii?Q?Hbr21UiqiRa/opZu0E8pVJRghz3TuH8des7K8AtNWqAfPIyC9jMmJBmh9F+a?=
 =?us-ascii?Q?ay7BHlHqtdBeG2euNh2cdK1+sBHUCCxWvqkmwO5ItrTDKDENeL27yuzfu/dM?=
 =?us-ascii?Q?czTw8qHB2tdNwC18B+c1KYTRmh2vGEECj7LwqRGN8XmHOt3Bf52//V61J61l?=
 =?us-ascii?Q?umaFGB55P8A1s1rDcJgaPlQ8Jjs6OD4j1blPivKIlt1HhoaWKhqW5XDyLPDZ?=
 =?us-ascii?Q?79n+n2551oUKpByqibaPijbD+7kFBX0FHTomQrXHz8OOamjLlsaGnnY0NFNe?=
 =?us-ascii?Q?7C5CsGpqDTkparhukL768p9vh9B4fHIJSwql298L31wnTPOVGgbNDlc9rlue?=
 =?us-ascii?Q?x72E90j07F/3QdYMZyz857qeta2CG/tyQ9p1uvg5FjZu3HI2rplLdSJJnVKv?=
 =?us-ascii?Q?uJxrzNY/XxLR0b/pwU1XN8jfy6NvhQiclspAv3AvQo+i085/DI7Q1a2l6MfQ?=
 =?us-ascii?Q?VaDY5Txbmp65m0w3IYSDB7sFsSVQ019AIAXxRF/SEti6kapluokdXuWWs34i?=
 =?us-ascii?Q?e4BMKbIexDD8vyd4pJGC0vgDijNdftd/g06avdaPDAxCLZ9XOKpS1rfPIpfS?=
 =?us-ascii?Q?6iWoI8b+AS5rmtEXkGxXuKtZDBqO8Jlxp9ZIKDqeg0jMsj2tH4lzBP6yIzNN?=
 =?us-ascii?Q?UwSpqabTfq1H6U7LnMbMXjZ4ZJvAnMbzM+UiM+R8By5V14QeoyKs7Qgl08X0?=
 =?us-ascii?Q?j/vWnm3kj7vg+5BtH2vaXI7YBlV3jg38FhSDzJDrweX3Jce0O1ZKRRwFaIlg?=
 =?us-ascii?Q?UooFf0L2j5xa8aFcBBei4grdTijMMPhMIHsYwGGvNzaVNvfVEOj8ME5O3RUP?=
 =?us-ascii?Q?TPyDyBX1pqFYUYqb9WnN85CmxFFMc73nuuyqvJ38m+ordu1ZwHDeeGriNOk8?=
 =?us-ascii?Q?z3CcwTwToELcTEii7oBFMjH6HKmQx0Tdiw23IJeEk0H5jiS8/PfRvnKPeIoD?=
 =?us-ascii?Q?UqV9145/F+yBCLZPK5Jba+pbmEGNchujlfrk4SMd2ZBkz+Ju33v2Q+SLYkXL?=
 =?us-ascii?Q?VYAJ0iuidAHeHAp/IU7Uwdd5TglD5SEg5Ealdop6BR7yZwXNSC1NJv9odIHG?=
 =?us-ascii?Q?x8PVF1maoYcOquMiu1BLJta+oMCymrB05J9ma8lQx9LTFejVr/CPaTYArD3d?=
 =?us-ascii?Q?HMmYPrJExbvY43k80Br3MsA0kIFa7G47/JIzr9pgNFC/MKWyUwwo5EdAkO0B?=
 =?us-ascii?Q?EgT5Sco6eh5ZjiZabqv1m3cU2mlf5N2S/foA6kkLCstguSsgx7BjMGYn42RS?=
 =?us-ascii?Q?Zu7FghZwCW6XPS3Sknnq/A36BMMWF6vPGONeJnuQWpOyMJjQlzZezpB95HpQ?=
 =?us-ascii?Q?L7a/e7ydtW/9blv5IXgEzAuEl6QAsZy8lKaEaipLG3GOcEptc+uD?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48d26bf-9949-417f-99b7-08dedd7e3ffb
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:24.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8mag5jLP34WNV9JOlf2FS+pzuesvfFn6zipIdqBXWcypWj0EKEnoG93yETdFTYUXk86rmgRZl00VbemkF8bWB5cIu0pMKucd15xbOwof8LzqiVNi27o7RDU/LJurfoo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

In enhanced mode adjust the size of the data that can be sent or received
as this will then be used to set the NDF.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 532441da235e..0dbf250a101b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -576,6 +576,13 @@ static int dw_spi_target_abort(struct spi_controller *ctlr)
 	return 0;
 }
 
+static int dw_spi_adjust_enh_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	op->data.nbytes = clamp_val(op->data.nbytes, 0, DW_SPI_NDF_MASK + 1);
+
+	return 0;
+}
+
 static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -1017,13 +1024,14 @@ static void dw_spi_init_mem_ops(struct dw_spi *dws)
 {
 	if (!dws->mem_ops.exec_op && !(dws->caps & DW_SPI_CAP_CS_OVERRIDE) &&
 	    !dws->set_cs) {
-		dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		if (dws->caps & DW_SPI_CAP_EMODE) {
 			dws->mem_ops.exec_op = dw_spi_exec_enh_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_enh_mem_op;
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_enh_mem_op_size;
 		} else {
 			dws->mem_ops.exec_op = dw_spi_exec_mem_op;
 			dws->mem_ops.supports_op = dw_spi_supports_mem_op;
+			dws->mem_ops.adjust_op_size = dw_spi_adjust_mem_op_size;
 		}
 		if (!dws->max_mem_freq)
 			dws->max_mem_freq = dws->max_freq;
-- 
2.25.1

