Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022106.outbound.protection.outlook.com [40.107.75.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986822E2286;
	Thu, 20 Aug 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207159; cv=fail; b=u0krhEdZOB+fNGsX/rTkTulwqvKqEhITrKMCV6cUt74+npayEFQR792cJphbV/oSFoAPTPig/rbkZB+FvLpR09W7GZJYZ46QV3MV6ClRaZadnRILAwqsu5r2GeROPW3HsuQfYtPipLZDgt/k8rg6lsfLK9UdWbZQWu3OgL6Q2SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207159; c=relaxed/simple;
	bh=SElEHEaQ+eIqNlScCk9jiVEgHf+PrR/apuFMjAF74vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1hmjO/6XK01qPpTphvg7SegMqSbknIq3x6sIjMcIxn9Brb4332fMDY4yK048m1VyEBx3bv+GSUcQAA9jV/Xi2bVuWP6ADAho/OIyVv8270uww2+z+cm0DhpUevFTWtUNU9YIyRdhEwoG7U+U3hqZ+jo0Pt6b+7HHjd9sa+dvKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=CJfCW2Ky; arc=fail smtp.client-ip=40.107.75.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="CJfCW2Ky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqrLbH7BjDIpWTWUGTjEqFaPnZ2ZpfRkoo8a1cmkoWPUgy6nKzO2lBEDBHFn/DjiHBfqsPmwdqClq+gIkp+ZZzJ8X8dhMRvt6Hkh0MCfSfQ/3ql4DTOki1k/pe23rjy+3djO7ziqtQrYs+9iiY91OC6B6p6Gc7l7MDzJztQ+wrdQvetbPZMir/fIZlTfe6iSwqgdAuZzgFbySFQth50SAkxC+EqvukWBCxD0wJiclBsosd0SpFGcOaOJrjY0by19MrUVvodC+iHm4WqQOD9rXvxsyxIUH/3yNibccDX97Heiqr9rOnnACM44q+0Z5ju+kbrmXlFzqWhwHd/VK6dc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SElEHEaQ+eIqNlScCk9jiVEgHf+PrR/apuFMjAF74vI=;
 b=UUJnUtLD8rFG5vrvquoIvzKTJo/oDsf/CUcJzmFlpyUPrkwr/a8dGK+5uNwIUzIFwGWenKRWp1ksaOac6/ers+xprZ6fk8KLWrl68THKFd84DGg79+wrxrYqHqc+/hhpS8BFdFgUs4PPj50EqDBSf9F7yTnq1e/JXtA51KwWqwQ8AMU+ngxoTOEqytWrKK+rVlM6BZwYv9sq2jOC7cK1ZOa/l5SCLqi8TDCSCnmb5rbXDk+iOhTnQHs/HnUGEq9T5ZINzdOQ1667Z6hr7Szbhix/bBoYVyx1gDHOgt33wmfoDbaqjrBZ85ry5607O+Y7bW46dt8gaGGxKHHF1vetPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SElEHEaQ+eIqNlScCk9jiVEgHf+PrR/apuFMjAF74vI=;
 b=CJfCW2Kyjt2bMe3yylKEY5xdoMBGm5BZjCWns+SWEXbxtrfaxlztNZTxzAA96qhlLe2HnS5x60Jg/BthsjP7Lz5pQI9VGeOmWftpCM0jjHN+M6Al8Vs8tj4ATlVh4cTnOX5U/mekWLQD6NeN3E/cnxxWuQmENZeoY69iLxB/uHyNCeijPxbcwqamVMea2f0AhfYpoxilGxnmyLI1SeMleZy4syOBlY+F5J/HlU437NTx+y/iSCZRn4UdwK9ZEYHx3H8VDtZeKnaUt7B7je9jUrguwnHXg0pXBeWe4Q7g265r/2CoilDxELNJC6KBK/h9BwzyUKxQd0gckpq8Nx86Eg==
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 (2603:1096:820:78::12) by JH0PR06MB7326.apcprd06.prod.outlook.com
 (2603:1096:990:a9::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 06:25:50 +0000
Received: from KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6]) by KL1PR0601MB4276.apcprd06.prod.outlook.com
 ([fe80::b7f3:3c41:fd0e:e3f6%4]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 06:25:49 +0000
From: YH Chung <yh_chung@aspeedtech.com>
To: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "akshata.mukundshetty@amd.com"
	<akshata.mukundshetty@amd.com>, "bleung@chromium.org" <bleung@chromium.org>,
	"groeck@chromium.org" <groeck@chromium.org>,
	"chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, YC Hsieh <yc_hsieh@aspeedtech.com>, Maciej
 Lawniczak <maciej.lawniczak@intel.com>, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Thread-Topic: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Thread-Index: AQHdJAuknqBBP2CVjUqShr/HE/RpMbaOnoQAgAErz4CAApUZMIARgp8AgAKkfyA=
Date: Thu, 20 Aug 2026 06:25:49 +0000
Message-ID:
 <KL1PR0601MB427610EA42683AA298B53C4390A42@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
 <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
 <9180f5d5-9885-492b-b80e-c2aaaeb39501@amd.com>
 <KL1PR0601MB42768F2FB7E907618E1DAB4E90DE2@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <d1bdc779-724a-4851-8c26-7e02981bae7a@amd.com>
In-Reply-To: <d1bdc779-724a-4851-8c26-7e02981bae7a@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4276:EE_|JH0PR06MB7326:EE_
x-ms-office365-filtering-correlation-id: 51e8f7fe-6d06-4cfc-d284-08defe83e0c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|42112799006|1800799024|366016|38070700021|4143699003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ka5KyNc8NFjdK/1wH3TnsD2/G83uOt8IaDQ8D2KhovMtWMt3kAOeRhHNHz9WQ1o+ka1dYClpgyEN0ltum9TI7DjnKC/THbBOhZRvQMOzisl6F+zWLr52+8zwb9nuwjvGFBjdVlEG0fxGJIIdGKArdvV0Y3SMrrcF3QpRu36/tOCWUhVcZ5ffThuVmNQx6oBX5lYtgq+akTyZzubvqNCNay/1n8lLm2qaTYilD1G0XlO2zTC+cHezsdzPm52YwddxbwrUu4BwbMHVk7Pv2FOfq/ZxeTMB4o3/7MWAcpEBAydnSeueQ1XOTBJEU+Nopa+BS+A8VcIt+ukhrVJtuDSNxmGdy6i/uIohyzUWs8R/T6ko+r9H3rtKsBsQlH4jF+iKJCTO3mT+LJK4H3ujhaPscWNgjj9RRlY7VtJuufjX+/H7P0VNMAapd0LFlyltrNocojkOJdL3CaNLHl/pK5UDhlCzOCb+YgFzDpbR2wFRQYSAybqPDzca+p465arAArmPxlAaZJSL6OrMmZVI/z/+aG1Gjohy5s/XaBN1dhFJhZL+RTd7kCgdgeyZhp3cIOCVZod3PiRwgMZe5OIYJRRxnXNSzbl32qBpO+6frSwMKS8gCR5yl2zaae9H34Rh6c5NlZqNycEXqwlfRG+ZOe/G44CqUSIrkae+hfaFk6LZcKJVKNGZMBjzjks6IsvwNdC6o9REEMwIrWpfXv7YIqP2jw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4276.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(42112799006)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VURjbElPbWF5QjhmMHl3ajlQeWdGMXB1bW13ekhJV2RxelRqYUlXckE0MGtZ?=
 =?utf-8?B?SEkrUUQrWWpDaDYyM0poOUlEcDJIUjNtZGVIUVFEYmwyYVA2WFBDRlExZncv?=
 =?utf-8?B?Y2xDWStPWWhaSWFnMkwwNitzSkpodWJPbmdyTFlHS2pXaTAzOWtZYzRRMnll?=
 =?utf-8?B?QmpiTW02a3IrWm8zMGZTajJUUnpTZS81emozM0o1MGdnL09KNzFrZ3dET01T?=
 =?utf-8?B?VlAwRGR3aDRMOUdSUE1RbDg0ZVc4M1VxRmpnbnBuR3U0WlpmKzBsWmI3bGE4?=
 =?utf-8?B?Vlk1OWVyY0FCTDRCZjlBQm80dTV4OVM4VkZDa0NPOEFVVjhadVd2bDNkaUVU?=
 =?utf-8?B?OS9IL3RsWVZYOGcwVVplQlhmZUpTTU9FY1hhMlVEVjYxTlRTVThTWGNCUTlm?=
 =?utf-8?B?TFNJLy8rSUsxTVNZQjltZ0M0ME5STVB3ZFluSnpwWnF4YmR0WDJrQlpmVVJJ?=
 =?utf-8?B?SVZmbkxKNjNUbGY0U3pvMVhGdXRNTDZ5U2taN3VHcFd6ZlhnMXNTQk5uZUNM?=
 =?utf-8?B?cUE3dy83TWE2WkJyUGZnZHU4bFk5ZzNMSmUwZDVnT3dQYVlaeTl6WEFmclE3?=
 =?utf-8?B?c0pxRnlOc0N4bHVHZnFncW82ekhFV1lhaHhGTDgrZXRKNk4yclkyOEIxMEgy?=
 =?utf-8?B?YldaOGY2dGQ3UUl5NWlXM01IU1dDTHFmM3Zvb2h5bVhXZEJnNVA2R04wYnJB?=
 =?utf-8?B?cjVwRnJCY3hwM0tPbjJFaXZwak5kR0k1RmpEclladGk4aGljb2lHOTV0eXhU?=
 =?utf-8?B?aEtqQlRrR1Q3NHp0NkFUS21lS08zUXlqbk0wR2UrWXZXUUQ3dU83ekF0cFNk?=
 =?utf-8?B?ejEwdlFCcnNWOGlSVlZVU2ZlL0paY3NpQjcwL2M2Q09lZ2ZEdTVnSGJzNm9a?=
 =?utf-8?B?TWZ6cjVvRWRIRFB0Y2MvRzRvOTVtYnRoYnlKMWJmUm9OM0dZaEtvOGowYjZS?=
 =?utf-8?B?b044S3pyUkV0MkFFdFMrTm5hN1phcU00am9VeE4vc1YwcVhFc2E1cFQxbG5v?=
 =?utf-8?B?UUZYdVJjUUcrQlgwZG5NYitRTmJYN093RWZ3d21pUkVaMk9mMXNXdVJQNjEv?=
 =?utf-8?B?RHNZaWpLWDdUYlM2Ti8vWnRtcUtxR0x6V1loNjRacE9UWFlwSWxpeFNvcERy?=
 =?utf-8?B?SzBieVhONVNtRm0zeFVGelNMZmpzUTFya2pwR1Y5dEJ0TGRMdjJJQ1dmSmZL?=
 =?utf-8?B?bG1mbWNJWGxTdktZVGp1THorS3ArMVZPeTVldFJIaiszSE1DeXNZdUxML0JN?=
 =?utf-8?B?REFuZm1PRjVLOVZzZ3l6dTRWa0ZKRlZHREp1cHVua0NIMmlaYVdFUk1Za1ha?=
 =?utf-8?B?T3RVZDdzand1TFFDbzFqdEpPMFV6QTBGREVQaWJrSW0rNmV4cWlVNkt3Y24x?=
 =?utf-8?B?RENreTdSc0NJQ0NNTmZEbmlTN1MrTFhzWUdLUG1MbHY4UnVGRkJnMHVlVlc2?=
 =?utf-8?B?WXFpdjcxS3gwdkMzS2VuTTdsVDBHbml5b0R2cEtxeUlUZ1o3b1NLeVBiRktl?=
 =?utf-8?B?QmxaRUZpVXk2WDhaNmNBRHBDN0tnQXU3bnk1SmNFZVJtbzIxNFBiRTBXWjNO?=
 =?utf-8?B?ajZyUjQ0aFRvdHdscnk1ZHZtNXA0dVkyOHlwTlV2UzZtN1ovcHhaUFlkMGRl?=
 =?utf-8?B?MmNOY3Jaa0QyR0FpVG1UT3lYZVpUaUdWZHVXR25paUVGZUI3TWZZRjNxNHov?=
 =?utf-8?B?VWZ3UytlWlBITU9zczVLOFI1L0xFZ1BxeC96L090M0RULzZBTHJjam9GNkli?=
 =?utf-8?B?eWF3ZHVIdHBHeGljQi9pZStGM1Bpd2hnWllvbXE1TFUvVnRjSkdqc1d2allx?=
 =?utf-8?B?akoyK0s2d1FpK21zc09rY0VXRG5USStJNU9NMmtBZzVFT2phVGxGOUZJNzIz?=
 =?utf-8?B?cjBaUWRrNzJETS9IOVIrK3dpYi9XUXVCem9Pek1weUFGNElWMUlNWDYxR2h5?=
 =?utf-8?B?ZU4ybk9lT2xkbzd4T2VKamNhQzdWZ21xZzlpK0IrbE9wWU1QZmRzUGMyb25M?=
 =?utf-8?B?S0dCOHE1Z2k1TFYxdzdLU1pnTlI2TnRUV3JlVlJvUTQ4clJMSGlocWNMMnRW?=
 =?utf-8?B?c3lLaW5uUklzNG9PU3F4cUFkNndSSVVyVlp4aDE1bFRDQTgyUlFkMTljV2NK?=
 =?utf-8?B?VzNPNUFIeWNtOXl2aEFkTTFZYXVNVnJpNzZVQitEdDFQVTdIcjRqb2t0WUxC?=
 =?utf-8?B?ak05dE10Z2huSTZpNlpSdnpnYmpFRk5lU3ZMOVhYZHVRZXBEWEpzZ2lpSVhu?=
 =?utf-8?B?cWlqWm00RUI5amc1Wm1UYnE3dTE2enFzRnlpNDM3OG5MYWVwbHB4anp4SFBq?=
 =?utf-8?B?aFhXWXVRR0ZUNnY3YTFTMjg5aGJhd3VDbmRSS2tOTTN1cHY1RlRIdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4276.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e8f7fe-6d06-4cfc-d284-08defe83e0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 06:25:49.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H6wXR2IylbFbLHc2IVfyCW5qCwrKkQy0NzOVBIyZn7SW7WhWbWXJUDgLqtPS0FyaqHaQSioBrxMoIxKcBFFQ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7326

SGkgS3Jpc2huYSwNCg0KVGhhbmtzLiBJJ2QgbGlrZSB0byBpbnRyb2R1Y2UgWXUtQ2hlIEhzaWVo
LCB3aG8gd2lsbCBiZSB0YWtpbmcgb3ZlciB0aGUNCmVTUEkgb3duZXJzaGlwIGFuZCB1cHN0cmVh
bWluZyB3b3JrIGZyb20gdGhlIEFTUEVFRCdzIHNpZGUuDQoNCkFzIEknbGwgYmUgbGVhdmluZyBB
U1BFRUQgbmV4dCB3ZWVrLCBZdS1DaGUgd2lsbCBjb250aW51ZSB0aGUgZGlzY3Vzc2lvbg0Kb24g
dGhlIGVTUEkgc3Vic3lzdGVtIGRlc2lnbi4gSSd2ZSBhbHJlYWR5IGJyaWVmZWQgaGltIG9uIHRo
ZSBjdXJyZW50DQpkaXNjdXNzaW9uIGFuZCBkZXNpZ24gY29uc2lkZXJhdGlvbnMuDQoNCll1LUNo
ZSwgcGxlYXNlIHRha2UgaXQgZnJvbSBoZXJlIGZvciB0aGUgdXBjb21pbmcgZGlzY3Vzc2lvbiBh
bmQgcmV2aXNpb25zLg0KDQpUaGFua3MgYWdhaW4gZm9yIGFsbCB0aGUgZGlzY3Vzc2lvbiBhbmQg
Z3VpZGFuY2UuDQoNCkJlc3QgcmVnYXJkcywNCll1biBIc3Vhbi4NCg==
