Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB77433BCE;
	Mon, 20 Jul 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562922; cv=fail; b=QQAdR5Bmpcg1b1aqd2CJRUd4n0ByVW7TtD9HuncRVO8jRm8efRBtsMGeh17cUSRFrRSG6FmVeTy9fzysMknQDmxGPmIAk724g+4ieuv4bzMqgKYckTNAp6ugRSUh7JT5f8/rZuIEASAgR5gFhE5AAjHAFDXVBLSApTMIVfKHZtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562922; c=relaxed/simple;
	bh=pYqTmJnBFFfecxdkTkmTEXrAdeJhQWPamJ00AWh7LzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9Cmbej3Q6t8tN4PMpNgK/D6fd/MDF4xFtx/P7UHkGmNYtZVxrPYOONUJXiwsJudt56p+USk6gcK+L3QuZZItHF2BEiysE20o6AAkiNwEXu6vgX3CDVEDOeCTFOeei1qttkegyUGaRDA9Gy8mt8MeF6dEeieulXBqZXkZahjQzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBO6ILrS; arc=fail smtp.client-ip=52.101.85.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBO6ILrS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RG8lwYmmkLjzlaLP3XR0R9vOzCzKKvKcOK0+AIRGxNbN5dOiEuLCZIJZr+XepgtGXAYP7OkAK+5qyuK5v/xIjWEqjjYfJwRXllSdGO9vpbf/7Rr4JpxJCdkNO2PIcW5jCcWG3DOZCpMKUV0EC2bWUP0X//ywCxncBZUSKrGdK9z5kHx+9EUTOcTX2oQq2bUOKb4BGIi0zka6yffDDX1prdvrFPxeJa73KmvhKJh6OCI8pjfVjN3zCBIILGKEBMpWd9vk6y1X6yohRllYADeoSpbNj8vGvf2kZ1roBJRuJ3aXgHfyLvdA4XDyinJR1x92jsr44PPHXLXYjoK6XLvXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e3Jn77Cj72OQYkbA/ABnsrMr41rIGwqgovvK4bvwd0=;
 b=RCjDVQ0ozGhX3vBzDFBcNtMxmLJkX/4uOh6JHjgNFl2/T/xzGBMqu2U6Gysei5/6gfYmdhAdbHpAxkDxnF6FlKyOQxcCdaQnGD0Id0CIyZAHChRphKpaQXM+udtjPA1SMbXGIAsaDG1/+d3XnFVQUztPofgsESpNaB/3K8wAK3xRHB3HuB41D4nXg1a5VatzokpRQSqyrc2sfAp+Mxe9kLQsqxCZn+Fw/HvMEFhaueNtjMFInLbcvHihGFyruTAeslXqmUnrlU2cF0D22YeugE6uV4aOL1dA+LUaOxHm7rJ8rbjLvTBTcwlCDrZhl8oPjio0iQE/oIx/nnZDfo0TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e3Jn77Cj72OQYkbA/ABnsrMr41rIGwqgovvK4bvwd0=;
 b=WBO6ILrSja8BV2xADT5++ugO/IMI3012CBUIO0tGuFOibIR4lJgfeDP4xILiqRjNaFQRQd/APdI7Erxc/eJxtGvzmjAB/6T887ps9DPq5oyLfXazUx9jsWJeBzxduehP/NQwPz/Us7M7QnrG2hCZ4guUuBiaVSF4SWIAcMxLNJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:55:18 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:55:18 +0000
Message-ID: <81d818c5-c7f5-43b5-b8d2-202250ad213e@amd.com>
Date: Mon, 20 Jul 2026 21:25:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-cadence: Move TX FIFO full busy-wait into FIFO
To: Srikanth Boyapally <srikanth.boyapally@amd.com>,
 Mark Brown <broonie@kernel.org>
Cc: sxauwsk <sxauwsk@163.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720125510.60166-1-srikanth.boyapally@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260720125510.60166-1-srikanth.boyapally@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::17) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: d78025b4-0b1e-4714-eab0-08dee6774c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yIWV6wFgR4UgyfyCuVoJk7u18KHQOPRAgdPJXo7QTdvmHuZkF1Epeza3X8HA5v18vnDxWpOBKIaxRUDIsrTndGlIv/JZj4Mpz4+1o66C62zQSdT07XATxnAFu0YvzdsEHzqW0+L6PbymOvEFIIzQEqhj5NtH++QtwinISa4jwNQLCJ/o+sZJQzVq6A88CLERq0/0FIiaEaBV6lYVCMWAi+30fVosu2Kv0pPfyK8Pm3y0FXRtlDMdhzN+j2whpsKF8nLWv7s9qb3l2JVZVd8Rw1mZOxDQkVFJcrzxZlL0Oh+gI2fiZ9K6UsUMifK5yceH0553h82CLS5NuDsuKpvN8k+tAVZGmxD5KAEs7+/dvhGBbHHXMWT0MO2PmIhmOBQfK2C0I0iHRTp38P9ASyQE7ucUmZz5gqYtDD9TGUut/7gfjxNiG3iN3H+rFRu+8ZOkJQOTM8IE0brr3i9UP/xzleM2/02Pg2pYTJGHAN0s0BTv7n+RfCeau2GJTrLcv32zRzpeyvR1IqAer7SS4difFyATyaqY5anhQ2i2qBv1dKiwE9xfwv8FtUW03L63/altDjLFbZO6H/5yDT5e33tbrbdaVMUkdxiAHu/uSuuZmHarjAlIt0vyFTypJdbDOttdqOInhtUYW84rRy90xfa50ydvww5iiruICu8uCJbwJEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhBV2xLNUNtaUxueVRTOWZSOUFEbEN0eTVJcGtyd3UweC9HYzNVSUVlazc2?=
 =?utf-8?B?dFlteFlkOHpMditKM21idW8vNEY2RCtuSTRLNVJ5QzgxZFpJaWc0bE1xdnl3?=
 =?utf-8?B?OXZMNTVvK05SMExpTytzL0NwOFdLdGZZNWdqZnF3eU8ra0pPREVqTjZTeitJ?=
 =?utf-8?B?V2NnYm4xUlh6eWYzblFVYmZuVGV2aEgzZEc0WTVFbkg2TFRGODNxRVVRQ1Ns?=
 =?utf-8?B?U2JhZHAxL2pXSWVBa1dPWmcyN1JIZnB5bUJYZHU2bDZUWXJYRFlrRU5SMkx1?=
 =?utf-8?B?OW1VRGowdjNlTHNWVTgvZ2FWRXlQenZiNi83Ymk0SVBGR1Y2YnBGR0lmRjQ0?=
 =?utf-8?B?RWdmRVUyRjhJUUIrbXdNUHVWMlpyVGp2WWZ2NkFwYlcvYVNPQ2tsNW1FaDZR?=
 =?utf-8?B?RFYySWVJaDF4Qk8vZm5xOFRNczE1d3FMVmhnWFN4SFdMaUw3cS9veGtmZXlK?=
 =?utf-8?B?MlZnNXUyaEVwc05xRHRYVjJFbUZZRFM3Q29NQnJJSUh6cU5NazdMVmxpbnl5?=
 =?utf-8?B?K2ltWVRKbk5ObWNBTUFWZ0M4L2dONjJucnpTTDlFTFZxQVVoZThqY3NLV3Ft?=
 =?utf-8?B?UFNsL1lJdWFHTUp3Wm43bUJRZmhiT0EyRS9SUnZ4RVFOWVVOOU9pMTBzVm5D?=
 =?utf-8?B?L0RoOFh1RERXUTFBSW90emVoMitrQVRDZE91Q2ZYVWJzVFlYVzg5ZTA2U0sx?=
 =?utf-8?B?UFBvRm8yTkNwSmsvTzNSMWVDQ1Z1TlhpK0lNVTN4V1MxVm1UZGlpNmxwZEFN?=
 =?utf-8?B?K3dqSTBTYXJBakgxdWI4NzNCSHpnMjRIKzhqVnhEWGhCdTVXVE9hSURFbTVh?=
 =?utf-8?B?KzBNMGdZSlpGRlVvWm1ubmJsbFhHYzRZSStJVys3YnN1UHROeGpPRXE5WGxL?=
 =?utf-8?B?VGdENFlOT3JXaHY3Z3VHWXdRbVBiTHN6cUIyQ0ovQnhpbk1NdFlEcjZmUE91?=
 =?utf-8?B?TDYzMjBlZDVTNGMzaGlFT1Z6ZVMrL0YzSi9EVFFscVZCcENzNjNDYXN4V3h6?=
 =?utf-8?B?aFlxSnVIMERKNW16VG83bjZQcWNJTEliVzNVZGx4ZzJpbmloS0Q1MjN6R2VI?=
 =?utf-8?B?UGFFNWlvRld2K0l5TDhuS3VPWWI2eGhKbVpJRlBpZ2JRM3I5MmpOcXJvczlY?=
 =?utf-8?B?Y0pQN3Z6WUc4NmNTTlovd2l5cVplSFVmT1FkQlFabUN0M2k4UFRzMmpMTU1p?=
 =?utf-8?B?V1Btdm1pUmtFRldua2pOcXZ4bFdWTGU4cWdZcTltTjVvUTV6N3VFL1k4UDE1?=
 =?utf-8?B?cUFhSW4vL1pxbDlJaEhlaXB0MFZuRVNEZDh1ay9SWmhjTm1iS09kR0ZtQVZk?=
 =?utf-8?B?ZGd4ejZaaVNndjlCYmNLeWFZZVY0UVRVUisrZ3BLZlpTRTZxZ3VVeW1SQ1Z1?=
 =?utf-8?B?VzJPUVEyS3IzZTRqbjgxZlFtVmVHak9uZXd4aWtKbGNlUldsVWlZNmR5bkJF?=
 =?utf-8?B?aTQxSUJ5bXZHTlUxb1FDZGNsQ2N2RXZMUXN2RmpROHQrUE9BVW5tdDh5VVRZ?=
 =?utf-8?B?VTRqWmEvcEhQSWxOSi9ZQ1kyNm12NmRSM3c1OEpBUUthUEFVdVhURU9iYUdC?=
 =?utf-8?B?YVNNci9hbCtpenhHeGlEOFR4YlYwQksyY1VOM0hMZk0vTFZlQjNZMGZQbWlm?=
 =?utf-8?B?bGtVdTBkc29WVnZQT3ZHajF1d3FPVlRuRTVxSXRiVFFmRVlwblFKSS9PTUdM?=
 =?utf-8?B?emZ4OWtvOXJWK2VCVlRqcVBBTUNVbDlpd2pSR09aM1VhN1lwdnBOSXlCVWQ4?=
 =?utf-8?B?Vm52eTFsMnNRcVMzRjhPSXNTMGpJZ3ZWMFJINGIyZndGQzI2ZmdkaEQ2cGp5?=
 =?utf-8?B?dlZKWHBPWm5YYmRQN3ZjN0tGVkpaK3Qzek1LTWtmTTB4RFVidFUzUDlGdlRt?=
 =?utf-8?B?TGlaUXRXM0hKcktIUldCelRFMmR0eTFxaGZPQy9yenhNM2QzODdXTnd6L2Fy?=
 =?utf-8?B?eW12UFk0bVZyRjQyb2tsemg0aFBJR0VwWWpoa3dFMTdhQnRWZGlPcXZKdWN3?=
 =?utf-8?B?VENpUmlya1BzYUxyRXlYWktOSUJTand1WkZqck5qTGVQbithWHhTL0tKWFpJ?=
 =?utf-8?B?ZWYzMEUvTEh4YmppdW5MNUh0WWVWVU9TSWtwSzZ3WHc4NS9zN2c0UXh6QlpD?=
 =?utf-8?B?aEFEWE0vZEdOdWlOWm85M3JxZFBzOXZEUW5EYXduNllKZmdXZVZxNDJPZ2VY?=
 =?utf-8?B?TmZqc3FFSkF2dmJ0bStDb0g0S3JyYXZtRzBKWFhYd2NKT0ZaQXc3MTlHWGtG?=
 =?utf-8?B?M0ZJbllnbzZENVdLVUs4cjJBTHpyM2JFZDNFV24yQjZCS29HbzQxWHVWbUFH?=
 =?utf-8?B?WXFsdUpQUDdFVFkzMCtzcWFtcnA5UXJoWklDQkpTVG5pcTU3MlRYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78025b4-0b1e-4714-eab0-08dee6774c00
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:55:18.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epgtRXRV6IKWBadxaEAfD5JuD7wNsosIQp4LiD1AtHXM5HCmuF58441vRzj5hk/9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

On 7/20/2026 6:25 PM, Srikanth Boyapally wrote:
> SPI host transfers could intermittently stall with spi_transfer timeouts.
> The TXFULL condition was checked only once in cdns_transfer_one() before
> cdns_spi_process_fifo(), so if the FIFO became full again during refill,
> writes could be dropped and the transfer would never complete.
> 
> Move the TXFULL busy-wait into the TX path of cdns_spi_process_fifo() so
> the 10µs back-off is applied per FIFO entry during filling, ensuring
> forward progress and eliminating spurious timeouts.
> 
> Restrict the delay to host mode using spi_controller_is_target(), the
> controller is passed into cdns_spi_process_fifo() so the check is made at
> the point of use. In target mode this delay must not run as it causes the
> target to miss its transfer window and corrupt data.
> 
> Fixes: 49530e641178 ("spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()")
> Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
> ---

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!

> Note: checkpatch suggests usleep_range() over udelay(), but this code
>        runs in interrupt context where sleeping is not allowed, so udelay() is
>        intentional.
> ---
>   drivers/spi/spi-cadence.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index 9b4e5b7013ae..af1a05e78492 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -388,11 +388,13 @@ static inline void cdns_spi_writer(struct cdns_spi *xspi)
>   
>   /**
>    * cdns_spi_process_fifo - Fills the TX FIFO, and drain the RX FIFO
> + * @ctlr:	Pointer to the spi_controller structure
>    * @xspi:	Pointer to the cdns_spi structure
>    * @ntx:	Number of bytes to pack into the TX FIFO
>    * @nrx:	Number of bytes to drain from the RX FIFO
>    */
> -static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
> +static void cdns_spi_process_fifo(struct spi_controller *ctlr,
> +				  struct cdns_spi *xspi, int ntx, int nrx)
>   {
>   	ntx = clamp(ntx, 0, xspi->tx_bytes);
>   	nrx = clamp(nrx, 0, xspi->rx_bytes);
> @@ -407,6 +409,16 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
>   		}
>   
>   		if (ntx) {
> +			/* When xspi in busy condition, bytes may send failed,
> +			 * then spi control didn't work thoroughly, add one byte
> +			 * delay. Only in host mode; in target mode this delay
> +			 * causes data corruption as the target fails to prepare
> +			 * data in time.
> +			 */
> +			if (!spi_controller_is_target(ctlr) &&
> +			    (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL))
> +				udelay(10);
> +
>   			cdns_spi_writer(xspi);
>   			ntx--;
>   		}
> @@ -460,14 +472,14 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
>   			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
>   
>   		if (xspi->tx_bytes) {
> -			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
> +			cdns_spi_process_fifo(ctlr, xspi, trans_cnt, trans_cnt);
>   		} else {
>   			/* Fixed delay due to controller limitation with
>   			 * RX_NEMPTY incorrect status
>   			 * Xilinx AR:65885 contains more details
>   			 */
>   			udelay(10);
> -			cdns_spi_process_fifo(xspi, 0, trans_cnt);
> +			cdns_spi_process_fifo(ctlr, xspi, 0, trans_cnt);
>   			cdns_spi_write(xspi, CDNS_SPI_IDR,
>   				       CDNS_SPI_IXR_DEFAULT);
>   			spi_finalize_current_transfer(ctlr);
> @@ -520,17 +532,11 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
>   			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
>   	}
>   
> -	/* When xspi in busy condition, bytes may send failed,
> -	 * then spi control didn't work thoroughly, add one byte delay
> -	 */
> -	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
> -		udelay(10);
> -
>   	xspi->n_bytes = cdns_spi_n_bytes(transfer);
>   	xspi->tx_bytes = DIV_ROUND_UP(xspi->tx_bytes, xspi->n_bytes);
>   	xspi->rx_bytes = DIV_ROUND_UP(xspi->rx_bytes, xspi->n_bytes);
>   
> -	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
> +	cdns_spi_process_fifo(ctlr, xspi, xspi->tx_fifo_depth, 0);
>   
>   	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
>   	return transfer->len;

