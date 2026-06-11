Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022086.outbound.protection.outlook.com [40.107.149.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A9332EBD;
	Thu, 11 Jun 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177798; cv=fail; b=b2biP89p7prDuncQDi9uJI7x7TpEzBrhGe4hfjRRERiOjJrJG/Ka10AW0Ci/HLxUpYyq5VISb8/DL2G1co5Vq39fb4G9MeLud0Q/GfHwAPSWkR5XLXCsVJ4qPmpjwuILkx5QGm6wM2xDTuw/O8mRzkrrxGkVFiqBJPIXahSZelg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177798; c=relaxed/simple;
	bh=2Jb98GQjCEtxQBnhT0CA0Wue5Jx2zt2IznnuNn7AQTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQF71Kz5mgiHUu7ly4GMwOwbb09HaHUwAfGXDdJyqwBU/j854Rt1xhw9sKOniF9vmKFWcKdW1CSJf+Rut+K/cAp5M2T5Xemu982qaHPG4njIMflFs0evLsUBwGnP6PoYzzhGwRYNYaRh7RZ0cOFX8eqFAfbG7lmsANtPuwI6CJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com; spf=pass smtp.mailfrom=edag.com; dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b=cnmh+5bN; arc=fail smtp.client-ip=40.107.149.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=edag.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edag.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edag.com header.i=@edag.com header.b="cnmh+5bN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiFwi96ShvScm+qUvw/Xby1Bv7zAEdz/iheVf7OZ14gMiUI+N+rwEZtr1FkibYXo/0+QqWjqVpJQsa9FBg9vA8hBy4DqiZZ2q9oUlVGvSYUd2d0l9rjyTgYSznxae0iHAwIq++qmLqQ1UJFQSp3oOrJhMCNweZo3KuaSHLKGGqMJbtc05b6A+HYfRxStYLPndgtxxTT3HDNo62iy5PSrFYQaznuL31lo5ydtZuA6kG7lx39y7zMcCLXiXfO5s6tyHVkZ8YYnpVTrtIvnCys3mCDkfDCm6Eu7PLpHtiiFGhUCPFXqxVru/dW46gohpZGs66d9J9mv2MlyTCflrob+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGQxzxEboZ8gMTXzH3bEHfwNZ0LJXL+AOLglnUW50ok=;
 b=vzzwrhHrmgozm7+buFhJfPKtCKwkPMxuhylIVw05VKE1L4+bE5Sulfhk0bllukJ0hlz4gIDWVQSoRZ//Y/spsJmKfrmJQu7S0T3kQu5H9ASP9AOqEEa1PChXNOC8iFJCvFeXoFnBjbYMATWFDxQVZZRzYEyCX9MtmseYFmGWRW3Wdj6D/et5fOUJgFUQfO+HBS5j1iOetaFOmT7OVuapDigqyiQ6++PKCP5fCHYtCBuqp5L2tZGwdo5WLupLrrIiqkS6lDA1JKJxHGcG7M6Zcd1olVDHqgUTFrkzzzZdajzmFkEfUEhG4j++6qDONVjrDvDGiFuw4CaA951srolLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 80.156.190.52) smtp.rcpttodomain=amd.com smtp.mailfrom=edag.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=edag.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edag.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGQxzxEboZ8gMTXzH3bEHfwNZ0LJXL+AOLglnUW50ok=;
 b=cnmh+5bNhf6fakuB/1A1ZMFfTSom6Utj9lV7pOJ73d6yWejLnjS77aFaIxAs8waXYDT90lFL3UeO9lAV5QLwD2PcHYTK3bUWTb8C0e3AJua1Nw7KMdvfTNXsW2/J4XZ2XQm+fnrbG8MaLsV/jRARidr/JjnUI6qK1twOWuoIzWYO0B8+GoGgfmUKmlMTub6WQ4qFhCuYmjSN0Qctxm5uJMAKrHz5tUuVteNaU4YEVqwIs9tJTHAM9GO5ZUduUC19uQQZKq/4KU2gDpbLuttxbofkbxmq1j8vMAsb+7JU0wW0fUJWkslOkyOOr16BLgfMLaOYgbbgK6gjbCwNLHMnqg==
Received: from FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:d0::18)
 by BEZP281MB2850.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:71::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 11:36:30 +0000
Received: from FR1PEPF00000F0D.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0:cafe::a1) by FR4P281CA0419.outlook.office365.com
 (2603:10a6:d10:d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 11:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 80.156.190.52)
 smtp.mailfrom=edag.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=edag.com;
Received-SPF: Pass (protection.outlook.com: domain of edag.com designates
 80.156.190.52 as permitted sender) receiver=protection.outlook.com;
 client-ip=80.156.190.52; helo=mxexo02.edag.com; pr=C
Received: from mxexo02.edag.com (80.156.190.52) by
 FR1PEPF00000F0D.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Thu, 11 Jun 2026 11:36:30 +0000
Received: from lnx06-mail0601.edag.de (lnx06-mail0601.edag.de [10.82.17.139])
	by mxexo02.edag.com (Postfix) with ESMTPS id 0E87BE073D;
	Thu, 11 Jun 2026 13:36:30 +0200 (CEST)
Received: from x06-sysimap01.edag.de (x06-sysimap01.edag.de [10.82.18.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by lnx06-mail0601.edag.de (Postfix) with ESMTPS id F2F3480215;
	Thu, 11 Jun 2026 13:36:29 +0200 (CEST)
Received: from [10.102.10.49] (dhcp-10-102-10-49.edag.de [10.102.10.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by x06-sysimap01.edag.de (Postfix) with ESMTPSA id B704F1C004C;
	Thu, 11 Jun 2026 13:36:29 +0200 (CEST)
Message-ID: <e6af23c7-1ba9-4acc-af16-394fde75b4da@edag.com>
Date: Thu, 11 Jun 2026 13:36:29 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx: use FIFO occupancy register to determine
 buffer size
To: Michal Simek <michal.simek@amd.com>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 lars.poeschel@edag.com
References: <20260611071033.1937983-1-lars.poeschel.linux@edag.com>
 <f98775de-f2a5-48c1-8d30-c39d29d0c4dd@amd.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Lars_P=C3=B6schel?= <lars.poeschel.linux@edag.com>
In-Reply-To: <f98775de-f2a5-48c1-8d30-c39d29d0c4dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR1PEPF00000F0D:EE_|BEZP281MB2850:EE_
X-MS-Office365-Filtering-Correlation-Id: e021c394-768d-465f-faed-08dec7adae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|61400799027|23010399003|6133799003|18002099003|16102099003|22082099003|56012099006|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	wiwCLaOBGCHdWKN9zZh/VG+Xovqcr3osD0zYLWG9Ry3huHF97NpedF1faMxg1cnZqsSd1VtrKVT66oAthonfbTRzbUO4rgUgo4TZvQ2Ko40E10ZmD/sDrd+KqwqglFCfrFtZYBEpkpIYMC7bHMbbiXHObxJUgPRSKJGoQagiK9bPwJ4ijLK1iHJ04l+NWIIi4yetf3Nr4JmdDfRnz/ia/rGQFDNCRkoTM8PSycdqa+HpJuvx7jeX16mUCqX8eWaib6uXpuMvUreUXCHhX1FWSduB+U5aOYEZVcxcq57bsMXsOFxtsXQ+fwL3W2Ifr9Iq/DTwQdBC+TZM23ezpB+tfKSZbxpH+34cY7TaeACdHR/3mbsZ0I7fIpbrk+l6i+8mMmF3Wd0lpyugM07P+JInvYPV67Q1anPD1c3vvNAbreoJe/tQ9ZGcUWuCU9fLokFQk3117UdDCqJ1sH+uQeczt14MabpV/GKStWBKND0/ssNB99W9EEvbqQ9YLxEZPfpMhehsgNMyUege7wxD8+vv8G/p9gHr3Y9uq8VZOGZPiJLgu/ww6xd0KEySHy5YIino5mc6d6g/ohBtYZJaSWUdXqMZlIbePETIZFq0u9whZMSjoPAqxWd9/xPd/QJuEDvgRj/mqK2D90mLhUw3eUzkAmQp+Zaal6LR0YKMhaaZNHYWaoCouo4UcnYfQTBHs7sSNoypwR0OLPr+NxoAvBKz6eSYsjYmqBXmB/B3P+xDSaw=
X-Forefront-Antispam-Report:
	CIP:80.156.190.52;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mxexo02.edag.com;PTR:mxexo02.edag.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(61400799027)(23010399003)(6133799003)(18002099003)(16102099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pOCmv2RVOD9xCmlWXjRIKLiFui+ISmepjYkuBCGkIjM9R37RuzsY7Y+nvJ53VvSPLgZ5nty7k/F8Y85TU5WumJOLKjYK7dO0HVbspyHfYa2JbBiWCTXRO/Q7CdiWkEXNP53naDhyLrXr2bCPBDujO29aYNORGWtU3OfTsVsplWU+ACp99BSFO0EpKN/L8I68cm2bSziVbKwRzriMaj2iLb9kDQq0oRzxhpRoT7U9K353PfQfw5cy3pvWDzXvtBIdppFTmDAgBD1NUqVIPyrtZjQ7I0TiS3BXdvt2azxtvc6+xQTWJXGAGURE4I/qP3FjNAsXwU+4rgHJSoH4jIopwHAEPPWoKttnBgf3+29AnHM92AYzEUS4eSuBAizUUb1+NVwSB5sheWXkkUQlCLhNw2CsnrKHBZaeAZndMuQWqmeWwnztYEENFN71H3OmZqQL
X-OriginatorOrg: edag.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:36:30.2994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e021c394-768d-465f-faed-08dec7adae77
X-MS-Exchange-CrossTenant-Id: 4812a7f3-cbc9-4f88-b59f-87b73b966886
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4812a7f3-cbc9-4f88-b59f-87b73b966886;Ip=[80.156.190.52];Helo=[mxexo02.edag.com]
X-MS-Exchange-CrossTenant-AuthSource: FR1PEPF00000F0D.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2850

On 6/11/26 10:52 Michal Simek wrote:
> +Amit,
> 
> On 6/11/26 09:10, lars.poeschel.linux@edag.com wrote:
>> From: Lars Pöschel <lars.poeschel@edag.com>
>>
>> The method the driver uses to determine the size of the FIFO has a
>> problem. What it currently does is this:
>> It stops the SPI hardware and writes to the TX FIFO register until TX
>> FIFO FULL asserts in the status register. But the hardware does not only
>> have the FIFO, it also seems to have a shift register. This can be seen,
> 
> I don't think you should guess here

Ok, I will change that.

>> when writing a byte to the FIFO (while the SPI hardware is stopped,) the
>> TX FIFO EMPTY is still empty. So, if we have a FIFO size of 16 for
>> example, the current method returns a 17.
> 
> 
> 
> 
>> This is a problem, at least when using the driver in irq mode. The same
>> size determined for the TX FIFO is also assumed for the RX FIFO. When an
>> SPI transaction wants to write the amount of the FIFO size or more
>> bytes, the following happens, let's assume 16 bytes FIFO size:
> 
> s/let's/for example/

Ok.

>> The driver stops the SPI hardware and writes 17 bytes to the TX FIFO and
>> starts the SPI hardware and goes sleep.
>> The hardware then shifts out 17 bytes (FIFO + shift register) and
>> simultaneously reads bytes into the RX FIFO, but it only has 16 places,
>> so it looses one byte. Then TX FIFO empty asserts, wakes the driver
>> again, which has a fast path and reads 16 bytes from the RX FIFO, but
>> before reading the last 17th byte (which is lost) it does this:
>>
>>     sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
>>     if (!(sr & XSPI_SR_RX_EMPTY_MASK)) {
>>         xilinx_spi_rx(xspi);
>>         rx_words--;
>>     }
>>
>> It reads the status register and checks if the RX FIFO is not empty.
>> But it is empty in our case. So this check spins in a while loop
>> forever locking the driver.
>>
>> The new method for determining the FIFO size is to read the SPITFOR (TX
>> FIFO occupancy register, value = occupancy - 1) after filling the TX
>> FIFO to obtain the true FIFO storage depth, which also equals the RX
>> FIFO depth. In non-FIFO configurations (n_words == 1) the register does
>> not exist; return 1 directly in that case.
>>
> 
> missing fix tag.

Ok, I will add one.

>> Signed-off-by: Lars Pöschel <lars.poeschel@edag.com>
>> ---
>>   drivers/spi/spi-xilinx.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
>> index 9f065d4e27d1..2d31e30fc4eb 100644
>> --- a/drivers/spi/spi-xilinx.c
>> +++ b/drivers/spi/spi-xilinx.c
>> @@ -54,6 +54,7 @@
>>   #define XSPI_RXD_OFFSET        0x6c    /* Data Receive Register */
>>   #define XSPI_SSR_OFFSET        0x70    /* 32-bit Slave Select 
>> Register */
>> +#define XSPI_TFOR_OFFSET    0x74    /* Transmit FIFO Occupancy 
>> Register */
>>   /* Register definitions as per "OPB IPIF (v3.01c) Product 
>> Specification", DS414
>>    * IPIF registers are 32 bit
>> @@ -377,7 +378,9 @@ static int xilinx_spi_find_buffer_size(struct 
>> xilinx_spi *xspi)
>>           n_words++;
>>       } while (!(sr & XSPI_SR_TX_FULL_MASK));
>> -    return n_words;
>> +    if (n_words == 1)
>> +        return 1;
>> +    return xspi->read_fn(xspi->regs + XSPI_TFOR_OFFSET) + 1;
> 
> Based on pg153
> Exists only when FIFO Depth is set to 16 or 256
> 
> Based on ds570
> This register does not exist if C_FIFO_EXIST = 0
> 
> It means this is not going to work with all HW configurations.

I think it will work with all HW configurations, even with no FIFO 
configured.
You are right, TFOR does not exist in non-FIFO configurations, but then 
you will take the

	if (n_words ==1)
		return 1;

path and exit before reading this register. And then according to PG153, 
Table 2-6, Tx_Full bit:
"Note: When FIFOs do not exist, this bit is set High when an AXI write 
to the transmit register has been made (this option is available only in 
standard SPI mode). This bit is cleared when the SPI transfer is completed."
So n_words should be 1 in this case and I think this should still work.

> Pretty much you wanted to use this register to find out how big is the fifo
> but I think in this case you should be just fixing logic around +-1 
> caused by n_words++ in a loop.
> 
> What about to change logic to be like this? It is clear and it is 
> without any +1 logic and no fifo is handled separately?
> 
>          while (1) {
> 
>                  xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
> 
>                  sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
> 
>                  if (sr & XSPI_SR_TX_FULL_MASK)
> 
>                          break;
> 
>                  n_words++;
> 
>          }
> 
> 
> 
> 
>          /* Handle NO FIFO case separately */
> 
>          if (!n_words)
> 
>                  return 1;
> 
> 
> 
> 
>          return n_words;

If you still think, this is more clear or better readable, then I can 
change it like this. Let me know!

Thanks for your feedback!
Lars
