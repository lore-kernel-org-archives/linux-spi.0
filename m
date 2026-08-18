Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3ED46D540;
	Tue, 18 Aug 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059558; cv=fail; b=G5SI3uueR5T+V49Ya1dPHYdwgqbJQVsnye//mOqWDGHq0KzZ7f1Y2PaTGXVoL9enZRSZRpCPmoUroMrBytJN+9lBoQET+4QFLnVvDNqViGupc0uXprqXXf/gjgFzLO0J6TVLuc8JntBu+sZQ8LlqKnrSKupNeWR7CdDENSZYPSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059558; c=relaxed/simple;
	bh=jMDn0vtouCucfSWag4i38NlewRAfJOHrXs9dOft7l3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUYvXnfgvS+WmcodREn3c1s9H6Iqj5pjocT88INmoO4akq0dWbrzn4HtpQhfkU9gwJQzyLfG7TgSoSUTuFyXuJ92IqUeJ4cHSH5CWvOF48fVm4YiWBbIWvU+6kMVkUpdHb2fL0x62U0o2RP+yng/2DuVYXpRZvCsfTzHPPGf38c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2ABzX1p; arc=fail smtp.client-ip=52.101.61.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2ABzX1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PddADsqG1Bxh3FJloPD3k+eHOJj62/ctD7mwWlTRE86bmQkDcGaimLrapw6kzls/Kv5Ax50zgmT7qt7ezP2uUpUe4wKtQHj/JS5xyjoEtFGGT19jpAXZRJJ9NURfcTQ83UflX6rp4zf7pe4dhPI6+Ao8w0Ig55WNTHQlAp5ruGkdybE+8PNsM3dN5IGgoAsy20koBpyHwdgMk2Bi0/opMq+M84dhKdv9aPUjrwGvODsdd4RnkzjtBLrudkhPLn9ZlJAfOzd3QprmFEeq9ICQmu9alMsbzndqConLJKTUGc93U9/VfumJ5G7ipbaZ2EW2KEuDtzVCy6F0wuCHuq4uhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxjlTP53SQoeogNhOuOEBlnVgbnKw2L3P1OM3KGtioU=;
 b=AZwTPGuzh7FDhswo3aXe+83QWWXFis6E9nzkk1NQNiAF+OOBuYUfFcDHzGlUO4+WqzsQzNfco6UrHrfRp+ClUhJPBpfbAdgtpCDykJpmzuerwiABhRXaxBMBh/jIPxpkzIgE6naM0UHqb8xWIJa1DNZmW7ZBb3Xn4lEOPNxrESpmIMSjJVor9ID0x1myebepNnPkM/eXTiAcxocxoCFpZhtO3y1OkSySBm+G3c7thvlsqo0WQkdyWWO1I/nnhwP26+wgOr5uUIps9mGHSxkS5v13mGy7FRE3/QYSX8N68gDr+hT2QAUshaBSe786dLx028Y9KasbUu4z5i1WhbA5Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxjlTP53SQoeogNhOuOEBlnVgbnKw2L3P1OM3KGtioU=;
 b=o2ABzX1p6rFTAHUa+ipVAUb+byWO3lcD8ix3nH5SkRASc6c+i/hcXdaT1ojpcaPZADU+d7tDjOVdgAcD3wNezrOE4FA3SenYMrtZZC8nosgdELTCL4MSk7cqti3HQ1hiNoENP1WPzueU4VNHTyq3SyYvMIJhaCFO8Xith26PK2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:25:53 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0315.014; Tue, 18 Aug 2026
 13:25:51 +0000
Message-ID: <d1bdc779-724a-4851-8c26-7e02981bae7a@amd.com>
Date: Tue, 18 Aug 2026 18:55:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
To: YH Chung <yh_chung@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "akshata.mukundshetty@amd.com" <akshata.mukundshetty@amd.com>,
 "bleung@chromium.org" <bleung@chromium.org>,
 "groeck@chromium.org" <groeck@chromium.org>,
 "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 YC Hsieh <yc_hsieh@aspeedtech.com>,
 Maciej Lawniczak <maciej.lawniczak@intel.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
 <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
 <9180f5d5-9885-492b-b80e-c2aaaeb39501@amd.com>
 <KL1PR0601MB42768F2FB7E907618E1DAB4E90DE2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <KL1PR0601MB42768F2FB7E907618E1DAB4E90DE2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcf0578-d21b-495b-7a2f-08defd2c3942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/k3dpoIBTZG86wKtVTQSdv4E0YuIN/y6oGsxGVDIbRO/Wb4o8SGOiU0mzQ3ZiiOTvoVKDBj40a06gQdStLF2t42ytjRNuPcgJ3xU4EB5MULNPpDUER2Jiy7MUjsDJilumkfhFKFAzi3rl3czjL7/psIxt8cE3nBVO3ZFw8425vMxiaBkFOYmy21HQGWiWntQ8pbA/y4p4mxsVmsWV4gLUpMlzL1j0WOsNd5b5wdYuobNLehfmDym4FDPxdqOitpcOM4ItgnmC6uIFa7LeJ/M48qMpNCfVS4rQo6utIeNEbdT5p+QFgMlEAw6oLIzzndkSBU4g0fWJ6P++iRFZ3XMRPxWm2/QG0nfk3JPpmLB1L7P/D4xKiH6RSCSNXgEn72G553lYITLkRA8ayaKpjZxYgHz1DKP7p271o8coSak/qmJH8Ut9Qyo2PVb6Pd574mv3imxmAMlZbpUSgq00iTOO89vu9ua4R058kiX61/TgwXwYweu8qC6ie35KWkMKUw7nDTo/fkvCYMwwKXgl4SGiEqrljcNLiZb3ECVhTqZFrZmMIkdY9zP4YPN1h9jgGAJoq7S8zem4vRli+7kI9XwgRaJ7QKEu5f6nKX/Ns3i89QMdI/Oz46ftyAkQ0c2pguFVDK66MimNTVK2kDowMj9Gduu7GTD7Z7ZPtqe8MUd6Cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnQrWndFUno4aTVIcTdNWjNRUSszRFN5OTE0MW9aSC93YnNSSXVWS2Q4WWFh?=
 =?utf-8?B?L2h4U011aGJrajJnRlNwMDFncWoxSFZjNGVEeUVUMk1GWkxTY2dmOWdhcXk4?=
 =?utf-8?B?SjdDUXZnVVM2YWk5RVdOL2ZXOXpRMUNVMVpyaHNMVGYrQmVRSGwzcUFVK3BB?=
 =?utf-8?B?K2k0M29ES1A3NURaaDhvaXlIeTEzcmtEOUxWKzFZM3NjQkxUUWdsZ3d0eUpv?=
 =?utf-8?B?M0FObncyYzlaSHN4V2pZR0s3UkMveW1FWTN3WVExb3g5OHMydUVLMXNzb2Ix?=
 =?utf-8?B?UGlMc05EeDUvMTdDRmI4OHg3UXE4THhueTNNWUx4WlBlbWtiamVHT3pyM1N6?=
 =?utf-8?B?OFFHUkJPZ2NmcXJRTzN1Q1prWW54cEkrTWszdjUzak1lcXBEM0pSY280cHFk?=
 =?utf-8?B?NzhhYWpudGkrdm9yVCtMV3o4UFB6aVYxYXdwS1FtYnQ4ZFhnZVFxZkFFU0FC?=
 =?utf-8?B?aGp4ajR4NTE4c0J0VU45NWpsL1VvNXJMTHdmOVdNc3FSZmFsUlovcFJjUHBr?=
 =?utf-8?B?YURTdXlyQ1grZ3Y2YnluOHpSMDRtWEx6cGRsdjk5WTBzZUJPSUw0czVFU3Y2?=
 =?utf-8?B?eG51NU82NzRVb0ZiS2ZrcXh3TDA0YWMyTExHWEVpclh3VlUzV0Z1a1FKSGVt?=
 =?utf-8?B?UFNBaFg1bmRoZWl6M0cyYVowN1BqL3o2Z09zT3F1VGN3RDFJaEpiOEN3L0RR?=
 =?utf-8?B?K1I2Zk1Tbjd4bzZsekZ2bm4wUHNUM2k2WkdFbnJHSDYrSDdmTWJXbjdMMmNZ?=
 =?utf-8?B?MmV0aEk0aVd3MXpKNi9pRDV5ZnRwOFlwbGNQa1ZhMUdTcVcxbzVybG4zTHdM?=
 =?utf-8?B?bUI3Zm1PSkJwMGdTYS9qQkZrczQvSFM5N2hPbCt1UVZTcUlXb1BNbzlBZzho?=
 =?utf-8?B?dHV2RDRJVVNnNWw4WlYwbzlHaVJFMU40US8vcmJmb0JtTGtHaWFWRU1vVDND?=
 =?utf-8?B?VUtPTnNSaVNpQTh2U3lTYkhSVERMZXB2S2laR2ozUFRQY3lQb0hDWlpSQkpk?=
 =?utf-8?B?WXJZMkExN2QxR3F1RDJOVGNNRFVYWmtEMTNKMEg4NVpTL1BSQnRrMko4KzhS?=
 =?utf-8?B?ZWtDWi94WUVtTkdTVHZ1Tlp6YWtJNlFaOUZJYjRnZ2ZLbjlRRk5EZ3RSdytv?=
 =?utf-8?B?NThHUjZ4MDVWbHRWelZHRk5LbGJEdmFQV2RRS0hkM2svVDUvd01WUUZUSEVx?=
 =?utf-8?B?ZFd3dmhIZi9HL3JQNTJ6T0tFbXBRQnRQN2VycWw4YzNkN2tUeHBlTTFHWi9Y?=
 =?utf-8?B?RkRXTWZjNS90VWpqUFA3VjVwRmhldGNjQjliM3dxbmR4MzkwVjE2TmFZeUFl?=
 =?utf-8?B?QWVoZGkrQS9wWERCME5GcFNiclhTcEZrVzRqOHEzOHFVdHNCOUFaNytidkhW?=
 =?utf-8?B?Y0VtbXMvc1lLL1lkMTkwbG9zRzNYbXRteC9adyt1SmZwODh2WUdnOEpScy9q?=
 =?utf-8?B?VHlwQ0VlaWp6YUd2WHZoRWp1UjZKWlRaMmNRUmoyWlcvWU8wT1k1TDNDRnpt?=
 =?utf-8?B?UjV4WEFud0ZsS3ZIT1hMYisxc1NtREk3R3pYWjhHU3ZSelJ1RTE1Y3dJQ0xk?=
 =?utf-8?B?SDlxWlZxTUo4WW5OZk5mZllrQitSYmpuR3ZSb01aQ0hvcGFkZmpMd085L1pq?=
 =?utf-8?B?N2ZXcFQxQzc0WDRpZ1BlemNWTVNOTVhFbE4yUFRQL3JRNW1NMHV0S1lUSWQz?=
 =?utf-8?B?ZGl2R1NkbWw1VjJxQUFMTHY2VzgwM2VodzZKNy9TSkZhenM4WGxVSW8yY2xi?=
 =?utf-8?B?SmJhWVZOVE1UZDBaU3drRFU2RHA4N0VXS3B3STFOaTNmUVk2eTF3WjU4MTAy?=
 =?utf-8?B?aGgvTmNLRjhDUEdUOEFDY3pmMGRIdkwxZ3ZER3hiNkdqcFdHZU5nR1BaNTAx?=
 =?utf-8?B?bzJrRTAwQTZCQ011SkNzOTk2VWpLYWFpWVp0eEE4c2E5Q2ZoK0U4RW52dlI0?=
 =?utf-8?B?Uit3MFhScHMxZVU2OSswbGVOKzNVWVE4ZUJKWVNsV1hEYzZrb2dQUG53bmZC?=
 =?utf-8?B?ZjRmTFNmb0J3UlhkdVpOSkxnM0gyNzh3U0NMV3RtS0NWajhKanBaK01MRWNz?=
 =?utf-8?B?Y0U0NnlSeVY2akY5c2VHbSswbnEvc1BnVy84SDRNUGE5enFVUDVUbEx1OTRt?=
 =?utf-8?B?eXNIdjlLaWhMcGVkcjJ1VlRGV3pQdEh0aUxvRC9Ob3Z1aHpHVHAzQVdIeHFK?=
 =?utf-8?B?cEFpa0ZpRVdDc1RCS2ZmL0doMzJ6RDhkcTBCaGpFaVBQOEdrRXVlWlZxTlQw?=
 =?utf-8?B?bkVXbGl1TVgzYVVQWlcydFozcHhjUkNZRHFrcGdoSDNqKzhzRU54bWx2NVQ4?=
 =?utf-8?B?MFZCbnhpNzlXOGlCc0IzKytXanpob3g4MGRUQ0txVStFdEVnRnVsUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcf0578-d21b-495b-7a2f-08defd2c3942
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:25:51.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+mttYKCtZncdodBWHnw88+MVf5zKm0m1B+ZujHDBG3WddwfMjSFnVUXWgIbaczOP9jhPlBaHIqG/n6qCHemXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

Hi Chung,

On 8/10/2026 11:43 AM, YH Chung wrote:
> Hi Krishnamoorthi,
> 
>> YH Chung, would you be open to collaborating on the slave-side
>> interfaces of the new eSPI framework? Happy to discuss further on the
>> list or off-list to align on the design before the next revision.
> 
> Thanks for reaching out. I am glad to share some design considerations
> from a target-side point of view.
> 
> After reading the series, I think it might be useful to align on the
> layering between the eSPI core, channel implementations, and hardware
> drivers as part of defining the target-side interfaces.
> 
> 1. Reuse existing kernel subsystems for the individual channels
> 
> I agree that we should reuse existing kernel subsystems where their
> semantics match, for example GPIO for general-purpose Virtual Wire
> groups, MCTP for MCTP-over-OOB, and MTD for flash access. Other Virtual
> Wire groups and OOB protocols may need different consumers.
> 
> The eSPI subsystem could provide common adapters between those
> subsystems and the corresponding channel instead of requiring each
> controller or target hardware driver to implement the integration
> independently.
> 
> For example, Controller Attached Flash Sharing (CAFS) and Target
> Attached Flash Sharing (TAFS) have different ownership and transaction
> directions, but share the eSPI Flash packet and request/completion
> semantics. A common Flash layer could provide that protocol handling,
> with a requester-side MTD frontend that turns MTD operations into eSPI
> requests and a provider-side backend that services requests using
> locally attached flash.

Reusing GPIO for VWire, MCTP for OOB, and MTD for Flash where semantics 
match is the right direction.

For CAFS/TAFS, the same espi-flash channel type is used on both sides: a 
requester role exposing an MTD frontend (controller owns flash), and a 
provider role servicing requests from local flash (target owns flash). 
It's the same channel/protocol layer and packet/completion semantics on 
each side; on any given endpoint, only one role is active.

> 
> 2. Consider the boundary between channel semantics and hardware transport
> 
> The current struct espi_controller_ops exposes high-level operations
> such as periph_io_read(), oob_send(), and flash_read(). These may be
> useful as channel-consumer APIs, but I wonder whether they are too
> high-level for the hardware-driver interface itself.
> 
> Would it make sense to keep high-level behavior in the channel layers
> while defining the hardware-facing boundary in terms of per-channel
> transmit and receive primitives?
> 
> Conceptually:
> 
>      TX: core/channel -> *_tx()      -> hardware
>      RX: hardware IRQ -> espi_*_rx() -> core/channel
> 
> The packet or request structure could remain channel-specific. The main
> idea is to keep register, FIFO, and DMA handling below this boundary and
> eSPI channel semantics above it.
> 
> For example, a controller read from target-attached flash could use the
> same transport interface on both sides:
> 
>      Controller (requester)        Target (flash owner)
>      ----------------------             --------------------
> 
>      MTD frontend
>         |
>      Flash layer
>         |
>      build READ request
>         |
>      flash_tx()    ------- READ ------->   espi_flash_rx()
>                                      |
>                                   Flash provider
>                                      |
>                                   local MTD read
>                                      |
>      espi_flash_rx() <-- COMPLETION --- flash_tx()
>         |
>      match request
>         |
>      complete MTD read
> 
> One option would be for controller and target drivers to use the same
> low-level endpoint interface, including the same per-channel *_tx()
> callbacks and espi_*_rx() entry points. A common endpoint object could
> carry the role, for example:
> 
>      enum espi_role {
>          ESPI_ROLE_CONTROLLER,
>          ESPI_ROLE_TARGET,
>      };
> 
> The endpoint role and capabilities would determine which transaction
> types are valid and which optional operations are implemented. Object
> lifetime, capabilities, packet definitions, and request state could
> also be shared. Linux SPI's shared spi_controller infrastructure for
> host and target roles may be a useful reference, although eSPI's
> role-specific protocol behavior is more asymmetric.
> 
> The benefit of this boundary is that common packet and channel protocol
> handling can be implemented once while each hardware driver remains
> focused on its registers, FIFOs, DMA, and interrupts. It should reduce
> duplication and role-specific divergence, make support for additional
> controller or target hardware easier to add, and allow both roles to be
> tested against the same transport contract.
> 
> Channel-independent commands such as GET/SET_CONFIGURATION and
> GET_STATUS may likewise need role-specific callbacks within this common
> endpoint interface: command submission/completion on the controller
> side and configuration-provider callbacks on the target side. These
> callbacks could be optional to support hardware-assisted
> implementations.

The TX/RX boundary is a clean separation and we agree hardware drivers 
should focus purely on registers, FIFOs and DMA while channel semantics 
live above. That means the current high-level ops (flash_read(), 
oob_send(), ...) move up into the channel layers, and the hardware 
boundary becomes your per-channel *_tx() / espi_*_rx() primitives.

As an alternative to a shared espi_role endpoint, we are considering one
device per channel under the target (CS#), single target shown for
clarity:

     espi0                     (controller)
     `-- espi0-cs0             (target at Chip Select 0)
         |-- espi0-cs0-periph  -> I/O + memory
         |-- espi0-cs0-vwire   -> gpiochip (GP VWire groups; system
         |                        VWires handled separately)
         |-- espi0-cs0-oob     -> MCTP
         `-- espi0-cs0-flash   -> MTD

Both controller and target drivers populate the same per-channel ops and 
the role (requester/provider) stays local to each channel driver and 
decides direction and which optional callbacks exist. The 
channel-independent commands (GET/SET_CONFIGURATION, GET_STATUS) are 
link-level, so they stay on the controller device with role-specific 
callbacks. This gives the same separation as your endpoint model.

> 
> 3. Leave room for asynchronous deferred transaction handling
> 
> This does not necessarily need to be implemented in the initial
> framework. A synchronous API may be a practical first step, provided
> the hardware-facing interface does not prevent asynchronous handling
> from being added later.
> 
> As a future improvement, the common channel layer could track
> outstanding non-posted Peripheral and Flash requests and complete them
> when the corresponding completion packets arrive. For tagged requests,
> this state would be scoped by endpoint/Chip Select#, channel, and tag.
> A complete request object would also need to handle split completions,
> timeouts, errors, and cancellation during channel or link reset.
> 

Agreed on synchronous first. We will keep the boundary open for later 
async tracking of non-posted requests, scoped by CS#/channel/tag.

Thanks for the detailed design considerations. Do you have any 
comments/suggestions about the per channel approach as a starting point? 
Happy to continue on or off the list.

Thanks,
Krishna

> The exact model could remain channel-specific because OOB is
> message-oriented and Virtual Wire is event/state-oriented. Keeping this
> possibility open would allow asynchronous handling to be added later
> without changing the hardware-driver interface.
> 
> These are my initial thoughts from the target-side implementation
> perspective. I hope they are useful when considering the layering and
> public interfaces for the next revision, and I would be interested in
> your thoughts on the proposed transport boundary and common endpoint
> model.
> 
> Regards,
> Yun-Hsuan Chung

