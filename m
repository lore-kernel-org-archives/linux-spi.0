Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795027050;
	b=ceU0DK/YQ23dC9HKgB3d2ApJnIB8K6lLKkIkH60Z+WbN/8yW+DTBYvaHxQSixMVyEfq1
	 5zYEpP+6G6IGH3q7JXsJsgXEa6wOuiIXl90+HTLoEopx5u1vcnkoOwtqz2tlBvzB8ckIL
	 xXupMntHkAII4wuNIdcz0pu90SW9S6Elj0cu0wZYy0ugD/QfLHdW3m3deNIjWTBIHOSFV
	 AFLjb7M2gyp1RKaLJjBVkyIwXd5YQqsTkypsZIvwyKTMSCSfZbYMHMCpAJOwknwuU/O8p
	 mRZk3CaDFegy3oXCJ9ZxrntuX1tocBt71RFpJlAHX8OkNLWDN3nxRPgz/IUuVKhH0Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027050;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wKgFGck7J6Vixl2hYumkVASvZivhzBNR2xbVF5IDOY8=;
	b=WOHbwh8ZAMeqDiOWUIa113GWv26CK/1Oetf/eXHkTdeQSzIDVrrG3qH1/1qyL7ZjBXC3
	 w4tEBLXKFeLS6wYPgMsSwgmCsBNjmFpjYPa2Ceje6eGWpo9cVLJBeQhBQ9lFEYl7x6Jn0
	 +Efox5DEutzaBCfz22UcIcoput3g38GRurjPsCM3y2xnU5haWE1EQyjdP2vwKDLmKpcTz
	 eu5HB0pxbFM3rGAo2fu0zREK8GUPyZ8ukB6I0T70kksrI8gTrWVKrdRfXSB1iYu1JS7FD
	 KT5kEDWSKFSon2y/zK4mhmcudh1wRJmCWR2CGZok9l9eP8hpeTpUOw/A1e1qo6/NeTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iopsys.eu;
	spf=pass smtp.mailfrom=genexis.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=4T411Hc1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.132
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022132.outbound.protection.outlook.com [52.101.66.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CD606A332;
	Wed, 18 Nov 2026 18:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6CD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=4T411Hc1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D89D3CuijOw3iflMS7YCgJz/MbMdNGTSDl1Y3VaRUC7DFUfL+fTAvajz1Mw9NyojHRWkIOgH8gAnd8HSaDLKmJb/SK3+WFkMyC1J5F4bq66ljBSaUXxL3LIOwIk5g7JOsq9IkTIa5cFdpRIgluJfWEgHHY3FzHQo8n/pBRH/iwARNndgg4qgMpqLtke6C7ixOXBl5QL0mQFft1y8/ILD9ETUq31ydA61NyXmubw5OS8tAmQkuSzZEdyldE2OG9RCcftE+IrCTefHJ/4LPulALwB9fL7vQ4Xh8t4utVHzs09oKaQ3uz8dS2AfYehlaXU/FPgdxYKwfhGOn1N71w2C8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKgFGck7J6Vixl2hYumkVASvZivhzBNR2xbVF5IDOY8=;
 b=ZTCoFbNlS1HdKOL+p0inG758sYIccP3CjNTQdpbvuvHUiDodOFNH5SvfnjAWThv0+QF86Z2Z+tL67DGKcPjwRmdOmBFkRQCP3OUy2cRWJ+2RSECLXV+w5LX1BxvspRtRyk1C+daAvSl+l3vT8GgxKL93yUtvLFuzmjGY/rnU8zm8tbtNvLWz6NDrOTWxJZj3Djh+8KXfCshxSdG2yoZjSYQFg2Dl40HHQ5ViqafVhPROTHnhNcoxob+3gDpjoG7k8swHBoiQnnLgRGfcHAr63UQIdHu5SlMDAP6UQCyiaSlWCAZc9fbWZzmMuylV/xk9G4tvEfu+AwmGdy4o1PAgsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKgFGck7J6Vixl2hYumkVASvZivhzBNR2xbVF5IDOY8=;
 b=4T411Hc1agCOvx5xWTdS1LT2nSaJN9t7faSRhWLp0v/no8W6TNCwdgQK/k3/nELqJXcZ4ZaJ+fq74hVol5bQBs4RI9xaNhe3K+m/26OPXCmBmkLIG8W+zcImzl94OpZ0NDwKNX1TW3OXZ/eS8+gWcbYnS3grIVBd2uyrMIHbHkoK3FiLlOaiMH/WAJ4MJ1z8u8hNwuHaeQgAFdWDlBF6fodP2Ot3qczW79ANf1/Uv/LDugcYQ4TAZOojhJUD+15dray6Hsu7RLKyKnBeRqtIJQRrEREZ7laieICevRidVBO6q6D+LIWj7DLRZ6lMfIc1x6TLqPWQqhV1Ayl7kuB0og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAXPR08MB6334.eurprd08.prod.outlook.com (2603:10a6:102:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:37:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:37:25 +0000
Message-ID: <37fc133b-a5f3-4b4d-ba2a-002239bbcebc@iopsys.eu>
Date: Wed, 18 Nov 2026 21:37:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: airoha: Explicitly prevent continuous reads
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-winbond-upstreaming-airoha-cont-read-v1-1-acc0b6410868@bootlin.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20261118-winbond-upstreaming-airoha-cont-read-v1-1-acc0b6410868@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF000480F2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::430) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAXPR08MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d3b9ff-705f-43b7-67b6-08df45a2fd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|261028144727099003|56012099006|11063799006|261026140227099003|261102123227099003|261026121527099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	AWBRWJoUGJdZYQQiYc4pVOyLMTv4Uu3xNz3LV7B+ODwKlMmcJiPqBGVcE/m+eeeucKaHXh37Zio/+VPFI1Q25sKSlJogVdwqAdBjkJ2UbfmP6M0lMWSXs6KiUTo+cTqAyIqqmaZI6h2+a9UJtCfZRXdszuq0K1mhxVQAfzS4VYNuttWykRAhKKj0tlMI+pXhHOiZJJHav7pWlU8xaevMGrFIiZCWHZKHewcF6kUB9u6+tRTOYrs2L7mLfyqRLzu8mGlMQJtMn8/BniT3R4nFzwwo7CYjnYsyhmE8jHsr0TlBbhreB7Ju4j4fkaZJeAk3mJRrPQqB842u/MBlbY5JuEnlhr/0b9XKPxjrpbgy40KCavrfnaHQm2k86Yo2NeR1HNU/eV8ZfqFMuWiXOrpUNCmnoGpWoQZBp3oOrh6DbVmpglOwXTq0gFjFOQ7VpjI31DNOo5/T5ITHslWapdJ8Jzj1tbctP0LyuErp6OV0W/FybDH+Lc91i1nP9/JKZHzTfX/6618NKF8SOT5ejtQVZt4Xe1xcMKsQ7ap6kuzovPRngwW5AeDIShWj3bmfpn9Fv4WDR53LGStkfGHo/kHYS8HlCsdLR/P2ChY5ToZTil0vU9gDmclHd2m6s3TYrt7vH8ETjBURRmmKrqYPIrrHwCoE/l+09XmqqTJhULY117c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR08MB10037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(261028144727099003)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTR2S2JFUUY0M01VSUdDL09GWlFVL0FaWjdxa0N3Y2U0WGFFMVp5alJBcFY4?=
 =?utf-8?B?Zll5MUFUZ1dyUUVSN2FYVE5kaDdJNEp6dHB5WSsyQVdPMHpIeWhiWlA0NVNu?=
 =?utf-8?B?R2FPN2d6dnBYZVFNQ0sySTREQ2lsa1VFNmdDb1hrVEoydXBWMW9DempzRDdQ?=
 =?utf-8?B?Q2g5eWc1a3IwUGRpTllaZVBtYUpPTXdNNUZLNGtZQmFSRTNsaTBvc0g0bjhu?=
 =?utf-8?B?K0JLSSs2WC9hck01L3A3blpTMjV1YXl3cXRsaUl1Q2tWUmdwMVVJVWpBVG04?=
 =?utf-8?B?RmZGQVRBVW9lWnorR2RjeHdUSm5abGhlT3ljeFg1SDJBTVlGV1ZyRXdFeHN4?=
 =?utf-8?B?VEZJTldSSGt1dHJSUHdlU3E5b0tCQ3lCUzI5UCtLOHVmT29XMTkxWHI0dkd3?=
 =?utf-8?B?d282bm55Z1dQT1c0RE1KSEJZaGVvdE5BdWpsQTlvcGFpVklnWk1QaWFveXRX?=
 =?utf-8?B?REFXRC9YWmdiU05CMExldnRYWUFzUWpJdU1Rd1U2YUpDVEc2aUZWVElVOEtn?=
 =?utf-8?B?UGxINmZXNjJ5Q3U1VzNjRWNiajRGY3dUL3Z6V0pyNDJpNEpPSU9rcm1BdS9C?=
 =?utf-8?B?SzlCUHJPenBGQmNjVXlLZTQwb0taL3hxNVpBajhtc3RpRFBhcElYaGhtQ295?=
 =?utf-8?B?ekIxdlNYVDNlOFRrZVlKSCtwcXJWaEJ0THVudlRhdVpWcWhDV0M5b01hWUJq?=
 =?utf-8?B?NlpnQ082d2RQK1ZHL1lSWUlmY2lGUm5GbFEyRWlXTUlGQW9aRzNrQ2cvR0FJ?=
 =?utf-8?B?SDk4Zk9KUG1YMnNNU0lDWkJHenJSa0M4cnRZVUVDREd2d3FGTHJMSkpBdGtM?=
 =?utf-8?B?UHhPc0paZUYxeEh4WGsrSDhDWWNVc25STld2azNoRjlOeTJMeGVGS0hWTXhQ?=
 =?utf-8?B?cWEyMFNmUnBNTlMvOFpEbVc2VThOM3NydEZuQlJJWm5NRVY2Rzl5MnVpc0o4?=
 =?utf-8?B?elhsTDBUQk5OZ0JhTzBaVWlqamlVWTAxSkRrM29oWVZlWmdvSGk5VW1BNEY1?=
 =?utf-8?B?bGNZNkhZRFZTSjRJTTB1ZG02WFBad01JcTN5cDV3S2tiYkJSZlFtdG9BKzhj?=
 =?utf-8?B?OFQzSkoyTHJSWE1EQzFoNE1aZ01CbmNsZTRQWXZ1VDNsTDdXcFZ0T3dqbTFW?=
 =?utf-8?B?SnZldU04SFNNYjhUSDVpOURLMm1PUnhXQWNLek5qRktTNFB6a2lXOU0wdENs?=
 =?utf-8?B?ZmJ6UENqaHVEMlI1Tml2Wjcxa0xmY0NLVXVjVzFDS3NVVjl0QmJYYi9NaTRN?=
 =?utf-8?B?V1oxMEFDd2ZsbUpZc1RaUzdCQkJJNWs5aE9Rc3dGL3NMZ1VKQWViZmtsVUZs?=
 =?utf-8?B?YVNnUDhCU1FCMkFIWFBMaVNVelI0bFF0cmFRaExKL1ZMYjlGTXdpcnpCTFc5?=
 =?utf-8?B?RE9LTHFYRWpkT1cwRGNReXJsSHRjMkNyTUh6MU5vNEtaeEdIMXB4a0RoSjBC?=
 =?utf-8?B?YTYvbEQxcW9ra1lFcUZ2Z2tpczd4bkMrdWorelRNV1Z3S0ZhN1NXMUFDZWVL?=
 =?utf-8?B?V1ZlQXJ6K0Q1dm1xQVNkU0VXZlJEc2syYlBIVlV3azJtNDh4Zm8vTXk2K2h1?=
 =?utf-8?B?dDZyVkFFS3RiNTdMV1dhSUtKeXFmUjhOUWE1S01PRjFxeUVSYXFlbE53aFQy?=
 =?utf-8?B?TUR5cDdUK0FPTWYrMDdVaUtKSWtObStJaWxJeGYvaTFkSElhSG5vZkVLSFJK?=
 =?utf-8?B?LytudGhHQS9NVnNZM2JITElOdVNGWDlleWtnZVdqNGova1NObDlZMi93M3lE?=
 =?utf-8?B?UU52a2QwRDIvWUxGaFpSSTFhTkVxU3JZY3NmMU9KajgrWlFtRzBndjJUR1lk?=
 =?utf-8?B?ZkkrazBwVlBTZHhBcUxsUGlMRkZ3eTFzSk45Ryt3RDZHUXJHYmFhNUlLdnhk?=
 =?utf-8?B?N0U4enQ3RWFNa0lqZjFXbW5hdExwckMzTHkwZlkxSEtDUWVycWlpYVQwQWNx?=
 =?utf-8?B?eUxzTStEWHZ0dmxDbG5udkN2VU5NTFBXNzdDckJhRVArL0R1ZFQ2ZlpQUEE3?=
 =?utf-8?B?WkJXT3hsdmYxN0w4TTZUenMxdzJtOWV1U1NQVXhFRU9JZ2IwTXUvTUgybU9D?=
 =?utf-8?B?dC9teSswZkNvN0dnMHVadWNiWERTd3I0YzV4R2FmblBGeW5jZ0xEdjR3VlVE?=
 =?utf-8?B?ZVFvSGRJRDlGNWdJRjZkUWo5UGVRWmYxMWJvWjJPRC9yUUVtZ2xNUGtTb2dt?=
 =?utf-8?B?WXJUZUEzRmpaeFNHMXJjV29QUXpPNHQwdGxiZkhuT1NPRlhnVTdhaGhORXIw?=
 =?utf-8?B?aDlWQXI2Z2N4MnNvTFpuOHM0UGlMN01GNVA0azV3TW13YXc2NXJJbjFBYTky?=
 =?utf-8?B?cHFwcFd4T1RlV1pyUkw3SHRmSDNPejdoVFB2S3oyWDQxOHA0bXZ6Z2xrMmdF?=
 =?utf-8?Q?kTRRMrBMzZ1wJyNU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3b9ff-705f-43b7-67b6-08df45a2fd65
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:37:25.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho/aYxhcqY9ZguChdL44i/vXNB2j8FAjbSBjLPlfA2tZdSkBySta0re316KjWcSi139ytBH0+z/FeAY0y/KgHAXDXandnaKkB60HPoWYAIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6334

Hello Miquel,

I think the patch is bad for the following reasons:
* As I know there is no CS issue with Airoha controller. It works properly.
* Airoha controller supports large reads (but only in PIO  mode). Thus
  continuous reading may work properly. Unfortunately PIO reading several
  times slower than DMA reading.
* DMA reading is much faster, but can't be used for continuous reading.
  Maximum transfer size is 8191 bytes.

Thus for new Airoha controllers (en7523, an7581 and newer) it's better do
not use continuous reading and read pages using DMA. Old controllers (like
en7512) does not support DMA, so they can benefit from continuous mode
reading.

On 11/18/26 16:59, Miquel Raynal wrote:
> The SPI NAND core currently treats the lack of "large reads" as an
> indication that continuous reads might not be properly supported, but
> this is fragile and might evolve. The real problem with the Airoha
> controller is that it lacks full control over its CS, which may be
> spuriously deasserted. We now have a flag for this, so set it and make
> it clear that this controller is not suitable for continuous reading, at
> least with chips processing a CS deassertion as an end of read
> condition.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/spi/spi-airoha-snfi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
> index 95bfde7c8e7f..1070d4697fcb 100644
> --- a/drivers/spi/spi-airoha-snfi.c
> +++ b/drivers/spi/spi-airoha-snfi.c
> @@ -1018,6 +1018,10 @@ static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
>  	.exec_op = airoha_snand_exec_op,
>  };
>  
> +static const struct spi_controller_mem_caps airoha_snand_mem_caps = {
> +	.no_cs_assertion = true,
> +};
> +
>  static int airoha_snand_setup(struct spi_device *spi)
>  {
>  	struct airoha_snand_ctrl *as_ctrl;
> @@ -1121,6 +1125,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
>  	ctrl->num_chipselect = 2;
>  	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
>  				   : &airoha_snand_nodma_mem_ops;
> +	ctrl->mem_caps = &airoha_snand_mem_caps;
>  	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
>  	ctrl->mode_bits = SPI_RX_DUAL;
>  	ctrl->setup = airoha_snand_setup;
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261118-winbond-upstreaming-airoha-cont-read-1332872b972c
>
> Best regards,
