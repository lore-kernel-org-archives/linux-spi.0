Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2129.outbound.protection.partner.outlook.cn [139.219.146.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A75542901D;
	Wed, 23 Sep 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158396; cv=fail; b=EEt7g2OlKdhbU+8R9YJ6SS4IAP6bGUfqy7f0YLnNjhUiTS2TYOmmUmN0RLBrnBwOKWWQMJbraLIkjrK+2KVR1ZDSYXkt93v0gJver5Mh+xh3ImPm3SdqFoVw9b9XE/KsejrHO6NdaF0v4hTVtVBiGMl0kTjXLAmFliV4c4jls/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158396; c=relaxed/simple;
	bh=09+gJsmOw7Mj6q9y5k1Xtc4EnEKzlp8mCcLraNn2Nt8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LHslUIplP635ie+IXVDFE1+U6JZsOrNPO0/2DF3X1CAgSfBrQ6t/Fe6rFy6uR/xzNGJNmgAgPuSEyXXBqJSy58Ua/Rl4l9byI6cZxTrWuvZPCsR7U5HaEvRniKk0EB/UpY+JhSjxgOC8s07ipU73VNR+tV2X+f+YnRq8mFHxUfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsbS0JVfd0y9ydgqliEvE/mBOFqshdLHhvoAX5O54DYAyZuc1TLC93keqlCrD3n8U/RvtE4uaKqrQw/mp9G8/VymDllUGzt65cWWRQmMcxQqqN5FkOGrVmmc5o0aldmOc6UPr356WdsfEdBFPEV9tCCwYjtr8484grCTnzpxkSpx2Y5/48kSPoL3AZHFWhY7OuKe8pJM00jqXBcbfW7Zg2GlS1MHvoOy5oaDTnVY9PYOFgIZkC4+/L7/QFp5uwlg4t9CwmN85O+OX2mg9r+Q1i6ycSEx8MIHCLffJ/Y/PCo0dR4FIrsZu/eAa2n/71r9P2Ow+8mK1jFLcD+tcfMfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI0Quhp9Ss+ATipgi1oif6CjgGHmwaFXyTiMiyHsaPg=;
 b=FpcN/rY6c2RJDIfm2r2qiX9Uh/oDecYCH5I2sIcTYIqJ+YREzqO8cRxfX0yBmnIVm9zH0m8uI6tSfTH/5EB8NMwEALUKrR+3Y0YqLndf3rB5yjV7M1QYE38pUQ4XUrJflh5jeZaDvzPHEFsN17fz/LeJQeVHuXRiygW79QsIxzvO5lTDT1cWMHa5uHSb1fHDv9V9bAbIl2f2ww0FVDoKY/bwglI9T2qYC4FFkHe1R9UPHseVEAVDY/srC7f6V5qfPPmwZPRp2C6UPwG0zKS59DpkfFzd2GHwp66Dduxu9W9IlNdaseVzowmam3Ilq5jaG9TrEGAQh5DBoTOI/G6i8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1219.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 09:57:13 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.014; Wed, 23 Sep 2026 09:57:13 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 0/2] Add enhance SPI DMA support for JHB100 SFC
Date: Wed, 23 Sep 2026 02:57:03 -0700
Message-Id: <20260923095705.233297-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::6) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae0d63a-2320-42f5-0db4-08df19590a7b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|38350700014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z8nXONOew0EBEAMUcQQ5p31g7yn8QjGGRKbrf70fzmkIXnAZ+5fukZkVp9kLwJYUQ0Aw5eUQXMFaE5PHMSozN1whfsN4W74b5LwmeRAgO6WYVvUCxTrRXEE0BUAcwl5P3AQdcoXeVbzYT+We6DSVoJy3tVG1Cjn7xJqHodXQBsJe7oWAr1B4yk42dwOOAmsOLerCgERzVGfJm6wiuSvnFwJ7onoFkB4rdJ9R39xdBL+ngDyrXEJXhPo+QSxpT5KcqhojdroNPuSU80x6EHPTICZuqsJlSbD6xcCRO4juc2eTSDnC6M6ydoSbbemKRwMhsMC2g8a59lSUi0+fjDtgjKmRWL+GDayeJ+/sIii9Nt59xPYjJZHxhpAp9UbCOv3IdHp1mTtY1F9oCPztWEl1UMLNyUOTsnp+nOs8ovDJEJachTeHnvJn/iMBRraTqm84xxhysA7ZavHxJawClqIUT+AKxKiysYcn/dSEUErFoFGg+5kNpu/Sdkh3IXYQEc/TLZY6vuHVXF0oi9xReI+1oIW6GWsTMJvFHEaARRAuOl+99cQd3k68aFmyilMUrpQ3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3hCLNPaM1oyfRMh8DMFvRf6ATZpnteYL6qQZduq/gtGig4rmF6iEJ+jGtJI?=
 =?us-ascii?Q?k2cuFx4CqvmyVWQdfkgvxylYGOsKqO+c9827RniIiIJozv3KqizjrOZYzP/t?=
 =?us-ascii?Q?QRdkbAb18tAxrrUjpHnNp+bSt3YKLxNJ/Pj+HY/oIe6tKq9xVYvtsjlpfcDa?=
 =?us-ascii?Q?hi5WzZ+jL+/VJ0cI+K3g6M5kYfv3tI3uDgD70HDnyLBRh3pCcq9dzh0WNfdP?=
 =?us-ascii?Q?BjRvydIPIOUVYiVJH8/8CIVUuCOFQasKny3Y57KYWNrLedpe6Nq4iTEBNpCU?=
 =?us-ascii?Q?m+9hnbsSqHqey81IBmfgf419KQgwm/x/w1Z9pE/MUmD50g8HIlj4PjNEEAuv?=
 =?us-ascii?Q?OmT1vG5iQ5kG0Mm2z8W68yBL+esFZcjy4lKP0EyaUqUfVRoJ2CwykNDciaxC?=
 =?us-ascii?Q?V5TL7P8WidUh9ITkkV5S/FrmZ/ksdpb8nzCUZo+EhfA6zWmg4LNdrxdwoeLK?=
 =?us-ascii?Q?62HvViGLtXe4J6OvAnwo9ZLOwVYMcRgQoT8yDP1MYnVu8Jn+uGKlT5vnIe/s?=
 =?us-ascii?Q?M5Ov3WTn6jro3R5vSJC9kxjeYi6wU/2j+8GYEcsyiCe+VRLaack7WxMEFDzl?=
 =?us-ascii?Q?6cULeYlJAjywZyDGyMp4RcpspogfPczQjkpMH/MOsdn25rYZgOriP7t8ZsMZ?=
 =?us-ascii?Q?U2PEi71v8nIxjlFbvgIRY0IKjoxg5uPJLQc9Mj5gVmPDT4gJwxkgJJ4T7ypk?=
 =?us-ascii?Q?geCv+XDfMXaKf3O/M7f+dnPOZOSIIhFDiVfkmuJJbDhIVLmp/qpQOW1qasa6?=
 =?us-ascii?Q?NL8cLfwKNa0zqYuOOFkOl2LKyIrOLJYhHg3o1jiPOMwfK6GwWyGKBGAoBuzh?=
 =?us-ascii?Q?seQbzY4Ma/0crfesWHrupEVonWeKjaOR7+FR8i+k2L80Rf2bjyRBpM24exqW?=
 =?us-ascii?Q?BpciSRaw4MgwDZwooCFtPSOz21sLveoNvQXJ/QQglp5zrRO1+8jFRa1Q421l?=
 =?us-ascii?Q?ZM+sc4T2tdT9MMXr5MN0Sb4UjHZw38f0FOpLSF8ML0fhuqXn/PGZ25caDZio?=
 =?us-ascii?Q?3TM2ijVDn0v/FmQ8uWRE3KxmcKX6MfjYw4rWJn+bY3wqto4Amvej4ygD264U?=
 =?us-ascii?Q?Kya0xK5SLYw/mIw6l6AKZzo077qZq4CIm2WrNKr9I3Q3L26+LYRRkqmEIREZ?=
 =?us-ascii?Q?RRVVKm+sIP4uW8dfnF8vPOZLljdNsHEasDWTH3x/nVo53SvPIHoDN9Ss5hbU?=
 =?us-ascii?Q?qW8sRgcdj8p2o1MuXF+qvbgQvy24hbfgkH4oy27ZNz+K+KUP3WGJCmQ1615R?=
 =?us-ascii?Q?TyLrzerobpdS7xm07Qd0plEL0nOLQNKikjWd+nTzfa33Sn7PWzMSoHPzany/?=
 =?us-ascii?Q?SUMUogLdMQRwUSIug4sPXXS75xCZEEnWCGotTCH5UWeweKGDxfvOI+SxGGn3?=
 =?us-ascii?Q?Mpdbn/Wvh2ov5vDvuV5AL0h2GAj82yPjwprFvhT1BYjLt2NqFu36PPviufOf?=
 =?us-ascii?Q?NoXZd0JbWuXkqX4W9Epr1NMnhawkJ35W9osOyBHJ1fsTYmYge96eBupahEVM?=
 =?us-ascii?Q?9lTwj+13Oh730ElFWvmhbglaRiYsjPFVGOai3J1aAyiKToVkfG3GVywqtLGK?=
 =?us-ascii?Q?+dvFuXyBFWXRxqlcbqLTOLabsuGezWCdFvRLlxQ9KUdhEiVEUv0hSvpTdRHa?=
 =?us-ascii?Q?ATGn5qJvWPTAt+bkzE9sUkTZiO0PRZ7Je39nq5MshKAmhxceVSmifSVkUFPa?=
 =?us-ascii?Q?oYC3lEht2UYnhPG24hoGXmgspRktuEPTVZkXEy/+xGtzHq7a1u7TI2l5ff+3?=
 =?us-ascii?Q?/BFzqBiKgFvzfUmTaH7EpE9D9e7M2tpUaasj6VhQE/BqgVo1uhwV?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae0d63a-2320-42f5-0db4-08df19590a7b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:57:12.9972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE1LUSOc4+L0cmrCXcJo3EWcmEB2Tpnwg3/1Rme7G8zPRgJqjJiCsDNGYMxB6UFyLHcudEvqXye7RbV2Pd4f/rPeSteyq8+eR7J6uyFx4NDHvENVHX+HzPVbTITK0ITG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1219

On the JHB100, there is only one channel available for DMA transfer.
In flash access scenarios, it operates in half-duplex mode, so we
can request this DMA channel for the direction that transfers a
larger amount of data. Different transfer directions need to share
a single DMA channel in a time-multiplexed manner. Therefore, it is
necessary to request the DMA channel at runtime based on the current
transfer direction, and release the DMA channel after use.

This series has already been tested on the JHB100 EVB1.

Changhuang Liang (2):
  spi: dw: Request DMA channels at runtime instead of probe
  spi: dw: Add DMA support for enhanced memory operations

 drivers/spi/spi-dw-core.c | 154 ++++++++++++++------
 drivers/spi/spi-dw-dma.c  | 289 +++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-dw-mmio.c |   2 +
 drivers/spi/spi-dw.h      |  10 ++
 4 files changed, 404 insertions(+), 51 deletions(-)

--
2.25.1
