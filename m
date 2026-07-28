Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33341D62A;
	Tue, 28 Jul 2026 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233710; cv=fail; b=krSt2mcpJConCEbpvFd0CciTKMQnwKQeYutsGCkfaJqO6d8nQAhZsnQypckCkhJTnEVPZ7imzT/knI2lO2doj+rocyYg5jUVlFAER/4V2stAIUUW3rbCrCDpvREYtuXz5VE/ynInQYH+BdLUcZVse/RtXj/XEEob+i16lj7EvKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233710; c=relaxed/simple;
	bh=Yz/MgDXOFwvMmARJm66qPunuWHy7JHptXALTE7BEyjc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uDnsbiMgcSYVYDSkLmsUKm5IQuL0cXufVLrKy4IIg4a4HMj3/CtHNDFx3ogASKN20XgmvX3vV0llTtv/eCn4eWkSJondZd4P2YmyX4dtNp6xJEmNd6NAqtAuFRPYhDmfK4ijPcpDOfaQd9KCGKWQUX2+1iJkwagIMu+OJkgaeI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OChnhRJI; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OChnhRJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrW6bl6zeDzV/fJPKeXhIHHYP6lqT3NpA1nJVWqh5zEn+hNZvEW0mV4him8HLpb/nDbNkFOffC+4Ku+HVDRaK1Xmh+ZAM3SVs+tLIZcHWwI7TbaS3OJ5f3LWxkI8di7xmKe31hhArGL+niJD4zghW+ia26wl9E7q8xP6XxGWtwwRajakm3FgQJN2EvMT00vAmG3ULS2goGlneAa4DhmAhwaUVQeIMsXHZ5inQeZvRxV2sffTPTirvcxT11iSEUwr+N8kVj0Fu5VUJo47y7G+aCeWI1kcb96Cmd/qbuZ6RAKKqfyx1Re6ePi2IgjU5VYOon0SS4RsTWzcYpZA6NSEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYKmO9C8GwtmO99V01Ddnf/RH9nIIQmVl0fWqQW85kY=;
 b=TYid/vxvKf+gE7s4OFWvDmFK4ymwH34C44hqSSc427Ho75RX0xpVfmfOa0XFo3T85I7z47PQICRDqzgCm49avQNwhMhLjbNr9wFgOpjgj9gbeOiImvYhuz+pF2UskYDAlkZksM+KsMR8u5E2w72YKrorCglGRHsT9qYBWYrHiTTAsqGBCSuPX8IpvNBh6tqAsgxAG5IsSypAfQHc1PIJfvi7g4DrjmvqZDIzlwfqL56UKqrMAMluhpKZvAPm49zv16oEzalZL3WYn7T04HzPDMQtcFwBDUWCgOE1cXdlSR7xZQypPhNF3Qr55CvmHSgFgzu98wdrdQ/Ux3mBVMZ9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYKmO9C8GwtmO99V01Ddnf/RH9nIIQmVl0fWqQW85kY=;
 b=OChnhRJIbZIXwVDy1WaV5lpbTBU6qhkGoTxjcL0SkibX/SzTQc5ey8CBaPGzD+YDWovV+uIuzRzRTwN6AFmVogPWH4khNnlE229UTIrrb+ZqBIM/tkzagGozyG9VFYBnHEWwgC90vXIu8s3FZlLJsYfHQN2EPUGysjkSuhwWhZ02qqyGXq28vdNjuxuvvimJaSALmmtq+Dq/M8Yye/sxWW9vK2UdJ4VUwpQnFthUX9j1EUjTmhYYgkslXJL+4HBIpZ5ICq2NPrauqbQzHQka1/W5iVYN9+FfHx3M/R2dWIrRPyBmt1mB63h/o5tpjwO3dRj0HU6MvuGqUaQzSVU74A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:15:05 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:15:04 +0000
From: haibo.chen@oss.nxp.com
Subject: [PATCH v2 0/3] Few fix/improvement for spi-nxp-fspi
Date: Tue, 28 Jul 2026 18:18:07 +0800
Message-Id: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+BaGoC/23MywrCMBCF4VcpszaSi6biyveQLupkYgc1CYmES
 um7G7t2+R843wKFMlOBc7dApsqFY2ihdx3gNIY7CXatQUttZa974Utigc+IDzE6HEmiOeqTgXZ
 ImTzPG3YdWk9c3jF/Nruq3/qXqUoo4Q/e3MiisdZdwpz2GF8wrOv6BT3lc1iiAAAA
X-Change-ID: 20260727-fspi-clock-adcae0c35283
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785233928; l=1175;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=Yz/MgDXOFwvMmARJm66qPunuWHy7JHptXALTE7BEyjc=;
 b=3qTtkIoitc2z1j5TW5QJfFVXvnvKXAX/mQKV1YBwuE/tq0TeF2TZ+t8Fzu98oz167D5iWT08R
 mTKEz9jz3VyDP7MJZEb7eA9+uL/MVy0C21cTmP42ksGMD6wXkvzonMt
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: a8197212-9574-4a81-dcae-08deec911777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|56012099006|10067099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	oBn2rf5Gm0tW+HKCB7gLXJ+g5JZXIyZl29oyVKcYrwVheKRArURC6QltXDduiM09k9VSsoX0e+BcWYMDcnadmUH/AYq+qiYtZg+2G91WdGjxEzSvttKjjyfC0lhXUgqm8MsrfGs3CBz+XRH7oHLFsGykO5yp4b8gYEYEp8P5UP9/xeE7IWwO/39sDudEQ05Zn96eiOGCja+4QW7Q/jPu/RHfF7eFFO1XbyeokYWtO1Yq4iUYSGfAJeh0Ohbzb4HA4Hrj9mcfwBSKD3gsrPJDURUHACeHhrVRyX4SRtzcz5YggPzPdBo0CXeXsEAqy1dz7dZD74HIbMW8qkonAdg9zKVWM5P6jLu+7Ktao1mlTdFG0y8IcNaf7MZ9moJi+vcQHS346lS/e5N4z8D9X7lp2V1ST3pDUO++5KVAvkKhN/1OfStTHTqrcebQiI+IMwttgcg3QVw/12o40tMKNnf+3h+aG9WNLKaEh9ecW5yBRiuCHjPZd24ZSJF3udVuzRzUb7Vdx+s5AZNn1pDvNcVeQ8qXxU6JlgnuNPr+lfvgx07IdJhZ8Q34YoC0SmioSGEKf4dcO8mBFIq1LJdke1Ixe7Nb6bIN/GJY7R1ZetPRlnrC8Wce57N880sdFovkdkIa9ZEFpuMrqjdDEb+wqsKPh4gt5Yde4u/G1FRnsaIu+Cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(10067099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUNKNWl3R1dPczlVclZEYVo2LzJQK3B2SDFpcXNqWkFaMXN3YUtUK2hpUDVW?=
 =?utf-8?B?QVYxYy9CWUhYNE5vUXVhaGEvQlMveUlvSFFEdGpQZG5rcllQN01VWlkwWEhK?=
 =?utf-8?B?Y2FOUkN3RUg0SC9OSUc4MmpSeWpYaWhEeWJoREluU0JXcmpRMW5EZkxKUnhN?=
 =?utf-8?B?WHpIb2VHU0U0VDgrMENCTTR6eGs2ME5MZmJZVGZTVUdGQXBRTkMyNVhpenRv?=
 =?utf-8?B?ckx3V25xaUp1WnJYMmJ5RnhlL3dKd3VnRjdiOHRZcVVHYmV0VEgybUhGMHlJ?=
 =?utf-8?B?VzB3dnNrZXpNc292REZvZmVuelRIaGVEWU92TUNSbTR6akp1ZndTbGVoVnZI?=
 =?utf-8?B?aGZmUlhNOHlQQzcxNkFBTmM2c2JyNExqbHhzcVozN1RFaGtRWUtWbDJieXlU?=
 =?utf-8?B?bVc3M3BuWVFqc2RRZUNlWFFRaC9VVVdMQzFyQnVEMGhkQ29ybVVUQ1R0TmUr?=
 =?utf-8?B?Q3NJMG9iSlRMQUNpRG9XZ2p0R3BmSS9qS2lqZzRrbXJyNWt5b1d0VTNsMm5G?=
 =?utf-8?B?S21XZGhHQXFucTZwMHc2V2wxTEtlVlVoQTZDMDdkS2lJTzdoOTRNMWs5UTd3?=
 =?utf-8?B?aXZpSjZick4yLzBGTFZRRkt5Vk5GcFpEZWN5UHEwVE5jZE5oWDhBb2p4M2Fu?=
 =?utf-8?B?VmZTdHRZdWVPVUxIQ2dUa0IrQU1EUE9WQ2pBUW04dDdUMEQ0aXhuOE1UZlB0?=
 =?utf-8?B?dVpPdHBrWTVuQUNnMHJZNkU2Z2VzN3RlQzZYV25wUGdRQVJNZ21VenFUVitO?=
 =?utf-8?B?dkJQSzBkek13NG52SUpINUNOcG5EeVlyRmNzeEtkVUdodkxBamQ3TENoZ1Q3?=
 =?utf-8?B?UmZOS0czakRDWG0yRGJUT2dnSkRDZEllMlA5RjVIWkt4K21pNUFzUm5ZWCsz?=
 =?utf-8?B?Ymo5cW52czVQR0c5d042SVQrNGFMTUZuQVJWcmZ2NTErOWFVTCtGL1N1YVdO?=
 =?utf-8?B?azlPdXhUQ3U3OUh2ZUZGZE1PNEpaSFJ4Y3ZnUWVwM0U4K25qUjJIZHhTelNs?=
 =?utf-8?B?Si9JSjZDb3IranA2QUhRdFE2Uzc5M1JOME5OVXFBNEtlN3hwbUxTMmZuc3Nt?=
 =?utf-8?B?STVhUHZvZlMyWGk2ZUlvbDhESlQyRHdFS1FKV2lyeTRtWWN0UDV5YUlrSWVT?=
 =?utf-8?B?eUZwS3lqQUxRdTR1RW5yVGliL0ROZXNTanVlUVJHRDNVOCtOWGFzUEZNZkRa?=
 =?utf-8?B?c05YSlJmeGVtQktuWHNoeXpLYVRTNXVWd1ZZeWtvNEhXd0VLSC91UlNobnl1?=
 =?utf-8?B?bG5GRExGWitCbTVRM0ZUVXlYdHpCdzgySjZVeUtiYk1TRGg2YW5RTXRUVnNX?=
 =?utf-8?B?VnRYY0NpYTBGcnVXRHp5dWk2Q2F5RHRvdXR3TDVldWxQdE56cFYwRkhRV1BJ?=
 =?utf-8?B?TUl2QVVBVUlSdHBwYUFuV2tCbFpQanE3MDk4ZXZqeTJFaUFRcmJFNHBsUms3?=
 =?utf-8?B?b3F0UlB4RVh6eTVmeW1jK2hPOTN3bjI1cnhsODEveG1MdHhDTGJpbDJNSklj?=
 =?utf-8?B?VWUwV2NlWTlOQUhIT2c3eHNCTFdTdzBzM0FtVUdyVVBXUVUxUmEzTjZrOGtl?=
 =?utf-8?B?dk1hdk5tTDJ4cDdncjVsMFpMR1NsNXVsSGxoK0F2Nzd3amxuOGhXbCttNGkv?=
 =?utf-8?B?M2ZCWnJ3TlpCYXo0Z051OW0vaWF1THJBSk12YVM1WVpQZ2laa0p4NzJvL1JJ?=
 =?utf-8?B?YXpvZDhDcW9ra1ZwcnJ2QlFwMC9qMExtVzFpQXVZdXN6L083Vzg1VlpNVTQx?=
 =?utf-8?B?cFIvcnowNmR0ZWJHWERyWkQ0SnZBdXBBdGdaSFlKc3hScHl4eHQremxYK29i?=
 =?utf-8?B?NGF2L0FQd29VdmQvYnFjL3Z6R0tOM2lpQ09HeDd0S1l4bFVLbXpzV2dsTThS?=
 =?utf-8?B?ZFE0TDZIbmZyTHR2b0dNeE42SFVzckp5NytQLzNqd20wcTNCaVdISkdCVVpG?=
 =?utf-8?B?ODFFMnE5dGdNd3hQV0ZiNnZYb2JlY3kxSzcwVUc3QkFNWmMxVlRlNjNOYTFx?=
 =?utf-8?B?TGxjd0p1eGJFczVwa1cwR0twV2JIcDZVd25yRExMY2VMNm9OM1huZ3ZvQktE?=
 =?utf-8?B?TmVRT2VYNTFJWWtJZFJwWW5HL1BSdGI5ODJ1NGVJcXdqb2w1T2dSTWo2d1p3?=
 =?utf-8?B?aW91cUd1NkdESG9KOTEwZjdEM3NLQnZ6MWdoenJ2dFRHT0NKQ3F2a3BiNnBr?=
 =?utf-8?B?ZzZ4bU4yOFZKbURsWlhSMW5pN1RGSndGUXZDaC9qYkRJNXdZbTBJR0hST1oz?=
 =?utf-8?B?MDE5a0NMcXFzTTUzUHVhZVFhT0FERWtHYy9CZjNSRkdDZzEyOHJncDFoaGcv?=
 =?utf-8?B?YmJWdWp1OXp1UzlZYVBSMTJKSE5raDFJOXRXT3BCZVFYTzlsQnFRS1Z0ME9I?=
 =?utf-8?Q?60oYZ0qVQukF/5lvMY0jLkaJ2xAKCZh3RaPdp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8197212-9574-4a81-dcae-08deec911777
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:15:04.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ctchyTqxkkL4JYk3mgFN3JGY6xDSOFFhMo4qUaX4rMkaHFY/3SsNl+zCh9hHp/yXZpBWZjxkuZNAe36Rfx8oeiKCBmwfyB1qUYG+xTmsuSvspSvdpGe4kNe3JeUTqwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

Patch 1 introduce per-SoC clock rate limits for both SDR and DTR modes
        by adding max_sdr_rate and max_dtr_rate to nxp_fspi_devtype_data.
Patch 2 enter stop mode before reconfiguring MCR0 and DLL to follow
	FlexSPI reference manual initialization sequence
Patch 3 propagate clock reconfig failures in nxp_fspi_select_mem()

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v2:
- Patch1: rework the commit log by Frank's comment.
- Add Patch2 and Patch 3 accroding to AI Sashiko's comment.
- Link to v1: https://lore.kernel.org/r/20260727-fspi-clock-v1-1-f4f3be6c366d@nxp.com

---
Haibo Chen (3):
      spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits for all supported SoCs
      spi: spi-nxp-fspi: enter stop mode before reconfiguring MCR0 and DLL
      spi: spi-nxp-fspi: propagate clock reconfig failures in nxp_fspi_select_mem()

 drivers/spi/spi-nxp-fspi.c | 129 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 119 insertions(+), 10 deletions(-)
---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-fspi-clock-adcae0c35283

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

