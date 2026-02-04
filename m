Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84AD26F28D;
	Wed,  4 Feb 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214362; cv=fail; b=bmmQqgV9+RIqdlqMrZMhikcmWuCViO++TeIblXEPvckKpWWfo1HmbghpfAiJjywGC4HX1tY5r3U3wY4O/IPmWF7vUJRZARrEtIcoFxmsXrPeNkjGFewGiy7UAvDt9WGAJrdI8J9TkAZ+QKIuCJYMa5+AZqUMNF9ZsW8LMejVI9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214362; c=relaxed/simple;
	bh=3ruOBB8oDzpeFUmieEK+AQYhqdCdi31kTP7NYJvsOsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQU2LHjy2rNhwQcceWyMWMOmnSjzEmmrI5wJpo0I1Ukwg3B5fMC3MG3eXlP3bTvTrTzjsK/jp1714XrweKhYljf++BffJhs5QQCVrE68TxIvWwNTRDNe9laTmimFnRfAYBTBkOZ6fZ/yM4beqSVqwRxHrrX5PJFjupOUm/xARGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBLkqg33; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBLkqg33"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw55DckpGYDUFDvGNQHbqI6AVEAxEMd6iMTsT+QNff4TBK3hnfALjymlBajM9+/6P5bWoLTyIJhCJHXJUKTiJBo1P/MPDMmU3zc8CCmUWyWi53aMumM0JgZupncv2WTdBY4rfko/p1qlDzbh/5DDoaAEBm429FExIVTaE4UqXEK/J9WjE++gLwViITuwYSwsVABNPWR5yQfh3fXYsdJVtxjrLougNgNnxb90h5T2SlSg1zdO6qcJMTXWh+AQbp7NEZ3nhsX2OLYtR5bdDo8kAAWSNw7tcHEn7uTzWZkTnhSsWOVBTnd8aU7zOD+Ej7yONBHaZPwBwMzSV2zM4RHHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE+9R397W3WHns1mubM6VzWhaRIkouIcX4/5QlCJhjA=;
 b=kjqwZrHiPW+JlP8e4mDWj7P/39JL1if5xlGR797Fu/h7v1xN5iXNQcHIT1aMyOJzWX461FSH0p0EEZc4xI8/q+JNvWYO0ub8a0ko9FDF9BjifvHCQ2KOXA8CDfyo25IDecnOTy/MrtjDuR9aqjmCY5aRnFyRnVNDMpXkwhASCTDUbtGXzq5H8Ce96hS1rmOF2u6ThEv3tQcpLNyclfxMbgtglQw2qcIGlmPyd2A6flI9Cjs/HdEy6OxRUacQ/jsmWTGRKkwgZ2q9gpP5FnpLU2mKrxW+kgOLPw6S8z2aPmIlgvfoqK3pRMLdXrGgqPOCwR30Wf4NaLxHITqcLjBc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE+9R397W3WHns1mubM6VzWhaRIkouIcX4/5QlCJhjA=;
 b=kBLkqg33UPSdANtW2it50VgQjGDvnjoDKkmkkLR6mTAyhg8TqNWBXXozRfw3ZReGfsmUqQx3vgzh+MLo+n0jynZnewAS+cHIxiga9vuKyeJk3d7l2actJHvRSGKP2SEE/GIBNOhHv/ay24rBSSpQyxp4Bai1N74Kwrnhm4KSBuqTnabmrQbjV+GLtPNKLwybftY8hLN7bDxOgZr2VZee2IJo+klVt21+24vGrszZAQwsc1DUkTkuzbxxQZ98j+xhGYpKSxnJXNB8QqvC+Pf22GpzRnzd39aUq0HAdXSmolxc/sVog6AlIC8a7kURZ/MjtbSxWj8zkbOYM9vQrH9NGg==
Received: from DM6PR21CA0022.namprd21.prod.outlook.com (2603:10b6:5:174::32)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 14:12:36 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::c6) by DM6PR21CA0022.outlook.office365.com
 (2603:10b6:5:174::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 14:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 14:12:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 06:12:15 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 06:12:15 -0800
Received: from build-va-bionic-20251122.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 4 Feb 2026 06:12:14 -0800
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: tegra114: Preserve SPI mode bits in def_command1_reg
Date: Wed, 4 Feb 2026 14:12:12 +0000
Message-ID: <20260204141212.1540382-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4f0f11-14d5-45a6-07e2-08de63f77247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8fNvK25JETOCy2aNEjoGFS5Hrl/Tqgn32gdFVfubGy9v3RbfDrHkpJ0WYJu?=
 =?us-ascii?Q?nIsybinUS2j2ON4tFwx6zGut54R8CbnAMWQaSFRdflEHOE4wot0n1QtWIKvp?=
 =?us-ascii?Q?r1+rdZygRPn5T79SCvRKOM2T9GTr0Si57x+T53b2d6Itmqvkq2r5yr+jscZ9?=
 =?us-ascii?Q?8k/X1tMeERG6yWxsVQZKmZDkG/gbU9z5OEmdCeBfMnEzES2YkXNtmk9H1uGp?=
 =?us-ascii?Q?sbox50jQWAMhD/0U8QbHieuPC18IG7gP8AA/eboU+J9KNF8jcn9yKNzWlGmY?=
 =?us-ascii?Q?LgaJslW3G5GUtHz4HHQW0MScnKiUtKpkLgTrus/l1jnhNOmnOji3nDK85zVe?=
 =?us-ascii?Q?JCUQUlbkytchw6RjvbbO9OMC34wVAfNNP/P7IBDjRbQKYkiQroz+JBPdgb4R?=
 =?us-ascii?Q?ZmTZ8A48F92goMsWz3d6ulgblmcn3ObVzkQJevzMGx/xLofI0kYiDbaJvwc5?=
 =?us-ascii?Q?n4V11IZvZLKhOHVSqFieEthbZm6otxxbE4EItAaJVEbqmh0xtKoYDz9LuQ9m?=
 =?us-ascii?Q?jRvEurccS3Vu6VEay7e8qQTt+JagXrteto7HbjiqEQPS1qEL/airlvEBpGxd?=
 =?us-ascii?Q?QxoMjOLaMXjrxFN7eF1Y2DceeQxatFQQYtvkS/d6IJSLzi0Yz3dMeXhXi3bj?=
 =?us-ascii?Q?TXHgKXX0aF7snNiMtEfdYBzLEQCYfQDKJZLRwkM+HLCHUGCCAQMw/IzmhKD8?=
 =?us-ascii?Q?A48ByskZ1F7irZj9AwqvfLIVM41pQJwSLNTRXQo/GDQ7++DE4unzfpIxntFt?=
 =?us-ascii?Q?yNXKutrCta7VMehoT5BhgBYtNgqI7B5jZRVUDdiPGa6mXECBrjaAtjUG1mGU?=
 =?us-ascii?Q?WuNnt+vA1S8XTBdXFiSK5Z22V3i5B019mOMBSC/pZnZcFsPK+l50bjNWaca9?=
 =?us-ascii?Q?Uf6uxaTOSji6XCPTFR5WslIkPOJG306gJc0MuIJEL3nI8XCOKl3TGYwjEA+C?=
 =?us-ascii?Q?TTtNy3bkDqzQUHUbFdI7NLrhe6+0pF/gu3Rga0Zu5p5P35VT9Fw5IDtpnfXn?=
 =?us-ascii?Q?wUDAiE3DetRm9Gz70zsSoJFL4ULuxH3p4KBRjuskbHo+sSdZZKDsedDcX5BK?=
 =?us-ascii?Q?KND0Ds9xW769M7VtpQBGdaTJSx9IcLboAEGQROj8Dd7Ft985pcC7h3jg8iN7?=
 =?us-ascii?Q?N3ZwbTB5RKHrB4sJ451SRo7neb7kCYrNAWdwrwgkrCoz7gPyAphppkeYxmXq?=
 =?us-ascii?Q?76AhbVQdrp7PvC7jxD3Bn5nW0piI6T0gIaG1J3kgEsyazwIDdOqV221DSs2f?=
 =?us-ascii?Q?88cODFTod6vSCWp1jt2d9FauEtO1WQ/GSBHIyA9s9aqAqafMD1tFaCf/NWeO?=
 =?us-ascii?Q?bnG6EEq9t+kIgeyxHw6KC6h4IqUwnS0VCtty9jismUSTeBszUviff7TiXNLr?=
 =?us-ascii?Q?doiwwV9w/jfcdH5pKuUJ36YyeAD9nk0Y2Ovhgkw+hthaHnQGW6KO5iMO4ba9?=
 =?us-ascii?Q?43YCDJ7hb3WEh5TXwDVjn7TfDSwtt1mPGaBTLNOMY6ONe5zIZnWEh0/3Bh/V?=
 =?us-ascii?Q?g/Yj+TUcrqEvFP0neiaqWopRvqi4bM6CcXKOsR9pv9+h8G0LD380UAHzq81O?=
 =?us-ascii?Q?TMiE4ALU+/BK1k7ph2dxEZ/7MrZr83w73XqumEFGbEtFucGqid0qMDlFGf5v?=
 =?us-ascii?Q?fCtlaf70LjkKM41BaKbk3BCSqZfWjNmImS9BNJtw2IM7C0GltDDzCGOh7cT0?=
 =?us-ascii?Q?iQPePg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2QJWTgzNulR/3DPh5Ey+99F9IsnHBAC3fElPZh8YfShnr02dWicG9ACDMzmNlzfmbT5/V8roIvhVcDyTrOkzSOLk3ldmVXovsTBkYnKzQubham31b/A9izRRiel84UHT69Vdo+ISSFOnkb1+Ewsx3DW24PJhFI/pfYdB7+tYeJoYvThoR1hEVjjGy8j+JatFgZAcbVVXMpx/Fzd6bfr6dCI+jAo1Cm0Nke0+nOiU7/72QmqzkCoaPSGbjIEp8/y3ADjuSQ474V7KQACDFpws7/0jgglGTqpDUCWiluXzTtDkgTNXDrTowO4Cvf7cpp6FQMtznNdzJfv2l/by1+9YhjtUfgvGfe22dhaK75mgQ53tE5Gyfc4YIVViY2pNk1jVkx30aSXpf/2wW+qMpfHuCuk2fPoZdvIRwx5g20aUCZcU0ujn/2l/1klVBgY0ikDK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:12:35.6139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4f0f11-14d5-45a6-07e2-08de63f77247
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

The COMMAND1 register bits [29:28] set the SPI mode, which controls
the clock idle level. When a transfer ends, tegra_spi_transfer_end()
writes def_command1_reg back to restore the default state, but this
register value currently lacks the mode bits. This results in the
clock always being configured as idle low, breaking devices that
need it high.

Fix this by storing the mode bits in def_command1_reg during setup,
to prevent this field from always being cleared.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 795a8482c2c7..48fb11fea55f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -978,11 +978,14 @@ static int tegra_spi_setup(struct spi_device *spi)
 	if (spi_get_csgpiod(spi, 0))
 		gpiod_set_value(spi_get_csgpiod(spi, 0), 0);
 
+	/* Update default register to include CS polarity and SPI mode */
 	val = tspi->def_command1_reg;
 	if (spi->mode & SPI_CS_HIGH)
 		val &= ~SPI_CS_POL_INACTIVE(spi_get_chipselect(spi, 0));
 	else
 		val |= SPI_CS_POL_INACTIVE(spi_get_chipselect(spi, 0));
+	val &= ~SPI_CONTROL_MODE_MASK;
+	val |= SPI_MODE_SEL(spi->mode & 0x3);
 	tspi->def_command1_reg = val;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.17.1

