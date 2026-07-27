Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420FCF9E8;
	Mon, 27 Jul 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785123161; cv=fail; b=MRwucfRwsyHvKPNVD0BUSy+IVGMKUZVt/KOFtb8PBppYFKa5IWBjF0Iaq34/sYtRO74lg0GcvaUgvVX9E/zD+yi9bZysS+JOKiVoBJF13PtvfDrB3cax31kUA+lrhJl2WxoqPSQRG3NwBt9Dzd8uqAls/S0+HpvrgjpQWEQEUjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785123161; c=relaxed/simple;
	bh=WLB3McNcP3YOWEtkgGwMS3Kl2i8YSV+RJaOhuwSB2ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZIO+bEY6boOq2SZ9/YkENFF5wCruawpwpE101qBxfdoX1pBeSXYYEpr7EqrQKHl8W28gDXlBIp0ARVe75DKb4OGLr2hU3inrRuwiFRBZDydPSBvEr3g7jSu5g21fmLvMBTVpS6lUFu6Iuk2iDcf3b7BMgf4xeVmcBxptiU/0mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JAg3ZNfw; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JAg3ZNfw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtnidAQLG4duQlomykvrlTPJo0ZLzLMFFrrq/a/kQdk6Gtska4F9DmYVLgcFydT5lEXqa9Fzo81YUlZNFpoEApN7wvUcqwrB11RNcoviVfKnag4HExOFk5Ozf2niibv8XvThK+qpfoqcOj7qbKs5oPR2YbWZzE2lGd+kAIy9ltwLNRkQsxRAF6xrq2Ie3fvLIE2Hnrichsf0uZAFuQolqstjVhYxXk8QF9PhzWWlCetOIkpcCZSdueKaDVamuk2y1uwi8YXC6ZstnLsjBqMCLSL31KdEPSrSp0t6dKc536h69GE4J2HZYelfAeM3zQs0481E6YzTYBQs5ye4PWZU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLB3McNcP3YOWEtkgGwMS3Kl2i8YSV+RJaOhuwSB2ec=;
 b=VhIx0eDa0FrKwrQQAwIb9lWRjMH/qZcJXio3NDgxZl3iYn4yf4hQDNNzVx8E90Nq369a2X7dRJew7lR1vULAQ5ayBiQIHUjVcC7PR5K84lWZBM0/lcAyb0Fa92mgmK898rGQXNKnnDWc/eUhcNlj0ucpSfJtF7CHFmEQ3gy1+uDnw7Adt+LwqQkPgYuFnEZkUwlY42HujDgKfQQgqQcjVMhjNfwK0Q5jAO0fxMDYSRK71OPEGh4jY30Zx7XDX9CfgNPyjYIehjkgM7NDuEq5D9YgzDmiDwSeWSxdQeRT7mG7k+l0HP/FLYsmc0Z4SJn8tBi3UF07l/u6eV4CxRpKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLB3McNcP3YOWEtkgGwMS3Kl2i8YSV+RJaOhuwSB2ec=;
 b=JAg3ZNfwehlq+YCbem62+LA/jyh6Z2YD4mzcOpEVJJ/1jozw3msqDbwn6KKsoa62HpNZcEr0FabOxXWiCDW1NSKbI1RRDyiAaMacO1ktEKnhEarjBkmR0a7prh/CQedLS6VgVNmsO7d8EkGmR8lrEA0SVF+yRlyO8BCu/W2GGN5ogd3fnhM7WiccZJ3L4rTznsfukspIJ4yZOZGIUuAHdAHYujLAz4TCHywXyDnIgWBbyBni4jKJCo6fKwi2L8eG+0K4PEG0+nUnY+i3cNA9RSe2hcxCXULNLNK6aG7KVv6j/eBgfQ1TOs0ZiF8C++wBfQ6Ewou+vLxN/tBYpntsyw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB11628.eurprd04.prod.outlook.com (2603:10a6:10:608::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 03:32:37 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::d57a:2d06:49d5:9861]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::d57a:2d06:49d5:9861%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 03:32:37 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jiawen Liu <1298662399@qq.com>, Han Xu <han.xu@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: nxp-fspi: fix runtime PM cleanup on probe failure
Thread-Topic: [PATCH] spi: nxp-fspi: fix runtime PM cleanup on probe failure
Thread-Index: AQHdHMLm369dSGQDakGgH84FAk7T+baAtfag
Date: Mon, 27 Jul 2026 03:32:37 +0000
Message-ID:
 <AS8PR04MB867677D43B6D5073C88983B290CC2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <tencent_D74B48085D60A729C0BE5FD64A87FAB9A207@qq.com>
In-Reply-To: <tencent_D74B48085D60A729C0BE5FD64A87FAB9A207@qq.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB11628:EE_
x-ms-office365-filtering-correlation-id: ccfe881c-a52b-4b67-70b9-08deeb8fb463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|38070700021|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 4KJT+r4uJ9c36LlTRB1VlVnbBipRsDOR18+oTZYnoAo6xL0T87Yr1jaaeZASapH8bb8jerhJjopOk2R3+LvNgC89DNBpXhtV5PCNWnYeS5+nNosyYYtIc2CUEXMJfyX4hv6jB2GsGKRwLPDBTdup9bYN+aZDuOwgB+5F1stOcXUtpYIyynzLp/69Dzemb3tRCZ1B4gw2wVPRKfg0GiqsauNmlDgASXEivPrLsYzcMFO2vwIcaRN7xjAzZrfzDO0enDRPz2xS0b0WTrPFXBrWKLueQZKxhZvLuE2njrzIgZSZqX87S09seXppH+J1b8DJPvbH7il0WiOeElzm7UzA3xuujeJXsb7LQpgdMDppeGXBM92njeZ+pyjXjySjLdC4qT8ZkOsaN2VF+TptUEP87gnUKfVUmMQaYOttCZhNQYS0ea/r9f8+cTemuxXuNF4oio9DDikyNoMN0R5veW/WRvSw7bqsykX7jtDcJqvKIngVWDjn9e2oN56DgAWFAHWwzCdagq6I6Yls5qS3NClOSY4gyRrPf5DIBOLWRV8yjS+wzofYtGBOVd1DPFGdQ9yBrwXV2v/7/7GOR8/Ia0i3tskC1G5Xhm7TGRGLnIv9kegWDBUcsw3XwNnd/DnUPK/BkLSJfQDVt9YEAu/PYgYFcOOztPMZAGWZC2FVwfc6WLRlgDaToi3nqnDpMhL98NcTE+LnLu0nqKqy6G3G6RDYsVRHbmF0GNcyVfQXPU4DOD4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?aFJwR0ZtNm1jR2wxT0ZpT1lBZUxIdmw5ZGtmQ2hFSVUvUk16TUJmRjMrNnpz?=
 =?gb2312?B?VG9LV0tVcTEzd1pxeVhob3lOSitWMjJRdUdXK2lodkxQQm9lUm9hVGtrMGg0?=
 =?gb2312?B?c1QxcjVHR3I1Q1NoY2l1K3htQVM0UDc0Y3BXWnFXQkxjUFIrYitrT1o4MzRn?=
 =?gb2312?B?THRGbE1aUjdWY0QxUUlBaGcwNHJzZTE1OVA4VGtWQkVXbTdFYXpLSEczazV3?=
 =?gb2312?B?RGo5b3BlZ0xNS3FBanpvSmVwMDkzeTFMZzlRMnlOYndWZ2NaRGJRZFhOZFFJ?=
 =?gb2312?B?dTlkZVNWaDRBM3E5cmtVSkJpU0pMSmNXNHFYYndTNThYOHoxeFhWM1A1K1ha?=
 =?gb2312?B?REFzeWQxWUZaZTJoRytQaU9WUGQ0VS9RdUpMSWZPbzZoMXU2L0VOMVJNM0FK?=
 =?gb2312?B?UHJFbTBJSXQ1Y2Z3aHFPajFEdnUzRXVZN2t3VnRUM0lXRE9ZWnE0LzVGL20y?=
 =?gb2312?B?Q0hMWlFmcjJJK1ljOFlQNDhnU0Z6bnY3SDZqYmNzaEwraGpBZXMzTXNEWWJt?=
 =?gb2312?B?aHdTd2RIVGZiNlhwOUZWRnpteVFkaW1VVXRHUnk3ZEpJaTZJUmlxVWFLWkJQ?=
 =?gb2312?B?bmdlRjZRZ1RWMjNDWGtsSFdVY0h6Y1pDN2Y5WUpzN29ESFo1ZXZmNDZIYzhi?=
 =?gb2312?B?U0pXTVJ3WUhzNVhDajRKWXVDMkx4VlQvMzlUb3J4M0NWOW5yQURnMTl3Nm9R?=
 =?gb2312?B?cVRUR3lyMGxsSEVYMHJBa2U4Nkh6S0YrbERBS09NOXZNWUpHbWp6aC9JdTFZ?=
 =?gb2312?B?N3dvNUU2cm13ak1oM2NObUdVcEJrSzNhQ2psVFBITEhSWXp2K3dWKzVwMkNK?=
 =?gb2312?B?RU1ERHlJTS8xUVdxdjArNkNWNVgwRCt6Z210Q2J0a0wwOE1yT1RrclRsMWRl?=
 =?gb2312?B?dkpkRWNyZWFlL3BpNTd2QXBMNzdLdGNyeTFrVW5nb1pqRERsQWdFREw0TEFt?=
 =?gb2312?B?N2RidngxUThRa29SSTVWUEUrQkJWc0wwSzJ3ZVNaV0RHeVp1Q2VtbDN3NEx3?=
 =?gb2312?B?Y2pWTTFRMzdoeC83ZHh1akd1bkduR2szMWgvYWk1MzkyaHZtQmxpS0laQVFW?=
 =?gb2312?B?alZ5RmtwUFZOeXIxbWNMbG04bmFEeUthT1RSRDg4UTFMU1lscmhUdStBM0tX?=
 =?gb2312?B?dEJNREpTRnArOHdPOERJUlRBTkUydTZteWcrd2hWSGhaM1FKaEpmRzlZUVVx?=
 =?gb2312?B?VjdSTVNCdnVGY1lvcFNpVWtuMUJZU1pqam41V1psN0N0eElLMlBZU3RJNVBT?=
 =?gb2312?B?UUNkd2YyelVVL3J3ZkFtTTMyZzBVeFZXUUtCVTV2UXpkbW5UbzRRZ2VDUlZp?=
 =?gb2312?B?ZTFwa0FCQ0VjdEM3NlhzMWwwTVduVGhaTW5NbTh0dmhXR0tGN1ZTakl3Z1pC?=
 =?gb2312?B?ejNpSGM0UzRwMXphMFEwVGJoak5URmZnUmxuUXRiWGYwa0pWd0N1K2cyMjRC?=
 =?gb2312?B?L25SanJPL2dwcytRZzZaL0lJUk02ckw4bGYrcE0zcDg2aEZRNldUaEF5Q1lh?=
 =?gb2312?B?MnZZVzhlRjY3eExwZ1RZMnByNGVtQWxpcStucDlMMWxRV2lLekd4Z3d2cWpi?=
 =?gb2312?B?YXhpUlhxYTVaV0Rxb3kzUWN5T2RPVGh2WWo0YXE1U1FVKzc3UTBDYlBwWXdL?=
 =?gb2312?B?MW5wWVh0aVgwbW5UMFZ5Q2hqZEJ2WCtlVkFxb1pEM0lOZ3p0NmxPb1V6VkZq?=
 =?gb2312?B?WU5CeDdFNDNCcHZ6MFlqOUlwQ2FJTVRHRlJqdUZxbTJ3YzZFNDhHaVJQeXRL?=
 =?gb2312?B?cUtDSHJrTWlkM0tiRkhEQU9IZXNEVGVIVm9mbnFBT0Z2WkdpWktUZmx2SWQw?=
 =?gb2312?B?bkpDbFAzV2hhOEFIVVZZc2NlTks2U0tsZGhORmt1OEJOVVhHZ2o0cU1kM1hO?=
 =?gb2312?B?ZTl2djFWTWwyZnFjWXM3c2NyRE8rOFBwem5lOWprZkZpeDRycmNMRFFpNVlT?=
 =?gb2312?B?c2luZlJ6eWcyNjZrR3pEOGRCampCT3ZWOFNScjYzSnNGTk1BOHltTnBpc0pS?=
 =?gb2312?B?eTVBMDRXMHpuOElXdHplWFh2dVBNWFZpemhiTGQwZGtqZG5Lc0F2aUwxc09B?=
 =?gb2312?B?UjA3Wnp0dnFVVE5oUjgrcEtFU0lMT0FkbHNMZTY3dE1UTVdzWHlZVDIzQjk2?=
 =?gb2312?B?SkFMb3pVcFY5MnlpS3BaS210a1pkMmdzYW9WK3ZlcE1kanUydjRFKzRpUk5D?=
 =?gb2312?B?bUVIbHVWWXozUzRsOFdEVk14VGJkRVNWWGRpZ1E4anA1b1RSdUR0cVk1ZW10?=
 =?gb2312?B?eCtJTksyUzZWQzhuMTVVL0kyTXFUTE9yZElFMHF5eUQzdW91VHJBa2hwQ1lm?=
 =?gb2312?Q?10Z4xVW5F3I3kLAzWH?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfe881c-a52b-4b67-70b9-08deeb8fb463
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 03:32:37.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5StRq2ecmWKolDH5MUBDzZ+Xq7cFotvaNmPh8U5Zl5LlPAbF22LD8X+OBJTmmYqtrdrnm6I3195I4ITVugyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11628

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaWF3ZW4gTGl1IDwxMjk4NjYy
Mzk5QHFxLmNvbT4NCj4gU2VudDogMjAyNsTqN9TCMjbI1SAxMzo1Mg0KPiBUbzogSGFuIFh1IDxo
YW4ueHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFlvZ2VzaA0K
PiBHYXVyIDx5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2Vy
bmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYXdlbiBMaXUgPDEyOTg2
NjIzOTlAcXEuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNwaTogbnhwLWZzcGk6IGZpeCBydW50
aW1lIFBNIGNsZWFudXAgb24gcHJvYmUgZmFpbHVyZQ0KPiANCj4gbnhwX2ZzcGlfcHJvYmUoKSBl
bmFibGVzIHJ1bnRpbWUgUE0gYmVmb3JlIGNhbGxpbmcgcG1fcnVudGltZV9nZXRfc3luYygpDQo+
IHRvIGJyaW5nIHRoZSBjb250cm9sbGVyIGNsb2NrIG9uIGZvciByZWdpc3RlciBpbml0aWFsaXph
dGlvbi4NCj4gDQo+IElmIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBmYWlscywgdGhlIGZ1bmN0aW9u
IGN1cnJlbnRseSByZXR1cm5zIGltbWVkaWF0ZWx5Lg0KPiBUaGF0IGxlYXZlcyBydW50aW1lIFBN
IGVuYWJsZWQgYW5kIGxlYXZlcyB0aGUgdXNhZ2UgY291bnRlciBpbmNyZW1lbnRlZC4NCj4gQ2xl
YW4gdXAgdGhlIGZhaWxlZCBnZXQgd2l0aCBwbV9ydW50aW1lX3B1dF9ub2lkbGUoKSBhbmQgZGlz
YWJsZSBydW50aW1lDQo+IFBNIGJlZm9yZSByZXR1cm5pbmcgdGhlIGVycm9yLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSmlhd2VuIExpdSA8MTI5ODY2MjM5OUBxcS5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9zcGkvc3BpLW54cC1mc3BpLmMgfCA5ICsrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc3BpL3NwaS1ueHAtZnNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgaW5kZXgN
Cj4gMWUzNmFlMDg0ZGQ4Li5jNjAzN2YzMjA5YzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3Bp
L3NwaS1ueHAtZnNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+IEBA
IC0xMzUyLDcgKzEzNTIsNyBAQCBzdGF0aWMgaW50IG54cF9mc3BpX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJLyogZW5hYmxlIGNsb2NrICovDQo+ICAJcmV0ID0g
cG1fcnVudGltZV9nZXRfc3luYyhmLT5kZXYpOw0KPiAgCWlmIChyZXQgPCAwKQ0KPiAtCQlyZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBlbmFibGUgY2xvY2siKTsNCj4g
KwkJZ290byBlcnJfcG1fcnVudGltZTsNCg0KSGkgSmlhd2VuLA0KDQpUaGFua3MgZm9yIHlvdXIg
cGF0Y2ghIFRvIHNpbXBsaWZ5IGVycm9yIGhhbmRsaW5nLCBJIHByZWZlciB0byB1c2UgZGV2bV9w
bV9ydW50aW1lX2VuYWJsZSgpIGluc3RlYWQsIGFuZCB1c2UgbmV3IEFQSSBQTV9SVU5USU1FX0FD
UVVJUkVfQVVUT1NVU1BFTkQoZGV2LCBwbSkgdG8gaGFuZGxlIHRoZSBQTSBnZXQgYW5kIGF1dG8g
cHV0IGNhc2UsIHlvdSBjYW4gcmVmZXIgdG8gc3BpLW54cC14c3BpLmMuDQoNCg0KUmVnYXJkcw0K
SGFpYm8gQ2hlbg0KPiANCj4gIAkvKiBDbGVhciBwb3RlbnRpYWwgaW50ZXJydXB0cyAqLw0KPiAg
CXJlZyA9IGZzcGlfcmVhZGwoZiwgZi0+aW9iYXNlICsgRlNQSV9JTlRSKTsgQEAgLTEzODksNiAr
MTM4OSwxMyBAQA0KPiBzdGF0aWMgaW50IG54cF9mc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiAgCXJldHVybiBkZXZtX3NwaV9y
ZWdpc3Rlcl9jb250cm9sbGVyKCZwZGV2LT5kZXYsIGN0bHIpOw0KPiArDQo+ICtlcnJfcG1fcnVu
dGltZToNCj4gKwlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsNCj4gKwlwbV9ydW50aW1lX2Rv
bnRfdXNlX2F1dG9zdXNwZW5kKGRldik7DQo+ICsJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQo+
ICsNCj4gKwlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBlbmFibGUg
Y2xvY2siKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IG54cF9mc3BpX3J1bnRpbWVfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
