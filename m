Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD541F366;
	Tue, 28 Jul 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233717; cv=fail; b=dFUrNVmrZlybcycQ2MHyotPRLtepGni3LQb+H7fvAC3mxxIkG03XECDSOBuBoQXOD06MLgNh8XOBEv5mc8eyrd5/z7KMhHyutLx2UovqVG6B74TZ/FneeIIHgC+ZAzXKXBO0P7lEpT0FeLac+zKgMalU8vyvIYuzRoKJMArDXsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233717; c=relaxed/simple;
	bh=zU+tSzetGmoM3vX8lWWfNBuoNE9U53X7vYoEmkJl9Zc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hEoOW7naeOnAPVCTtOBXmsPF8hOm5UidVnPchJ9PRjuU+Fkr4UcVfboYIvwcDo+HSnV++O0FxmxPe2emqFUaBuq/73mUxF+Hj+szAnC0M32rCL85FUnf3RSgpCA1eh5Ta8T2yJYiNLShBMdkMmZzYHEC9jGKQOzPNXv+c8iwYx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TCiRPwSf; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TCiRPwSf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7g/IjjyWXtVhdfp4VUHZh+Bx3XQIphg5PqI2pNPJFriF3DZ22Eo2sMLtJZjv2q7xiSrt1u85uKOaJk6NFIW7PIQDyZULE+gSD1jti3rD0wFXDvBFBseRBVZyd3IWw0v7LjqGeIsCy3CSMTWuk07KIrrUzdDk3j+487W+gMyGc6XmkaQXGGw+2HEtepk4kVJw61LxhihgLVgv4VTyJBgHODFPTECB2mRNYP7F6y5tFqtl66Vjl9YtJ4UVmayN++cNQcZ71x4YGRY0wOcFfUpC7a6rgz9/jHi2YxFEHD6UXbHOOyFHofWK81i/nbkq5lr1ZxkaOFRGllpKra+q0zj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sjU2S77WehAgUQtSn4iDIkgWBAUUuNQE8/tayMraCo=;
 b=wLtWfLpqWrxGtT1cyp6Ml12fMrghJtPd6x2yf3XN89/EfbkGDzNulm5mHJUhPEKf4BVFPdG1g/3sG+lwYbRQ2z9SrXBcslPWiTgBo/dbANWda+4R8q6P7kDQuKftoH4IbwTKnDD0Ht1K/TNKNlMPi9IU6c/AOKOzu8RKb9qOfTzWXwmncMeNG5DcWGEDYO3RgLl5zjXp4V6zM84jLwsd51T3BK385XheqHIoGgciagR8Y+Z7mAvdQndm4aP6wDbnOqeNf7yukS525kzhxg9x2voj1uvwFwvfMvqEQ9PLcHgjb3b6gLUG8Rf+C/wlVgd/xff6FdZDl2I0/kmpjG5pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sjU2S77WehAgUQtSn4iDIkgWBAUUuNQE8/tayMraCo=;
 b=TCiRPwSfsnBBWv5Ix806X2dpIMnKgj6T2VFulLphtPHParovWI0ixPhBGOKZExMKmCx5FZvQfcJoVPEUQwsHMcIrampFIAcHAreQW/JvgEAjVLRuUa2fMA2nbzDEKJ0HIkSItApvEQYtvp/NHjl5TwbG5MmuIsqQPIuKhUIxa0Ylb3NPAD/3FB8uYNajhMMKU9TLQJgz0s5aRcmQ63mWYmxmjkTu8crtxHlzAepOlzLNdvCx/97bGLc79oWVRbyvI7hyR+5BzKL/FKU8yeb5XMJtfeicLj8HgcZbcawpBCcde0cmaAYpzkw+cV2m5SpAeX6ENp5600VE8A2B9C3oag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by DB8PR04MB6858.eurprd04.prod.outlook.com
 (2603:10a6:10:113::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:15:09 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:15:09 +0000
From: haibo.chen@oss.nxp.com
Date: Tue, 28 Jul 2026 18:18:08 +0800
Subject: [PATCH v2 1/3] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate
 limits for all supported SoCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260728-fspi-clock-v2-1-dbe786a4a6eb@nxp.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
In-Reply-To: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785233928; l=6946;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=izwP6Tujqqf5uZLERGwLN+30JiIbHue8si2gnuH0h3M=;
 b=w4OGqg6PhSV/EJ41OhiJNP0qXAAgUL59RwLmJR5M6AT1EhXHPf/BmNeRcABXntJZlpnB8BBZq
 65xW2M+lSAGBDwlvDgruhYl9t8bVPGWgIdEfGiOil+Im0lx37rT6/+5
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|DB8PR04MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: a57327bb-befa-4c7a-1d86-08deec911a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rOvxol8EXRk4H5+V65bkwXMnKR4MlbaDUcY4vcEylbjsaU2fZeKiXrc2QxpGmTlIviruZsURZ0zo03AYj2H6tl5mJbozY/a1kMQOmFoV24S+y6ImDkG0qsi/CAKYb4tyGYl6SPJ0sYts1qSYDKe3OFxAUN8gblYVOulzjzyCHr9WHWKmEgOVFoqnCVxHMnra6+sXY+3A2aUO/auqOOSKi8e/GWbnbjMpD9XXYqj96+XgmVDUjewxunzEBpu/YxooPNLm7Vaz9ngTPEBQkcXAJWRifEeoXHGSKbLZlcbnQ4UyMeV1EdrCH0+MfIuh6+EJN/FC0I1ViglVpIKNCJCir5FTTfAGEjzVnoKRMr+pC35l0uMvpdo90mDkIE/y4e1i4Bu/6wH0eXC7bKos368hueX3+2p58GbedAkMl2Iqu7STa0OIVFRUbJ75/56cKY6duOlere6om6KRZh1CHow+2HvZXf5Zuu/uGYQF8ujUNrdNWwbN5l5upNXSIBV/O5ep/6BlbkWL+N4NH5iBHxk84ttDZ7efCw5UHhucobPRwoHPkymBv8jYmHCfSqWWiniUxv0OEXnVqV7URknc7aV3RWcSv4s1IXycN+99Tb2YBFxmwkM7Fi/uV7U27q8q1SBm1ArZ+xOMdIGl8uYXEAuWNHoRmMebvsKeEWo7JiceVns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdxSXVmVklEWWE2cTc0akpkSkpDMXBJcmVRc2d4YXBLQUwzQWdaVWh4RWxo?=
 =?utf-8?B?SHJRT0tUNVYzZE9EVW5nTzR1NGlGQlU2ZFcraUMvMTN3d3JaNGkveHI2OTBL?=
 =?utf-8?B?OU54dmJtajRSMGxSUkg1L2IzOFdsUGhDVm50dTRBUktid3QwQzFGaWxOa1Vp?=
 =?utf-8?B?eUg4TnlJOUV2Z3M2aHFsOXBPR2I0YXFvdk9yQmx4SlkxdG42TXNtRUp3U09a?=
 =?utf-8?B?ODJFMHRKbEhCdkNaajdNdi9xT29Gb05qSkVyNU9MOXhzN01uVzgvOTRIOVFR?=
 =?utf-8?B?SEFvTGxJNmtIQjFKMHMrS1paM1IrWVF1L1JtRDdhS2JaVzkrdXluWGV0RGdp?=
 =?utf-8?B?bnp3ODVVUUk3dTZDY0NWdmVOYlRtK2IrWHBoUUs2c3NCTTBZaTVDS3JQVFNV?=
 =?utf-8?B?czBlTmF5VG96NGV5bHdzY3cwTVdoYWlEWThYbEtJQVdBbzM4MTVyNko3cHZu?=
 =?utf-8?B?Zko1c2xmWkFxWXVjQUprTjE4WjNQUnE4bWpQR3JxeGw0SnRIWityY3N1KzNL?=
 =?utf-8?B?ZTFtd1VoZDVXTzhnV0RXN05JSUN3Qm15MkFzMlFjT3BKY1BFSHR2VWxKUjBB?=
 =?utf-8?B?RElHeUxNejVTV2xrU3pvd2VmY3dZY3VHUmJlUG9MbU5YQlRpbTdtQnMrNE9B?=
 =?utf-8?B?SVlhVjdjeGc1ei9DYWdYcHYxYi96eWNqaUVERysxK1lmOWZ3NVg3Ny9UcHp4?=
 =?utf-8?B?TXYwcVRUSDNuemt4TW82L0ZkOFhEajArMmNyZWFpeUhZOEpDQ0l1cGZjT0pL?=
 =?utf-8?B?YnFNaEV1aHdIT2swUWdDWGYyYmlLK2ZPRGNMcXhlN2NaaUJIbUtHZWtCUGR1?=
 =?utf-8?B?aWY0R3hvZFMrczNFOGhyaGtRc09Ha0VUMTkxdEVZdVlaU0lxL3JzWGpQSDF6?=
 =?utf-8?B?RkJ4MW5CM3FnQ0grU3JQQjlIZGZ0RHdBUFhlZDFqb3RmSWhINWlkcHVtbU41?=
 =?utf-8?B?MjcyTUs3K3YxWVh2RUhzU3cwdlJZbk1nVWlqZEpsdUxOcXlyMmh4YitkRFNv?=
 =?utf-8?B?Uk5vQi9JbGdSbGJxTkZYazhrQzZ2ZXArU01tVjBudldQVlNkMGUrVm9HUyt2?=
 =?utf-8?B?UFNyQURZL1V3a0dBQnA5aFNvNmZxVlR4WDMwR05EWjVUR1BYZ244dm5rZk5p?=
 =?utf-8?B?VDJxWUltT0FVb05kRTYxcmE1UEl2K1YrL1hhWHp1Ukp0clg4NzhBV1RtczU3?=
 =?utf-8?B?R3B5MEtMWS9uRnpCUWFBY0JnRmhBVkZTMnRvczFQSGFSY1h1d3FETWoxNS9J?=
 =?utf-8?B?WUtKOUFtSmR5QlpMK1VUakNSSzEzY0NNTVdYbU5qeTNlRmhtdkxJNTJkQlBa?=
 =?utf-8?B?dXQ2Z0VLU3ZtOUc3NHB1Z0dZbkRhWHpwRDlEck9nQklqRkRia0pRcGUxN1J1?=
 =?utf-8?B?TmpCdW43VlhGa2RXRkl6NGtZaWxZNUQxNGROMHl3OVlPNnZOS1ZVckxGYlI5?=
 =?utf-8?B?UXMwVG5hZHVweWpoSnNtNms2ZXpscEc1NTVDRFptdkMvRDNKL3ViZHBOTHRp?=
 =?utf-8?B?S3dKUzAvYk9UNTE2ZlVqVHNOaWgyL2xOOU0rZWkvZHpTbjE3QWNJQkFTR00x?=
 =?utf-8?B?WEtYWEdjTGRyNjhzVkZUNyswcy9RZmFDNGhEdjZScWY0d1lQRnRQMHBhSmdL?=
 =?utf-8?B?Q1ZLbG1IUFRURHg2R3RGZG5oNFFLS3FNOXVFT292M0tSQWlkR1NNRUx3anp0?=
 =?utf-8?B?M0NlaEpLZlZScytXRVR3S0w5a3VwZ2xES3NnYld1K0hNSzlPVnNtTEFHMVF3?=
 =?utf-8?B?RE5uQzB1d3pLZ09UZjA0UEpiaDBtZFZ0bWxhMThuS0l0ZE9oRFBXY3BacGdu?=
 =?utf-8?B?UU4vSkJDazV4VXNiNjBHRFpISjdkcVM0NVMzblpqR1haSGVBMGR5dEJwajZl?=
 =?utf-8?B?TjRKTGViNkJ6MWRYU09VTlovOUJCb2EzOC9rYlBFT0NUekJlMXF1b2dFdlpn?=
 =?utf-8?B?cHdmOUZmRktiSERlS2pJMkl6aDArMkM1SW00U3V6bVJTT3RoaVdoRWFJdmc3?=
 =?utf-8?B?akFNYjlTUWZwSHRUREp2UVI4OW9hSnRMc09qSlhNNlFhOXVlNmRMdnlBWGtJ?=
 =?utf-8?B?c3ZRS0FRbWljcFNzKzJRenVINlJhWFdYenliam9kS3RodVlmTXhwMVEvYk00?=
 =?utf-8?B?QWxDcURZaTZPL1Z1eHVpYllHc1duSndPSEV3VWp5TjhBUnVTTWMvMDh5NEZp?=
 =?utf-8?B?MGJoMkcxMWEyaUdFVmtvSHQwOW5EMW5URHE0MmUrWTlvWnN5TXFvM3lCcUNE?=
 =?utf-8?B?dkxEaHhWRVQyVWV2cmRZdUM3MUF3NHBqdTZuaXI4YXNWSFFsMUkzRFUzNkk4?=
 =?utf-8?B?c1JqeXFkMjhscHRUdVFHWW9Xb3h2cXhDa2dwMlNzbkJreXpST3p5bWhWeHBP?=
 =?utf-8?Q?JL3dtFeqcDgzkWShmRApHJYoKMe+R1dssPRae?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57327bb-befa-4c7a-1d86-08deec911a94
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:15:09.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM3WDrDHb0Xd2obVnF48jdLxe9osjLofcwUKX07guALPKCFxIph9QNldqopzqyjKsOIc/2VGUlSKV3ibjY6r2YVPw5ro9gPsRo53s7CW5u+7HhjQkyU6KY4sedQgsaRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858

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

Update related platform data with correct speed limation according
to datasheet.

Fixes: f43579ef3500 ("spi: spi-nxp-fspi: limit the clock rate for different sample clock source selection")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index d94a2a7b98d44db217ba96a8ce7df23e37a08ba4..6de6d432cdcb2ee383a02d72f20000045903e176 100644
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
@@ -385,6 +428,29 @@ static struct nxp_fspi_devtype_data imx8ulp_data = {
 	.quirks = 0,
 	.lut_num = 16,
 	.little_endian = true,  /* little-endian    */
+	/*
+	 * IMX8ULPCEC §7.3.1, Normal Drive (ND, 1.0V) mode:
+	 * SDR RXCLKSRC=0 max 60MHz, DDR RXCLKSRC=3 max 166MHz.
+	 * Note: Overdrive (OD, 1.05V) allows up to 180MHz DTR
+	 * but is not the default use case.
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
@@ -691,10 +757,20 @@ static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
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
@@ -1457,10 +1533,11 @@ static const struct dev_pm_ops nxp_fspi_pm_ops = {
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

-- 
2.34.1

