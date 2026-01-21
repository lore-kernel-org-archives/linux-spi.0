Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ED533F364;
	Wed, 21 Jan 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998374; cv=fail; b=UkzhQHpiQkLEF85bIV35dD1xzn85H0wpshj+m/pEDB1O7rZ24tvaz+U8jVzK2cdOCYEt6XASyKUQU9Be/sMa6wowT1iLbEVz09u0GsBM808H/H7bY1S+BWg7GtiRIZywfJHe3Epes7w8TMMiM+dgIx68CA+WH9CGnz84g5z92SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998374; c=relaxed/simple;
	bh=MjIHCcjLuduGtLmoqFAFLX0AAij81SUVQL7l5L7FlBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUkHdgMS9PgI3KkMCXudBkDY66S/Sx66m9kDTokWE6+mUUAL3U8EoERtx9EOU3tDFdLjCiXUUrTNKAcnbisf499eegW8/0QaJNUyuUw3krC0kYY+JG8xyzW4g3ckhk+bmNHLdN1W0tqRI2fI8h0/n2u4nhvgI5xwFHsUyVIdhcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3BpMYzR0; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3BpMYzR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcfU6/FXDLwVzYCvuvyEJ+vSrJFuh4x4WWRgvQQ59PlMFDBiojFBS0VCYuh/LMpGbdcgDfQN+3azT/NcHhEHLF9n3JVnZEcLGanyOovOdlA/AAu6XltqbbYZpLzebz4OMy9xPPKphGZQqraaXKc781GAs6uaqwE6Bkxc/M1lFe+T8571R+tWgC8lVVqq3qvSlsU68cKMCTRzkCRGH35l4Jwl8tOTuK/mXpK2pD7lKufs5gLlvBwZhpCgh76vwAIpdfX2/8zcZVxNlL98TxZveflN2v0OJoTdnbs5+2AbH+06GxLx86fKglLFZRjQ0x1Gboz55KHoymPmax2yuevGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73Sb17XZ9h0QhRRgEIT1g0isG6bgF8qXOzmlbG7IYBM=;
 b=F6yPoTxzOA5uQF5YeqRAex4v56XL5Psy1KlH0udaqGYB/fnn1YcGil1tWlPGx3mvk3xN48rcKd9iqbY2X2XUhTWYujRkPKUaItotylPMC42aYgFJ0A1Lk9x+hXf20qbwB4xJkmOU/zQyWK7xwK5ChbRWwggmJyn1dkPSvUNghGmJN9pF77LSe67XycgHUPEDs0qJ+Gakl8L2wXMuNmZdRoUPzmMgpRoBB40kbdebE76JkYD8lTPsMpnLSXfaaesh4hHqDpcHoYCPtvlPXBjwB8CDePXsOp5w1j1NBQ1mqTJiO7wcfxX2AJiJLMxYw9lZ78nxCKXQ1PtzFEEHgNl3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73Sb17XZ9h0QhRRgEIT1g0isG6bgF8qXOzmlbG7IYBM=;
 b=3BpMYzR0rxVRo0UY8j/4kNfE+vXS7JaA1c/tIYvEWYWjI0C20M7EMZHNIq0gpPyk0Pl7j3YSbv1voij/Gpk4h7IgccZeDap/tBKp3NN9LUXeqC1zOxk+wx8pcypftfsAcRW7maVEWk+YOVPVeNE7MKsJ4uRXBbecxvMD4R8i8x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:26:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:26:08 +0000
Message-ID: <8270c11f-7244-478e-b341-2ae7f6e1e416@amd.com>
Date: Wed, 21 Jan 2026 13:26:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/3] spi: xilinx: switch to device properties
 and make IRQs optional
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Abdurrahman Hussain <abdurrahman@nexthop.ai>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <176893698361.778248.6867023245726406177.b4-ty@kernel.org>
 <c0288962-6a11-4274-9e93-91bd5a6997c5@amd.com>
 <83b93899-8f48-47cb-a74a-b4e838cc463b@sirena.org.uk>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <83b93899-8f48-47cb-a74a-b4e838cc463b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9387c790-a83f-4d52-97ad-08de58e8413d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGV4UzdSL3VGeDY1djcrU2dlVWFDcXBZUXlpa0FNNWdUWENYSFdPa05QQVFP?=
 =?utf-8?B?UEI3UjF3ekZpZTRGV2w1Z0VsTjRkZGdjZm5hZXAxbkpIYzM1UXZlYTRGaHMw?=
 =?utf-8?B?bE5FbVkxREYvYTFHQW0zc3dYU1lFMGNBRkJsbVJEZnNXcytVVlRKT3BDV042?=
 =?utf-8?B?b3JseEh5cGp4T3VBQ3Y4WVhadTlPcHFLWDFoUGllenpBSy9QYWxBWnhHVzl3?=
 =?utf-8?B?MVhNR2VPV3BvOGpJSit2WnJxVHNNNnNuMkJmdUJZK1dmTitUNzM2RENQQlpO?=
 =?utf-8?B?dzB5TmJ6MVh1dE5NS2wzWEJ0MXgwL1V1ZGtDV28zSG9PSVRQelpHS0xNZktY?=
 =?utf-8?B?U25jMGszQk9iZitiYUdlY1RtZy8rb29UbkpjTysyai90dU9Da3VHbWh6Smtr?=
 =?utf-8?B?MjcyVFB3bDU3My83RXpsa1Nsc2kyZThFNlQyMnNzWFhqZjB6akpGOGtCT0l5?=
 =?utf-8?B?MmVrWFU3V0lpSDExL0ZKQ25UYUdLNGVWQWJzTFpiczRpcDZXUCtQOXNzanB1?=
 =?utf-8?B?L2lsSTNIeEF1R3dHcjJnZDZEOTAvTE9WWklaM0IvNUVzbkh3eHdZSmhraUdF?=
 =?utf-8?B?a0tPL0dReUY4eVFudFRUZklqRkN1SVcwaGYra1psMlVXMGdKUjBwaVVQYUlV?=
 =?utf-8?B?Z255UVJVaWhpWDNvSFRZekRaYkRNa3hKck1pWjA2VFBnM3VnQzFFSllJdVI2?=
 =?utf-8?B?V1lZNFNHWVZ2QUJidU01d3ZUUERYM1RnbHVnREIxbkphRnJhdmlGMGxqOS9F?=
 =?utf-8?B?T3JWQUtpMkNpc3k3R3hDdVdiZDZLMVB6Z0xtVm1jdjltMU9CWVJVc1dpYjlD?=
 =?utf-8?B?TGhOcnRaaGRKQjNuS2lGZDNJMFNaN3VFaUZkeDdMdzFiejZCYXhGT2E5NE5x?=
 =?utf-8?B?bEJIMEZvM0t1UGRXRW9JTVMvV0h5Ty85YTNmWHJ1WDJTUlExR2Jtb1ZUTTdF?=
 =?utf-8?B?bU9sOEZUL1U1c0hTV2JiZEIwQVZnM2F5TSswMmVvVEMxQVVRSy9IajVWNERm?=
 =?utf-8?B?dCtrYzV2K1J6eXljcXBIaHFORFF0UzZBOTFGOVJzazgvWE1Day9EVjBoSndG?=
 =?utf-8?B?NUM2cWR0S1VBc3lZQ3oxWWdpaTl5b20xbnZnY2dHWFJjQmUvRC8yYW5SSXVE?=
 =?utf-8?B?S05SbXM1aUZrQzBWZ3ZER0IycS9aZ1J2TllibEU1Yk56c2tRdm5FcFZJWXFO?=
 =?utf-8?B?VisrelVzbVMrYlB3akd2N29RREczMjU1dVpQeWEvVjNlOUtaU3lBY0N5N3ZX?=
 =?utf-8?B?ejJxR3hRaStMSTJaUGJUSEtQQjBDYzZWUERFakN2L3Q0R054QkpYdXEzUm9C?=
 =?utf-8?B?U0Q3MlFyMGhrbmVDVGUvY1FOdTk2Vk1za0hEbXd4MGRjR29Ec2paeTFXMjQ5?=
 =?utf-8?B?Qy9ZTkRBbHNKQmZidXMzQ08vUk9uSVMxTXNvVHYyV0cwN2U2K2ErUTZKWVpI?=
 =?utf-8?B?VDhBTlUrcHFBcmJNMVpGaW9lVlNTVTNSeG5UM1hsblpzN0xkZnRXaUwweVFR?=
 =?utf-8?B?YWgvTTJqakYyNHJVckpPSVk3bTNDakdibkdsYWNDNkpmUSs5dTJUekFDZW84?=
 =?utf-8?B?bmFTS25ZOW1SN1owMnVSSU1qbWgrUzJJTHF6NUF4aXRCLzZtVkRxSWVkV25p?=
 =?utf-8?B?ZklEbzkvNVd0ZGtrdHZmcnJRL1g5YTBEYkJHb2ZwRFdKdHJ1M2xZc1dkWmdF?=
 =?utf-8?B?NFBWTEVIQVBsQWRHRmc1djhYdzhaODFnRk5Nb0dXUU9QbkZGY3YraGtRdmh6?=
 =?utf-8?B?MGFrMFFBaGNTa3VETmZEUEQ4Z3ZyN2hIWDNyRzYzakN2aW1zSVNJWStZYk9z?=
 =?utf-8?B?ckJuNVBCMktJT0g4Z2YwdHIyeHJubm1jUTVsa25tS2NUT3AyclVVdXllWTlv?=
 =?utf-8?B?elpaMHpoRG1NejVIVzZDOVJuT2hCUllRY3RjVXlhK0tHdU44aWorYTliZlB3?=
 =?utf-8?B?amppRVpjQjNIRGxyR09QVS91ekNIMmgvL2JxUDRrdTBhUU9YZG14cFFHZDF6?=
 =?utf-8?B?UVBpeUhESG9KUHlDQ2pjZTUrTGhXZ1U3SG10ak5laDRWRDJBOHdabi9CYXdG?=
 =?utf-8?B?eXA4ZWRKc01zL1dQeUw1eStVL2JoOE45eEkwOG04ak96RlZsU1ByaEl4RWNx?=
 =?utf-8?Q?PaL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDRGWnZaK2xqSW9wZWJqY0ZWQU0yWFpyM09pQnk0S3p2Uk10NlZCR0lkWVIr?=
 =?utf-8?B?ZzhJL284MzlEKzFHVDhKOEc1ZUwxbEtHM1lobG9xU0xEc0R6ekVyc21QdllV?=
 =?utf-8?B?SHJyUmhnL2RqUjMyYmxOQ0pndmNSR1BkNWtralBPMGJ1UWZKLzA0cjhmT2cx?=
 =?utf-8?B?anM2aVM0L2xaTlhwODNJZnNDZE5jdGtzYmNWZnd2Rk8rK1BDdXdCSmsrM2Fl?=
 =?utf-8?B?NjRHZVpTNU9hd3dDVFN2Y2xxUmE2YmVmR0cyMi9RakNsaEY3UG84NmpwTkJp?=
 =?utf-8?B?VEIrdXhEVEgwaXJDYWlKWGhOc2hsL0JXQkNwQnlBRlZRR0h1M0hESlRJUGl0?=
 =?utf-8?B?aUt2WkJBUk5ZRzFXQm1XTTc5Yy9kZVNEcG9uWXk4UCtKUTFaNVl3WHhUZTA4?=
 =?utf-8?B?cmp2bzRmQUlEOHJNc3VFcWg5VWsxV2FPSTlBZmZac24wZ2svUDRxMnBhbjRZ?=
 =?utf-8?B?OFRUQWUvTS94VlNOdCtnZldrV1FxS3JDMUdoUVBaM1pFOVVlenQ0WU81ZWM0?=
 =?utf-8?B?RnFOQ2hwSk1NVWJhNjRMcjhRcGJMcUsxZEswWStSdUZDNDdQRkhBUCt6V2hs?=
 =?utf-8?B?bFVPbjI1QWFvSTAvT1FDc1J5cXYzWUFHODlhR0o2UGIyTWlUVzJrSnVRK1ZB?=
 =?utf-8?B?TEZWODBsc2ZrWWtxM2NYakR5ajgvOFltN3VBeGQrWXlNTEtQMTYxaC9ESnpl?=
 =?utf-8?B?d1ZCVDd1ditRVGhhM0V6aVppa2hlUlV4NlhoVGxaaVh2Z2N0U1E5cHMyTzlh?=
 =?utf-8?B?ZjAxdW5heDM0WFVIdTNZd05yTElpbW10eVdwMngxVm5hMXdLMlVxYUVSU0tI?=
 =?utf-8?B?NXpxRzg4ekh6RUJ1RWlDc1RhblJRV0pUMFBrT01kRzlodkFwcWRVNitjRjdn?=
 =?utf-8?B?ZEY5S3dtQXZVaURlZ3pFMlRoaWRJTGJxTnNvcERNb05TRXd4dnJaV2l4SDRU?=
 =?utf-8?B?bTVEOUZWWm9sdUJ3TXBrY3NvRmV4ZFUyNHBObmdzVUlwY2FXS2g0dmxMdE1K?=
 =?utf-8?B?Q3hOYmNPRTJvOXNUKzBjN2lPWjhDdEg2OXJrM2Y2REFwMThJYUNjbHZybVhG?=
 =?utf-8?B?K2tyVTRGV2ZiTUYvR1hDaHhkNkh4VHhabkllM2lKSGNLVW1iSkdmdHFRQnBX?=
 =?utf-8?B?cXpiVGJDSGZiQm1KdEp4SlQySDZWb00wRXc2VWJJdXRCM1o5a2dZSGgwWng5?=
 =?utf-8?B?UElLa2Q3bWdEMGs0TjdpVFovRzRqNDRvek1XRXZOQmhZcm1neWwrNUFjTDFU?=
 =?utf-8?B?b1RFdjhYVitZSTFzKzBnUUhEOGpOMityU3hyNTNMSUpUVDl5WWZiMlg5K2p0?=
 =?utf-8?B?aDFUL0hMRWhKWXNmSjY3UVc2S2NyYjQxZ0ZlMldBWCswYS9SSWJPVERjWStH?=
 =?utf-8?B?VUxtMmJzYzZxUVVJMGVsc3J0S3ZWOWFKS3FBUVdjRW4zK3RMNkQ0Z0NIa1c2?=
 =?utf-8?B?ZTJNOE5VdTdodTVmL1RCTko3TEVqZDYzMUpjVGRMUE9FbENUQURERzIweEpL?=
 =?utf-8?B?TTlaNDBpWkoxdVYrYTdtUjFlaVpxSkVsR3JsY0J5Q3NjWFlxRmFmS2oyUDZS?=
 =?utf-8?B?Q2p1bTR3VmthOU1qR0tjcnkraVMwRS9tOWxlVmo2d2N1dEcybW1IVUpTalpu?=
 =?utf-8?B?cjRja2o4T3dhYzRKK0Y4VXo3NG5FNTJRTmFxRFZ0TlVwZ1VZM0lDRElsZzQ3?=
 =?utf-8?B?ZUlhUk1aaWJMTUNIeDV2Q2pteCs1OW13YmJ5Q2ZydXBwRVBqRGRXMXdCY3Jk?=
 =?utf-8?B?WGpseGhlUHhsU0tjZ1ljYUdDYUIwOFFFK3ZKbTVhOHF5WktFSlg4ZlF3cmNa?=
 =?utf-8?B?ODRzMGI4Z245MVUvc1NpS0UrN3UyM1d4YkE2WTNHQ0VSSnliYzNqMDdkZjJq?=
 =?utf-8?B?aWZSbk1sejdmcDNVQ1lvLzYxZWpKcjh1WlkwWTlKRUR6QVo4V0lMVnJkOUVQ?=
 =?utf-8?B?SjBVcDV5RktZaHh2VVNycUdBU2E4V3VIbTlOVXdKSjE0N283bVdHNFA4M0h6?=
 =?utf-8?B?YjhlWTh6d1p1L255Z0VQQThoTDcreXVlUWtqZXpaZWtMeVUzSGUxTzBGNmha?=
 =?utf-8?B?UmhDdVdiM2l0cndYUW1lWEIyUVNjYjdSQm9mRDhPeW9wbTZjbmdLOUJPNkdN?=
 =?utf-8?B?WjZ0S2pmdCsrU2Fqcm9rcFNlaG1TYWlxVmVkeUNiK3QxeEMxS3JhOFQ1bzFM?=
 =?utf-8?B?Q0dHMXA5aktGc00yaXVRdks4TG5la216MjBjdnI2SjQwR0NFY0dORjI3a1hI?=
 =?utf-8?B?ZlBWZVQ2Vi9pdlRSRTg4TThVM05ENHJ4dkFJcmk1S1RUTUFwa2JlcFFYQmlx?=
 =?utf-8?B?RzJiR29HbFI4SjJPcHNXVURXd28rWEhyY2QrWUZ1bTBsY05PY0kyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9387c790-a83f-4d52-97ad-08de58e8413d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:26:08.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F08ujfHzcR0nY3776Veg7mLH+efVr1szK/0TvzvM9TP+GCD27+wffTiGPvp09dKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694



On 1/21/26 12:39, Mark Brown wrote:
> On Wed, Jan 21, 2026 at 09:15:02AM +0100, Michal Simek wrote:
>> On 1/20/26 20:23, Mark Brown wrote:
> 
>>> [1/3] spi: dt-bindings: xilinx: make interrupts optional
>>>         commit: b603500de20fbe15ee54580481c1df4212a4ec44
> 
>> Are you sure about this one based on my discussion with Rob in past?
>> https://lore.kernel.org/all/20250605130331.GA2370690-robh@kernel.org/
> 
>> I don't really mind but would be good to do it in a consistent way.
> 
> My understanding was that the hardware doesn't require physically wiring
> up the interrupt signal and can work in a polling only mode.  That's not
> unknown for SPI controllers.  If the interrupt is actually a strong
> requirement for the hardware (and especially if it is actually wired up
> on this system) then we should drop these patches.

Keep in mind one thing. This is soft IP in fpga. If you connect in design IRQ 
you will have it. If you don't connect it, you don't have it.
 From HW perspective both of them are valid options.

It is up to everybody to decide if make sense to have IRQ logic or not.

This is the same for all soft IP cores which Xilinx is having.

 From SW perspective one OS can decide to use IRQ, another one not.

Then the question is if DT binding in Linux are targeting HW capability and 
configurations or describing Linux driver. I was said multiple times that it 
should describe HW not actually what Linux driver implements.

Thanks,
Michal
