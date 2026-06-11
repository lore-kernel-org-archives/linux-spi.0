Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463635E1D5;
	Thu, 11 Jun 2026 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167985; cv=fail; b=Bciy4hiD9h6r7sgumWoCW5INjD+eqDua7Jzagcbde3XdzixeRYh1rh2vTHixaJT9mAM4AAP6PY0AGWrAazzcmGCGkAM91yP8XfX3E/ccSupflaw2DN238KCXs0Iwp+Anikq1E3Xahaz6IiDawfRO/5X2SaG15URRh7hdH+X6Hpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167985; c=relaxed/simple;
	bh=DtBZRn3QTu5lzHX6KTD4AucCgl+HRrt2RyW90fLWjt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EVK+8GJUql5NIxAOw5hqkEDGZa+pandmcK40txlXvW+03oSIl6ut46HfERcBpD2i5ToWsel16+xmW4B2PajoQOOnfQS6fA1lD9BktWKVo+7RdP0aK4QAZTwMDegUwZgAZmSp6tPgWgR3/hrxJZ2sXBuzDhzqZrBj0uxgIG0cIdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wI2MqGkc; arc=fail smtp.client-ip=40.93.194.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wI2MqGkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP6l49UKYl8JzvJdEzApBkl0uYiQslg5DUfmi9CYRJylt9l9GrQ7XvH7l2KUS2wGa3wcrB/0PcYwQkGXKVcz55qH3Za3JhVMbYPtanY9GbeYjcFq/7VZmjGIgxscGdZylt13Cci2V6oA+CpCoqbEPcS4pEK7Q68RLkkF8GXIarhT2KDQCJzFy3axAlWx94w0lGkQyEfLgg0Pem8NCUdCse1MHrkSUOqt8SrsS/+y2rWGE2yQ93BzlY9zXGLpHO6QVJrxt+zftnlykG5/LNQRajEhN6bNqEUtsmY+IZnCyNYwleSdX3YlZWymBrI0gXDLPvZ8jZcgmRdEbm+m+HbSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwVQ6imf0q4ZVLx7p5Q+hDttv8FeEqRhJq/Ey3eLKn4=;
 b=IRsMmzoyFz/R+T8sJfV4ZnFqjzbBrCrCWp+Vsqib5KSjgWqmuCPCy3UsFjGel7WfO2/60V+j/fmZOu2Rma67kC1HEjYMpq0X0LzGPJf9ahliUQLHyaQwq9y8wPjTyA2liGQC/vT1WnKRwKzbiodMY73U9r5RBjE4gVwhzb0YixsorZdeoDZzH93ZkhIHonWxkzP7F3ryQ1j0VIiQGnTZy5j/4BJpCE6RqugV6M/LEqtXvMYHpDPe31ximIUETLK3T2uHYJaum0OM4hHsHk3Jk+O+6ELRIg5bjzKXV9bKlUj39oTi4yAoesPSQBShp9GrFWzxaoGi1Ijqwj53TVMEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwVQ6imf0q4ZVLx7p5Q+hDttv8FeEqRhJq/Ey3eLKn4=;
 b=wI2MqGkc5SW8v87OiYLUsnP1ZJ5CVfEEjrSHLCFTqx9VqzFnfmEWY4I+Qc2ZIWr+0POEIXMwbuHOdTI7dLfb4kkwsIA3ecThm1fhyDmnDWUOCUutpQNwDEvM/54azPltMkO4nqm+qvBS1QPkPHtiAcYF2lDPuWzAI5aH0+7jEUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA5PPF6407DD448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Thu, 11 Jun
 2026 08:53:01 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 08:53:01 +0000
Message-ID: <f98775de-f2a5-48c1-8d30-c39d29d0c4dd@amd.com>
Date: Thu, 11 Jun 2026 10:52:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx: use FIFO occupancy register to determine
 buffer size
To: lars.poeschel.linux@edag.com, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Lars_P=C3=B6schel?= <lars.poeschel@edag.com>,
 "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
References: <20260611071033.1937983-1-lars.poeschel.linux@edag.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260611071033.1937983-1-lars.poeschel.linux@edag.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a756c2-39e7-4c22-ef22-08dec796d803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kIZ0q2l0GQ+W1IC2d7rZAFduMgDZeXdH1EoGgrHtUf9FIF98WxJ7F2WYdEx+GQhWDXGR1z+/EwsvY6kQvkMXxRyO9Nz1XqOGRfDru5W2t1eb+YX3+Zm1SxpL6Fweb0tHp6TTammL1MyRVk7d2xlHMEJTmy0XIMxmpFIrZ+ZpoKQ+FPRcSafiTmnf86C+w0fm+H2Bx0LRFd/yu+/LbTbdfu54IE/fL1qAjQ6wp1elOMpU4rgl6Iv2VFLMyvl9HG5FBxD/0wEiUPzZ6q1KLTcOIGzLckA0divDcisqs2XElSEpEbDusUqnK7dI3QixpnQuoW8uirGF+1SodV/pw9gWWGcVtZDKEENJXjSf776lO+hR4l7RX4G5poFB7l9TABj1lCztgRbyWWR2+wWXChJ1YlST47XVnT9OgfT9ukPOviFWOMJCo+RPRrmJtfonTGxMGlxK3NRpDPgCNftyGVEwSibEFBob+jotxRo8utL9Yfz6RGEeHpuw0Yg4FmKN9CWv2dOMCm7sapoGSNd7zoS17qJ+0ctXlcXz5qkxFvLcCZt/5pM1oNiQMsqORoJEQJhlEUREw/Z1mgyTmWQbGo1Abb5fSGqRjEEqE0Kc7Jpqe7QlpflIOu3PneJPmW+TsXDOWJKaqx9K1SSZw+9hyCYIao5CCx0Oez7YME3psijhvSwPbB3wLU68UQ4i475cr/Wt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxiK3VlK3Q2am9JQTJnTDFTL2dQaWtwQUdDc1pyVU9JUE9MaUtxdFFyWDNU?=
 =?utf-8?B?L2ZzR1c0blZNNTd0bDZlOWFNNTlXNVhpTk9ReGVmaUpDd1B4R3JHQ0VtUlhi?=
 =?utf-8?B?TXhkSVRBRUZoSWkzNVZZODBKSmkyWmtIVVBVTHloOGhWKzNWSFVINStiSFJP?=
 =?utf-8?B?bDFVT2ZYck1aVjJqT2w3UEx6WmxseSttaHNTMVd0amZjRStiRzhhYUtZamJE?=
 =?utf-8?B?VDJvV2JtWGoxT2t0Ty9PRkVVVjhEdDJjVTN3eFNoZzRJeWR4YWdieFgyQTAz?=
 =?utf-8?B?UzlHMjhrSnZJVkIxV3dSSS84eTFDUjRpdVp3aXc4c1ROMzNVZHJUbmVzeHBx?=
 =?utf-8?B?eHY4Y1BLL3d1Q1ZXZ1dUWk94dGRLM041UlEvOGJGTnBOd1kxdDIzclBKelNZ?=
 =?utf-8?B?d2g5Kzg1a3B5aWpPT3ZVWlY5MmZvazFFL3g5UHhXWHoyQ3ZmUnAwK3pMNjIr?=
 =?utf-8?B?cGlOVTd4bVJjTnArQ2dQKzhlU2ZLT0JCZy9LdWFsWlNRdVNFWmd2OWdZaXdB?=
 =?utf-8?B?WEUzWHJpdXYvS3FHOFJwZHZ6RG95RkRyaDF4akxTNzVqajF2SHlRWjN6SjBh?=
 =?utf-8?B?UlkwdGRIeVRMVmY5cnBVYkhpcWZ5dlplZXBJWXI3SE5HaVN0YzJhVlVycHNE?=
 =?utf-8?B?a2w5by9SNTFZYXAvT1FhdmVLM1crZ3BMRTN5ZXQ2V3lWbzc2Q0pxcGMxc3Mr?=
 =?utf-8?B?cU0wN0FZOURjL3lZVk40bG9CdEFLZ2pVdTdGVzAwc1BEQ2IveEwwOUNrYmxX?=
 =?utf-8?B?eHBzdzZ6V1RMekRoMVRYVWw5R1Z1ZkVvNGR4b1Z5Z3BiK0hYaVBqdGR6ODV6?=
 =?utf-8?B?Q3BQY0FNZmwxbkJDdVNLZ0Q2amt2UzEwMmZUanhrdzBBS2hJSG1Va1dyOVNV?=
 =?utf-8?B?UkF1UnFMNkRZejl4QWdLRm1wUVpsN1FIZ3ZtWnNjZGtlS0U2Nk1GdVU4WU9S?=
 =?utf-8?B?S0pSWUxLMDJsb3dTalp4Sk5jTXVLZVFjYzJQVmZ5c1IrSnJrMXBHSi9aRDg3?=
 =?utf-8?B?bWk1TWxINVRJRkoyN0htYVhkaHh1NmpZcGdZbGZqZGoxaWs1OWw4RkJWWkVX?=
 =?utf-8?B?OXgxcHRrN1Z1aVpPSmUxNm5mTy8rZlRVeENtSlJQSHZ3bldLM0RRUHM1WElv?=
 =?utf-8?B?dXVoQkxVeDhQdXhpUGdaT2w2bjVCOE9PdEh2OWJ5NHN5RVNlOWhPamszVzFh?=
 =?utf-8?B?NVFtRXVxOE5LVXZtd1FnVGl6SVozU1ZybzNvRjVDNktEMDNYVnNEUmFhZ3F6?=
 =?utf-8?B?Tng2UmlkeVJjeG84WElONFR3c2lEQUlRcXEzbmpwd3QxZjU3MTEwMEw5cnN0?=
 =?utf-8?B?RmtUUU1PTTZTQkx6TElFL2pBSVE3MFp6RVZsQ0lsQjlYYXpKT1Q3bmIyZ3I0?=
 =?utf-8?B?aHE4YmtKZW94cTNqRzcwVFRKdmxuN0lTYitnVzBJdU9OUHhXS1dwR0hCYkZ1?=
 =?utf-8?B?Wk1XU1dRa21yTFBjS3o1UzdGYzd4WkNyajF0aGdJeW5HUVFNRE1MTEY2MjdP?=
 =?utf-8?B?SmREMlFNRk56ZW5mZjlFNlFLTDFZdDBTVi9VZ1AzekVVeE0rNEw2K1RYbnFm?=
 =?utf-8?B?YVdUbVc2TGNOaWM4S3dVcW90TGhnV0FkbDNVZTZCNjBhSG5FSkk5ZXpRWE9z?=
 =?utf-8?B?aXExQUtld2hFdndWNTU2ZGMwbHRmWE1PWjYxVWxwM1FWYzRaa3A1N2pjeTJX?=
 =?utf-8?B?OVNSa280czFqb3hUMlhLMXkvQ2p6SmNRWks2WVhqVjRyYnpadkg0VThGNGk5?=
 =?utf-8?B?ZmJPVTBnR1JOdSt5WHg5Z2tRMDhwdXNXMUVtOGRGeGovYkFGZjRzeXJERWx1?=
 =?utf-8?B?U0k1T3ZwSzMwMSs0ZzZ3czFsTWdBSjF4QTNiQlFhdFg3NE5rcmhTd0lEVkFD?=
 =?utf-8?B?eHdJdE9QSHA5Q21jMmFkdHJPSU5nQ0hyUC96cDhhbVJZNTRiNCs2UW1CVWpy?=
 =?utf-8?B?dVhQeWhqRTZJZi9uTlVHakVpendxdldHakN1S0dIQysyRmtZSUxVU1NRSE82?=
 =?utf-8?B?T1FwcEFpR3FNTHJGK1BVaUd4L3EvZjdXTTNxeXBzRExxRjF0TU9wRnJZRTdG?=
 =?utf-8?B?cGlFQUZFQnNBbStzYzdFSUZZU0Y4ZW1Eb1BKdVFBV05EQ0lSQTlwTzNPemVP?=
 =?utf-8?B?bTV2am5kejkxQklqSThhMjV4aUExZXJGUytNcmJYdlNYdFc0cWxPdXZQaHJU?=
 =?utf-8?B?UmpvZ1VjY0Z1RzlnVjE2WitOZEFLdXdVQmJ3RFBZdTRzTHFRanJ4NmFuekFP?=
 =?utf-8?B?aWNNbGtBcitlTTFGcmhQVEVjQzNlck1Gd0EvRTZXMURtVUV3Y0txSkRRaDg5?=
 =?utf-8?Q?rk2b94wuar3uyaayFk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a756c2-39e7-4c22-ef22-08dec796d803
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 08:53:01.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTQujs14VcdfDaN/YDHtltMIzeBv7FujiJect+EfrCstWHDbcEEdu/mOwSiW12dQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448

+Amit,

On 6/11/26 09:10, lars.poeschel.linux@edag.com wrote:
> From: Lars Pöschel <lars.poeschel@edag.com>
> 
> The method the driver uses to determine the size of the FIFO has a
> problem. What it currently does is this:
> It stops the SPI hardware and writes to the TX FIFO register until TX
> FIFO FULL asserts in the status register. But the hardware does not only
> have the FIFO, it also seems to have a shift register. This can be seen,

I don't think you should guess here


> when writing a byte to the FIFO (while the SPI hardware is stopped,) the
> TX FIFO EMPTY is still empty. So, if we have a FIFO size of 16 for
> example, the current method returns a 17.




> This is a problem, at least when using the driver in irq mode. The same
> size determined for the TX FIFO is also assumed for the RX FIFO. When an
> SPI transaction wants to write the amount of the FIFO size or more
> bytes, the following happens, let's assume 16 bytes FIFO size:

s/let's/for example/


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
> The new method for determining the FIFO size is to read the SPITFOR (TX
> FIFO occupancy register, value = occupancy - 1) after filling the TX
> FIFO to obtain the true FIFO storage depth, which also equals the RX
> FIFO depth. In non-FIFO configurations (n_words == 1) the register does
> not exist; return 1 directly in that case.
> 

missing fix tag.

> Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
> ---
>   drivers/spi/spi-xilinx.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 9f065d4e27d1..2d31e30fc4eb 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -54,6 +54,7 @@
>   #define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */
>   
>   #define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */
> +#define XSPI_TFOR_OFFSET	0x74	/* Transmit FIFO Occupancy Register */
>   
>   /* Register definitions as per "OPB IPIF (v3.01c) Product Specification", DS414
>    * IPIF registers are 32 bit
> @@ -377,7 +378,9 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
>   		n_words++;
>   	} while (!(sr & XSPI_SR_TX_FULL_MASK));
>   
> -	return n_words;
> +	if (n_words == 1)
> +		return 1;
> +	return xspi->read_fn(xspi->regs + XSPI_TFOR_OFFSET) + 1;

Based on pg153
Exists only when FIFO Depth is set to 16 or 256

Based on ds570
This register does not exist if C_FIFO_EXIST = 0

It means this is not going to work with all HW configurations.

Pretty much you wanted to use this register to find out how big is the fifo
but I think in this case you should be just fixing logic around +-1 caused by 
n_words++ in a loop.

What about to change logic to be like this? It is clear and it is without any +1 
logic and no fifo is handled separately?

         while (1) { 
  

                 xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET); 
  

                 sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET); 
  

                 if (sr & XSPI_SR_TX_FULL_MASK) 
  

                         break; 
  

                 n_words++; 
  

         } 
  

  
  

         /* Handle NO FIFO case separately */ 
  

         if (!n_words) 
  

                 return 1; 
  

  
  

         return n_words;

Thanks,
Michal

