Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6442252E;
	Fri, 25 Sep 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335890; cv=fail; b=Sg7RoPNM1fvr4aV0LkXXcHYVTXv2qgb7IuW7wcSgiODTjpfe42smpitMM4iWj3SfKV+UyHKkpafLGyP7Eye5hR3VC3cSixmXiF7+MYq3V2TPF3ROLZ5w28b5CMNDQN4qd20HRUnjRHJwJoM8y0RAKY51F7ATFTD/doB0sIH0vJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335890; c=relaxed/simple;
	bh=d2AEmJ0rPlKI+JvSe7mNABiPGfBb/sM188b3zI4rEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cJq9HQR/7UPbLU0BercpmM0Wrpg9yEbkQAS3HS659LRFQ2ZI+3e3V/UAy+78wzNtdp4HYpfVs5qLsaARiB3V72GdNUVKkt4kP3BQqIcd0CsekWYCqwNVcRVgE8RgGSV0AFs3OGTJeHzrok6oKY0MAKQnTc7p9EuJlztbwyhd/wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zivJpOQF; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zivJpOQF"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9f0wO3695836;
	Fri, 25 Sep 2026 07:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SvzAk
	lZ4sf2/EA2Zvi9Q67I6hqCRCD+Bm0SFfAIlSGk=; b=zivJpOQFHuI0YtjKgLkVG
	MJpnxr3h9YOfqIKDXBBLm/7tPpf1nzvlVuLTDeFIocEgkBhqvkN1Aw5UKfFDAQDM
	43qa5CuWKx2LVn3lhT7dzle4xAPc5O55CqDd6TialoAwuxLE0SbhDBXWCVcQUPxb
	N1vyo3JBvTs6TrBTioijChdLu8PBbdJ77yhJ25SIfTEi6zHGO7YMQHSQMqc2WksL
	3mqpJcoSje+gJUMHwX5Q1lq1wzN15ZTwkmDQzYNTUaCrU/2B2CUoE6NydbFnmz7g
	rXhBJX0zDWtBSZ6fd+bYFinLDdQjwo80r4GrX5jQbX0T9H8/4/+bHeaebo3ee77p
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gwarjkbrw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 07:30:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyAqAf+Uwd0nwCxmLQaCaG8Z5rzwrqemrLiTxUz6ccNg4C5ydmLi3GXEyuOI7mGhAbPRgh/UcoAIVDzKlU6j/zeO7EYq35BGEyx1qpT8tYJD8bIdOMDnpd2/ggOOsR3/uO8S2GzLDbqE2I+NFbLOd8vL8Nj7CUv+DcbRFwR9Ai82bljKBwzZ95S2XN67P0mC7zGzGDxeRkEDH4hKzEsCpvGcbTLhCL0bPWk3kACQEqfxgeNcUAuA6seX3ppuBIj2SVkxs+OrIJgfDbWChs7O0yAjSNYmcYaduEjCCxhzJZjkWxNCytFsO9772hre/AJ2L5q48cCRWluOvli0UBXU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvzAklZ4sf2/EA2Zvi9Q67I6hqCRCD+Bm0SFfAIlSGk=;
 b=cQR6hDJf4Q6fNA2XBSdAYhci4GSTOn0MZNnwsMFTdVwPBJ+sIZ96yr3z9H9iP4KAdyhhAv4daxFf8KcSsCwQd5YDQ2O/XgMIMh8eQTOaCz/ADf7dwymuK7J+bvJam9XgeMM1eUteRJ03vJXX31oI8T8dRAqmBjxlCYKAFBAnwyyxRMp6pljN3QB+6sPFxians/MwxGH4m0a6u2auJVtWtWfsvDwNuKxRxTFQMsdQEkDwu/giIWvZ2mrG9EuidN+iDfcPJu9bjIcpwDA/nhaCQ0mAlcEBTBAL4Q5xWsAOCo6dSmTMq/Y+3q6SpZBRIKl7WHf/c3FgMcADGbSe5nOBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB989281.namprd03.prod.outlook.com (2603:10b6:510:3bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 11:30:40 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 11:30:40 +0000
Date: Fri, 25 Sep 2026 12:31:57 +0100
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
Message-ID: <arZbZiSTIRT3sxQ2@nsa>
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
 <20260921093701.1341766-3-fei.xie@horizon.auto>
 <arFEjzkHGMbecWWV@sirena.co.uk>
 <20260923061211.1608907-1-fei.xie@horizon.auto>
 <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
 <87pky1ll4g.fsf@bootlin.com>
 <arZHjbzUEFhydnHt@nsa>
 <87ecehljdy.fsf@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecehljdy.fsf@bootlin.com>
X-ClientProxiedBy: MR1P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::7) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB989281:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c0c245-bcaa-44ef-73c6-08df1af86d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	piYwzEyhnV8U8yKHQV7i6lys9d5IE53g2nu/TJhMx56pZphMtVUkRVpOGoHgafjlEfZ5MahaQMzs7KWH8bca0onsmDzwxhEMkaRNoALXO0B92pohZQkhg5dquLfs3Uzf6QG4AWeMuQryJMPQNig2vJ/M1NUHEZyz7T+icJgrvB12+9Rm1hGThE9HPQ/OEVs29qUVnT+KpB8TooHhTzqUkrwJ9haOEeK0lZXbBfpfF5Ui21lKgfado+VdwhtSprvO+rYP0Bf9o7xI0HUYPjBx2RQOfmkXx7zXGYea3pUQwd5QS2oExzPc+tODQxYXRlTfwMYeb4rXr+vrbA0F6IM4b9JBu3sncU5evc8r29UuHNrLjTHWVxybkxO/syWEYEIBh0Bbx3y4K/WF/6H30w4f2PxJ/sBnSyE4UuKuRg3JoUH7E8n/LBSo+TshmqibvNRj3400AFWkMLkJgxSFnyoVzIZDXDUmBWYYbDWnalaYKKKRHQK8+s6fI9AcSzfmaeRP25Hmm2IpnA0fCYSdrRkC2qoQSWma1McIPKkzO+TeTFkJi0d7BzmmJG5DNB1drFGhQkx18fgrZ6txBZOoPETkCsQJhoIQRa+3U44Af1SE9sVWV9cSnawV8gJ/pfvHldK2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJOZUNHejJoTk5vY0o5R1V5eUY2a28rbEZlZ3E1RHpvRGoxeW5LV2ZnK3d4?=
 =?utf-8?B?Vnc5a2FoQW5WS3AvSGhiYk5SdWU0cEVLZWpYK1JQN05BSnU2RmFwNlpjbVRk?=
 =?utf-8?B?dHFhanBhMTZOMVVrZWZuRS9yMDRQWS8vTlJDbVQrMktxZnZObFBNaVMrSTlh?=
 =?utf-8?B?enRvN2pONmlSRlhUS3FuVjF1TWhBY1E1UE9uTndPL1A0ZHlxejM3RW1MeFJj?=
 =?utf-8?B?aTRVcG5IMTVJTS8yem5obFNFR25nZEJCdTM5ZW9XQjZUZHJTOSsyNzVnQVZC?=
 =?utf-8?B?dmY0NTd1SER6cHVINHdxQjQ2K1YrbnpSdjc3bDdPTzhwMlB0UUc4RElzd1hL?=
 =?utf-8?B?MEkyMEowQU1yb0puWjYyRlZBREc4bThFNlE1MEpXbU5mbkFNT0VuY2RrWWMr?=
 =?utf-8?B?VmcxY0lQUElBZnJQUDVrYlVTSUU1YS9VTmxLajBpZHZpQjJKSXBXYnNXTlFQ?=
 =?utf-8?B?V3MzZEQxYzd6TmtpU3VwYjBMcXZncVNuVG5sRHJyTjhKNGJjeDJta1FFRXYy?=
 =?utf-8?B?eEtPM1gva3ZzTnhSWWtPaU1EcDdLUkkyOVlGNmx3SW9oYkFqdlZvbSs5TDdy?=
 =?utf-8?B?SmEyeWp1WlZrNitvR3JkM1ZrWWVIQnlGNlkrR3JZeDZ1bitEM3dwVUlvOUJt?=
 =?utf-8?B?ZXFtRzlzT0c1YVZMaW9qYzNmbEp5bjNsOEtpZzI1OTdPMnFmaDM5NHBWSkRt?=
 =?utf-8?B?RFBjYVo4MDVWbzhpdmppKzBmY1ZUeDR1WGFYb2lkK0ErWGtzcUMwVmpUZU1l?=
 =?utf-8?B?Yk1od2NmMGgwVnFvOFUwNnllWmpWaE1HaGFCbDNWeEpMd3AwYjBCZlI0Y2Rk?=
 =?utf-8?B?QWhFVDFGZ0lhdTB2QmVzYzE4ZG4yUkk0NzUwalUrSEdRT1RRbFpZVm1ieDBz?=
 =?utf-8?B?L0ZJVjRwR2tKbXF1OS9BcXRxRGFyU1hmSFFNT2dyWHk5aTZXbGx5bk9GR1VW?=
 =?utf-8?B?ZFp2elZ6MktZc1E1RnVmVHp0RmZlWCtmT0lVRHY0MjNWRklYZVFNb2RsVlNS?=
 =?utf-8?B?SU1KMUhGR2tiTjd0Tk00dndxTlBjUGtINndqdlFRS0ZvV3pYYi9HYThGZGkz?=
 =?utf-8?B?SVllVTJxK2cwUVYzRjdyL21uQzRDaEdiRTk4UkxKUkZWUmtoVGVraXliZjFK?=
 =?utf-8?B?S0s2ajRLcjc0RTFpUjdqZkZPUzlSbVluS1Q5bnNLajVkeUxnL2ZVem5GRDRU?=
 =?utf-8?B?UWtrSXFYeWZYMDJtSzVQVzBNM3hRNU9uQXZKZXFsSVdXNGgzMjIzVU90bkEw?=
 =?utf-8?B?S3VhUUE1NXV4NnVJeFBxbGFzNEJqcFFHSWpveUdqWDFUaEhTME5HNXdMNXlL?=
 =?utf-8?B?TGxqWEIyY0pOdXRkeE5TYVlNUCs0Qlp5UFg0NWVlQzRHZUxKdWkxcVAxcStt?=
 =?utf-8?B?d0dSaEI3cEJsbmdSelZtdVhGKzN2a291cDRHVk93UDArSjJIZ1NZRk9DcUhE?=
 =?utf-8?B?TldGS3JINlBTc2x4aGxVV3lYVUhKMWpZUktXZUNzR2RJbHlXSUNZeHN1SGhi?=
 =?utf-8?B?R0FBckJPYlpyNlpWWEZybGZlRXhUeTdHOEFBTWV4dUtZSDZKOE0rTlo5c0NP?=
 =?utf-8?B?RU9RMFAzSWhSK0xNdHVBc2xSdmNWeVBWZ2ZPZHV1QVFaWTUzUTZHVmxZeFA3?=
 =?utf-8?B?M1VzSUhuNHQvdzVRQ3BQMHpvQnNQOHc2VjdxZWFrVUliSFEvNzNSdUg5TXVp?=
 =?utf-8?B?UEdOeVd6M0xhaHh4bHoyRXpHYVprM3RzNFVpNjgwUVB2UmlBVGhoRnVHWnhT?=
 =?utf-8?B?Qll0TUZVUVoxRFo4dUFyNVJQNTgxNTJzMVBjbTBzZzAreW1Wbk1KRzd4Sk9R?=
 =?utf-8?B?TEdtNENUaVpBTVlhU3JJRHh6STlJMEc5MGJFUVEvQnpMVVhCeTdTY0RhRDNv?=
 =?utf-8?B?R1oxWFM5dGdUQlRpOHY4MkkvV2xxbHg2NW9YWXVnSWRHelBodXdKUUgzTlRN?=
 =?utf-8?B?aUhQSmpsMjJXNUoxOE9hUmpHSlVNa3dOYzJlcFBIOUQ1WEljNlNUZDExbmg0?=
 =?utf-8?B?aEFQUmhqS0tqOGNUMHNtSDRZeVQ0WHZKWjhzcG5BK1BIOGF5QnczVUVVc0JI?=
 =?utf-8?B?QW9zUXhFd2d6NHl3S0UwR0dYMThlZkg5aTBONEw0OUJ2Vzl0MTVTZWVJaW5U?=
 =?utf-8?B?Qlc4eGJ4aENhRGpTTGxRUGJ0dmhXeHZUUGlNTVkvYWxScklYMXB5M1VsTSto?=
 =?utf-8?B?Nmx1WUQ1Zyt5ZnhseElRWS83bVo0VWh0RzdlZGZWOWNtd25XSWtRcGNXUjRX?=
 =?utf-8?B?bWdKYTVhSVE3N0xxTUF1NmVvYVlTMllDYVhhelhxSEtGdHIxR0lEd2lmb2xJ?=
 =?utf-8?B?cUU3dnhPMEFETHplbDJQQ1czTUVISVVuZXVGSC9DSVI5K01qTFB6Zz09?=
X-Exchange-RoutingPolicyChecked:
	0ODoHyTHjQw92X3FPGTOFv740HRcyD61nRbyiCc4rO9A/xr1MGiwUfwTvUwCe8LrzpcK1ZDONOtckM3IBERKtJlvVgBJRKiA1QeA/GI3GUbCSNGehSxxRCr4LUdg2HQIuLXGtc4TezuAGT1SnQMdtaI3gHVxJxIV0cygCtXXvl4SdRNaUmBgV4E4coMmmYUMmiuwOBHp5bOn8G5btXWm8miCM6TvVR47l0XECEb0mKXbKUrjLv2gUrbqaEiYrVfN/HUDJpGWOS7sKzGKVwwDUEIat1NwBDtwU6NWGn1PDt/zqz71L1lw0rFb7q5Yb832736MkQZbQWZ1z6y4brxZLg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c0c245-bcaa-44ef-73c6-08df1af86d2a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 11:30:39.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bRkYspQCCm0BrfdYRzK/NFIxWXb3YNO/YS/b/ztPiRsCSawgFY/+XCCCw0DTN0SD13jmKuAjgyMvE2ILxle4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989281
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NSBTYWx0ZWRfX3ZRWzBoNHTOJ
 cJF2+s7Dc+48WfhCvethcD91cvHzOx/kne+4Qk06DFMX2RjQDIN+MtJ+ffVifW8DhYiwB8fsYmw
 6e1Yr/6NPmLx4c9Vh9wWi2sfcFqJ4rMJZDNvMvGwLiwF2siLUtSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NSBTYWx0ZWRfX8qbb/Xj7vouU
 hMIejYvnprGxckRVR7LMFsGvYy/GvjsoGzjbP/KRnvJFDdQNuGtVIKughenPnEpQKMDidm5wZ+d
 f+26E555G6Vfh6PwkE/YCW3Hs/eFAaEWi1SWv7PwIpv4qakLZq7b3tS5Lt4iLYDzTb1XYMBJ2we
 L6Mi2OJaZYVjRs/88fVXLbiCWqldkZ3GgzAeW9QaD1YDpCoZ0/fkBziHwNyLf8iWJlD0tuARTj6
 OmRA0l3ynwdOmo/7xBiOZXCbPZZvqXXotZoqzcbl6xlVdcHlCQS2HdIuUUG/Skf9kahrWilBLWW
 /q9Ceo03XIP2o7Dajnw7zjhQ8gk6mWPE9Bln+C7yYrwnl15yVUv147eQI/hR43eiO2v4fs6EdW3
 6BxxxFRBm1F24AMsZBZu6p4CwzZYPzk5uAkzou/WWmoOEjAQXAPld96nwlYT3q6N+CAS+9AoTPf
 lK97zqiU/SQ6r8y/qxw==
X-Proofpoint-GUID: J4IpJuS6cbzInfvHQpdI_XbgY9dErHTz
X-Authority-Analysis: v=2.4 cv=Vvq2kO2n c=1 sm=1 tr=0 ts=6ab65b62 cx=c_pps
 a=G4czNpscrl+lNx4D7BJ0lA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8 a=WwV4jeUuvoBrZrMnDWUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: J4IpJuS6cbzInfvHQpdI_XbgY9dErHTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250045

On Fri, Sep 25, 2026 at 12:23:21PM +0200, Miquel Raynal wrote:
> Hello,
> 
> >> > I think that makes sense, that mirrors some ideas people have had for
> >> > optimising SPI mesages in general - submit the sequence to the driver to
> >> > see if it can do it in one, falling back to just running individual
> >> > operations if that doesn't work.  See spi_optimize_message().
> >> 
> >> The spi-mem operation-sequence interface seems very complex to handle
> >> correctly IMHO. I fear such a solution would also require major rewrites
> >> of the core. It is always hard to make fit hardware in code bases not
> >> thought for them. Most of the time being spent in I/Os and wait states,
> >> I am wondering how much would be saved by packing the commands. Do you
> >> have benchmarks?
> >
> > You can see my replies for a more verbose thing, but the TLDR for me was
> > that the gains in performance did not really payed off (vs the
> > complexity we would be adding).
> 
> That's precisely what I was expecting.
> 
> > The real gains
> > for me came by using the nand continuous mode so that using ACMD (and
> > DMA) so that we can actually ready chunks > page size. Of course this works
> > for nand chips supporting cont mode (which hopefully newer ones all do).
> 
> I am very happy to see this feature being used! It already caused quite
> a bit of churn in the core :-)

Yes, I updated my Windbond W25N08LW patch (I resend v2 recently) with
cont mode precisely for this xspi ACMD effort.

- Nuno Sá

> 
> > As for PROGRAM and ERASE commands I really did not saw any added
> > value.
> 
> Yes, most of the time is spent in the wait_ready, which is not getting
> faster with hardware automation.
> 
> > So below is my version of this:
> >
> > https://github.com/analogdevicesinc/linux/pull/3478/changes/477e6095508546552071b825a66522cf697c27c2
> >
> > I pretty much treat NOR and NAND the same thing. Only when you want to
> > do thing like having the controller sending commands itself (or walking
> > pages), then knowing about the chip geometry becomes necessary.
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
