Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F605397E6D;
	Mon, 30 Mar 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900586; cv=fail; b=GDxDcW9AzyyYCQLAaVt5c7Bqrzb5lyk1yIsqhsWWE/7WZAW9ZE3gfoEn3EGOBKwhtKgD5xMC0olMdmLthodA40BACgy04fdr+VHa7cT0Y5qFxuF5H1JkNJr0i38CSpYw1noSkCHykxME6eZ0m6tdW9Fo8zciQ6n000U4Vq77eZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900586; c=relaxed/simple;
	bh=O/s7LtzQzdky30IgoF7DGECTtamtZ6fOuCWcW8Blfv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uus5QqqdbU7o+Tvv93ed+PpOPOACNe2JYwnASSbUltvx/fFtULRbApGLmcfXXj9HU4wZR5NyPJ9jx7M5rwpyFzUtvpQnIdC5Mbu9jqcVIY740X5RcDvTjmGcIO89uzW5zJ9rAHlnwIAA7E6qiAdr1ALAuaSBqCevODlbmsQup9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mRLzK7v9; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mRLzK7v9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxKodlfE/qy50wTTIoFh0/JtUWuugnMax5IT0ygLaV7xdsctGwa7+arUYGoBkaVtNqU1069VvSxptuuOUkNJf9nsZCMQW6pTVHAN+GrpKzujdNpkf9euYd1nDp9bNtWZ+EvpzDRtCUtlTvSHVn+m7m8Q2UlxgxwH/ti6eZdkRoADrCgS20Q5zPtu1+wxVPZmrbqmj3p9j4cFz0i2lPx8CQ2oAeuPTVfcJXn52JZQ1kcN66QlTgvTpwix9v1ruU8EWgkJly4GU4shA+oIimQc+/FyezSM4F1k+419BHRUWgBeSpLh0QMUVX85K3nvQpiZ46t7LOptbdFYkjEQeJIqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4gGIeXbl4uwDSno0tUZnrWynXik5m7JE34TEF/1Rbs=;
 b=lBMniq/qkJu38i6cUwBxVFg0Odi15lUlnDJLARwSczmYaJSCijkWGY26zVwOTNnekD1UzDS+8mhkDHIxjpyiGPqvguf402U4Ko7TgwxTXnTUyPRCaWOjGnZrejOyRKc4VoqmRR09rj5YQjfzggcnXXaJyDP54Z4Tl3SkLtG7TXfWfmh9XaJRBg9iTMBkD3mxn7YPRH+EhP+lwKyUQ9XHa9kfX7Nd0KsXIDZQcQN7u5EZITwEU6wCmxx7rQeAVfKGjMFEpD+0E6AAOZ/vh37NDkATtAgxXE15el0wLLiA84540pLK8HiZBq6BSrB1NZKkngSHaaLDXKWCV1TbzrG85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=kontron.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4gGIeXbl4uwDSno0tUZnrWynXik5m7JE34TEF/1Rbs=;
 b=mRLzK7v9mv/b6HCsQ45Ykpd8nDbM8gTIkworI5cxKGoxoIqQGK9nSfTtZHxw0cC2lMJpDRATKIC/67mbfPxk0gwcB2MPfSzaU4U6UGbTCPJJYnGg4gGZzbNq01LtqeD7TggKJgfgXJJEhUPnODX5ibbtjas38juEMx6h7eRSXAw=
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by SJ2PR10MB7825.namprd10.prod.outlook.com (2603:10b6:a03:56e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 19:56:16 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::1d) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:56:13 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 14:56:08 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 14:56:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 14:56:07 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62UJu2mC1373390;
	Mon, 30 Mar 2026 14:56:02 -0500
Message-ID: <92997069-cbc6-4f45-8b33-b0b5ab1cd356@ti.com>
Date: Tue, 31 Mar 2026 01:26:01 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/12] spi: cadence-quadspi: restrict PHY frequency
 to tuned operations
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Eberhard Stoll
	<eberhard.stoll@kontron.de>, <s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
 <20260113141617.1905039-12-s-k6@ti.com> <87zf5nf5g1.fsf@bootlin.com>
 <fdcb19ff-c949-4538-8819-88720e514f04@ti.com> <874inlxde0.fsf@bootlin.com>
 <87zf46cwp9.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87zf46cwp9.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: ea27fd61-44b8-410a-4b38-08de8e966600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YUGb24hebC+utm0tT+chdPCp3jMYEaFsC/lkoZG3oYS3OV8sFxQyCT5TXocceDkRdhJYxN2WlXKUNphsb7DlfLIvncqur5TY6xKkkLF8kgXMRieQO2VWskOpWlsrfJoRGjGrpmPf0uuMiyMepXwjkH4eUBqobn+v1ulX+JSIFCPP0dWf3MCsgA+sfqX4FgGJq1TGtoPabEILWeRaqOa5RXPzBcthJVY4zS0VGlrFzthY2jInAkr2ocxnasdWP4h5KIXp0O1I8vxWDjCAT+CdaoFX/ttTwFiCJsrqbilidba0tX2oQ/kgWrNuhK4nnih1OOJG8u2hXcsUajvR+FFgoZlrYTZ6jAxqltppX0vi8A0B8+xN7mTEDRhKqVymZBPTNf+p4kuwRgIUzgPI4FgBETN3D/HmYe/W3Q1CyKfxAIWODWHj0Mepa5yFNDdizzNT9MV7Lc7RMS9Hy2N7gzQKc5YkAAeZGfLvnpsZc1K/AOhPlHhG8+PQshJ+Wm7EF2hYzn/YUq+7q01rE27dmmufm+rcQ3vUvR9WBBhd4txbPwZr5X///BfHt6OaybKRlxSWV+/0TOBBqKqXNp76Qn2nuHmjATL4Z7cl+df5H8RiRQG+1MqujX1i205uLMqi/q+2SJmtNnJtYAKvCJioUk+Q3utDDVffBXTmy7ZUh0lWd/VEvbOQOmCbmYDvsvO4LZYzehDbTuso/Z6UTKNsTMYD8JZLbvkUoYOEkRTbYVNcNmdlAnxGi9FvLyrYlNV8FBuQLygqmr8zWxIXHQqFfG0hog==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xyB1npeEQMeqbsyggglDzy9T3TmiAos/RkMaXdoSNAsGyOnjibtcUY/M819AJxNWIy/aVBDytobGdvlYTU2TGp7RxsgyBJp59KLQi9nCkpAy9jAjKMuN70x2EkmYpGlSvS5hwVKBF/9/1N9xQiDmAEXTwC4bbphKjQNw8DPQUF9pqY+Zb7AbwkanmF6JXWFmvw6F5Cn3hjbG2+x3OgLiDHTOQz5CWC481/0uhlPfCJ0QeMJqpTnb4ain8pPv2Hp1ecALg+vIObd/E7BkmQZd0c91PxKZtee/F78FsgykS1ZkEz/DQyclOsXyVafZ/t2rT9dsy/vl3y7x7HdmthT+DhWcKZaiMtvt3cVmej8dGNUFwT8eiT3WPgfXlxrSukqQpavITdZXXAr8vyllFnTplRfQHJJ/86vrox0QdHHHYf7VH06/gigU5+2zrRVB9R4l
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:56:13.9599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea27fd61-44b8-410a-4b38-08de8e966600
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7825

Hello Miquel,

On 17/03/26 20:47, Miquel Raynal wrote:
> Hi Santhosh,
> 
> + Frieder and Eberhard
> 
> On 13/02/2026 at 09:21:11 +01, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
>> On 07/02/2026 at 00:57:04 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
>>
>>> On 05/02/26 23:17, Miquel Raynal wrote:
>>>> Hi Santhosh,
>>>>
>>>>> +	/*
>>>>> +	 * PHY tuning allows high-frequency operation only for calibrated
>>>>> +	 * commands. Uncalibrated operations use safe non-PHY frequency to
>>>>> +	 * avoid timing violations.
>>>>> +	 */
>>>>> +	if (cqspi->ddata->execute_tuning && f_pdata->use_phy &&
>>>>> +	    (cqspi_op_matches_tuned(op, &f_pdata->phy_read_op) ||
>>>>> +	     cqspi_op_matches_tuned(op, &f_pdata->phy_write_op))) {
>>>>> +		cqspi_configure(f_pdata, op->max_freq);
>>>>> +	} else if (cqspi->ddata->execute_tuning) {
>>>>> +		/* Use safe frequency for untuned operations */
>>>>> +		cqspi_configure(f_pdata, f_pdata->non_phy_clk_rate);
>>>>> +	} else {
>>>>> +		/* No tuning support, always use requested frequency */
>>>>> +		cqspi_configure(f_pdata, op->max_freq);
>>>>> +	}
>>>> Shouldn't we handle this at the core level? We know what kind of
>>>> operation pattern we provided, so it is easy to set the correct
>>>> frequency in the operation structure.
>>>> Can you please make this happen? Perhaps you can return the operation
>>>> frequency once the calibration is successful (in the read and write op
>>>> templates maybe?) so this can be picked up by the core and used for the
>>>> following operations. This way the controller driver no longer needs to
>>>> check if the operation has been tuned or not, it can just look at the
>>>> frequency. When using the highest frequency, PHY tuning must be
>>>> used/enabled, otherwise not.
>>>
>>> No, Miquel, this may not be correct. There can be cases where an
>>> operation does not require tuning but still can run at maximum
>>> frequency (166 MHz, for instance).
>>
>> This is currently not the case. Currently you tune for one or two ops
>> (read/write) and you enable PHY tuning only on these. Do you plan on
>> adding such a feature? If not, I would not bother with this now.
>>
>>> In such scenarios, simply setting
>>> op->max_freq to the maximum frequency value and deciding whether to
>>> enable tuning based on an op->max_freq comparison would not be
>>> sufficient.
>>
>> If there are such cases, can they be listed? I am sorry but I fail to
>> see where this would not work. Any examples to share?
> 
> I don't know if you got my feedback

Sorry for the late reply - I did see your feedback, just got caught up
with some critical work.

, but I would like to have all cases
> in mind to decide in which direction we must go. Especially, I would
> like to make the bridge with Frieder's work who is also "playing" with
> the maximum frequency.

Yes, I've gone through the series.

> 
> We need to clarify our mental picture of the max_freq handling. How it
> should be derived, how autonomous shall the SPI controllers be wrt this
> value, shall we flag operations that can go faster and if yes, can we
> attach a meaningful value to these operations, etc etc.
> 
> I feel like this is the part that needs extra thinking. The rest of the
> series is promising. I would like us to clarify the needs, maybe propose
> some kind of drawing/slides or even take half an hour to discuss in a
> call once we have all cases in mind.

I'll need a bit more time to gather some ideas and inputs, since I'm
switching back to this after a while. That said, we can still plan for a
call if there's already a proposal to discuss.

Regards,
Santhosh.

> 
> Thanks,
> Miquèl

