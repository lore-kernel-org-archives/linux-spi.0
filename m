Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43A32ED27;
	Fri, 12 Jun 2026 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264767; cv=fail; b=gAkD0kwfSkqpoRsAsMOZC3PSNkhKZOgnNMlvxhLEI68+3zrmMnfojmTtIWWA6AGyb5s3C0r+F63BE5YWcPJ4er5aOESi2PqrkHqIsHVHvqQUdnLJpg6xNDrJeFQiEkXk/UV3Jv5PQflZaGM5fhdAOArF4vKJaNttWOjVraq/M0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264767; c=relaxed/simple;
	bh=JwyAqgSvwtX3G+npX7kwNaz2+46gW7n2lRsUthc3cJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLTrKBuFmsVLAWEMCTuROyoAURxy7AQSwOIe3wJ4oOiBPn8Hv91jvwY0CEYSoCiW9G965yc6LISBGF/kf+y987RF7a3ItN9NZidCPrK+0LFrXva6OmDGKiibyuT+lZx+cMpn1HRubVdZO6vl1qTkUIkClbylbMz6sLxw778mb3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZR34DYdm; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZR34DYdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNAotS32XuvYctyWQFo+zXcZElJeMTaF8pnNMvljkgf4MaUMGZAd18fQOmgIpi1khdIV6W4i+2julTVLwBmm/wCbCsOjGthzcCotIOXK9YsDHLIGIhGU6Lpv0PC+sxioWrWhSDeYMjzoVD73xThdEpkiz/KMeilkkOkSU2aAwjXtoQhjKSkijB1QD71Rw4/PE8Ody7YLO5RKbeokxWpzlqyyZeoGQnvDE4ca7zwAH5UWeAdchF+FUqqMy+Htn+kAXip/fNEXoLgzMK43gGPPFcxooRsFuKrHOUl59lZTqx2SQnPkJb81iL06gupKrMuVAwhFlHWymAnBFOjl/+GdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgTyYMn2vnfQf0GzBA+JieNNR5tHrpRCnmjZziTOBBk=;
 b=S6xDiBf2tmlfOaMyNAWDVrLMKQxNUBDXAaOI9tW6h0whFnuMOQMAhPA+5kewUt3t2ze8yYtmomq8XtptVU9vBkGmAVTqgLAsL4Ks//KZVwCS8C0c7FK5I7i9qcWd8hppQyrFe41WxMr+jsUnExFz4r1OClym4hf/lwUyPAII8eN00Pm0eaZ3VVpo2nFtO5JcYeS9ozneFIsyfOeKWrum98881f1zi0ZivfWQAjIrAXdHNsv8TtY5ia4u+dhMbxKu9c5O6IigfF2yi4XozfsXEBCHjLKfUIEU4FKu1G6QoRWCqHdT/+AClwjRpkJg2KTL/BJwOt4qF9qv8r5rFXeI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgTyYMn2vnfQf0GzBA+JieNNR5tHrpRCnmjZziTOBBk=;
 b=ZR34DYdmoVCBAE1iRNDWBmgw8mmOMP24iiFQe3yMaRMyICjUOSuqIBGLo3ZPAIW0WZTwblLi6Qd1Y1XP9kegMGB4cZ2jhAErUyZmHvaI8ScQscrTd9NKyOv9elWkC465lZ/ZH/fVBTUb1K9u0BIrhotEAJs3c9Clkluh3Gt/rMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:46:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 11:46:02 +0000
Message-ID: <6b7965bc-001b-4e69-be5f-546599aaf6a1@amd.com>
Date: Fri, 12 Jun 2026 13:45:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: xilinx: use FIFO occupancy register to determine
 buffer size
To: lars.poeschel.linux@edag.com, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Amit Kumar <amit.kumar-mahapatra@amd.com>,
 =?UTF-8?Q?Lars_P=C3=B6schel?= <lars.poeschel@edag.com>
References: <20260612105244.9076-1-lars.poeschel.linux@edag.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260612105244.9076-1-lars.poeschel.linux@edag.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0271.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::44) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a4846e-a498-4b3b-0066-08dec8782d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Pxsvpa6zY8lcPuC35VHpCpV+aZpsa8nSZwvmyWlLbeDc3IlEAgtnVDHTPbThhTpL1RN9ad2oqlN8ag7/Pu104QSqFdtQ/w6cmbLFfCiUwWEMoVmyUDMWKl6EZBTs4QjnXW0fTxn/38GA8+gzY0vMA7Ymnricg6SL6ZWUpy6wqtuVn8sdDzKF+6+brQ3wS5V+u+BBIhRlCkoR5M2K8icShHduueGKbfcFBy5I0bBGDQ6MHKEH5vcwGLIQ2zqUHvrm4PJ0v+nssLA6N4ZwhxTgrzUk9PF9jXrAnqHBG48LWV4PK9Gl0BQ8GBEqIgT4ysMH04vkQKtKFsNM/pkCa6ApRl9/bzbgvlCxzAOTWW3jJh83ahKTLLojsjun7n4ApTHzKfIvP5YPOlddjYU7wZLSvPaFiLefzA4GCr2yyM6dmSRa2qHeiqJNg74WFx/nKtpYzcd8aAum09LVrsjMhyRtVquz1LX4MxFvlbhplz1+Dg4M4fSf3kgHyhgHVPiIi1VFuU+9ibvIgKn8poTAQQ5kQk1ieASvFjbzBrq9sJgXAIArCt6uzMQ9ega03kcvHYBhnmCh3h5tHg0xyGqKIXofonMFCPzNZQQOv4RDLeaSF138Z40z14eqNY/c4sj4p4ztT3blNKCDZVCbdbO6Xfy5jbe4xaZbaGEBOyOdgEvmAJwomv0XY9GtofK3FOwnpZCe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNLeUcybGdxN3QrdjlOd25nWVRQdnlKVTNmLzlYTnN1U1EvWlBPYWhiSEQv?=
 =?utf-8?B?ZEtRcVdoQTNZQWVGdDBQTDcwY2g4MzhmS3dQSXNobWpjY0ExRUFuOExYS1Q0?=
 =?utf-8?B?K3BaNjlzMktUb05VY3R2dCtJQ2RNOVJkNmZUbFZyeGVtWmlLS1FnSDRpWXc2?=
 =?utf-8?B?anhLQ2pXc1VMc0I0Y2Z1UjNkVkVhUkJ2L1BPK0NvSVR6U2txSjZHcmN6Qmtn?=
 =?utf-8?B?Y2RGL1hMQmdwRER4c0dzd3Jad1NjY0VMTkNRclp4RDBaQ1EwcGZFMlV4UWpW?=
 =?utf-8?B?SmxhU0xTell0YXZGLzFPZkxwZXI4MHByZGlZUnRMOXVMV2dUSEdJTnhnMzE1?=
 =?utf-8?B?NDBUQ2EybzVzTWNNQnBQS1R0eE50NUFEN25HN29nMmp6Z0FwY04yOEdyem9P?=
 =?utf-8?B?ejBXSmVmekJsR0JVREZtdTdQK0c1VXNoamJvL3BCM3ZCMU5ORnVubXVrc0gr?=
 =?utf-8?B?UFFVODhTMGpwZ0tmYitIdzQ1UWpLVGlRSVNON3ByQ3JmVHF2RUFNd3dQUmw5?=
 =?utf-8?B?RjJhZjZncTc5aWJaYlRVajFZVkZXeHU2UEl6NkxJdWNyTjJ4TWVTMytnZTVJ?=
 =?utf-8?B?eFRQY2NaSWZhU0lxWGFySlJDVVFnNTBxVWhSeVZZbWNybHJpYVRNNTE1Zy9I?=
 =?utf-8?B?TzQ4dEdMUUNUa2dHVzFadE5KWHVvR0ZuQm4xbnJYNXc2YitGbHJBUENYcmln?=
 =?utf-8?B?eE8vT2VHZU5mV0tMWDdjYTNGcEVERUdrQkhxWWNzbWc2RktKTEZkZCtPbzE5?=
 =?utf-8?B?TEN0azdLVWgyYjNiUVVOZkRid3dZTldBSEJ2dmlqVjRqcDg1dU02YkIwWVhq?=
 =?utf-8?B?Z282RmxQVkJQWm5MZ3dFV09qMktRL3Exa012OUYzemZZTFZNZnlmRVE0U2tI?=
 =?utf-8?B?RUNhU0NQVml1Qk9ZWHIwSHRtRFVZUW5jbDRvMWdhYnlhVGpOeDlHYjVMdUkw?=
 =?utf-8?B?L3piUzRYck14cjdWM1U4M2s1a29kM085dHQ4Vm5Ed1g1RkE2SjlIMmN6VkIx?=
 =?utf-8?B?dVkvMUpGOHU0OVBMaVJCMU1LM0RvK3NpaURmSVo5Q1JJc1VKdDN1cDdpQTlE?=
 =?utf-8?B?dHZweS9Xa3NvNkprS1l3VkdSakJNbzJhbk9McU5NcUZ4Z0dBYUNYNHUybEdF?=
 =?utf-8?B?amRQS01FWnhiZVhVVzdRSGY4VXgvaE84YVNLenY2QjlMQjBCNGJSd2RRTjJK?=
 =?utf-8?B?T25CTVdDYVhFK09VUytNNXZRSXNEb1l3TFJkYnRxV3hmQUJyTSs0UjEyZ2N3?=
 =?utf-8?B?Z05tMDdPNlFxSjgyaVRNUWlHSlFRM3daUnppbzFnUWJsbjFlYkR6N1hSV3Ez?=
 =?utf-8?B?MU1JclRlU1RBYjczdHMvVVVRcThCRVlDU3ExK1VweWhudTlpa0xPTkVHelVF?=
 =?utf-8?B?WEdmOGxWa0EyZXptNlVQNS96cmEzbXk4YlVuUUJSUUhiaS8wU2tpWXNiNkxm?=
 =?utf-8?B?QmhxTkxJMG44YXVJVjhFeTRkdDBwQml3Tk01RGx1SHk3Q2M3WVppaHYxL2Va?=
 =?utf-8?B?T0k5UnlRSVpNMVN3Rk1rR1d3TG1sYWVXa21LNDRMZUVVc0dLa3FWWDhIZnRr?=
 =?utf-8?B?dk5hU2N0VXBJUG4xOURWdGxNWkhZL3hYTjJPYk10ekJmbmtXZ3h6eGg5NEp1?=
 =?utf-8?B?aVhiay84MWxod0crbUdyRVdKMktReW96TndBZDZJNXhmSVd3V3UyU3pocGlu?=
 =?utf-8?B?K1YyNnlyc1BxWVFMSjlyWUVDYWlWMCtyTy9PZm5QNnpoOVF2SnQ4VVk0c3dK?=
 =?utf-8?B?ZEJYUHdaeGowZkFtZ2kweERkTURxSXA0SGovNENzUmRBYTFndDVsQ1dlbS9s?=
 =?utf-8?B?K3JCNkE5U29xcXlxR0lLOC9uM0pCQUxRMGdxRkEvS0k4cTByTkRmeGltNjJV?=
 =?utf-8?B?ZXZBN0tCSEVOY3NHd243L2xicE5XOW9Fa2lUa2ZHeDdLeW1paG0xWnlDRloz?=
 =?utf-8?B?aU1WcTZCVXBVSEdSV3o0SzNwTEwxb2lUZVlySHFKMTlGOFRRY3lJcmhuT0FB?=
 =?utf-8?B?TlU4ZkQ1dGFLUE01cVlvNEdWV0poWVVQSlorQnhvN203ZFlJYjlmN1NDRXVa?=
 =?utf-8?B?d2oybnFVcUY0RlZ6clVqQmFaODE0VURwbitKOXp2RytCMVJQcEpuZElMZkJW?=
 =?utf-8?B?VFVERUMxZWFoSjlYVW8rYUJOTFI3cEhsVVBENHQ4ZkYvU0RtanByTk9LZzRE?=
 =?utf-8?B?MTZRSjg4bVdkVU5zakJiRXNZRytGV0hxQk1UUWhNekRuTDZabUkrMWp6T3BR?=
 =?utf-8?B?aXROcnQxOEQwM08xZUYyUFBwUkg5M0FkeDJGMmhOTVRlUTAzSkF3RlNNV1Jl?=
 =?utf-8?B?WFk4T1RTUldmckVUYUM5VUJUVC8xOW9HblRZYVBwU01jdjJiSWViZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a4846e-a498-4b3b-0066-08dec8782d75
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:46:01.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSh81BQdmhIVnCWQbd3G1qakZfAhdiiS3mOTjeVoFtxPxI0phDHHrwc29o3R3JHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331



On 6/12/26 12:52, lars.poeschel.linux@edag.com wrote:
> From: Lars Pöschel <lars.poeschel@edag.com>
> 
> The method the driver uses to determine the size of the FIFO has a
> problem. What it currently does is this:
> It stops the SPI hardware and writes to the TX FIFO register until TX
> FIFO FULL asserts in the status register. But the hardware does not only
> have the FIFO, it also has a shift register which can hold a byte. This
> can be seen, when writing a byte to the FIFO (while the SPI hardware is
> stopped,) the TX FIFO EMPTY is still empty. So, if we have a FIFO size
> of 16 for example, the current method returns a 17.
> This is a problem, at least when using the driver in irq mode. The same
> size determined for the TX FIFO is also assumed for the RX FIFO. When a
> SPI transaction wants to write the amount of the FIFO size or more
> bytes, the following happens, for example with 16 bytes FIFO size:
> The driver stops the SPI hardware and writes 17 bytes to the TX FIFO and
> starts the SPI hardware and goes sleep.
> The hardware then shifts out 17 bytes (FIFO + shift register) and
> simultaneously reads bytes into the RX FIFO, but it only has 16 places,
> so it looses one byte. Then TX FIFO empty asserts, wakes the driver
> again, which has a fast path and reads 16 bytes from the RX FIFO, but
> before reading the last 17th byte (which is lost) it does this:
> 
> 	sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
> 	if (!(sr & XSPI_SR_RX_EMPTY_MASK)) {
> 		xilinx_spi_rx(xspi);
> 		rx_words--;
> 	}
> 
> It reads the status register and checks if the RX FIFO is not empty.
> But it is empty in our case. So this check spins in a while loop
> forever locking the driver.
> 
> This patch fixes the logic to determine the FIFO size.
> 
> Fixes: 4c9a761402d7 ("spi/xilinx: Simplify spi_fill_tx_fifo")
> Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
> ---
>   drivers/spi/spi-xilinx.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 9f065d4e27d1..b95485710e2f 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -371,11 +371,18 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
>   		xspi->regs + XIPIF_V123B_RESETR_OFFSET);
>   
>   	/* Fill the Tx FIFO with as many words as possible */
> -	do {
> +	while (1) {
>   		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
>   		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
> +		if (sr & XSPI_SR_TX_FULL_MASK)
> +			break;
> +
>   		n_words++;
> -	} while (!(sr & XSPI_SR_TX_FULL_MASK));
> +	}
> +
> +	/* Handle the NO FIFO case separately */
> +	if (!n_words)
> +		return 1;
>   
>   	return n_words;
>   }

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
