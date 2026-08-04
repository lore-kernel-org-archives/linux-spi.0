Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137593F44E2;
	Tue,  4 Aug 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870896; cv=fail; b=sApzGUKyyZhII+Jpo+Eln41I+UcGGRSRP9Qu73a12D9wBO/PVlcsrCtORu7kgadqAqTlT7XNcRSg4mwQkN9JuU53R0j1cwSmudsfw41CxMU6Cxv3n9ROcd4hm6yzrfy4Be7Dx+qAtQ4tOEBNcsyIQp0fYwHQEdHZYApltvCS0WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870896; c=relaxed/simple;
	bh=W2v18i0MEWmJHDIHs5w6AgQYpdPGjxRo3QFat5HQUUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBQqPA+sVgoA/vdcVFZ1Dqa8rqBCfofvcMhKObmo0Z4GxEvHJL1a76QsWZFr/JIjeaiV7rcQhXNz86mIfLxhuowgYzReCub1rRsbES7RiHqO4gbWLzms1SRvAXE/F1r0YFXLv3Rq80H2FJoOO4RJaZ2mib9oTRpxnakJKWbqxgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=STdfDB9X; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="STdfDB9X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHcUE6TUIj80URS/ympiz/iEfbLb8+eiuGcbqrnw0g9SjGC3g/u1YkzLYjNVvgT2eTFp5HLUWKTJpOdxXOkZ9nBc8eA2xp8cQmeCT1KWuPI6NUmgU6BlNaZ3hBH0ZwjV/PMZW3XvLuFsl+HiP3pCe4qIz3TNeLY5bOoSgU1fMqj7VPLJ305ZWgMPMJzuGW6zUNIAdoJA+qoR3D9y6b+TwLKnV+IMOOGHUt2lKrg4yucH7KkNEvLKHBANFB2E11pwWOUqTL3357CGvQ9PhIOT8tmOlOZ/2ARd9fghLCG3NVZAdAT9jdYmknQQbSTYLJxcyGOuGWpI7e6nd2nJeGtkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNG/qHHNXBybqCDJOOLyLMXa/bDr7j4IDU/VxU6Tnao=;
 b=f5kxRylhEmxeHbXiwVPQGs0jSLAKSMxiXVxBMwqQmYutAlvQ92kpVoNJx1K0scmPs5GuYi3xVzldIcmAdOmNXWDyykTQzCuhUwwKQxo/pQKZU6veLSp8VaYR2aS38ArBI8pLIlH16gxTU4WgVHz6Q+c87w6nHWqUa1gpn0jBUhAL23a8Pj1lYFbRGXt5cpSQp6Hac3gv6Ln/gNsdGUI3tMbNYlmWKjc0+9xuLjKGEsn/wf5byTS8SrlxreAMKpgsN89WNPbM5yy/LAb/RNp1NK94EJbJTAnljp4iHVNIYRy0vH9P3/CPNhXfPSr42WVZHs9NisHfTfExUNY7nil3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNG/qHHNXBybqCDJOOLyLMXa/bDr7j4IDU/VxU6Tnao=;
 b=STdfDB9XXUa8ROJyU0HPDjM8hfhb1darSQG2rsX4lrJJ1bGK7o/5qu1Q/MmPZC+1ZnKv/Yzz/lsQMazmtMLOiIQ7csL4CJBZRUxKWBU2MqHWSN+WAX6RtheMr14qmmdHvdsnP/XLGDQntZfe8lv7DFD9186FcRBiW3Tn18kKWhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 19:14:49 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 19:14:48 +0000
Message-ID: <4c9230c1-b92d-4824-8f96-f6c6a4114e62@amd.com>
Date: Wed, 5 Aug 2026 00:44:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] Documentation: espi: add subsystem overview and
 MAINTAINERS entry
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <20260804115259.4065638-4-krishnamoorthi.m@amd.com>
 <cba4de8f-0c4c-4c53-82c4-f6972cb4f4d6@infradead.org>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <cba4de8f-0c4c-4c53-82c4-f6972cb4f4d6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0036.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::7) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c53ffd0-7af9-4787-5386-08def25ca6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	n1zZ2xYxmSczmz9kg70OTRNVwERTxe5RA7n3NGBowUIJ/ehHYTKIKWB4DrzgYxixKNhzOUnqGk5dRBLe5Ru44+LzMWkIrakSL9pFaIfTPV1Lg+m3Gq02BExDD0+Jszk2J3USJKGahW4Uc7aJ73rntVvB3WeMKFOZJ8bNXvJbq8rBhhf3UyhI7RTggJrbT6UqLu5dEQK9DKxLUK9uQvtK1sCOpxgIpuSy9ebavxSn1p5Z4qM0cgwF6urgJ22w9xftsALLasuHSts7k+2WiyJWibZTI3J974OEEm5FE9DjY/GBq7Nhq9epzQ/00rSxYQze8rxN81vOCyWhweL0HAwzjTaOEQ4Qu0JBujUOM/Rg5jtHo1jNwVh+sSJBqoV2Q96rRUNzhdJ4Ee2fs60s9ibun1C2ysaOfmxVO74giFLU1id7u4RFuos58EPc8YJ2rX/i9L0gxI5NJWzrDx5U3LX10hBh/PExtJaS9LAyw1JhLdr0BVKg+skTmKicyDvxlWf/SA/9sXaxWDJ/Gna5eDJbFf62Lugocn19+1+LM4HiVM2WTgjn2c38UBrKSSKamKqqiJ5oeSg5zEQrq4NxUgJvHByrgvX7Hze+4xD24TX4eR4m+gwZgEJ3WZaWZZExzYuAw1I6YQf8G06ux0b8J1ExM3hfqyo+mIT4v4PihGrfUbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU8vdVJMRUNxRTZncEZnTy9MSC91WW1tT25SZkJZa3NPRFpYQW55T01lVHAx?=
 =?utf-8?B?UXhETjhlT2xENjFldmhJOWd3YWwyU2ZuaVhsMGVwZTRuTExSbEFFQ2xHdGhr?=
 =?utf-8?B?ZzU4SnpaMVFyUmswL2hXYTJWakF2ak13cGc2WGdOelpQbDhlOXFIN1VEYzdS?=
 =?utf-8?B?eUZPWllPa05Ka2Y0S05oajNQK0lDY2VsUkZGNU5qN2M5WXBSenhvblE4TGd1?=
 =?utf-8?B?RXZXRUNtbEFTS1VsSkRFdlM5bVhocXdwZ3NrUXRyTmJ3WlFkK0cwV095a1Y1?=
 =?utf-8?B?QTJRNjl2ZFh3REgvT2VSaUpObkdqaUhQaTRZWDFBN0ExRU90SXFsSmlEL2dS?=
 =?utf-8?B?Y0NVL1RTM1VOUWcrOHVKbnRMamhEVEdiNm5KTUpBbDdzV1RIVXBrNjBVZ2pZ?=
 =?utf-8?B?TjhXSTNsOS94Q2tBV21XN2xPbXdXdDJwZTFCRlBSd09BWU11QWMveXh6ODhX?=
 =?utf-8?B?anBqYXFIdy9reVF4Wm5mdEhNZVpIZ3laVFYxRWZrbnF0akEzdUcxL0FqTFlV?=
 =?utf-8?B?VGhybVdET2NEa1ZiMStXOENZZk5qYjM3b1hHd01GWXZhaTNpcEt3YU5zQmZV?=
 =?utf-8?B?Qm0xZStsMnc0TDh4QnVWODZGOXVlYlFZa1ovK0JxZnlVWkp3YnI0bGxWY0FK?=
 =?utf-8?B?Mi9Fek9YK0ozdklUUUxMd1VSNTlVUm5UM2VmRjZLaU5oZGJrNUF5YnorYVRY?=
 =?utf-8?B?TXdFRzZXM1EvdUZobVREZXo1eGVZZ1NaQk9QZ3JsYXBYNjRSSTB4TE5XdDBN?=
 =?utf-8?B?bkYrUDRodkxmMkFXWUFka3VDZHBVb1cyMnBqblJuN1JLTjlJSlR4cE1NeW5E?=
 =?utf-8?B?eG91YmZaa0JtSjJENDJjNXdlQjE1Rk1OS0puZlFXbnN3RmNHTSsrNjl2a1hR?=
 =?utf-8?B?Wk0zQ25TTUJRZDFrUkhNa3NjdmMzdlcraytLMzA5djFpejNycnMxcDFJanFt?=
 =?utf-8?B?dkhKVUladEtnQWs1VnY0Q3hTSGc2Zk1HVWMwNTljZmM0aU5qVEVHZGhEQjVl?=
 =?utf-8?B?WFNTQXU4N29XdVdNUEtVN3BVdDludUdiNEdMYVg0SWJrdU1JSk5uZ1lhRFMy?=
 =?utf-8?B?WnhHU3ZhRk4rd3N2ZmRCaU55WmI0V0orZHBRTE5HQzVFa3llWTYxa0w1M0tD?=
 =?utf-8?B?T01oQ2c3VGo5MVVURUZrRlo4eWRSOXJEYWFXNjZ6OHc0TkpTZEd6ekc1VjVM?=
 =?utf-8?B?WllyZnJkaklzYmN4Vk5SNDJ6ZG5mQzFGQVhMcWsreEJyQ04zSUJUbUVkanlx?=
 =?utf-8?B?ajRTN0ZTb0ZHalB6UEhJdWg1MExOVDhGbFliYktQZzZYYmpuR2lNdEl0bjhw?=
 =?utf-8?B?OUNtVGo0d2lzcGp1R0VKUjNKcDRoQVE3TVVqWGlFR3VzTi9CWjhzQ3VBV2t6?=
 =?utf-8?B?emZrRkRjTGhlSjBqaFJlWGxkV21PdXRoK0lLTWFPcUp2V0pqOEpLRzdUakR3?=
 =?utf-8?B?cnRYUEdUb3krbGJBVkpkQndTeG80RHRzeG4wNEdmUHc2NGg5UTdxNmFUN3Fm?=
 =?utf-8?B?MWFNWGlqYjZqUHdmYXVWZWE1UDVmOGo0RWJDRVEvWmltNjJmN1ptanE4TUM1?=
 =?utf-8?B?Zi9jM3l3aW9VVUdCQlpSeUM1Ylp5R0E3TEdrdng3c09ZVytvcms2S04vV2Fi?=
 =?utf-8?B?ZTNtdUNsWUFOTFB4RVFZaC9EMnhzamJrUFk2dWFNc1ErSk1kZUVRaXBQQjZX?=
 =?utf-8?B?T3BNemZxVE1EL1NaNVRBaVh2eUYzMUlLQ0xqZUZadkgrWEtwQm5Lc1paaDFW?=
 =?utf-8?B?bHdrNjByOWpQRG9UbVdYVXFEQzVyUUdOaXFIaFB1dXdJMEhpSEd2WkJJMVgw?=
 =?utf-8?B?MHp6Uy83TGkwb1FLUDF1ZzFmUGhxM3l0eWNTdTVtRlk0M1J6T3JrWGFPdEdV?=
 =?utf-8?B?VlExcVdEckRMQVkxTUFET3c2bFpmQWtKZHpaWEp4L3pyMnlCZ3ZWRGZOemg1?=
 =?utf-8?B?bE9YeCt5ajdZczFvSlpkWkRydnQ4aHRlWXBlV3h5UHBHb0ZQeE0yN3ZvNUR1?=
 =?utf-8?B?dHhRaUc4SG5JMFQrRnZUWVNDZzVuVHRjQkZFc2RyMTA1ajJGcFdOUEU0aWVV?=
 =?utf-8?B?aldhdEFGS3FNRkhWVXRRZGJnMWdSWXNhUmxtMlJRTEJ1Rmw2YWwwYzNjRGhy?=
 =?utf-8?B?OW96V3pFTi93dVhTcXFRMXA4N3dNZWlmSkt0UXZtNFJucDdjVGo4K3JiZDI3?=
 =?utf-8?B?bmNHRzJpdVNSUEt2M0ZBN1VFVkkxWWpqdzAzTnc0dEt6aHN4RnY5YkNXQXV3?=
 =?utf-8?B?QnA4ZlRPV3M1cTBZR280ZTFqcVU5bHRieGNGb0FYRVpGNlNLZGlKeE8vNTR1?=
 =?utf-8?B?Y0U3VkdVaTZTL281WTlSQTQ3QnpXNjBmSlp3ZkhwUEVzTHFHL3FaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c53ffd0-7af9-4787-5386-08def25ca6f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 19:14:48.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Ar4S6QGjmhemlS5df+DTak05HkHCI2UvgK69qp0qRb8WegW1ZGMakItV6i4M8xv5+azYfzvRmeJQDMA4F+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653



On 8/4/2026 10:09 PM, Randy Dunlap wrote:
> 
> 
> On 8/4/26 4:52 AM, Krishnamoorthi M wrote:
>> Add a driver-api overview of the eSPI subsystem and a MAINTAINERS entry
>> covering the subsystem files.
>>
>> The document describes the architecture, how to write a controller driver
>> and a slave driver, the per-channel APIs (Peripheral, Virtual Wire, OOB,
>> Flash), the alert mechanism flow, and the event notification model. An
>> API Reference section renders kernel-doc from the exported symbols.
>>
>> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>> ---
>>   Documentation/driver-api/espi.rst  | 213 +++++++++++++++++++++++++++++
>>   Documentation/driver-api/index.rst |   1 +
>>   MAINTAINERS                        |   8 ++
>>   3 files changed, 222 insertions(+)
>>   create mode 100644 Documentation/driver-api/espi.rst
>>
>> diff --git a/Documentation/driver-api/espi.rst b/Documentation/driver-api/espi.rst
>> new file mode 100644
>> index 000000000000..60a3187edb05
>> --- /dev/null
>> +++ b/Documentation/driver-api/espi.rst
>> @@ -0,0 +1,213 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +===========================================
>> +eSPI (Enhanced Serial Peripheral Interface)
>> +===========================================
>> +
>> +Introduction
>> +============
>> +
>> +eSPI is a bus defined by Intel that replaces the legacy LPC bus. Unlike
>> +SPI it is a structured, capability-negotiated, message-oriented protocol
>> +with four logically independent channels (Peripheral, Virtual Wire, OOB,
>> +Flash) over a shared physical link, and asynchronous target-to-controller
>> +events, so it is modelled as its own bus type rather than an extension of
>> +the SPI subsystem.
>> +
>> +Architecture
>> +============
>> +
>> +* ``struct espi_controller`` - host controller, created with
>> +  espi_controller_alloc() and registered with espi_controller_register().
>> +  It is not itself a device on espi_bus_type.
>> +* ``struct espi_device`` - a target on the bus, matched to a
>> +  ``struct espi_driver`` via its modalias.
>> +* ``struct espi_controller_ops`` - the optional hardware-op table; the
>> +  channel API returns -EOPNOTSUPP for ops a controller does not provide.
>> +
>> +Writing a controller driver
>> +===========================
>> +
>> +A controller driver allocates and registers a controller from its
>> +``probe()`` function::
>> +
>> +    ctrl = espi_controller_alloc(&pdev->dev, sizeof(*priv));
>> +    if (IS_ERR(ctrl))
>> +        return PTR_ERR(ctrl);
>> +
>> +    priv = espi_controller_get_devdata(ctrl);
>> +    ctrl->ops = &my_espi_ops;
>> +    ctrl->max_targets = 1;
>> +
>> +    /* populate ctrl->caps from hardware capability registers */
>> +    ctrl->caps.supported_channels = ESPI_CHANNEL_ALL;
>> +    ctrl->caps.max_freq_mhz       = 33;
>> +    ctrl->caps.io_mode            = ESPI_IO_MODE_SINGLE;
>> +
>> +    ret = espi_controller_register(ctrl);
>> +    if (ret)
>> +        goto err_put;
>> +
>> +After registration the controller calls espi_new_device() for each
>> +target enumerated from firmware (ACPI or device tree)::
>> +
>> +    struct espi_board_info info = {
>> +        .type = "my-ec",
>> +        .cs   = 0,
>> +    };
>> +    edev = espi_new_device(ctrl, &info);
>> +
>> +On removal::
>> +
>> +    espi_remove_device(edev);
>> +    espi_controller_unregister(ctrl);
>> +    espi_controller_put(ctrl);
>> +
>> +Writing a slave driver
>> +======================
>> +
>> +A slave driver declares a device ID table and a ``struct espi_driver``::
>> +
>> +    static const struct espi_device_id my_ec_ids[] = {
>> +        { "my-ec", 0 },
>> +        { }
>> +    };
>> +    MODULE_DEVICE_TABLE(espi, my_ec_ids);
>> +
>> +    static int my_ec_probe(struct espi_device *edev)
>> +    {
>> +        /* register for hardware events */
>> +        nb->notifier_call = my_ec_event;
>> +        espi_register_notifier(edev->ctrl, nb);
>> +        return 0;
>> +    }
>> +
>> +    static void my_ec_remove(struct espi_device *edev)
>> +    {
>> +        espi_unregister_notifier(edev->ctrl, nb);
>> +    }
>> +
>> +    static struct espi_driver my_ec_driver = {
>> +        .driver   = { .name = "my-ec" },
>> +        .id_table = my_ec_ids,
>> +        .probe    = my_ec_probe,
>> +        .remove   = my_ec_remove,
>> +    };
>> +    module_espi_driver(my_ec_driver);
>> +
>> +Channel-independent commands
>> +============================
>> +
>> +espi_get_configuration(), espi_set_configuration(), espi_inband_reset()
>> +and espi_get_status(). GET_STATUS is optional: controllers whose hardware
>> +does not implement the wire command leave .get_status unset.
>> +
>> +Capability negotiation and channel management
>> +=============================================
>> +
>> +At boot the controller driver reads the target's capability registers via
>> +espi_get_configuration(), negotiates link parameters (I/O mode, clock
>> +frequency, CRC) via espi_set_configuration(), then enables each channel
>> +with espi_enable_channel(). espi_channel_is_enabled() may be called at
>> +any time to query the current state. Channels may be disabled individually
>> +with espi_disable_channel(), for example before an in-band reset.
>> +
>> +Channel APIs
>> +============
>> +
>> +Peripheral channel
>> +------------------
>> +
>> +Carries I/O and memory cycles between the host and target endpoints.
>> +
>> +* espi_periph_io_read() / espi_periph_io_write() — 16-bit I/O port
>> +  access; ``width`` is the access size in bytes (1, 2, or 4).
>> +* espi_periph_mem_read() / espi_periph_mem_write() — 32-bit memory
>> +  mapped access.
>> +
>> +Virtual Wire channel
>> +--------------------
>> +
>> +Carries logical signal state (power sequencing, SMI#, SCI#, IRQs) as
>> +indexed wire groups. Each group carries up to four wire values with
>> +individual valid bits.
>> +
>> +* espi_vwire_get() — read a wire group from the target.
>> +* espi_vwire_put() — send a PUT_VIRTUAL_WIRE command to the target.
>> +  Named after the eSPI PUT_VW wire command, not a reference-count
>> +  release.
>> +
>> +Wire changes from the target generate an ``ESPI_EVENT_VWIRE_CHANGED``
>> +event delivered through the notifier chain.
>> +
>> +OOB channel
>> +-----------
>> +
>> +Tunnels SMBus/I2C messages between the host and target out-of-band
>> +processor (BMC, EC). Messages are exchanged as opaque byte buffers with
>> +a tag field for matching requests to responses.
>> +
>> +* espi_oob_send() / espi_oob_recv()
>> +
>> +Incoming OOB messages generate an ``ESPI_EVENT_OOB_RECEIVED`` event.
>> +
>> +Flash Access channel
>> +--------------------
>> +
>> +Provides access to a SPI flash device attached to the target. The target
>> +acts as a proxy for flash read, write, and erase operations.
>> +
>> +* espi_flash_read() / espi_flash_write() / espi_flash_erase()
>> +
>> +Alert mechanism
>> +===============
>> +
>> +When the target has upstream data pending it asserts ``ALERT#``. The
>> +controller's hard-IRQ handler acknowledges the interrupt and defers
>> +processing to a threaded IRQ or workqueue. From that process context the
>> +controller driver calls espi_handle_alert(), which acquires the
>> +controller lock and dispatches to ``ops->handle_alert``. The hardware
>> +callback reads the target's status register (GET_STATUS), identifies the
>> +pending channel, and calls espi_notify_event() to deliver the appropriate
>> +``ESPI_EVENT_*`` to all registered slave driver notifiers::
>> +
>> +    ALERT# asserted by target
>> +          |
>> +          v
>> +    hard-IRQ handler (controller driver)
>> +          |
>> +          v
>> +    threaded IRQ / workqueue
>> +          |
>> +          v
>> +    espi_handle_alert(ctrl)          [espi-core.c]
>> +          |
>> +          v
>> +    ops->handle_alert(ctrl)          [controller driver]
>> +          | reads GET_STATUS, decodes channel
>> +          v
>> +    espi_notify_event(ctrl, &event)  [espi-slave.c]
>> +          |
>> +          v
>> +    slave driver notifier callback
>> +
>> +espi_handle_alert() must always be called from process context; it must
>> +never be called from a hard-IRQ handler.
>> +
>> +Events and concurrency
>> +======================
>> +
>> +Hardware events (Virtual Wire changes, OOB messages, Peripheral channel
>> +completions, channel state changes) are delivered through a per-controller
>> +blocking notifier chain (espi_register_notifier()/espi_notify_event()).
>> +Callbacks run in process context; controllers deliver events from a
>> +threaded IRQ or workqueue, never from hardirq and never while holding the
>> +controller lock.
>> +
>> +API Reference
>> +=============
>> +
>> +.. kernel-doc:: include/linux/espi/espi.h
>> +
> 
> Describe each of these:
> 
> WARNING: ../include/linux/espi/espi.h:176 struct member 'setup' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'cleanup' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'get_configuration' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'set_configuration' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'inband_reset' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'get_status' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'enable_channel' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'disable_channel' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_io_read' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_io_write' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_mem_read' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'periph_mem_write' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'vwire_get' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'vwire_put' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'oob_send' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'oob_recv' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_read' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_write' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'flash_erase' not described in 'espi_controller_ops'
> WARNING: ../include/linux/espi/espi.h:176 struct member 'handle_alert' not described in 'espi_controller_ops'
> 
> 
> or don't use "/**" for that struct's comment header.

Noted. Will add descriptions for all struct espi_controller_ops members 
in v2.

Thanks,
Krishna
> 
>> +.. kernel-doc:: drivers/espi/espi-slave.c
>> +   :export:
> 
> 

