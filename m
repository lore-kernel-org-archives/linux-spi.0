Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632E3D45EA;
	Mon, 27 Jul 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180686; cv=fail; b=AYX/s4ot8GHMwSPNV4P1Z2FITAeLBdIP6huuUNiH//IRzWw8WONwz3ujDLGQk3Nv1mE5vO0ddI8UkC1Y39jJEWWh5UiRedY63zDLn3ft6An5DteLzfRSxFh5Y239hIc/PGo5fTg05g371ixffCH+tDYYtXHSfeUKDlYJ4QVto4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180686; c=relaxed/simple;
	bh=dfI4aElAMdOv/4xlaceJ6XZb+cKlqhRoe4LDQohshxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYc0BwrYVjHVtdbS59h+idaV/O5rAQbtVYm63yqcHRhvJESp8+R4xW59Wnxhta5VrEvMxussb2Na4YQRL8EJRb6Gas1yCFfzVuBOr6QbmcWPycbF0T3IsD95n6OqurINjN0Y972I/95Pbn/sMvWe8EPUGC4EhGw3T24kA/mRfMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ABOJrySQ; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ABOJrySQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjUMBQRMgThwPuM7E0X9zoSbVJoXGNcsUMq3uz6QTSfflaiJo0UQImO3cMSfZv2K+GPsXLxidKbXvJJjC9xenh7I7j6/5WytMFyzWwHKqOuXzBdkEmCvoA9/Gt1tUEt0x+X+03xKm5hk2eWfm44LkXvM8rMTZIyH/ouHaEQaZKWokHKDSHhZhiw4x+Smf8r5IT0LQUai9vbfQtrA605oyWL6fAvPszCe0rzm34b8bbxxdQSQ3vlZ2AjRLhiMDr9wW5/rms2XmiFAEP9qi7N0hxkorcORntglWLAwPZec4srFPtbVys6tyeNJK/dcRLlqSvFExewFxO6rmEY39aUCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+xPuh+zQksPq1zB0a5As0p7vLzE4MY19JjIUCua6bE=;
 b=ANs+gK26Rc+Zoe7lWVrO6ANYJuvi4S+poOH7xHt1fQGX7NsjcB/6noOXNXh7aCYjRuDF7IiGuH/m1w1Dln0ky3p5r8JhN8OwfJRmnCSvB5IaERn5ELPHMOgIz8coZjK4Pa/RcmFQ5Mt4tfex8tOF+QWvuEyqtVWUU46GvDL7JPm9mpZO3JSS8rzS/Gu9MoJb98r2Yg6oDvfW4aNDzMpeTfG+aYZxEJbO/XVkoQ3U6L9w1lNp2UA7IT70fyTAsKeqBey8apmZ05hiTiE7FUg4eH+Dmn8mRQ8/UDib3TqbsK6fahUeurazgMNqTnkVQ09Z9DPjuP6CrIR+0yx7CINt0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+xPuh+zQksPq1zB0a5As0p7vLzE4MY19JjIUCua6bE=;
 b=ABOJrySQ4SdfPDEwGusatXFfPh7iJTdsE/oa6NaSMR8n0YQp6kjtksZXlVgZjDNAuPI12Hu1r9wkK8l0dsdKAmAhYFyEfnK9aAeHJcmw7HdabgwOEDJ1899HKpEUHEjtWb8DOr3JV15nuTpIwjWbAI0L6Ipnt79TAVwGxHTTKVLsZgS/0GiGsWsewxxfAoDQFFdC3x8Z/xQkoNRJqbRO+52lwkh5QXl2JZkuCc4aRI5ZptJy4xtrv5+JjwLm1g9jmbhkg/waLm0nLcYn4tVxN4YdhLqWJNIh8856KP/Y8cikil1YolHWDa5Q50yHSMcic0y6xw4e2BAEZd585+fxhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6947.eurprd04.prod.outlook.com (2603:10a6:208:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:31:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 19:31:21 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	han.xu@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Han Xu <han.xu@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v3 0/3] Add DMA support for i.MX94 and improve AHB read performance
Date: Mon, 27 Jul 2026 15:31:10 -0400
Message-ID: <178518066116.2648170.15820007549794747555.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 124dd789-ee3f-4b8a-2d56-08deec15a333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JaRHzzvWPc/5EoF19hDwz0Kk9MvzVdTlE8CZnBqvgYy1kztVqdPut+z6fPF9zcvNBERA85Wk++daz1ZlbvlaqIQx3lnh9BG0StMelZtEAV78Pcwp5IkrSuoGexkeOY6AVlCYA0JljSg+7bf0BSDfyC2ZKHUdl7xdcv7Y4GAZDyva0+82049L31dOL2c8Rg5zfAwjXdf2BAzGV9VzYJIrqB40jssvFhgJRVncmLRWz5YLi/bW3UsBcQdIRRE6P3De83er1DhegyXIqSRvccbasGirlKEUeBNGsIVAeRqPFRNonRfAT9iw58uLHmy+jUQ1mt+MRLFrFvquEP8Rxp/umgeTn+mnAV96FLXmE0W4xguVhDYi7iGimRu+9WrmOnbkSVJKgdiKaVtdDLe3ZCNjqo3+lLoprvrJZeLfx+WWaOsfUe6TDfwzxd34hQsOG2pn404Gf+KWiOf+HsDsmktN1h3XTKuqWWLgdQfvYfEriZYmcMgNC0tfd4m6EEDzgpYtv5OlpfBI4NUR1va55osYMQlt78ZVzwgfy/WgaOwMis3AtMS+p//mzOX3dyhMBvvVV86uRdJVcAXKDJFcfDV/2pXOQf/4XtU2WeIyu8TE2TmF2VU6ZLMZtguXykDpQE9Fai+hB0Fhzdpt9OSuevDNLQkdID0oD26Ac085bC7Nqo8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHMvbzJTMW9wRm5HeXExaW5kd01FYzZMLytWKytieHljSGMyVWtIVDZtQUQz?=
 =?utf-8?B?L1hPNnZ2TENUbGNiQ3B2ei9LM1dxTjhKbm8zVTNmc3pXdkVoNHlyNCtxUkFo?=
 =?utf-8?B?Rmt5SWFmV3pxUmJleDlscGNRZ21iQUNVa0Z0RThzTTIwRkZ5RmVIVWFHUXdx?=
 =?utf-8?B?ZlNBdlZoY2xIUmtaeG5Udmg0Vk8wNkJ4V0hNWWlQdEd1anRpMnpxOTk0TkdU?=
 =?utf-8?B?VDA2SkUwWitmdVJFZkYzUVBTTXhHaEJ4QkhuZjdac0NFMmZJUXFxMFhJY3A0?=
 =?utf-8?B?bE8vZ1NXclNqVHBEVXlIc0VEbXRQbzNGNGJrMnZiT0k5TkR4L2NaWDhFMHFa?=
 =?utf-8?B?UUlDNzVkV0t5TkxJM05xRmZlem5qWkxoK3YvNXpiY3RuV0VCUjZWb2NNSzlM?=
 =?utf-8?B?R1A1YTVzU01ZUE1Ea2VpYXkzcnpDNUwvSnUxSENOM2tleFoxUGFtZjlodjBH?=
 =?utf-8?B?QTdlRzRwL3pjTVpQSzFQcEw0N0lnVVF2aTlNSkliRHcxN3lYTjRDQitya1R5?=
 =?utf-8?B?V0tvaGFZN2FNZE0zMnNsVWpXRCs2d0NEelhrQjRsVG1FL09OSDZtZ2phem9t?=
 =?utf-8?B?RWJOU0JzZUZzYlovczZNTGROU3hzdTI0ak9UN3d1WmVIWnlwb3hidXdxQ2ZR?=
 =?utf-8?B?ajlZUTNqQzNwUXRNMXpPR3ljOUhhMng1MGRCRGZPL3pURUdJd1pFbnE1NzUy?=
 =?utf-8?B?L3JQL2NRR0JsSlkxNlI0WCt4cnArNlpmajVtRVk0WWRIYWhvZkFPbVZFL1Ns?=
 =?utf-8?B?N0VUYlc5RGdvNkJmRDhMdG9oU1o5YlRqWXI3bGVNNWxXZ2ExQk5pVGlhWVdS?=
 =?utf-8?B?L2NDQlljWWQ2RnVtLzNERlZ3c1ZYTEVvRmU0cnBUcWZXUUFQc0tpZWdJNXFm?=
 =?utf-8?B?WUp1eVVoTVlWL2F5WlJuZ2lyVytqZWo0NzdMVFF3TklzdDdZeElkTjI5YTNN?=
 =?utf-8?B?eUZEN0l0RFRIU0N5U216eml0K0IzdkZEbG9UTXJHUjJEREhIa1FsZW45RFNZ?=
 =?utf-8?B?bnFTaDllSTFqK0FGWExsakpyNzhxSjBkMVl1YWY1U1AvY2xyRFYxYjlnTHFP?=
 =?utf-8?B?akdSb2ovVVRzL0F2N1Q3amE4NFVkMDJ6L0FzaVlkeUF6R2N5OEJ0V01PTG5U?=
 =?utf-8?B?cVBxK2Q3M05DRmhCSWoxRWt2bkxFOVVMSmU1RDEyV21ma0cwbUZIRzZ6dnc5?=
 =?utf-8?B?YzVCWFprVmdUVmhkYUJ3UzZpZXNRck9tazVlZlZaSlFPbFFxSjlrSm9oTjda?=
 =?utf-8?B?NVZ1djhHLzhOUGFyOXpiUFI4N053eTcvTXFwTGFnSnU5RktZYlpGYmh4dWR0?=
 =?utf-8?B?UDVHYncrZE5COVRiY2VrTlN1Z3lhQURFTHhQaEpEK0pSSHFmbkhKbWRKVEVs?=
 =?utf-8?B?cGJaUTZsUllHamNTVHNWVlQ1SEwweGNHMmVsK0l2NGxidUM1QVVydng1dWpx?=
 =?utf-8?B?MnplakIrYk9GaXlCb0NRZHRGSkIrSWUrSE9GYjBPeXo4R2s5eFkrd0pxVjdx?=
 =?utf-8?B?SzNCU2QrY1NLcDFybW5lSXdEYU5kcXY2YjhyOUkxaHhJUlA2aGpUYTV2K3I0?=
 =?utf-8?B?ZEpOWWVtakUya0psdUVVVEpsOWtXdEFDMnc1dHFwQ0RWV1lzeE5jbkxocW5h?=
 =?utf-8?B?VjNhTCt2Z2FqTkdXejlFNkxBT1FkZVN4UGcyY2NWaTkrNnZKNVJyK2tuOHBp?=
 =?utf-8?B?TjBjbzNTaDdFN3ZTQmRHMVR4YVlDdHFsUG1ZRVJISmU5WjBQZWxXOGpiZ3ZV?=
 =?utf-8?B?Vk5WWTVYRHBtajhXRFFTQ3dxbFV0UWhlTlZNVkFXSDlIZ2pLN05xdFBwV0Zl?=
 =?utf-8?B?T28vdWg0SjJ4VjgwV1BpRFg1VmxtdkV1NWRzM2FzTGdVcG9kQi9hb0U0RzBL?=
 =?utf-8?B?VktmZVI5bFVnbXdqbXRGRWFLOGhsS2RIYXp2VUNWTkIrUFFNL2RQRTl3eTVl?=
 =?utf-8?B?TXBWblhMTVI3aFZOeDdzWlFaa0kvWFZKamJ5SWl5UlNOYVRRcitsMXJQRXNV?=
 =?utf-8?B?cDJrS0lxaTAwQjRqNXFGWjNvMGJVWUtiek43VHNkRzZQTjdrSE5VWGxpZFlz?=
 =?utf-8?B?TUxBcGdFc1grQUcwMUdlQ2lWY1FQWjJOUitFZnEzK2doYmJhOGg3cytxMFVN?=
 =?utf-8?B?eFFKTmVialMrVFV0aXJjU1VYS3RjdlZDLzdnbUtBYURQV0VURFBrUlFDUm05?=
 =?utf-8?B?WHMwNjVWQ2lVYjlrVDdyc3NNTlNVR2xhMXdXUVJaMlcydUNNSG5CYlhEdXZM?=
 =?utf-8?B?Z0dVelhEazdmRGxTR0JJN2lwV05Sek41aUtaMk9ETDZLVUpMMWJ3Wm5jZ1BP?=
 =?utf-8?B?ZDRTYWx2eHFKNEt0ekRvcVNqcXRWQmtBV3NrVysrYmNLUXJRL3ZsL2FpSnFh?=
 =?utf-8?Q?PhNKAOkxqTEK823gduUF3oQK94feWVA6kS3Pc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124dd789-ee3f-4b8a-2d56-08deec15a333
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:31:21.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPaKUTkwiJo+0jInlU23OtkBIvPC+5Yf9BfhqfkBd/TGxRo/rIBEhawHujfQ2cRofe5r5k+5PGRJRd5mqD0iGM2wf8EA3rGXfxxVCYJL2ckVhGhOHZkyS5yR32m0A26H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6947

From: Frank Li <Frank.Li@nxp.com>


On Wed, 22 Jul 2026 17:00:41 -0500, han.xu@oss.nxp.com wrote:
> This series adds DMA support to the NXP XSPI controller on i.MX94
> and enables the use of DMA for AHB read operations to improve
> performance.
> 
> On i.MX943 EVK, the measured read throughput improves 4x higher, from
> approximately 70 MB/s to 290 MB/s when DMA is used.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: imx94-xspi: add the DMA channels
      commit: 933bb140ffbd5015e940ea376a8c5c15b0fbf5d6

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
