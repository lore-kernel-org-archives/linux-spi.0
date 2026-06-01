Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACB306B1B;
	Mon,  1 Jun 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306052; cv=fail; b=IXt8c6OclCpAojnYgUoyd8VpOvdfs9BPE6tHA5pabCWNvJu8dLV56RSRyRK1RtYmI5XnpP7Z3NsTfNPG3/fCDwZ2B3Lj+guVt7EpsQO8vGHrHstHRI/zTWS2249829tdrA5gC7TVnwLFTe8kM700saR1l7/U3f3cIIv6TwPLSCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306052; c=relaxed/simple;
	bh=Kcn2rg+vdYNsGoU4nC+zSrzRSQTjGi4msT1Sv/vdzrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iWLYaRZGItMU7C2H/L+ntuicdMDBBkl17+C+QizHqZSFawnaYJHx4QVXHzDiSy3RKNYg1kGuE+8Y9nJj7LJAT6H5h8Sr6UPuh04jrWlUPzFfnv6NJRA53LYpS6iNyQ6L0jGgc4ugOa52c/puCF+CE4iDzjJF44t5LXApxqjZeDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JWvxUuEO; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JWvxUuEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAIEM30v1yyGmVbNVgW39L2/Oh8QtxKyB2Ye6g4EH1EtEqnMQaqSz0qIfPTRvWFgfqChLsWO8safD/CYIkE04xBY5BWLjDpdonxZ7w5DAIWSNP6f52F90hMRJh6WmttzFuRPG9AWZT2uEahODr3uvkWro1tskYHVJ9s8XpKNsaR68HNWW19NLnSRCF01fUZ+hyRfGolhpSRJYiXWnkgrwR6ad6EMMJXGOangJAb5vsuNJf8iTF8+LDfXxaH9bAJZ5Z8sXQvwk9eB0s776rq7e9eeRHHnGLbeqQwyX6ASGTOGtuKzybvrm1AIFLHvOi6sNJb/mvid0jKOk7bi47Qn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpiTrhU4b8XaxM7+quIPhOK2GqZLyNikYCoZcor7zjw=;
 b=qw/zJkkZDGmnBKy9es7MNZ0CGFcGIUTtldHthSkNj2H8M5UqIzn8WtXnIQ+FTehpUAtEhVy50MlTNbML3M8MctuLRDM77fYlP2cSaeymrBnWTBvmeFhC/XBpKd/bmDZ3vw1z2XDF0Fh5B8DWQa6YgOBt80Jw9lGSSeiUeeSTrtiqUIvpZgIc5aac5Ckquvm3wRZS0jx/aiUdvJs0hDgdjZ+mk6GJI0GFlqZOE++bOZvfGfxmoGYDHkf35PPGhsS9vlS9nqnz5cfPBIU1M0o+8UAjG7EwBB+cIRTcFk1fKCTYq5bRaREybb5QXgvuuTj2bEWk3bWxvM9M+UWCzFPODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpiTrhU4b8XaxM7+quIPhOK2GqZLyNikYCoZcor7zjw=;
 b=JWvxUuEOoLOyAgzINjlM5nkuzNjVGZ6Q2TV4sRcB0XeqbmRNbSlBskm0+iRqlgbM6gKLoNuA1uxtHHPIPpzWv7xSe4v2XDRAnGOahoMg0LnONlkwXnBjtks5hbX+DF1xbLDqo607VUE67TUWkC/5UFdZV9nvMKyCOeWBBWmajVw=
Received: from SJ0PR05CA0144.namprd05.prod.outlook.com (2603:10b6:a03:33d::29)
 by SA2PR10MB4570.namprd10.prod.outlook.com (2603:10b6:806:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 09:27:27 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::7e) by SJ0PR05CA0144.outlook.office365.com
 (2603:10b6:a03:33d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 09:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 09:27:27 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:27:26 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:27:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 04:27:26 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6519RLwH716951;
	Mon, 1 Jun 2026 04:27:21 -0500
Message-ID: <0ee42621-f970-451c-82cd-9a1a63ce197e@ti.com>
Date: Mon, 1 Jun 2026 14:57:20 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] spi: cadence-quadspi: reject 2-byte-address DDR
 ops on PHY-tunable hardware
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-10-s-k6@ti.com> <87y0h3gb6o.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87y0h3gb6o.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA2PR10MB4570:EE_
X-MS-Office365-Filtering-Correlation-Id: 0145e690-5cf2-461f-e245-08debfbfff0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|3023799007|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ouBA9Pe3BFAkC4cnXDRJtJSrTKndN2XGjquJI4lpGMMSN8yJap6e2MxT7a/9KrbExqOdkfYCFy89J8ChZtrSzkgenAd3yahv7EQ/Jtebb8g0JLGgJ5dfyhDjyJrdbnc9JrlZr2uFz+vCkLUKt2lJmyBkd2EZFvqybBAzZzeF6FbjE5AscKKa0bWMc/Z+vhxcLIj/UhRYLwsHggXdktsV2umIyDOwxK1QhFxmtsWUd2HrELrbuZO+25Ve16HQeanfCWqbRjb5P8IcHIYMlOdXdZD8BcqcIxIgklas0bRjtfwxXVoOZe9TkyskcE+hENVPf/1sbMLXnN5ixOj9uoi3YRh38UnuUhcFxJTH5q4G/9dEqJB/8c+pNWTKNAU0vJUNNrhCMpilM4WWsZo4cLCmq0CmSeamdkiX+Dis33QisJ1PPKYwuheHtJ17pojSeJXMr9S1zxxNAh9qdwoNVik1BXxbJd/GR42b+NUBKMAwvuGj/Yvw/flcvywZtJ+enEPni3VSCC9gqEqVlGDjb6os/v3HP9BxLOb/viagk8AfaeFot20wPQY5QX658Z4tTw6pINWzQEhf3mQPyxECgvozooz0e+t9rH40svw/kJ5qqVnwVOv6XMVoSklYJEpB+jzCk6nj5qAuvGsT/T3huitvJOzxOo6qCcEIxAtC46hrrpKKVZ996Nijm3/aBzPc+6epXkme0Ko9HE8abCahtyNarYnsoB8xkrRQJQsVRJ7CBF7GVRP8ixD/U2KVL99SwKZR
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jpP4M49lk0aFQ9u6I3r+BGQi5vBiJDftD44eu2vTyVq2rnRlRrHL7rvGYkFElOOapUxdcoNBoVTwIZXCmkERsm3DeOVHD+dXijeEEpHkikbVlT1Dbl25qZyoNDMb4ehYo7RYyt7kOjR9yCFJ+ltLgBelMcoDSZfhAbQrTfQYlsLFcGhW/IHGx9z3HQmgV/6lnSJ6EocwHkO0MebKg5OmprvyJ505n7p0hIPNFJaRw432O/iu/VssW7EK84Sx1zyG5LMi8ycAxzyQ3wo1SzYzzfbUGqbPMdbJkChp7qYxchrGfjY9Jm4iI49pBNIfWASnU6jVP1nUlKDwPEM2KX5G77cWA2JERD9mXbPVnaBCT2eYWa8MxU8T4fVxTV47ia0tNM5n+4h2EhoEJw7oOo7SBnY+M68hC0/Fsm1drqFOGkkgy1fzN6vI3BSn7X3kaIow
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:27:27.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0145e690-5cf2-461f-e245-08debfbfff0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4570

Hello Miquel,

On 28/05/26 14:31, Miquel Raynal wrote:
> On 27/05/2026 at 23:25:23 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Erratum i2383 affects the AM654 OSPI controller: in PHY DDR mode,
>> operations with a 2-byte address cause an internal state machine to
>> mis-compare the transmitted address byte count against 1 instead of 2,
>> locking up the address phase. [0]
>>
>> Add a CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag and set it on the am654_ospi
>> platform data. In cqspi_supports_mem_op(), when a controller carries this
>> quirk and has PHY tuning support, reject DDR operations that use 2-byte
>> addressing.
>>
>> [0] https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/spi/spi-cadence-quadspi.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
>> index 508bc5bc4ab5..72208d376305 100644
>> --- a/drivers/spi/spi-cadence-quadspi.c
>> +++ b/drivers/spi/spi-cadence-quadspi.c
>> @@ -49,6 +49,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
>>   #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
>>   #define CQSPI_NO_INDIRECT_MODE		BIT(11)
>>   #define CQSPI_HAS_WR_PROTECT		BIT(12)
>> +#define CQSPI_NO_2BYTE_ADDR_PHY_DDR	BIT(13)
>>   
>>   /* Capabilities */
>>   #define CQSPI_SUPPORTS_OCTAL		BIT(0)
>> @@ -1627,6 +1628,18 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
>>   		if (op->data.nbytes && op->data.buswidth != 8)
>>   			return false;
>>   
>> +		/*
>> +		 * Erratum i2383: In PHY DDR mode, 2-byte addressing causes an
>> +		 * internal state machine to mis-compare the transmitted
>> +		 * address byte count against 1 instead of 2, locking up the
>> +		 * address phase. Reject such ops on controllers that need it.
>> +		 */
>> +		if (cqspi->ddata &&
>> +		    (cqspi->ddata->quirks & CQSPI_NO_2BYTE_ADDR_PHY_DDR)) {
>> +			if (op->addr.nbytes == 2 && cqspi->ddata->execute_tuning)
>> +				return false;
>> +		}
> 
> I don't think this is a valid approach. What we want is to prevent
> tuning in octal DTR mode with 2 bytes addressing, instead of preventing
> reads/writes in octal DTR modes after tuning. Have you tried on an AM62A LP
> SK? I bet probe fails..
> 
> The quirk should be handled at the beginning of the tuning procedure, so
> we skip tuning entirely in this case.

I see your point. However, in my testing on AM62Ax LP SK, the controller
and the flash probes and operates correctly in 8S PHY mode.

The reason I handled this in supports_op() is that, for these devices,
simply skipping tuning when a 2-byte DDR operation is selected may not
lead to the best achievable operating point. The performance ordering I
measured is:

8S non-PHY < 8D non-PHY < 8S PHY

So falling back from 8D PHY to 8D non-PHY would leave performance on the
table compared to selecting and tuning an 8S operation.

That said, I agree that encoding this as an operation support
restriction is probably not the right place to handle it. I'll rework
the initialization flow so that operation selection can take
PHY-achievable frequencies and controller-specific restrictions such as
i2383 into account when choosing the final operations.

Let me prototype this approach and will report back with the results.

Thanks,
Santhosh.

> 
> Thanks,
> Miquèl

