Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725671C862D;
	Fri, 25 Sep 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331219; cv=fail; b=VPsVjxFTvUQHAvIXhf7OksHdU10NAstPSyzQi53NkuZRoHPO5zrVQlbd7FYgDcCOJvoDRo8jq9WC6vvdqBYPJZcf0/yOmMuq1NKdd1orE/cZ58BaMv0c6JrYfyMBqAzxlpjKIKKkssRpucUoNoTVtyhKvV5fKJROHCjCMTwHIxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331219; c=relaxed/simple;
	bh=Eh1Bn3X0JxCZcuZJB1oRuPMfw+5fhHqspjswZZ1qP58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8xwx5knyKNAA6CjFfCaC91MT5KEwjs6Gn2ggx+0AjZiH1AVdlir0ErhctiyJbEbamePM9s6+enWiAeH5uE4Nvysq/gxNLskNjYuA7EXME61I5klTnG3FyDHrfVKdjoKR0OSSF2yb/fYsTxj/gs686d1IotwXpZxL7Cz4ux7yjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GX3OiCAr; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GX3OiCAr"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P8XFLo2945087;
	Fri, 25 Sep 2026 06:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SjQX1
	SUjvSjpnVKvtM+cBH5zcGaj6+ZPdWlwDftYS/Q=; b=GX3OiCArFGmAFOUP4b26l
	sHSfTeOq8vewthMz2Eb9F+0CqA/kyZeMr6UW6o75uvJL521vhMTrsxZKNMQ4FMcA
	xEFOFF5g0vFu/DEjbUP4eIoDSdGlF0S39qqa8H29gj8QCVczWaFCcPMXhWU+a9z8
	y5SpiKg31Nb7cv4SGFYjzsLfN3ILc9gYb20oKzAz6gMzUyUAIUvXb7sqMFPKmA/G
	ldcZIzH3jJz/NIL3wi6jNrVRReDuGU7m/C/xo4LVDcRGpNRcO6a+sdoP4NRO+Pu5
	us4dSXZxEqUDJrqSl0LY/kuQLeV5IU+Ud5qk3c2DWV8MCEG8gCkxy52WCwKJZVMO
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gw7ckmnu8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 06:12:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPtHlLSNM3Uw49eua0DmSlXEzQ8oC3AbtlKXYkb6mUceuBw0ONVICoBps8GgFhOykP19iXsi+CG115yfuZovcx7in+iuxHce2xCfOi2dSn4tl7k6dH9I1m4VkGX8v7YWM/XF+DTS7NR2XDnQN+RAsrVDq41nhUAx9AbAnrMI4llFZSGgzPoOipLLVE1ELX4V0yTnahQqQEbhs+cBTihRxarGHaYcZvDJXNprlr5iMA7Hab2N3BHxVeohkcHlIjevAeXH5VHEZGSztCO2PRK9tHvx0AfcIZNFjiDaGt9Mo+wKXpS3c2wjw+hRqC6WfDgp9/r4e4klA94CBPkfpFcr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjQX1SUjvSjpnVKvtM+cBH5zcGaj6+ZPdWlwDftYS/Q=;
 b=vqbuTMBmwBaiOHelDrxyBxLy0IpKTgkXw/n2p/+nSm4aka8joDph5JQhc3vU2twA63lZyz8DrP6hoHUO3JJycxI5wcnsLj6NVbwjoL7yhdFJtLudcA8mw53CrbvU2T/GXSzzhh3GDpvDlTeum3c8zLtjRVA6sPDswS6ZdaJB1QLyt+pYDwhD110L2WWlenmM50MLZAPjNPS4FeplijdFqQmUrpryboWQ4gXP9yiHrGBG+zTMn9YyYijAvKCyOx7xnITtEgxZvteY6amsbphQyMUb0oQDw5awTRaazKErU3iEJkv8ZXBAKlT3tEp34vGZTHJB2x1WVfGaeXOtTavG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MW4PR03MB6393.namprd03.prod.outlook.com (2603:10b6:303:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:12:52 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:12:52 +0000
Date: Fri, 25 Sep 2026 11:14:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parshuram Thombare <pthombar@cadence.com>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Message-ID: <arZHjbzUEFhydnHt@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
 <20260923061211.1608907-1-fei.xie@horizon.auto>
 <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
 <87pky1ll4g.fsf@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pky1ll4g.fsf@bootlin.com>
X-ClientProxiedBy: MA2P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MW4PR03MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: dd38b887-3918-49bd-9ec0-08df1aed8e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	L2vTEgi+Ae/oC81QO2re0rQ0IVlPIIJKxOfGjbM3lu/pJZRy26xPDvWR2whhbEpwMAP8ITfMYtlIK2qx7eAuiGSpVb2aiJDVuA6aDnZhuhfo1FNimlqr+KQ/5XJqNG37YRA7wxyHyL0zCuU4kXhlQe8W5zpaMEpHxW+uDwdd2rfidF1fieRcYhYpixusxdVUYzstU644GKBlN6uEOi5fmoFd80cHBOFmrqC8298CDgH6OfhyAxn9SUa9Cdhl88PcYNuEYSNzxilnKgpA/ZslplqDMN4eh44q4MwbjmHmmRs64tkBDpwvMqj+pV/LvfmyM6w0CHqQR4hGtI/2PvNZfDrHBbI04exf+IUFQhU4RQd2FI97fXeRJFgiA/1Ceza+oMpbMJ8AYoQppotUp6MgjrPE4nMcRBjWVC6UOhglBRYS8tohAWyHS3U/yTTm0E9YHg8VDIkuHthivweq+H7/hqfqB19SpOCewjxXAyevi+0Uo7+5hru+X0HS2v1hnjqBjLbUy/KvVeXr5cN2gevyKOXEkJZI+EMG7RfXcU6RBIZQ+2Au1KNMwRVCsDYnKwBitpspBuZNtO4O4Mky9cvHSc5cKFCeZIQLoySesBTrXA86MVyZgucjOn7TzI93gFZj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3d2ZVdacVBrUjg0V2wwdTNZL2pJYnQ1Rjh5TjFodHA2THVNTTFMdWZPVlJ0?=
 =?utf-8?B?OTRUekhhYzdiZW5DdGdwM0FoUXB4dHNQT2gvZlMrY2FQU25EbjdaQXZuQnlZ?=
 =?utf-8?B?ZHhvVlRsVW5MaUFiMStqWTBMQ0pxOExCRW00aGQ3aENTcnUvOWtpUWZjMWl2?=
 =?utf-8?B?T0FMV0d0SWM0NjZwRnR6d2xObEFTZUtXdXZyL2wvaVJkRmpPbVVEbFNlMXBD?=
 =?utf-8?B?R1pjNnJEaE9SM01HR21OWlk0YVFDdGZJSklSZzl1a05jR0JHTU5BU3k3UGl3?=
 =?utf-8?B?eW9tVmlSQTVBclZrbTh4UTErc0tTRzhNZ2pFdzJMTEtrd3B1VkxrTExtQ1hI?=
 =?utf-8?B?UnZFSjA1bk91R3VtSEdtMVNxOW03K3JpWUtRS3Bjc05oL29hSmNVNEZjVHk0?=
 =?utf-8?B?cUY4blUwdVZvLzh1cHlFczRhNjNaSFV6WUV4RGxDVVBvbldRSmZreTFpV3dw?=
 =?utf-8?B?cnVvUG1iL3M0R0VEbzJoRFBwNk13ZDFxQUxpR1hyYk5nOUZxclROemlzZUll?=
 =?utf-8?B?L0pVZ1Zxand3N1hocU5JTFNYM2NJWGxIcmFZYk1vc0c1S2ZYTjR5SVpNRzM5?=
 =?utf-8?B?Y01JeWtrZTRmcG9BQ0t0bXQyczdJdElQYjExUytLZzhmSzViQmFzYmJYSlNR?=
 =?utf-8?B?d1ZQSno1TmpaNTh0S0Q1ODdCT0l1Umd6NGE1SlhHdmE2dVJhTHJYMWR5cUQ4?=
 =?utf-8?B?c3owekVXQk9PNEcvOWUrS2Frc2F5aFNoR1RzdU53aGdkNzR6VFd0OHBNNDlT?=
 =?utf-8?B?ajlVd2l3dHhHQm41bFE3MS9zSHZpWXFNcGVGam9aQmdaYXJqWjR3ZFBQRGov?=
 =?utf-8?B?Y1dTZEpqaXVxemtIQnhwb3ZvN29Nb2xMUERQL0s2dEtvb0lZWWZZenJBeFcv?=
 =?utf-8?B?SlBCeEhBeno1RFB2cCtkeWdiK01JQ0x3S0N1eklvV29xcEVvd2ozTDJPNmNv?=
 =?utf-8?B?TklwTGdLTTgvbkNyTC81NS8zQi9lWVhwWCt6NzhxalUreWwxZ1JUb3RiQmFj?=
 =?utf-8?B?anp2MmJMVXBzdE1YNk5GQU44TjF2Mm9vZ0ljc1ZzZUo4VFkrNTJXZXR0RCs1?=
 =?utf-8?B?Qm1BMmlJR3Q0eVp3V0hGcjYrTHlQVkxSVk5KcUFPaGY0dHdDa1NCdmI4bW1r?=
 =?utf-8?B?V0ZyYlRaR2g4QVRxSEZRK0E5Q3ZYSnVEK1NHTm5XM2U2NlhFV3ovdjlKOEhK?=
 =?utf-8?B?NFdBekJLRFQ2WEtpd0Z3YXlKSWdTSFZvdGVpMWpHM2FYeU5kSzlDZ0d1Sisw?=
 =?utf-8?B?cjVtd0hmRE9ra0JNaDBVLzd6V0dkNFFrMFFhajdEWll3VDFtYVpYaEl6cWpK?=
 =?utf-8?B?SldwcW96TG1iN1lEaXMvNERqN2ErOU03VFdRMHJaMGFvUnVwajNqaktreGpx?=
 =?utf-8?B?NlAyRGF2V0FzODR1NEVCSkNGWEFVMTkxR1dUcDJaK2pkL3IzNm8rK09JWlNE?=
 =?utf-8?B?TTBDb1pzUGo3K2tMeEE5bXRtZHBzczdNZGprL00wVmczUFFPTXNnRkJla2lR?=
 =?utf-8?B?UmZWZ090WjdRZlFJa01PVzNLYWZLYjRMYVNaenlEM2ovWVYyNGJTd21WMGw1?=
 =?utf-8?B?aWt1TjluSFZDSGEzYktuMHFsOGNwUUMwU0plWXQrZEhENHdMWStqYW5RbDdp?=
 =?utf-8?B?YUovYjdjaUY4TC9hSTByOFhSK2IxMmhERDRmMjlDZlZYZGlEbmJadmZOenpz?=
 =?utf-8?B?TGM5ZDRKL296enFTeXVlNDE3TGpTQXptT0dlcEUrUmp6b2tXZXdFWTExbXpr?=
 =?utf-8?B?OStPUEhQTTk4T1Z1c25YZEVXN3NUYXJRQUs0eGV3UXpTSTdWSVl2bjlLN2Vl?=
 =?utf-8?B?ZjA1cjRxZzFEU2RXK3FmbjFvMUVVOCtCR0xuRlIvaW16NUJWcVN5Q3BNYkMy?=
 =?utf-8?B?c0NBUVhOWFVReUFVSEo1UnpJc0NhREdpU3Z0bms5cmFpaWl1V3pGemZhQThR?=
 =?utf-8?B?OGc3Z082NjB0NXNjWDFxRW5KZ1NkYnV5TFBXaGRLWFY3czk5UzFLb0dyL1NW?=
 =?utf-8?B?WEgyOWpCMnNQMGx1ZmwwbjhDRitiSm1OQnduQzl5QkNoTVd3aTI5dXFGR3hP?=
 =?utf-8?B?NnBLWTkxajhpZ1J4VjM5TmJmMFhXcFFTWFVDZ0RBd1UvaWNyRTZDbzRXYWxi?=
 =?utf-8?B?Y1ZaUVM0Uk9JZUpGcnhTSEdEelRaMkU3TU9VOUNrMjhBWXQ1WGd6SzNlZHYz?=
 =?utf-8?B?L2tJV0RNYlk4RlhiVEJFZDhoWVZERVdra3pUMjJSYWdacTlOTHlKVk5KWmtC?=
 =?utf-8?B?Z2IvQ2tBN0ZGNnJHalVJa25NejhTeFVwd0N1WHlrSm02VytlbVZJbkU1NXVV?=
 =?utf-8?B?S1BKYU1iWGZuZFNacFpmVm41d09YenZ6Z1NMZm9Qd3p6VG5WWmlBdz09?=
X-Exchange-RoutingPolicyChecked:
	khAW7DZgraMZP22X+LX1nps0a2438RT9GSNDdDSMUIKG4UlSe02G+uAC5dFXFS2Yl9V0cfmW0mq6+AIFzkUwRKyBFW9MweKvMaTYDjNTtUtrd666mVixBD0AjWSSV0J/9at13ixeQh1to63gQ0LD6Ycdql6XpN1jYOE5/wubEiyVpqajuTtyknBRJG9S0Sn6QUiMzfEgwUQuPBnyqErshJsdTGLBjc8aBoGlvSZ6XoJvkQEWDilbfKqJFzVEe6+nAP3hNSp3f8RJFX9bCsuJUlOFTiuskClVHGgwbRr4tDKGy839PeaMO9ZpLJSdT5uQSAu/2ICoFJw3PxVKHc098Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd38b887-3918-49bd-9ec0-08df1aed8e8f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:12:52.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh//MEjzxRfqcqCfg380GO5tk5LSmyJnqCU7YbR9D2xwroqlhLf6emJLgWnNgT+G+zsSpovHpDgwYwXToQnkIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6393
X-Authority-Analysis: v=2.4 cv=HYuB3SE8 c=1 sm=1 tr=0 ts=6ab64927 cx=c_pps
 a=w8e6fJRD9yN2bKWo9pBaJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=jsrt3cF25jRpF2hEbf8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfXxV3uyM40F9r1
 JdjAkTnx9uB6iYG7TyhQ+Q0lhkrlsVRzY3iZzdxy+0mKzw614SENJM29NLF4HQ5zX6Yd1uZTusx
 CNBJHBquVON9LRU61WP98/K+uBEYdZ25uG9IP3GT0z05iIOjaXln
X-Proofpoint-ORIG-GUID: FtQhSIb5Q6Ljsdfwyjt6b7A-KS4n0lRE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfXwK+Fuwo3HQuW
 5Ll4s4Omuz9gWn/vPKLuozBT93zEfTV9nf3KpeY+wMXSR2nzm1cC6EPvhtECiplDP6NNesy2QSZ
 cQjjFHCOYF1nVweke3zgfoHXhCLktEyyD76UzHNE+FT+ZlJ3cQS8SscyoElHYf51THwzoSjoNUE
 LAy2vfrKNz2BQx1VbrqC9sUqm/lx7ptcjWBFnpen4soVAvC56m5wCXJ5TsDW+OqccoPwHry2RUy
 ByA9ETQaWFvTF9F3NaSi+0ZFuIPKPAUO5lLHkKu6bjP4Gg9YqdihXYLE8pdfa9WWNaqvwWe6i5W
 bna4xxtmn45nwC3Cq/OLs9lKr4cqq0ulmgt/75xpNFIihvv4s02mowSCQSDi0hdAvHhhGrXZPbi
 I+M6X9f8in5odtIdMboHtZQ57LuVPMqcmhUyYIZfJq15kdDBE7Y0GPkvEyPayIbAJ31ep2r8CR4
 QBcy56g6iDHhhO73BbQ==
X-Proofpoint-GUID: FtQhSIb5Q6Ljsdfwyjt6b7A-KS4n0lRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250040

On Fri, Sep 25, 2026 at 11:45:51AM +0200, Miquel Raynal wrote:
> On 24/09/2026 at 19:55:58 +01, Mark Brown <broonie@kernel.org> wrote:
> 
> > On Wed, Sep 23, 2026 at 02:12:11PM +0800, Fei Xie wrote:
> >
> >> The difficulty is that the hardware ACMD sequencer needs the complete
> >> multi-operation sequence to be described before it is started. For
> >> example, the SPI NAND core currently submits PAGE READ, status polling
> >> and READ CACHE as separate spi_mem_exec_op() calls. The STIG path can
> >> execute those operations individually, while the ACMD hardware combines
> >> them into one programmed sequence.
> >
> >> Would an SPI-mem operation-sequence interface be a reasonable direction
> >> to explore? The NAND core could describe the ordered operations and
> >> polling condition, and the controller could either execute the sequence
> >> in hardware or fall back to the existing individual operations. This
> >> would keep NAND-specific knowledge out of the controller driver.
> >
> > I think that makes sense, that mirrors some ideas people have had for
> > optimising SPI mesages in general - submit the sequence to the driver to
> > see if it can do it in one, falling back to just running individual
> > operations if that doesn't work.  See spi_optimize_message().
> 
> The spi-mem operation-sequence interface seems very complex to handle
> correctly IMHO. I fear such a solution would also require major rewrites
> of the core. It is always hard to make fit hardware in code bases not
> thought for them. Most of the time being spent in I/Os and wait states,
> I am wondering how much would be saved by packing the commands. Do you
> have benchmarks?

You can see my replies for a more verbose thing, but the TLDR for me was
that the gains in performance did not really payed off (vs the
complexity we would be adding). The real gains
for me came by using the nand continuous mode so that using ACMD (and
DMA) so that we can actually ready chunks > page size. Of course this works
for nand chips supporting cont mode (which hopefully newer ones all do).

As for PROGRAM and ERASE commands I really did not saw any added value.
So below is my version of this:

https://github.com/analogdevicesinc/linux/pull/3478/changes/477e6095508546552071b825a66522cf697c27c2

I pretty much treat NOR and NAND the same thing. Only when you want to
do thing like having the controller sending commands itself (or walking
pages), then knowing about the chip geometry becomes necessary.

- Nuno Sá

> 
> Thanks,
> Miquèl
