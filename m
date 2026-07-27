Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6C3E7BB4;
	Mon, 27 Jul 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143138; cv=fail; b=r7ZYME19+IEQhiEzBvjApDggJ7ocpFkSFu7UNFuCnsxo9B9sy3wGrFYx9l8Kct0i74Wy2DYnXlz6HFPXCq+iM3GXSK7VE4ou/VAH0k2HFz8RgPUa3pqPtOVRG3ODSGd79d+Uz3hCyvyP2rHkuu3+jAaPA8iunB468/FslIuVcTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143138; c=relaxed/simple;
	bh=mC75OZBnfOw0cC/S3nb7dM98D7F0jJd3A0e6LPChXQ8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=S+BJljsI9qTqBQfCXKO+FXpM/2uDwEzVgxuEN3yQS8N0LXiSoPGaR1joHpdum8JVpj/1k7tSM3JxjP6Kxcgew/cseV1pLEIUYHeInv6IO7MkaiZTCwA32NkIDOgGhm6zOHueI8LtpzT43NfmqMX7h9LNTRmAxx60zGZpokK0NqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eLKhqSN6; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eLKhqSN6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IthZMTUn+OB1drku64XsRpT6UQw4mWzBUiKVKhOKZzlgEmjFQ8Th1GFr8Qj4EPuI6DCRfiNsPKk9Nhd1LFxo4X9/oaBBvc+Xi7rIHXxbQ2MsjyJ+Y/ortVfmOD8pRMQ721qL0jvigoatspU6LllK98eNV1fPlUQXUOJx8Z1KcJLwqJDEa26ub55eGlN9QP7CkfaRljZ1PIgzuIcoMiJUTb8uTlN8p7lzEVnPkm9v5SoFZDmhQykSdx2nsEDqx8mE1v0aMYIu43tWcMOMGn0mI+Mq8Q/fo0qw8wyPbU1B+pKfUIFWz53R6sEarZ8TMZ4hmUdHk8eTRm+sS6xXRpcBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQRFpgmMwly6NIBPbRsv54soakZ8hIAawVCQTDl64A8=;
 b=aTAv2guQaoNb9OZblry0C/gqr7/BDec9RBqGTfhh+gn+zlUXNplSi5mrMQaNfJJ1Cj5sgQMIeP9TBpbLENhCug4MasjgrO4KcF2AQitR5WutbEMZKVbLjeOjanu0/RSEmDss5l3ZhePWXtasFA5sCI68vWn+enSCdvGoXwrrgrOYJlfLwMn6n6a3V79a5ZFhiM4bBnKR0dl/WWL7BjmnjZcQx5TbCGB/2U+G5sAvh/gB2/3o/P2lmaLr7qctj2B7bqmJq5kEEwoezwRLnEPGSJ+y4fs+NexSEbKrrYsFTQrBrfxJPitSsJm4jH636zrLWbgvzTxgJusI1T/NQB7FIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQRFpgmMwly6NIBPbRsv54soakZ8hIAawVCQTDl64A8=;
 b=eLKhqSN6ftjwIspyHhhU2Na47QcDecN1EdsGg7Z0gdjJie7bL4ytlRshZHil04YGziYJDAKlXDh0huG+zXOsv99VdjIrBR96IKYEAgloNgrNXOG+Zsj9GzVptQlx13P861az6tw9HHA2M2BF8L8AukdA0V6GejcOW4Yziq3U5eU9GniyZ0ZAhiFe4QHKqp5LS5asfzFQ+NnMVahOZ0z59IzhUNEys8f8N76KU+lBYs49V14NL3oh1ldFI5fMDqWTAE5Bmzig8+UicColYaQ4zXVeboQ6ik4T25VnYmC5lAd1cg9Do1hTXJA5QIvawXDNngIx0enX1ghVNAaKze2WCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by GVUPR04MB12194.eurprd04.prod.outlook.com
 (2603:10a6:150:33f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:05:34 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:05:33 +0000
From: haibo.chen@oss.nxp.com
Date: Mon, 27 Jul 2026 17:08:47 +0800
Subject: [PATCH] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits
 for all supported SoCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fspi-clock-v1-1-f4f3be6c366d@nxp.com>
X-B4-Tracking: v=1; b=H4sIAB4gZ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3bTigkzd5Jz85GzdxJTkxFSDZGNTIwtjJaCGgqLUtMwKsGHRsbW
 1APMSoztcAAAA
X-Change-ID: 20260727-fspi-clock-adcae0c35283
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785143354; l=7913;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=5rVNULakh+Q9/APH0oD06xSOE0RWvsuSTPl0yto7ubI=;
 b=A1xgFtA/UYAN37QNHVMELPrjMib32X6PNIvw3Ok3wzSsuQCW8Aqij0NQyTeHKEBxLAlGjeoew
 tWjM2bnbUEZDgtY63JrwiSxwT6z42nUwRQ+ZM78Zr32RQt2U2mY6Ozc
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0135.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::11) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|GVUPR04MB12194:EE_
X-MS-Office365-Filtering-Correlation-Id: 241b6c4e-8c7a-4813-7893-08deebbe36c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|56012099006|10067099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	k+iP95/nGIb5Kr47u0X8UvODN2AqKUYG0X/QKKOAsnfzu9SQsSv63/A/iL8wOyWkn/vTFw6amlxEx37qn+b4qTKpNL8bS7txl7Hdb7nQI6800s1cHCD8nzyM4IB+e6Cfu67OKTde/Ildh3V9mmK1R6lFFjn7TC9utfnX9KDvq7uIEc9u1ZI30S954+De27upstMwUJk/COSXFXbPQM67XDJE3cxEbZwzblyH5f4Lro4odCZK2LjPR5ospAR0IRQWFxY+nLc3gGxogP/lTVd4tGlZ13e//2peSMG3T7TU4Tym71WgKK17Y7Sm/0EJR32oI/2Tpf6szm8v4GCdSIDPPY0AAYbjLf4NsaD3SnLYYH80ihqb0jLGsvn10xPa5suUiUW5j/cQGM4nEXZrJx1PJUJuA8CTL8ZVE1vEjXntvfJBf5S0wb4zTzm9pabtkIv0QXUnIeLvxQKlgqs4JRb9PnVEcuHNetiI2V5q2jGVeZCAeGDT4iQPuaKdMjmvttxRI7zyj4/FLDVgOMwNyxWW7ur8Ly9VsW2LF4HCXZK7cG+6dOZESY3Z9X78zIRVi2fRt2LwSlAPQIXqHsdb3dMWOpe9g92RRYs6pmOI4glxZUMw7OXm9Pa2bPMnWXAC1uV+d/7nNSBpKOs3xAZB80F8lH2IP6Qn3t+xbk1ZZkNT5JY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(56012099006)(10067099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVqc3RwYVp6dzU2YjEydldETEswUmJ6YnhzNSs2M2ZIWGFabUxURng3aGlY?=
 =?utf-8?B?K3A4RjRhRG1pN2g2UGZ6N3ZlT3F3TnVTNTNtVTJYbnJ1bjdMK2FkcUpONXBN?=
 =?utf-8?B?RGZpUm95VDYxOXJQYk1RQjVkajEzc2J0ZkV6d1Q0cVhWMkRYd084c0RJRHlr?=
 =?utf-8?B?VTEyWkNBWHdCS2pSQUY1bVhGNlpoYlo4OHlIOXhKd2MwOWgzYlZBZlI1UGY3?=
 =?utf-8?B?Uk5sdVZjNGphOVRNT05FaWhsaWowbE5ESVVrZXlGb1Z4dFZha0NWVjNZSkFX?=
 =?utf-8?B?a3FndmFjeUZBdHZRTnlQMDlEUW5VN2RtN2xBQ2N4K3V4T3lzaEt4S0JlS0JV?=
 =?utf-8?B?c1hFOUloRGhUc2xEWVpZQzBRR0xvUGNRcG1VUkVlRDFDS0Q4N05uOURNaWY0?=
 =?utf-8?B?MDFMQTZsQWd2cWdOd0FGV1JwK1MyV2JkVmNFMHJNaGtxNjdRaTE3YUUxYml4?=
 =?utf-8?B?RlJyNFdUWlI3dkFPb1ZLOEFna1U4QjN5U1FjcWw4eUZGYUdUVjk0a2NaTWdN?=
 =?utf-8?B?NDlMaFEvUzQxNlptTG1sTkFVRkYvN0Z1KzZzNUVmQ2Q3OUljTXZCOEhZYVBs?=
 =?utf-8?B?U2k0blZTeDRvaEFOMUFqZlVTTHV2NmFsNHNoS3lMaFNqYnk0SDg3NmdPWDBP?=
 =?utf-8?B?eTBWM3RqV3JnY1Jtc2JvcDdDdUM2TDhVYUZ1dVladERBdU9BVWxMVlFKNFc1?=
 =?utf-8?B?UkR4VFZhazY2Lzhoelc5dGNjTnlaanRBSkRnaDFpUjg1QkZ0KzFTQVdGN25j?=
 =?utf-8?B?NVpmWlNNeW04V2RoNG5SZUFWZmkzNDdKQStOaXVZTGVyU01YMnNmcXlpSmlJ?=
 =?utf-8?B?Wmt4d3oxWU5TL0Y2M04vckpFSERKK1hhNUd0T1ZhNzBwTER5bHhPMnpveDR5?=
 =?utf-8?B?Ynlia2Y0UEx2SnBuYkFxajI2S0w4ZURMN1piblAzRko2elVxd1NpWmQ2VnM3?=
 =?utf-8?B?ZEdISGdXV3FTT0tsdWJZRWxmZEhCa2hScTBqenVlNGc5Y0dzL01OK3lpa0kr?=
 =?utf-8?B?TFNLMG01eEs0Yy9TeTdYbDZNZml1UVhtMWxDQktnaEJpTXNaU2NVSUxhRDJ4?=
 =?utf-8?B?dnNYRnNCSCsyLy9hSXhvbnZIcmMzcDRiNWdBTEZ2MCtoSEVTYXhPdVNSQ2cy?=
 =?utf-8?B?eTgxYjNPUG9YSHRvVmpoeXdiOXFQMzVoYTkxRFR1TGZzYUxIWFhJWFVCTEdN?=
 =?utf-8?B?RWtFZHJxWW5YSjQ2eXNqMTd6VnVXN0NXc3BiN1dHMFpCS1U0M0hibUQ0Umlp?=
 =?utf-8?B?WCtieHlyUU9WQWR3RUR0Zi9YSlVrZGxDSEZzMDlFTVV2ZjZXcFdMR0k4b2U5?=
 =?utf-8?B?NUhNVGxJbTFjbUYyZ0JwbGVHWUl6S0hmS25Icm4yY2h5Y0xOTElCbGVzaU1O?=
 =?utf-8?B?bXdKajNQbkFMeWpIeU1MMUV3T0g3Z25IeGd6N2ZISVpQckUzeVFnNVhqb1lB?=
 =?utf-8?B?ejdTSDRtb2N4MEFrazRDRmdoMkVyd0ZBSzU0NVcvNDVoNU0wdkM3ZTZHTUNJ?=
 =?utf-8?B?QXBweHBhWlF2M2Y3SVRPcWVuRXhxditjcFcxUmd2VkFWMWpFc0dZRnMzNUFU?=
 =?utf-8?B?RzJUMDBQZldhN1JEODlnZnNFdE9yV3Z4ajV3K3ZmU0txY0NHUk9CTTkxOG5n?=
 =?utf-8?B?Y2tiUE9ZakRYRm0rekxjVE16ZGtrRW0vb0RxbTNmVjZHL1AyZ053eTJZTHRi?=
 =?utf-8?B?dFJHV3VJZkdsdlROV290RjhkdEt2OWtFMXc5cCtTZ0ZLMUxsWVowaWpXYVBp?=
 =?utf-8?B?L2V2RTZtMEFhUE8yNlhkZVB4cHVjT0QvQ2VBN0NnbWRvWkV2bHBUSTBtbDRa?=
 =?utf-8?B?N3U5VWJhNWJpS3BRcnNlZ2phRFdudnpkeHRWdkJxUStpemdOTUhRKzdiZkNV?=
 =?utf-8?B?U0hEOWhJQVZpM0EzR3hFYVJKaWJxdjVzRGlwcDlHT29FcDhqQ0NkdS92VWFQ?=
 =?utf-8?B?MXRWMjlQbWRxL3pxckk5UzRrVWpBZWNkWFNIQzdUaFdTYVFFUWdnakovOTRE?=
 =?utf-8?B?cDVyQVlIc2tsZkFOcTZZZlRuQjFoelVLYk5KSERjeDVMNlpVN2U2d1ZGcjE0?=
 =?utf-8?B?cG1nZjl0NWt4K0x1STB6VThlbXI0YUJybW9Tb0Q5bkJYN3VxajQ0UGx1NVhK?=
 =?utf-8?B?bStVRmxEeTM5QnpvaW1DczdrUEVDbDUyVzViQmtIZngxMjFTUlVFUysxeDFY?=
 =?utf-8?B?dCtoeHVXOVk3aC9uRjJGMXJrQkxmL0dacmRWSnYzNHdPdnNweXJOVWRIT3JR?=
 =?utf-8?B?NHJjdmo3VUF6bEV6VFVqSmMxWjRtYVhDV0xYVW52NHI4NDh0VUFVYUNiMktZ?=
 =?utf-8?B?REkzS3pTR3V0VTR3K245L3NGak1nZGQ3OS80ZVFpMzBRbyt3dk1pN3RweXdB?=
 =?utf-8?Q?tbye9A3AQd1hRuYUy7obvs3LBOoMNXtaFom98?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241b6c4e-8c7a-4813-7893-08deebbe36c2
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 09:05:33.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THIcNK3ufxX8JDboCzPWaPZvFrGdxivg4Iz9qAtXmz2NYp4bKkEjtIgRzfNZ4bsqkzCKhYoIPiEYkZKXO1xtaXR2fJOr5YYESalSy0tGDQ8hbHjCwiOhN3W/t6jo7tvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12194

From: Haibo Chen <haibo.chen@nxp.com>

The commit f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for
different sample clock source selection") introduced a global 166MHz
cap for DTR mode (RXCLKSRC=3), based on the i.MX8MN datasheet timing
specification (Section 3.9.9, page 65).

After reviewing the FlexSPI timing parameters in the datasheets for all
supported SoCs, the following corrections and additions are needed:

1. SDR mode (RXCLKSRC=0) limits vary per SoC:
   - i.MX8MN/MM/MP/95: 66MHz  (IMX8MNCEC §3.9.9, IMX8MMCEC §3.9.10,
                                IMX8MPCEC, IMX95CEC Rev.8 §4.11.7)
   - i.MX8QXP/QM/DXL/ULP: 60MHz (IMX8QXPCEC, IMX8QMCEC, IMX8DXLCEC,
                                   IMX8ULPCEC §7.3.1 ND mode)
   - LX2160A: 100MHz            (LX2160ACEC FlexSPI timing parameters)

2. DTR mode (RXCLKSRC=3) limits vary per SoC:
   - i.MX8MN/MM/MP/ULP: 166MHz
   - i.MX8QXP/QM/DXL: 200MHz   (same FlexSPI IP across this family)
   - i.MX95: 200MHz             (IMX95CEC §4.11.7.3.2.3 Table 106)
   - LX2160A: DTR disabled      (FSPI_QUIRK_DISABLE_DTR)

- Add max_sdr_rate and max_dtr_rate field to nxp_fspi_devtype_data
- Use per-SoC max_sdr_rate in nxp_fspi_select_rx_sample_clk_source(),
  falling back to 66MHz default when zero (preserves existing behavior
  for any future SoC entries that omit the field)
- Use per-SoC max_ddr_rate in nxp_fspi_select_rx_sample_clk_source(),
  falling back to 166MHz default when zero (preserves existing behavior
  for any future SoC entries that omit the field)
- Add dedicated imx8mp_data (previously aliased to imx8mm_data) with
  explicit frequency limits
- Update imx8qxp_data, imx8dxl_data with correct 60/200MHz limits
- Update imx8ulp_data with ND (Normal Drive, 1.0V) mode limits: 60/166MHz
- Update lx2160a_data with correct SDR 100MHz limit
- Update imx95_data with correct 66/200MHz limits

Note: i.MX8ULP limits are specified for Normal Drive (ND, 1.0V) mode
as this is the standard operating condition. Overdrive (OD, 1.05V)
allows up to 180MHz DTR but is not the default use case.

Fixes: f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 81 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index d94a2a7b98d44db217ba96a8ce7df23e37a08ba4..1159f5fc8a3a69eb464f32fd92e283e84ebd67ab 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -340,6 +340,18 @@ struct nxp_fspi_devtype_data {
 	unsigned int quirks;
 	unsigned int lut_num;
 	bool little_endian;
+	/*
+	 * The max clock rate (Hz) that FlexSPI can output to the device
+	 * in SDR mode (RXCLKSRC=0). Defaults to 66MHz if zero.
+	 * Some SoCs (e.g. LX2160A) support up to 100MHz in SDR mode.
+	 */
+	unsigned long max_sdr_rate;
+	/*
+	 * The max clock rate (Hz) that FlexSPI can output to the device
+	 * in DTR mode (RXCLKSRC=3). Defaults to 166MHz if zero.
+	 * Some SoCs (e.g. i.MX95, i.MX8QM, i.MX8DXL) support up to 200MHz.
+	 */
+	unsigned long max_dtr_rate;
 };
 
 static struct nxp_fspi_devtype_data lx2160a_data = {
@@ -349,6 +361,10 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.quirks = FSPI_QUIRK_DISABLE_DTR,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
+	/*
+	 * LX2160ACEC: SDR RXCLKSRC=0 max 100MHz, DTR disabled via quirk.
+	 */
+	.max_sdr_rate = 100000000,
 };
 
 static struct nxp_fspi_devtype_data imx8mm_data = {
@@ -358,6 +374,21 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
 	.quirks = 0,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
+	/* IMX8MMCEC §3.9.10: SDR RXCLKSRC=0 max 66MHz, DDR RXCLKSRC=3 max 166MHz */
+	.max_sdr_rate = 66000000,
+	.max_dtr_rate = 166000000,
+};
+
+static struct nxp_fspi_devtype_data imx8mp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+	/* IMX8MPCEC: SDR RXCLKSRC=0 max 66MHz, DDR RXCLKSRC=3 max 166MHz */
+	.max_sdr_rate = 66000000,
+	.max_dtr_rate = 166000000,
 };
 
 static struct nxp_fspi_devtype_data imx8qxp_data = {
@@ -367,6 +398,12 @@ static struct nxp_fspi_devtype_data imx8qxp_data = {
 	.quirks = 0,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
+	/*
+	 * IMX8QXPCEC: SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 200MHz.
+	 * i.MX8QM and i.MX8DXL share the same FlexSPI IP and limits.
+	 */
+	.max_sdr_rate = 60000000,
+	.max_dtr_rate = 200000000,
 };
 
 static struct nxp_fspi_devtype_data imx8dxl_data = {
@@ -376,6 +413,12 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.quirks = FSPI_QUIRK_USE_IP_ONLY,
 	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
+	/*
+	 * IMX8DXLCEC (i.MX 8XLite): SDR RXCLKSRC=0 max 60MHz,
+	 * DDR RXCLKSRC=3 max 200MHz.
+	 */
+	.max_sdr_rate = 60000000,
+	.max_dtr_rate = 200000000,
 };
 
 static struct nxp_fspi_devtype_data imx8ulp_data = {
@@ -385,6 +428,27 @@ static struct nxp_fspi_devtype_data imx8ulp_data = {
 	.quirks = 0,
 	.lut_num = 16,
 	.little_endian = true,  /* little-endian    */
+	/*
+	 * IMX8ULPCEC §7.3.1, Normal Drive (ND, 1.0V) mode:
+	 * SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 166MHz.
+	 */
+	.max_sdr_rate = 60000000,
+	.max_dtr_rate = 166000000,
+};
+
+static struct nxp_fspi_devtype_data imx95_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+	/*
+	 * IMX95CEC Rev.8 §4.11.7: SDR RXCLKSRC=0 max 66MHz,
+	 * DDR RXCLKSRC=3 max 200MHz (Nominal/Overdrive mode).
+	 */
+	.max_sdr_rate = 66000000,
+	.max_dtr_rate = 200000000,
 };
 
 struct nxp_fspi {
@@ -691,10 +755,20 @@ static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
 	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
 	if (op_is_dtr) {
 		reg |= FSPI_MCR0_RXCLKSRC(3);
-		f->max_rate = 166000000;
+		/*
+		 * Use the SoC-specific DTR max rate if provided, otherwise
+		 * fall back to 166MHz (limit from IMX8MN datasheet §3.9.9).
+		 */
+		f->max_rate = f->devtype_data->max_dtr_rate ?
+			      f->devtype_data->max_dtr_rate : 166000000;
 	} else {	/*select mode 0 */
 		reg &= ~FSPI_MCR0_RXCLKSRC(3);
-		f->max_rate = 66000000;
+		/*
+		 * Use the SoC-specific SDR max rate if provided, otherwise
+		 * fall back to 66MHz (limit from IMX8MN datasheet §3.9.9).
+		 */
+		f->max_rate = f->devtype_data->max_sdr_rate ?
+			      f->devtype_data->max_sdr_rate : 66000000;
 	}
 	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
 }
@@ -1457,10 +1531,11 @@ static const struct dev_pm_ops nxp_fspi_pm_ops = {
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
-	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mp_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
 	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
+	{ .compatible = "nxp,imx95-fspi",   .data = (void *)&imx95_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);

---
base-commit: c5e32e86ca02b003f86e095d379b38148999293d
change-id: 20260727-fspi-clock-adcae0c35283

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

