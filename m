Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022090.outbound.protection.outlook.com [40.107.200.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256033F5AF;
	Thu, 16 Jul 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215372; cv=fail; b=eAVc8pj7SYyoXkZeEmNVqF0jajl0wtCM06IMiFPLtCsxYZFFFpLeEW6d2Fvocdq2nX3CQyAhEkG/Tnbqy3mBdrAR/C2n2oFuZhChQg14rnTSTroxFLHPkY+7CNYwLgEbOGEPu96/28onzM40maOHTHHYhQQ2LrDtEFDeFoIjWqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215372; c=relaxed/simple;
	bh=bj7/tVa+SNfjCvOT25HW06nTi49lPfnitoQxrLu/RWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7rys1/IszCCG8vMzv7uNKDw3+kPt/o7esxTP/APyC0o9JxvzwwpCX7J1gAV6SbtcsEr3sGdQpIK2ddUaXKnIPSbS/JFnBxoakagq9OqBZB/24YnzHWl2eMTzEAZu+rRAlCJ0IWI3iZcrxA07nkMaZPoIH1wH2IHyvAfS3uFLRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=k1/9El3U; arc=fail smtp.client-ip=40.107.200.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="k1/9El3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoMdkHx1dnAQEkSw/qeCfbrT1hEA32xmx0Q8aMjAByxG5zfCaAoyn5r7z3ZnIfNjnjo10QgGENQ3XRD5VzPqgPdAZMpkJ/zk0PRykbUq5pye0RjKqdRBZPWwN2EsioEUcjvnmJE+f2TB9ETQ9xAhBBZ7D+aiE+16sbfISsY485y8Hdxs9Ym5hAmdTmeESpc/Ul35h10OnZupLe3SKywPAJTtuhBaw0RgZO1OQA9wlVxj0Ah1j4EiOl+znGzZi0DT4yKbJr9B9Epa7Y2Fq6glG+s82IS7pVMGbU2nvthVLUSWKYBjNLniVqg9rh/JT+29QbXzypbu8HM0S0ULnTldNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj7/tVa+SNfjCvOT25HW06nTi49lPfnitoQxrLu/RWw=;
 b=l9O8mpy8krS7aASekwWrdkSZYhli0+XqBoNFVYZJ/FrpnLVmbtzmOvfXi9TiOlQVUFgvNjGfebD28MuKhglXrtOasqEt9M49+NbJJ4w2tpHMnrpL7awNhR0LN5aj6I9i4RCFJTE5rFUQHU17PeH1F19CNAfPxFFrnz1J65/sUUbL/WO7pRrEqmyX7iJReegHpydKWjAKML2B8ArAWVLuhYyqG3tlHcmbrOMxdIgbyBdVin9V5P9D81fniFxyadcqT6SN1AP+LUUC8xQuQXEKFT49hE/5SG1uR2hKBqdZAzmaXNoQZ/U0M9Ks4NKqT7qSt+H1f525ks+KchJ2yEezzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj7/tVa+SNfjCvOT25HW06nTi49lPfnitoQxrLu/RWw=;
 b=k1/9El3UsHsksTfATk4m/LfDNyBTo5pjfmiUbTvwYlFZCu0HVfTWk7mtkX+cwRdI73OP+gqB5kw4wlhl3AcDyQSQLf1VGfTxBZPckxbMEtD8uS+BUnPKtEkO7mGgrtNN7lm/i87upLTDCIf6lMBWgjT7JhtzOI+E/gtjtE7AMYlq0SUtUrXoh2ea2/6URVsrBNJ7kt8YST0GglLyWiNp3PljpA/boeUyuaQZOAfAd/0ODxMrQkaleykabffkEEnXKmuS9oJP12impbb6I/DbIhvTxQU8tuPyPrya9JUn5QxmKbnLU2wB5sR828JkPue2RtygUDpJjVF+QAfW9XRgSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c) by IA0PPF799512FA4.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::c28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:22:47 +0000
Received: from BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e]) by BL1PPF1B62FD55C.namprd18.prod.outlook.com
 ([fe80::8726:2e55:848b:39e%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 15:22:47 +0000
Message-ID: <c9d57477-881e-40b3-b24a-edbf7a016475@axiado.com>
Date: Thu, 16 Jul 2026 23:22:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: axiado: merge identical if/else branches in
 ax_transfer_one()
To: Babanpreet Singh <bbnpreetsingh@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
 Tzu-Hao Wei <twei@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Karthikeyan Mitran <kmitran@axiado.com>, kernel test robot <lkp@intel.com>,
 Julia Lawall <julia.lawall@inria.fr>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260713060807.7-1-bbnpreetsingh@gmail.com>
 <20260713060807.7-2-bbnpreetsingh@gmail.com>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <20260713060807.7-2-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXP220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::8) To BL1PPF1B62FD55C.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d8c)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PPF1B62FD55C:EE_|IA0PPF799512FA4:EE_
X-MS-Office365-Filtering-Correlation-Id: e4153488-00a5-4e59-4b4b-08dee34e170a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wF9voD+u+iUAyoZGncTR87tN8XeooK5Moh2KSP7sAdH1npxGw7i6RXACLz8pE366AkffalPp0wyGsCE4WdVeQoSozlj+rbAFsVkK4TT7Qp1VaQxb4qLICZQq2ChI+0FdTiWMHryscUt6BMXeHpvPyqwyXGyLpGgGlR/UDr+9JBjRbXjtGUTTjfXIPS0QSX76SMPYezb7g3QKC6bzr3sqLukXcZBJPoxeK8m2nq6tLEcxmOSW1/H8BXIwpo5MUx3DKW5qx6rs9+S/Wa2WtDlh1jqOM1QVkJgicHaaGsp49GsPHA1HfqbQet7XECsEWhM6LW9rmFughV5agQtpT29FVu2HgquTgfSAgu8ZnSoG1oVkWOfVd1DHbfiSlyqtM7E3pdKhUth0M0DlBSfzyNzSvJrJXsq8kwRGWdr8lsddMJIqRUm/BakxiSVXfeZYDuJWsNS6TSQW0wYI/dxVinYJFuFexakcUTjJPghZaHxCR3Y7Frt0RWdrMjC487QwBD+A79FSG7BEdRrBvktN9wVk40bLTPXByt2OFjfYPbP0WfJVklsxrzKvfti8gJji9h2aUSpw0vtfqLC/m+hx1nNmgGFFPdcM4adM0/UX7Gmug8QI8l7vtfqpimzRAvUHD3dej2fQmZEyXDep6/FnGMAV9jV0kqs0bGjER90V+qvy3DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPF1B62FD55C.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNQbWJvQmdPYXo3WCtLVm1SeFlITm9scEpKeW9sT0hibmxKSjVOV1E0L3lE?=
 =?utf-8?B?bTBIQ1ZMcTU1QUZOUFZ6SWFobTFmbzRQbHV0TVNBSzh1M0lhMnRkRHBrZDZj?=
 =?utf-8?B?aXNxZ3dTb3NKeS9VSmFERWhHTm5yZmRhM2pvNUhuQjlEbHBhOUp4Z3dmaDhi?=
 =?utf-8?B?QXZ1Q3NkMjRiNmRtYmM3bkRsVHZPQ2tGQlk4QlFDTFZZdWhyUU9DV1dYMzh0?=
 =?utf-8?B?b3l0c2VHWmN2Q0xFTUpDNWV5VG5rTVNCc21oYlNVVVUvVHYwOStORFkxY1pL?=
 =?utf-8?B?OWF6L1JobU03NllIY2RoK3IyL1dsa0Y3MEpoZHdzdExWK3dpYXRKemREcDFi?=
 =?utf-8?B?OVBwV3dxMW40VzlEd2F1V2p1WStqblpLR1VCMmRzNUtkeU43YXJ6a1E1bi9L?=
 =?utf-8?B?dTIrN1F5NHNXR05DNWNqcVc2NjNmaUQ0eUhQTjY4TWU0aXhrQTlHSjVUN05H?=
 =?utf-8?B?RVZocDBMaExpRllUby91L3hUTnU5dXlOb0tIYUtzWkUzTlB6NkFHUmwvMS9E?=
 =?utf-8?B?UnJRQSt3U1hPeGpkSHpjQ04vdGlCYnhaV0xRcXQ3bFltK1Z4ZTVwb2JZZU1a?=
 =?utf-8?B?UitrcU1wSGd6bWJhOTltTEVnMzdzbzlDUkVSbk1wdG93cGtHaHBhMVVtRHNo?=
 =?utf-8?B?bUhrOXhicVJQQVdQYTEvSlZUNkZLSjNvRXZpK24rTmxlM0dQdmU4b2ROZE1n?=
 =?utf-8?B?bnJtOHY4dFFxSUVwRXgxT1lnOXJVeWsrbTRSc3d3eEgrSmUyTUU1SVBXSXJL?=
 =?utf-8?B?Z3FvKzF2WTdCL3BneWhHVmFaWk9GTGs3OUZGMWw4Y0pjaUdkeTNwZkFuQXFE?=
 =?utf-8?B?QUc1TzAwelpkU2c1bnV5OEQyU1Uxc2pGM3VUbitJVFNpNTJOYThmOTBsTjRS?=
 =?utf-8?B?MmlIQ1hubnFGdVU4eGh3YkNIc0o4MldPK3FpamtGdjdQcG5Oai9xVHQzSlpp?=
 =?utf-8?B?WTRkSTZzcUZBUTBJSGd0Vm9WLzB4K1RvR09iZHlXeEQwd3ZHcUZmS3ZRS2RC?=
 =?utf-8?B?NUhZY0dXN1plNUVzTmVkNlZqUnd5b0NoUERiQTRWOTlxVENHMDlrWGlvV25U?=
 =?utf-8?B?QWhIK0NEWXhPbWdNY3BPckhjdks5NHFKNGpzTTloUWZ5M0xXeHFEc3lsQ0pz?=
 =?utf-8?B?TE0xY0Y4Y0xwV1o1azdHZGZ1UmNWQ2gzbytYT1lHN1JDRE1FaHhVWk5MOTlS?=
 =?utf-8?B?TTVjcTd5N1dtNWtFOTZFdDBVMmdNQStZMXRoelVtU2xObnV4LzhJQ2xFS0Vp?=
 =?utf-8?B?OU9PaS9jQ08zWXNOYjRadTRNYmJaQ0tkRzRnRiszbnpFeFluQ0pGcDFvMVR0?=
 =?utf-8?B?czRQYTJDTldJU2lFUmRKRXZZczQ2bjFOWEVIR2J6L2lMTU5hTEwzZzBpZGtx?=
 =?utf-8?B?V3RpVTVsK2RzZTQ3RFdTbkpkMHVZTEdKWVpmL2JzenhzZ0tSS3FzNEhCMGNk?=
 =?utf-8?B?dlV1Z0VlZU1zcTBlbkRPWnV0cXlYekx1LzFMNStMU1duRC9iMWdUcm0ybDJF?=
 =?utf-8?B?aURtdmt4VzhBT1NlalRMQU5zM0lZOEN2d0tXWVh1b09KTEpOamJGcHpId2Zu?=
 =?utf-8?B?Q1lQc25LeTJIeklVVGlEazFCTFhMekRvNGFjS0daOWRXemhoYTUzcEtCMlAr?=
 =?utf-8?B?NmZlck1xSlBGTGNWNmJ5SHZJbW5KZ0pQMTEvSEdiTGFEdWMvdm94TUxxTncw?=
 =?utf-8?B?b1Y3V00vVXBnT0J1S3NNNmZYbzdWcVNSdmkweUJ1Q01VNCtiWXVHc0t0K1dP?=
 =?utf-8?B?eG5SSXp4dHlVUUIyMkFqUTNCM0pZYWxJVFl5TThtcnhEVkQ1NUVmQlU5WnIz?=
 =?utf-8?B?V3ptbjNVcmpZTjRhRXRJd2hrQlNyc1Q1YTMrOTRvZStab093Y3QrMmdwcGVm?=
 =?utf-8?B?emdERWV1MzIzNlhhOFRuRHZPV2Z2YlV6VzVKOC8vVUxoNUFDTElrZHlsWkpZ?=
 =?utf-8?B?aXBIYUtCbkR3ZW1PSVorRng5RDZDTk5rWFgwd3lGUUMzM1o0UXFVT0RPeDlm?=
 =?utf-8?B?S2VXb0lBNEk4RWNaeVJZRWZYelpKSzRvOFdpTlFIZUN6Q0thVkV4V1Zvblpl?=
 =?utf-8?B?TnpUT2l6bUJOVDZxQ0QyL0dIK1cxUm0xUTBmNDBvVGtSQUpycTI0Ym9DdTZQ?=
 =?utf-8?B?U0tCSkkxazIyZzZGc2hNRGl4bFk3ZWx6ZEh6b3Q2dTZOaFFzWWdOUlVmSVRr?=
 =?utf-8?B?SzgzbXo5UkVRQmY5b3JoaW5WU3BmSlFBVDlNbi9oWEZxL1pLNTZHeDhHTWlV?=
 =?utf-8?B?Y1AybFh1bkxPZDkwMDNRaUlsdjV5VURFdGlzOXQ5TjF2ajZhclVNOFQwdG1Y?=
 =?utf-8?B?NnZydXV6YW5NM1h4RjZFNUVYZWdVMG1oaFRlRW9yR3A4SmxVbUJkQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4153488-00a5-4e59-4b4b-08dee34e170a
X-MS-Exchange-CrossTenant-AuthSource: BL1PPF1B62FD55C.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:22:46.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkRztlmrLIFTRWgg9UOf7FSvAc/Kv39MVgzXA2hI/2EwDhtZh81p8f0awJjKi9lGphvKCXeOLxCzrVoMXjjDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF799512FA4

On 7/13/2026 2:08 PM, Babanpreet Singh wrote:
> Merge the two arms into a single else branch and fold their comments.
> No functional change. The redundant condition has been present since
> the driver was added in commit e75a6b00ad79 ("spi: axiado: Add driver
> for Axiado SPI DB controller").


Hi Babanpreet,

I tested this patch on the Axiado AX3000 platform with SPI NOR
read/write operations, and no regressions were observed.

Tested-by: Swark Yang <syang@axiado.com>

Thanks,
Swark
