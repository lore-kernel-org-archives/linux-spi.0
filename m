Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A73C278D;
	Tue,  3 Mar 2026 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571795; cv=fail; b=qBG6biXs+YurhRjMVSibIraAtG6Da8uGP3cWRdGYyAdQar8JKByV67FcQnalDbEQ1vW21pHcC7wW80nUTQss2vbPcs9RMd6qXEupCqlyZZ136V/iZID/AQGoocBjqvsVyiCD9lC/ALd+KsNXT/tyRP12Kl74RuqSZokxckulAts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571795; c=relaxed/simple;
	bh=vQzNmfHty0a8R7i44+4APMyp2tiOm0fXFC7TwBlbpwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRvsK8JC5UzLTCaZ33zV6vFDxTc2tBieNg78f9gG+kQRKIZOWJRcgUwHtRNXB/fOua6QMOR/KdXnO+RIj7rd3haUe6Ii/PZb+yiiSnku+kj9caRq7qZEzpm2rSaNyBvdImJ2fArW914wW+CGhqE2hd5flzg5C0g1JuxXrzsAql4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ed3IWpPT; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ed3IWpPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkcEfJJ0WaAKLfDp9EtmqxQRBoKTzJnTgMqOSH1N/HBhnpMEP3GLFZ3JzB771+N8bCiBODrb93+wgXMN+suu+nEDUIsIFtHmey1hui9lEAZWBG/uz+BuhWobcGbOeyLlw+zkKb7n/EFJs6KhJBP+JYvBrKBxo0MzHaCGn+57KGRYcYHyLJjLDUj9gsXtLMN5f3ziPS1LszKpwyp1ipcD6oXJ4rC8maqGJs8O/dj7K+zOc4p0soE4IrlCchNH+++xrnmX2Dk5p0wQzTmEfS/QeW43y5ffKzOxmwmhgXC53OBffA5X3Yauw2GDYcQJQmWJD9/RVU0wbEoS3Is8jdK62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBf2T7z09usgbBZ3wZTiAXnO9iofJOVKJ5qBFaG17WY=;
 b=WSpBsM4+zv7fFmVFBDBQt9ZMf0w6zFaW3Y0KKdP5ec0BvgttpPYHbFNINRXWaBVcaM8boXOOUaIk9bnZF8fV8vzZkKyk42He9aovrxO5Jkfny/cGSAh8rqGJPl9oDw/QjwXRrzhJiU5r0a2gX9frQZafw0y1uOJIxKqkpQTpP9CmNpvWPSwzHOs7m8UHeLj1RdSdljKC/BKO8R8cMaDD1ZSF6nJxM/YUQ7XcspidBBJq+pajwLy3MhxG6fL2dXfNeuY4IQLk6ECZAxBNWep/3R+rAkF6NDclxCGiWAI+y3qFxoBei2WU5RFo9Tq4lXBg3i1sRwH2Gthsdo3xIOPHUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBf2T7z09usgbBZ3wZTiAXnO9iofJOVKJ5qBFaG17WY=;
 b=ed3IWpPT8X3RWems/Q3TlCaLPn77DRrv0DlWqmaWAMmGhE3RYvYX2NlT8t1usWHk8gHwBPRP1z8Jkn9CES+FgmmXJBCvfBCvsXAwBuxirt2A38seAKB1BGkh3zxhJUu/TOJqMPkpDPkC/1u3MJwXoS0DENLEvDJT+LAf8luiYInnMAcFOhgR4lQitsCeY7onDcWL+vTs9Vj03MdupI6gNSlMvfziI9cgTrbE0YPuc8ZxfVL5wjoicoi0ZrHfYRc/Gb3BzeVPHxcelK13ZbfVf7Dm2yO415s4Ofoqv7uTdUOVGICfxhmk440g5kzYso+LVh64DH8LZo0/mEJRpDVL/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8639.eurprd04.prod.outlook.com (2603:10a6:102:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:03:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:03:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Han Xu <han.xu@nxp.com>
Cc: Frank Li <frank.li@nxp.com>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH RFC 3/7] mtd: spinand: winbond: Add RX sampling delay values
Date: Tue,  3 Mar 2026 16:01:17 -0500
Message-ID: <20260303210131.2966214-22-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-3-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-3-9326bbc492d6@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8639:EE_
X-MS-Office365-Filtering-Correlation-Id: cd92376d-c44f-48b5-1afe-08de79684510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	FhwlsXgH6o+WZQkBDx2siy9+KqQaqMmHC3gXXEAhL6Ko8DP04LuGXx3NdPqVWQ/70PGE/YO8TgvyVi10KiwRINr2mAs4toViu3VBUXhWRvaxa2OLoQRQ6P9YFc9NCbc9M63tTf6NckW+ax+i2ZWZ9TbSAM/nFVeU3t3T0KvNHf5a4qCpOsHirJgZolodtwCujgOyZGcBgBI4aUhApRVTsn2Tl4HRuDQzs27h4EvQuzQZ6GHwmgyYOkBGLtfBjW2fvVesVE7n53s86xA71VONEqIjoolh+UADTc0P50PaO3hWreFQOXGjM+tKCQ/DeM0tHyUKAxf9J15sba/YOaonKWjeYJ87DanRoNZwl0kIIdLQ60pB5oD9ZGjdad/2GG5/NEGqhbHUNrHf7sOBTqa0yFQDBdPO8JSApqLPt1+GReTpiHH4U8ibpjR1HF0e7ulTboa/FyIWbRn9ANuyH7YLWtr6jLycPu1ZwKCusNDIe8D54uEc1QBj+kUo2z8EAjm/7jWNLhErpcBmLzKKwddePWpHT/aF+WcesrNewfLgG97wjaoD/O7ScEiibxOtng2PCYIboWHvT20Pi33D5nPTRXKi31fwfIS9aBZk6qKMmnDNrb2ZmX+TFaeBeg1TcAe0DGRrNdXfnwq43IDlHMhU1PDug0wDGtAIR/SFmLdH86eem0OMnxjs5gZK5jT2/lkAfLIrvGgBNwuVQBtzHoPqVDlgKinHLga+4izFGY5g5rgDQob1cx1dJ5S2SlzCmd3AWuvZegEgR/ak0rIUrV30nxLrHzZyzK9AJxlU/q1WpJA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXRTWWxUanc0a2xHcHN2cnFOVWpHbG83TUNucUhzdzFueklPc3lzNHZqSEZ4?=
 =?utf-8?B?SVpscnhjMGU4WW1XUk5IYU9tK1RRUXh5dWxpc0I4Z2VPTHd4WXJZN210MXBZ?=
 =?utf-8?B?czR3V1R2RDZQMlRhWmliTUUwY2Fwd2lremY0NUorRm8xZXZsajFtS2I2cTVm?=
 =?utf-8?B?R2NFYXo1RVpWanB3cG84T2FyS054K2cwZWg0QUJnS2RlVGNDam5vMkxJS0VD?=
 =?utf-8?B?bzhqL1hZNHdZTFlzZVlnSWRtVnZ3M3dHOE1nNlNhSUI1QldtNVRIMHJMTXJ1?=
 =?utf-8?B?MmxBcmNSTFp0MS9VK0Fhb1BsZ2JnRDdzaXVoTmIxRzVmNFdONVVkaVlDZG90?=
 =?utf-8?B?ZXBaRUx0NDhjT0lNcHBKbGhuZXZwRE53TkRzN1Yxb2hhTU9YeEY5T01ja1lY?=
 =?utf-8?B?Y3ZpeE80aUFPUmRTQ2dDTGhkM2M5SDFJWVRHR2lPR1R6OTFYSXhNRWRLeVhW?=
 =?utf-8?B?QWYwS0gzT1VNbW15UUpzR3RWME95SDBualJWZVYrSGlDaXkwNEF1eDNqTC9S?=
 =?utf-8?B?aTh5dkFNZG5DcThTcUVoeVRpSk53TjlOakhqNTZnUi9jbnRaZ2lDZTY2cTY2?=
 =?utf-8?B?a0VBeThaVmRudEE1dm8raGxGU0dNSlg5NU1mZ0IzMkwzVmN1akpOcU5GSmNB?=
 =?utf-8?B?R3RZN3BhTEtZZHl2akgrZ0VmQ2VsaVlZcEFkdGsvVGxUeWoxS3p4bU5xN1hH?=
 =?utf-8?B?am1kaFlPTFVLdFVtdzdSSk9uaEM2dDErT2JEVjNSN0hJaDRmZUd5UURMTVZX?=
 =?utf-8?B?eGRqK255dGZ3TDJXVUFXUzJOUlNBWWJLUnMyZzFKbG9RRnl0dnpaVVlGWXI1?=
 =?utf-8?B?bFBGamRKS0w4bmxXZnVvaFZCaDAxM3QvL292NElxRURqS1lOMGgxUW0yaHI0?=
 =?utf-8?B?MU0yaHVsQm1sbnhoRVZmQ0c4bTlacEN2RVBKM3lCMk5PZDNuVWZWS1hjSkpS?=
 =?utf-8?B?ZFlQRnBPS0xTdzl1YmhtSnF2bFdYSjg0eEhRUW1JRnBsMTNlc01QWUhjbkR1?=
 =?utf-8?B?bWZKZHQxSFRIYVhZOEF1Z01IbjJoMzVTdE1GOVRIamxaaUpXSU5rTGU5Ty90?=
 =?utf-8?B?eDRtdHB5RDlJSmFWc0VxMDVDblQ1dWFDYUI1ZVNRUkZHL3pSZ3YvVVVuaXU4?=
 =?utf-8?B?Wmw1aklHcmMwN25lUlBFcHdVVkt1UTBFSkpOVkh6eGVGU2QyZkhUaTJTYmk2?=
 =?utf-8?B?Um1sa0UrUHZpdFVoRWRuNHZ3SjlWTU9PUU5hbG4rSTVRSVROcDErVU5hdmkx?=
 =?utf-8?B?MHc5bWd3U2NOMEZrMUdhL2o0OElnV1BDVGZGTnIxT0RKSmd4eXA4NkVZUW9W?=
 =?utf-8?B?bW9EZHUxWXZuZWY1SWV5aXkvZkkyVGdBbnh6S1hMa3djM09KaWZ0SUZaZ1Nh?=
 =?utf-8?B?YzF1WDRTMFFmdFdLWHZ0b1k3aTBiT1lzTUV5dzVxS3FKVDZoY3VKWnY0YUVw?=
 =?utf-8?B?Q0h2Q3ozQ05rclloMkoySUxFME5iMGw3MnQ2a3hsRmhOd296WU5GZU9scWZJ?=
 =?utf-8?B?ZElJSDZ6Q3lhMGhmaWVySDk1eUJPbWQwZjlSSG92cVBYYzkvYVlSdllpemQx?=
 =?utf-8?B?WEtUNnRiUGhwbXZRVnVWaWx0OXNqd1doOERNVlZ1dGZnQmdLQ3gxZUIwOW9l?=
 =?utf-8?B?OERDL3dGTGF6d2tuRjUrTy9QK05PaDZxekNDdGQvc0FUYW9HVXpiRWdiZSsr?=
 =?utf-8?B?ajRpUGh5Q0UzSlUvZTViWTUvY2orMmhmcmRHUnp1LzRhTmlsVzNuMGNRRW5C?=
 =?utf-8?B?UDQ0VHVpNnMwQktkUEFPckh0MWZaVWU5cmswSi9aNGtLR1krcVlBSTlQSVl6?=
 =?utf-8?B?QXFKa3JBeFFmdWtuR1ZjeS91a0JsRDAwRENtRWZUT3I2LzRoVWp2SGhTUitO?=
 =?utf-8?B?bW80WEZ4MWp6L21WY0l3UFNNNUJJcmpRREl3QTBxRGM1bzg2K0dwTWVCbCtk?=
 =?utf-8?B?UG9tOVFjL2t4UjNsNU9uUlA1YWwrUE9YMThzREZZQ050dEdUcWYrK3R5cGph?=
 =?utf-8?B?YUhPN0x4U2J5b3NuWGpmYkxMRXlldmNBbzBuaHlmT3pneGNBeHJUaEYrUFZR?=
 =?utf-8?B?NDFTeUJ3V0JFNmIyMGtGK09PVmhIY09XZDUvWnhLbWFJT0RQa3VUY1pUb2px?=
 =?utf-8?B?djJXWjBmR3NmcEgxdElGQ1M2VWNUd29KRWpkbXNRbXc5eDl2UTgya2w5WEpw?=
 =?utf-8?B?Y0kxVElPRm5KZzh5RUxwRDlwWEI4bVg3Q2lDYUNHRWFVUFd3TFRBQXgyOEx0?=
 =?utf-8?B?cEY1MWlvM3hSNjROL2k0b1R4am9KTUkyeFZYcDBGUUNvaXNFV0Z2bHZTMFE0?=
 =?utf-8?B?Zy9hMVdRc3JrdE5zRFNxWVQvVEJGM0ZRakR5NCtTbmFEMlNvVk5EQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd92376d-c44f-48b5-1afe-08de79684510
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:03:07.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6chsOh9VPpCM4u4buEeDQDedG2SLqlgu8F1L6ToHNyxkQ2jt2frvhwQUJ+MkxyeQWXJraDbKWR3iQRyAqDCRpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8639

From: Frank Li (AI-BOT) <frank.li@nxp.com>

AI bot review and may be useless.

The patch looks straightforward—adding RX sampling delay parameters to
Winbond SPI NAND device entries. A few observations:

> -		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
> +		     SPINAND_RX_SAMPLING_DELAY(6)),

Trailing comma removal on the SPINAND_ECCINFO line is correct for the
macro continuation. Consistent across all hunks.

> +		     SPINAND_RX_SAMPLING_DELAY(6)),

The delay values (6, 7, 8) appear to come from datasheets per the commit
message. No obvious logic errors, but consider adding a brief inline
comment explaining the tCLQV mapping if the values are not self-evident
to future maintainers. For example:

  /* tCLQV from datasheet */
  SPINAND_RX_SAMPLING_DELAY(6)),

This is minor—the commit message already documents the intent. The patch
is mechanically sound: consistent formatting, no resource leaks, no
locking issues. All entries follow the same pattern.

One style note: ensure the macro SPINAND_RX_SAMPLING_DELAY is defined
elsewhere in the patchset (likely in an earlier patch in the series).
If not already reviewed, verify its signature matches the usage here.
