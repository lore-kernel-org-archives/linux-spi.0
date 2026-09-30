Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C64534A4;
	Wed, 30 Sep 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752566; cv=fail; b=j0Z4drnwlybpdtYOan5WANlfA/6fUl66wO05V6sbHQ4nEoDpcN8YPlV7QIoc0zSMocPOHFGu01gadZLjkgblMfeSNXrH/4CtaxQ91Rajzu4dG2dhOXd7D3RMPkHPyK3Y3vA6ib/gp1brvqqRk6TjieGWxOwVztr1064d/bb7ogg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752566; c=relaxed/simple;
	bh=ya2sJdY/A5pPN64ovuHrJgcN+ZX1E+a8m3vDk5/HtbA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s2X1XuGHdWlLA7FFrt5mFJei1uFGmN0eMEu9Vi3Sg0jSVYfPbJvix/mc38kCS/N2I6STHOLOjOqNB0hVEqs0Hormop6X0iqBtisy3CZsYfnGup7eYbQexBey7grtHzmCzTNbJhkRrZ0hDt3n4hNOB4womjIHrcyqrsoLHzm1DfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1MbUmuWHe+QUxcEAQCKlz/yqSpmTZ94afr9UDRFDr1SSUeawsGlcSoFwv6bPAR1n9R748lPBKIg8/MF8MfRS0+lXEb0qgi7R8URwre5wo5yaCzChU0FW/CJu0pA/XkvNmaDkXPA16hSO2lKQkagVDtcJdq3CPFYM6zEWocKpgqawRtEWR74WUrhrsmlA/FB3PFxXuRd0MdxtV5JGExtfOSWjRVfIlOGF4jGvA+4E7X+2Jmr7VGjlwZfVhnxKN+KoSz6cu72D0nhHxO4ls+GIs30A3mzpB5JS6RUr0wOY5DkNwkK8AEN2idguTaBtiOpKr/eUw0jOfDjNJ2jC5Zzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zshh7hI5TA7yd9z77i7sgJ2/MhTQFg12oHx8F62U288=;
 b=MLG9BqNpkWYjOSsumgUnB4i36pr0p9Pzt7B2ODlA1lWhIf0cxRDg4F01i5Y3OBQEp+6R8NCJ6sm3t4CQKuwBOmkO3rZwAt49k5CVG3mYI5fzj3VORs8HeX9yq5MMlNb97h2PPzllxcWrMTJz9xW0oszeC7SuSNEfDlJ7TlhQXnKTmgfJTcTxvtOlRHuTjxBIyHE+Cj+Qn5zLQxjQq02iotrOUt57MwSkpUd4YOmKyqyfduAfblWXtVxj7qakBQON8cqoQ8fSRUw3XaMKRLwFj03404sbN/9ZRLPCypfNnASW3q4Fc0qWTlribMhaflFNAueECGRbhng2S/aiScp2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:15:46 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 07:15:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 0/3] Add enhance SPI DMA support for JHB100 SFC
Date: Wed, 30 Sep 2026 00:15:32 -0700
Message-Id: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: aed867ef-acd7-4028-6d61-08df1ec2a567
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6GRtWzDg6EgeYmSOv30KaYPSARjYE1s8QlASQ+1X2cGOI0399vpitCiaWgWN+GGWv7JbULwIVbDzHbYpw4Q2baT9FDmGPQu/dBdfwRN6hnuoNnvZRztQ3x+btN5QWbOeDwN2vhuQbyoSSDaaxxQi5dq0W+Pf43+FLTjO7lNJJwgpOc/PY5ivDNdoZjR9YaAbEaRRit/MTJo+QVablaC7BGKytha19z6aAw8vdbxEysI2xQCz/14Ed2NLjcwMHaS6qHOZlQBfDxpDK+0e2HPaSE7X8+5vdH9F/so6CB6aMJ+2/DrrEueiXNNGRCf+Tna1Yn6WqNIpi6UsjgFNYOAxnHmIn9oiYcW1H6xfb7josfRK+6JaCQdcUqfz2sjNU7Zix/O0OLBZrIbLpL3F1jYisiwtLDUlbIFZyB/MHP+8M1vjmxDZQSgL5yS7F2ZCdeKhmmF9xaRyD6xba8CtD4vfUBaKDIPO7veFsPfOIWWC9BpM4nN2tX1D8BnRmlFy/z3WeCuqWwQCUbpaL+50oUFyN0nVuKarJP6l+OZvOQXtFaVqapD5h0JjfoIKX1KmpU7K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nwKaC2n/ynkTE+T2nTrligj1LdWy+9UCS1pMzn2IqMHrHmuiKthe+Pyk+Os4?=
 =?us-ascii?Q?egqwLaY4YrMcDjuorwMd/fJGCrmY+pojVdThWnVZxGkN3PThEWkj14QetIGR?=
 =?us-ascii?Q?dZNbDiz8sJJY2Js6CxxktaT63llPCW4dBaQBEt5/u4IRnEryv0KnPkitTjPw?=
 =?us-ascii?Q?50MNpqL7qBB7vpxxa4HP9wK69CPE7YTAECUUZqLX5HmZgmvkyukaG2EBI8Xt?=
 =?us-ascii?Q?VDed+iZgNc+YThmiOXEXjd7y8Z8ZTnVJj7sH+oNwDYcrmvqGOUsZrBRk3OM+?=
 =?us-ascii?Q?nt/O+DmbNT9GfgbAVHInWWcncGHm1N/u6SC/fRPzSYfPMRSowxADc1f/o1DA?=
 =?us-ascii?Q?Tk34uy96aLI/dCbZYoDiwOnbjPU4qKnDnksunzzbCqNmb0d37LmIG/7MHr4x?=
 =?us-ascii?Q?I4L9e2k1JHrIY3tkC9Z3pqaW8A68KX5hW8m4lMKS2vjKqBsXz2s1F18FsiqR?=
 =?us-ascii?Q?1njmez/HQ3BN31wleb3hTQvqMwLblw7Q09Ruoz6BY71M5ixCSEY4yC3YLCUs?=
 =?us-ascii?Q?UEKKrftOBQu7/OWLhIz/uDFqkFvWn2kqZ8q2GmwrLlC6imP3pt0lhMLtHoIH?=
 =?us-ascii?Q?NyPCuXimGtt6n8Lgqza+nkx9PZgR/xz+5B/H2OoKO5eTJ0X1/3zeuPStcnWm?=
 =?us-ascii?Q?3/Md/8qSWtYyGfeVD2lHk8yZZJjWpV9Dkgvxvkx9z0hajhk/9jKapE75KVsl?=
 =?us-ascii?Q?OcI/E2h5moy0ub4dbxNHbZyshnZzKY3mcON4Sxlh3Ukw4Fsf4klfzaNTxg3i?=
 =?us-ascii?Q?AxqtFI0hyhX5QVy4rP6bg6OxIuHKtPxEszlWpn1XvPPJn7GE009fKFt2pNJI?=
 =?us-ascii?Q?tgM02zs4zFY80t0ha+7/CoU+PmCnhRA9ftpM4S15rYMlTD1650OjDjPitW2g?=
 =?us-ascii?Q?G0ArpV7hNiDRw6szh1wnbPlTGkusl6Cn5adawv6cANW9g7Sk2p7vD+gzDiam?=
 =?us-ascii?Q?NTUMEBDaFRLz/W47PePMyiIpK1bcBei29kxy/YM9BuFiDZuWy4Mr3ZbfoJZU?=
 =?us-ascii?Q?Se35CZCSxCSCPZ+gwz+vEQGL8m73XinZi9jKQ7L51vwyW4WZwTG2O7u7W9hg?=
 =?us-ascii?Q?ReEnSlsfrwQEs5ji2rBszETPtLAk8Xa4Gh/P4ZqN8+CCUcm/yvEJg7/ezYwz?=
 =?us-ascii?Q?o4qLKR/V4ymw480DJwQsP1mtF0KCrfUoqYKllckPXEEZ1zT71PeYFlnjiO+C?=
 =?us-ascii?Q?l1JRKIxbhWg1mSFwJZG7mxxLefq2+sp1e+SPigPT07TMo/ylUFHHUSlBa60H?=
 =?us-ascii?Q?WILPDkqOW5dgEUHQ5vYxzY8KZ/qNqILf5uXGjgxFCeq9sZ+Wco3FOxuAZMP3?=
 =?us-ascii?Q?KMpauQkFPpDm96ptewx7ko81n8jKGbAM9C7BNV85DmQFEK3xOD2WADbbKlWH?=
 =?us-ascii?Q?tLPOQADBmmEeDtIbGg47WpzGzJisUGnGdGh81D+/X+9jzahjo+cItXfVIiiF?=
 =?us-ascii?Q?hE3CKsvF8zzK0DMwHKufAAmQJi5RBwxDQa2hif5uo+Yms5vGdVv5NI5s2FnD?=
 =?us-ascii?Q?VqLERypDpXEYMPnjEcHD6AaaOvC4w4CveTDw5gUMfmEtEAaZ1hzhv6dX+u3d?=
 =?us-ascii?Q?WYJp7cEUDdJ+H7Fq4xZr/UkNYb4ODRGHGSl0GtOhj8qWY2CRvzY1mAWAjlHl?=
 =?us-ascii?Q?dZiGBkUF2fj95uzD05PHiACckachJu494v1g12H+q/55N/jMoG15cTNo+I92?=
 =?us-ascii?Q?SJjYKWBYjxu8p+xLfhbgb5IVnUhBlP+KyZLRK7k44eZ+qitjTlsknEJglRWv?=
 =?us-ascii?Q?i389ZYzAEH7NHJXdEAZCmYF35o21/STMe85Lc7jWk+IBif3QOsTW?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed867ef-acd7-4028-6d61-08df1ec2a567
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:15:45.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPOW0st0V5lblsZIUYLLCjYFtfCebyOaGi4yLiKHFMaLtafswKhsLVe0MlalQ+b8oN/sY/0iy44FD7oLKbTJoZ8VGS+weuE8AL5qu1ug/LSVZZ2m7OQtUSyTMohN+hpV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

On the JHB100, there is only one channel available for DMA transfer.
In flash access scenarios, it operates in half-duplex mode, so we
can request this DMA channel for the direction that transfers a
larger amount of data. Different transfer directions need to share
a single DMA channel in a time-multiplexed manner.

This series has already been tested on the JHB100 EVB1.

Change since v1:
- Add a new patch 1.
- Keep DMA channels for the lifetime of the controller instead of
  requesting and releasing them for each transfer.
- Optimize the process of requesting/releasing DMA for every
  enhanced SPI transfer, so that the release/request DMA process
  is re-executed only when the direction of a new DMA transfer is
  different from that of the previous DMA transfer.

v1: https://lore.kernel.org/all/20260923095705.233297-1-changhuang.liang@starfivetech.com/

Changhuang Liang (3):
  spi: dw: Convert the Tx done delay from SCK cycles to time
  spi: dw: Support DMA with a single channel
  spi: dw: Add DMA support for enhanced memory operations

 drivers/spi/spi-dw-core.c | 103 +++++++++-----
 drivers/spi/spi-dw-dma.c  | 290 ++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-dw-mmio.c |   2 +
 drivers/spi/spi-dw.h      |   8 ++
 4 files changed, 336 insertions(+), 67 deletions(-)

--
2.25.1
