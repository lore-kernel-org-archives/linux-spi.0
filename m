Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588984;
	b=rFOn8HWEJWy3nbyruztm1bX3QJKDfD/R5bJ5GWsO54lsFi5njzQk2BkJXljqa36Pxg6u
	 N+JNy2fADEZH83chy9vbQUx9Th+BUrMsr1L7eAKztEaajMyELZ2D50yD+KKqLAD0G0qGJ
	 UF8PVb7kJsdrF7UUnjob3XOsp+iaKwAJHWg4VhnDhQW4zE/e4GDtU5ykwPS6jscCyMfVb
	 /aK8OArqL3KUfeVv+5X0aqGddc9bfdCIz1rIpc6oi4Wk6gzimnrYdhftd9hUiTQM/fFbS
	 fHDEld9QIhN5NYF0JIJaeIRZmBBjOmDQOYkYUYoshGh53oYK4Udt+9ywGR657LW7QlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588984;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:Subject:From:Message-ID:To:CC:MIME-Version:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
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
	bh=53ji13d+h+JEKts2Z89Kfez+JeTlaJTa5XRRiXW+Qpg=;
	b=nzfBOkoj9JYopjb6IYza1Qni5WSrcWctJ5IOvSR03fN0ejp0o1zpr+aVOpUbgBlddTzN
	 SdsavVVJB3ulrTuE4Iu3CRDVW+OzgjbG1pyidP0GarcDi5jcXaQkitwXrWTI1q6qhlrMq
	 gSOLauBQHFOJt1t9+CBkEqH7jVzQVdEqqvFKDHUCCEXFFyMmVkXAglDPd63eOzu/zXVbf
	 cFUN9dioB1hk/xH81ZmxJcWITTffG9FPNY5OqvHwRkebEb8ldkZZ4TL0bLngV/AbSlM0c
	 VZ4w5lSVz0qhp917hsmyUdFuIoew4pGv7mrTE/lxvoRgSP6RceCztil2jezryPLR30w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mdDGJogH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66910606A321;
	Wed, 21 Oct 2026 13:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66910606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mdDGJogH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgMb2FFUfKWKQUv32GAlemcYP5rEbiSw2aFOx9XktWTpJMtSRL2WGcEHsxYQKkbQ7ber1zvveWDjuzFzK2OfZakHG96ka4TDABmF5x+JBIKI8lFYZgxI5bjvNGE1CmadhyiF718EjIzj5rQd2DiOA/BfN0bJajBzm0ca2tSyTQ+ObJj8oP60UuPG6Z4bcTC720UOFcfJciga/r7x5+7jf4lP4+npQUkg8pcNqJPUIuQvw6JaegSwvN3y3qDXnmF6vHJpYQEU8jwLqqJmlosdB4XOFCytxSbRWWqTJkSxAzly5JhYrgNqt5WjaUevYEgkIE0z+pDFAmr7vIGFSf2lXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53ji13d+h+JEKts2Z89Kfez+JeTlaJTa5XRRiXW+Qpg=;
 b=FGPfP8iyOdaBOyvaz322rpNiw4yiXIcMIQolLfjie/J5XO+jOc5BNeizfo6VuDaiqRCF3XOyHn0+bcYlwMGmm5k0jw0oJD6nXinKZbI7iDMCJoYxxfh7SX/F3X7Kpz1CMah2xl+BGHnt4kGPCMdvj+B0YXbld+Q0zLtVOuYhaTghM0FqcWv/jgniXATqZ4J9WPqJsF6TufL6LIImrhUhLSGVRHfRjWwuVx7MhwJ0OiXjjcoD4dF8YqAFyxa7DXlg0M29fnngPb5bSvT+BwPPxtgcy73mhz9sS6I5YLZUtprIzZa3wzuooCiLS+/8KLVTtTujDKLxYPVFWr0DeU/cpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53ji13d+h+JEKts2Z89Kfez+JeTlaJTa5XRRiXW+Qpg=;
 b=mdDGJogHgKsG2HgRvKRLxOqmAZZjbu5PuQuUos6G3S4pkEbjhGJiK/+LHMEeZzF7ci1VmTxUWqhjTx30HSwGC++SFyzUzd8lH41dLItyjyXV5UA7Jdv6PNR1BsKsLeX6YU0TtsOGh1wBrixBkgVIQP26VVQSDTNhsC3kT6mmZlirzVoW1Lg2Vdg8oH+HHmO1v4Cx6rNeTRLa1PpQ96PkpstQpDLMV0ca35xx+XH5+UGFeoQKNVGljcISlEj3Gpf0ljuPWix3h7cM9EmbC/z/UGfJqWPV05ELZamfFP8ckzsWGBc6we8ezA1O0uOF1DH1jWnGE5SU740AyXb6RwhasQ==
Received: from BN0PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:143::20)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:22:57 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:408:143:cafe::32) by BN0PR10CA0023.outlook.office365.com
 (2603:10b6:408:143::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 13:22:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:22:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 06:22:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 06:22:34 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 21 Oct
 2026 06:22:33 -0700
Date: Wed, 21 Oct 2026 10:14:06 +0000
Subject: [PATCH 0/5] spi: tegra114: chip-select fixes and PIO-only probe
From: Vishwaroop A <va@nvidia.com>
Message-ID: <179258895296.403962.3492255118456900623@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 40acc64b-3202-4f69-5d54-08df2f766bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|10067099003|260925021911599003|261009221727099003|260925021311599003|261009223027099003|261009221227099003|11063799006|261009223327099003|261009220027099003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info:
	b/SoP6GQ4867le+JawTnNPhkI1OrRafUNFgoZD/ou7y9duqevzuixbQ+ryEOotPL381tqLS4KCbKLWiHFThGkxwatmvmdbxhL/hdSujgciZK+CjlQEa48RV1eXwmeJI7Yq1sEvM+kVz5+y+R88kdKtH7z78JezwdrcShXJoCX8Cf7o+XyJW/HoTmrWP/LY/CfYC5IOusEh1g974qTHrJybmB8Bfn4BfKWMUwvHXtGnsq6Sh/AlrsKgEL17smz/Uxa1PuUgHXuVtxwcvVZM/gifcHLxQNHEZIfiGyD8ydbgY11sv3UGoBVpB7k0UvknO3Z3bBZa1uV+N4DjrcwU2oBjQMfuoYPmrUwWQYx+oLhBNNjp6SSYJVNCWoAQHwibAP+r2ZBXUkEZpnCedysNTLaUkKuL1iIQl9K0IygPDi8ksGS32cgMN8epf9XXXCbRknlST5BZFGdvs622yAhHQI3OpEfsSbukvpQqH2hwdkRXNcCPovQzEKKbHiJOadWFCYa+sL8yHMjL74m8A8wmASnUxwjE5g2P6Nk+jRA8L+gWr+8gDIW7P8KmwhWXme1IcTMvO44wjDCbV0/wsV+mRUuA0G7TV6w/8CaKgZ6ViD3uZaE43XMark9sYYPjhRNU62EH3lQ+iEF9e6neqUPuQQbuCuWZN+tC3f5qJSqVctkJRI5IwOjivSvwnvgulnkg8ACo+R2xNW5pkpwTsVfPoWNg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(10067099003)(260925021911599003)(261009221727099003)(260925021311599003)(261009223027099003)(261009221227099003)(11063799006)(261009223327099003)(261009220027099003)(260925022911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ae92MZOTY1PY27Btb72xRQ8jsUf9p/KbCefDBWeY1gSW7menS85VB7taMAVKDEzfZg6iaIKG6W96MDBhf1yYvbhKB1dTjrlXo8EslDuwDg0INY7QTi45klZFgaW5xqP4+dmG+qX3sBc74S+895KyMTfzW3iyb1IvTiO6iNy3cjMw8uph1faslueEWrQXEnpybti2meDCEsrGFmacwaVch1381bz4l/minqhcnWYodoeEly1HfmRR2frxNcyDFnN3NKFFNURQGQcDU61DiZ7oCgu9+HoIUE3ht3vuEqL5gbj+CY6lajdx1ld+eo5Ei041rpFfzXEBZ3sDIzAZUsbPDW8J5UdYyrKkMwc91+L1sDnCoGdBJ6tifisShuzGns94PeJjVldegj5E5ZdQPNThfycsIt4xyBfOYPy+ZcQelS6wy0PYwj4po6zPRa84iT1e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:22:56.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40acc64b-3202-4f69-5d54-08df2f766bc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419

Tegra114 SPI sends each transfer as its own packet, and hardware CS
follows that packet. The driver implements transfer_one_message(), so
it has to do the per-transfer delay and cs_change itself. It gets
both wrong.

The delay runs after CS is dropped. A mid-message cs_change drops CS
and never drives it active again. When the last transfer holds CS,
the next message can turn hardware CS back on and drop the line.
TIS-SPI under spi_bus_lock() needs CS held across those messages.
Multi-transfer messages already use software CS; patch 4 only moves
that choice so patch 5 can keep it.

Patch 1 is separate. A missing "dmas" property fails probe even
though PIO works, so fall back to PIO.

Krishna Yarlagadda (1):
  spi: tegra114: Allow PIO fallback when DMA is unavailable

Vishwaroop A (4):
  spi: tegra114: Run per-transfer delay before ending the transfer
  spi: tegra114: Assert CS between transfers when cs_change is set
  spi: tegra114: Decide the chip-select mode once per message
  spi: tegra114: Keep software CS across bus-locked messages

 drivers/spi/spi-tegra114.c | 126 ++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 37 deletions(-)


base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
-- 
2.17.1
