Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793189497;
	b=nGy5RhtBVSaCDJUUlx/KXrLiSSrH8VoTPrS5+AzhtF9IATGk+eMrRjUkEnxHp2QyjfsN
	 bu8AYzM/zY3gmPnLidcAiMend/P0KpjY+npsebZimHolw7vmKV6qw5/UC2fHMzyPvG9c3
	 F3oxiUVM6IK4WoaciVmBtCWdQDzv3kM77pnWHDH75C1+IbQveJquLVHAjOjpwmA2jg5tv
	 WT7+iyrHICRufwN4mTqRW6n7K8AjctplWpkFYPUuDk4QOjjqwGrOvl2LA0kUpoBUFBvS4
	 l20cZCcIhRKccThby2k5Z7PV2A+qnWvH8QGFI/+44IBDCWGKXcsmNwirrUWzYzrmZVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189497;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jlVl0CLdKAyGgCtxSLFk4C+xBaLQOGlligz3t/OW7Pc=;
	b=kbppz4+WLEzLL5kHOMOfRda5IyqtHkKs1CSwdOkUyWAmxezvKBlJt6q0fEokZUv4/ISa
	 s5HXgjYECIINzBYQMsVMvmFjvHmMq4++OU42LUpICeGPmaOLHjkFfvX3KmeBWKCkj35sj
	 U8CuN6v/8FtEF4+uQj3yfL3WOgIv/PuKLrfMKdE2yqVx0LhVTWsPjgPJBNgXM799M6WN1
	 6kUbdKAyOrdNnTAhG+3yGApI5Izr0Hb+8peH8gIoP1dsxjHQ5IyvYgrmc2bHbjZesSeIm
	 BRVg2rHLYefEp6DP5k53zIj3VT3Q4kx87EHjpQ/roLKB0xg645WuNeCJPXBecbRFQ0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AA606A31A;
	Wed, 28 Oct 2026 12:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 775AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJvAcGg+CqMRyTd8HgIf0bY/BWhrfqdW2+lHI90E6eLIzPcP97Pyb9eH/qGbGaqTpQf5wK3sCRJ5IfBoEMi8mtX3LKYkFnhIbJ/U9cpkMZMIbqYqShpQuT9i+y7hzhum3Gi1oRjDAPIfdF3FcDI3Gxu72gKfzdUKD3RW2ZPcUa7dZz+oBSpMqU8ORAb0YdJ3Ru5OTRTqMpvtZLB5V7mI9S0F0vOXqAGTY2U2NdSn2gH9ruIpbEsXsou+qC9fkh6A5qLJ53BWXIw4lViaKaQ6CJSB9ESx9umntzrmJMRDh0FUtequRZyjuPImURXdijE02UulI52xJ2rnBkHHnmVMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlVl0CLdKAyGgCtxSLFk4C+xBaLQOGlligz3t/OW7Pc=;
 b=lGYZmvF4Nv79dHgLnLlQ9IsbUCL216l0yqnyokYN/Pg0nYNNwd/A6p0Z4tLOTG2kWExpS1yHSxZ8PyBupc2BiG62Hsp/w9TaGlzhnCiSghDAHk77Q+lhLgsB4fik7RFMPClBWLypwnTUwdq8qoYUTSoVK4TK64744zOUIVJxX8qtt4Hu8jqC97hfnUx9KZLoIf0U8uXbZpvwxNLsx44BiRkqnX1pahpqMah5xG5VvLnXvZC6/KiAjZhevsTf5yOnO3QJ3dwCYuhW63HCQOn8MTx9hUiq4wv5Xz9wJix529+nKbaZI7T0VJSa48EhXG4h0t5Q14xs1FkrqoGx1CQ19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 12:11:22 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0546.021; Wed, 28 Oct 2026 12:11:22 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 0/5] Add DDR (Dual Data-Rate) support for DW SPI controller
Date: Wed, 28 Oct 2026 05:10:55 -0700
Message-Id: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::14) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1070:EE_
X-MS-Office365-Filtering-Correlation-Id: d43be6bb-c8bb-40f8-0c97-08df34ec94ae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|7416014|366016|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|56012099006|261026140227099003|3023799007|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	+SVMLYtFqGsfsbMjvYAMcqC9R38FvQ1UDFIBWlBy6HYU1NwjiJWPke1jQI4rYJ4d9UgmLPoHnHlH26ILThTR05JFUkQZNS5ix/48P17MxFUZweXbyON1TWRZeseTMtgD/uH8yE/zvI1cGRCeOWbjIrXMto1PHAfMV8ABdvSTG0KbNxTuSfn0MosUkiuqchgBwMzsMmVpEXVJQ1Yx9xRBjgk1oisYv30iVewIWc35hovf7jbgRf0RWi/A84V7r6QyHCZvvoZy6cMRKKgRq/GqY/+XnVmWf74EYRejOzuxA6EZR+U9Ly8Bihm1+W5KwlRB2KeWicMJ15RqP/jP+eHE3aoDl/Us7sefp/uGZovViRTHoFpxrD6ikij4CYac1+qWrmt6/yXG1w4HaYL8600YiHHzJNoKCINbOkgBP6+k6Vv3LJs8ho5WboydgY59hJHvB4HCl9lRokBPfoSEe3usk4WFPoffvidDWvzU3sGzKb8oms3IGQjNvDNU+EXv6wHcgzyqRX+6nfDbMe72rcm9zbsnLo552CMcW29pm795eJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(7416014)(366016)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(56012099006)(261026140227099003)(3023799007)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vCu5mUkfMaK0kqh70KUdRkfdC6IyuZrrNacrwZzWIUNrNU1/yC0xMnp8h6g6?=
 =?us-ascii?Q?CmWBYfSWHL5v725MScq6ZgNbbitOwjJiX2EJRHhyOliZ0kaEeGoJ7fSgBB0F?=
 =?us-ascii?Q?L7Li0JGmuO/ckZtSaE9r4uV8Aq/twjfgKHjGcbknLijqcfFD7g3us41TERen?=
 =?us-ascii?Q?GxH2MSZ09jx+JPWh1O+tNFd9WzygdMoClelSvMtvZsXBJtNu9qdsj8zwZDoy?=
 =?us-ascii?Q?fpX2hG9QjhTTtV++khbVze4RJnuS3TjpEZrFCitvZ0hGYz3oQM9goxUUQVZ8?=
 =?us-ascii?Q?Cx6tbdqq0xJcsGR0m4lir+3l5CiSOESsNGEgl655KRuaRXgc9rt1yvpl4wVe?=
 =?us-ascii?Q?1o5vxt/Q5o4PsMl6GaeBNc5oUpyUjAWzUUTU9Dx41EIyQ69V3grkU7qqehrv?=
 =?us-ascii?Q?7z8EHUJVsFBue1AdxNXLK05s+5rS0W6DhQhkcoz/AKlHgB+wBBkhmd6zfh0g?=
 =?us-ascii?Q?k3w6DK3BWECP9n2NcmSaGu2c5U4mwl38f34ilPtkmomdc7twmkQFFAo+N5j+?=
 =?us-ascii?Q?lpdZoTE7aJejAe1//BOWzLNMBjGV/q3F+XRBBCxtqIlvEHoRhIq7bkaj7h5s?=
 =?us-ascii?Q?O12IpSD+5MHPrjBquS24mLY19ABHYZ9EMEm7OzfaFBlJGgnsAodT5kYfzBt4?=
 =?us-ascii?Q?po3sYIyDHa2VhqVyrfMnOeMm2SJriQWx9gKkFAvFegVYmJA9LL3CcL5dApAB?=
 =?us-ascii?Q?NMZzTLgHVLZyVbHyN7y3QWmTF4YmJrWxd88v81ZJD+eeboXvvZ4Nu2Y2LV6r?=
 =?us-ascii?Q?mZrv2udAokLA3hyR4CbYjr7LlESxLw6P+WZKI2wxLmcq2kUnOUBtovfbHM17?=
 =?us-ascii?Q?DtyC7KACIpMP2Js+Ti7t31PFwG8QLU3gwH68CPfTKaezi7tzqm66xdM+QXlr?=
 =?us-ascii?Q?1Q9mX2KmU/wzb8JBncNRI39vqlu7qY4AehHAQlKWvw1rkusYYoQNzU+nQNeU?=
 =?us-ascii?Q?zdCJKlls/cpCB+xZ0JSQfB5IONV5f/YB0m4zgaQMJkBxfhmmFe0uL547irQ8?=
 =?us-ascii?Q?qFI7Atk+1OAgc6O+QOLN5kH2WxfjJYi4/0hwY1bBZ9f/Flzj2eKeOOyhu2cZ?=
 =?us-ascii?Q?aqvMo8UljMuBDjwvSkQV7tjdc/0bbaLTzDXbCtkv/oavAilhlmRoDYlivWeU?=
 =?us-ascii?Q?i/VpXbJhVkTKWdaHkGC+BQCoDjWVvq5S/qwYAOyEWMAj4B0D39Q9SyGcd/sq?=
 =?us-ascii?Q?YxWUXz//71lSwmUq3GyjHpn7pjoKxmllliWqaMXv6K9j5VE+9RCXxcYAV/ds?=
 =?us-ascii?Q?2uIf1C3jRi3ejkZ2XDzPtBt/hVkpie3FbA+nSgLsIrKSNFuXR62I1PM47nCS?=
 =?us-ascii?Q?KTlqW8EeC7Q0G5UjGeoufwxd/cq/VMdGZ/T8kiA2CKaORoxAIxa2UP9YR8jT?=
 =?us-ascii?Q?TvCwc2MOUuCC7sWrAgACZVLhHjtDagn+A+v8ekWjZLs2uNxwmp4nzQgvKlso?=
 =?us-ascii?Q?8ZPDz0nUKMiTDK098oU0VJF/9P/atFMBAXzDrR1ZrhPvS2B454rVblH732gB?=
 =?us-ascii?Q?0Isjv5NT/Pm0APHkd8Cg9Clpe9CRPCW6y1/4qnoecehS+ioPMRZcKupMLiSH?=
 =?us-ascii?Q?tnfX3FUilfRZsRiBHqzBVQl6hPWFVwIXEMzhMPkvaTWHN1gMT36/vSsCeXYo?=
 =?us-ascii?Q?biGL3NwI63mHWfUUQZl6SAEpLahSynd9PRCjkLlyNAc+O5mfTzzK+SSZoQbC?=
 =?us-ascii?Q?SP76Ju756Bvaahf1qaPKnvZflZHwKlT8Pb553cOLCdF/YbXIvty9Vem6tInC?=
 =?us-ascii?Q?Wvt8tbDdqXxJIoKmk3LS9hzmK8c8j5ogWEXUxFiGTjUshATUY4+A?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43be6bb-c8bb-40f8-0c97-08df34ec94ae
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 12:11:22.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZLBgv5SAwEmfAU01fWJSD6/XRFDtPR13GA4GvBIYeiO1ihINQd41isMDPgEs7AP+ILbJGBRB13w2MjyPbsFD2ZNWZEVPDMXkKs3BxBP+qFM8PWKi7g0k7oFSJDPOQj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1070

This series implements DDR support for the DW SPI controller and also
implements 1-4-4-DTR read support for the MX66L1G45G.
This series has been tested on the JHB100 SoC.

Changes since v1:
- Add a new patch 1

Patch 2:
- Remove DDR instruction support; currently only supports 1S-nD-nD.
- Add dw_spi_supports_enh_ddr_op() to reject invalid DTR operations.
- Use the new DW_SPI_CAP_DDR flag to indicate DTR support.
- Use addr_data_ddr naming instead of spi_ddr.

Patch 3:
- Rework spi_nor_spimem_setup_op() so the command extension, 2-byte
  opcode and SNOR_F_SWAP16 handling apply only to the 8D-8D-8D DTR
  protocol. For 1S-xD-xD protocols the opcode remains a single byte
  sent in STR, and only the address, dummy and data phases are
  switched to DTR.

Patch 4:
- Add Miquel's Reviewed-by tag.

Patch 5:
- Add Miquel's Reviewed-by tag.
- Update commit message.

v1: https://lore.kernel.org/all/20261022102614.75696-1-changhuang.liang@starfivetech.com/

Changhuang Liang (5):
  spi: dw: Detect DDR support in enhanced SPI mode
  spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode
  mtd: spi-nor: Support mixed 1S-xD-xD DTR protocols in
    spi_nor_spimem_setup_op()
  mtd: spi-nor: debugfs: Correct DTR protocol names for 1S-xD-xD modes
  mtd: spi-nor: macronix: Add 1-4-4 DTR read support for MX66L1G45G

 drivers/mtd/spi-nor/core.c     | 23 ++++----
 drivers/mtd/spi-nor/debugfs.c  |  8 +--
 drivers/mtd/spi-nor/macronix.c | 28 +++++++++-
 drivers/spi/spi-dw-core.c      | 96 ++++++++++++++++++++++++++++++----
 drivers/spi/spi-dw.h           |  6 +++
 5 files changed, 133 insertions(+), 28 deletions(-)

--
2.25.1
