Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF082ECE9B;
	Fri,  6 Feb 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406094; cv=fail; b=iTXw9gzGDKbvjkFjkdD5jZMWGuXdYlZ05l/9O/tpgQaTr2G223GzqKnoa9bREL3j3ErnJthw3X5LAwSit3bsPU5mjjTuowqUqoHSwZYFV15lWmjoOfoJDNN9zwsjMP3zHT7M/cDgliTZKFLWicLSetet5ZhF70bcr8MNggejSIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406094; c=relaxed/simple;
	bh=xKWOhz6y9oxY9lVP1Eye+GwHHIq5hAXVq+rmRHFruz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iHoU9AppIWwn/2mcAG3KNlGIzH20ezXdJ4SUdLhxFAw8/rcG02nfJRabtZfLEoXCjype2Achf7dEsYJ1rL8ltuJf6cOlXzrEtXgiJ4ySTCbldzz/fnjTn75NfQGOX6AnI1tCI665qS9yp+WWZQ/y4yNeXUYMc3rlaPCWxdYXoTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eAdj0OWM; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eAdj0OWM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lE2BcoPDn/KbrhxSo7fmoZYDpLbFAhiemXkAXDHV3gVvQXIK/QOiA0J0sWHHmeGAx1cQUiuDPF+dZtIhyoeHnVwD8TieLO/XY6pufWpOBfz+Mdm3pEjspMq9TCq0/zR5Pg7AI8YfaDhPU95Na8Yk2E5Z91ZPeRTV4cJbYO0+8PBW//1LfAc6pwyLcjrmC1h7C7iDZVckGe0d0ZWa9ROSR5+48R6i8H2NdrfJKTGdbzbBupoQitY9fcAzUZ1l5W4BVynS31eziKpd74eM8UzsvNVC6U8OpUf+OJt2tSd8wJVuit/i3UqfakK+PMmG/93EyRpjfNYIBDC9/nh+0BTOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY7Zymg7WCBxQ1m95nLz/OOLP2QaEvtLAGyzDcH/Gvc=;
 b=QzWspRddBp6rZ1P5OErDF/Za08luDGsUD2A43IRD1s/CEz4NKeiMuTSBE2m2miCkj80elTSceX6q/j4SCD351S+qY5uiebqifAAjL1S5W6O8o9w+OVJy45olhnLdy0GfJhsfkJR5n5LyIzbBxQFUsh2H3Qc4dbAcPAsnQ7F9Pw4y9tb2SRchvWXLZmcLuCbiDWHK6oOQlo0XKZfqLN6oAmXvHnOnri/buIZKd8tlOOB40g0TaVpeE0FXOJuPmh+Z07k0LgfpFpd6czT41P9IAmx3ER5exUsNuR/EY0JRrtODN5L92XBXmb/6mTdfDY5f8gotlG4OMwMjEzzDujG17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY7Zymg7WCBxQ1m95nLz/OOLP2QaEvtLAGyzDcH/Gvc=;
 b=eAdj0OWMMjR/yYXZhEnurabnu1xEXq/zY6q9mRZAfc/1mLNdJbNdqAvdZR8w2bjOkVS5Lw0f31YJDhRq7oZRJb0QDJGkCbsoJjtowlJYMP4ozXqrlkq1PPmkhL+wFioXI6oKi+xmCvJCvMTvYKhrk58TnckHu5ZMBqjCxcU86EA=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 19:28:11 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::d1) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Fri,
 6 Feb 2026 19:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 19:28:10 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:28:09 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 13:28:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 13:28:09 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616JS4U91840601;
	Fri, 6 Feb 2026 13:28:04 -0600
Message-ID: <775d8dce-b567-4f21-963c-a843e409fea5@ti.com>
Date: Sat, 7 Feb 2026 00:58:03 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <87343ghkek.fsf@bootlin.com> <87v7gbdwdh.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87v7gbdwdh.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|MN2PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 2746b7c8-6209-4a29-15b1-08de65b5dcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJiZDFCcFJpVituSlBmZkxNUGh6MldoYnZiN3RUWDV3QVdmRjJkTXJsZHU2?=
 =?utf-8?B?Qk9TWmVvZ1MrNjIwRU9xWWx6cHFMd01ZcnlrV3FRSjRKc1VHSEJSVWVSZjVN?=
 =?utf-8?B?Qld0OXB2K3Y5dXpsMU96ZjBDRG1zQmVOeHVXZWE3VFlmdWNEQ0JnYTJnL0JP?=
 =?utf-8?B?RVc2cU9hRnJZNkM3QUt4aDBXUmtuT21HYmEvYmJEMS9RMlBtNDlINC9BMnhw?=
 =?utf-8?B?VityKzBGdEpzelNCM29jYkgwK3BBN29tb1JndVhhODF3NDJZZlJoQnp5Y3Z0?=
 =?utf-8?B?NzQ4TjVZZ3VSTm5wSEVLcHpDRWVRWGpqa08wR2pvTTltTUduSGhocHE1VHY2?=
 =?utf-8?B?TERwZ1F4TlpQZmVzN0FhVzJVYzcvNmVnK1RjbFUxeVg1aExadjlqeEo2Y3lk?=
 =?utf-8?B?QnBUR2dmUFhXc2J6MDlZNXRKL0hrVUZTWStWREc1U0RqdXMvZVliTERQV2sv?=
 =?utf-8?B?ekszVXdySTV4R3pucHpLN0tzc25CWm9TbDg4cmVEZmRhaGlHanlFUWNDYkJH?=
 =?utf-8?B?Z2hPSE1xa3pmdFlkL1N1N05NQlVTYWtxUlRpekpFcWVLQWozZ25LcitsdWtj?=
 =?utf-8?B?VUhLYWpBRmR2MVJGRGpwR0tUQ3lBbC9nbFBnWC8wVXhGVE90Qm8vN2dXVGww?=
 =?utf-8?B?NWtmZjRjSzdhdFNMRER5SGdZSW5GemNmWUxvUzhaL0hWVkFlQ2V2MkNvelRD?=
 =?utf-8?B?eW9mOFlPeEZnZlZxdjIxWkdsMVQxWUk1SnJqeTFXNXgzY0VXbzdZTkNNVGs5?=
 =?utf-8?B?SVAxL3AvclVtdU9BUTBiRlV6K2dPNFBlNGFsN2NPMktlL1UrVFhjZ3VjQTlB?=
 =?utf-8?B?eWI4RWN4TkRkTW1DMVJFU21tMFZoVW9IUmh4bk55ZHhSTmpITDBubWxpREFS?=
 =?utf-8?B?TFBHekNQVmJyS2xBc3FWaFhzWjQydS9pQ0JXelYyVFVMT2h6dFRPQmN0bWo2?=
 =?utf-8?B?MmlMUHNFMHRUVEsrcy9pTXliQkRiMnM0UVhWVGpsV1NocVVRaVN5WjFiOWpM?=
 =?utf-8?B?dXNYckNKenJMcGlkeS9EeXloSTFtRzdVaVZnK2lhUmNnempPeTRHUXZTeHN4?=
 =?utf-8?B?amlYOUlaL3Q2bUw4NGVnbjlwMUJ2ZHdzMndvMGY3Smk5VitZVm5MQU9hVUdY?=
 =?utf-8?B?NUtBUXd4bnJFc2puVm5yVzVXNFFyQ2Z1US9BTzRkVExIQUZSSXZ2SjNHdWJ3?=
 =?utf-8?B?L1Nqa3pqeXhpUkdZbFJmMy83dVNKU2JFdm05NVhLSjE1bEFJL0NMaDFQSENJ?=
 =?utf-8?B?aGYycHhmSklmZmFUNGY0MmVSTUVDN2FESWFNa3g1anBGWUdDZHZtNmZCNWts?=
 =?utf-8?B?ZGoxRW9wVDZKWVBnL3Z0UFlGV1ovTHFSZGFZMUM0anVYaDVlbHNGNm9ScFdP?=
 =?utf-8?B?QTJtTHh3VmtvRlBZRVBSZURGNUFxbEVESjUzRXFFak5zSWJmUUFpcHA2V0VD?=
 =?utf-8?B?RXlnTnJURWhXYi9kMjZub2w4WW9aNk5qN1o4R01CcjRiWm4rS21CaWVuUVNS?=
 =?utf-8?B?VjRlbSsrN1dTSEtVWjZHNDFvdzI1QmRvSUl6N09kQVhZNWdGWjI5akdPbU1t?=
 =?utf-8?B?TDNiTndoMWsxK2ZPWUlERUpjWng0VUdLcEYxTTRzejk0S0hZeHl5SG1kUlpC?=
 =?utf-8?B?alFlU3hEVEZEVXNnbTUyQXRqWnI1WFA1aEU3ekt5T0JtWE15c21sRmh0dFV6?=
 =?utf-8?B?SE02RG1Ec2VLSXhVRlhLTFdOakFBNzlYTkl6VVY4VExuRXE0ZkZRelNadCti?=
 =?utf-8?B?K1VxQkZPSVdOdGFoUDNDdDBIZFZxWlpGYzFGU3ZyMHFOZ2FJalBCZVhnNHl0?=
 =?utf-8?B?dWprWFpzd0xwZTRLaGgxVm5NKzR3Zlo4bnBHODdhb3NjYTlpMVpjUWlacWlW?=
 =?utf-8?B?R0JGRkhnaGd2WDJIOEpEK1U0WENycHd1MlA5R1N2R2t2Tk96dGk3RzEzalNt?=
 =?utf-8?B?UmtCSmZ4WlJNbTFUQXFrK3N1N25maUQ4SS9BUjBFSUt1c1lHc1pRRnVpVmRR?=
 =?utf-8?B?LzY0OXJOaWp2bHpFMi95dVVabDVaeFgxMGpJZlBQajVjejRVdFBzZFdvU1cr?=
 =?utf-8?B?UGhRdWo2ak5ibW5TV2J1Ui9ZL2s5WUEvZkRXRWhWTUNheGlGR0k1ZDdaVEc0?=
 =?utf-8?B?N3hTNyt6R2ZoN2w4c2Ziano2aXM1N0k3NFQxaVA3TFZPeXJnWlk0eUZ3cFhT?=
 =?utf-8?B?M1c2cXVMOEFXNnNNQXNnTVdIbGRXeUlyeEdHWm90ODV5ZisyS3drVjJyRTYr?=
 =?utf-8?B?QjQ5QjV2ODRDMUl6ZWd0RVhUT1dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAmKBrYzfH4ReIFYfnuaIJIsR9dBdFYGgM6WJs7Ec+i/PuQHLSOswQhB7lwo/9XMuUBCxyzQ+BP8L3qknhxU9QaSIQ5P9w7PWYRQThecgprsBUcG2J7/2oRD1u96oeMCZOO0nMCTtYFbo0kpMl5IQcgRdfTvonXrCLa2DHFZIdttVRpXyWVeTIyL4AOJiBj3B5ygzMwxEDudII5tRvY1cobHCspApSNPKKPZGTXV402uJxgwxRji6pE3N5PKhVEAT10IQEHKEoGQnpd7s2EZDOVW/vakeOEJcuUkl+fG//tZyU95AQkkZspQKA/bVjDb8LWLcheyWn9+MRR9wb7VIGr6uTjJ8cb7Q8TWpVlDkDv45jQ0Ps+TwH6BbIpT8UjZi3bW4HHNdz1Bzby3wQbahgxyfzjbqCo01qoR5K88Ydxeba9ezAGWxmJu/GONdqXj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:28:10.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2746b7c8-6209-4a29-15b1-08de65b5dcf0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125



On 05/02/26 21:18, Miquel Raynal wrote:
> Hi Santhosh,
> 
>> I am surprised by these numbers, I would expect these to get higher for
>> SPI NANDs. I will test the series and report my observations, especially
>> since there is also ODDR SPI NAND support now (in nand/next, should be
>> part of my upcoming merge request to Linus for 6.19+1);
> 
> I just tested the series, here are some numbers I grabbed on TI AM62A7
> LP SK with a Winbond W35N02 SPI NAND chip (so in the end very close to
> your report):
> 
>   +-----------------+-----------+------------+
>   | SPI NAND        | no tuning | PHY tuning |
>   | Unit: MiB/s     |   25MHz   |   166MHz   |
>   |-----------------+-----------+------------|
>   | Octal SDR read  |   13.8    |    34.2    |
>   |           write |    7.2    |    10.2    |
>   |-----------------+-----------+------------|
>   | Octal DTR read  |   21.2    |     N/A    |
>   |           write |    9.0    |     N/A    |
>   +-----------------+-----------+------------+
> 
> Please mind I used MiB/s and not MB/s (so kiB / 1024), I don't know
> which one you used for measuring, as you marked MB, whereas the most
> common unit seems to be MiB.
> 
> However PHY tuning failed in Octal DTR mode (your series applied on top
> of nand/next) with the following logs, can you have a look?
> 
> [    2.261647] spi-nand spi0.0: Winbond SPI NAND was found.
> [    2.266956] spi-nand spi0.0: 128 MiB, block size: 256 KiB, page size: 4096, OOB size: 128
> [    2.285257] cadence-qspi fc40000.spi: PHY tuning failed: -2
> [    2.290835] spi-nand spi0.0: Failed to execute PHY tuning: -2

Unfortunately, due to a known erratum in the Cadence controller, PHY DDR
mode cannot be used with 2-byte addressing.

Refer:
Errata i2383: OSPI: 2-byte address is not supported in PHY DDR mode [1]

As a result, the Cadence controller supports only the following
operating modes:
  - PHY DDR mode with 4-byte addressing
  - PHY SDR mode
  - TAP (non-PHY) DDR mode
  - TAP (non-PHY) SDR mode

[1] 
https://www.ti.com/lit/er/sprz544c/sprz544c.pdf?ts=1770404630843&ref_url=https%253A%252F%252Fwww.google.com%252F

Regards,
Santhosh.

> 
> The fallback worked well though, the memory was still usable like
> before, which is a very good point.
> 
> Thanks,
> Miquèl

