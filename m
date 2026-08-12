Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E68336881;
	Wed, 12 Aug 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539044; cv=fail; b=U03lsshh545QhCV5fzDuO6paPkMRAdFI8CeeEroCSx/DwTzRW7xOaJ6l3zwo6lOYqXDfDcrAMDMThG5fs01WPDKWs0moshFrAEXj2PKriviZ15OiltM2NbvJ9kAMPCnDq360uPtxPscDL8v4G5jlfMbA59obpF2k4z6E9DuF4xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539044; c=relaxed/simple;
	bh=E/d4lnAS+k0Tl7/kYQ4KBgG5OwvKHZHhdYKPW9gNFNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMtu84zQvEKHZvdG6cU9Zf3OUqC0MbO+RrLefrL5/j7iBMxZFc1D9pSwEF9x6Z4lPprftNICw/c8cU9eRtdbs4x7FYen/VCWLgdoYFHZa2WXEiKKOhN+Lp/hbqCBQ0lQfUUueI8WaPu/U+ClhxP9uZv5h/L3ZaJgbz1I5sadhn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KHGMZwYT; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KHGMZwYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4o53Fww/MugYhMb8UxpnfDfnx0x6DqGY4docgrQ+hPxiuUbcXmjLaFecTYDQRw2BNCgWReDVpbZPJqCtkW2BUIf8k5106W0d3aOM79ybSU0wAlFWcC/VWX2D6mnrM1yN+l8OIPItdI8JhxCx6hAXn4UMs3mUnfPCQUsimvYKGNFmt46KCDqxitPR08tISAVVoe04BD5oXqYrFYCchaJcPypM2xNuWipdKUhxWbhiGQKPaFceDaF5sd13lYcgNQbJZt1wvG8QBbANjeWvxKQsniT02CtBTZebtpao+hIwF84zmS5mZrjc3pFgmfgMwfQlBM210MQE6HAgdofWTBlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDka4LESva/Xu/HG1yMsyCWJ71LjV6w1vLMqyhmV1ek=;
 b=hJFgLbQqhJXRMvcSD6O5Sr9OD7H3kgnKcK5XA8h5yhOQ9DILXf4PmOSPV81ygrUQ2vVgtTFyeMSUt+nZT5zu4oBZDSXLHq0AgW2l8lne5/g/16+jD8Xm/3SXD0EuFujED1IwCR2KH50eiCon4v6KrmmztTNKhQkLvNVRKwjMToz5e2QXZFuRXM+KaxrlAKrD5TwDPx9KX4SPIEKTYq1DZSVKrVhGKmYoPHtYCB+DMlpDvrQANrsPhk6msF4nacyf6GeUF1XwQjgegBDGc+vKgdApI5DOsKKgNk2NTDKKYXDArFp3Oqd9++rxdjBRoGhfvRdDPg+GNE5+Neg0Ee6i+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDka4LESva/Xu/HG1yMsyCWJ71LjV6w1vLMqyhmV1ek=;
 b=KHGMZwYTly3mj+49dLBr+5DkF4JES7ZWY1EvGHIDZa6ccd2o8EVZ7gqinqlXF29a7+8yd+SYo6yd9d3OqNrxtobro6VbCbRM745vuZxGrLRpuETnTLY9uzVU01Av4eBVEZgCVq1zjRW+xthQdXB3FEDMCGzwzt4Q7zHLJA3UW2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 12:50:37 +0000
Received: from DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c]) by DM4PR12MB9733.namprd12.prod.outlook.com
 ([fe80::aeaa:23b5:1d59:602c%3]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 12:50:37 +0000
Message-ID: <0f7469b8-8275-4061-b336-97cbce41ff82@amd.com>
Date: Wed, 12 Aug 2026 18:20:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] espi: add core bus framework
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 broonie@kernel.org, linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <20260804115259.4065638-2-krishnamoorthi.m@amd.com>
 <anSGjRK8spayFnKw@monoceros>
Content-Language: en-US
From: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
In-Reply-To: <anSGjRK8spayFnKw@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::18) To DM4PR12MB9733.namprd12.prod.outlook.com
 (2603:10b6:8:225::13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9733:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d462ac-2022-4367-c796-08def8704eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|11063799006|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	yPw/LXBOkNLfbT+5t0f4q+UXdFeza+HxFed+rP49OJqrw/gnWQ7tnhAtRmQ6B0R86+0anofSspti+7LLvEQ2zQ57nBEgbwa+K6k/pg1fNYwXgAI1LFHT9yz1fHkGX63ym8xa21/YNRc6EVP4zqVdxQdbFgf2QIkDrjs9M0aiJsQYMNFI1WjsbwPMAA1HE5P79jmb64riRxaYhJ9zTrSHsRia5yKGXw7Ym+KUUw9dZJfGR3It/N8Idz+yvJzkBc+6Wqk1h01eSjg6v65+uxq7azkG4/ohY6OlDpnmm2svK7pM5UlP9ySOjGhlhy+N7q6J2iCm3P9zoLKE23AQkW/sdl9YT9zMKyrcO5xcy5rqkch6Bu0fZQi1x6aOGj31IcZ1JF4s5Wpb5ynsbsAguy2Urs7fHewueKPZKGA5YPen6Cm0S9GAplptK9ejA9AfCJkfZibKnGJQ83vXHS8YOXrlAtE+PfihXiRwe5ilNGtdQwEODiVprwfD7hzWbVMS3puIDg3p5ivGDyoYKi0F3Ex6Z8MBHWlWgqPGxoowXcCzpyPFbclx1GHHYkCcTG5dC0CjJS4GiZdBe1ZytSp+RiYXktGSphMoTLjvg3OmuyBYv2mULKBT3ZTD+1jfK+F9Zrty9JEjrytAgyfQAxUH86PYG31v7kDLTyGZE91StNJVFHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(11063799006)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElNZThoLzcvTmdjQ0E0RTBsdzVrUnJFcEJtR08yV28ydkZhc2VFaUoxb2Uz?=
 =?utf-8?B?Zit3VkhYUVFnSHk3dVZQa1pUSkdhUU9EbURuZ3J2RnRtdmhPWlRMRXFqMkdU?=
 =?utf-8?B?VUpyS2pNU1ZhUk14S016Wkx6YzZlR2xMdFNrMHZqbU9IZDQycGtOVmFRdHdZ?=
 =?utf-8?B?N2V2WTZ2bVUrNHZDUm44cHlyR1FnRnNZblQzaE5Hc01ZOXlOUTlSVjhTb3kw?=
 =?utf-8?B?VEE0SkV4YUVUdGMweXRycWlqMjBlWnB6MU96S3AwdjlFcG43K0VOeEJ0OHZX?=
 =?utf-8?B?eHJRc203QVZraHRQY2ZVQ0laYWpyVTEycEVkdUlKTVlsR1pMTUVzTm54QXJr?=
 =?utf-8?B?Y2M5QjM0VUJYQkZtNktLNEtwZG5iNjlad3lLU1dhNWt4VnNoRjE2K29wRUc1?=
 =?utf-8?B?OVJEbE1uNjBKWjZlZGR5YWZHK1RmRlg2TEQ0aTljU2ttWTVrR0JBV29Tbm5Z?=
 =?utf-8?B?ZGJ3MU1xNnBFNEx6UFdZekRvbStvM3FheEV3bDk3ZktCUEhpaUwwVkxaRFo4?=
 =?utf-8?B?WEFUamhuanBLQTNGZnMwRDRmMkFNSll0cytoc0JrZi9kTjN2MjQxQVplalNG?=
 =?utf-8?B?ZXZJR1ZLUFI4M0xuaXBhMVY3K3YxbDFVT0JZSnNkUTZXUXprREk3UU5FVGw2?=
 =?utf-8?B?NDBtUEsyZW8xcUlJL0g1SXFBUjdlemNZcTVZaDZzcENIOVkzYmJYZi9PREVq?=
 =?utf-8?B?RG1rVVN5SllaTUd0TldJZ2NQL09ncVJ4YnArMzhrSDQ1RVZFQU1zaFlqTmRW?=
 =?utf-8?B?YTJLL1EvUDNYUE9ZVE9jbnVndER4YnVqQW44dEVaSzFUNkFEdmVnQll3QjJE?=
 =?utf-8?B?Tmk2TSt0TGNoeUpaMk9QMDcyM21UTW1ENGRmWU1jQ0EzSVl1VzJJeFR1Qkw2?=
 =?utf-8?B?bE1SQ0x1Qk9EdXltL054MVlEN0tpUUhXY2NGZWFBK0d3Z1FqNWVQOXlKNzFN?=
 =?utf-8?B?UmxyZjY2cXpFckNwOVMxLzNGTTE1Unl2MHE3a3NVd3FvRU9wWFZQTzlwc1Zn?=
 =?utf-8?B?U011b1RPV25GUXFpRktkL3d3cG5qWno0dGRIRmtBKzY3aDJDSFh0Z3V2WE9h?=
 =?utf-8?B?NHQ2SlBlSUFrVHVmc3AvZnIxdVgvVVI5L1VDQUhBK1lMS0JReDhGOTV4RHlT?=
 =?utf-8?B?ZFN4WmJVejFLaERKMXRWRng3SmUyOVdJOTRkKzJUV0hKMlQ3anNoTjA0U2pk?=
 =?utf-8?B?dGY4RmdLODhLblFRbkFOaDMxWG1TeDdXTTZnUzIzT0Rod0pBNzlWNGNNeXFZ?=
 =?utf-8?B?Tml2NjNwS1E5NVk3QmFtWXBoemNvdkxQNENkd3dzOVpkSTBTK1hocTBSQS9h?=
 =?utf-8?B?NWYyODFVcVovcFgrY0htazdnLzk1WjBYL2VFbGpGd3NOMktIMC9BaG44WFNp?=
 =?utf-8?B?SzluY3JzZ2Z6VXQ3Q3ErNmtNbjdKWUlWeXpXZm9UeWczaHNKYTdldmRiaTVa?=
 =?utf-8?B?Q1JyS09lYTFwZXV0dTczYU44SDlCVXVOZjZiRjlWY1JTNEN5dTlDY040RGFs?=
 =?utf-8?B?azJKRHZVUVRncHg0QW1WSUFraEY0Kzk4Q3JlazRhdU1OQjEvcUF1NEVLazhH?=
 =?utf-8?B?dnZLN0dOZjFKV3RZNzhCTmx3SFRib2xoVFVMRllKVksxTW05MVpZd1AxcDlt?=
 =?utf-8?B?N016SzZreGQrZlhNMm1KU3BnUnQ1bVFlRWMxWDc5K09ERnpPdUcwR2JkQXNT?=
 =?utf-8?B?SThDQ3JudDVYeHlhWCtIdHVNWXRTTXM1MjRFWFFFSjNBWHVJWXhHY2UxT2lN?=
 =?utf-8?B?clZqc055SVlyMk5mekRTQkcxWmx0UUREZmdtUThoYXU3eWc2Nk1uVmpycTBh?=
 =?utf-8?B?dURyR0ZPdVdDSUE2KzhyUDFFM2JOdjA4Z3h0T2lnVnBQQkZ0UUd4NnJyeHF6?=
 =?utf-8?B?aVFDejdaRzJtYTlNUW5BdDdFbTlIazkxV2EzM05ZM2hsQXFiQnUyTlpGQkJT?=
 =?utf-8?B?dDBod1Z4WnlCWTN6dDBrN1VGVUFEMUR6bHNjMVB1UXZaK2RtaXBpaGFmd1g1?=
 =?utf-8?B?aFdBT0FxeTBCMTMrVG8wZXJJbHVZVUF0U0tOTUQ3a0VjVmFrdUptRzhESXR6?=
 =?utf-8?B?SzJ1T1EvWDBaek1qMUVaK0QzNTNXMTRpdXJjK0J2QlREZnNkNlI2L1lXMU53?=
 =?utf-8?B?U3J6UzNpc1o3OE43ckttZVBBdUd2QmMvV0tOWFV1bWtucmlaUG90STBTTVBa?=
 =?utf-8?B?dkhGVlE4UlhSWjlNc01MT3J0WEpwSGhydlF5TTJ3UzR1S2h4UTF6OWNya1Yx?=
 =?utf-8?B?MllSNDZ6YzNvMHNKV3VlMVBmRFJaR3BSVDhGbFBEWDVnQnN5QmZLM25GS3R0?=
 =?utf-8?B?dms3aFN4clVRbmdIQkE5d3Y5WlhNZ250bEUxTkdkcktacUZJSmprZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d462ac-2022-4367-c796-08def8704eb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:50:37.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kth9e6IsrAJXPdcm0UjR34OX9Sr6rRDbhmvveBVOkonhgJ8I1qzw/GAc/1iKMW1bn/QWeUomE/KPaPjBlkEenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

Hi,

On 8/6/2026 7:01 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Aug 04, 2026 at 05:22:56PM +0530, Krishnamoorthi M wrote:
>> diff --git a/drivers/espi/Kconfig b/drivers/espi/Kconfig
>> new file mode 100644
>> index 000000000000..4411d8336e82
>> --- /dev/null
>> +++ b/drivers/espi/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# eSPI (Enhanced Serial Peripheral Interface) bus configuration
>> +#
>> +
>> +menuconfig ESPI
>> +	bool "eSPI (Enhanced Serial Peripheral Interface) bus support"
> 
> Can this be tristate instead?

Yes. CONFIG_SPI is bool, but CONFIG_I2C and CONFIG_I3C are both 
tristate, allowing the bus framework to be built as a module. Given that 
eSPI controller and slave drivers are expected to be modular, tristate 
is the better fit and is consistent with the majority of comparable bus 
frameworks.

> 
>> +	help
>> +	  Enhanced Serial Peripheral Interface (eSPI) bus framework.
>> +
>> [...]
>> +const struct bus_type espi_bus_type = {
>> +	.name	= "espi",
>> +	.match	= espi_bus_match,
>> +	.uevent	= espi_bus_uevent,
>> +	.probe	= espi_bus_probe,
>> +	.remove	= espi_bus_remove,
>> +};
>> +EXPORT_SYMBOL_GPL(espi_bus_type);
> 
> Do you really need this exported?

Yes, it is required. Controller and slave drivers built as modules 
reference espi_bus_type directly when registering devices. Without the 
export they fail to link.

> 
>> +static ssize_t supported_channels_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	struct espi_controller *ctrl = to_espi_controller(dev);
>> +
>> +	return sysfs_emit(buf, "0x%02x\n", ctrl->caps.supported_channels);
>> +}
>> +static DEVICE_ATTR_RO(supported_channels);
>> +
>> +static ssize_t max_freq_mhz_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct espi_controller *ctrl = to_espi_controller(dev);
>> +
>> +	return sysfs_emit(buf, "%u\n", ctrl->caps.max_freq_mhz);
> 
> Is the unit here mHz or MHz? Maybe pick a better name that answers this
> question.

The value is in MHz. we will rename the attribute to make the unit explicit.

> 
>> +}
>> +static DEVICE_ATTR_RO(max_freq_mhz);
>> +
>> +static ssize_t io_mode_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>> +{
>> +	struct espi_controller *ctrl = to_espi_controller(dev);
>> +	static const char * const modes[] = { "single", "dual", "quad" };
>> +	u8 m = ctrl->caps.io_mode;
>> +
>> +	if (WARN_ON_ONCE(m > ESPI_IO_MODE_QUAD))
>> +		return sysfs_emit(buf, "unknown\n");
>> +	return sysfs_emit(buf, "%s\n", modes[m]);
>> +}
>> +static DEVICE_ATTR_RO(io_mode);
>> +
>> +static ssize_t channel_enabled_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	struct espi_controller *ctrl = to_espi_controller(dev);
>> +
>> +	return sysfs_emit(buf, "0x%02x\n", READ_ONCE(ctrl->channel_enabled));
>> +}
>> +static DEVICE_ATTR_RO(channel_enabled);
>> +
>> +static struct attribute *espi_controller_attrs[] = {
>> +	&dev_attr_supported_channels.attr,
>> +	&dev_attr_max_freq_mhz.attr,
>> +	&dev_attr_io_mode.attr,
>> +	&dev_attr_channel_enabled.attr,
>> +	NULL,
> 
> No , after the list terminator please.

Ack.

> 
>> +};
>> +ATTRIBUTE_GROUPS(espi_controller);
>> +
>> +static void espi_controller_release(struct device *dev)
>> +{
>> +	struct espi_controller *ctrl = to_espi_controller(dev);
>> +
>> +	mutex_destroy(&ctrl->lock);
>> +	mutex_destroy(&ctrl->device_list_lock);
>> +	kfree(ctrl);
>> +}
>> +
>> +static const struct device_type espi_controller_type = {
>> +	.groups	 = espi_controller_groups,
>> +	.release = espi_controller_release,
>> +};
>> +
>> +struct espi_controller *espi_controller_alloc(struct device *parent,
>> +					      unsigned int size)
>> +{
>> +	struct espi_controller *ctrl;
>> +
>> +	if (!parent)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
> 
> You might want to align sizeof(*ctrl) to something like
> ARCH_DMA_MINALIGN, to ensure that devdata below is aligned
> appropriately. Also use size_add() instead of direct arithmetic with
> sizes.
> 

Agreed. I'll align the private-data offset with 
dma_get_cache_alignment() like SPI does and use size_add() for the 
allocation size. Will fix it.

>> +	if (!ctrl)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	device_initialize(&ctrl->dev);
>> +	ctrl->dev.parent = parent;
>> +	ctrl->dev.type = &espi_controller_type;
>> +
>> +	mutex_init(&ctrl->lock);
>> +	INIT_LIST_HEAD(&ctrl->device_list);
>> +	mutex_init(&ctrl->device_list_lock);
>> +	BLOCKING_INIT_NOTIFIER_HEAD(&ctrl->notifier_list);
>> +
>> +	if (size)
>> +		espi_controller_set_devdata(ctrl, (void *)ctrl + sizeof(*ctrl));
>> +
>> +	return ctrl;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_controller_alloc);
>> +
>> +int espi_controller_register(struct espi_controller *ctrl)
>> +{
>> +	int ret;
>> +	u32 id;
>> +
>> +	if (!ctrl || !ctrl->ops)
>> +		return -EINVAL;
>> +
>> +	ret = xa_alloc(&espi_controllers, &id, ctrl, xa_limit_31b,
>> +		       GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ctrl->bus_num = id;
>> +	ret = dev_set_name(&ctrl->dev, "espi%d", ctrl->bus_num);
>> +	if (ret)
>> +		goto err_erase;
>> +
>> +	if (ctrl->ops->setup) {
>> +		ret = ctrl->ops->setup(ctrl);
>> +		if (ret) {
>> +			dev_err(&ctrl->dev, "controller setup failed: %d\n", ret);
>> +			goto err_erase;
>> +		}
>> +	}
> 
> is ops->setup supposed to be only called in espi_controller_register()?
> If yes, why does it exist? The driver specific stuff in it can just be
> done before espi_controller_register() is called, can it not?

You're right. ops->setup is only called from espi_controller_register() 
and nothing in it needs core state, so drivers can do that work before 
calling register. I will drop it.

> 
>> +	ret = device_add(&ctrl->dev);
>> +	if (ret) {
>> +		dev_err(&ctrl->dev, "device_add failed: %d\n", ret);
> 
> Better use %pe for error codes.

Noted. Will change it.

> 
>> +		if (ctrl->ops->cleanup)
>> +			ctrl->ops->cleanup(ctrl);
>> +		goto err_erase;
>> +	}
>> +
>> +	dev_info(&ctrl->dev, "registered: channels=0x%02x freq=%uMHz\n",
>> +		 ctrl->caps.supported_channels, ctrl->caps.max_freq_mhz);
> 
> Please degrade that to dev_dbg. We're already have too many messages
> during boot that are not really usefull once driver/subsystem debugging
> is done.
> 
> Also I'd add a space between "%u" and "MHz".
> 

Sure. I will change it to dev_dbg() and add the space.

>> +	return 0;
>> +
>> +err_erase:
>> +	xa_erase(&espi_controllers, ctrl->bus_num);
>> +	ctrl->bus_num = -1;
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_controller_register);
>> +
>> +void espi_controller_unregister(struct espi_controller *ctrl)
>> +{
>> +	if (!ctrl)
>> +		return;
>> +	/*
>> +	 * Remove from the lookup table before dropping the device reference,
>> +	 * so a concurrent espi_controller_get_by_bus_num() can never take a
>> +	 * reference on a controller that is going away.
>> +	 */
>> +	xa_erase(&espi_controllers, ctrl->bus_num);
>> +	if (ctrl->ops && ctrl->ops->cleanup)
>> +		ctrl->ops->cleanup(ctrl);
>> +	device_unregister(&ctrl->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_controller_unregister);
>> +
>> +void espi_controller_put(struct espi_controller *ctrl)
>> +{
>> +	if (ctrl)
>> +		put_device(&ctrl->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_controller_put);
>> +
>> +struct espi_controller *espi_controller_get_by_bus_num(int bus_num)
>> +{
>> +	struct espi_controller *ctrl;
>> +
>> +	guard(spinlock)(&espi_controllers.xa_lock);
>> +	ctrl = xa_load(&espi_controllers, bus_num);
>> +	if (ctrl)
>> +		get_device(&ctrl->dev);
>> +	return ctrl;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_controller_get_by_bus_num);
>> +
>> +int espi_get_capabilities(struct espi_controller *ctrl,
>> +			  struct espi_capabilities *caps)
>> +{
>> +	if (!ctrl || !caps)
>> +		return -EINVAL;
>> +	guard(mutex)(&ctrl->lock);
>> +	*caps = ctrl->caps;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_get_capabilities);
>> +
>> +bool espi_channel_is_enabled(struct espi_controller *ctrl, u8 channel)
>> +{
>> +	if (!ctrl || channel >= ESPI_CHANNEL_COUNT)
>> +		return false;
>> +	guard(mutex)(&ctrl->lock);
>> +	return !!(ctrl->channel_enabled & BIT(channel));
>> +}
>> +EXPORT_SYMBOL_GPL(espi_channel_is_enabled);
>> +
>> +int espi_get_configuration(struct espi_controller *ctrl,
>> +			   u32 slave_reg_addr, u32 *config)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->get_configuration)
>> +		return -EOPNOTSUPP;
>> +	if (!config)
>> +		return -EINVAL;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->get_configuration(ctrl, slave_reg_addr, config);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_get_configuration);
>> +
>> +int espi_set_configuration(struct espi_controller *ctrl,
>> +			   u32 slave_reg_addr, u32 config)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->set_configuration)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->set_configuration(ctrl, slave_reg_addr, config);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_set_configuration);
>> +
>> +int espi_inband_reset(struct espi_controller *ctrl)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->inband_reset)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->inband_reset(ctrl);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_inband_reset);
>> +
>> +int espi_get_status(struct espi_controller *ctrl,
>> +		    struct espi_slave_status *status)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->get_status)
>> +		return -EOPNOTSUPP;
>> +	if (!status)
>> +		return -EINVAL;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->get_status(ctrl, status);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_get_status);
>> +
>> +int espi_enable_channel(struct espi_controller *ctrl, u8 channel)
>> +{
>> +	int ret;
>> +
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->enable_channel)
>> +		return -EOPNOTSUPP;
>> +	if (channel >= ESPI_CHANNEL_COUNT)
>> +		return -EINVAL;
>> +	guard(mutex)(&ctrl->lock);
>> +	ret = ctrl->ops->enable_channel(ctrl, channel);
>> +	if (!ret)
>> +		ctrl->channel_enabled |= BIT(channel);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_enable_channel);
>> +
>> +int espi_disable_channel(struct espi_controller *ctrl, u8 channel)
>> +{
>> +	int ret;
>> +
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->disable_channel)
>> +		return -EOPNOTSUPP;
>> +	if (channel >= ESPI_CHANNEL_COUNT)
>> +		return -EINVAL;
>> +	guard(mutex)(&ctrl->lock);
>> +	ret = ctrl->ops->disable_channel(ctrl, channel);
>> +	if (!ret)
>> +		ctrl->channel_enabled &= ~BIT(channel);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(espi_disable_channel);
>> +
>> +int espi_periph_io_read(struct espi_controller *ctrl,
>> +			u16 port, u8 width, u32 *value)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_io_read)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->periph_io_read(ctrl, port, width, value);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_periph_io_read);
>> +
>> +int espi_periph_io_write(struct espi_controller *ctrl,
>> +			 u16 port, u8 width, u32 value)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_io_write)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->periph_io_write(ctrl, port, width, value);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_periph_io_write);
>> +
>> +int espi_periph_mem_read(struct espi_controller *ctrl,
>> +			 u32 addr, void *buf, size_t len)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_mem_read)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->periph_mem_read(ctrl, addr, buf, len);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_periph_mem_read);
>> +
>> +int espi_periph_mem_write(struct espi_controller *ctrl,
>> +			  u32 addr, const void *buf, size_t len)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->periph_mem_write)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->periph_mem_write(ctrl, addr, buf, len);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_periph_mem_write);
>> +
>> +int espi_vwire_get(struct espi_controller *ctrl, u8 index, u8 *value, u8 *valid)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->vwire_get)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->vwire_get(ctrl, index, value, valid);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_vwire_get);
>> +
>> +int espi_vwire_put(struct espi_controller *ctrl, u8 index, u8 value, u8 valid)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->vwire_put)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->vwire_put(ctrl, index, value, valid);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_vwire_put);
>> +
>> +int espi_oob_send(struct espi_controller *ctrl, const void *buf, size_t len, u8 tag)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->oob_send)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->oob_send(ctrl, buf, len, tag);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_oob_send);
>> +
>> +int espi_oob_recv(struct espi_controller *ctrl, void *buf, size_t *len, u8 *tag)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->oob_recv)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->oob_recv(ctrl, buf, len, tag);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_oob_recv);
>> +
>> +int espi_flash_read(struct espi_controller *ctrl, u32 offset, void *buf, size_t len)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_read)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->flash_read(ctrl, offset, buf, len);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_flash_read);
>> +
>> +int espi_flash_write(struct espi_controller *ctrl, u32 offset, const void *buf, size_t len)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_write)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->flash_write(ctrl, offset, buf, len);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_flash_write);
>> +
>> +int espi_flash_erase(struct espi_controller *ctrl, u32 offset, size_t len)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->flash_erase)
>> +		return -EOPNOTSUPP;
>> +	guard(mutex)(&ctrl->lock);
>> +	return ctrl->ops->flash_erase(ctrl, offset, len);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_flash_erase);
>> +
>> +/*
>> + * espi_handle_alert - dispatch a hardware alert to the controller
>> + *
>> + * Must be called from process context (threaded IRQ or workqueue).
>> + *
>> + * ctrl->lock is NOT held across ops->handle_alert so that the driver
>> + * callback can call espi_notify_event() without deadlocking: notifier
>> + * callbacks may in turn call channel APIs that also acquire ctrl->lock.
>> + * The driver is responsible for taking ctrl->lock around any register
>> + * accesses that need serialisation with the channel API.
>> + */
>> +int espi_handle_alert(struct espi_controller *ctrl)
>> +{
>> +	if (!ctrl || !ctrl->ops || !ctrl->ops->handle_alert)
>> +		return -EOPNOTSUPP;
>> +	return ctrl->ops->handle_alert(ctrl);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_handle_alert);
>> +
>> +int __espi_register_driver(struct module *owner, struct espi_driver *drv)
>> +{
>> +	drv->driver.owner = owner;
>> +	drv->driver.bus = &espi_bus_type;
>> +	return driver_register(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(__espi_register_driver);
>> +
>> +void espi_unregister_driver(struct espi_driver *drv)
>> +{
>> +	driver_unregister(&drv->driver);
>> +}
>> +EXPORT_SYMBOL_GPL(espi_unregister_driver);
>> +
>> +static int __init espi_init(void)
>> +{
>> +	int ret = bus_register(&espi_bus_type);
>> +
>> +	if (ret)
>> +		pr_err("failed to register eSPI bus: %d\n", ret);
>> +	return ret;
>> +}
>> +postcore_initcall(espi_init);
>> +
>> +MODULE_AUTHOR("Krishnamoorthi M <krishnamoorthi.m@amd.com>");
>> +MODULE_DESCRIPTION("eSPI core framework");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/espi/espi.h b/include/linux/espi/espi.h
>> new file mode 100644
>> index 000000000000..a191ddc10cdd
>> --- /dev/null
>> +++ b/include/linux/espi/espi.h
>> @@ -0,0 +1,345 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * eSPI (Enhanced Serial Peripheral Interface) framework
>> + *
>> + * Copyright (c) 2026, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + */
>> +#ifndef _LINUX_ESPI_ESPI_H
>> +#define _LINUX_ESPI_ESPI_H
>> +
>> +#include <linux/bits.h>
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/mutex.h>
>> +#include <linux/types.h>
>> +#include <linux/mod_devicetable.h>
> 
> Please don't include <linux/mod_devicetable.h>. I think you're not even
> using a symbol defined by it, so you can just drop it.

Ack.

> 
>> [...]
>> +struct espi_device_id {
>> +	char name[ESPI_NAME_SIZE];
>> +	kernel_ulong_t driver_data;
> 
> There is an effort to replace .driver_data by an anonymous union for the
> already existing *_device_id. See
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for details. It would be awesome if you'd do that from the start.

Sure. Will change it. Thanks for the pointer.

Thanks,
Krishna
> 
>> +};
> 
> Best regards
> Uwe

