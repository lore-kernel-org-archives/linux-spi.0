Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED63B1ED7;
	Thu,  1 Oct 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857413; cv=fail; b=QKswwZ/Ii/Eq/fkKrdHUZIEqR2ZGPgXdtllafMtFr4iR67aK7VYjia5zUwNNQAny4HUNfdaCUqToj0Cj1QEUUTJZE6h9Jv5RxPhdOOMdJvT5uBSmiFVNX0i76pPV977NDb7u6xgFHnFwEEMCwHPA/YTYlsLZ5CYA/zvFucbgnuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857413; c=relaxed/simple;
	bh=xJ64vbv7xKTOxDqAHipxsDg4G8pCDmXEmmu17Ez7Ioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i6CRPvuGjIy1vSDUonb9T0cahcOoQiDEWPOMh9wcDzoKSx+2rtsKyHhhe8MoqDB8ifNZZELp+m8U3YgWWToXhYMgvYBIv8OVLv8nrQhEtz5bt2nYndl0znXWgjjmF7kmFDQ1H8YywFgAJaHUHoniSiR3EPXEJBOldxEIj+kYLDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dIRioQTd; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dIRioQTd"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691BZZEb3932446;
	Thu, 1 Oct 2026 08:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dcs0H
	0Y8NN4daFVOctUGhgQldd7qjO1moGa6MFmqp9g=; b=dIRioQTdsgb+zDKLM5w9d
	wGxUKS7oz9diePVsnP51K+gwrP4+Ibw+XP4svGzHvV20KpOYiBS5DF4S05SFI3pT
	wtjsCWoEBHOr8OGNMr8wTldi3diOhaMtuQeko+vDo4qJozggiVZEzDN+DEs0Zro+
	9O52pm/yDuQ4vI2tRJlO12IMkkJdhdxqQ96ckWDad5dOzSEnoi5JLxXel4QCqGIK
	Ss0OcqpdpE4uXUgJmR8HDyw7ezchRnI+C1UAsL2whXkoGlNJ6vit3wVab0qMX14K
	QUu6lB2+3uhNFECYhr0421bp3IbS/dBqD7p3TG+6BUv317sPDfJjhWRa1EM0o86R
	A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h1ak6b704-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 08:23:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnsnhCABlf6jpRievJQqyrjH66qrDQJYpXThfG0ijAOx+y9q/svGuGOsgb20siDW5gnW8QV93hWKyZPoPwHg7gzcTIsps3RY9Jpiqj3VkI2a+xO8JS6BN7uDKIkf/zrWEam390ZNK1/Rx2+n1rD/+TRqItvkt3tSG45ZXy4UCUvHRTCWbs/eGoixgmjW/2oav1sB3Gf2aIMGvrqVAIzNeClDJhf0qEsUQCeReu/G6bxM4YKvc49JbwBA6YUNQJpFzUzFKPx8mx02Bh6pQIt9j0JC94pJps9aS2sK3YgOOzwDcnKu/cNw8PUGmK3+FuXNnuSJFU8SZ7KsXCMIDRi3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcs0H0Y8NN4daFVOctUGhgQldd7qjO1moGa6MFmqp9g=;
 b=N6Bh57bwE2401WG9ZYgDJwPrcWTtwsszYT+0ZwaNBLBFdmOYs7PhyJkr1PuMLc+5EzMX/qOHoXTzHLxUJuF7y3rLGAJlZF9pimkLJVnND3i5bsY/+HlQgbY84KV9VTyfGT0vSYpkPFluLyfSWXecAdKFovEPYGameZTipdotircZilgIj9gY8EIgMf9GhE9STno47sIl0I8mLaW9ZQkKHf0kZuvQjrIjRyVPZJLC899/qoclvBECEImJbPXSDdxus9XtsI3jKWuSGpSacAcuit0k4Z0l5gX1CFaY71UlH4vAnD7s+ttcu8m6zzjcMHwfPA0FGvIgxs+5JyplMrZjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by IA5PR03MB989629.namprd03.prod.outlook.com (2603:10b6:208:608::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:23:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 12:23:21 +0000
Date: Thu, 1 Oct 2026 13:24:33 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        dlechner@baylibre.com, michael.hennerich@analog.com,
        jonath4nns@gmail.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v2 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
 in trigger_enable
Message-ID: <ar5QVsQs2yrPqdxI@nsa>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
 <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
 <8ba05b99-36ac-4a76-ac11-e6ad92c631d4@sirena.org.uk>
 <a1fb38b1aef69d344d31235fbb4bb55d75aaa1d4.camel@gmail.com>
 <f0b918c9-2ede-4ff6-9ccf-6b819b972f38@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0b918c9-2ede-4ff6-9ccf-6b819b972f38@sirena.org.uk>
X-ClientProxiedBy: MR1P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|IA5PR03MB989629:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9a91a3-0238-4fb4-4935-08df1fb6c860
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
 79XbZjpFPq5lPP+thSXS6tmU58Y8j/NN5yhuyKUtoNTFmiu0Ek1tL5uXCyjdsTM3oG6VYhhGo164+kabdaUYQ+txImhtSNFyLJjuElSKQQVXJsliWTlt/K+kqBqsIHNFC+9nVjBIl8CLVx6+h4QeMiFovqrpddBcqd9im1psUAmGp0U51oJeakfZfqvJsnsYUstDapNg5ILRMQT+L+PQOPh9wWUilwIsdqCirOfMu72MPXG3OPEUmwB8Hp/ryegXxmlDYlFB3oXKwX0yZ/UoCVtI8ud8WRDpw9FKROWbjCzJqmaBfyHcUKsuqABIEcbImZ7tzhmDa5sb+PpD9XPsNhZtBWJCBjJPwe0PHkwMPgpiWBTGjvEEKikijhkMPZnRD3yjuZJJ/YSiIdUgWr+ARudKXK/SN62QWuNQcCd/6EXqMHAbUw08efi6aey9zPpGX+nVPsfZgh7/xk1fS+gqItFxAk/mdh9wjfs96BTGQeDicj+ZZKWHfRXfusvtd35aLRLV5P76UFvHiKbW+SbBh6bZj+b1ovKZkYT61Ge+3qFBn14aSRb9jtHHEXpAK0Xu1IMyhYUTUJTVNF2wft8HUJSTqgsv3Uoa/FT83v0S5+FqhzxgDdvlHBzc2/Z2r9C1WAXbf2UKQJhPaq170/pTTCuAAhIuqXNSlYwvR+S2aIw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?eEFzYjhwdDhpZWhjTGlrb3pxNThxK3crMkhJOFlLUitEZi9aVFYrd3ppNjlt?=
 =?utf-8?B?S0NKYVcrczA4TUtrMVMyVzYxbVc5c0I2dzQ4WExieXdOZk5rY1VJM29DY21Y?=
 =?utf-8?B?WEVEcVE3ak1RQ3gyOFZpcFFBSkNvbmgzbnNiSkJHZExGNXF0NFFoVnZYUll2?=
 =?utf-8?B?dU4vYnR5eU5JK1FGcG5ST3lWNkxQdFg1anFrTHBHeHpjcXV0OVJHViswTHgy?=
 =?utf-8?B?TXFKRXh3YVJGVlNrL0tEV3FUcDExaGxWd1F1QUhjM2p6eDhiNVhJVmd5RzhQ?=
 =?utf-8?B?MUdYeFFYWE1pSEw0Z200Ky9OV3VjZzVRS09VYmxidUJ2QzBFaW5GZXQrRG9Q?=
 =?utf-8?B?VS9NSUFDdklOeGxnVjZKandoTHBHdExSODJra2xEblFRK2lidFl1M2JFdzVp?=
 =?utf-8?B?djRSU3VkSTk5Z256WE91dzRwNHEyUEFGbXl1UGxoNlE2UnQ0MElVTUk1VE5h?=
 =?utf-8?B?bnBCUThYTXloalplNS9WNVpyR0Rla0V6WTZselpTVHZyclY3YXV5V3pIQ2xE?=
 =?utf-8?B?dFU2OStibmJDbjNodjZ4WUJBOHhXNFRpaExMem9jRXRCOXlWZDZXaFJpZXlj?=
 =?utf-8?B?Zlh6T1NmYmtCT0QyamFuMlQwdWFDclJPdTdLZTdNY3FQTWVoZFU3U2hVV2RY?=
 =?utf-8?B?NUgvMFpQM1BMMWh5RXREUS85amVNSXJCOVN5RGtIYktRRWxZZlkvVEt3Qjd1?=
 =?utf-8?B?YS95RWp4SGV1N2loUmFuK2t5Q3VzWVRrYUpvQWRteWFLUnQzWFAybHlXMjg5?=
 =?utf-8?B?WXF1K2pZUTV0V2hBOXdDaW9zNDdtS21MMFBFYWZjcjRYMkFQVU16WE1wZjNL?=
 =?utf-8?B?cUphU0kxM2M5dERlWlpweGk1ZE45R2RzcExHNUFMTm1xWUJ2b3l4cloxcnFs?=
 =?utf-8?B?L0JuRGhZcC91LzNlMmxndUZlVWdSWXd5SWlwOGE3L21uS3BjQkdBc1F2azRa?=
 =?utf-8?B?a3MyTFgrNERsQmdMVXJ3b1Fncm53dGhJaWlYTFQwY2RiMGhnZGR6a0RpRmVZ?=
 =?utf-8?B?TVY1MVNwU0NMM1FQTjE3c3lNU25QNkVYQnlQVlVFQ3JuZS9qQ1FFMnZvbVZs?=
 =?utf-8?B?b2RzYTc2bDFTNmRrdnVJVUY3RVRWV28rb2g4ek1oWnZmd0p5ejhFYlE5MSt1?=
 =?utf-8?B?M0dDUWJPYnlYSFJHNWpmanNZRFhndmt4S09aYzI1eFVibndERFkwVVAvajNi?=
 =?utf-8?B?K3R0ZmlMNFdjb0p5OVpkTWc2L2pIK0JkMXBCQUNueFFMVUp5THlUUzd0N2FP?=
 =?utf-8?B?TXEzR0JZcWh4R0FVc1cyMnBpSlpnaG4xK0ZvVmxUNGNTbkNNeUtsNHYxYlJV?=
 =?utf-8?B?RmVXQ3BLbGFYbW9ySWxnMWFodENhcUhVMEZEWS9URy82d21MN3ZkNjAzdVZx?=
 =?utf-8?B?V2s5UTIyUHFETUlFakFsalQvVnpxZmhFLzBMSkdBYTdaQmRtNzNUcXQ2TG9q?=
 =?utf-8?B?VzVXVEhMVllqWFk2NEhJd25UUStnN2xXR2NkUVNuUzVSbytqZWV4SUtIczd1?=
 =?utf-8?B?UTY1QTlMOHpnL3JmREg2b0QzYzJvcTlmWXFtN0ViWVZmazBCekg4VnBEWE5M?=
 =?utf-8?B?TG5RRzVKWWlIV0NDYlJTVEtBVFQrMm1ybzZIQ2QxbnNMRzFYS2NvdXV5VFdy?=
 =?utf-8?B?NEdFRDEra0JZL3AzMHNnS2cyM3h3ODk1WDlnR1VlakJSK3loU3lHNXR5MmZp?=
 =?utf-8?B?dTd1Sk84THJMUmt2OVVBQ0hVaGlzU202T1dzbmJvMVFHb0FZRmV1dzJ3dk1y?=
 =?utf-8?B?dEx3bUR2RGV1ckxlNVd1Z2lDUWxaWnBOYXQ2Z0txdTFKZmFtZkRrY04zSFl1?=
 =?utf-8?B?Z1ZrYU1LMktHODFEMFFRaGpmRW9iZTYwdGlqWXlPb3FXTzg1TjFPUXRXV0VQ?=
 =?utf-8?B?OVBZTzBaY1F3MWlIRysvY3c3MVM5Snc3MzBDUm1mK1JLWUcxR1FxZjIrTWtD?=
 =?utf-8?B?N0RjT01vVFZjaVp3ZUtWSHZIZDZNcE1XNlRTaXh1c0dJNzJXVUttbW01Z1BG?=
 =?utf-8?B?Ynh0TDVCdmh0N2tZdXFwbldNdmlnRUx1M0xJaUQ5b1lTRm5WaUNRZlBFODJh?=
 =?utf-8?B?Y3VPWkdBcDBFdEI4dXVvSnl1RDluQ09QL1VLU3pqOXlHU2FiNVlhbVBzbytv?=
 =?utf-8?B?Uk1USHdIWkxuekExZXVvY2NYc2s5blo5MXduRVBic3Z6SkpoODlCUW4vU2pN?=
 =?utf-8?B?VTRmSVF5TEZCS2gvVFpwWEtRNzNnTStOTE10UjlBbVFsZVNKeVd0R2NpRGtY?=
 =?utf-8?B?MmF4VE12ODM4OUlOMk1zZmtWaVJZZjhjL3BOdXNJd1ZCWnBFYzdPZ2RYL2Zl?=
 =?utf-8?B?Y1R1NjhpREtvb3BhTTU5TGVGVHZSeHFBbm1xb0tGVGpVZkVkLyt1Zz09?=
X-Exchange-RoutingPolicyChecked:
	ziqhLr+d2LBFbQ6kpFf45xuhh+GV5gUiw6Bhp3TvuHU4Xna5zU91fQOYAfySfbfLt/imjyWH51L4Loi6495dMZ5cO72U761X7G9WS+kjuYJ+eRfgyrVFIJnurADQeiOBVSReM4NZy4E12Cz+dyE2b5BHwzQbnKTFlWwALsQmoaNvu6jaJwKGB1ATxuBoX+UI6bFPlFvDeA83C0ZmQJtSbYOQKa1B+zc9aImP0Qew2CzdCoZ+Lvup5CKj7dXCZErTIRo5D4eOSwNguS4NKbnmSau0fp9pOm/g/WWpEAzZps02rOt4NUAqHl7X9nQzmAr11PqUJRxeKsBRjhpPbWMFyA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9a91a3-0238-4fb4-4935-08df1fb6c860
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:23:21.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBMVsNGMQA6pDBf6afUknMHx05QlRca2K0e6LigwACApChK/+1VhK63IfJCITSAauD/0x11WSHgbmePiIEiVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989629
X-Authority-Analysis: v=2.4 cv=T5AZ3PKQ c=1 sm=1 tr=0 ts=6abe50be cx=c_pps
 a=/NeaHkXls/iJsjBnUIdqww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=1dN2G3bv9VznaFRuthEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y6tZ_Rqb2IETHxk-IPtblk6kI6r0qlfr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0OSBTYWx0ZWRfX/fVEhalgrYlZ
 ZNi/DTprH+l/crMqCOVp+4u8c9dFIu3dCqyQKuGdes0nwWkMtbd2waQC5laaQtr9daJEWiLwbUO
 3sQoz5uG0VJ1qIDJbSiykxBcvRrh1iVMsS/5o20G58qvClLOeQuK
X-Proofpoint-GUID: y6tZ_Rqb2IETHxk-IPtblk6kI6r0qlfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0OSBTYWx0ZWRfX9L8gJWzC9B4C
 jQKw9omE4fe8c3yBhwNlPAcXJoMzfkFb69mxYtWCUrL06sryoS+EP/k1X0uKKrM0lCuUa6h0zWM
 0dinixvy1oeqBzjSf/YF3z3KNC1RdaAJ3olLVmefTAID5ZY1uV57n6Y9Tbt7QPUkw0tgMupIm20
 VTf2HBC4MLkPEm0mc8cbO4TqlX++0w+Lgz5uPdFBWk5TiaOhaEkZSDZQDhqN4suRFbeiPYg86No
 aQbCGxWCPU48qDMKjaQu1D7IB6Ju/YXRL0tPM/MFKqGmX0HEjAVQGTUiS+tYxz7LiULjETcqnF+
 qI6nr4Z8siYI5/E7bDpzdkR7s2AgfNQe9UeK/kBzmVsBCHgMJHRz22p8RqYm+F7wUbwH+Ic1Je/
 SKQ0dUTsAm4PsNaiyFrHB8UXh9PYe2I1GDQt3bIECr3SHGSZc8xwnqQWogGGZlbnjq3WHrf4ZbA
 47ofQStbWjbo0jXu58g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010049

On Thu, Oct 01, 2026 at 12:58:52PM +0100, Mark Brown wrote:
> On Thu, Oct 01, 2026 at 07:55:45AM +0100, Nuno Sá wrote:
> > On Wed, 2026-09-30 at 14:09 +0100, Mark Brown wrote:
> 
> > > I'm not seeing anything here for the issue with ensuring posted writes
> > > are completed before we drop the lock?  The write may not be visible on
> > > enother CPU, we need a read from the controller or something.
> 
> > Just for my understanding, why would it be an issue? The trigger register seems to
> > only be accessible from the trigger callbacks which are protected by a lock where we
> > have implied barriers. Im sure I'm missing what can go wrong here :)
> 
> Are you sure that's true for mutexes?  I thought they only covered
> memory, not device stuff, but ICBW.

Oh right, likely not a full barrier

- Nuno Sá



