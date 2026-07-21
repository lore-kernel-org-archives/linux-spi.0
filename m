Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BE4582E0;
	Tue, 21 Jul 2026 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667727; cv=fail; b=MYyJM0GxdSnS5ungvD+efhhCojDAcAtQW2gXGW/Z7IJwfAbDu7/JDO0VfTz9HMMJZKoIfkmXNC3QimoQAGVsBN2gj2oee/W7YKyrqTHI9SDEvCkDlVmtTIWiMqg3jy0qiAZJS2eqZAQdXOvL5iq9/kZiADR0oUixUd4QkIqSkjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667727; c=relaxed/simple;
	bh=qC2MuxbiwI1dazDchoGku4cXFfmM9o6MbUMycaGk5mQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e9dsxLQ7jAIRKg53wUlChMH8xdFx/FvMxrEUtBCpsVm5Luki3hhfn2YepeW3TaZ6MoxYRkKPuQz6M173hsSEGdsJusG0eoLu1YL1FN1ZJ9qXQ2DnETTzWLAkGQSfXn8HWDTS+12iOWgCPtpjYsorF99CSP3Ktq6IvbS1rk6rO+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ae+Gab+9; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ae+Gab+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1RsI1CNHAdiSadW+P/JsAVjitvareLub7jPt0230+JT9GQ1n3brSALaUaEuoTZZkmYG+iKXiA0mLyxw9PvPT4GtcS5DQ3/Qyum8rRJnkN3prVTDfYD5Zbz3ZmEbp8KZ5voVUTa+o/RcCtNN5f8u+F77sy/aXlSfXkhpjlYY/kAqq1Akq8h7Mg05JHbbGEZ2u/PR6tsCYc3xQsmwIFZHMqIatRLFbDxCehigIhUSWinR/MJtNOuLnwEPCq1RytvRH6De52vpj/rpxaRLhBUBUsJHnnavaXJZUpUoqav9IF2KKGipujQlNfuQJiTa5781N7PBPUfLVVRfRg5C1opnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpvPCPfsVrrM81pvHxdFj3wlD026RLV+ioUWciRQEDU=;
 b=tgMsin6P4JxurevkRxIKg4kmaReLuHG+id7efTAsoKlT+IjIcN14n1H8mBgs5LcYWVLjwOcIW2v7Flz+2B4SGHSghR5DaY44oQFmKVcE0bY1ghXq7LJD4jg/h010nrdI7W6VbUOTB24P51zsB+Eyi1ccNbyPVjZB269Sph3ED1vx4Ie5ZMfdGW4KzusYBj16w6PmWRB7ag9Mpu1LmorsPgPznNvvwPS4I4Zv9sdR8+wCL8EpyqFMhr3lIIotLQlmemT3xyNxX3THq3M2OmnKxD5zPbkMo2wyy001xnUxHV9WpKVYmeVnjww3ZULfRXhCYqrYFtXhFNEcOZpIts5yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpvPCPfsVrrM81pvHxdFj3wlD026RLV+ioUWciRQEDU=;
 b=Ae+Gab+9HOwwaKVmVTPdqgUkGN+1uHbscsiz/QOutodf2llNpnyPzGWk2lL3g7rw1AwaulO13lhcNh7KKyUI1IUKljvM3WPunsK4cGZKGIAmbCsTTandkadAeuCftK95zaSCXw1zs6/mRzbjWjwSW1GNizWP0sbD1N0nlJFKPUtZrRmwsE0TIrml9uvKac0X5agJIfU26xdmsIaapvydidshJs/Xa0AKPz4Iv8QCVK3HvmKnU5/w/0SC7OAHptRf1hSs25pqcw488s6wEmbbFVtYMaOTmicXYx61sGAzFYEh3GZjZrZSR2RqqGr3PoHp1mVIFCVigg7Ouor54GK4HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 21:01:59 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 21:01:58 +0000
From: han.xu@oss.nxp.com
Date: Tue, 21 Jul 2026 16:01:44 -0500
Subject: [PATCH v2 3/3] arm64: dts: imx94-xspi: add the DMA channels
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-xspi_dma_upstream-v2-3-9e19d80e7762@nxp.com>
References: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
In-Reply-To: <20260721-xspi_dma_upstream-v2-0-9e19d80e7762@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667702; l=968;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=DIvYzVJJ+Z7BGus1NDjEgVrT7HPmIigSFr3cNQeP53o=;
 b=Apbm1On0fO2MED88NHkNS8jopMTtUbVvmGx+zaQyO2ylIAukDH9WHOZIN+aOwZHKAT1TOu67g
 nv2Nkk5gK8bDLA0UDHhMQehSjMQPTFkueOfFvPZKBNQpRa5Uy6NbwsR
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SN7PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:806:122::29) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c804d-b787-43d0-3312-08dee76b4dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|23010399003|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jSSHSUSU1RpJxa9td6XzsyPRYMatp/WjeZkop2qldCOSHkYRngbNIrtaKgY/T5kp8W99HmRkeUUSrBS10GCW+164ajElgUEUh1v8bN9YRf6K4VJEOPUTMQEuOt2uU3vkr9MRdp55hdbMQGi6Eqa2YE5DdGhATIuixh+fsAB9jX4vENJLJdrpS1ShM99fvSpUd3nuVy34SzPY1YQtDIOZJh3u/E9yBRHUxE3Tk/1dwFZjS8dvZvGACSPzr+/2xi9/n7bobzs+1o7xPvJ2PsFaVyMnH9Ob9nYFhLNXY9oeF2XphNhTOCOd7vcFCPBuuwlRP5YKV0i7oVTRt/gXgW1jRdIAev1RJqWnlykMjWV+KWIQ4u2mR2Wqmq/3pQNdlfIrfwpsN59GQZT2VTbjky2jXuTdRqTftBq8sFKninIiDkq0xycgf8QIhp0G5seOEGXc3uj25jDZg99SFcMhmQNfcLNSY+JbahjzPnOI1wC0mZCGhxim4dMnq7GrwtXUmK/i7VmVRx72oEoFmcZvFA44MIYCRFLmeJVoWhObiULYxn0fJUV68AscZjFxdoCvdlBeTxoX2S0HWFEMKQHtqK03/md7G894pNwCmTh3u6u18Zzatq8lrBSH4RzAh/pkjpNcxEYNNaRUrbDIPXOHPTNdU9pSWU0efwDO8lcKfaJGei8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtzNXR0bndTN29EWkg1ekJSenJIOHRmSVFONDA2dEhWSXdHWVBqZDNPcExO?=
 =?utf-8?B?NXJCL1VtamxSMmNtYzQ5dExxV0l5N2xQNkpUMHRUZXhNeXBOeHpBcXRQZmE0?=
 =?utf-8?B?eXAxZFVnbHpjK3MvaHJuUnJxZDUzSG9ndFFVeFNwRVc5d2prdmpnbmZQNU5m?=
 =?utf-8?B?M3VxS3d2bmNyMFlTU1k3aUhRWlNpdDN0Y0xJTkMyUW5rNktQa3BONVY5MVJZ?=
 =?utf-8?B?RUNzdEUvYy9ySHBNaG55K0JVemxMU3hnRTZDamJaSG5vQjFqT2s1MHZxKy81?=
 =?utf-8?B?R3lUenJoT2pNTW9ZbnliTld3QnN2UG50T0hoN0lycU1mN1lBSk5JWFZtTVRn?=
 =?utf-8?B?VVA4blhiTCtubCtoYWVLQW95alFoVHY4RGNlVGpjQ3NmRGZUWWZPTFNqSGFj?=
 =?utf-8?B?UHIyZmR5Rm1rL2ZHb21kVlVrNVRWQzNOdHFMeGdHL3hjZFl1eDY4SjJ3K0NR?=
 =?utf-8?B?c2pwdmQ1T3p3SHU1NzVvUms0Q1g2ZWhvVmJ1ajRScm5WTTY3RjU4ekZTR0ZL?=
 =?utf-8?B?Y25acjdERnpQS0QyNXY2RHVTTmppd2ZaNjZzNUdFTlUxZzUwY0FZWFZISS9S?=
 =?utf-8?B?amtJQVJDWWxVOXhqQytJNFphVHhlTmpObzI2R21xNW9uazhTYjlUUmF5OHBn?=
 =?utf-8?B?dWFtWXNiQnF2M0cxK29IMWMrcmZYVi80eHNUUVo5VHNGUXkrTktibExySFRJ?=
 =?utf-8?B?TVpIblpBY0ZqMElydlFETUV1b2l2N3dZbjRoQ3dzaVQ2S3c2bGF6eE9hV1Jq?=
 =?utf-8?B?Ylp6REd2MkUyaXFwZmgyM1BNUVA1bGtXVG5LaHEzTW94d3gyUWcxZngxQjJV?=
 =?utf-8?B?YnNHQ3BGSXFwU3N3eTI0aDNEcVIxcmhPenBsOWhzVm41SGRsbit5Q2RPZ3pS?=
 =?utf-8?B?YkdRRGxWL0NkWnUyTXdtZ2NYK1VGeEZraVVBWldWbm9nWmV4ZEh4dUJCQ3Q0?=
 =?utf-8?B?MHV6cnpMU09aSC9iR2o1aUx4OXNINlNQQVBhd2pVdnltWmkrbVFxWW92Tnkv?=
 =?utf-8?B?di9Ld2lGZHNNMXBGcHdTTnJkVzdSQUg1YXpVSktnL2NrZkZvS210UkZ4eGt1?=
 =?utf-8?B?OE1tN1RrdVRpSFJockNSRzh4SHIyZHRRamFSUTd1ckgzOXlrcTh2dTk5Q2ZT?=
 =?utf-8?B?L0taOGNLeEkwQ1pzSnJQMXFoYmRLYkR6ZWdpU0hnRisvVTUvakZ1cXZYOTkr?=
 =?utf-8?B?akJEMnJuR1lzZDFpS2FRb09Ob0JRZmluTkpBelg5TEZ6U2p6cU1pYzlxWmJU?=
 =?utf-8?B?Z1J5dmNkb1VCWE83OEZ2OHJBRWFOdWRycGs1OFFLaXgvVTArRm00YytLS1cr?=
 =?utf-8?B?QXNCZlp5OVNOQlFINzdjSTJ4LzNWdWZ1Y0JQWHJPbEhLcjNtMU9BajBnMGp4?=
 =?utf-8?B?QnJhakVDZmRCcWtIaVM2OC8zL0JsNkU1eCtIaC9tcmFZbEZLK2NqU0RjRWNO?=
 =?utf-8?B?endQM3lkbGV4bkVnVWpiNXJ2YVo1bDljUDQyUjI3L3hOOFYwRm1rZEJQNGFv?=
 =?utf-8?B?d3o3bDhIM2hXU2tmRzJJUWtpQStUWmVTQ0kvSWdIUzBwVVJJeDlwVktwR2F1?=
 =?utf-8?B?YXB5YW53RU5GY3p5dUNQS3lWUE4yY3lBWlpYb2pBSnQ5c21oQ0pTL1NVbk9i?=
 =?utf-8?B?TmZTNjlzSGIvaXpQQWpxM0ZPbDRmODB4MU5QRFllN1JjSE5kREEyZmV1NkdH?=
 =?utf-8?B?NlNJaDNhdldZSUN2aHplSXM4QTNoYnB1blpUME1XNDRXVTIwNU9Gai9sN01D?=
 =?utf-8?B?T0MwM21kSXg5L0g0K1ZLT2FOOVc3OFFERURJT3p1RUxCSWpOWTVRTWFCUmJq?=
 =?utf-8?B?dGFFVms4NzVkWUd6ekY1anQ3QUFZanJXWGZpTHAybjJvSGFNM3NFYS90QVRU?=
 =?utf-8?B?c2FJekZYbnlONFZlZkg5ZmY0aHNHWlpkVEhuZlZtdWVUbTBVZDlGU1E5Y2l3?=
 =?utf-8?B?Rnd6MGthZ254ZmNuejZFYU1UMjZObDFtZHBJTmRoRHhYWWZXNzQvYTUzTUli?=
 =?utf-8?B?K2ZkZEVNZ3FJZ2I3RXJHYW5hTmdDRmtzQ0JJcUorZTJxNEZuLzZYMlE2T0JN?=
 =?utf-8?B?Y2xEcUFTVnpQUm15T2NjSWRIY0hsYzkwWllLa0U0VitIU3dpZXAwRUhqSVVT?=
 =?utf-8?B?bFNBalNESmswNno4ZWhiTDJyZEt0YjRQUnV5VmxIQUN5WnY0QjVBNDNBcTg5?=
 =?utf-8?B?SlZkMEpYbG9kTTVXTlNPbnBrSzI4NVlZYkVGUkRzbmNySUNoTmFUUytEaURJ?=
 =?utf-8?B?Y1VSSW1MWnFqQzkrMmZxbGNhbHN4M0pTNHJLSGY5NEVMQk1GaTJ6LytqSjZQ?=
 =?utf-8?B?c1I3aDlDZTVndXVpVGZQUVdGc2phcXQ3OEN4cDhNMHl5Q2I5cWR2cHdDMHow?=
 =?utf-8?Q?Tq5bK8k7FpoSlPGM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c804d-b787-43d0-3312-08dee76b4dea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:01:58.9023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0r2oQCdcEUKAUhLgbq6UzcbDu+w56v9yUKIWX+bzCNCfjymAM6GXBdzeSvxlFGUeLhOKRG1K7Cx1H5RnbjRidEIv5qq6VPzG9qExz0pAhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368

From: Han Xu <han.xu@nxp.com>

Add the DMA channels for iMX94 XSPI controller.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx94.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
index a6cb5a6e848b3..70c9dbf10fa5e 100644
--- a/arch/arm64/boot/dts/freescale/imx94.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
@@ -827,6 +827,8 @@ xspi1: spi@42b90000 {
 				#size-cells = <0>;
 				clocks = <&scmi_clk IMX94_CLK_XSPI1>;
 				clock-names = "per";
+				dmas = <&edma2 27 0 0>, <&edma2 28 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -843,6 +845,8 @@ xspi2: spi@42be0000 {
 				#size-cells = <0>;
 				clocks = <&scmi_clk IMX94_CLK_XSPI2>;
 				clock-names = "per";
+				dmas = <&edma4 42 0 0>, <&edma4 43 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};

-- 
2.34.1

