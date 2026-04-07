Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E232E54B6;
	Tue,  7 Apr 2026 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550669; cv=fail; b=ib3pzVPiGxw6pVD/5WoprHUFyoo1RTssyt3hIRgntgwNt/V0OzbOAy7LwQ5XRBlL2TTqb9BvIx+k36aIReN4DScqtBC7RLY7TGwL62RknmXVqLt7DBXUJZhablvIi8GN+NXiCrwz9KlWbUlgauOQmMenExlf5tHAtTHpNc+uFCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550669; c=relaxed/simple;
	bh=KTyTXTqnvbvI+Z1YIZIceRSHd++L/FRWxPc8pGB4o7k=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezcYh+uXYareiecOnEoIeY2v4fvLbYHnzLjW3kKqx68JKKsx5riwjIwP7HPWjqrZOPuwYBWD8uUmUUhtZK99jKtstSaAlSfnhXdg90UkfxTpWRq/AJY78uilObUK2ckXuPIraBPfVV68VT9RumWqvzcszgtJX9fJikkYMG6C7oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FO/pnevJ; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FO/pnevJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6RikDi/H1bGgsC4/k70vMUnTUf/YYRxTdy1tvw6+E2wvR13qSvpvs5aSgFwjXDNNp2XfjxYXAEcZseOfP73hTj2dKuycnwKJXrIho9EgeWZY4NasCKVOyOb5HI0sPmx/EEQG1hlYBe4EDMDK3mtDuCLoNDFf67e8c1ZXafuAbjhthH58nw7e+NsAZLHUt5/660QAJnrf1lD1rOtPcZB7IIbEpYOZZFhFiLhDEmWaU9mmkPDqwmnMSc+7nL8EHDEllI1uoATS+n03XT8T6q3sakPVpUGAjSHY8ZgVr8DGCeLT80k+8kV+xBiW8HrbyzVHLopFbS8ILYuI7kQUTaxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1j5mPn3Cef/krJ9oVZWI5lqu+E24v+R9gZnWg2+2L8=;
 b=dFVN0LoOdJqvT5bhIYirgY4tx3C1M3EFWPEBZBxD1ECNJyzqwAITl9viFTOJbYTSkj1N5tk85AmGa/aqNGd2zi52Rm3ATburWLR4nWdLqhLTe/Y0lxuFNGV/S/txtgOp6u1d9CKovRY8cFqYzbkkG2DNGQJR7I1UACnP1XTApOUr5vrzPFnZ8fBly8VTQzcJeaMHZhiOMLhss33g5O9mHjc/3aEM0ofM6ChbvU0LRYhYhQol7c3WQEjUdw78H++vh2WBw+nClMypVuqk0/WjVV4NpuL7aUGHmVdBl13FBRaoSa6/WFNuz2Lw8omDUTr8Yzqm/vg69oOICsCUigVWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1j5mPn3Cef/krJ9oVZWI5lqu+E24v+R9gZnWg2+2L8=;
 b=FO/pnevJeVh7Ww6RwyAQa9eGW/FdmyECLBMP6qdubTqJsVPTTmNz5nAw8U84+Yc6Z1P+ySzMQI92N/CKc+M6wo4dmYKXoHj1+jnaeHywFZj4vsm3wp8DVaBR3w+qcT1q9livkc3vwUJhl8Yc/n3dw4N2SDfnD06p3OJV4hAqPlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 08:31:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 08:31:05 +0000
Message-ID: <8a496494-07ef-48f0-94fb-b4e84a40d31e@amd.com>
Date: Tue, 7 Apr 2026 10:30:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynq-qspi: Simplify clock handling with
 devm_clk_get_enabled()
To: Pei Xiao <xiaopei01@kylinos.cn>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 broonie@kernel.org
References: <0c851587c90ae51d1498d18955aefc83fa41f17d.1775547057.git.xiaopei01@kylinos.cn>
 <827a6fdf-b119-4aea-9442-7f27f1383c78@amd.com>
 <80a108ac-c100-4077-b51e-8139f9ec277b@kylinos.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <80a108ac-c100-4077-b51e-8139f9ec277b@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 504c3b28-6fc0-443f-30c6-08de948002c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ECPFSL10J1773zknc2SPLHH6Q7K51g2bql+z672kYoo0hMakx5x/fGDLFaubcF1/j2FqKRNcIbVyJAklyZITvkwyE/KUV5pMMimiW8+T3eM+4rP4Neco/9trDPXThr/mVloXhfyESxJ3TclBSaERqE/Adw3f9pJJw2LtBqtqbb16bMiYMvB4Xqt0r5Z4xIgKGeFZJhHWw8Hp/2k7/9KYRfvAVDAHLANVNfGpbf2nP9Trrkx1/biLYT/XtkNiL+//sKvihKuo7gh3jE1DIbhq+ZPfFMBX1qPVAeLISuiENROYt9Yo6Q7Vct3ZBbDov2aFB7lNwVVWkHC0+eIqbdvKXZbYZ7VPdPoTMzLvGhCmapa8MO5aa2iuGwtrNaqHBjiDUYk0BzDa8sNg4eSFqOZE2frpyo/himN21uK+cyoecRY/5xLhnrGGd86gIpokqfgK9b9oyZhmzefNueUQkJI5vBs0+gal2IKyLxKp1VQep9U5KgwMvnCY3BZEpZ0/Notar8OcRvGrUlrTVJlqEcX+3mKKrydnpaacBc4CYTu1j1QNBQuulRrSfYzEuJbk1GVclVTPOcz2NY5118ApeTQfp6grZP5J0yPXv87CFyshN5PKV2K0h+dCQZ7ocLq6j8oPLlo9+mbDlZJTDdW07wBqXzcoCqY1RS0tujeIVMI1dGRBYnwaMfW+AHHhJT+FfadQ2jLZA4hKiiL6JvDL4qkXyd6A6rgJUhjnPwCIHp2tzaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2k5cjhqUi9jTWUvTzlyeGtsTVNGd1BpYXhydFhuVlJjaEdQVjhRMk9OUjhz?=
 =?utf-8?B?dEE3MnRUSkFxWUNUQStHMS9WaHNFV2VZOXhOK3kybjdpQ3NHelpuV3d6R2R0?=
 =?utf-8?B?Ui9ULy9CMDRrRkxtMk15bG5oeFhPZXFLNWowWnZZekxJNFVOajJ6WlQ5ZlVz?=
 =?utf-8?B?N1BDbjNOdTNHYjZIT0t6dk4zMDhkMUM1RVFETHEwUWpRNkZGcmJLM3R4aXFn?=
 =?utf-8?B?K3lRV3ZRUmRFWXJ3R2R2bWV5cGN6emlCSWcrc3ZlblN6MGNFcE5aOCtHcXk5?=
 =?utf-8?B?YzlucGhvZEJrNUtMQnVkTVJVcFVrL0FONzQ0aXhiM2I3M3JsdWw0UGJlZ0tT?=
 =?utf-8?B?ZUQ5WklldmlkaUVLeUdiZE5TakNnc0FpRjlUMWZHY20zOTlWRjZ2K2czQjJE?=
 =?utf-8?B?U3lLMHZ1ZFc5MjN2OWRWaUxVNHcvSHAzYXAyUlVsaW5FK0JqUWNWY2Vkb1Jm?=
 =?utf-8?B?KzFoRHBhdEp6bERsSlNHQnZtRXlBTitLRHllcEY4WUhnSzJuZTdza0Q1MDJS?=
 =?utf-8?B?OWNjbU1SOUVRMTBrZlB1WnZ5NldzVGlBcXlSNFA5cnFnYm5SSUZ5NXFCejc2?=
 =?utf-8?B?TTFhS0duYWVBSUQwUTdtTzc1YjZFMFVtRHQzUy90WjZvNm53UU1vMEF1M1JW?=
 =?utf-8?B?U0lUL1pGbmlRZlFjOWNPLzViY2YxQ0E2WUxrMThSNnhXazlSVEZ4SHM1M3Yz?=
 =?utf-8?B?N0Z0a1JNdjlvK3NFVTJsUzVvUDB6ZmRHejJYaHUyWnVCa2VsSkJod1owcGxX?=
 =?utf-8?B?ZUIzR0tOT0pveFVyZkpDNXhqMGpFdkV0T1RsV05VNWN6Y2s3YkI2WmhJUDNL?=
 =?utf-8?B?UHNTbml5S2lGdzhEM3VBZTg0c0RWTHZqRWhSZFFkNGFPbnFrbFo2QnNQL0Rz?=
 =?utf-8?B?UVk1cGk3dXVYNzBSc2F5eXZoNUg5d0Q2MEQwREljeHltTTJab2pDb0pTdWJH?=
 =?utf-8?B?aS9FbDBBMEMzWFB5V1c5b3pWcEdiaEpXZDhWRU5YbjJLVS93NklsRncrbFEr?=
 =?utf-8?B?bVA5eHFMUkV6MkFBZkMyUm9GbjdvZjZaTUptdFhrN0l6LzltTXdpOE1EbjU4?=
 =?utf-8?B?bkROb05UalM2ek1CbnVRdWNXd25XeEdkZVFBODh5T1JCemNGV2ZlUFZ3WEZl?=
 =?utf-8?B?ZGhsWFZ4SHpYZXlEZnJKVGU2WHZrOVJtSDNFS2RZV2J3NXFMUDEvb05BSS9k?=
 =?utf-8?B?RVZkcG9qNUxhVDdJNmRncGNiS2dZVXlMOWdJV0JVcU1DVk56NW1ZVldOQ3h3?=
 =?utf-8?B?Y2VTZjF0SVVYWWdtd2MzRml6ZHVDUnNucGUvYnAxQnRDMXJ1OGNZNHVHeVFZ?=
 =?utf-8?B?UklUazZuU29wT2R4cjJaaXFlQXFQeHZzV2poL1A2RUdsUnY2S08vSTJuVjdN?=
 =?utf-8?B?NHdaZkpobnN0U25GZENzaHJXVHE1ZzBlVXBoQW1iRDJiL3BhcEM1QUxvMUhO?=
 =?utf-8?B?c3l2UVE2a09Rd1ZuemFkQTBHc3JBcU1tZ3pEaHRBWFFQbDVQdjRpcVU5K3Rv?=
 =?utf-8?B?NHZ2VHVpNlVZekNTOEpRVkw5Ly9FZ1RQbHRaQk9pZGhRWVI3SDhjY2xyTTlk?=
 =?utf-8?B?dDZXMFBnT25VUjNzaWJNenRibVlRUWdqTGc3YmtpVEpqUHhEdUg0dDM0dGJi?=
 =?utf-8?B?QUF3UllCb2VtYWdVaC9tdlExWEJvcEVVdUpGZHVlSVAwWTRLQ1EwZ0ozYkJW?=
 =?utf-8?B?blJOUEYyZ21EUG5QeWJJVlJDczNZejU3N2Z2WGlTRWtwVkpJM1VzYWd6NjJQ?=
 =?utf-8?B?SDZ2anBSa1lScWFVREw4QnRpVXJvN0V6M1hVRDlKOXVWSk5iTEc2Uy9WSzF0?=
 =?utf-8?B?RjJxME1mRlcxUFRzdFhidTBuY3N5UWIzUStBYy8yRHJqejdZejdzRnhCVVBZ?=
 =?utf-8?B?MmdOTVpFYkdGTUpiWTR3QXI1MVFhcTZQcU1DbDJsZi9rbDdpa0RDeEUwRVRw?=
 =?utf-8?B?Tjk3MHYrdTdPZmVNY0thSTJpazg4eEJldHlnckx3RTg0TTVqaWc3VGtVbHdo?=
 =?utf-8?B?SFRkakM0VzdlT3B0YTRWalVLU3hmSlpFemlxQ2JCMjFNNEhWQzhJOUpuREJk?=
 =?utf-8?B?czhIOUZmZnVDV3RvenhCempwd2U3R3pHZXRyQ1FmdEpNblAzMlFKMUVNRDI4?=
 =?utf-8?B?MUhDN05ORTZERWRCWlFDMThwQUljRzIwM1JxZlNZS3ptbEczK055M283YlZN?=
 =?utf-8?B?SmlKdFExc3BySG5zUHZwMDg3S29hcnM4WlE2NlN5dVpmRUtLa1NuRGI5eUZp?=
 =?utf-8?B?dDNNVHRTdTRscmdDU1IrZmM0TW9wUSsveHY3SnBYam9nNVR0Rlk2RXhVQTdv?=
 =?utf-8?B?TVNZOGxYUytHSGJ2WXBZT1BtNUpBV1hJcXhWNTcySXBkaU80bkdHUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504c3b28-6fc0-443f-30c6-08de948002c1
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:31:05.8109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhGu5ict55DmJb744FevHM6Shn5fzWyCCztrC1ej4vAjUOm1lNuggqjeQmk/csn8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504



On 4/7/26 10:14, Pei Xiao wrote:
> 在 2026/4/7 16:01, Michal Simek 写道:
>>
>>
>> On 4/7/26 09:32, Pei Xiao wrote:
>>>
>>> Replace devm_clk_get() followed by clk_prepare_enable() with
>>> devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
>>> the need for explicit clock enable and disable calls, as the managed
>>> API automatically disables the clocks on device removal or probe
>>> failure.
>>>
>>> Remove the now-unnecessary clk_disable_unprepare() calls from the
>>> probe error paths and the remove callback. Simplify error handling
>>> by jumping directly to the remove_ctlr label.
>>>
>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>>> ---
>>>    drivers/spi/spi-zynq-qspi.c | 31 ++++++-------------------------
>>>    1 file changed, 6 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
>>> index 5232483c4a3a..8c3975030d0a 100644
>>> --- a/drivers/spi/spi-zynq-qspi.c
>>> +++ b/drivers/spi/spi-zynq-qspi.c
>>> @@ -661,7 +661,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>>>                   goto remove_ctlr;
>>>           }
>>>
>>> -       xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
>>> +       xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>>>           if (IS_ERR(xqspi->pclk)) {
>>>                   dev_err(&pdev->dev, "pclk clock not found.\n");
>>>                   ret = PTR_ERR(xqspi->pclk);
>>> @@ -670,36 +670,24 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>>>
>>>           init_completion(&xqspi->data_completion);
>>>
>>> -       xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
>>> +       xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
>>>           if (IS_ERR(xqspi->refclk)) {
>>>                   dev_err(&pdev->dev, "ref_clk clock not found.\n");
>>>                   ret = PTR_ERR(xqspi->refclk);
>>>                   goto remove_ctlr;
>>>           }
>>>
>>> -       ret = clk_prepare_enable(xqspi->pclk);
>>> -       if (ret) {
>>> -               dev_err(&pdev->dev, "Unable to enable APB clock.\n");
>>> -               goto remove_ctlr;
>>> -       }
>>> -
>>> -       ret = clk_prepare_enable(xqspi->refclk);
>>> -       if (ret) {
>>> -               dev_err(&pdev->dev, "Unable to enable device clock.\n");
>>> -               goto clk_dis_pclk;
>>> -       }
>>> -
>>>           xqspi->irq = platform_get_irq(pdev, 0);
>>>           if (xqspi->irq < 0) {
>>>                   ret = xqspi->irq;
>>> -               goto clk_dis_all;
>>> +               goto remove_ctlr;
>>>           }
>>>           ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
>>>                                  0, pdev->name, xqspi);
>>>           if (ret != 0) {
>>>                   ret = -ENXIO;
>>>                   dev_err(&pdev->dev, "request_irq failed\n");
>>> -               goto clk_dis_all;
>>> +               goto remove_ctlr;
>>>           }
>>>
>>>           ret = of_property_read_u32(np, "num-cs",
>>> @@ -709,7 +697,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>>>           } else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
>>>                   ret = -EINVAL;
>>>                   dev_err(&pdev->dev, "only 2 chip selects are available\n");
>>> -               goto clk_dis_all;
>>> +               goto remove_ctlr;
>>>           } else {
>>>                   ctlr->num_chipselect = num_cs;
>>>           }
>>> @@ -728,15 +716,11 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>>>           ret = devm_spi_register_controller(&pdev->dev, ctlr);
>>>           if (ret) {
>>>                   dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
>>> -               goto clk_dis_all;
>>> +               goto remove_ctlr;
>>>           }
>>>
>>>           return ret;
>>>
>>> -clk_dis_all:
>>> -       clk_disable_unprepare(xqspi->refclk);
>>> -clk_dis_pclk:
>>> -       clk_disable_unprepare(xqspi->pclk);
>>>    remove_ctlr:
>>>           spi_controller_put(ctlr);
>>>
>>> @@ -758,9 +742,6 @@ static void zynq_qspi_remove(struct platform_device *pdev)
>>>           struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
>>>
>>>           zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
>>> -
>>> -       clk_disable_unprepare(xqspi->refclk);
>>> -       clk_disable_unprepare(xqspi->pclk);
>>>    }
>>>
>>>    static const struct of_device_id zynq_qspi_of_match[] = {
>>> --
>>> 2.25.1
>>>
>>
>> There is also clock manipulation in zynq_qspi_setup_op() which needs to be handled.
>>
> Can I remove this code? If not, please ignore this patch, and I apologize for the noise.
> 
> In zynq_qspi_setup_op:
>           ~~~~remove this clk enable code
>          ret = clk_enable(qspi->refclk);
>          if (ret)
>                  return ret;
> 
>          ret = clk_enable(qspi->pclk);
>          if (ret) {
>                  clk_disable(qspi->refclk);
>                  return ret;
>          }
>          ~~~
Yes, remove it completely.

M
