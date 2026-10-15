Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730851EE08;
	Thu, 15 Oct 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086458; cv=fail; b=Hqy28Sp+EqW44iyHbEES4DX+eOoKh9JwZjsoGy7fVuftCUynQWUWC+Hyo6WUyjDCcV42QVQXTKrZ6Eny98hujw4AqcVJmm4uaK1CES8fXYigHxCfRe5UQIBMQihYaJVYavqfxGsw+0YBHo4GHV9LuFomEIzdvyGa20u4qe3UgWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086458; c=relaxed/simple;
	bh=v6opQsLEt5F0NSTb2tVmY4dmvvw9fQfzx57QX0HTEPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+7QTXP/zXxA/EX+l68tlcWiqm3P61IVLTAErV/Edl8NLBN0E6IlXErSFwiTQoDUl8RMG6lKHCDy2prXbcVw+1H/hqHSNjokG7/BiX80GyvjeT3pUKmfpeEcTdcisLgADvICzo1xCVRQzFXGZA4qzkv+EV2rcenk3TRHhpgtDiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xsW0qV4u; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xsW0qV4u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGJ89J8rcXkvC7/CllziPrNgoQ0ZJEchrR2uqvX/R8VmH/SYTCh4cF5vZKt+ias9Tej94JcLCyh58IQ26FU7WW0yq6xC4d0Y4SQC+gxJ13r+iWhngL47ey4tFuF6tNBHfukoCZveqOQVXXP4xbQ19dBCXO4OvAQF0lI6BCgZhR9tNqK5LvBDDvAA6KZcfap4f1FOQTi5C8RimK9gP/Ejvyn3l+gev7nrHa6ZSas8UP2iGHUOk4fFTHTUECSdFWxdiNWYC+kT7CNZCawXn0rh46pEK+vB3Zt1D6ePE9enoT69dmigjddurD9vPf6RD74Hpe7qQUKIB8n/XMJyQNpzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv7CrQZO8TP6gR//qjz7+uCFCsmle4Uh+jQY2J0RpgY=;
 b=Yi98Pl3n0Co60bOdmNWgGP42EygDW2TouNMQOcJ261fBiYkc6tBmNvfjrpu/KXujMwAX3Kk2MlhydXvdX27sxYkAQd+lUjXbWrGntsnOo4ItSni4oOBNMpqmuYb0qNV+OKibNcFZc77xjyiYARzqckf0bz31V5ot4KK1AKngfBFCmrVwHZ0dQY2Is83rDBzCbIkKq6bjsqbmEw3uEtS3DV24zOnx8cB7L+29miCZxpvfoYEKw3mT5N85BVt8iDi2qFXuYj4a2NDLOkNEbDYaDmkKW0TXab4mylNrZVsvTk4I2JW2gaizWzSOhDYssg5Z9LGka1DOTbN4B0JGsYt6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv7CrQZO8TP6gR//qjz7+uCFCsmle4Uh+jQY2J0RpgY=;
 b=xsW0qV4uSfZ8i9ldAbWPGoBWgZDS2xbXogvrtYa8pQBfdqweN9yEb6RGtN02+rki1ZCcd1gaI9p1P2i9k/DtBC6MDieEBnTpbywBV2AFdjD8CJJRSsjQt7IQDEp/mhbeiNqj/HZ8tB9osU8XyNLDD0EbVrj8e5dYlyR4JI44nSw=
Received: from BL4PR12MB9534.namprd12.prod.outlook.com (2603:10b6:208:58f::18)
 by SA5PPFD911547FB.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 17:47:23 +0000
Received: from BL4PR12MB9534.namprd12.prod.outlook.com
 ([fe80::d8ad:832c:a997:7b16]) by BL4PR12MB9534.namprd12.prod.outlook.com
 ([fe80::d8ad:832c:a997:7b16%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 17:47:23 +0000
From: "Boyapally, Srikanth" <Srikanth.Boyapally@amd.com>
To: Santhosh Kumar K <s-k6@ti.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, "pratyush@kernel.org"
	<pratyush@kernel.org>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"takahiro.kuwano@infineon.com" <takahiro.kuwano@infineon.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"praneeth@ti.com" <praneeth@ti.com>, "sebin.francis@ti.com"
	<sebin.francis@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "a-dutta@ti.com"
	<a-dutta@ti.com>
Subject: RE: [PATCH v10 00/19] spi: cadence-quadspi: add PHY tuning support
Thread-Topic: [PATCH v10 00/19] spi: cadence-quadspi: add PHY tuning support
Thread-Index: AQHdT92xQ+xygSLAEk2C5egMPeH7zbb+mlVA
Date: Thu, 15 Oct 2026 17:47:23 +0000
Message-ID:
 <BL4PR12MB953485166308D311C5AF9CF69E9C2@BL4PR12MB9534.namprd12.prod.outlook.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-15T12:02:21.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9534:EE_|SA5PPFD911547FB:EE_
x-ms-office365-filtering-correlation-id: e4369d92-23e6-4b78-d81d-08df2ae45e52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|6133799003|22082099003|18002099003|10067099003|3023799007|11063799006|921020|261009223027099003|38070700021|261009221227099003|56012099006;
x-microsoft-antispam-message-info:
 l8x6cFN20Kr8AWB5uy8nEXAblRJn/7AF3Xi+g8wOp/TeDnQh9G6j3SKUbQSNq96u1jLI6hDGqcP0Rj5hGJWegmOWKUvx88JLzTNpiNUteTUwqlmbt09cHT3aEU8z/G1o1JXUQSev0FesSQyqvjENEeDPZ1QKa2KNRI/gBFmDOkHA3PBKktSnGm5mLpXk187ntCPrYuRBh/DEl8JTMB1z+RG25CScHymqvyY2EBj+guHzuqAEomPEgX1J7s6uC0hgD5wLXYvlqzKc8N1Wms8ASCMugFR8oxAl6faQC1HqfB9lSlStPM8eW56JcM9IqMbR+uoIpKN3YcYNjSeDYkxPijQWXwxshlQwD23QG5/1MzxPqX+cjJWYRpws/uy/i9XPNDVmfHWArABZZiONvY81hLjV7CmnPawxRTs1+WVyBBO02h3D6CXvgghtRKv4nneYGvN6J7IU2C/xUDQdYr6Z84fM3dYYjVPpp8qW/FDhW24eucVbPG9OrUeY0G5ESLxRHRDOH5z9k6I5TTqLmiUhMlti1cHoY+74TsvBr4SOL5KXwV912Oc76919Q8HaYfRvvSk+U/38nIHsc5sBNJk8oVuD0oRJAcsccrhIIhnZkt8QKjYogvGvr+kjzXSQcTUepiJ7Rus/fZYC5JS0YZhVaaiVYMwZrFNctX2Lj0FMHyCsnO1K6+4imCC8WpcW30Xo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(921020)(261009223027099003)(38070700021)(261009221227099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q9w5QYJpfCM1iGkmH+or8BStPjYNK21HAShkALmL979L8gKPIXC1AjHNJKr5?=
 =?us-ascii?Q?qWCiP7kGzfnXYF4c+kFjXtn5zjXyDXcjes793P1kDZJX3BrwAqIuMgRabhZY?=
 =?us-ascii?Q?hKOburNeZaLD/wqP+m7dEevKBLha8toiwechN1vzL2Ka7Unh4t/u1UMetsKg?=
 =?us-ascii?Q?22sPFL3L1aD+4P+w3FYbxmFIb0J7ctjLl1Xo5i9gogm7iRnUjugXwuTMPIPn?=
 =?us-ascii?Q?AMVYBB34GqIVbSDBxE9vxWGvNjYrsI0L+zT3ZrjDfrL+7aXo1gmmzA39LH+O?=
 =?us-ascii?Q?38+VFE5X97wkHVqh5u2RN/hEMrWCAU2IUcICn5LGsnxHMGjt3369ftypv8oA?=
 =?us-ascii?Q?hiwKjA76c0O/SntunSXuQ53zoLKYxGFSt7VuvMbsWTLA8mGrxLYXd//9NyHZ?=
 =?us-ascii?Q?HEP01ZSNXNJroOjvrNyEuA+I/7YxdOOvncN+QI0oJnVl5p9laOZK8TsXn41O?=
 =?us-ascii?Q?yOLc5kRrtk0I4KiKd0URdWn/+gT752bUBXt0rFVdwea8hk50BjiHJegbXptL?=
 =?us-ascii?Q?EzUBAsaM9HRyo8xoZKqMCp4qdeAHHZbsmeTq09v4M9xWYaYL/hiMzhVxvIp4?=
 =?us-ascii?Q?Sk77CxF2Xr4ZO/uhh/KqvGSutP+Mi8twSft/EjMOYl40Ahz7aq63RxjT1PST?=
 =?us-ascii?Q?VIAblELP5mdLeUwwUwFVdgSLsrrouQNE1RTPGjdDC9XhZzowah8yKM4w3cj/?=
 =?us-ascii?Q?7PwJ5Jc0vp4OowGQHCdImuvFg/Kkv+jNTl7a67ZIkvso+voksSNKlk22A63m?=
 =?us-ascii?Q?aCeHWnZKoiOqWZMzAHapXPZmXIggfSnSLVxUjlLFGx+B2b2LuCpDhpVFq1Qn?=
 =?us-ascii?Q?vnyRunYblekjBK/Zy0lVNxFa5X4RaaD4OJS8o8UAwjqUYq9iSmGnYTw5Imbn?=
 =?us-ascii?Q?Ek8+M7R6yRNIn5UnVpTkeDzGoEOCVoXBJ6ykIWCi4U/vd4p0umrQOppXGZlG?=
 =?us-ascii?Q?eIQb4l2IAoM5uLdkQpfJfah+IR6jdnb+J+cTYxzbDNnF2bFVRB2XBfmxDuRW?=
 =?us-ascii?Q?hdi8jNBScsP026csZuYDuN7upAnb3rO/CUD0X+kIMHL7Br5NGCZ31/gkGf8C?=
 =?us-ascii?Q?cvEK1XKGVF1GPtI/Od3AhtuGKFS3D/HLsUF0cljRZfrb+v0mEmzuc9SqMrN4?=
 =?us-ascii?Q?HvjzC5f3xMvnFeqJqeeJFTxub+LbSOEFhgz+XDLCosNp9U9hzl9QfGDXV7Jx?=
 =?us-ascii?Q?q24FqFEdSr5JMkieV35746f1sZqmYqQbESwqCaBcpqZsF2MOWOLMPljcjani?=
 =?us-ascii?Q?oelIDEYf9akVQqQA+c5BgkOfOreSXc1PVocetm/dwyhCix1x0UgasuFISde2?=
 =?us-ascii?Q?OoP2P0CPrUcmbGpyYLHyUb7S/WNEDBHGA53YbccI123GJFcdrsi3Ah8XJjF7?=
 =?us-ascii?Q?ybYO6QymHTuh3uM68EfsL5zux6LZjECl0d67j0e3Phg0ZxNMswHjZ9IgfdtX?=
 =?us-ascii?Q?0EawCZPLqq3opFaVJj+tCWBjvyO1P474Gbrrm7002JLgM8N2An3a9pf1g56X?=
 =?us-ascii?Q?RgUVA5n82D5v1w1IR/w078gJIOe9Uc5quN8y1svg8NNIgbTg9rXf5Mq1Jh5e?=
 =?us-ascii?Q?L9xExjKxjwFcYO7i9Nws1mWc6X7cWPVku+Pmg5CJgYjMjJwwB0Rd0lViFDiN?=
 =?us-ascii?Q?B1sqJI8UcZ8nJjTXDmjIem6mscEzO/JDxpgCwOTOBhhZhTYDwbtyV6SSEIAj?=
 =?us-ascii?Q?dLFvxnI4B/ruvvnQCFA8sNomZALcUYbfGEkV0nBe4HZnqisB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4369d92-23e6-4b78-d81d-08df2ae45e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 17:47:23.2677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZPRe66xqMVz76vKWi5qOY+xiQZMP+XR/avznXjYTLWDH0wEy2EGi0aJdfrH4zBogb3meHqkO8ocB8/MDwvFAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD911547FB

AMD General

Hi Santhosh,

I tested this series on SPI-NOR flash devices on the AMD Versal
Net platform by integrating AMD SoC-specific PHY support on top of
your patch series.

Read throughput:

  DTR-PHY (200 MHz):      271 MB/s
  SDR non-PHY (20 MHz):  19.60 MB/s

To validate functionality and robustness, I completed JFFS2 and
raw MTD erase/write/read-back testing with random data across
10/10 successful runs. I also verified odd length reads, which
consistently matched the corresponding aligned reference reads.

For the SPI, spi-mem, SPI NOR, and cadence-quadspi patches,
please feel free to add:

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>

Thank you,
Srikanth
> -----Original Message-----
> From: Santhosh Kumar K <s-k6@ti.com>
> Sent: Tuesday, September 29, 2026 12:05 PM
> To: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; pratyush@kernel.org; mwalle@kernel.org;
> takahiro.kuwano@infineon.com
> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-mtd@lists.infradead.org; praneeth@ti.com;
> sebin.francis@ti.com; u-kumar1@ti.com; a-dutta@ti.com; s-k6@ti.com
> Subject: [PATCH v10 00/19] spi: cadence-quadspi: add PHY tuning support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> This series implements PHY tuning support for the Cadence QSPI controller=
 to
> enable reliable high-speed operations. Without PHY tuning, controllers us=
e
> conservative timing that limits performance. PHY tuning calibrates RX/TX =
delay
> lines to find optimal data capture timing windows, enabling operation up =
to
> the controller's maximum frequency.
>
> Background:
> High-speed SPI memory controllers require precise timing calibration for
> reliable operation. At higher frequencies, board-to-board variations make=
 fixed
> timing parameters inadequate. The Cadence QSPI controller includes a PHY
> interface with programmable delay lines (0-127 taps) for RX and TX paths,=
 but
> these require runtime calibration to find the valid timing window.
>
> Approach:
> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>
> SDR Mode Tuning (1D search):
>  - Searches for two consecutive valid RX delay windows
>  - Selects the larger window and uses its midpoint for maximum margin
>  - TX delay fixed at maximum (127) as it's less critical in SDR
>
> DDR Mode Tuning (2D search):
>  - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>  - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>  - Defines valid region corners and detects gaps via binary search
>  - Applies temperature compensation for optimal point selection
>  - Handles single or dual passing regions with different strategies
>
> Patch description:
> Infrastructure (1-5):
>  - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
>               frequency achievable post controller configuration
>  - Patch 2:   Add spi-phy-pattern-partition phandle for
>               NOR flash PHY tuning pattern location
>  - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
>               spi_device.post_config_max_speed_hz (0 when not set
>               keeping all existing DT fully compatible)
>  - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>               op->max_freq equals post_config_max_speed_hz, return
>               immediately leaving op->max_freq unchanged. All other
>               ops are capped to max_speed_hz. Also require per_op_freq
>               controller capability for post-config ops in
>               spi_mem_default_supports_op()
>  - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>               spi_mem_execute_tuning() wrapper in SPI-MEM core;
>               serialises access via spi_mem_access_start/end and
>               rejects GPIO chip selects
>
> Cadence QSPI Implementation (6-14):
>  - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>  - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>  - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>               verification (NOR via spi-phy-pattern-partition phandle,
>               NAND via write-to-cache), SDR 1D and DDR 2D search
>               algorithms with temperature compensation, AM654-specific
>               execute_tuning entry point
>  - Patch 9:   Reject 2-byte-address DDR operations via a new
>               CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
>               around AM654 OSPI erratum i2383
>  - Patch 10:  Refactor direct read path for PHY support (preparatory)
>  - Patch 11:  Enable PHY for direct reads at the calibrated frequency
>               when both transfer boundaries are 16-byte aligned,
>               falling back to non-PHY DMA otherwise; also reprograms
>               DLL on chip-select switch when two devices have
>               different calibrated settings
>  - Patch 12:  Enable PHY for indirect writes of at least
>               CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>  - Patch 13:  Reprogram per-device CS timing on any chip-select switch
>  - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
>               runtime resume, since the DLL loses its lock when the
>               OSPI controller is power-gated
>
> MTD core (15-19):
>  - Patch 15:  Extract spinand_select_op_variant() into a shared helper
>               spinand_op_find_best_variant() with a skip_mask
>  - Patch 16:  Negotiate optimal controller operating point before dirmap
>               creation; iterate all read variants in performance order
>               across ODTR and SSDR interfaces; re-pair cont_read_cache af=
ter
>               PHY tuning via protocol-shape matching
>  - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>  - Patch 18:  Execute controller optimization in spi_nor_probe() before
>               creating dirmaps
>  - Patch 19:  Reset max_read_op frequency for security register reads
>
> Testing:
> This series was tested on TI's
> AM62Ax SK with OSPI NAND flash and
> AM62Px SK with OSPI NOR flash:
>
> Read throughput:
> |----------------------------------------|
> |                | non-PHY   | PHY       |
> |----------------------------------------|
> | OSPI NOR (8D)  | 37.5 MB/s | 218 MB/s  |
> |----------------------------------------|
> | OSPI NAND (8S) | 9.2 MB/s  | 35.6 MB/s |
> |----------------------------------------|
>
> Write throughput:
> |----------------------------------------|
> |                | non-PHY   | PHY       |
> |----------------------------------------|
> | OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
> |----------------------------------------|
>
> Test log:
> https://gist.github.com/santhosh21/e1b5c7cc5cad4acb94b67e826d971ab9
> Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v10
>
> Changes in v10:
>  - Gate the frequency spi_nor_spimem_get_read_op() propagates on
> matching
>    protocol shape, and add a patch resetting max_read_op.max_freq around
>    the security-register read override
>  - Split cqspi_tune_phy() into cqspi_tune_phy_read()/cqspi_tune_phy_write=
()
>    so PHY_PIPELINE is never set on writes, per AM65x erratum i2189
>  - Fix spinand_try_ranked_variant() to only clear, never set
>    cont_read_possible on ranked-variant fallback
>  - Fix other, smaller correctness issues raised by sashiko-bot
>  - Collect tag from Miquel
>  - Link to v9: https://lore.kernel.org/linux-spi/20260825171737.776052-1-=
s-
> k6@ti.com/
>
> Changes in v9:
>  - Fix off-by-one in DDR PHY TX search loops
>  - Fix cqspi_tune_phy() to unconditionally execute the disable path
>    and restore CQSPI_REG_READCAPTURE on enable error rollback
>  - Fix other, smaller correctness issues raised by sashiko-bot
>  - Link to v8: https://lore.kernel.org/linux-spi/20260821114822.4040338-1=
-
> s-k6@ti.com/
>
> Changes in v8:
>  - Re-pair cont_read_cache with the selected read_cache variant via
>    protocol-shape matching after PHY tuning instead of unconditionally
>    diabling continuous read
>  - Rebase on v7.2
>  - Collect tag from Miquel
>  - Link to v7: https://lore.kernel.org/linux-spi/20260811183313.1550425-1=
-
> s-k6@ti.com/
>
> Changes in v7:
>  - Serialise spi_mem_execute_tuning() with spi_mem_access_start/end and
>    reject GPIO chip-select configurations
>  - Fix cqspi_phy_apply_setting() to also write the calibrated
>    read_delay to CQSPI_REG_READCAPTURE, previously software-only
>  - Use local op copies for pattern write/verify instead of mutating
>    the caller's op templates in place
>  - Fix the READCAPTURE bypass bit in cqspi_tune_phy() to match the
>    value validated during calibration instead of being hardcoded
>  - Enable PHY before starting the indirect-write state machine instead
>    of after; the old order was a guaranteed deadlock
>  - Add a new patch to reprogram the PHY DLL on runtime resume
>  - Fix continuous-read and ODTR/SSDR template handling on ranked
>    fallback in spinand_try_ranked_variant(), preventing data
>    corruption after a fallback
>  - Fix other, smaller correctness issues raised by sashiko-bot
>  - Rebase on v7.2-rc7
>  - Link to v6: https://lore.kernel.org/linux-spi/20260723110219.3180747-1=
-
> s-k6@ti.com/
>
> Changes in v6:
>  - Add maxItems to spi-max-post-config-frequency-hz property
>  - Rebase on v7.2-rc4
>  - Collect tag from Krzysztof
>  - Link to v5: https://lore.kernel.org/linux-spi/20260717185116.2065505-1=
-
> s-k6@ti.com/
>
> Changes in v5:
>  - Rename spi-max-post-config-frequency to spi-max-post-config-frequency-
> hz
>    per DT schema unit suffix convention
>  - Rename CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk to
>    CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR for clarity
>  - Rename SPI NAND identifiers to remove PHY-specific terminology:
>      spinand_configure_phy()     -> spinand_optimize_controller()
>      spinand_try_phy_ranked()    -> spinand_try_ranked_variant()
>      spinand_reset_max_ops()     -> spinand_reset_max_freq_ops()
>      spinand_op_find_best()      -> spinand_op_find_best_variant()
>      phy_read_variants (field)   -> all_read_variants
>  - Replace bool odtr parameter with enum spinand_bus_interface iface in
>    spinand_op_find_best_variant() to preserve the existing enumeration
>  - Replace cqspi_get_phy_pattern_offset() with per-flash probe-time
>    phandle lookup in cqspi_of_get_flash_pdata(); fixes incorrect pattern
>    offset selection when multiple flash devices share a controller
>  - In cqspi_tune_phy(), reprogramme and resync the DLL when the active
>    device's calibrated settings differ from hardware
>  - Edit cqspi_phy_apply_setting() to update phy_setting.rx and
>    phy_setting.tx alongside phy_setting.read_delay
>  - Reprogram per-device CS timing (CQSPI_REG_DELAY and read-capture
> register)
>    on any chip-select switch, not only on clock changes
>  - Move post_config_max_speed_hz early-return to the top of
>    spinand_optimize_controller(), before any state is modified
>  - Remove dead NULL guards on SSDR op templates in Pass 2
>  - Downgrade tuning-failure log messages from dev_warn to dev_dbg
>  - Rebase on v7.2-rc3
>  - Collect tags
>  - Link to v4: https://lore.kernel.org/linux-spi/20260618073725.84733-1-s=
-
> k6@ti.com/
>
> Changes in v4:
>  - Add spi-max-post-config-frequency instead of extending spi-max-frequen=
cy
>    to accept an optional second value
>  - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq()
> extension
>  - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
>  - For SPI NAND, execute PHY tuning across all operation variants availab=
le,
>    perform duration comparison, and select the best resulting variant
>    by taking controller-specific restrictions into account
>  - Move i2383 check from cqspi_supports_mem_op() to
> cqspi_am654_ospi_execute_tuning()
>  - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
>    cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to
> use_tuned_phy
>  - Remove redundant spi-max-frequency parsing in driver
> cqspi_of_get_flash_pdata()
>  - Extract DMA refactoring into a preparatory patch
>  - Rebase on v7.1
>  - Collect tags from Miquel
>  - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1=
-
> s-k6@ti.com/
>
> Changes in v3:
>  - Drop spi-has-dqs DT property; DQS is now enabled automatically when
>    the selected read operation uses DDR signalling (dtr flags in the op)
>  - Extend spi-max-frequency to accept an optional second value forming a
>    [base-freq, max-freq] pair; the presence of two values signals PHY
>    tuning intent and encodes both the conservative base speed and the
>    calibration target in one property
>  - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
>    two-element array there; single-value DT is fully backward-compatible
>  - Move frequency enforcement from the cadence driver to core: new
>    spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
>    the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
>  - Propagate the tuned max_freq to dirmap op templates after
>    execute_tuning() succeeds; store persistent op templates in
>    spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
>    frequency writeback survives across the probe call
>  - Replace NOR pattern partition lookup by name with a
>    cdns,phy-pattern-partition DT phandle pointing directly to the
>    partition node
>  - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address
> DDR
>    ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
>  - Remove RFC tag
>  - Rebase on v7.1-rc5
>  - Collect tags from Miquel
>  - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1=
-
> s-k6@ti.com/
>
> Changes in v2:
>  - Restructure the .execute_tuning() call from spi-mem clients instead
>    of mtdcore with best read_op and write_op (optional) passed
>  - Add compatible-specific .execute_tuning() call which can be called by
>    spi_mem_execute_tuning() if exists
>  - Handle tuning requirement check by controller instead of spi-mem
>    clients
>  - Add support to write the phy_pattern to cache if relevant write_op
>    is passed or get the partition offset which contains the phy_pattern
>  - Add tuning algorithm for DDR mode
>  - Add support for DQS
>  - Restrict PHY frequency to tuned operations
>  - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-=
s-
> k6@ti.com/
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>
> Pratyush Yadav (1):
>   mtd: spi-nor: extract read op template construction  into helper
>
> Santhosh Kumar K (18):
>   spi: dt-bindings: add spi-max-post-config-frequency-hz property
>   spi: dt-bindings: add spi-phy-pattern-partition property
>   spi: parse spi-max-post-config-frequency-hz into
>     post_config_max_speed_hz
>   spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
>   spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
>   spi: cadence-quadspi: move cqspi_readdata_capture earlier
>   spi: cadence-quadspi: add DQS support to read data capture
>   spi: cadence-quadspi: add PHY tuning support
>   spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
>     (i2383)
>   spi: cadence-quadspi: refactor direct read path for PHY support
>   spi: cadence-quadspi: enable PHY for direct reads
>   spi: cadence-quadspi: enable PHY for indirect writes
>   spi: cadence-quadspi: reprogram CS timing on every chip-select switch
>   spi: cadence-quadspi: reprogram PHY DLL on runtime resume
>   mtd: spinand: extract variant ranking logic into
>     spinand_op_find_best_variant()
>   mtd: spinand: negotiate optimal controller operating point before
>     dirmap creation
>   mtd: spi-nor: run controller optimization before dirmap  creation
>   mtd: spi-nor: reset max_read_op frequency for security register reads
>
>  .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
>  .../bindings/spi/spi-peripheral-props.yaml    |   13 +
>  drivers/mtd/nand/spi/core.c                   |  328 ++-
>  drivers/mtd/spi-nor/core.c                    |   94 +-
>  drivers/mtd/spi-nor/otp.c                     |    5 +
>  drivers/spi/spi-cadence-quadspi.c             | 2275 ++++++++++++++++-
>  drivers/spi/spi-mem.c                         |   55 +-
>  drivers/spi/spi.c                             |    2 +
>  include/linux/mtd/spi-nor.h                   |    4 +
>  include/linux/mtd/spinand.h                   |   15 +
>  include/linux/spi/spi-mem.h                   |   14 +
>  include/linux/spi/spi.h                       |    3 +
>  12 files changed, 2671 insertions(+), 154 deletions(-)
>
> --
> 2.34.1

