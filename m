Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013026.outbound.protection.outlook.com [40.93.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09E48124F;
	Wed, 21 Jan 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008280; cv=fail; b=oPR5YWeqClF7h62WuABQb3FgfSiqlfuCTutYifBV9qOxz9EPQXlN8VWkOAmzD+Xmq4stlEIODNFGDH8M+frEocpJDuN4Pk8bEa8t7AzeFSGh8mbdzJ9tUiZQL+H1UoiYQRnKb9xZMGyg3bl0xlMDUrnn4euQW00nOsROtMNzXBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008280; c=relaxed/simple;
	bh=MPYTphMTGUGfnf4hqVDLWM20SCOiRCRKA6WAQtCD9DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r7GUiygqSQJN2sDCPIqCQJAjZ2ZJI8eO7GgcSx8pLvApUBOJiuF4He1S8HsBZmerB51hB+A7WWpDy5l5MMI4tu28hkIc+ede8BiinWYtZP1Ae2T3MK5A/Xaxy1CRcTmEIi6nu6yQfvyIhQEZN+d6eOqvm/ihIsd04ogqGuvmV0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5h5Ibqs; arc=fail smtp.client-ip=40.93.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5h5Ibqs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L07iJZnGLDlcj7ySSRY1WKmcb7nHRisG7pKyhvDfoIsBxbDgQSBV+4UAr6zsBnh5pPsv0tDmzXlXKslqfTBcAjfmrRyBlY+jkJYcuh3OTGkLVBsh+kuc0N5Glf+qA0r+hycrG3GGKQYp9aKRq1ygRYVo9l7C3iLjA4adaBmX0RkrN+7pousrbqEjFMhtIA5rG6BtsVhM89dxXWhuB5+5YGR6sZ+o+fyMP8HJSrmeIMDaTXfAL6s8X2MR+sfmNRTgSTB5toDokiKwRGQZDi4ZMrrzuujolbnZ0Qd0nOly2+C4nCaGSFiwdNHQYCg7/XBBFaCkJUg6gXgskLQe63T/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFfklUOq2H5slR2xmSJfq9YpEA3FPX6yFG9L+HIaeJk=;
 b=zRdqN9347upNuQU5hmRxviQAuFT72qteV8rriScBYxybTErmvr/cHtFg/lOEH/MqLWEiVOYGAQzI1FZtRuKV2MXuxMFkY0nhombX/xLMGZ2YQtxw/WIBLVFkrcabJL2A1CUej2XvFmPLwwbba66VVyxiKxxlYLTyc4Cm2V6wGbZkjNUTkooGoE56zNRWrmPvtojVxKYIh6va6Ob0y3I+t1MyJ3Bta4RinaKXg1U/dWtaFeT/Il78YzC8QJo6FNjB8GW+DFsUX7bxnsX3cftzcdaPjbQNi2GiUSCiKO7j287MjmoUFAhEFGtG4AM7OWp2ZkwztxX/4764lFNDLclyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFfklUOq2H5slR2xmSJfq9YpEA3FPX6yFG9L+HIaeJk=;
 b=Q5h5IbqsHzlWE8EzsVw+4UEzX+yx8dst/HWh+dvPzbTVGa4O9H2pnzsBTTS2/+FiJ55u683WnaESzEYudylihAuDqMPoSV2aN7vdzT6weLtqeiHQbF2EuMlsWeS+bUwCge7//HmX5uHaJR4B/+dGaWSkH5/ZORFSKfTfrXcxEFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 15:11:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 15:11:07 +0000
Message-ID: <634d6989-fe58-48a9-82c3-bed7cb1b1ef3@amd.com>
Date: Wed, 21 Jan 2026 16:10:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
To: abdurrahman@nexthop.ai, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d891c8-73e1-4922-1963-08de58ff4d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejlJOU1TbjN6UXBWdncrcFZZN2RyaWo5d0FmLzFNcW53bW9ueGtDRjVpYThy?=
 =?utf-8?B?RHovRVBYNTdJQk5PSU9FQXB5Nnh0SitPbUZoZ1VsR1pvazRnQ2N6L25CRC94?=
 =?utf-8?B?Vm1JSVF1cDZRamlsWlhVUUlwc0tGRklUSURYeDRGa2Vna1pZRG9mRm9wT0pN?=
 =?utf-8?B?RkpMYk42NUJ0MTNQa0lVNDZhVHFsVWpSVzhzSnIvQnZ1RGl5OWRKRnY5bTdo?=
 =?utf-8?B?L05nZE85MkdwYjZQWlhmRDNkVUozaDkyaHFPY2wycHZERXhRY3UrM1J4VERv?=
 =?utf-8?B?VXl0SHBrYU1UVngzUjBMSnBabU0ydTJqTnc4RHRzUkVLYTNMWkJISzcwalZT?=
 =?utf-8?B?bHk3WnN6TVI5T1JlUWpnU1dvTWRjK29MQ1k5STlVZWlGM1dIUGpodkdicnR6?=
 =?utf-8?B?Ym5pcjc3Z1JiSlllZ0gzakxlVEJuWmt4NUoycVRKMDJ4VktITDZlMU8xazA5?=
 =?utf-8?B?VWcyM0Myb3BwZkhWTEZXeWN3cmVBc1c0T2NIWCsrVHM0dnBaT1NYK2QvbmEz?=
 =?utf-8?B?MUorVUpHVDcrRUw1dWR1WkNuSW9WQ25KcGZjL1JoQzcwbWtybFQwM1J5TWZ1?=
 =?utf-8?B?UW1yVWdoOGNFSGpRbEs1RVNkT1hCZVFZV3JhdmVxNVREbkt1eWNVSktLZ01Y?=
 =?utf-8?B?aEgySVBNUTBVRnhYR2xnNFYwVEgrZlR6MTJzbFcxNElSVWNiZ1kveXMvVTlu?=
 =?utf-8?B?QjdjR25CZVZpdTduRTdibFQva3ArR0Jra2o2cEFuUkgrSUxzVGRMNWhYWStC?=
 =?utf-8?B?dWM0MEp5SGxQaWk1YWkrb3JZbFM3aktmdVU1Ly83UGVoVFZSTm5CQXljU1NF?=
 =?utf-8?B?aE5uWCt4Yy92eTEwSW9GRjBrWHN0MmRVVVBhZjdweDJFMWNXTEo0OTM3UnlI?=
 =?utf-8?B?cFRWTWRCNlFrQzQxZ2t2OWE1QjFRaGlNc3B0b0RqUURpUE12ZEZON2JwRU1H?=
 =?utf-8?B?V3dCM1M1UjlUcFRBR1dWNlV1ME1FazlTUkRjQlAvQk1yTGdOeVdZSjlCNU84?=
 =?utf-8?B?aVlCSmZoY1dnQi9rRExhTzlXczJrYjJvZTltcjkyV0dESWt4M3BqdUgvWVFk?=
 =?utf-8?B?RHAvRHN6UVI5MVJST1hqcmwxNmI2SVlNT01lT2ppMU5uRFJSb3puUWlWR3hs?=
 =?utf-8?B?Z0RJcjg4bllqcklVVFNHOUZlYWdOa1paVTF4cTJGYkZYdUZucUdrMnp1VC9B?=
 =?utf-8?B?cFI2Vk5QVlNmd3pKQlhCam5ZU0VDdFI4bXZPTjVNbnhuUUVsVmRaM0c2VTdQ?=
 =?utf-8?B?aFNHVlBWVG1weHZSSlYxUStHSDQ0djQ2YmtsL0owS0xodUZoQkpXV01GWjdN?=
 =?utf-8?B?Nk9JZ0xsbisrSkdxSzZOcmdkdGlQWmovVlJRU04xREtVQUVRTDA4SnV1N0Zj?=
 =?utf-8?B?Vk5kcDI2TG5rTGJYZVVzTnBiVi8rQW9laFFDNENROENRcEJpNVdUVEdYNTlu?=
 =?utf-8?B?SDhUUUloazcrc0xBcm5DVDFlN1YyWlVLcW45YWhrckRZbWhtNituc3VFQ3NE?=
 =?utf-8?B?NzhKNmlwVk9aa0M4Z3pGVWg0OWNVTWdMV0VIcUtvemNaSlhQbnFxWHEyNkU1?=
 =?utf-8?B?OVAxQitscWlUL0wvRGtjR1dQQ0ZhUlorM1dCT2ZRdC9uZmRPUHVLWTF6a2Ra?=
 =?utf-8?B?Q2NNek00WldXMjlndnVaKzZjR2JQYjd6NmZBZS80dmY4RkY3VFFpMWRLb3NN?=
 =?utf-8?B?SEl1NElWKytGK3dwNmdvbVRXVjcwUXZVbDQ4bXlvWFJ6OWxOUUFWQU9tSVds?=
 =?utf-8?B?VzhxRmRUZllrdDdtazFvNkxXVGlRdE1USGxVYzlxa3VHMDV4UnkwcHptZzIy?=
 =?utf-8?B?enRXR2xBeFVrSXRaQy9qZHhCcUE0bms4djZFWkU2cjA5UDBLOVo4d0NyeVli?=
 =?utf-8?B?QXNkeWRQK09MUVR0MkErZU1EYlJNdzJTMXB6TVRMdzhHdWF3WFRHa0MrNE9Q?=
 =?utf-8?B?TW9DT0xsSjExQ1pNb0FQWUx5QjI3MnpHSXp0cHBsTEM3dDJBZ3BqTW1QcHFW?=
 =?utf-8?B?WmVNdURMTTVuZmRmbFdlYWErOUlWUU0rbjducDhMVmxxSHU0YS9qYzlhektT?=
 =?utf-8?B?QUZVelN4bmNvamhCNjlLMC9kdjhjd0FHOGhZYUd1WndNS09BYnF4K21McUNv?=
 =?utf-8?Q?Li4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlVpZUhGeE14OUhkVFhuVWpHKzFNMDVUdXlTOU9mUEZNVnIwUjR5SlJROHJw?=
 =?utf-8?B?ZWZLZkNZeUZVWkdNMVdlNUZqTXVhMCs5d3pFazE0NTBjcjVLY2RGa1Q1T3hE?=
 =?utf-8?B?R3ZWVXpTOFZleFJ2V053QmNCUE5nS1dzTHdnVUwxTTVRc1Jqc0ZaSWpleFNF?=
 =?utf-8?B?dXJNSDFMbWRIc0lXTmNoVEpTdEsyWDBlbng3Ync2d0lCdGZpR3A4dmhLbks4?=
 =?utf-8?B?UmV1UlpTamtjT1MvOVZVNndNZkdjTktkcUYrNFptQmJ6ekQzQzlNTTM1TDJp?=
 =?utf-8?B?Tk8ybDlJOTl4WVBhdDdmUng0MkkwdWg5SVl3bUFzRlJkM0lKRkZabXUzWCs5?=
 =?utf-8?B?RDZ1UE5SbDZTM0JOazV1S0dZbDhBM24xdWdYWmF5M3F1QUxNK3l4UFBkelNC?=
 =?utf-8?B?L3JZTW9Xd3VsZDdBUWRzMHp6WTlVQnVyZWxzSDg2UUtDS1duL2habEZIVlBK?=
 =?utf-8?B?UHdleG5rdk1EQ0ZPQUJXMnJmOHBHejk3TzVVR1J4cGpha29VMGlPUWxMTXJj?=
 =?utf-8?B?NXFYenBWQmJZdi8zakV0aENJckZKNzhQQmp5M09RZCttengvMld1SFZiSG54?=
 =?utf-8?B?Uy9BWGRvUGJFNU5zUjM5U1l3RENoa2hyZjM2bjBxQ0JlQTk1ZVh0L1NIUHhU?=
 =?utf-8?B?QW5GcStBUFdjOU1tSWp0ZW5INUtxcitoWllqUlJVVnNNZXpxOXF1V2lJUnJa?=
 =?utf-8?B?emtMaG9wSENVVlpzYjhPakI4VmY0VVpFRllIR085M0d3OTZycm9JbVZaU3Mz?=
 =?utf-8?B?R3pCNDR5ZzlmQTRsOTRjZThKZFlxUDVETjl6c0FZNHorb0plMzJyL2E0RFhN?=
 =?utf-8?B?K3hkcDg3SmpneHU1cmdocUNVaFR5VDB2eW5sM0s0WmF5NUM3N2EzVVNWY3dm?=
 =?utf-8?B?aEZSck5PamorZnQwZ2h3bVRxdEpueWxxMjhtU0NEaEFvYVJHOFA0M1JZRW5D?=
 =?utf-8?B?R2poY2FTQ3R4QlYzRVpTQWl0eHg5UUVrS0MzS3h3RnNSZ1VhSWloNlptckJT?=
 =?utf-8?B?eFl3bk45V0RTYXIzM3djS0tMSzBBVkFteVdtV2hvOEo2dlQ1YlluS0M2VzRq?=
 =?utf-8?B?bVd4YXprT0VSNWRkc0VRdk1QYjNBem1oTDFvOEtCR1drOUtPVmxCSlVKUG1h?=
 =?utf-8?B?c0hXZHZwN1BXb2xnd1Z5V2Vvb2EyQi9KWjNYbVdqTkFKQ3FZMHlFYlN6WkhL?=
 =?utf-8?B?NWpWWDBRWEhXdDlBcWV4VEdHMllOWFRLT25LKzM3dkpvYXJaak93WWhxY21t?=
 =?utf-8?B?Y05VaVBpK0hwTEZCd0pJeVdTNHg1SXFJSGIxSUVNUUk4S2M5YUQrWUU0aTBm?=
 =?utf-8?B?MUVodDlWanhHOGhUcTNBZnUwVEhOY2hRMFdINTNabTg3eXprdmlxaEZvR0NN?=
 =?utf-8?B?SzlJdVE1R3R2MkZUd3hvWk54OHZ1WFBhUXB1OFhtOHRETGtSTitxa1orZ2p4?=
 =?utf-8?B?OUZPdE83amJpbzNzYWxzRmw4Wk8xazlVRHJjaXNENkxETFRkZG5mNkdJMkNK?=
 =?utf-8?B?djN3U0ZGU2lGUjFxaGY5NkdJbUJDVkFDWEpMeGFRWWQ4cXVFcnF2Q1M5SzZG?=
 =?utf-8?B?ZTQ5OWpKMmxBRGg3b2cxK1AvQWZPaHFUdGVPelpxaUxhM0hXbHlYMkdMVk9L?=
 =?utf-8?B?TFgySzU5NWxpWDdHS1NRYXZuallnMUFVUUI3YVhpT0JGUG9zM05KKzROZFNW?=
 =?utf-8?B?M2hGM1playtWdXRDZlpIT3A5RFZKamdXRjRMT3B3RUdNb29iNUhidDdWR1ZY?=
 =?utf-8?B?RmdBMXRaa0dISTlqR0xBNVpZd09qYnFBVDZNVWlTMDdKVk1iczFqc055V1RS?=
 =?utf-8?B?Qis3SUZ1bEt2ZTE1c0x2S0p5YzVBakEzV3NvbUh0M3A0eVlnb3NRaksrSE4w?=
 =?utf-8?B?NTVWbTlDZ3RQTFpQUmRaZE5IRG5ma1pxZ256blhSNHU0a0N1OGlCVkdOTGlx?=
 =?utf-8?B?eHlGZ3BmdDFQZTZ6ck1IcXl1d0p4TlJOT3NNMFBWSWt3eldkMHZiSWl3WGEx?=
 =?utf-8?B?cGlRQ3dIWmhNOHc1dk1QMFRsRHZFWnFFNVhUaE5DTWYwMUhIMlVpc2UzaUUv?=
 =?utf-8?B?aTdkU25yK0xEMVN2RkJoVjZrQklWaGJiVG9WTzlkTUJqTWRGb2pJcUl6TjQ0?=
 =?utf-8?B?RmZ0OXczbHZzU0pkTjN0ZkFYNXdsMEtqVDNzYm5QV0QrTjkvSWJFeTVRNUxz?=
 =?utf-8?B?ZlRRcFN3T0EralB1UlV2Vzg3d0ZHYUxZT0JsNGFCQ2N1ZlBDdGVVa0lmZk9U?=
 =?utf-8?B?NEd2WnFRV3k1RDg0OTBmVndGdHVESUR1S2h4Y2VnWDRWVGNlOXp6OWpVbEEv?=
 =?utf-8?B?R2hqRGZtamRsRkFiMCtmbWJxRExPbVcrSFFhNysyN0FaUzl5aWhPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d891c8-73e1-4922-1963-08de58ff4d5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:11:07.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RO0xHXDFR8yANXMggSwPP6xOtCtxtfMbhaTDkPJWz6H7mq3DdQ1Ge1Zm7guvT1+m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605



On 1/19/26 08:06, Abdurrahman Hussain via B4 Relay wrote:
> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> Make the driver work on non-OF platforms.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>   drivers/spi/spi-xilinx.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 4aa67fc61cb6..9fb1da2fcce4 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>   		bits_per_word = pdata->bits_per_word;
>   		force_irq = pdata->force_irq;
>   	} else {
> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> -		ret = of_property_read_u32(pdev->dev.of_node,
> -					   "xlnx,num-transfer-bits",
> -					   &bits_per_word);
> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> +					 &num_cs);
> +		ret = device_property_read_u32(&pdev->dev,
> +					       "xlnx,num-transfer-bits",
> +					       &bits_per_word);
>   		if (ret)
>   			bits_per_word = 8;
>   	}
> 

Let's get back to this patch itself. I think you should send v4 version of this 
patch with updating commit message and saying that you are using generic device 
helper functions.

Thanks,
Michal


