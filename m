Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007A4B44BB;
	Mon, 28 Sep 2026 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596147; cv=fail; b=VRWQ1jVpi6VpLARAY27mJo0fnyLj0H26Y49mVXWDWxQNPAReVQAyj4CPSlWD0xKJNN2Qe7eSiQ9uAt2+MsqRvh95vw+gRpkfyPh0BMil9W2lig9rUSzArDsO93NdoahVL08yHwIUlol4GstYr6mMJS1URk5WSoWwwmdteNj95Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596147; c=relaxed/simple;
	bh=34UgFuUHxIwc0EcEr1RIAR5ZvYXh3YSB6axI3SVN3Ho=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=WBG903vCQD/16rOfXCrOHHK9/Alw4wJanmKx2b4KIosO+WROxRn+SMBehI4A4HlVW+lImdoRiU0h2gdnkAMtBf6fWJuXxkPSvNOH3/Ln7HO2QnOsAq3gbyS9DX6lRy3QqTmKAJYPRR0b9mcgIt2cOritUj+VeVuBVi3T+YqenyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o+p+4jxR; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o+p+4jxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khGiMqr/GbOWFIM5gU+qmUW8ZVLCaU1690sPNG++siGSdEFdG/GNu/3hgfG0dJarKMQ6flGNBzs/H10zzEST0hTXdqDNfw2XJdHXkQQAmDQwrC9oNIVV4wE28HyHbDYgMipFBTMA88FidvbZsZQ1ojJlwubMc5EkNFZFnFGDn62dbpM5FBxkFMzB+Z9laQlFZBNYro5H6eZq+ISXocCQuVhljTlG71qHPl0EeSfcyxo32E/B7b/WkM3V8ZEoavZv+wUjY1fu73UDeFH4hO1sBk5HBYrePw/1hcMZMDCi79C1AOoD39aISQ32PMYR+LPkJoCzW9FGrcOxeDCVs/uF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXtuzYt/Hcb2RQYuJ5uIvJEIBHplX7EnZm5Y6FYm3ek=;
 b=To/ZXH5axreaKqgMepkxsvYkT2oh2vxPEr9b7SxiePMTFw8tnc2YtlNt/f45PLoBKu9Sm3c3fXzYCyxe/DhdJMBCOpq43QZBbllxNJue16GI9d+pAwBQNxesslw/HDp9itJLjFjQdqz0M52MELEd5MBZgXW4D8kW1EuJ3AhSj+PU+bb+wj+pR8bm3HaRE78ma9qBARrsIoLzXx1touvdqcgUfPFsp3XDKwFHc0stc0OW03WnggHBRKJrYCJae44ev+JqwJFnPb3sqDL9V0fhbbAhgq8ST7h01RdB+fUYRukNYHKJWCO27yI41jQgYPzYMp8bl291ZklPS5ixLL/LSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXtuzYt/Hcb2RQYuJ5uIvJEIBHplX7EnZm5Y6FYm3ek=;
 b=o+p+4jxR36kE2e75y4TGuxnss8oBZkC8bXVBNJ7ZpyXM+/fo/ruRpYv1dRx+Q/RnTqMcvyfHLqbu2PKWi7kSgygmfWpH1Bkw9dOJcsb8XU6WtgJVz44tl4zl6VspsZpTKfaWsN86tWfjd6/EcJD7aMdEB5kcZ2m197gT1zH8/rcL1Fif3o+xIYKvawUOqyuxa2sLw1a4W5fuyikYzHSAifOTY1JQidu/pscRa6EDSv3Kilh+nXqVMh5f4gi9YL2sRpKpcmFu1vGdH1lKseFNlZFt1Cq7MCsgPRRLuUTDKL9mHGoYEqxlV4kWtV3IHO+5aI0KxcNwGu7zcENnzKNnAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by MMZPR04MB729243.eurprd04.prod.outlook.com
 (2603:10a6:190:32::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 11:49:02 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:49:01 +0000
From: haibo.chen@oss.nxp.com
Date: Mon, 28 Sep 2026 19:53:11 +0800
Subject: [PATCH] spi: spi-nxp-fspi: exit stop mode before waiting for DLL
 lock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-fspi-fix-v1-1-a0f9288cd5c8@nxp.com>
X-B4-Tracking: v=1; b=H4sIACZVumoC/x2MQQqAIBAAvyJ7bkGXEOsr0SFqt/ZiohCB+Pek4
 wzDVCiclQvMpkLmR4vesYMbDOzXFk9GPToDWfJ2ooBSkqLoiyLiHXEgCSP0PGXu+l8ta2sfa/W
 OPVoAAAA=
X-Change-ID: 20260928-fspi-fix-fff612e82f84
To: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, michael@walle.cc, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790596406; l=3875;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=JSyls9Pu9DOkXGyKOHLs3XsvDwVwu/zmwYD7l0g+80k=;
 b=H52H1DsCt0dV7Lg6r1Sb0vrNXjrAYSC46egGzHu2gM1unspL/wg40Wk8YsmLAOtea8bqj5zoI
 7K5kjK+AfMIBZPhe8QuPxNWNJXM8K3xyjwbd5DBQPq72BG/modySPPV
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0285.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::8) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|MMZPR04MB729243:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b0435-1462-4f49-2362-08df1d567d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|19092799006|1800799024|11063799006|6133799003|10067099003|56012099006|18002099003|18092099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	W/LlYwV1F0vAW8Olqe3+IW/1ES/CieMAaFe/npmfVSl/R0/O6j1dmgjX1s6m6g7cytkIcVgWkEk/f8NomfZGCiiu1Sb3N0j8JTsRS+L1trtlV0aMxbJ55PfbHhajTq4NXw1DrM+vzfwOJuONqH7/eX1qKhrO65Mqblulfp+kmfT3vMl51Vip0kUExMM1KCbJy5O3+N4Fy0e86pT8+ZN45z8ULZAH25iJob3LPVm6jZWLzR+guUoZIDhuYWX//iLSSHO+oHLSdQG8SQGli3AWFqw6QericEnOTgETEsEfy2REq7CT1u65tmIz1YHYSlsRZOFCm9xuFLXaw/W1yfV+NgzxVscSiKjZMSV3PK4XAUP2iVDjbUHYtEQaiA9Iz/UtZuAKsK69MLiw0XCmdH1vfKhNLfTkDhdJq5Cdbi5wiEZr/2EhszAXyLXvlv50wPs6dTbeIXN4uX7z+bTxgABP59wvVKORcqJgfq3XgEmM3eDIKMWVyXRJOEuGgnwSPoXOR5bw6DzELsrQ5FkyZ4GJAlFdaGkD6AR9t3GdR4UIBBpUZy37gXRuUf6jq5h7MOdg44NqcXl31XVvz/TA/EfnooZBKGXmP293pl22IdDkGKO9KOlX9I/F3tMmKU3TXK2B6CGdD9wWWL715WHYtAx26dAayry6NeAsJUVOokqnhtE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(19092799006)(1800799024)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(18092099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1pIVmJ1NGpKWFNXdEd6WHh3aGo2ZHZ6RXJKUTBqNzRVek9Kc0RJYitwVGdU?=
 =?utf-8?B?VGF1Ui9BN3pEWXA4TWhBZTNKcXMzemRoNHJ0TW5CM055VjUvSkZzN1l0RmJJ?=
 =?utf-8?B?R1UrZkEvY2ovNkxPS0ZZRjFRQnFvdkFiaEdJT0ZtNHhndmp4dDlDclBVaTZt?=
 =?utf-8?B?a0VpRTk4WDVJcTAzWGxqVmZuY1ovQmRCZlFGOFdhV0VmRzV6Y2Z6bWdCQk10?=
 =?utf-8?B?TlR5cTJvQTJRblhSeWlLaHlQVy90STZDbllZVFV0bUpBTkxUZURYRmt0RUFn?=
 =?utf-8?B?eThmejJCc3VHck9hUEpnaFFTZXlhTUpUWG12OFBmdHNRRHZhUDg1T0t0RU45?=
 =?utf-8?B?ODlmdkltcE1QbTVGcEJ1NnJwdlI4K3A5SThtcG9XdVBNdkR1QWFRL0ptV2dj?=
 =?utf-8?B?bUVINXlaYk1ZSDFGdWxGQnJSRzJrMzV1cGR0cGw4Q1BwdWl0QzZGKzFZVnZu?=
 =?utf-8?B?enA2QTE1SDlVdENzZ0tpdlJocGJaRFB5SWRlQ3BRMm5SbmVIaU9kSmtJUUNj?=
 =?utf-8?B?SHhqaVN5Vm5vWHFCWW5KWFlyWWVPVUtoa1BxUmV1bVJ5V1JBcWp3K1RsMU93?=
 =?utf-8?B?Wi8zOFNRV2FKSVVORnJ4cHJyUy9oMDRSazJ4b21XR2hFVVBDUkZkOXRQRUgr?=
 =?utf-8?B?cEJXd3ZUaFN6QWh6RHlETzFuNzQxWnBqZVBhRUdIajhjVXgraDJ5UlNPYU1P?=
 =?utf-8?B?WmtXRlNYNGgzNFdjc0RFZUgvZGF2WGR5NEowYzFROXJGSmg2TnZyNy8vSHpF?=
 =?utf-8?B?QWdGLzUwOVZHOS9kaE9PMzJmVHZGR1lEdHBhb25XbFFaWDZ3c2FCc25DYXFS?=
 =?utf-8?B?K1RCSXBrTkZQUE1DNUV3dTEybWFQK1VvaGNUZVAzZXdTb0dnVVFlZ0ovZ3Iz?=
 =?utf-8?B?K041NGM0NGhsN1J4dk1PQ1FOVHg5R2ltUkdKdENUeG5RMGE3UXMwcWJ4ZEZF?=
 =?utf-8?B?NFAyMEE0Rnh4OHdIRHo4RVhUWW1IZG1ZaTA5U2xnS1l4TXZ4emh0N1ZVT2c3?=
 =?utf-8?B?RDhyNEZXOGdtVklsYXJCYVhtdFhhRVNSclhRM0NPVlNGSFlvSFRkbzVsU0Zw?=
 =?utf-8?B?QWVacVR1TGNYNGtVMU0yVnpSQzdEU2gzcmEweFp6S0JCRGVRL3diL2FWY2lE?=
 =?utf-8?B?ZkJPNFRtS3J3L2poT0xWTDZESGdoQmtwV081WEo5MW9QV2djaTNHd3ByRjVE?=
 =?utf-8?B?SlBwTGw1OENGM1JlNE53TThmOHpCZlM4a2JGeFJ2SGpjdzBNUUV4T3hKMVo3?=
 =?utf-8?B?MHcyMzdjK2hSOUpIWlJDN21aSXB3LzR2RnVQRE1jbTRvR3lBR3R3QjA5OUZX?=
 =?utf-8?B?dlA3dVhZeG5HMVJYTDQ2amJWZlVmeno3TDZpUXFuMnZtRHg2UGN6Zk9waFdo?=
 =?utf-8?B?b2pDRnl0dm1qUVFLREpuTDVRRDhQK3pFT05WWXYrOEU5L29RbFdXUmMvb0Rr?=
 =?utf-8?B?bFZyYWxRVHQwUXpCSHRPTkoyUlUxVXBYbDI0cWRsM1kvc001STBGckpCN3By?=
 =?utf-8?B?Y0dPTkZ5ZjhUTDBwajVMekUzQm9rWVJnQkVqUi91a2RRMVFNM1FVSE1rMGdG?=
 =?utf-8?B?VWI4T25IWUxMMVFXb2lWTDFiaTBuZk9aYUN5dksrYUlYakVIck9vZmM5UVFy?=
 =?utf-8?B?MFhCaWFNQWcwNjNPVGlLN1RRQkFZNXZkbnNOdXBlT0V4Y2RpeEJrNkxLeml4?=
 =?utf-8?B?ODhUYkxVUHh3QlpBRzFuZ3RKUTZTdWdqOFJxVG5qLzhtZlh1OVk4TWZKSC9M?=
 =?utf-8?B?WDdObDVQRXdJYlRRcjJDWDcvVnQ4S1o3MDhYbkRFSTRMU3VCcnVUQWNESG45?=
 =?utf-8?B?dE9PVnFhOEl5Njk2UlFvNFh1OTJ0UUN1VGgyWUV5UnFsb1NBZVdlSi9RWk1w?=
 =?utf-8?B?d2RSVUZkKzlZQ0l4TDRxanhGU1ZrVTgrUkdoTUtleUp3SDJqNUtUSWtSbldF?=
 =?utf-8?B?ZFlLZXl3MDdJNXFROUQ4bFNrdG1FT3M1dTd0bzRwRDZNL2REWG13bzJlWkZy?=
 =?utf-8?B?SWxIazVMZ0NUUDB1TTZhWTZDT1lLdkF4REk0cW9nc1hneUZFZTJhaUVvNVpI?=
 =?utf-8?B?WDR0WkYyRjB0em1vZnd6Z2Y2ZURJd2FpSFRSc2JPUVEybE0yVjduMWt0U1h0?=
 =?utf-8?B?QTdQcVY1azVRbzkxcy96TDhqa2VXTmtyS28wV1JnT2x6TUNoUUFWam1Qakps?=
 =?utf-8?B?Vkc2TllCNHpVUURPOTg1WTZZUGFmMTdqQUpHOVhBQnk5QTJ5Smt0MVBHdmNI?=
 =?utf-8?B?K0x4ckFyWi90b01nbVNLczcxWEJNTkpZRUZ1V1ZSaDA1UkdZNFV1ZXN5cGhL?=
 =?utf-8?B?NG5KWHgxWXhvaTZhaWxTdEEzdXFoNlppSUxEdGwvVVJ4WDNFeml1OWx2bk9P?=
 =?utf-8?Q?np7A3a+9C1KNArrIwtokrrokwNIZsyM5C90TX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b0435-1462-4f49-2362-08df1d567d44
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 11:49:01.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNPyOfiO6JKRRN9u29EuUgwo3AqaQb343Y7k79KhM9AQP5KcC/nZEC7aH+glTHU3tXiMfc9URzx99twnkiaa45zmB5h5Fdb24LkCV7xO1lN1pyy0lJX34HSLY4BTXHjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB729243

From: Haibo Chen <haibo.chen@nxp.com>

For 8D-8D-8D (octal DTR) mode the FlexSPI samples read data using
MCR0[RXCLKSRC] = 3 (flash-memory-provided read strobe on the DQS pad),
which requires the DLL to be locked. Per the i.MX95 Reference Manual
(FlexSPI chapter, "DLL configuration for sampling"), when the serial
root clock is above 100 MHz the DLL is enabled (DLLxCR[DLLEN] = 1,
OVRDEN = 0) and software must then wait for STS2[xREFLOCK] and
STS2[xSLVLOCK] to be asserted before starting a read or write. This DLL
lock is relative to the serial root clock.

While the module is in stop mode (MCR0[MDIS] = 1) the AHB and serial
clocks are gated off internally, so the serial root clock the DLL locks
against is not running. nxp_fspi_dll_calibration() both programs DLLxCR
and then polls STS2 for lock. When it runs entirely in stop mode the
STS2 REF/SLV lock bits never assert (observed as "DLL lock failed" with
STS2 = 0).

The MCR0 bit fields (RXCLKSRC) and the serial root clock rate still have
to be reconfigured in stop mode, so keep entering stop mode around that.
Only move the exit from stop mode (clearing MCR0[MDIS]) ahead of the DLL
calibration/override step, so that the serial root clock is running when
the DLL is calibrated and STS2 can report lock.

Fixes: b4bde5cfff8e ("spi: spi-nxp-fspi: enter stop mode before reconfiguring MCR0 and DLL")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 67d991dd249d283e5a7b777c3ef4a70a9af3f065..66cb58f95fdb1ce5dcd0288bbf0d473de7f9f371 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -898,10 +898,10 @@ static int nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
 	/*
-	 * Per the FlexSPI reference manual (initialization sequence), MCR0 and
-	 * the DLL control registers should be configured while the module is in
-	 * stop mode (MCR0[MDIS] = 1). Enter stop mode before reconfiguring the
-	 * RX sample clock source and the DLL, then exit stop mode afterwards.
+	 * Per the FlexSPI reference manual (initialization sequence), MCR0
+	 * should be configured while the module is in stop mode (MCR0[MDIS] = 1).
+	 * Enter stop mode before reconfiguring the RX sample clock source, then
+	 * exit stop mode afterwards.
 	 */
 	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
 	fspi_writel(f, reg | FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
@@ -936,6 +936,16 @@ static int nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	if (ret)
 		return ret;
 
+	/*
+	 * Exit stop mode before running the DLL calibration. The DLL
+	 * reference clock is derived from the module clock domain, which is
+	 * gated while MCR0[MDIS] = 1. Calibrating the DLL in stop mode leaves
+	 * the STS2 lock bits stuck at 0 (the DLL never runs), so clear MDIS
+	 * first and let the module and reference clock run.
+	 */
+	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+	fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+
 	/*
 	 * If clock rate > 100MHz, then switch from DLL override mode to
 	 * DLL calibration mode.
@@ -945,10 +955,6 @@ static int nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	else
 		nxp_fspi_dll_override(f);
 
-	/* Exit stop mode now that MCR0 and the DLL have been reconfigured. */
-	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
-	fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
-
 	f->pre_op_rate = op->max_freq;
 
 	f->selected = spi_get_chipselect(spi, 0);

---
base-commit: ba52b770f89bd2f3771b98edb92c4fde68ca8cc4
change-id: 20260928-fspi-fix-fff612e82f84

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

