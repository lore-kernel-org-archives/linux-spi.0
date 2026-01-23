Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B55285CBA;
	Fri, 23 Jan 2026 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177691; cv=fail; b=fAIoihs8mQNPF5IWAJPcjbY0QcHB/4jE17Ky/ymwjFa1k09n0184nbAbIQJgr/LnyNyviObecpFG3+AaALDZIJEGvnPBmX1AtgjC24TQQVXgtiMItnEbXpjpNaJ0ya59rc7sugA7jzBYl3y4c7al0yL8PLU7TXJaGwwBWMCJlho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177691; c=relaxed/simple;
	bh=P9Af6VfJbqYRsveK/QnMzjPqr5Mk1XffAQaKzslB5Ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYo4JC889arvDUD0zftFBVDgxQ2/8lMYX6VneOrJ+zDz1DjhSH3OZDmv/zmWM7y/2Pd7A//Sh4rqcPiVHhy51QcgaFEm8+Wh6cYTeVKgDTB8fHCN+ai4lift2CoDWxC2rIvxg1WapmkL0b+Pm7Rc2KROkqiqzvQE+LN9sgLTnz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oMq/yW8Y; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oMq/yW8Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7g0FHjtQFH3peMEbau1GO9Tn3klzv8Zu+jxShHtwesOqyALKku8o4+HfAcwm1NttsMYb7nTokOhVvVvmWf1sNi3R2J/0z3byWl+ucrE4LWip7THMeNbtfNE7RcH2AFQDcpNS8LIX8jryRFhdZvP1IUeD2N4BliiJbm8+cW3hySnEe+Iwv9yMgk0C4z90x6hUue60tHw8fmW3nrvFiwRr8ZBinDSuhKWbyUW0+5E4Vzc4Nt2NFnWqLSw+4QqLOAyxU2QiRRyPmulNGWhB6CBYHKb2gBwSSTvp1yzEIwrO2eeiEhVB1fNT8dJPjsKGsDJ8hI1qv+8swCHxQyk+PWjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwBUMDy/zOmT5J3dWznJh8mjzL/yAouyAokgKarzMms=;
 b=dxOOSFQMEFhy4UUzprATd+kSaEKh13lfCAv+ghfeGpBncGM5VVrE+POvqsM8nOZjAIiFSegZdjAVqiobd4nAFcESzTCGRfozLK3ogxkkJzT1aNpTXNBxKRd5kio6/zabBxx43R6Lq3QYUPoQZfiA1v0tZupy6DczblXkMXStu5MQq8I7f2EGcblEJBF+MMRNtQJ0wr5Dxb5yfycjtroTvG43uJjbpZhG4FtwmyRo+Cdyj8+j4P4YFcXQTYgJziB4AUCwQ41b9uzpdqy0aTwlL/rkNMY5rlcOZTbVCPjWj+SZn2kJVpxVyTWbw8YCsz/oQevzE/XvopICE5O78zeIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwBUMDy/zOmT5J3dWznJh8mjzL/yAouyAokgKarzMms=;
 b=oMq/yW8Y9VQ6V4UPIcsy6PxP5yUJ+eRUjgigVuk3BxKHkl0hzWum0aoOHeerK6bDdgBJFdIrnIfe///oI7UMEiAgPteuiWP3/Odyj+mo+aUCVCWWzPeCBJ0RLYfjGt11ivx6jM3EJ/WBUGP/gD8+xNDfE+LzWEwagf5zVna/GyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 14:14:44 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 14:14:33 +0000
Message-ID: <c0310e06-4a50-47e8-9de7-581eff6f53ec@amd.com>
Date: Fri, 23 Jan 2026 15:14:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] spi: xilinx: use device property accessors.
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, abdurrahman@nexthop.ai,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai>
 <d6c5547b-0426-40d0-85b9-b64f183d37b6@lunn.ch>
 <ac0c9ceb-0c34-49f2-a486-1d87e488f607@amd.com>
 <a979b1eb-87c9-4c08-8d30-0fe18ad07a26@sirena.org.uk>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a979b1eb-87c9-4c08-8d30-0fe18ad07a26@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d30b1a-8596-4422-bdcb-08de5a89bb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXI3aC9Zc0ZORm5nV1EydEJobWxWdm9SWXp6Zzd4ZTlYa2gvZ0NoelIrRExC?=
 =?utf-8?B?SkR6b24wblJoQVNNWlRIZVZHemVZeWJVdCt6K3g1Z3FDRzA5MEpRMjBFYXlO?=
 =?utf-8?B?eXltYTJkeDlhbmIybzdnd3hFRVhEbXZna1VTVldINVVYb0hZUTM4NkQ0eXFa?=
 =?utf-8?B?SDJkaXk5RjVBdUt1N1FnR0hBSE5PS3QxVklFQS85M3FSUVQ4QlZ3RE5wNlQy?=
 =?utf-8?B?MEo1cmwzZlN1Q3dTYWtlbkExdjdrZUlCR21hcERVVElxeWtYaXpSaDRqY3hZ?=
 =?utf-8?B?eU1xeG1aYjJXM1JqVmUzSWN4RmtRQWlsZG45bGZNNktNNDErcko5QmVtSFR0?=
 =?utf-8?B?STdQemlzNjZiNWl0MXk2YTlRM25WNzRuc2tEZG16Nnltc2d5blVaVDdjZzZx?=
 =?utf-8?B?Nm1DUVF3UmcwTUZpN2tscGdZc3FaWjRVeEFuT3hhekpXcEZQS0hjOEFXTVJl?=
 =?utf-8?B?MlhKeHpIZkN6NjQvMVJ6QTF6MUp3d1VJeGZiS2UvdDBhQmtwdmlyL2RFY0xX?=
 =?utf-8?B?QlZjOTBHNnZDcVljMVRUd05zcVZndnI4R2IrQ1lVVmhQNmNsQXNWdElMYnUw?=
 =?utf-8?B?NEMyZlp2SW5YZWRQZTQyRlAxQTF4cUJEejZQOThMY09tL1pKRUJLTG1TTHRl?=
 =?utf-8?B?VnZXNWNaT3NlcXA3YVEwRkxJVkJHZS93aUdZZWliaVN6bGp0WUpwR0x0b0ZM?=
 =?utf-8?B?ZXlBYTc2UWhDai9HN1FCNkhPVmVCWnlnQ1Q0V0ROZzhXd3k4d1hzT01WNGg2?=
 =?utf-8?B?RHZ1TG9TWHR2dDlwelB3SlQ4czJBMmQ1ZlB0blpxem0xWGp0VU5oSUlIZVhI?=
 =?utf-8?B?Q2dxZE53VHR3UWNTbzZiRmcya3ZvTmNXRWhvaDdDaUd3a0lXYlpOK2FvUnVN?=
 =?utf-8?B?cEF2T3U5eWFVdUJIVTY1ejZISHJtUkdjWmp5NXNBL3lGeUJSbXJmRE1Hc0JX?=
 =?utf-8?B?Vm91TC9RNDZhcmxjRlBvN1owQ1hXcVVRUFNWNTJsOWhOcjhoY1Mvd3lJSTdU?=
 =?utf-8?B?M0k5bDE0NHpHdFVEdHplMU8vSFNFVHdOSDVFSmVaa3lyMFBjU1JackFkNUlq?=
 =?utf-8?B?NlQrelROaXJnSktiYndneG9Oc1R2UkJvTGwyelAyMmphRll3VDU2QWJMcUFT?=
 =?utf-8?B?ZnlILzVrUlpYclUzWFNBYk16Yk9RTFAxeGUzbjlzQzA5OGgzVy9td2UzWGtz?=
 =?utf-8?B?QkJnbkkxb3dpWUUrVUJ5eHEwL3JHTmtadFQ1dVJDeXhJQ0pBSE9vdnVwUkRZ?=
 =?utf-8?B?ZmJuMUszT0k1Sy81cGdQSzdCMXNpbzBzZEJ4NGhWOEhjNE1vaEVuZnFyZVph?=
 =?utf-8?B?WTJSWjFvZkFWYzhlNzZ0SHhRd0lDeGU2MzRXNG0vcGxkY3JieWhGUGx2VzBL?=
 =?utf-8?B?Y0prdUNkRWdtR09ZclRvUDFvcnNTdFdTMU1ObEcxcHpIb0xrNG40cktjL0NC?=
 =?utf-8?B?Rm9YMGVtKzV0NmJJVGcyR054Z0tLcnVKbFBZNURoSXVINFRVYTF0M3duWVl2?=
 =?utf-8?B?VnJOY2tLajhGY1RvYk5pZHoxamlNRXk4ZHdLYzM1cGJydGFZbysreWFhemFX?=
 =?utf-8?B?c3BlM0p0M3BqdHVWQ2VmN3NUblU3Ty8wMDBYR1hZS09UWjFlRXdlQjgyVCti?=
 =?utf-8?B?K01vcWpjajVoMzhnYnhrM1crcU9DS2cvMUc2bFJHYTZxREdrOG1lbU5QVlhS?=
 =?utf-8?B?Z3NoM0xOaHJXTUJTRFhKbnd3VXlJTFU5ajNodjRvQmRuRlF5N2FCaTVFQUt1?=
 =?utf-8?B?bytSaXh2NzVIQzl5Q0FabUFxUUpBQjc5bnFrckVjVFN3aHlrZmtjSG1DUVZC?=
 =?utf-8?B?cDdqdmpqblRUcHo3VVF5RFU2QjR0QVAxU1h3OWorbnpvZjYwZkEyLzBFTUEv?=
 =?utf-8?B?dVIvN1NQSTdudjVTcUt0K2o4SmE1V1Y1S1FUVE9vVWFQSjNBZEhNS3JkcTVD?=
 =?utf-8?B?MzJXL0QwdVV4b1l4b21GK1o0Q09raTZnYkRzOUw0Y0k3dVpsbGJ3Y0g3S1RP?=
 =?utf-8?B?MVNBdnBvZmQ2UXpTa3VuVDJnTENrNWdsKzFhZ2FValYvQnp2RHo5bWk2R0VR?=
 =?utf-8?B?RjZINmdMQlQzbnB6ZThkOTcvSVVUYnRTdGc2SzhDUFJxZjhQd1NJTElqT2NS?=
 =?utf-8?Q?0kgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3JKQlYzbGIrZFgrMXVaSHNBdnlWSlNSbHlUeVJ6ZjdQd3l5ZGNwN0JVbS9x?=
 =?utf-8?B?NFkxaldOR0s4ZHhOTzAzTWdEMFAvTlMrYmswSWlneUlFTFBVT3RIRWRhK2Ez?=
 =?utf-8?B?eDRkMjhLUTdpSVhkZk5FMUY0NFFSTWMzaDZTUEJ6cEJWZDJieGFYSG9hUnZJ?=
 =?utf-8?B?WVBHeTFQOSswblptMXpkUXFKSEpFTDY5WXFBTWJpVlBWa0loV1VVL1pRR1JX?=
 =?utf-8?B?Wm5vV09qSFRSUmZuVUxqaWlyZGc0YStHNVNrSnNpTXA3TnZoYVBvUHJiR0Vy?=
 =?utf-8?B?TG9JakNDMVl1TS9tM0hQUjdJTTFqVmNSelNwMW41RlRmQzdjbFQ4N2FyNUxZ?=
 =?utf-8?B?blVlNm9ST2lXcHFHNnRSOFRPaElvWnA5MlEvZHhRUHF0SEdhanowa2ljekVB?=
 =?utf-8?B?SWY2b0RjSTBhRURUbW1QNDNXdng0c1EwcXdLUUtCRzN5WTYxWjdJV3p3SmNW?=
 =?utf-8?B?Mk5BNEFuVGFIc3BIVDVNVTNoWGFra2hVUjVuaWJzTFhvKzVZSlZiVk1ITVdZ?=
 =?utf-8?B?My9zbEFEOEFsUWlZQk1sUmg0WEk5WVhVczlicUZ5WnllNzNiNzZXcXRMUTBF?=
 =?utf-8?B?Nk9pZU5ROHB5Y2VHcGFURTloQ1pkNnJBdEdKVVhkb3ZPOE1PYUJNSFNTNmps?=
 =?utf-8?B?S3IrSzd5Z0VtdUxsTmhPeDRUZGt0a0ljZXhXK2JXQm5pcS9MeFlXRm1EL2JE?=
 =?utf-8?B?bkhadUxsQjFjSGhDN21CbE5kVktGVkpWamJnMFhrdmZBaXBnUis0eWFnQk9k?=
 =?utf-8?B?cnlJSnJCcmEyV1lqQS9ZV0R6aVVRdUE0NzE3NE9mcEVMTFVBbldzWDVSeFBk?=
 =?utf-8?B?YW1FODkvQVgzOFlMeFhXVGxlZ1IzQU5xb1E5RUo3WFczV21XazFEZTdCNEFn?=
 =?utf-8?B?bStPQ1k0SVNOZE1aK2k5ZVJMU2RUZktnUmc1QXV0eW43VXB5V0RWZm5TSXFN?=
 =?utf-8?B?b3dqNEJXMTk2VERqNGRnQ2RLK1FocW5qcUwvLy9ETCt6R1VZSTlONHBvNGdV?=
 =?utf-8?B?U1V1TGxTYTg0N1REZ093NWtEWUpjYSt1OUV5ZUxFclI2NGh6SytpT3d0TzFz?=
 =?utf-8?B?U3RtSHBaeVpGM2oybDBkZEZHUHNaWGFyUm00S3d3RUR4MW1UZjkraFd1YUda?=
 =?utf-8?B?QlJtUUxROU1ITDF6S3EyS0xGQnI1djQyMlpzb1V1ekVWVXhpNkNxNDcxL2Zt?=
 =?utf-8?B?ek1ydFJCUGF0Mm4xUU80R3hmWERRTHVudnhJQ1lMWGhaMENtYkJIMFAwS3F0?=
 =?utf-8?B?OUVsYk01VGlSa0I1TEJ3eWdxemdjOGoxbFltZnRueGt0Rm5nam44ZTdXRkJT?=
 =?utf-8?B?RmppZ3k2ZUVzaVBFa0NZVndPQkdaL0J1U1F5S0FSODN3QlRKOEwzaXE3Zko5?=
 =?utf-8?B?M3ZFeVBnNDhmMGJPWVNPOVNTZlQ4emxEZzNjTms5VDNRUlpZaDUrVitjZWgy?=
 =?utf-8?B?NktkUXhxdTJDbFVzb1hoNThSQUljKzM3aU5qWDNSK2p5NmJZOW13U3MwdjJT?=
 =?utf-8?B?SGNIT2hBSURZN1JqTVJ6cGN0N1NFREZFSGtmelIrREN6aURVRm4yc0JNeThD?=
 =?utf-8?B?cDhsSnBqYUwwVFpsQ2Q2aGFnbDRjc1NoQTdUTGJzTmx4TDZsOHR5YjlCdllZ?=
 =?utf-8?B?Z3hJTkEreUxLMEVtYWp1TW1tOUxrcGFFbGZrV2RiRVRtUVVKcUl3alltMXRN?=
 =?utf-8?B?R3hadE9YQ2VReWh2SzJ1U1l5ODYwSnJoUXNJdXFpdkVuMEhUaXdMUGNJN2RV?=
 =?utf-8?B?d3dZVmpBdW1zNUxXeTVISWhNM0lGcTc1cFNXOC9pSTdWc3FBcDZlNGZGa2Rl?=
 =?utf-8?B?OTFKRDc5RkVGUDdEL1IrRzRqUU9qZHpSSDNYU1N6SmIxamQvMVF1STlkRUEv?=
 =?utf-8?B?YzVDL3hoQjZYaGVEUld0Z1d2YmFTd24vTVVEd0MxMFFwMTdSZEtOS3BPQlRl?=
 =?utf-8?B?dElhSUY0YWtVV1AzM3h3L0RaTjBTMGpZZ1dTSFc5M0wzb2ZRSE9PbUhVRkFi?=
 =?utf-8?B?cCtJY3RwakpoeWZ4VmZ4QnUxanRabXJrZTNUR0dWalVNaWxDSEVwYjd6cTJ3?=
 =?utf-8?B?dW5pR0NUUXlsSCtrcE9ubnFRWHdEenVmRGpkbUh5WXIwSFJLQjJmd0VUUHZy?=
 =?utf-8?B?cnJyUnB5RHRVME85VmRQaFlITHJUOXY1UEVWTnJweGRaUllnS1VWb3Q0UEt0?=
 =?utf-8?B?eitLUHFITnVUL3gwM0dFTUI1QU94QzNlYjgzbkpBYy9KU2kvWXZXNHpna3Ji?=
 =?utf-8?B?WUxDa2FZWUttOHpqcDcwSDY4UVR1MHRwUit1RDNEdXZITTZINnhCcmJPaGdq?=
 =?utf-8?B?K0RHeWdwQmJ1Q0RYZ3FSZEJjYjhsQnJpRUNXcWpCa0xZcDJhZStVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d30b1a-8596-4422-bdcb-08de5a89bb02
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:14:33.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da+qyAFBQ6jFGl8Hc12u/YQoP5dNf+fF63nH2NMl1/neYbTlSKk+Wb73ADZkTi0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136



On 1/23/26 13:40, Mark Brown wrote:
> On Fri, Jan 23, 2026 at 08:11:47AM +0100, Michal Simek wrote:
>> On 1/22/26 17:18, Andrew Lunn wrote:
>>> On Thu, Jan 22, 2026 at 09:00:29AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> 
>>>> +		ret = device_property_read_u32(&pdev->dev,
>>>> +					       "xlnx,num-transfer-bits",
>>>> +					       &bits_per_word);
> 
>>> It could be my grep foo is broken, but there does not appear to be any
>>> users of xlnx,num-transfer-bits and xlnx,num-ss-bits. So it would be
>>> better to just remove them. There is no point Maintaining an API
>>> nobody uses. And it would be silly to spread that API to ACPI if
>>> nobody it going to use it.
> 
> There are no upstream users of this driver at all so obviously no use of
> the properties.

We are not wiring this driver in any DT because it is soft IP but it doesn't 
mean that it is not used.
But as you see Abdurrahman is able to use this driver is one configuration.
These properties are stable for years and well documented.

Thanks,
Michal
