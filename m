Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67393A1CE6;
	Tue,  7 Apr 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577776; cv=fail; b=CPrZ0kzY2QXlk6aGIEO7UMdgHugMUEOyZp+Vj/T7gWjJoN+MRh5rrdIbtBhIqA35dgwbJ1unvbNBhSHosLWATWl4jk06HplvzsCOexgkz+nqQQXI7Fd5koMZCAapfbLLh3wstYJ1LlsdMs81m4X2UFdqtLHDvNm+HXjBrH7lSs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577776; c=relaxed/simple;
	bh=xGswHTG6/XCWPpIBD90KeVV2yb84q4EgetNZffl6uzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnFR28DRjUR409kNULQ8t3IifNh6GzObgeqr9mS/RJ4JP/tbGrHlpC455R2Zmy80zll9B8Yiqy67PHiHBQVLbaykUK8PYJg7MBGLDD11Ef1wkjfNcfu/u3GqL4UldPNjXn13cbT/khmvWaSvfx+lHY8Y/WZBUHyhDhY2YpLqI0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ccDSCbQU; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ccDSCbQU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grz+0Rn9QMjgY3p3zHkDXhqKWdJFzX+syaJeH6+dEhL38LSvStDffkwqdgZK5j4mQWTcRGwuSoirpTasfyfwI86AQR/rnLtUFBm8uD8O56k9vPku6hshSS++1krz5UN0oANITlYbWu3EsKBN7sFn7w8GTt7Ux0wGEUj9/JNFqeowO4sjqMrSL9dYYzc24eUdJW0dVCXKvSgyWjO24DdraWsYkHG8xTq+M0VjPnq4JoO4N6fWlWY2MZWTHmWwDlOUglkhB1rqcZ6xfZ9EYxkHaR+bUaXJ0xa8MFLTml9kySt/ZpVxv8zgCwJmq1K4iv5AGO4AaisoEgEw20l3byKbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGswHTG6/XCWPpIBD90KeVV2yb84q4EgetNZffl6uzc=;
 b=wD30PnnKaG6X2j6yNt8iFOFfGjHJv6Kjhm5ravGzQ1Uu000rE+48YVw8D8TjN7LhPQ+2PnmFbDkI0swl2BZ33gyHT5shXsVIpRDoISM1EQqVXYSSghivkWLdjKU9JRHzDHVlhti76KxriNlC0CBQYRsj3qwJbVe1pSojnb8Ktvq3schIgRWeG5iUu5pII3g+TEvw1ue81ZEqEGtCFDV67ccLcql3i2BxbkN7rDYrfEd91CS4m8h19qBEZw0PJ1DWRaKlegNF26/I08LXFA8ETj+E/JDPoEvGoH0iPQTEM/md5uZHr6f4ffAji3Yj2eH9iFRwb1uVj8awWCMSlxQuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGswHTG6/XCWPpIBD90KeVV2yb84q4EgetNZffl6uzc=;
 b=ccDSCbQUlu/cH/IYkQ1NCk3MVFHPt39Glgj6+g/IcnarbqfD/MWhPMc40YLtE+wRKRKKtDpn5GVwBc1dX//Oj2FTqUAO+VAqiWC8u6NTlNmeG/muD7oJqWkKN4C0sNcjjPO1GBrGFEcWOMAuzFq4C+NJ+RrFKXjj91ersRKPxpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) by
 DM4PR12MB6229.namprd12.prod.outlook.com (2603:10b6:8:a8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Tue, 7 Apr 2026 16:02:37 +0000
Received: from DS0PR12MB8441.namprd12.prod.outlook.com
 ([fe80::5e43:9cfc:4490:1e3]) by DS0PR12MB8441.namprd12.prod.outlook.com
 ([fe80::5e43:9cfc:4490:1e3%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 16:02:36 +0000
Message-ID: <169e3193-3d37-486e-8c6e-5a1a01488296@amd.com>
Date: Tue, 7 Apr 2026 21:32:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update AMD SPI driver maintainers
To: Mark Brown <broonie@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20260406091042.4065767-1-Raju.Rangoju@amd.com>
 <ada32253-6d8e-478b-a833-b2d574fddeee@sirena.org.uk>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <ada32253-6d8e-478b-a833-b2d574fddeee@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::7) To DS0PR12MB8441.namprd12.prod.outlook.com
 (2603:10b6:8:123::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8441:EE_|DM4PR12MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6ee62c-529e-4dd4-29fa-08de94bf15ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GcSjlu5cTgnl9xOfmoz080vovQrQKKaLKQ4PPOFx44PRpIRGCIMRET6EM6ks722LlWFzDA2jLgHA5j43APCu54GQLYabVStXTz2KdrROOE/jOxSkjSm8Xi1yCgU+X0nU7iq7eBBOXpvIE6wEpqklxfOe3QyjRBIhNX2XkZhR0FNKxRWOJtLxTNMxQ54A0j8c5jJUUSzKpWcmAoJUyJESB9MMrLJ9fQ9xXw6C7sYIM8OvAkhb7a1NrJX8Jy9Rsb0APzdEpwrqKHqMpF6FHS4qs+QKGY2PePdkE08IQQ9tRbyQpNbLUSWQPeFq99bQZ9vqCvhnyx5eYXVKx9XVZIe5VcSk75MPMBHK0kKKJ+IilDtUwUQaOzqjXvN/+soNdU5oBB6A+r8bGgPx+G0/Oz/eYiS/bhnC5l6uSdJp9oN4BbWtXNEBapNiKuutvIGhfTZ3Oo/qcOVa3IPz0CVJWpfk+5fwxhEfZeKRXUyzvUpsdiEhRQgUNARo2HYXED2GA5XXc2jnpAEBvdqkLhkv8vvCI+QLOh1RWkak0Oi9YBtJBdtnuXOTXapcMedC/kvBRg0plrMTL8to/xsgHV0qEMdt373ZHF3/B+i2Pu8TuzktC/wAXAGHAZyehFH1XfkA94u1Co0RvmjHw69LahL9itR5ZZHyW8Ly7Kan0OwIsTMF/jqQwRkr3aHilAF27alLE1MhkX9DV5L5ic3X4lZNKt7Fs5c7peeGI9m3RHQQ2oB6H7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8441.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHZSdXJOaEhtM3JqNUVxM3p6YkxwaUp6ZVV0QmVBT3phWXRnd1pRTTRlWTNr?=
 =?utf-8?B?cURYVzVabUVMeTdqMlVYRDV5cGh3enR5UXhOcno3bXpUTk5WUVZnTXFMVzdl?=
 =?utf-8?B?MytYbCtqUGJGRWhVbEMwMGZLRVNKL2F1YkRTOXF1Z2ZPTWZSTHNMVkZzU3g2?=
 =?utf-8?B?dG56cHNNaUJjK2RsUUpkT214RndiMlFHR0pLNGtpTTZ1c1VQb2NLUzBMTndS?=
 =?utf-8?B?TE9lVk1BSmc1OGRIZTkzWmJIQ0k0UnhvWnpoNHAwZFNHd01XdndBQ0tYWUdJ?=
 =?utf-8?B?VGpYVHBIOXdtSHRSNXZhU3JkQW14aXZBS2ZtQmFmNjR5RTFnZzdkQXdIc0hU?=
 =?utf-8?B?d2g2QytWTG1yaWk4TnRGalpNYTB2YXgvZEZQczZXbFNmcERDMEJwNmNsYks5?=
 =?utf-8?B?a1pOZXM2NjhJME8xTU9DY2JhcDJBcTZDZTJNajlBSGZKOHVZVlg2R0NJa3A2?=
 =?utf-8?B?VS9uQWNzREJTVVVyYVhFWDdKWWU4Kyt5dHh3TVA1K0ZDY1EvZ3dsay9ZV1J0?=
 =?utf-8?B?aE0yeWVudGhpQlJRN0xMd0RNbHNQcjBYaUpFREF5QnJvRVJSV0UwM0RlNldV?=
 =?utf-8?B?bmRUQzNCcUpaOHBJVEdYU1FrWmRGMWNpTHVyV1NDdFRiOFd5ZG90dmR6dCtZ?=
 =?utf-8?B?Yi83cU9hRkp4YnU3Q2lUVWFCdjJ4RzlDeDRYV2NBWWQxYWExUFBTNWxNOTRJ?=
 =?utf-8?B?ekpaVmwyRVpYOUFCTXlISkhjUVpodjlkUDFIcHMzK2s1VkdDblB4YktYcXBj?=
 =?utf-8?B?WDcrVTdYTjc5V01NUlEzQnl0NzVqckp5Q004RkE1RmVyd1pacVdzZU9IWHhM?=
 =?utf-8?B?Q2c1dE5hdmwvTXdvUTc5OFZOMGxYNk5tVHdRQ2JKcDQ1K2lHbW92TlRmbjFu?=
 =?utf-8?B?Z3FZcTdtNmFVbGY5dVFYNVRubXE5b1VjMGI2UWZwVEd5VHBpN0pJTHVjOVFB?=
 =?utf-8?B?Z2VQTFVwZFN2NlB2dXg5ZDh1NmlmWWFlU1RKU01DaVFqSURJbmM2OGluaEU2?=
 =?utf-8?B?TDB3NHZlaVFmVzY3dElJbzE2dlQ2Sm5kdG5JVHRmbUcrcTk3VVgxRWxuckFU?=
 =?utf-8?B?aFRvQnBYQ0g0aGorNzZDRzMrbHQ0MXkxNmcvcVhqY2lHK1R1d0lRY2Zxd1Rj?=
 =?utf-8?B?cWhBU3JuZzU0cHNpTk5IM2ZlZUkxMnBFdktyOXZFcnpnUGRtZ3FKRmdhWUky?=
 =?utf-8?B?ZkVmUktsUlVDbkZtdXRHNlcreHRLcVBwY04wT2l4Mks5aUhMVW56anRTWG9I?=
 =?utf-8?B?eE94UzI2Y1J5dGRER1NQNnlEenBVRXEzUkRzRVkyMXFSS085K3VaOXZ6VXU5?=
 =?utf-8?B?M0syVjFHVWlyWFJtcjRPbmpiaXJmOXMwUXd3b1FuTFhTQmErV2xZRUl0SldH?=
 =?utf-8?B?cWhPTmI0dkI1NStTVitra3lhbllDL2JWMkRxMjFMczhHdU42MWdHeHJScU5B?=
 =?utf-8?B?ODJoKzd1U2Q0WWtId2JiWk9uVlhFTGxxK045VE9MeEc1WnM2RTU5cE9mdDVZ?=
 =?utf-8?B?bFhYWUNXUVJMZFJnSHJ5VG5MU1JvRTJoMm5KTGFDNXJBdnlMQmVHZFlnNWVk?=
 =?utf-8?B?aStHR1pJbWIzS09XZDJhOFU3SzhDcnozcENONlY3eWJGRkM3NllLOXRUWDVl?=
 =?utf-8?B?M0s3MnEwamF4Y1Q0T1p1YnNaMDFSWDJGVnh2UkxaNmFVOEVBRUFEZWRMTzNO?=
 =?utf-8?B?U1ZhVXpYR2FkRmQ3OXJEL1ZFbDBrbGlqY1REZ092aTQwM0M1bUY3TnU1V2RX?=
 =?utf-8?B?eUh6bXNuWlFYZWZBMSt0UEw4Rmp0NU9xakxhSjFmMkdOK1k4eGMwMFBtaVVm?=
 =?utf-8?B?QURCR3VRVHFtSXlvU2hIamRzU2FxWTAvUjZub2czSGRkTmxyWHRUTlRvcmtF?=
 =?utf-8?B?aSszZmtCcG9tdXhKNW9IQ3JyOTVpdjFpVDFRSEtvbndhaElabFRtRzNRcnps?=
 =?utf-8?B?TzBoUlViSVhoejlvclVIQzRxdlB1ZnljMTc5ejBBWjJqMnprRCtwMWt1bkMz?=
 =?utf-8?B?bUZLbGl6U3hNWVkyY1ZQZmZOZGRtZ0VxZXRmbXF4WVk1NzV4TWw5aDZwTis5?=
 =?utf-8?B?REVSM0RXdUVLaVpaTjZPNHFKK1lwSnlZVy95OW9nRWk5dWMxWWt6dmMwelc3?=
 =?utf-8?B?SHdkaWViMFgxMmwzQTNuM2VyanU3NUJQM3FuL2IreUt4N0U0TjQ0eEFwSDNQ?=
 =?utf-8?B?L1FSVGdORDU4N2J1ZjRmcEsrTFhRQUNJZFM5THpsbXZoaEZHVDZ1dTBaNDgy?=
 =?utf-8?B?bi9VR3VZS0xmYnpveDI1aG9hQ3o0Sm41d2hSakRtVEdOa2haakcvNTB3OFRM?=
 =?utf-8?B?Q3FiSXRHY0JhUFZaYmp5d2pzcVdaWXJIdUd2YzkwRXFOdnYxeTFjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ee62c-529e-4dd4-29fa-08de94bf15ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8441.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 16:02:36.2221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54vFDVCLOM7D6IoVeDKGf9qgyRaoiuCcbhUDJxz/76GXzr8Gk0yhVOPZTXvPlsLrJhdVqaJ2i9AJiB7uGIR8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6229

Hi Mark,

On 4/7/2026 8:07 PM, Mark Brown wrote:
> On Mon, Apr 06, 2026 at 02:40:42PM +0530, Raju Rangoju wrote:
>> Due to additional responsibilities, Raju Rangoju will no longer be
>> supporting AMD SPI driver. Maintenance will be handled by Krishnamoorthi
>> going forward.
>>
>> Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Krishnamoorthi, I take it you're OK with this?

Yes, I’m fine with it.

Thanks,
Krishna

