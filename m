Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2183ADB92;
	Thu,  9 Jul 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577410; cv=fail; b=gGaB+OEH2pN0POGDhUEQh0oz5SV3pGWKFSX0edX6ij3NBTF6ErxDyBfcc6NIybHY9HkenRNejRBh8K44qRLDWXItPfdJASj/7x+QMeTT8lt7AGVsboVciA2xGdCZwsGo5bFpzVGGw9UIAFP/GaxL5srhmNilx50XkKqcwwOTibU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577410; c=relaxed/simple;
	bh=RCyDfN5g7+zidzrhYU3XgOiOoKGER2BtgmkY1Wofw4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hn/UGnfrrSv23UqgKDh8IJPpKyAyxTCu9KIfoRQOBULnhJuoWcG/GFr2zuJn13VoOfCdzciOlfVequx04QDI9nYaWW6j4gerXmW4FJFJg07pwdwYO14suZ3WQN4yvBfx4mv/0MkhU5dfKynOZ7MmwlSS2NcvwOOl8Hh0H5CBJl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG322v4ekBlPD9V+2QiMhvbQ/sJRGDgEKoP9+hfGOpn13xAjsZzZjuMq3kqXF2ksfoexPi9auxO9GxUHygCcEm3zA2dFEzXpHUa+prDUH8+fB1p2Thb6P3ZIG9XBtiXHm78ljVDQQFWspcXy3EFMkoQ9UPNnUDITksnyIsMTaXWWf7GlXkfGGXgr7PvOIthIzoQqSaNGLqilLvLAQM3YcI0WNyVLH+uKqrdVN0cqH7himkenJBGhmgBf8CDZObAwhnPl233CsU3Kww3L6Y4cjs0JNX7TxTf2raNTU9vcE7whVIAFc5j9wr0VXLxwHvbZe31yqda7pIsBjCcrBi0H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgIdhJwQ1qB3yxpKTMUmpWzfqSZvtanpFTlPAH3oPUA=;
 b=ljEnxOS0QL4/pnlbCVoaBl6NDZfVUkINgiRGhAnALGxQ48/jiT8xon4QrElLscWVPPC56gAyBAII2f4Wf+tcye4SBT4MWVMATQHeJELhnlloQsVMxfpASBqILwcXxW4kBuSjO85qFi+xa2WkF9G204aNh4O+4+Ufqt65TXPFs0XJa14iCZBRcjI5fP9LUn3mugS5SGrZ4ilO/sl8YPW+lo5xFiqjAO9bbJJIEv/Hk9/g9JQe8HV34Ik6qeSmbd3/BPFmuRvD/mlx8SNSRtgPIbJsClWmu/f2Z65EFA1EVGFIkzzBkc770fXMB2ovlwbkq+o8UT9euBah8zaF+8lSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:22 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:22 +0000
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
Subject: [PATCH v1 06/11] spi: dw: send cmd and addr to start the spi transfer
Date: Wed,  8 Jul 2026 22:51:59 -0700
Message-Id: <20260709055204.138168-7-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: cb9277cc-64ea-4ae8-f4b4-08dedd7e3ed8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hFRNpxKhmLThxUjwruccs9QXs8GCUs9j4eRg6xXNeqLZUIbhWie98dURb+M0AmYn97WrptrUBmCdyq1OtYmJLjS64Bm3BVhXxN1tMsQylM7XvKo0Qq72iDE+g9rwDNISW1i0dSXNCmhmnRLnLj0MqwUSjWV/6XgM7kl13s5hwsXE2X/GF9ZsXi43UrlxXowhwYtpj0HrhSppupJNVxndhR5wAN43ElcxDlEh3iA4mfM+oTbanyc+oxIc2tQ2WZA5/w3XLse6K2BL3Hd/CXJjPE98NDXT3FmV0PeIm4IhWZS+ap0ry98qsqgYQS0tEwVvFOb8JqJ97bgvHykRzcBsPaC1jxt49dxblOLG3/u5ZzGAMGG0QRxSqdvlk29jRy9pDNV1llVD7kpgUfWjn+zKen0MXSCPENVMJQnqPuSJIeGsET3tLjU6vsIdMoOy2enMHw6f0F4Xr83G81faENiynKlSXGwpn+Pxx/otwldZWAnSgvjAgGSA+9OC8B/AxsB0cirPcfMr6DZEP8rM+F4fZN+0MAUYYDVz2VNb2XOIqSUMjDnKwdBorg3giArzfkcK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJteMMdLlJ5DviLEoFtocED1F0whzHNRJ6HmlbhD9Bwjq9sacpY9d49HlLo5?=
 =?us-ascii?Q?48gSdEe7+yH2+3mFuh+P973Z1grnrHqKE8cvAe8Y7mBQtqo0hzE0qMZ53B+a?=
 =?us-ascii?Q?jHUVbZLHTcFOXuvQDPMgizQFq/pbQFWYJWRz1MN32BgY/AY5pks2/dnzM7zQ?=
 =?us-ascii?Q?Mxo/MchzI2CFIhGxYbfdOrp4V39sB8plSwQOU8qT6PWhG/rLgIch8l5Y1Cv8?=
 =?us-ascii?Q?pNsyrPVeaiFh/msrZP4mwtf+cuwJrFyjTkc1agsspRDsSJZQVfJB+BkMePH8?=
 =?us-ascii?Q?Bgp1UDiNYs4iuBz0mfSJ06WibPyBwUjPvxd7Tv266A+orWHEPk/hJtOZ2E12?=
 =?us-ascii?Q?ML377qJUPQ2GlsreJracSbPyWJNxAIBxsN82L/Pdz3t52Rx9156zxrI2h5O1?=
 =?us-ascii?Q?vcE2CutgPBYRM2gGtJuqDocJXF+9Lbdpee5v0pDsOHE8aYkV4risQcpbq506?=
 =?us-ascii?Q?uF/8hMBmBVcloq6zvWbJ4QdaVBzKMt0668BPwFtR2WVUS1wvEn/HUAoo8EJh?=
 =?us-ascii?Q?TYCAaY7WJuAOHbdS+CxalZzzZBFUsmo/sl3PydikXpogTCOWrALW3Ntw5J6b?=
 =?us-ascii?Q?5csmBfAoNUlX+8UiA2kmHuDlWwSNsOxgdaCxqy4ky7Q40AcfQfxOoVEowvPi?=
 =?us-ascii?Q?3a8soYUrJ9XmdfMXYMAUIqgWEdGy9StQhqDVppt+IE9tZlrkL0/+TdwaDlCZ?=
 =?us-ascii?Q?+pS+P14qtFFJ4TBlZa4xsJ/7tL8MO98Ej3K+2z+ORFft43q4Q+ZVtUoGoyO0?=
 =?us-ascii?Q?4RjahAPa3Puw0y25wNj6bWWl+4loalJi+vUMK9i96XME4CzTSK8lY+5p0lfR?=
 =?us-ascii?Q?EaKWuHLBdlLzH6pLEqx+boqVAx8lJhFkB5tIfN/yXHzJ4OdybYSN0wOEUENp?=
 =?us-ascii?Q?R34/Is+iX0EiuyANtyUDTqHLYeRKB+XR+GQTB+5Mgy6uU7v5hqv0QNIOejQf?=
 =?us-ascii?Q?d6xhevkA+Du7O8le2BZkU9FK4rk1wRdfWHrWVdhepQI+ksC1DhZ58krRgk7t?=
 =?us-ascii?Q?7Pgt9vRjlNQddkpVhGXmcx5TgTysKOHNplGXlFDPI/T+6LvyO0vHaWUY2vQf?=
 =?us-ascii?Q?SdtqNLNsufKl6EqRRL2YIP1ZO6R/VZFIFXJzVmmPAGt1JsBuAKmAPM5ksmrh?=
 =?us-ascii?Q?+TN0X5kAksWWyz4H8dcUjFsSC8Mflmk96on5qAmwsipn5p8ohVnt4rtmZ2w6?=
 =?us-ascii?Q?ekmeRGpoHXcBiL35Kf9FDxZ+a+mH6/TS2GLVs23l+EZvl0oYr7dt/SmjD7NO?=
 =?us-ascii?Q?/ixBgfQRfvqDXrwZsNzwIFwVpce9tIJxsBggPBPSOyUKRhkC7QKIQqyjrEm1?=
 =?us-ascii?Q?AvG7Fem4Pzo6Mqq+eChJNMKdvhgrwG16Q5Q+1UkE/YsXVJPeScMgWleqXFLI?=
 =?us-ascii?Q?fEMGQsdzd4qZQpKPjMAR1Hklxq+h0dlRCs4EOS7uKloePGOlhz+QMVvTKiN/?=
 =?us-ascii?Q?OS7dgTnxnjNHqtf1zQedb3yU759narbi6+t+1lHrgRCnwYOUsVFodUju1cJz?=
 =?us-ascii?Q?jifUT6DxqXr3RF9ba4t5KkgzGhXnJBWGjluWXtvbuv7DVeJk5icxKfgkEwSt?=
 =?us-ascii?Q?o94g7UVqDzxPnzcNfbEmizuU0qT7w9yKSkHxyKcb1UHTSZqN2pZrqK9ayRr+?=
 =?us-ascii?Q?pmS1fMnM8DWOV/Qos/3z/vr01o/AwFe5NdyFd3DF2umrpqfI5Im6lXazkwO+?=
 =?us-ascii?Q?jhl8ipkgkbArme61GFg25TH4Gut4tpfPKzEpugFlxGr7zn1lc+/H6q362Moi?=
 =?us-ascii?Q?UEaZmuKRgVQDJYS6Z483tB7yviuTW4N8AwBBPC77SU3patNDgzR6?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9277cc-64ea-4ae8-f4b4-08dedd7e3ed8
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:22.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0njrRGp65Nu4fkbsNpczIUmy6kKn0cgENEBWk62Wxmcujbq8o7L2Ej/1M1KKGibZ3CO8H70YBFxtV56e+8dcOw3txOf/XuRngBVsVQXcmYMzCUeClvgxAt2jCCSRj7Za
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

In enhanced spi mode, read or write will start by sending the cmd
and address (if present).

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 9f3ee1d78c05..9f0f7e0b93a1 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -836,6 +836,19 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
 	}
 }
 
+static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op)
+{
+	/* Send cmd as 32 bit value */
+	dw_write_io_reg(dws, DW_SPI_DR, op->cmd.opcode);
+	if (op->addr.nbytes) {
+		dw_write_io_reg(dws, DW_SPI_DR, lower_32_bits(op->addr.val));
+		if (op->addr.nbytes > 4) {
+			/* address more than 32bit */
+			dw_write_io_reg(dws, DW_SPI_DR, upper_32_bits(op->addr.val));
+		}
+	}
+}
+
 static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
@@ -895,6 +908,8 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_enable_chip(dws, 1);
 
+	dw_spi_enh_write_cmd_addr(dws, op);
+
 	return 0;
 }
 
-- 
2.25.1

