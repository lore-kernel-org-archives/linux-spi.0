Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7483A9DAD;
	Tue,  7 Apr 2026 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558375; cv=fail; b=QJdDCLK/2qcfKrlarzSMwQDM4YyC2xePQU+YQgC1etU/6eVQE1ssxU89o+xYYrbbtfY0+dL8w+x+kk5GmTETozEuqKYffD4rAx/78N7jAjnJNEJKpWbBH9C5ctjsaaEVo9IBLuhCqY8XIRoHSMnnRHinPJaip9lUjW8qOlF4pgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558375; c=relaxed/simple;
	bh=qcf/MM8GE9NMZO8CTM6E0O5F6GzN+V+YCZB/aOkJIWw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqDgocGQxx8xaDXJhXtmqFGXi7ml3ItT7kAikTFOWfgf6JZCwVwCbd1RZKMptfTF//yCA3xGaLt+CBg33FZft9UGEpM/JkZQONukhjcroiW+ZyJrATlg9hvOP8FL4WdeiLbzxcm6ic95u6wPNde2AmapvT3Y6hGfU+WVVeZaaNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mAzWwOW8; arc=fail smtp.client-ip=52.101.43.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mAzWwOW8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u23Jz6ZiSO3XNJzDVg9UC1mQjNPwMzOq8+DdqIAiZfDdjmiAWqIhtHxMia8HLJY649kCopZq5M2krdSfJ/FZ+0TCl/OoN/qn4YAEe1CI+DezUD7UPOYM0yzXNQYuz3QdFNnCgw71yhdxpdT67Y8D1YeAoEBOxcNXt0ARba/Ow6pnIfA6fyx5eSPIzn4ae1hQ54ri9bFHrR5S8Cfzm6fuhy6zwHbJfbgviK9TgD7IQ5SmHAH9k/tVZD93BpxXPp6QPn5OvSNyW9NzIznoxQhSS8SAuJc3mPItUTAFSY/BkHpb+1o90GZe7TRb8dIMTQ84gHTHGLYvJ7AQVWBRYJgQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvAZ+629QhyDhpxz89pJEI2y/qsOO1WfdAtF9a4QTMQ=;
 b=jZeqmQl5llMYcjCm1dAAYgf8l2LPlzoyiXinUkrMSHvw91LZub6O/lB4AJC5XACN/O3JVLLeuyYo/Z/otFXqzGrx2+RtKHfNr8hU8bcy1MZ+MnwTqku49RPSwM9vRG+Ob2oFKs4Iu/8rgSVp8TvZRbvbT8rpvZsCgPxnIHn74spquy4VB8D/lbCttGU5qs+SfS3fVm3ixy8ktZRBJdAwpoH7mBfWXZzph04uNPJVYQmr9PfrZwi7edc8zxTmIOmOMpnG8wnCMpUmRtN7CGgoIRiE6JKlbASOrkPhOlqOB6qIJ9wcUvRGfnKr8w1pqu3lWjbeHJliDKTgv1xqFXIdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvAZ+629QhyDhpxz89pJEI2y/qsOO1WfdAtF9a4QTMQ=;
 b=mAzWwOW8GV0PaUUyI14nqqO4nGEBWKYjrGuw/IfjEt9KeV10LRAOr/nmBqzj6QxeFSSYc7wi0zDDzBJIqC2zKzg4WS9cmTXTlLqQrOnV3dVXX0lN0HIjKhVJHOJJXEZbcBjOYNzc3koWwJ1gkUaEgo6jiBWgvVTHHfWVkFjvy6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:39:31 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:39:31 +0000
Message-ID: <6e2bb8a3-28c7-45d7-aeec-fab6e7db90ee@amd.com>
Date: Tue, 7 Apr 2026 12:39:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] spi: zynq-qspi: Simplify clock handling with
 devm_clk_get_enabled()
To: Pei Xiao <xiaopei01@kylinos.cn>, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0018.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6f4a40-0739-4db3-1978-08de9491f3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OY524SRKH6HZMMibJHft0U8U5zjwnB9nv2WVjy2U2FnR645f7u2nAEtsL5J+Uq1gS+rUn68/1alrl/K0VhA6YxVQ7UV+zGLCWGvdpEKaFuylEf4JKV/DSxrY1bc+yW1JvJoL4KW/s5GeNowFzE12k91Te132SqX5sgZNKqhmuSKek0EqNT22uwpgkaTZcuOFd7PSCvy4rDr4LO7QwkSvtQqSul4y4XYBF84CUSxs7chD2xTeH5PE3nPiJA5e1/y+JaSzE2k1K9zBjvOWo4Ql4BK7ftsXJ8uwNiESMdJnOsufKDCv2xVehoFlsY4VheBQ77f5jMxvbIY3CA1lmL64wSplOt1D4hyIVXaaJ3eHpk4k2mvABO2g2ys3kz38vanCRV05gTe/E808Yb0MB5j14201xHjWwgHKbQsjqrQ+PBqYPyA4c8Z5x3Qr2P2r+RT/EIWXmxfamYeBvaTK4HyDkHGq5Vt5igUTGcRtBnOmqZHHtILe9myByASZ73TUjaZIgnxvzmaGCczRO99xoNKF5dmUby69AuCtQsM7epkQH1P4WSPkjYEbpR8GvUXtEH6keP6f9p//XuYjJ0uAkfXTOmfTaB/Zucm2IlFVQkj5qc3cJrBMrGxJEuSMAYzpFaP10k/dXZVXljtvM3rKpOrOilYcQP3Wx0O0TWoC7Xlyk7XFAUHJAVNhG4LyOnjlHmph3WJ+4PrwKGumg9MtxW/wx1TpyoXtxDRYC2F9cQjlhNw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZ2TjVXcXV1SjMzcUdGMG9WaE1lR1FpSnRjbFdUQ0JZYUdGc1YyRzJBMGF4?=
 =?utf-8?B?MXlWaURTaVhtaGR6SGFudEN5SDRkOGcvTERIOWtoUmJ5QWx4WkZidFIyY3A5?=
 =?utf-8?B?a3RxTVd3ZmkybG84b3Z3OGxVT1JqMm15UjZobHNkeUNvaFBhM1VBSHFkSEp3?=
 =?utf-8?B?WmpPZVU0T1BrRVk0aUo1N3ZTdmpwSUJSVmpQNGxFSlBZSmdTOW5wbFdNamxn?=
 =?utf-8?B?TnVoL0J6a1kzSWM4NWJWYStYdkJsQ2NrUzRGWXRZTFlMSG05MCtrWlJPdXBE?=
 =?utf-8?B?WHZia294VVJiQVF6bEI5ZHgxVnc1TWxwZkk0WVM5ZnF2citERGk5dFMxSnF3?=
 =?utf-8?B?UmtGa0gveGZKT0ltMXRpTUViUWRQRHkwbHZXV2lwSjJWYjNUS1NlSU5MUGhh?=
 =?utf-8?B?UVNtVTQxNlVwdmgyUHVFamlURjMxTzJnMGttMEJiS2lOcXVpcU9XNXB1N2Ix?=
 =?utf-8?B?UVdZT1BERkszVGxxSi82NGZBK05US3MrTnkvbkM0R1F2TkFqZjNnM1g2azlL?=
 =?utf-8?B?c1pwRURuU1lZYVpBQW9wVlU2MzNIWVpnVHpSdEZNemhnNjR1UmZmTXREZ3Fi?=
 =?utf-8?B?VE80RDNheWEvZ0dNcWFreVdlUWd2U0VJbnkyUWl2eVJnYVArczI0R3hqUFUr?=
 =?utf-8?B?WU9uWWlQclhkSFZpRlhLUnZaaW5WcEUyR2VuT1VPaGpVNE85dytBUjB0cjgw?=
 =?utf-8?B?c1lUV0hFZ0N2RUtHeHY0NzhaMXVUTHJMbzlUWlgwclMzNm1qZFprdlZSTVdv?=
 =?utf-8?B?M1ZOUU9CVHI3WFdkUVdFQ2g2Smo3aGhQUmpLV2J2bVhpMDhPckRINnpUaE9z?=
 =?utf-8?B?UDBuc1l1dkdVRXladHZvYnRzY3VldDBSQXNURkN5ZW1IcVVmbWY5dFdJWUR4?=
 =?utf-8?B?VVF4UEMzWkJ2MTdCUVVsbjZIbXIyMFcvVS8weURzZk5SalVERW93K2srcDBX?=
 =?utf-8?B?VGl4SEp3WXZCOHlwLzNIYzQ2dW9xV2tQaXJ2c1JJT2VIOFlqcWlXMGRtUk1Y?=
 =?utf-8?B?L29jL0ZEVGxBMWtkRlRiYiszdnc3dXRiSjZOYmpHSXp6WGk0bWFuR1l5STlN?=
 =?utf-8?B?b0xoTGxwY0Jyckl3YW1YOURsdjJQeGN6SXBESG8ydmhTSlpvcjhqeHlNRUZH?=
 =?utf-8?B?cVJMVDVVL3gxTHhzQWo5Q1hWK3JuU3ErazkvMmxpOVZrQ3FFZEw2WVNvUVNG?=
 =?utf-8?B?V0UxY1VHSzlsZ2hQUVFCQ2pKdlkvbnk3S1A0T1AxNWJXQXMwVnJ3dzBocGk1?=
 =?utf-8?B?Y2tvdGV6RTdUQll0SFppLzJhUG5LVnVpS3d1WVUvY1h1L1ZFRnhuOTkrdlIy?=
 =?utf-8?B?TFpJU21lMjlXcWw5VjMwU1FjbktKekc1N2NCaEtqZFgySU8vWHpGb2dCaW96?=
 =?utf-8?B?U0ZQT3E4U1RrWHZzcHkwaWlMQ2tWYWVsNURLTXRVQjU0UCs4elJ1TXU2Lzkv?=
 =?utf-8?B?L0ZlYmdzamhFTm9FT0xiZFl4bFV6RzNFQUVBOHpVNTJYSmFYeHRnb2psNlow?=
 =?utf-8?B?SGN0MXpuRnFFbUR2R01wMS8rMWNlOXdldmlBL2c3TXZodWZZOElyT1pROUla?=
 =?utf-8?B?UWNpbnZRS3VkVzlLMnd3ZzU4ZXdwZ2VtRGJrQ0hjOXdUMUthVjNFaXgzeVpE?=
 =?utf-8?B?UDduN3BXK2Z2S0w0RHpNMXd0RFpCK2Q0aGpOQ2NZMDI2TVNvQXJnd0RPOVNa?=
 =?utf-8?B?UXVTZFlQZ2FRM1JxOXYxc0hIYkpVRUQrZTlxNWgyalpkLzlUOFFydlBnR2hR?=
 =?utf-8?B?T3F6VlJ6RUhMblcrbDZoZmNqNW9jaEk3T2gyUFRoSCtlS21PblVBWHU1aU0v?=
 =?utf-8?B?alRUcDIxaiszU2o1bUlBT3c0NEZrZDlRWnQwOVZYbHpLekVEUyszVENlQTFN?=
 =?utf-8?B?eEdWclVJMEFOZktXOHRCcEdPZUFkRGo5Y2loalZmS1JvaXR0U2hQSHpISE5G?=
 =?utf-8?B?WDlBUG5pa0lheXM3elpOck9YUEpiZ2lZa0ZkVFl2WFlvdzh2dVBralp6bUhm?=
 =?utf-8?B?Mk1sbk05Z0xnbDdIVkxSc1ZWMjdPNmVDSnVlclVEeVExSVN6TkREZ1BEbS9R?=
 =?utf-8?B?VytnZno2ekozZkEyVi9iVVltUFhQa0dRQ0NaRW5wQk9hdFFyNVNiR2pJbHd1?=
 =?utf-8?B?bTlnOThtKzZFdlgwU0lwbDFzWENWeExrVStVanlyWFRZWEc5TnV0dzl0K1RF?=
 =?utf-8?B?Rkdnakc4OGRxRGM5aDNwYXpaRDRGSnVPWkZLZXl3YlQ5Nm5STGtIamk1aE9j?=
 =?utf-8?B?WXVCN1lpZHhLVG1Jb0d3MkxzZEZ1NzZSREFpV2g3V3dHV2JJaUJUejU0VWxM?=
 =?utf-8?B?UmNJVFU2QjBKMWJhNEJ0K3d6aFpZdWZrajBMTU5Rd2l5cGtIa2xmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6f4a40-0739-4db3-1978-08de9491f3ad
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:39:31.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPXxsrNH/FpnhgdEC2c9/yUDQZvtOPmjZ8uRFQeNQQ87yYSu7iAdOrahN65VRw0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333



On 4/7/26 11:55, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
> the need for explicit clock enable and disable calls, as the managed
> API automatically disables the clocks on device removal or probe
> failure.
> 
> Remove the now-unnecessary clk_disable_unprepare() calls from the
> probe error paths and the remove callback. Simplify error handling
> by jumping directly to the remove_ctlr label.
> 
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> changlog in v2: remove clk enable in setup_op function
> ---
>   drivers/spi/spi-zynq-qspi.c | 42 ++++++-------------------------------
>   1 file changed, 6 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 5232483c4a3a..af252500195c 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -381,21 +381,10 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
>   {
>   	struct spi_controller *ctlr = spi->controller;
>   	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
> -	int ret;
>   
>   	if (ctlr->busy)
>   		return -EBUSY;
>   
> -	ret = clk_enable(qspi->refclk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_enable(qspi->pclk);
> -	if (ret) {
> -		clk_disable(qspi->refclk);
> -		return ret;
> -	}
> -
>   	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
>   			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
>   
> @@ -661,7 +650,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>   		goto remove_ctlr;
>   	}
>   
> -	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
>   	if (IS_ERR(xqspi->pclk)) {
>   		dev_err(&pdev->dev, "pclk clock not found.\n");
>   		ret = PTR_ERR(xqspi->pclk);
> @@ -670,36 +659,24 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>   
>   	init_completion(&xqspi->data_completion);
>   
> -	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
> +	xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
>   	if (IS_ERR(xqspi->refclk)) {
>   		dev_err(&pdev->dev, "ref_clk clock not found.\n");
>   		ret = PTR_ERR(xqspi->refclk);
>   		goto remove_ctlr;
>   	}
>   
> -	ret = clk_prepare_enable(xqspi->pclk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to enable APB clock.\n");
> -		goto remove_ctlr;
> -	}
> -
> -	ret = clk_prepare_enable(xqspi->refclk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Unable to enable device clock.\n");
> -		goto clk_dis_pclk;
> -	}
> -
>   	xqspi->irq = platform_get_irq(pdev, 0);
>   	if (xqspi->irq < 0) {
>   		ret = xqspi->irq;
> -		goto clk_dis_all;
> +		goto remove_ctlr;
>   	}
>   	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
>   			       0, pdev->name, xqspi);
>   	if (ret != 0) {
>   		ret = -ENXIO;
>   		dev_err(&pdev->dev, "request_irq failed\n");
> -		goto clk_dis_all;
> +		goto remove_ctlr;
>   	}
>   
>   	ret = of_property_read_u32(np, "num-cs",
> @@ -709,7 +686,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>   	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
>   		ret = -EINVAL;
>   		dev_err(&pdev->dev, "only 2 chip selects are available\n");
> -		goto clk_dis_all;
> +		goto remove_ctlr;
>   	} else {
>   		ctlr->num_chipselect = num_cs;
>   	}
> @@ -728,15 +705,11 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>   	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>   	if (ret) {
>   		dev_err(&pdev->dev, "devm_spi_register_controller failed\n");
> -		goto clk_dis_all;
> +		goto remove_ctlr;
>   	}
>   
>   	return ret;
>   
> -clk_dis_all:
> -	clk_disable_unprepare(xqspi->refclk);
> -clk_dis_pclk:
> -	clk_disable_unprepare(xqspi->pclk);
>   remove_ctlr:
>   	spi_controller_put(ctlr);
>   
> @@ -758,9 +731,6 @@ static void zynq_qspi_remove(struct platform_device *pdev)
>   	struct zynq_qspi *xqspi = platform_get_drvdata(pdev);
>   
>   	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
> -
> -	clk_disable_unprepare(xqspi->refclk);
> -	clk_disable_unprepare(xqspi->pclk);
>   }
>   
>   static const struct of_device_id zynq_qspi_of_match[] = {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
