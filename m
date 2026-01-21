Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7D43E9EE;
	Wed, 21 Jan 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983075; cv=fail; b=I2lVJvKMhJgbssYBZaN9XTzritrTGck6bYThW8SVX6ZfSnUa24VAVVykv1m+quoTuOVS1IX07ymShEdzYnCjEKcEcGvQRQua4n9dT9oiPa2oLWmzi2E0Ky30VmUuptf1cgrfPz5OKUQudJiU89iOtew3ewcK2v9BQW9SfjtJZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983075; c=relaxed/simple;
	bh=Tsli60Auke+40UU6B92uN6behgj1APQ70ruw3XZiFYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qs90FZpzLz5B4WKUKb2PvuBsBOXn7TdnOKc8Gae2D29SJ7TWYaakGLENWi4BH4ehWFwZjNELFHlMIoDK0fU8XmXi2mYL9z/w55lzviX14wB+/WmMj3763wA4wTw4urY/01X6VjVFhUemTavgrko7jp0JLmgoocuuN+BdErlVSEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=otEGt+3t; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="otEGt+3t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcxDqMQ/zLBvrkZCgk+XSSKj8NloR9d+N7rTOlyybClKdcNGCD0gWXk6ydOUIrQxnEK2y3xHfeJBtNGO6fOOqs5xHNpZZLxpWWRcW2BrcvEvOJmdJcNQfDywas7qvJ5RX8Q/rMBQ1oHYloCAIrrknMrkMD8yPRwLUYXAEucjSBsWFd2A8js2QyPymX0Za8aWR0w5cVOiX+PzTp1e4c4o6tgRpyhF314DeoEWKGe/hZNQnA5tUKto3SI0DCva6fbbVuirFbKsQYU7F1FUzwlv8jG6Lqv/5bCx0AyXkMoD6sPI8skNYj5G6LGCZ6hlFCiOFYSJbyVAoP8D6Q6fNGfxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZX3+6FZSfA2BD1JNfinDpUcQ0msLMnttfkAp0XCqWM=;
 b=GiMEDi1P6E3XvEUQn4ZDJa4hJU6/fdv2yXLvgsmlYDmAd7GM3daD37lPdJrFqypNfW/MGfg8PDe7eWaWLHy3mzMQaeCiPYBiPFho34Jk94oeIW+j4WiMGx0g1fCzWrPMyRYQz6eKi6CghEu79I+p4URLQo3CC7i8Pam4SQAGqQxbXmfypyjK3OLh5FrQ9mPMwr3jkMdMaTKPbOJYcDFfHV0UiZLLu16H2Y4Jmw5oXV7BWpOERq+GT0jhP2eXdiKpslXHiqSja9cvpAJzWDG/gaf0M0XdodM//H1N4mTkaclPDkSA2zMDC6mAAF+WozTospJNwWlUxPLkIkLkje644Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZX3+6FZSfA2BD1JNfinDpUcQ0msLMnttfkAp0XCqWM=;
 b=otEGt+3t843EQVaSMfhmeivuapWHRVNxwQp3UVSh9EC7aKZWXJt3exXSpRXnJwxVnoYqGdUzSLG3OTEa3CX8XQcipj8k5X2odVPk6FXgKp26sGK8ofG8cddgZExp8N5PGzGSHh62GQWswVxKOP+J8oJdhTJZfgy6rL6YfLxRGUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Wed, 21 Jan
 2026 08:11:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:11:09 +0000
Message-ID: <6ad4387f-08b7-40e2-a2eb-1346d8af6ea3@amd.com>
Date: Wed, 21 Jan 2026 09:11:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
 <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
 <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
 <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
 <817bcc43-7f10-4329-8924-6c375eb73ff2@sirena.org.uk>
 <aW_zjaRLtewa_NV1@smile.fi.intel.com> <aW_1zlEdaPNwiXuI@smile.fi.intel.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aW_1zlEdaPNwiXuI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f48413-a9d1-4ebf-61b4-08de58c4a23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnVURkw4OUVWZjg4b3lMZXJxSEFpWGFVejdyaEFMRmFCSURCcllWQ2RJM1Iw?=
 =?utf-8?B?MHJoaWNIOTZBUlZjVGpwbjBMVTFsMnJRWjc0RWdweU44bEhRWEI1aU5oOG9Q?=
 =?utf-8?B?QlVNRzhGbVphcU5la1p2QTRmSGg1eWMyYXMwWmVFTktPd0xnbFFEMFZDRUtO?=
 =?utf-8?B?YUUxSkh3dm81OWh4MnhKcmZVRHl1VEphblpqK1NlWHZqN0IzRVdtdUVPNzM4?=
 =?utf-8?B?dXlycmdaaGY4NHJhZkNlQjI3c29PYXl2S3hRSjdPMmNtMFErL1FlaFptTUFU?=
 =?utf-8?B?R0E1SHpMeFpsdFk0d3NCelJEalBjUlVlK2g4dUhBQ2FadmFpaUpkQktQb2lO?=
 =?utf-8?B?QVhzeWZjMkRlYnpZMkp4a2ZPT3lyZGR5eXlpd2kxU2I4d1FjTGZoZTBuTGJT?=
 =?utf-8?B?UEhxenpuMVhTdWpNTVhPcVg3Q2xOeXdJK0x5T3hEUHVBWTlHZno4cVk2aTNv?=
 =?utf-8?B?Q2lQR0dzM2wrZ21WWThUVnJMbTVFWHR4alNvZ3FIbUh5bFB0NmFBcGdJRnBF?=
 =?utf-8?B?K1FZdXA1N0QwakZtajBINVNZUU8xNncxMUswNzYxZ1haTGh4YXZCd1Myc2Jx?=
 =?utf-8?B?elZ5QlczRm5JN3RTRlVhSTFLeEJkcWpDM3hVa1Y2QlloNmlzSGRZeWp1SmpM?=
 =?utf-8?B?RzJTS0IyR0s3eXRtRWVsMTA0bGJ3elNvdkgwUEpjRHczbkZoNkw0NDFIbWlG?=
 =?utf-8?B?aFVsVXoxbU9FMG5NbGd0SklXS3VnMFlQRVdrS0ZpbzdSbEtlT1d4Z2ova2xW?=
 =?utf-8?B?OXRPQzNncHRWbTJ6aVhydEhrZGRYTFNJdjJYd0JPSkh1bFNkSGpSWE0zZnQx?=
 =?utf-8?B?TmtYQXRaaGt5QVBkbjV3TllXbGtrSGxycG9qUXRabFM2b3lBZk44QmJRNzR5?=
 =?utf-8?B?WUxibzZCVU9VSU1rQ0swSnh4RVNqU2h5TDJ0RkhhMnVuV3kvWW1rS1Q4dU5G?=
 =?utf-8?B?M3FtSUtXY1FWeWdCSXpEQW5ncm94N2hJYWt6WUZPZmJQSVliMWlZZkdNT3hj?=
 =?utf-8?B?ZTVoeTZWbjVFbW9QWVhzMjdzeVFCSDNCb0N3TkJVdnh6bTI5dWpsVG1MUVJ1?=
 =?utf-8?B?TXBQNFdLSWdwOTJZTGliOE8vSlRvRjF4YjlPSk9jSjNwNHJ4Lzh5SGdGZzJQ?=
 =?utf-8?B?VThJTXBaM0NpQ2dyem94YzlVL0tQdElPQmFTZk1PWHVxRHpPam1ROS9UQUZm?=
 =?utf-8?B?RzVnNHRoSW8raGJrRllaRVJ3TWlXa2xYY2dBSHoyZURXRW45NmFQNitmbVl0?=
 =?utf-8?B?YTVXbWhNMUp4Z1ZtNTRsckJhSWtySEZkRlJVc1d3NURhYkEwbU8zS25IMDhm?=
 =?utf-8?B?b05JMVRESS83dGZGUk9wK2RXVDJ2emhZZEJobEdFMVNGQytHeXNLUVRkQWVh?=
 =?utf-8?B?c2Vub3E1WEZROCtvczBOVVQyUFVXOVpERHNEUFNZREU0YlF6Zk1mSkJ6SVJm?=
 =?utf-8?B?RXdoT3d0Qjgrd0xDYnE2TkZNYnVURm1LY3llT3MyR0d1cUhRSTFhNk1keEVx?=
 =?utf-8?B?OUxoSko5Z0M5R3BhVkFLd1VrcVBrM0VBNDlKQ2ZKakNlMVovT2Y0NzIraXQx?=
 =?utf-8?B?SGM2ZEVzZDdGM2R3V1lYZEsyaktYZVhBQ2t1ejhTalBRSTIwVDVqbUgzOHBs?=
 =?utf-8?B?cTBvZTJFcUFlbUpZWkVLaXlZS3VqS2VBUHRjczlvU3VPVlFPZ2ZFaEg5M2dl?=
 =?utf-8?B?STFwajh3dm9qckpxMGYrOHUrK0RNT1N3bzhtZkZpQ2pzT1FJTEhxQmVJK3Ay?=
 =?utf-8?B?RWdKMTAvSXNDVWZKN3k5MERFUFFhWUYzaVFLRWhncWVYZUdUVXUxbFZKeE9w?=
 =?utf-8?B?U09uY2YwcHpqQ2FDN2NxRHdDUzJzMGdzVTZLNUxCYXBtaXp3ZzB5MzBZcndl?=
 =?utf-8?B?VFM5MTcyV3NuWXpneVJYZDRKaEYzUjNXUkxlOWFxakMveWcxcEw5dmxrNlZQ?=
 =?utf-8?B?anBwdEFMTEs5QU80M3BQSW93eFVHV3hNWmZLUWJVRjdpVHMzVjVraU8xdmdU?=
 =?utf-8?B?YnRKQ1RVSC9nM1BmY3BjQWJtUXViejZxTlNmOU9iNStIK3QrT1Y4cmROOEhU?=
 =?utf-8?B?TE9mbC82LzJWVHFEeE1Wc0ZOTjBkWUJMaHZWZ1h4eGFSakV4NTU0ZjA1c0tt?=
 =?utf-8?Q?dicbFW+XuOr/8TUzrrT68El2w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pxYmhkdjN5V1Q5eUlyRzd6L29HdnIxWDVtV29FS2ZKWjV3QnBCNHB3Y0E4?=
 =?utf-8?B?MFVidUNPL1J4TXJBQUhGbmFHb3pxNHYwMXZ3WVFiaDdaMGhKSmFVUTNzMVhy?=
 =?utf-8?B?cktnNkpzOUpiMFdaU1ZlQ0VpekR6bWNSNE9vMEdkc05FNmxySkF1dURpbUZn?=
 =?utf-8?B?N2V2ZktEcUcwbEFFbFNHeXlIcXRHUkozL2xOK2cwZU93Y0JFbjdkZ013REdD?=
 =?utf-8?B?NEhRZVZ0ZWFha3RlUk9zMDhkZXlrVjZ2aUhPV3Q3eHhyYXE5ZVpZcklpRDRr?=
 =?utf-8?B?bFpsQ05Bb1gyZ3RwUGc2Rk9XZnNDOU1DUjJkSGhYNng2WDI4MDQzZm1wclZl?=
 =?utf-8?B?VUVvTmpmejZ4aEUwMDdIbWc4bEk4RzdTR3o2eHV2Wk9mSUo2K0NMcDB6Mkh1?=
 =?utf-8?B?Yy9lSC8zenFXUVNoTUwxeXVJMzRza1o5RlI4bHZzS1VtT1duNVI0aDBtMXRV?=
 =?utf-8?B?THBYZjBvNEo2K2V2cUVDZTdKK1FhRThOSjFOeTVhaEN0bmx3UVdmV3hWYlNQ?=
 =?utf-8?B?WFl0M3BSZEhRMTRTNGVpZGpVL0Jub3lzOThoVHI2QUQ4YnFuOEJZREo1STBO?=
 =?utf-8?B?Vkh1VTJXL05WMUhWVkxPN0R3UGJBaWtrYUM0QVVlQ3Zlcm5wSkZNaVRsYXN1?=
 =?utf-8?B?MlVPcHVLNUtBaTY5SEdsbUx2S3ZwOCtEeCsrZnFwMytpL3lVL2tMWHZ5OTFI?=
 =?utf-8?B?emNnSTUzc0R0SXdhVHJhdy95YzRVRVUyMHEyN0ZRcXhoNGRFZDRJcitadDQ3?=
 =?utf-8?B?V1l1ZTk4Z0lzL2lBdFdzMmQ5WU9BL01SRzl4OStzZVlUY1FsWGk3Zm5ENjVm?=
 =?utf-8?B?L2xISDRaNE1rYStNQUZDZmRDWGhRTEM5YlZNZUVuY2cwS1pnNHRzUkJscXFN?=
 =?utf-8?B?ZDl1N3VCRVRya1Q2REJSdlRCQlpOZ3J6TTZIY3dVa21UOUlyWENOZGVhOVJY?=
 =?utf-8?B?ZllLdThYaXpjazJPRG5Na3B6d2pkRlFiSVVNcjNPOXhLWm14TXJYTFVTRnQv?=
 =?utf-8?B?Nm5mN3FXVmQ3NmVUcVFRRi8wQ1hTMUF0OUFoYm9CaGl0R21XUXFpUm94ZVBP?=
 =?utf-8?B?YUxBVHNjUG5WeDFZV2RtaVVZQ005bko2L2JZVTdTVW9xRXI1TVhYR0FiVTdG?=
 =?utf-8?B?T1dFWDMySjRzbSs2V0p4TjBpMU5vZ1NRR3hBeUpGSElMVFJ3VDJFbXVtR0o1?=
 =?utf-8?B?SUhCU2MvRE90a3MyRkN4WnpHRjNkWlRYU0VCOVYrYXhWdGhITDFhbGdyL0VW?=
 =?utf-8?B?ZFR4WEdrTGpwUnZmdSszLzJvc1I0VkRSeGxaejdzNUNlbDFiYXcwblQ4YUc1?=
 =?utf-8?B?dDJVdC8xQUFCUXlsNVNEd2dmSUxzTGRvblg5SWx3RUtkWUhRZ21wT2ZuUDVK?=
 =?utf-8?B?K2xKTXU5K2RDOWt2RkM2TnlsbmVJZjQ4TUdkUVlpVlgrMFVIQnljVFlpN0VH?=
 =?utf-8?B?Qm5YVnpibUVScFY3MzB3V1M1NG1SOGlybEh6WWxxUENPemRwbDNCUjZvOFE3?=
 =?utf-8?B?K212UUF4cjNPdVFHK1p3bXN3akh6SktLNkU0cWpvN0pFTmQrTGM3cWJScVE0?=
 =?utf-8?B?NklOazI1QmJMK3lIUk51S2V4UnYrWjluRlNOSjZlRjRLSXpaSU00Y3FvRUNO?=
 =?utf-8?B?UWwyL0pYQ2JCWWlROGZtRUtzY0I4d1JRQkJSaGNRbE1aYUxFOWVoUU1TU0hj?=
 =?utf-8?B?VndwVVRSUUsxWVpxMW5kY1ptYU5JTTlCRlppTHE3WSttcDdEMUtQeW5EVEJz?=
 =?utf-8?B?dERITkpCdTA4YjlPNXhrSnpuV081cXNrYjFhM3RDYWdPeDg0ZUl3eU5rM1FO?=
 =?utf-8?B?Y056UkxPVS8ydUo5UjNZcUVmNzlJWWtQanY0MzZoS01ZQmlLQVRMU1d2N0xO?=
 =?utf-8?B?Zm9RNllJUmIwSHU5SW5UUE9kU2VIZHpvS2J6VkhWTGNua1NmRkU2ODNkL0JJ?=
 =?utf-8?B?ZVRGRkZhWVQzeGkyaVBySVFscU9xZHV1Sy8zVXNwQTFkaU9yUHdjNGRlSUsr?=
 =?utf-8?B?UDJPTnNkOVZxRmo3THF4cDErRFowN242ZFVTTWEzTURJNmg3SVlDZzllaGFi?=
 =?utf-8?B?TjBBQS9LN2dwQ1FXZFFjMHRTZHlOM0VGczBhOVNtNmgrT1d5dHBVRTdnMllX?=
 =?utf-8?B?WXB1YUFQd1hTaFhZZmhTZzIxTWEyS0JJUnE3ZGgzdWlnQTZKcW5McU5jbkF4?=
 =?utf-8?B?YWwrTjdSaE5pRFpkemhOVVNhNFpsNHY3dUNEYnNVbmJxS252VVRiWStDWk9J?=
 =?utf-8?B?eHY2VDFjakdrSkZvVU45Rloxb25ab0hzK3NWdDB0SGZHQ2ppYlkrS1VVVHha?=
 =?utf-8?B?LzFXRXFzV1k1c01TNm5ML2Erak4zK1VtaGFzczJwcFBqTlVJelJ5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f48413-a9d1-4ebf-61b4-08de58c4a23e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 08:11:09.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXDIp0ScXoLh0J9HC9k07mw0AJEyNwfUTh/XNOdD5fhVZx9j3NrAnSdqYjGgN6Oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496



On 1/20/26 22:38, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 11:28:50PM +0200, Andy Shevchenko wrote:
>> On Tue, Jan 20, 2026 at 09:04:58PM +0000, Mark Brown wrote:
>>> On Tue, Jan 20, 2026 at 11:11:44AM -0800, Abdurrahman Hussain wrote:
>>>>> On Jan 20, 2026, at 10:45 AM, Mark Brown <broonie@kernel.org> wrote:
>>>>> On Mon, Jan 19, 2026 at 04:20:06PM -0800, Abdurrahman Hussain wrote:
>>>
>>> Let me once more renew my plea:
>>>
>>>>> To repeat once again:
>>>
>>>>> | Please fix your mail client to word wrap within paragraphs at something
>>>>> | substantially less than 80 columns.  Doing this makes your messages much
>>>>> | easier to read and reply to.
>>>
>>>>> To drivers that are used on ACPI systems, yes.  Many devices wouldn't be
>>>>> used on ACPI systems, or would be expected to be exposed differently
>>>>> (for example, hidden behind AML).
>>>
>>>> This is not for a normal off the shelf server. In our case we are building an embedded
>>>> switch with an AMD CPU and Xilinx FPGAs that happens to use EDK2 based BIOS and ACPI.
>>>
>>> Sure, AFAICT it's mostly a PCI card with a bunch of stuff on it from a
>>> software point of view.
>>>
>>>>>> I am just trying to get this 2-line small change merged so we can start using the standard spi-xilinx driver today. I am not trying to boil the ocean.
>>>
>>>>> I mean, adding a HID wouldn't take substantially more code.
>>>
>>>> We could, but we don’t own the Xilinx IP blocks. Are we not justified in using PRP0001
>>>> hack until the driver owner adds the HIDs? Wasn’t PRP0001 created as an escape hatch for
>>>> these kind of scenarios?
>>>
>>> No, it's more there for the cases where embedded ACPI systems need to
>>> import non-trivial DT bindings so they can avoid having to respecify
>>> things that ACPI really doesn't cope with or for local hacks.  See
>>> Andy's reply earlier in the thread:
>>>
>>>     https://lore.kernel.org/r/aW9JihlsjnJ-uBul@black.igk.intel.com
>>>
>>> AFAICT for ACPI the HID assigment is a bit of a free for all in practice
>>> - board vendors generally seem perfectly happy to just pick something if
>>> the silicon vendor didn't do something.  Just look at all the parts with
>>> INTxxxx IDs!  That said Michal is on the thread so hopefully that's not
>>
>> INTxxxx was a (historical) mistake, but look at the correct one INTCxxxx
>> which has listed several components Intel doesn't own. Because ACPI HID
>> it's not only about the component in use, it's also about integration of
>> that component in the platform environment. Hence it might require (platform)
>> specific quirks.
> 
> Btw, you can look at the MIPI I3C HCI case. MIPI as an owner allocated generic
> ID (which is usually represented as _CID in ACPI), AMD allocated their own one
> _HID (compatible with _CID) exactly for the purpose of having platform quirks.
> 
> TL;DR: if you are 100% sure you have no HW integration issues, requirements, etc
> and everything works as is, you can use Xilinx allocated id (assuming it will come)
> for the given IP and use it directly as _HID, otherwise use that as _CID and
> allocate your own for _HID.

I got in touch with respective AMD team about ACPI ID allocation. I also don't 
think it is going to be a problem to get unique one. And I expect device 
properties should pretty much match DT property names to be able to use the same 
device_property_read* helper function to read them. Andy: Correct?

I am still trying to wrap my head around all these possible solutions for this 
problem or if we can solve it in a more generic way.

I can't see any problem with patches which are switching from of_property_read* 
to device_property_read. If driver also works without IRQ I think it is fine to 
make irq optional (which is 2/3 patch in this series).
The patch 1/3 is the same as mine I sent in past
https://lore.kernel.org/all/a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com/
and it was rejected by Rob.


Andrew: thanks for sharing link to pcie driver with DT which is one solution 
which requires writing one PCIe driver and that's pretty much it.
Obviously enable DT on x86 but that's not a problem for product based on 
embedded x86. But it can be a problem for standard distributions.

Then this ACPI way where it is not clear to me yet how to get information about 
clocks. The i2c Abdurrahman's patch is making clk optional
https://lore.kernel.org/r/20260115002846.25389-1-abdurrahman@nexthop.ai
But input_clk is used in reinit code that's why maybe it is working for the 
first time but in case of error not sure if driver really works properly.
On PCIe clock for spi/i2c is likely only one and ACPI device property can be 
created to pass that information and call devm_clk_get_enabled() only in DT case.

And then you have DFL (drivers/fpga/dfl*) and aux bus 
(drivers/misc/keba/cp500.c) which pretty much targets similar setup.

Thanks,
Michal

