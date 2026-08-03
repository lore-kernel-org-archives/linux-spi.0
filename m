Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E1410D06;
	Mon,  3 Aug 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760864; cv=fail; b=tEYyHXb11avpubf4Xj5jPQq2dK7g2dRWHPuGK4XLJ8WShZ5LZtALQqhTYGyGhuaEyXGgnYHTDH2Pn0Dk83Ml+bWwubxllWsLzKNFTwFuhLFnW41Mxm/OfeFuT6SGf8RFVcNXfeZN6uUhEzgu3rarWS80CJOOWysKqk/vzwtqI2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760864; c=relaxed/simple;
	bh=O3zRtlo7JWlErgCphWkW/Ar4hMWcQ87LOm+xeXzQ7Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UZ8B2of9HMrUw10XnsEVu3M3VJ6rRBi08bbaBKilIARgRUnV8XYPA9DYnWFTY30pk3APC+WpKJcXcx5q0lDyhR2dPQnuzkEhnPZkGTePow2htk4TafcTo1b3n+tGHvmlPmRJuNKD+RD1YQuq26coxSfZVkP8xA8/QuqwggxG4xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoWbrH+6bVASfkJS46+rAx1qFec5drKgOayfM+UekMyDUKbQKfspzn6aB/1YAYTzbFWgfQYHrHaPPnJI1CEXZiAoLIg0IRj9oYL4N7mNTr4caPcvzDFA+JlspuwfTa0fabxFzNOa65sQ5ZoKMyNKVLgDd09LrOAMbryVLRai27Frc16qImYWqztAOTCBU1CSWkjBzHtiAWa2B8UKvhw2dFN6zrqIsHs4P9505zJs30unWPA1HSrlnGCjgq5lCptweiroRFKjMD7zgW8QRO0ufQEgSHatR8ml8WOmxF+BRq8sI2msPVPfXhb70XODmGgTjFveaDbg8vDt3cEXFTyxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omohw4DeZIYGPdXXozk2uh9C8XPZ/Z3teCXhbZGIfRw=;
 b=KN/BEmMbO54UdZh07m32NDn5DT50khddH5JP3KxLD/aQIL7W0Ad2cONVqeyunSZExsv5IAAjgCqwO19FwwK4XwzESQCyHsGJEB4Yu/s+AcL2FAmPmfJjywwd+Ct7QRysFq6KfQZg36aULJ4daSRGCjK6GZt784As+Luq4VsI33XfOV3+Q4eN+YlJvt6VNM++B7UfJQw1dwTS8D0mrfsFBywlRi4r5Qj/lE/KxLjQPu9AsyTVj6YyHSmSpqHjOMciVLaDE374jyXGkFj2pfG91DMukK81EXCLo1CiLij2GOBDA4RLlQK99dEHcf5/zvUrEA05IchPb05ZFrUSAWcUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:40:52 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:40:51 +0000
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
Subject: [PATCH v2 00/11] Add support for StarFive JHB100 SFC
Date: Mon,  3 Aug 2026 05:40:33 -0700
Message-Id: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::32) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbda597-afce-4ce3-bdd0-08def15c73d7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	uCC8RrOnDScE9gOZlMXDxoI2d1Xk7U2wXIiy8QVqJz0iyiUiCYIqyriuPDFz0/BnBeUCUqXM1F8MYaZmhgFvfXSP6P5drEKZPbHU18rNqPM30YiaUtVGHkqMI1aGyIh8U9jr2yCA7Nzkcab03zBC58ktlYqK/xf0DC+ZMom7BLfMZV3cElKwZDUXsYr2+ZRy77sG7o8pC1dTziChvorJK/7iCNtfZt3rlGYMoaMy580TMIo4E4/CLJtaLLmUsLNkdbOhJ5P2jgyIhtlQ8PIUZqetb66cOGNO6YsdODTHS6PprIyJ1rB8Pus+1xsP3LechbY4fXSA5l2ShhA8LVZnW0Q2jrjSbHSi1uuldVS2fnZn6BciWlSI0IcchTlxkp+EXgLVnETDozPHvSD6K4f8Ky4gYmHVbhT7G+OLWLHvRI3OSlr/af2spySvE3DHvh5uPaHJVMu32CWGad3nfMg+2/xO7pF2s/HpkQD4YRCOM/Ha/XkpjSs6dJ/oV/D8x2hro2KHCW0P/MkPiN2Sy57KZyrXuBbP03o44v3e1CGrCTr0stToZQkpbl6oHtQYmibd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNl9LTi4WBC+Q4Hn7dM9c0/URHVlPxV6aT+OD4KfcBdNOkUG4LKFJAMmLzFS?=
 =?us-ascii?Q?WYWjkB7b7vE9gUxfibswe9AKuFmjWjhsVgkpYh9lBhOYao5dqA40xfVg9Geg?=
 =?us-ascii?Q?Fo29pTSt+PlYlW0mhrACsQOyj7NaygdYmevVtP1v+ecXk5Xya2eBG58McJ0b?=
 =?us-ascii?Q?ZQRhcNUdStOANmnTUsUjQdv3IfgbUuiMABNBc3SGRmdRvyAzM6pcHS8JTrZI?=
 =?us-ascii?Q?GQ2BSVBOerGhfVfxP/0e5/vbRvWvz7rLO4MZo3uTwCZINgs+bkwVUmnxU4lL?=
 =?us-ascii?Q?DbpO0EQH2ocs+CqLw42QLDMN+Erz9wtrdKpkvomsjTc71BwZKRHGcZib2rCd?=
 =?us-ascii?Q?TAplM81USw+x4MwP9NMcRD3kipbKFg004ANj+F5E6UKgTLx9tsCW/6kQNX0m?=
 =?us-ascii?Q?eB+7gvLzGy4McmCHay4qEuoa8QH2NukeU0+OEONMi0XeOXkArKxVv/lDK5BY?=
 =?us-ascii?Q?M+mkSJb6tO8/H3D9ABFSwIRbM8yuhZMbQJMd3Bl6IWDRZ+NTFm+hjfNtk6e7?=
 =?us-ascii?Q?UDo/sDigKKGdhe5FR92MA7aQdzg0Hdx4KK31YONrk24bGSNP8TTxNObpN2dD?=
 =?us-ascii?Q?TQs3spViTzFYX3t9kRDsCx9T1C4if7PfNb6WajWa3yO6nzygVsIDL1R2EU2Z?=
 =?us-ascii?Q?trniUmK3AoYI9bcwPHUNzmgIrwBNgHPYkjMl9+8nUeo++zdmSDo+ns/vYyKg?=
 =?us-ascii?Q?68sGae9V/rM4Qgqof3nXUNF77xQrho+TMZ9dKsxUGwqau2iamcOSwSIrYAE+?=
 =?us-ascii?Q?wvMwVhSA53FohMPlHYSxCbjSdo6+VidYzu1xvQXievl3YIjd5ZFKOkyfMHzj?=
 =?us-ascii?Q?8PZNgcTv7uuqontqkpzV4VStD7bQDQ5k3LCo/u8ZuUzIm1wkq79DomF4wBZH?=
 =?us-ascii?Q?Tw9ImRZnj4S9USyEOsHxF4zzGse5UQDm3N3b0Unc/EVCuzR3f9e27YQrrGOi?=
 =?us-ascii?Q?o4Wjh1MZDYK+njcdKZ/gHQHMZqnNBFkBtdRvXER4tH17rPCZ2cy4n+QIQVIE?=
 =?us-ascii?Q?Hx7LJXm4LyUMCpP65ZXy/LYMoGPEnMVJANgwkZGWpDEdeOqJbBP6bISXGb7O?=
 =?us-ascii?Q?K5Bw4FnugJI+Xzt/dM0Eytq9Mm/T1H2/OjitmW1SRx+wr2EmXOhiHx7T7vmi?=
 =?us-ascii?Q?b8nMqFFPtbvL1KODzPFpFOkT9BZG4FyJLg+pZRzyHeLyTKwOAH5KK4qF71af?=
 =?us-ascii?Q?uUPoKOTv/mAP/qg/UN33iAd7iHwE6GFPgveEmXelhBK1Z9pUZGvypke+jGJ5?=
 =?us-ascii?Q?h7I9Xd+z+mX/g3yx9R5ys9fSRrjuoKETe3YuLTeALb0qSOgR5Jh/Ywg/r4Wk?=
 =?us-ascii?Q?FHGi8uY+VJtb6IftyPUVGvgg0hpnJVzz3z7rk75JlrEXMUjpJs6Vkmm9XAn6?=
 =?us-ascii?Q?3g0BJm1mZa+yPGb5s7bgZmbpS0a4abjXSOixYQklTkMgsfW06kKxvGObqfRJ?=
 =?us-ascii?Q?8+cLGAmtviYB3VxENkUkw3CFsf9yEm4thWkdKz433iUS8W55t6G7IOh4ysCh?=
 =?us-ascii?Q?ka2fbW/dBGp5HNzx3+GAbsOBm5zB7RSWPT2jyoiaHzIIslq3BiRqOo7BC54V?=
 =?us-ascii?Q?31OOWDdIyeH1mAAdf8vQah12twdLC1X+UQLhuJwCRe6RHhZr+MkgSv18fgOT?=
 =?us-ascii?Q?Bx+BW5po0+N+Q4KxE1Sm2mr1d8Sg7p/Zpy5j5kmRqhY2ETSDa3vzsoKJznTt?=
 =?us-ascii?Q?ZjsDFhZ53oDD+FiqU41351buil2JJbVkDYVZuqrM844dtMCvmD6E3Ry01Mk9?=
 =?us-ascii?Q?imCKQ4zAzDf4ivuqCJfBFfi3Mu3H2JgieP5IE0E98eP9P7cKiDiw?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbda597-afce-4ce3-bdd0-08def15c73d7
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:40:51.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB0xSU2lPDy760or99VZFFTriIlZfr+fXqtFmSNzeFhLjj2hifox0CAEq+3n1vShc2RA5n1mPW6EiTYCU4WmDH27DIlSCxETQKK3sMYQEx8leMeTUMeO5hLcJPBimcNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

This serial add support for the StarFive JHB100 SoC SPI Flash
Controller (SFC), which is based on the Synopsys DesignWare SSI
version 2.00a but with some customizations and it also add
enhanced SPI for DesignWare SPI controllers.

I picked up some patches from series [1].
This series depends on the series [2]:

[1] https://lore.kernel.org/all/20221212180732.79167-1-sudip.mukherjee@sifive.com/
[2] https://lore.kernel.org/all/20260521012932.24163-1-changhuang.liang@starfivetech.com/

Change since v1:
- Reordered the series so that every symbol is introduced before its
  first user and each patch is independently reviewable.
- adjust_op_size(): clamp DATA_IN to DW_SPI_NDF_MASK + 1 and DATA_OUT to
  DW_SPI_NDF_MASK, matching the two NDF programming conventions (receive
  writes ndf - 1, transmit writes ndf).
- exec_enh_mem_op(): use op->max_freq rather than mem->spi->max_speed_hz
- detect_enh_mode(): clear the accumulated mode bits when clock
  stretching turns out to be unavailable.
- dw_spi_jhb100_set_addr_nbyte() returns an error code, rejects anything
  other than 3 or 4 address bytes with a message.
- platform_suspend() and platform_resume() callbacks are introduced to
  handle platform-private suspend/resume procedures. JHB100 SFC used it
  to re-mask the SFC filter interrupts after a system resume.
- Limit address bytes supported by JHB100 SFC.
- Remove underflow/overflow interrupts in enhanced SPI mode, as clock
  stretching ensures these will not occur.

v1: https://lore.kernel.org/all/20260709055204.138168-1-changhuang.liang@starfivetech.com/

Changhuang Liang (2):
  spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
  spi: dw: Add support for StarFive JHB100 SoC SFC

Sudip Mukherjee (9):
  spi: dw: Introduce spi_frf and STD_SPI
  spi: dw: update SPI_CTRLR0 register
  spi: dw: add check for support of enhanced spi
  spi: dw: adjust size of mem_op
  spi: dw: update NDF while using enhanced spi mode
  spi: dw: Introduce enhanced single/dual/quad/octal spi
  spi: dw: send cmd and addr to start the spi transfer
  spi: dw: use irq handler for enhanced spi
  spi: dw: detect enhanced spi mode

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  22 +
 drivers/spi/spi-dw-core.c                     | 386 +++++++++++++++++-
 drivers/spi/spi-dw-mmio.c                     |  72 ++++
 drivers/spi/spi-dw.h                          |  52 ++-
 4 files changed, 521 insertions(+), 11 deletions(-)

--
2.25.1
