Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AA1FC7;
	Mon, 22 Jun 2026 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102655; cv=fail; b=GkDVq/CdedvcBYcUFL6ykBwfFq0z8AWe8E8E0crN14NvRvYa2QKYKMhpl3sc/2SeRIBAb2qPAqn3hnJARTtTHBsEY+XhTN+DBJeLLWsEZObrUGcAw4hd8U342lKu1KmAn8VtaFD0fhBHJaAQGevQ7veZmOBrjTZkPZpv8jP388A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102655; c=relaxed/simple;
	bh=I8QVNqqWWGLSixLryqMW8ZYtF4IHDxFr0Krzo5q6NX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6BQdDGcA2Ic2JgvNpNGzJpBOsPpCqScQNQJl6d/bd3KdEJj8OQwuZqm04LzWbHVWXyDz6Drezshp4GE+9UFV/Ksgu47UJ5RnEou10GmRIR3FuQWNtJDgFhipf2gnRgjVfiLuD3rWSbCm7BGDf+hNs+BSx8VFkagQqThXsUgHP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7Szm1V5; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7Szm1V5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALG1ganNhyJtzjQ9e2FJIGDrZW27jvaft3MOhg1UxJagA9nKA62Nofee4cfEmyh7rXP9fLrWSac3ePbmbpUuvL7MLpBIhCW1rJyB5SmWhnoyHTkj3J8gDUDbuy3BVbJ3m7cLMYPs3oymrkwlKdeD17AyCjwEPErRhdPvAND7x+qz68unjrwDdICya+OsRA8WwF0ImuV7YJUkzjvqIkUNVkKgp/1RMefHrH688nyparnvBKZBoGoeWuW+QODO6dsNVjQLRACeQWL4NWsHS0cbkf3mJM24qxSxLPZNI1UlPTEhMmF1CJmiIUScNmhs5Xq8mPvcSoelfAUAPrGLyIKUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtYqiwZe1/C/IHxSm09BK12syBfcdYfvg9ruLMk/0zU=;
 b=AbEUl/e5Xmae+PSiQWCfZWasGoQ1IOMv8dTjql0F/z2Kydrau4evDgXSGlSzapP57QzwGrUnG9wj/yNoasWam2ND88t9bIqyfOx+eV7MbEG1N7q+tAbYmeqNsAXXJZk+Pxruq015UFaMCAB66GimVmdzFslFeBBGKLIoCKE5jKDq5BvPeQm8qNYL41pSxn2FD7lm5j0vaH49sAMSGs7oDbrScXs2qtQX21LChCIRjFPht0iazwmOlusMcUD04dnYhsAFO9zj13MrNitzQB0UsoOQ8INWr9L2pLA5z55fbo4cOunrBYqQrctnBV3zr23h74AAla+TES0JcvtUz7bo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtYqiwZe1/C/IHxSm09BK12syBfcdYfvg9ruLMk/0zU=;
 b=Y7Szm1V5mfExcMipm93I1QP4IzeSQGqlhIZn9THJQR7fcwbR4mxaqIADizq0WRqwIPkQUCxIi1UOm/zG5fWL3d9nai4tWWWUFlzmUcyXvR/YA6sCYXfl7E2yQmmcGOceaLSy5fIW5dFJLjY1gvMm3EK6CNrZJtWNq+06XumUVXE=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 04:30:48 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 04:30:48 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
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
	"praneeth@ti.com" <praneeth@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"a-dutta@ti.com" <a-dutta@ti.com>, "git (AMD-Xilinx)" <git@amd.com>, Amit
 Mohapatra <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v4 00/16]  spi: cadence-quadspi: add PHY tuning support
Thread-Topic: [PATCH v4 00/16]  spi: cadence-quadspi: add PHY tuning support
Thread-Index: AQHc/vVy4naZUONYPUiTCjVUkD9g5bZJ+wEw
Date: Mon, 22 Jun 2026 04:30:48 +0000
Message-ID:
 <DS7PR12MB9503EA13A8FB71938556F1CDDCEF2@DS7PR12MB9503.namprd12.prod.outlook.com>
References: <20260618073725.84733-1-s-k6@ti.com>
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T04:06:11.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9503:EE_|DS0PR12MB9397:EE_
x-ms-office365-filtering-correlation-id: 8bb0cfd5-c3d1-4996-3df4-08ded01708d3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|3023799007|11063799006|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ATLSSsTYI84+NDjsYcbkMN0OI5mAlv9ur3k4Ss1jBPRX9fmRlwNWz6EW2D31i6EJJw85jG0zVYJcnqIXHB3nkvJOLE44GTgx338h2OdBqxaLSPSgMz3DHKrW6AdrxJ3gzalIQCu6dREjwpddcP0GM/VbhpWgi6M9oUFO+7szpZ4JJeDPc0jCmN9UZ6SITaAENtUWx3sPIGWX78+gBAWVW+7XMHEu/Yt6qUqEMDBI8qcyxVxTiszYrXNspNgWKOKNl3GnnGYu8eeN6OUAD7yLK9xOdgc0QCFu9Uq23EoYurHwNa3PIif9SytAlvqwpWGBIZneSjcj7IqzMZJg86MNKh0R33QrQNjGYuWznlALZl2OB/OUHG7LpfTdswltncJR1N1e/aFNSKq6oLyGZ8F61FCjo/434SOLPzWf789XOaDMXT6edLJ00OlyScGHsMsloULwBmHWbsvJtgYpS5JNWGGjqcCmClqYCFwky3j0rXOtGWfJr2DH5HqMtyt8/+DzZI1vQejoy84rpxl6R2X25GpGI6IEpr3hgHp0Yu1YZblKqwRlp1GTcONkty69gCN3kpHugtYpqz2NtZqzKKc/KfL6lb12x3FfjnsdX6W1o9nZe/cEoqVJseZtn297XlcegSxB0qfZ0oCncowt9FnyDFn++wsHTe74GjBiU2oqPkVJ6ob4bP4zxOgfKMFjTWY/LvsVz5uCrwxxp8kMi5WRQqrA/kAXiFLEZFPY8pZmQEep2upLNW7f0SdpgcIDRn6s
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(3023799007)(11063799006)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OoPaL4jMl16nXoVUGxatXG2LXvfz4T1MQGea84xslCN9I8xDGjW1PM+thfE+?=
 =?us-ascii?Q?pUpcnFK2FtCjRSdgZQ5Uyznf38GpmYB2KcZR2tJtOokkKrYS7B7BOwsqwTVs?=
 =?us-ascii?Q?Ebj99+80FyavQGLn+MFvCM7g8MssgUKj6/DLGiRsIYIgnfnSY953P20CM7h9?=
 =?us-ascii?Q?6Xm5+66v9XhXJTMY2Rmkh6SD0fwbuKHOXOV+4PucRID0hm/FBArUCGcvc3Qx?=
 =?us-ascii?Q?B8dXJJHP4HXdAGqLixK47O0jXISoovtfeJPuQQAamqoLcu/WRbfaRVQjv4qt?=
 =?us-ascii?Q?jS5WKQI+6fsQnCJCgXSs9LHtOf+1cR+5F6llI34CSwOfhB7pG+DA+BlKO9fp?=
 =?us-ascii?Q?/+BdWDRNk7puEl6d28LdFptM2rg8FrmnU9DkSBjomjk/neOVdS5naZt3balS?=
 =?us-ascii?Q?pAXL/AEQn9yPu/jOXq34ueGCACKyhtppTQ2jZr6rjf4GM+5ELkvQbMOzWB5Y?=
 =?us-ascii?Q?gkksqRB9MwRnUmM19RV4Od0PQY83gU8g9ETMBDYOAUlRsjVl/egmtn4v1iyR?=
 =?us-ascii?Q?820y2ViMYZuSp3sgQ5If4jGKizcvlqTLVC0LbxNqSilmIIxiRd++2EqoFaTa?=
 =?us-ascii?Q?yxot0NI+o5u2zLjXUqUZoIaKxp9cENwX1nQnk1FENeI/DX8gFQZ3uluBSIdZ?=
 =?us-ascii?Q?D+h4qAcRMGOMLNIEjnBcGoNEt5N6kljNzSFtJCaEIAA4D2XoVSZNLWW2xRdv?=
 =?us-ascii?Q?GuY+LZCoT4hrNnbnt1OHcCCoZXog/u3b6WZpSHlWUJC9TKStkRCutskCIDdP?=
 =?us-ascii?Q?wClMAI1CsOt508eFzLYd3zPe1WPB/RfQ4r6cK6SNFfr0u+x/Lt3wdXorJ080?=
 =?us-ascii?Q?sj7FwsoRiLEeY/wEbMYU6mJP+MugFbvee7T+MrRtSPinBmPCPAMYbUV6u3qq?=
 =?us-ascii?Q?CllXE00P6wpheAphgta2tCtGLXW8OVbmhgF32rXYXBgGownBDXS2B0mmdHT9?=
 =?us-ascii?Q?kegmDkXaqFx1JbktyGKGTNS6ba4DqhiwTCKWeqXhC+Aai0a3AGKnty2P63DP?=
 =?us-ascii?Q?wxsbAz087reNkENsiBNAh6Yfzr3kcGGZbXI2rELT1bxkCDJeggPS0T5Dos4v?=
 =?us-ascii?Q?YlIT2uynl0vdt5XohC7pRgG6tLCuG/CeqXHFQk4zm0VHbhQrIDegPsbzbUrv?=
 =?us-ascii?Q?rWsHKdHza4xQW0aTPYs3YGgqBwBzRvqQSAMImNiTBaq3dHw8vG42uoMeM9jU?=
 =?us-ascii?Q?MKytu9VXvihD0UiC53/yKIGAdbeSS48oNCBO09O6Kd8JpKkXlYVac8D6KQnK?=
 =?us-ascii?Q?PzXYl/GdJy7VKy2gTCaW4gSoWX8BJTZFqf1rNXP8AkggEF8O41/NFm8W5rdq?=
 =?us-ascii?Q?KO0v+2Jhi51QRtKOYfDNG091+tdIoUPMlqq5WjS7PthmZsERkvrQxmWlTAUG?=
 =?us-ascii?Q?g3UjevJ7ORFc78Kp+OXWYVc9a+ad6aPCJcOFA95v+WK4WjSf0nQdCk2gZBUn?=
 =?us-ascii?Q?RylvTp4hB97L/NJZPQDGG1JYWlBvu5tJlXssbDG5maXM04Fr9nZ7b+1/oQ62?=
 =?us-ascii?Q?CGYkI34GF7Q/tSuiny4CeZOblHeh9nn6Ji+ZpvvaCAyAqaCaFlHwRw6pPoQn?=
 =?us-ascii?Q?sxwOKJKTEeOUrPNSQ/KEtcVTp/CJ6FroAkeL2lEbCDnqcCQysPRXaKGCdxgU?=
 =?us-ascii?Q?/Ebca73k3O73P2J80sm23O9Qne0I5TL/e4xE/K6ZFbcf5sckNvVyr8iBD6/3?=
 =?us-ascii?Q?pDeUCZtd9fkNvBSaJw/FEF+4yt6ldiPepeHGqE5gzfo1gRyz?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb0cfd5-c3d1-4996-3df4-08ded01708d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 04:30:48.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H0gJyNfzD0omUrQa+axFmqGiupI4NsrrUVvs1ZXEfpxwXr1ZgP1BiQp0e/NwOo84gBzwjJVKwMMj4QKbMqUzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

AMD General

Hello Santosh,

> -----Original Message-----
> From: Santhosh Kumar K <s-k6@ti.com>
> Sent: Thursday, June 18, 2026 1:07 PM
> To: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> vigneshr@ti.com; pratyush@kernel.org; mwalle@kernel.org;
> takahiro.kuwano@infineon.com
> Cc: linux-spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-mtd@lists.infradead.org; praneeth@ti.com; u=
-
> kumar1@ti.com; a-dutta@ti.com; s-k6@ti.com
> Subject: [PATCH v4 00/16] spi: cadence-quadspi: add PHY tuning support
>
> This series implements PHY tuning support for the Cadence QSPI controller=
 to
> enable reliable high-speed operations. Without PHY tuning, controllers us=
e
> conservative timing that limits performance. PHY tuning calibrates RX/TX =
delay lines
> to find optimal data capture timing windows, enabling operation up to the=
 controller's
> maximum frequency.
>
> Background:
> High-speed SPI memory controllers require precise timing calibration for =
reliable
> operation. At higher frequencies, board-to-board variations make fixed ti=
ming
> parameters inadequate. The Cadence QSPI controller includes a PHY interfa=
ce with
> programmable delay lines (0-127 taps) for RX and TX paths, but these requ=
ire
> runtime calibration to find the valid timing window.
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

Thank you for this series. I had a question regarding the Virtual Concat
driver patch series [1]. Now that it has been merged into the kernel and
enables support for multiple flash devices connected in stacked mode-where
each flash device is probed and configured independently-if both flash
parts are required to operate in DDR mode, each device would need to
perform tuning and store its tuning data separately.

Given this, should we consider this use case and adapt the tuning
architecture to support it?

I'd appreciate your thoughts on this.

[1] https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-0-5e98239bb55b=
@bootlin.com/


Regards,
Amit

>
> Patch description:
> Infrastructure (1-5):
>  - Patch 1:   Add spi-max-post-config-frequency to describe maximum
>               frequency achievable post controller configuration
>  - Patch 2:   Add spi-phy-pattern-partition phandle for
>               NOR flash PHY tuning pattern location
>  - Patch 3:   Parse spi-max-post-config-frequency in spi.c; adds
>               spi_device.post_config_max_speed_hz (0 when not set
>               keeping all existing DT fully compatible)
>  - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>               op->max_freq equals post_config_max_speed_hz, return
>               immediately leaving op->max_freq unchanged. All other
>               ops are capped to max_speed_hz
>  - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>               spi_mem_execute_tuning() wrapper in SPI-MEM core
>
> Cadence QSPI Implementation (6-12):
>  - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>  - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>  - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>               verification (NOR via spi-phy-pattern-partition phandle,
>               NAND via write-to-cache), SDR 1D and DDR 2D search
>               algorithms with temperature compensation, AM654-specific
>               execute_tuning entry point;
>  - Patch 9:   Reject 2-byte-address DDR operations via a new
>               CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
>               AM654 OSPI erratum i2383
>  - Patch 10:  Refactor direct read path for PHY support (preparatory)
>  - Patch 11:  Enable PHY for direct reads, split the transfer into an
>               unaligned head, a 16-byte-aligned middle section with PHY
>               active, and an unaligned tail
>  - Patch 12:  Enable PHY for indirect writes of at least
>               CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>
> MTD core (13-16):
>  - Patch 13:  Extract spinand_select_op_variant() into a shared helper
>               spinand_op_find_best() with a skip_mask
>  - Patch 14:  Negotiate optimal PHY operating point before dirmap
>               creation
>  - Patch 15:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>  - Patch 16:  Execute PHY tuning in spi_nor_probe() before creating
>               dirmaps
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
> | OSPI NOR (8D)  | 37.5 MB/s | 216 MB/s  |
> |----------------------------------------|
> | OSPI NAND (8S) | 9.2 MB/s  | 35.1 MB/s |
> |----------------------------------------|
>
> Write throughput:
> |----------------------------------------|
> |                | non-PHY   | PHY       |
> |----------------------------------------|
> | OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
> |----------------------------------------|
>
> Test log: https://gist.github.com/santhosh21/fe98754e52970287eb9011154100=
b62d
> Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v4/
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
>    cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_p=
hy
>  - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flas=
h_pdata()
>  - Extract DMA refactoring into a preparatory patch
>  - Rebase on v7.1
>  - Collect tags from Miquel
>  - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1=
-s-
> k6@ti.com/
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
>  - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
>    ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
>  - Remove RFC tag
>  - Rebase on v7.1-rc5
>  - Collect tags from Miquel
>  - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1=
-s-
> k6@ti.com/
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
>   mtd: spi-nor: extract read op template construction into helper
>
> Santhosh Kumar K (15):
>   spi: dt-bindings: add spi-max-post-config-frequency property
>   spi: dt-bindings: add spi-phy-pattern-partition property
>   spi: parse spi-max-post-config-frequency into post_config_max_speed_hz
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
>   mtd: spinand: extract variant ranking logic into
>     spinand_op_find_best()
>   mtd: spinand: negotiate optimal PHY operating point before dirmap
>     creation
>   mtd: spi-nor: run PHY tuning after init and update dirmap frequency
>
>  .../bindings/spi/cdns,qspi-nor.yaml           |   19 +
>  .../bindings/spi/spi-peripheral-props.yaml    |   13 +
>  drivers/mtd/nand/spi/core.c                   |  246 +-
>  drivers/mtd/spi-nor/core.c                    |   80 +-
>  drivers/spi/spi-cadence-quadspi.c             | 2265 +++++++++++++++--
>  drivers/spi/spi-mem.c                         |   40 +
>  drivers/spi/spi.c                             |    2 +
>  include/linux/mtd/spi-nor.h                   |    3 +
>  include/linux/mtd/spinand.h                   |   11 +
>  include/linux/spi/spi-mem.h                   |   14 +
>  include/linux/spi/spi.h                       |    3 +
>  11 files changed, 2493 insertions(+), 203 deletions(-)
>
> --
> 2.34.1

