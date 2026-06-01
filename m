Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3D390219;
	Mon,  1 Jun 2026 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305419; cv=fail; b=OQddUs6JeX64xZ5jgs2zgZ4thIz55gH68NeakUPo0U8KGFbVkn88o8BwneFnsfWgm+vwyWWWDPIgN2r7kNZFRk33zZo9fnWS4NQFjza1Vsa4YnUYn8MQZ79BvVthApQbai/3UORlOoPWp0I+V21hSkIR0DTRdyOAwFcqYcterKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305419; c=relaxed/simple;
	bh=zoEHDaKimPqfJ/XNQNMYFKp9hHwD1uPTi4xziKWtUB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dv4d7fsA8ZoLLUtRJdxmmDTtjmVtu41+hDJz/dAA9Kce47cGUWq3ggLskmDWyhvF3z+KC8vNuI6QyttYpklkjyJ3zdFwMJnQMxMZT6Qc+WTvikwSNN13yldyJi84tQhE1JfdkQk1is+i4+oP3To8lwXcVFVgrjN1x7BWbSkszmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IXqfuSCs; arc=fail smtp.client-ip=52.101.57.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IXqfuSCs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADpyZpGPuKgb58MuPJC7KeZgzNTaS4EK6tGOdAHeyczpf4CSk1B54tEErksCHcLJ97PFJNNiv0zjigaykRFPsBoG0+PFN2UbRh97HI5UzCipqnF2ROu7XEDNbvB/JFym0IvOgRgJRKrcCfelVAWmT1AD9cHf6uEadU2EWNNiBcWl2bcj/avUdErad1pRI3TmHMwsH/eB45uWtALnVxA7pqdIHOnIAJL4QvAlzbxSK0OAJb7mPz2vJ/od6xns0BXHR2lwGIa4RAem3Fodp8Cbs39kTDSggJCGsek7UNOnDkD1GletVy3jJ2fdyknkKJXkQQZ1r0zfsE95mzR1akUuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxTNlQFdzmXh2tYzBfynmc96b0ewkuI55Lqzeef3yKQ=;
 b=g9gkjZIQS9maSTPHXi4j27HEZ9HGHk3Vyy/ggy1kxezkuJxLwVmA6QXNF26dSG3nWkj1TX/MgO2G3rAI636zxST7S4OJSQ6Emo47DZPAh3cF0DjgUOwS74JJpilLcA7IuLFCoNy53H0MvHeaYqq03I+9GI7hXBzLam3qyjmL0Kb9adH9YienASHzsccYGC3mfKrONDHkdJ3lmgH+vfw1EguQ66onJssT1Zj5sV9yO78Z1QL+9+lj3VHJOLEfS7x7N5CQnH/0QcwzPM1PCqi9tbJr3mu5ls1i3RKEQPBalTWwO+qkC5/bxg/3RocB/8Nm9EJn4jOqiEu8lWk4/DpvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxTNlQFdzmXh2tYzBfynmc96b0ewkuI55Lqzeef3yKQ=;
 b=IXqfuSCscNCLS1tOg6Arg7blZnU3ls/Ue8LvTrm7sAvZG2Hc9N6G+9IPo92QUOUIJfbeHhYM6Xbu6NkmcUGJyDwl653EA1fO+eg+Vu1O1louGL4lotoxAmKKcJHolxVD/KdhgP72FCdo+l+XJ/uv+uQaFJrjbeHafANUs3OMmLA=
Received: from BLAPR03CA0177.namprd03.prod.outlook.com (2603:10b6:208:32f::30)
 by IA3PR10MB8300.namprd10.prod.outlook.com (2603:10b6:208:582::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 09:16:53 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::16) by BLAPR03CA0177.outlook.office365.com
 (2603:10b6:208:32f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 09:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 09:16:53 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:16:50 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 04:16:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 04:16:50 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6519GjC1700738;
	Mon, 1 Jun 2026 04:16:45 -0500
Message-ID: <2f509130-491c-4a66-9156-39b01b40e65f@ti.com>
Date: Mon, 1 Jun 2026 14:46:44 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] mtd: spinand: run PHY tuning after init and
 update dirmap frequencies
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <takahiro.kuwano@infineon.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-12-s-k6@ti.com> <87mrxjg9zi.fsf@bootlin.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <87mrxjg9zi.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA3PR10MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 500aa677-998f-4ffe-ca69-08debfbe8599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NsiaIjixbLSwzDw5hOApCsIjOSoRuM5b//0cdHNVr9zgMOS7WPiP9l3xyzcI+V4mG7HrjycpNkKFz8UYRxkaUaloexLjV4ZgaGWf1enD2P+wFwSJ8o6C4BH2lcpHgGVWplXc+bQ7L8w95OgcZXwlGdIK3hMoXuN2Oxg1CWKB+wJ2Ky6JU9w8kDdHGi38pnMkbapLCnS1/GguAYgi93h2FhJDk5uPEH7KWHcK2tkg90bnDcwY9h2oTGzGpA1krIcVvHI7wHoB6VvLS+tRxIDf6kCzOEYPQxuY2PLcNw0erqoILcxO3bo4/QO0fjgbmXCnlnwY234tIPlpVkUC1QWAEc1egFQk/CUp4sNCrBvbenxDwKMq0M6hJ/f/OcrRq6jxQiC4dEYn3pud97OPCjAavNVJyeBOkremLAtVdtD/W2mET6nY+k3R4sGa/1xEXvtSbZ3Rr4kLS70rInCCz38uLG1rkOj9ZlQPuFn5uJO3Li/22lq1w+/HM4djTz2bacN8+0zk2J7sxFOr9//EX1t8LSNmII4QU5RTxI1uVCpXgXY51xkGJG0QxcuAm96d+diY8uMl+JDI7mO+nAhfPi44YI75Ed0y7vmHJpSVtmQvrPrxOfW5xddv7C4Nb2T1lBBPdYohNCcK/3chRo7e/dWoAD5zvH8G+GAGm+RUI8V73oihXZ9tclezVKgxKHHSFIm80DeEOs+sQeRDDLv17TE1UeeNi8obXqZSu35M5+sa1nQ=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WrdhD7JRKd2YkNlp+qaKG+4ITsFVx4qKAFx3oO8E6BFLaRjR3/Fp/kaytU9RtiHVsBIbGKYm/tAEBlKjELZkELucxeTjYutgnJ2FTSD2PZxOB44MPwH/JwJvGTM7/ciJQ1rSRPHnjRAslc4nPZQVLP/mVgtMGHELI8wrniRFiHPqle/K5fBSXNhSj5c2kbkQepJSrZ2FNt3U/qyE9S8naYu774LAHRwaYiq52seGnXoy/5ZpBlf2adECLThuD3YxVMcfls7GVHRro/UJVc9J+5H0lqS6IZNp52/vBjewZKY1nSvlwi1tX0CV4CncgEGT/M3x9PDN4F9JKi9CdBNa5fmeA5opMuVAZQ1SxFdb48Xg9rEs3CvR8Rg4/LeIWSPqPtqQ1ixsGXcFTVOFFpdtWFyNeZnePnWDlYvMF7Glxvv1oJls4dKjMvtdNilXexdV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 09:16:53.8018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500aa677-998f-4ffe-ca69-08debfbe8599
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8300

Hello Miquel,

On 28/05/26 14:57, Miquel Raynal wrote:
> Hi Santhosh,
> 
> On 27/05/2026 at 23:25:25 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:
> 
>> Run spi_mem_execute_tuning() in spinand_probe() after spinand_init()
>> completes. The read and write op templates are copied into persistent
>> fields in spinand_device so the controller can write the validated
>> frequency directly back into them. On success, propagate that frequency
>> to every dirmap's primary and secondary op templates. Updating the
>> secondary template ensures continuous-read dirmaps also benefit from
>> the validated speed, not just the primary read path.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> ---
>>   drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++++
>>   include/linux/mtd/spinand.h |  4 ++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index f1084d5e04b9..9b54e4607cfe 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -2030,6 +2030,41 @@ static int spinand_probe(struct spi_mem *mem)
>>   	if (ret)
>>   		return ret;
>>   
>> +	/*
>> +	 * Copy the read and write op templates into persistent fields so
>> +	 * execute_tuning can write the validated frequency back into them.
>> +	 * Tuning failure is non-fatal; the device operates at base speed.
>> +	 */
>> +	spinand->max_read_op = *spinand->op_templates->read_cache;
>> +	spinand->max_write_op = *spinand->op_templates->write_cache;
>> +
>> +	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
>> +				     &spinand->max_write_op);
>> +	if (ret && ret != -EOPNOTSUPP)
>> +		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
>> +			 ret);
>> +
>> +	/*
>> +	 * Dirmaps were set up in spinand_init() before tuning ran; update
>> +	 * their op templates to use the validated frequency.
>> +	 */
>> +	if (!ret) {
>> +		struct nand_device *nand = spinand_to_nand(spinand);
>> +		int i;
>> +
>> +		for (i = 0; i < nand->memorg.planes_per_lun; i++) {
>> +			if (spinand->dirmaps[i].rdesc) {
>> +				spinand->dirmaps[i].rdesc->info.primary_op_tmpl.max_freq =
>> +					spinand->max_read_op.max_freq;
>> +				spinand->dirmaps[i].rdesc->info.secondary_op_tmpl.max_freq =
>> +					spinand->max_read_op.max_freq;
>> +			}
>> +			if (spinand->dirmaps[i].wdesc)
>> +				spinand->dirmaps[i].wdesc->info.primary_op_tmpl.max_freq =
>> +					spinand->max_write_op.max_freq;
>> +		}
>> +	}
> 
> Unfortunately, hot fixing the dirmaps is invalid. When we take the best
> variant, we select a maximum speed that may be lower than the tuned PHY
> speed. We cannot just overwrite that value without consequence, because
> depending on the boundaries we cross, extra dummy cycles may be
> required.
> 
> I believe spinand_select_op_variant() shall be aware of the different
> possible speeds. It should look for the max_speed_hz capability and not
> for the base_speed_hz, and fallback to base_speed_hz in case of
> issue.
> 
> Or otherwise, maybe we could go through the whole I/O variant
> selection again after tuning, with the actual maximum speed set.

Good catch. Updating the dirmap templates after they have already been
created is indeed not correct, as the operation selection may depend on
the final frequency and associated parameters such as dummy cycles.

Instead of patching the dirmaps after tuning, I'll move the
_execute_tuning() call before dirmap creation. This way, the validated
frequency can be written back into the selected read/write variant, and
the dirmaps will then be created using the final ops.

I'll rework the flow accordingly and let you know the results once I've
tested it.

Thanks,
Santhosh.

> 
> 
> Thanks,
> Miquèl

