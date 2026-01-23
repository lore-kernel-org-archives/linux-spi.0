Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F234253B;
	Fri, 23 Jan 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152322; cv=fail; b=n13/9ZbxskZN2L6SvhzVUD1ClG5AO+5q7ZsLF3tkJoJ63rGaZVlzVL4FEjCncXSCxtPn5Jd8tiYyZC9IZ2iytjhtDBdVJO9ymjBJLhqsvItqxmTUqchsVd86MwofPXgX1KCFbEcDdWsDYETbChzddwBgmSFY5z6jQCQaR2y+F7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152322; c=relaxed/simple;
	bh=TWitUai8dn6Y79SCVi8SBmAIDzOFYLEmCB831kG2Xwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UbIIoN3Er67wLFoJCZy5vdvK8JZKbu0ZGKdG4uRk7H50/jce+Z418sTjHEqulO2Yo2HXfT4XF/uxw+Hl7m75PmOtz151QFZQG8vZlbwUXUAVZ18Uh/XfanVeG1WFUSEt3m5nvIr3ux/ymkdsgipcDts0PsYYHwm3Ko5RnmnYFsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hU0Xuh3/; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hU0Xuh3/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edmm8/OikoofpXCtAtHhg0gpBdqnXwv2IuNToXeMqIBkf36+nRNIZAEbFMUIMqnYWKV1BC64Qxa20vQ2Qcc2oDwKindEZ0XaHjrbIfD9cd2OgGkaGNkDs5kqOlk9a8m0JwdxMHHPRisej2BgXwHquNFEfDbFB2roidxg8PwUKAWg1gSdCsRO5p9IEtPgA1OTnzMN0QDdMlPHuSw7tU+Xeh0AynvLtdTKNiKD+jdzaK/K0KsABdc9OuhPKNFd1aBqkfoLe82kouG/VBO2TfjDMwW2Fs6JPWI621NuWVIkWY85E6De1OKc3h9I91D7Lvkpi+T91SzdEFfX66XFajVU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehxCJ+KeHb2MFrKvzQPnqsr80fT4oDvHaNSK1BXH3PY=;
 b=tz+usfra1mi0f9vTb+9idJrEvG2dvphyO6ErYTqXq4dxYoMMysxr0HvKXSDj0K2CWLSlYOhhe6m5TJQt/q/DnWUJS6D+NynqCoi4LmV5nqsddPx0u2FGiEWj2zDZn3ItSYk43BfWD2/cgwcXOwgBsC55K7uwxS/wGUR07vksUyN5SEFpPJjXiGhHYbDu9/0uLyPaZtQxaX3iA4aUQZCxrQ7cBeN4CWPcXw+hjIj0mKk2HPW7hI1V7DE/gIbDQDOTZZrnHT+YtNOTopTYQXy+WdT6wQssu9/lAyvUN5BioL0chpfeN01yj8yXZrgcVUcd7+oN8ccXBhZEWZcwnZAkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehxCJ+KeHb2MFrKvzQPnqsr80fT4oDvHaNSK1BXH3PY=;
 b=hU0Xuh3/5de0PWUQdLVl/g99JDK/nRWi1+37mSxlc+2e/pgDgdt6uVm2m1mwt4jhP5VMpAViHiYR3GtQ3vXm2c01OWp7V3ENziQQu4ERRi3l9GH1A4SNBChWisoW8FAPJ0oUIxZVpT8uLZJ9gBh13ymi5DTJhNlcllyeSFrNA0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 07:11:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 07:11:52 +0000
Message-ID: <ac0c9ceb-0c34-49f2-a486-1d87e488f607@amd.com>
Date: Fri, 23 Jan 2026 08:11:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
To: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
 <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5899374d-434d-4ad9-9e9d-08de5a4eaecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blU0STRqR1RrcHcvN1V0c3NBU0p2bzhsYUNkZlJqaHhTSTZkbUNjcjhVWG5t?=
 =?utf-8?B?NEpidGNyTWk0SVFkQVovYnZhQkpVWldaaVRqTDVsY3BEQm5BZnViaVI1QVBG?=
 =?utf-8?B?QkNLVU1sdXRMRi9yMVQ4djFHendWaURTdHA3Vy9mSktXZ3YwS1BLMWljSG0v?=
 =?utf-8?B?N05XaWFPVmVNUXZmelViS0hFZkF6aWZCQ21YUjlsbUZVdEVOc20vTnRzaExm?=
 =?utf-8?B?S0hjNVFnRnVSU0xLMEtxR1hyc2M2YjNMK3J4VzhJMmk5YWxPdFREbSt3Yjh1?=
 =?utf-8?B?RThPTHRKU0JMQkoxMWV1Yi9rZWczQklOZEpvS2FoMEw1NmRGbVI1MXUzdDNq?=
 =?utf-8?B?M0xWMWRwMHI1eWo1YWxibms3U0wzUGdBNlNqaHFYN1dsRTFNSE9HUkxoaFVJ?=
 =?utf-8?B?aVZaS3J3ZENOQUx2ZEkvTjNuNk9RNEVKMS9OSFNiaTJYQmgyTmg2YUVYUDVT?=
 =?utf-8?B?V2NtcFFXTnZFb3RycU02cHorczJnb1ZMbkFZaTg0S2ZwWE5oV1p1enI3VEZw?=
 =?utf-8?B?RE1VdlU2WGdvVXZlNWpDakdQU2swRnFDLzlDWVJTSHpTMTZ5RDVMdXY5MXZV?=
 =?utf-8?B?RTZrZDhSeFBNNjJSdy94Rk11ekdPckFwdjRlK2psOWRVM3AxUnMvYi90WEJY?=
 =?utf-8?B?UnRJN3FlNmxKM0lyVldWUmRYQno2ZndQQjN0MWZOcjlnZW85bjM0ZE5UU0xp?=
 =?utf-8?B?SjEvajFWZFFlRGRseGNzeWxrK3FOUG9oekpQdU50dzNzOWJpbjNDUVA2ZkYv?=
 =?utf-8?B?N2xHaG0zbXpNdDFWSHNGb0M2NmJkUW00dHlhQ1B1cmdRYjJ5N21ucjBIeHhl?=
 =?utf-8?B?Nzd6aUovK3NlZkhJR1g0VWtxK2psVjA3dTNFTzZTcHhJdDZpczlVYWdCTmth?=
 =?utf-8?B?QU1uTzVRQ0lKM2lObW9UMlZKR3dRWkxqWS9vZk9rRU9HK3czdnhUVjNiZUtI?=
 =?utf-8?B?d1U0TURKcVh0aXAzQmNPd3FrSGZJaUY4YnVRTjVKanlrUXN2V0hKQ3FSSjhN?=
 =?utf-8?B?T2dSQUhPVEcyTXd2Z1JvV2VlL3RsN2xRMVlVdlVxQzVQZUtvSk5kdFJsWGh1?=
 =?utf-8?B?SEMwbmYvdzV6cVY3QWo5L1ZLcHVRbDR5THVRUGZnejRPcW1Wb3ZLTVpGSkxT?=
 =?utf-8?B?d0daYzZEZ2N6Q3puUlBTVVFvR0RWanZOVnlGLzFGRkw3VW5XaGg2dVdPeCtN?=
 =?utf-8?B?Y29uRWk5SVYwQXJxK0VNenlCb0FiYnNGUzk5bjVELzBrc3Vrd0RKakx6Y1RP?=
 =?utf-8?B?M01xOGNvOXR3Z1AvWGh4QmZOKzVITFQvRVJaYXB4RHlDTnRTNjNkcEQ0VHRV?=
 =?utf-8?B?NS9vT1BFZHA2MmdaR0FMM2g1R29WSE5nQzlIbmFFS1AvajVHTHNEZFE0Y2NE?=
 =?utf-8?B?NkZpUGpxMmY5TGo0Z1Q0SjFoSVNvUGVHQllDcjA0ZDgxVkFMUmJMc2g0aWY5?=
 =?utf-8?B?KzFQbXJtc2ZVQ2xRcW41NXkvL3pTREVPU2pMWFM0MVRzMGdjNWRudFl2QXlB?=
 =?utf-8?B?dlE1N2hCM1FCVmtmVlNOSGNOT25JK0pVVk1ZeU5MS2VvU3lNcE9qNWF4STIz?=
 =?utf-8?B?NkV4dzN5Yk1NVU5PRVM0WDJtY24wNlZxYVRQMUhTK20vaTc5Si9CcnUwMmtm?=
 =?utf-8?B?VXFVdFZGd2djN3J3dXdyTXVCb3FVem1acXlnSlZLcFVZZUZWVTQ2TzFpb0tm?=
 =?utf-8?B?dUR4b0JNS293UFBLVit1bExOSkNDT2lWd0Zyb2NqekNiZENGeHlGbDJCVEZ4?=
 =?utf-8?B?N1I3L0JYaG9lV1lhVTBQNDJBNk12U29UY1RTamlKZHhEODVXdmU0clZwL3c4?=
 =?utf-8?B?UWEvb081dXUrbzIzOWV1YndDaHlJcUdnN25vbHhVeklpV3I1WENuYVJPTUZx?=
 =?utf-8?B?c1NleUdJeUNkZ1Z1VXJ6dHB1SDI2eTFwT3A5MVhVNGdBTGpUQlhqeTh2TEpr?=
 =?utf-8?B?U2QxbUlBZmVsTDF3eFhGV01LbVV4b0dXU2Q5anZ6RjY3ODB2OTF4SHp5MGRJ?=
 =?utf-8?B?d2VDVkc3dVFMUFJvczArbXppZWsxRHBHZFdMQTFNS3NpeFYxU2xobldrM1VH?=
 =?utf-8?B?d1QzQnI5NDYreUs2UFdscFFNSVdYdlJMaWdqaTVqUWhuRTR6c2l3MGFDZ0Z2?=
 =?utf-8?Q?qoVcHErBgbyMhnzkK3h2dM77x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFka1NYRFI1QWxlaXRJbU5XazQxYTJPQnNScU1kY2d5TXprakNNNUd1amJu?=
 =?utf-8?B?dlhwY0xEelo0QzNDSDNXcmNFVXdCMm1MYjNiczUxeUlMbnd6K25MMzVpeUt0?=
 =?utf-8?B?WWk4MjVYUDJXVmJhd25veUZPSG9RNVJmU2xiRGJwMkZpaEMyWG5iT0lPY1Rv?=
 =?utf-8?B?eExiNFVEeU1MaGxyUVlFOEEzVk9LRXRmaURyUlJJMkpteExmZDh4dENYOU9u?=
 =?utf-8?B?VGxRbHI5NnRLdlRjOXQyejNEcWV6SWxpc25Tb3pneC9ybmZKL1RGcDgzY1Z5?=
 =?utf-8?B?SXpTbVBWSCttSUZWbmdQT1hIdzFsbStYWnpOYy9DMEpJZXdtL282Tmt5YXpR?=
 =?utf-8?B?QzFBbTVHL2R5azBiUm1lQnBwQThlQ2hud1JmTlNmb1I5M2hhS3ViaXlTdzk1?=
 =?utf-8?B?YTNtZTJIdXNrMXhxM0xtS2FWUHMyYTU5RmNNc3BaUjkwWG1sSjh6VnhXRkpU?=
 =?utf-8?B?cEluem9Hbll4ZXczeG9JcEplbi85SVdvWVpRaU9jY0kxcVkwZUdJZ1FpSmk3?=
 =?utf-8?B?cmRKQWZ0QTJBNER1cFlGaWc2YkJScmY0Ykc5TE1nN3Y1SUM0RWtNVEpoSG5w?=
 =?utf-8?B?TmduR01HWWQ0SE1lUEE2T29RWW1KajA3bTBrbC9OcGU0eDA2NGFTbElnUElD?=
 =?utf-8?B?V1pxV1JqZUJhWW5GRFpBN010NitrRFNOMDljMCtmRXZ5MlJxbXNma0QrSTd2?=
 =?utf-8?B?ZXJmbithTlp3UGtKK0N0eklLcXRtM2laTjBydUN0Y1RGQ29Ia0xKdXI1bTNt?=
 =?utf-8?B?eDFTTjNRN0dKdWlHSzJqS1R0dHNpK3l0VXh3b20rcjl6ZlBXSzdRanNjL2Jv?=
 =?utf-8?B?cHh0T3l3NnFZRWh6VmU4SFBNTmh0Y0o1TDhzdSswRE9VdWNLM3RVQnBzSDZF?=
 =?utf-8?B?aDNDOWpKNVQ1ZldEeGJzVDllRkZjUXhpaGp5eFZ4c0lCWWpOU3JmQlFrWHY1?=
 =?utf-8?B?Q0xWcTNxTGJBK0FYdWpPQ3ZNazRJTk9uS0ZnbldQQUFuMncxbW00aDdIZzJs?=
 =?utf-8?B?T1czcS8vRWJyK0JodnZDcFlLdTNlYkdGZGdhN2o2VTd0TFRSaDBXWHB1anFj?=
 =?utf-8?B?ZjYxd3JmWkVncGpWazFLZTZ4QVY4WkNNVDJ1Tk1kRUxlSmptS1NaNnBZV1V1?=
 =?utf-8?B?OHlHSGVCcDg4M3VyckNxc2pIQ0Qzb2ZFdlhiRnd5WlUzc1pXaFF5ZGwydUlN?=
 =?utf-8?B?bklRdWs3VENjZGRuS2dhbFpvUFZUTmMwc1h2UnFGTUpsTXZPN1M2TEhXdWJn?=
 =?utf-8?B?YnE4Q0N4bzl4MnFZRSs5d0JWZFVyT04yajNENG1FcnJQQ3dMS1RDRGo2bTBm?=
 =?utf-8?B?QVBJRVhvWWhYWEtRdU91Ym1ZZExXYWhFemI0RWlkb2xENlUrb0l0Mnc1UWky?=
 =?utf-8?B?Q280ZWRkQXZsdzJXSCtvUmlTbWlDU1J1MlhQQ3ROTGhkVm5KYlZnVU9uVm5H?=
 =?utf-8?B?NWJXQSt6VzlkWXNXKzYwa2x0NWFidXphcnp4UGRjUERvcXJnQjNTSnNpN0VY?=
 =?utf-8?B?R01PODBlc3QzRVNwR0s0ZGNDSjIvNW4weVlMT3BUSlRCMEo4eGh5UzFvMjFV?=
 =?utf-8?B?WUNpcmRQQ3JpY3ptbjNOeVRQdjdjZ1c4bW1jQzFLYSt2cGJJMzB6aGNCaUlt?=
 =?utf-8?B?NnBaQS9FSDJzMXdrejAvS1daUEY2NDVGclg2L1NLbUVJT1E2OG9US0lTeklZ?=
 =?utf-8?B?b2tHUk5OQnVvWURCaTFFVEIrMTBoOGovMFkrdVJ6VU9qaWZsZVJ5MTErSnZM?=
 =?utf-8?B?K0p2Ti81dkQvbmhTbGZoZ3VrK2lJeFdUWXB2Y0hjM0VNNmZoRDZtNGRRTDd3?=
 =?utf-8?B?L0J6MWx0YkdBU1UyaG1Pcytta25yenpqMDBPbUZnUTRzWFV2K3htRXpIU3pK?=
 =?utf-8?B?aXdlbTdzL0xTQVVyZVZnd1FOMlp6MFByWFpDUVZlOENhZTFZbmdXV1VlZUVi?=
 =?utf-8?B?UjhSRzhkUjhjSTAxb1Y3d3pWMkRUUDFuSHlnbnFQTzhrRjRjRWZrZzBVU2dE?=
 =?utf-8?B?ZWs1c2tDZC9XRHBUd2hMRnlVUUxQUGdTNFBCNEp2ZVFqUkp1b0xydWpGbUJz?=
 =?utf-8?B?NWN4QjBSQXg3QTJZR1ByQ2U2WFphbzc3ck9sK0k1cjBEQVF5by82ZEQzMWhi?=
 =?utf-8?B?b3VoZTVhMWJieGJsNktrejFQM1ArNFFZMGROTi9ZV0E4enhNc1hHc0xHVmp5?=
 =?utf-8?B?bldMUzQ3M2NySlhQWjd1U1hoMG9CaEpxNjExMjJLSEMwanRxL2J0eXpFOFd0?=
 =?utf-8?B?NmpNMklib1JieERsSlJjcElodXBnNWNPeWsrcU9xbUJIL3ZQemJ0OE9NZURG?=
 =?utf-8?B?WVJWREZBUTdaMTFzcEVSZEZxNEZTbkh1VVErUUpaVHY5UlpSSDEydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5899374d-434d-4ad9-9e9d-08de5a4eaecb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 07:11:52.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4bjNAFzWgIMtAPI7zLGJtdacFTOwoiLsFlt8MK6noSELfslqXE2Znc2/9ytlymj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483



On 1/22/26 17:18, Andrew Lunn wrote:
> On Thu, Jan 22, 2026 at 09:00:29AM +0000, Abdurrahman Hussain via B4 Relay wrote:
>> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>
>> Switch to device property accessors.
>>
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> ---
>> Switch to generic device property accessors.
>>
>> Changed from v3:
>>
>> Removed the patches to make irq optional from the series
>>
>> 2.52.0
>>
>> base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
>> ---
>>   drivers/spi/spi-xilinx.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
>> index c86dc56f38b4..c4b70e95b695 100644
>> --- a/drivers/spi/spi-xilinx.c
>> +++ b/drivers/spi/spi-xilinx.c
>> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>>   		bits_per_word = pdata->bits_per_word;
>>   		force_irq = pdata->force_irq;
>>   	} else {
>> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
>> -					  &num_cs);
>> -		ret = of_property_read_u32(pdev->dev.of_node,
>> -					   "xlnx,num-transfer-bits",
>> -					   &bits_per_word);
>> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
>> +					 &num_cs);
>> +		ret = device_property_read_u32(&pdev->dev,
>> +					       "xlnx,num-transfer-bits",
>> +					       &bits_per_word);
> 
> It could be my grep foo is broken, but there does not appear to be any
> users of xlnx,num-transfer-bits and xlnx,num-ss-bits. So it would be
> better to just remove them. There is no point Maintaining an API
> nobody uses. And it would be silly to spread that API to ACPI if
> nobody it going to use it.
> 

"xlnx,num-transfer-bits"
bits_per_word is initializing bytes_per_word which is used in code for transfer 
sizes calculations.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-xilinx.c?h=v6.19-rc6#n470
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-xilinx.c?h=v6.19-rc6#n125

"xlnx,num-ss-bits"
num_cs is used in host->num_chipselect to declare amount of chip selects.

Both are also the part of DT bindings. The name of property exactly match the 
name used in design tool. That's why it is 1:1 mapping and driver is quite old 
before num-cs property has been created.

Thanks,
Michal
