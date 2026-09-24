Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD47757EA;
	Thu, 24 Sep 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216059; cv=fail; b=SxAgwU36ahrDVT0BwXKfaM5I1Cnr0XMgZvR3z1mfRyzkrK33JbUq2VQLL3ZO1zV72bgZz7fPghU2cwvnIDUJZwiVGizVHtwUgX8gctq4/ILobrU93S8pulwH96TNOxyq6GuwuKm61kIF3Qdzlve3hEvFejQQ1MSdsNLinAcrFAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216059; c=relaxed/simple;
	bh=hwn3EBZVdp0DjMrYMVc1pfJu+hvBNybQskDgXP0QziA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1yQLZMFxDBrh2S7c1qSAGlDPekyldlOb2bqG86gvMd9zVSR0cUOew0K4V1+5WUIWJeAiKa1m/n9dljQD1glcXAkRuN18bM+k03SCHqS1Cl+17RMuCGFpl33egh3KnaXROtNDeZ0PX6oNo4UgoWm0/pPOY2tRDaKWJ1aMYakArY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSAKgvRy9kYpmVyN0XL8oClp+NQsgH8EML7fQBWau+XaSKFOyadfxRueP5CDp4ZskRnFIXJY8TqIX3CkWY2yDMftE+qRIp+xbl2IJh7fKTkQL3FvocFt6smYpvU4pOaAHEGhgpG1UPUP1c/3Qfhy94KH1Olqisl/Mz590tk3ocfU9RtDdkPEJjX8zXHz55iz81CNnr/Pc+QgVJ6Wz/4Y8Lwx8EJTyzojcYsKkcWcgn6Alakd+zVsu1Ke4TU4p4YVv/BmvfvmCYIKdymotwYtfp1Jo+Lca3R0Qb6TjQZfTaKxxSLU3MmDx7IwEoYRif7Ze02b2oletnEjhDNQlsVZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YawwSFlqUBHBpV6zHaS1s+gmYVCioarR5mitw0Z0kYc=;
 b=Aq7WhVVl7VcrIyLoMqPVrxmk4h2Wb18tNqtdrJ6aLKL/D3wHMVgJ+cv4F0RvySc1CYeeo6SvlwiKO0bIevIccJWLJA9OF+uqqyugB+PK5h6wpTeV+8/yO9Co74+Q9p2yoYYLntuUqR5SaBfwZXIIgxtsN7W7RoJcBCUgHRVxZqFnCRVX1lHV4jA5qSPJd7PNbawhrt2kJJrSCJxVKDEWsTAqyxOnHRRtk8lzCDDsGBQQjivekEwV6NxKHwpspkz1xTaOAbDSVSeIuttvpdi8LAzrOt+X9tuLlu5hhOcirVBKLLKof/9JkinsHyGlc1MWKp1uev5chX+3yAd5zeyUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1165.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 02:14:01 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0451.014; Thu, 24 Sep 2026 02:14:01 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: jszhang@kernel.org
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3 4/5] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
Date: Wed, 23 Sep 2026 19:13:51 -0700
Message-Id: <20260924021351.3965-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909143652.9234-5-jszhang@kernel.org>
References: <20260909143652.9234-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1165:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ccd921-11fc-49c8-044c-08df19e17f95
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	o86Rqyus6zpCtREXeBcQHU+uOJvfNAgiVun2EXgmOdvh+UlukDTumxSOeRc7ix2d3Q21xcZoxsGuqqaENBgKoMo6Y9fEwuULZo6tMCxX97ZnvP8kmDcF8x1DbSxexX73riPnyc3Rupmvv9WpL8EZrSB5JytlOA0CiO6nKAP3vs3s5/GeofkwGinXJ+sS6HeuzrHUj8JNjuvlh9V1mHd8St6cr+CF0zMMSFufckCwU7fp2i5cnCczmo2hD/0JP0swHHsAAunnatYVV+DZK27wYdnFgZNlC9wXLksSIPyMf8DoyV8bKbQi+7gTi0YvlZOWAW4c9U6j8LJ1Z2U2vzkSqP9/gPC9putOnsyugcoPWjluo4HK4AfKkhgKLdMJB4/T3woBab+qo6Y2NneYgj6lJeQXIOtKYkHRSCv0FTrY2qe+KMKkM917ZFbw5gxuHWhS67goYxJgZrKzpaUWBi8cFlw7Vks7E7jLhlI+TBJ6U9g7nxsyR7KtoOM0B6OGhSGCvzCHVkCWW40J1TfgQvzMRtVy80RN2Rwj/iLx/c6F1Zm6Zh5qf0hutGq0VP00j/ZE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJQZ1gvRC83eHA0WFZheFNCMUNhTXpoY3h5S3d1ZU5NVkh2S1NLdzlETk1r?=
 =?utf-8?B?cGhiL01FSmg4ZkEvZysrS2ZnUDVZZDlKbHpaQ2pQSi83V1laOU5qNDBCWUxY?=
 =?utf-8?B?d2pqVTlvQzJhalh5TlNZb0RtTnZ1Z3V0NkR6T2h1Ylp1T1h6UWRHSWJhL3Nz?=
 =?utf-8?B?eGwzc1VjR1pGcjE5dEZSNjI4OEVXWlY0WGs5YkpCOFRCSGI3S0lHWmxpRklU?=
 =?utf-8?B?N04xam1SRDM0Ny9GRjFvcG9RL1FjeklaVERCaWt3VWlxcTBuMVN4Z3pmeFdk?=
 =?utf-8?B?Qjd3akFtWEtZQUpKc2YzOEx5VmhIeTNxVWhHSzh1RmxRUklKKzFDR01DeDlJ?=
 =?utf-8?B?TVlUTWxOVXc1KzhlcDJiSmFUblNlY0g5NzJMelY0aDRWeE1ZNTMyL2ZrWFNE?=
 =?utf-8?B?bHBkNFk0QUJNUXgvaTh5Mm1TRzNZTlNkQ2xEaVFCcUxUQ1c5VThZUzRDa29B?=
 =?utf-8?B?by9kMkhxWTNwNDRuQXk3aGRlQWpXTVV5WUx4bVBwRWRFYnV2QnFhQmpWUk1T?=
 =?utf-8?B?eTJ4QWNFTWNXU0VtYjhQMGxiMFNRTGxCRzdIK2lEWDZVTmdPc3pnWEVqaXJU?=
 =?utf-8?B?QXBMbnVjZ0phQUx2WHgrWEdYRTU2eU40UHhsMk5BbFBhR0w1b09yV3J1L2Zt?=
 =?utf-8?B?b1dNdEZmeUpDa3NsNzhHQ3R6MDUydzMvc3BITDczeENOcmtpYXFDSGpwbkM4?=
 =?utf-8?B?QWtPRDVaTUFIT0dsR1FDTzM1WFdqOEVGNUlacGxlOU5qb3NvK1IyNGZNN29K?=
 =?utf-8?B?SUJEL3JRYlBHQU9QVGRvOWtmeDJOeDV0M2JmbFJncXRVNkljUk9nZFYyR3dt?=
 =?utf-8?B?Z0tpUWRpUEdzRTRYTG9PVWtEWHloVE1BL2VXUlRSQzNoZWlWdWdlaEdNTnZo?=
 =?utf-8?B?K2FrL2JIUHdoVzV4YUx5RFlNNzdKN2N5QlpVWjAvNzgrclJTK2lURHlJV29V?=
 =?utf-8?B?SkpUdFNmMnBGREhhajNhV2wyQmpSRHltejJpNlZhZko5aHZzbXcyalNjN2E3?=
 =?utf-8?B?NENtYWE3UDlMczJ3aEpuNUJsMUxydXp0ZkcrUVdZSnRtb3QyREhkWnlKZUJ4?=
 =?utf-8?B?SXJyTk1BZXNNRTIvYlF5YmFUNkIyZEkwekVWN291QTNIMDJZMGhxTDlWRmU3?=
 =?utf-8?B?eTgzeHljNy9BZ3BpNVVuTTRlNjA5d0FCTWdiYkdTM3RvNGdlVzlTQUVTb1pQ?=
 =?utf-8?B?bWZqTnJNUXh0SFlvdUREMlpUUXZCRFVBRWhIUU0wdktIaXpYcHRhVjBZYUJx?=
 =?utf-8?B?ZzhhR29mWkxVY1RXZUFPallqcFpFaHFEQ2t0VUZZZEFGUnBLZU5oOW5JRUsx?=
 =?utf-8?B?MHV5MVowWkRHZ21LRGlFWHNIclIwV1UxeHNRd0tNZnVGZ0dQSlVhQlhiWGd2?=
 =?utf-8?B?b3MvRTNmY3NTZ2tjU1U5d2NHMHVxWVBnMnM0UDVUMk1waFplUWRxODMyZ2Fw?=
 =?utf-8?B?bjRQL1BWdk9uUU56aTNSeWt2cFpqUkk2VlptQVJWMU14UzkxcGk2MkRCOUMw?=
 =?utf-8?B?ejA3a3V2MHlyYTBienE1c1VMNUlsZ1ZBLzBndzRYQStFSm0vN2FuL0wxYjlW?=
 =?utf-8?B?Z2FGMmdSbzNkakp2V0FFOTF2dE9TMFkxRFdiMkRZTFBpZEttRklyV1hoMEtl?=
 =?utf-8?B?Q2VvSEZzaVRwY01nRnB4RmMyZDVMY1Q0Z0pieCtYS2k0WndiazY1MG0rNmxE?=
 =?utf-8?B?a2pyN3YyaUEvQ2JaSDU0M2gxL0xuaDI5VlNzK0RYRENyVUxzbmxiRmF6aE1q?=
 =?utf-8?B?WGVmUWV1Zk5lWnRBMjhHM0Zzem5lY0V5YmFMNGRxb2xCRnNWajNoYnR0V084?=
 =?utf-8?B?cElJUGNlSmlyTTl4SjRaYXRwK3JzQlB2OTM3UE5jZEpjNi9wSGtVMUJxNnFk?=
 =?utf-8?B?VUxXbWVkamo4VWRoS1VtVjAvc0IyTm5NVnZZYUQ0VXduaWVzNktzdnhEeUhy?=
 =?utf-8?B?ckJNZXRFd1ZtMVp0MmR0aXg5OTVVRVA4aWZrYk5Ldzc5bTVFdlY5dEo0TzJr?=
 =?utf-8?B?Q1JQdGFvQVQ5MW5PN2VnM2hGYUtlNzBsYWJVU1pEQ3VkaVhHYXczR2lVTk0r?=
 =?utf-8?B?dUNSVmdHWlU3L3ZYL0dDalZqSFppMHhoVkIvWWRML3g0K2tucGdyUmJ2OUhV?=
 =?utf-8?B?cWMrdGEzSzRJQ2w0MURwdjdEZHBWbnRsN2s2MkZBMEdjR0dGcWc5bFEyS1d2?=
 =?utf-8?B?YjduL0kyVUVvRFRTWDVHazhRZWJDTjhIaThldUVhcFNSTFpwSTZaYWEzREZQ?=
 =?utf-8?B?ckJzUFNsSXVyakZvdzJHM0xsckZLc2tRU0xmem14d29QbGwrZXVrd0xUczFN?=
 =?utf-8?B?K092UFNpOVRXV1prOHNpYmdjUU1zNkZndERKM0t0aEVoUXdJS0pzc1ZlU1J5?=
 =?utf-8?Q?l6QZgKXuRG+EPyTNbY8AKZ+T8VYXB1q7u3Oy+?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ccd921-11fc-49c8-044c-08df19e17f95
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 02:14:01.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWI52CQRJWD9ggmxKZhJHCFJjZ+2JFXeSn5iBBE1Q4gicNun85MVlfhKBfOCgeZvBBujjxV2hZAY2Z+RMakBgoy9t6z63QuuaIwBYQ/swW19764t/uQ0UMrqHHjdeUsK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1165

hi, Jisheng

Thanks for the fix.

> Recent "enhanced" support changes the dw_spi_irq() behavior a bit
> when !!ctlr->cur_msg:
>
>     if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
>             dw_spi_mask_intr(dws, 0xff);
>             return IRQ_HANDLED;
>     }
>
> But it misses the dma case, where the transfer_handler ==
> dw_spi_dma_transfer_handler, so this changes the previous long time
> working behavior, let's restore the previous handling by only filtering
> out the dw_spi_enh_handler.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Maybe a “Fixes” tag could be added.

> ---
>  drivers/spi/spi-dw-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 91de357f97f3..da7d4872e513 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -280,7 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  	if (!irq_status)
>  		return IRQ_NONE;
>
> -	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
> +	if (!ctlr->cur_msg && dws->transfer_handler != dw_spi_enh_handler) {
>  		dw_spi_mask_intr(dws, 0xff);
>  		return IRQ_HANDLED;
>  	}
