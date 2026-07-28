Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B143446C5;
	Tue, 28 Jul 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231303; cv=fail; b=lvw0Qz1uYxB5yu3Hsy1QdNiWIB62M5I+jEZq0DaUOToFqcuqL34myiNh95kQgBvSnUxjtG8xciBTlu9NLWp6w9W/krysmOzVnwdiz0z5k+OZbBdBDb+9Xb7pTzzky6FUIfe2KgcBx4J9WgMflZ/qDxKFiNhfHI+C+sarZttA2gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231303; c=relaxed/simple;
	bh=LxOk9nSoqpLgML4rOu5Zbcx91E7tVhvPsUXXxvvAfNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Scb+Zb9go2OUwsT3fkV1C49NDue3ey1N3qlUEX7Fw+4ygglnKrgiTDayuCHrvc+YM2/2OGKzBOwVl+U0hUN5oG09C0wVxkZwXLyMkbmdHnp7PzOwROoZoTE8d2JRz6lZp1XPlQ5RvSm6s+hOJgIM5g0+fv5/jqr/h3D4mihJNys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1LmCTeG; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1LmCTeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNjqUZB0AGt7zXwcVHkHy/sxT0bwDPkoNQ65IloOlZrCWvHUf9eZFGwCIbvqBxcaqWWaObP3/N5cTwVHisiD6IT2LGvwHzyJVrXmsdGl8T4NRtDCYkWm6uYudt+s26QNIczVhcZAuIfj3eJqGwTpmgnQANOTqoKM0M069Ip67JVtHratxTn2Q3Wl6WV0t3jLUeZ3fG5BrM2lyOogMlFYCXeqJZJoNLmiUccV6XNor6RS+Abu4mjzc+1C62ADzU3Bv8+xPyylrYY2nxZCWLln/ZttPI+KtWEa0yTsMKhz4wFW+BIZTZp44ZzJBeeKuPKAN1bfpq7dZeFPyd2A2CoyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYziq67DyXN8DWR3gUgDiyjYIlRvm0uhIOFzxJfPtFc=;
 b=ETATWqtoZC+eDHw9XruW+CJBiko9sK9Xcu7534UOsui1evQsy9qCqjMZnqLl24OLpzxEjZvpMGbJM2R81Bp49OKW+gh9QsFw6v2f/rQ30guYecmPiHg2MX0j9Bi44GxTVE+23P1SWZOB0mbQ6jYeeO1ar+rW+I8CNWbJ4IhOfZUEBEQ+oIUArHFZW2X6bcMfx/iyKAhSAMXWqXKaBYXE3nf4M1PQVsHm2zxc7mOs48AJ3hwvf1VqyoUGIPweEm/QUPWbulcS5aPmfstsfT41zHrOfj0PJNxigRJ0ZQv3ReADQKIJDrQX+DKAwWN38Hks/fq20584RuUJBPNyWZJxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYziq67DyXN8DWR3gUgDiyjYIlRvm0uhIOFzxJfPtFc=;
 b=D1LmCTeGtDb1CW/77pv6BRwBG90QqUHO341Bw8JNX4owYJQKEENcVMt9TY8scoUtCkyp22FDePlcCyCwhHPVrX5FGFyoTLqWcGboMlz4AjJcab7+jGi5WcPbTJH3ED36SauoVIFNkatOO3YKLi7Hl1efxuOcKozE3fT9LNRT3KV8NZAunCvDzLEPjlQHImHxKbYgb3O85mAJn26748CwKg/FtQ7YDSglJHIGFAOVMZPiRowBq2pmz8HpnotokqT8s32eCojEKgC9VZhfgtl8nU2uzWSNoRa8gP7LbBqvmB+M4HVkcMbqr38w31nw/1vVIoT+F3h4cnL22elnKRS4Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Tue, 28 Jul 2026 09:34:58 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 09:34:57 +0000
Message-ID: <9c196ab1-1945-49fc-a89a-5588d1e50046@nvidia.com>
Date: Tue, 28 Jul 2026 10:34:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
To: Abraham Zukor <abe@maticrobots.com>, Mark Brown <broonie@kernel.org>,
 Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725042944.1204409-1-abe@maticrobots.com>
 <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
 <20260728025503.162543-1-abe@maticrobots.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260728025503.162543-1-abe@maticrobots.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::19) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d910d5-8b38-4a78-4d82-08deec8b7c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jaGdhnaNBIIwtMQDVBpkMJSePcZriSgBlj/bSLWZcDHjVDMvh2UvR1huAx1lehmJqpzy37r9ycGqOL6220XWeiM28SlonXRkXE1RDIlpym84cT0tkCHnLZBNbWjMi1/gomE4A67OIAG05pyWYzh2PeCkcPZwDwPHFSN9fxeDO3IIPcVh8araK/CNENlL1DmDDfVj4SmcvQxV2ZSv6J+RtwHAIURwN3lLw3pzt7F5x/ZGpUbw/muJR4ubnENEVsSwjcNd30eNV0CX/KbcIYajJb27pqcdkdWDzUEywxdX/C6OvjUmtAb5f978osy1Ws0N8Q8MdasHefqz6i4ZhDFk6yE7w+Zl5QGOgpndeGAxis1stWsBPQP83lk73B6isloIK5FykXYl86HFvvJ3tS+zagbhTyOLCAvAJ6BCbZOO3MgMlTVbCqCyMAa10+3qOAfQwOc65rKoVJKlM8aXIhaWKv3eZnrErbS6HLpUbQfJjuodf0Krm3SIwMHpLT/xKF30uCq2RtR6gqfYDKZM06yLc4T/yAaPoyBkcIeSDxkUV/gJVBWDqUAVp46cYit6yRq0izCfW02IopS2feGl5mChC211jCW9RkxJiEqGgxAg3kDFxtigo2BqUJL38sdKp/IWmIN3oTXVf4UMfGjCJvYeIZ3fDv35IolXkCCxI0sPCUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejd5VlJTaG1QeWNka2hyT21GeUJMaWZ1SjBCQm1iVGlWakpKQVRldFl5QTd5?=
 =?utf-8?B?eU5MQll4UlhWUFdsbE1YanI1aDQvdncySStwZkZXd1FtR042KzBzV0pUZVNo?=
 =?utf-8?B?cEZBUnk2cWpPQ01KNnBQMkRWSDVmYjBZYjhwYktXbnBTdnRWeElDckNGMDFz?=
 =?utf-8?B?eXlCQlNvOGlkOHhDVnp1aUhvcHgxTitROXMzeEdKclgxMW92NFU4cklZc0ps?=
 =?utf-8?B?YUJLeTlaYk5wNjZJQm5zN3RyWVFmMDc2L2hJckZ1eHh1MVFQREFiaG5Ld0k1?=
 =?utf-8?B?K1RFNVFlQk1PVmthS29GQ282VmhWUEFlcWdsbnRrY0lQaUpVc0x1R2JXR0tP?=
 =?utf-8?B?QUxLZkRvZlV2Y1laY3FnSCt5Ymlrcy94YnJlRnNUejI3N3gxa2poMTNHUjFM?=
 =?utf-8?B?MDJuU0tqR2gzK2JPVkZDSGZ2WUVKVmdFYVdnZU5LUWtXNmwrQzZRL2w0ZDBE?=
 =?utf-8?B?cWdEVlBIeTQvVG55K1FMa3BzR1V2WGcxbzYvRzVLWVhtcGc2MVlhbGxkdC9s?=
 =?utf-8?B?Tk91b3ZRYkNOblBvRDZLUjVTR3JYODRDOGNWNUhDVUY3R1M5aDZnVmcyT0g0?=
 =?utf-8?B?aWhWcExDUmNGWkZjUExFVlprY00yUFoxMW9mTGxDNkZvRVA3VmNhbDdySysy?=
 =?utf-8?B?OU85amNtdkovMnV1dWN2Q2hZU1lxVWRMY1BPWXZDcDZXR2JFWUFRQjV5K2Uw?=
 =?utf-8?B?eVY5VU15QTY4UmI5enNKZzN4L0VKSGlXeVJnSHV1R1NjTnk1TG85VTkySnM1?=
 =?utf-8?B?Z1VTclZMbnNhSGxiZlVBM1NndXQxcitQOWdmN3pXaGM4cCtBNG5uMnBoL01i?=
 =?utf-8?B?MUJIQUplSUxwMlhpd1NOREFBa3N4ZlYzZU1wUWhrRzhYSEU4ZUVVVXNMYlIz?=
 =?utf-8?B?VVV0ejdYYW1nNmMyNFQwL0l4aVNFRHVJWFZqNFNHcUdSUzV1YjNkWUE2QS9p?=
 =?utf-8?B?c0UwRHpDcm9nYlBGcDBpRXRDOEl1ZUZFR2E0VXFUTis4bXlWTVlhV3NZaU53?=
 =?utf-8?B?REVhQ3FPVlYyL3FJckhPTjMvbTVBL3pna0RQYkQxemJ1NHcvMVc0WCtSZlNw?=
 =?utf-8?B?VTF3aHBadXhwMkhPczdzUnl6N0c4MENwWHVONmQ3VkVXZ3VaMDM3TUpKVGN4?=
 =?utf-8?B?eVVkQWlCWk9Mbll5MTcvUDZoMFVRWCs2OFkzSmpUTGJTa2V0S3dXQnN4QWx5?=
 =?utf-8?B?YXFBeUxRMnA1MUxkQzdBYm43bEY0Q0xmeVRyUjhJL3N0bGtXUXEyak9STFo0?=
 =?utf-8?B?elBuK25xYzFHaVY0N0YzVFBURG03emRwdlVyUzhNSXluWGF3cmt0RDk0Mndj?=
 =?utf-8?B?SlczcFFuemg0ajhZcFhuYUkxUm56QjhpWTdXa2d0eDh0S1U4RVFsNHUrTDBC?=
 =?utf-8?B?VTM5Z2s5cGUxMlgrOWpZVDZ5dVg2Z3JJanU0SmJtOXppYmZ2MGZBZVpick1C?=
 =?utf-8?B?YndmWXhKN1lMb2s0VTRqdDlTSUdMMUN3TjhiUDN5UVZOaVdveHV5NzdJYUhN?=
 =?utf-8?B?cXE5am8zTUVtK2lpRUpTSkowOHBNM2NWaWJXNVFiVVRUUFBiZUJDZGV5bHhT?=
 =?utf-8?B?WHk4SDI2bU9PNjN5eWRKTmo5MkRoek5DZEhKanhuZWR1M21VM05hbHluRzhq?=
 =?utf-8?B?ZnROWEFRMmhHL1htWHRwTStrMDJJNDZPS2gzMU9mTFU2WmlFRitLNy9oMnRv?=
 =?utf-8?B?Y1AzRzdpWVRLdmpkdTNlUEkxdXhGdlNndjhESWZHZXlGSmUxN1I5ZEhmSS80?=
 =?utf-8?B?cFJuTURTSHV2YTg1Y29qY29CQ09hUmVva1JwTXhBWlh4ZEVoN0UzSlJUV3dt?=
 =?utf-8?B?TUtBY3cxb1ZrZyttRU1PUlNoNk9yL01rdnlEbi9TcUh0STBqanoxS01hMTVo?=
 =?utf-8?B?YTRTcVN6RWMwQW9PVFg5N0ExNW5iaEpXa0hzRW1Hb2plZVlyb3RqWkptd0xD?=
 =?utf-8?B?ekFDb2QrMXNTNnJaRFErM3AyRUNJb3hSMlVELzBWQVdiVmhSZy9Td3p3QnJk?=
 =?utf-8?B?WEttMUZ3eWdqK24yS3ZLbER4VmlmbEVEc1RTVVgzWkxMZUhtejNLVHBURity?=
 =?utf-8?B?RDlveHY5eUxDY29QbU1PZ3VYYkJPWDhtZFdZYmdNTU4vNEVsOHlwTzdyancw?=
 =?utf-8?B?bWxRWDZYdVpzeXA2cDZacGlyMTMwOEoydU9YZk1maXR5QjNsS0o2Smp4Vi8w?=
 =?utf-8?B?S1I1dHBNK0FVMitpQlJaZC90WWpSRUpUT0psOG5aZUt0Z3hJbnNmaDhZTkhI?=
 =?utf-8?B?VGdYTVZmRjRHemtDNC9RVzV0d0tlSkVFQ3Nkc2UrdlBPSXRiVkdWVjVGNHVl?=
 =?utf-8?B?M1U5VEl3cnNoaXBJd1VJamdHd2dPVEcxRFJYbFNkWit2TEhSbWxRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d910d5-8b38-4a78-4d82-08deec8b7c9f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:34:57.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZxHUWMTzK/W7DLecQgMtjZrz1igN0UUhyntKh3+ZoMWEa430W3J5UFWLc6Cv+EtUny6JeTl2+2a766pb3OUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728



On 28/07/2026 03:53, Abraham Zukor wrote:
> On 27/07/2026 13:07, Jon Hunter wrote:
>> What about the case where the SPI devices CS is active high or a
>> mixture of the two?
> 
> An all-active-high bus is the case the window gets right today: probe
> writes zero to the field, so an active-high CS idles deasserted and an
> active-low one sits asserted. This patch inverts that. No single
> constant covers a mixed board - one polarity or the other is asserted
> until tegra_spi_setup() runs for that device - so the question is
> which default is the right one, and active low is what the SPI core
> assumes when a device says nothing.

Exactly. That's my point. Which is the right one? The answer is probably 
neither, but whatever is present on the bus.

-- 
nvpublic

