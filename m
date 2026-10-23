Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792749285;
	b=i8JZ1L0cxuQyAXQz4lABcGO8jcgILw694beQSpZj4F6NBYv65HORjUp3RDFJo+iE8Ywn
	 Nxv3WIuj02Rpu7qnBEzuDG7Rfd1/Z0bxE1vZpqzfXMw7kAkGYoVrYkj+H0TvlDvm0kVj4
	 FKurt0f2dsSnJz4zY0TAp0RMa8TlmRiy6tKfn69yPNcanarCTQ8e0qQusuIAyVvuVPw5k
	 K5Vqr7THPEvRptl+zF/uPbvkLLncOkNddulocNFz3pCiy1l4fIn7O/SSt71HV+WU5xvvA
	 UvfZSJJFovlCcrlpdnBO3Q4/M+JZNaDMW3wFcE4yXwLo7s09sUKaerwPnK3c2LQMKQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749285;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7Q7o7EtLlDBqBJdxrmMJVjJNYp23GvILaNiiQs8PyS0=;
	b=2S3bNJ2fsvAbzF4WUOXAMjJn2DmE4OO86/24aBUq7zoKidiwNkk0OtbBJEVZNeolxTWR
	 mIuj1AQMSnyzRbeQq4GCnZhKJ5G3DO57OHEybgfzxxqyUEmBifvXqW7fYcRlza0nZxihO
	 uC1Gar1t3tI9BNISLZd1ezY137zOt7FaekvqtRPOMTcPG4nFjRlaeRlNLJQLgaHM2QdYo
	 xqMPww9soEnGWIprsT/0Yz6UhA0Uh/EocdYCWYfIG4WOHYEJE84ThS9e99htAkQ0Hk5Ur
	 fM4QVh74WeQto+9KBjoFeHRynpD2249khUHFduuwnJWxbfkTWR9oFn5V+LTuDqRQ+1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=starfivetech.com;
	spf=pass smtp.mailfrom=starfivetech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.119
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094E606A31A;
	Fri, 23 Oct 2026 09:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3094E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKanLRj62MbAgdP8S21NPBeH2LRyJbNVGsZEzHwpvDLwaTlWJRIFXHbeSDrzzz0qPOaXaHywC5hgVZ+LwDJ7xSv57/Vn6EiA3M2e5pYssAITM2GDY6IlqrpZPTyYS44EsleYL+zusYjoq145FoFR4k/me6pNzi9iQiYDoi/5IljcUWjmFzd5HxbZ7wY8VhXBiznuGPhen0nltRAhplproY+7D2e69Dqhsca8H/22DFq7oRpUl4+6x4Y1f9vsKl9ihOye4XCgW1oExYkRGcnsm7QYVz/t56nkoPAxXDLQMPgz2HSuCVwruLvudlD3tILhzeBg7RaZ7xc9d3ZWv/WbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Q7o7EtLlDBqBJdxrmMJVjJNYp23GvILaNiiQs8PyS0=;
 b=g2kWY1HyQKup8A6LzpXtrMPesjp8Y1uIxEi+8hmr0lnkolyBtGONV3YqN0X+EDkajE+Pbk91nbvE4WmGqxOxe1+PQfPki3CbM6XvjOpQQOE7PSX2xku6Dti5TzH7uSLh2YTmLssUeEFsw5hzLAYG5ll7bgzw2K1YXLjsCjgspNKBannQqbTlr08OGRCtJxxY9NZ2xhjSuim6knDKia23XMredFipoQrtK8baNcvHFqkJD6zb08Ignio56hABTctu3jEitFHEgF221ZOg5TJiauSnV4r2GA9VgN7qCnAVtQjvyJzb/2CaEYrKFCWQUiaDFgX8kSR++DiPtp4RMyHf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1265.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:54:31 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0546.017; Fri, 23 Oct 2026 09:54:31 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>, Mark Brown
	<broonie@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
Thread-Topic: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
Thread-Index: AQHdYg/J0rdlsgMyL0SIJwAb/cmFb7cJX+ZJgAGBvHCAAAKjuoAAAJpg
Date: Fri, 23 Oct 2026 09:54:31 +0000
Message-ID:
 <ZQ4PR01MB1202E9F126454968952AC6BAF2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-2-changhuang.liang@starfivetech.com>
	<87bj8mqaof.fsf@bootlin.com>
	<ZQ4PR01MB1202C6B2531173B2D395C619F2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <877bj8pwvz.fsf@bootlin.com>
In-Reply-To: <877bj8pwvz.fsf@bootlin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1265:EE_
x-ms-office365-filtering-correlation-id: 3912b713-2929-4346-8946-08df30eba299
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|38070700021|4143699003|56012099006|261022075727099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 18SS4Et0NqlrrBgbSsnUqcZutATM/6lL1fw052POmJpzyLk773Y3FqAEt+XupeGnHkqA6yUCrjyprw9Lt4HyzWSj5XPlAFzkCDT9jHYmcp6CQvuNaRIRLGyj08MWR2cq9tHC6SGLXzvkYoiLQiuEXTeIOiHm0XyIrsdxEOj7SOguOGTZuQe6ITbX9ZfcS+EB1++M03Lt2kVNNMPcFeWrPt0Kq5QMO6yF6UkDcyfp+QoHWeFE4Mm96A6E/w64folmQf089kzDrCrvrk/kwz6a4c9gTvINuRhvAd/8gAtccebBZRWCWVWhUfxk7xwqtz9/Gp6tApOb4KYqpfvuxzs1jCjCYzawB5vvRrzhf5eSZLiDhN0UB/+vcxBF9li93zW59yr3LwRev+dy264cni7Wt7xrN5URWkKiLRVPvVwQ+5V+3pqmjCUPx22cbd3ZYYlY6jSnYNyXntfV1vIFCQwB+WVYBiGJrpzmgqRiUmkSF5vYTYS+PKBNZu35MVymUmFyHltLAn0Ob2N5ClYQ2WvUS+l4hiIa55vcw6itEw6cp0rVuuz4loe3Hc2UosikNFiZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(56012099006)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YU5CcE1hZ3ZpZGsrdG9nUUNXdjk2MkVPYm1IbUlvY2VQajRiUFN5bjlmTEJL?=
 =?utf-8?B?RDVMTkRlZlhaVVJCMndzTkdRWkRnaWtXNVo4NXJPdDlpWVl1S1FqOVJ3Tk9h?=
 =?utf-8?B?ZGRZOEFhTzRWTmRJR2R5NUNDc0hnWmdNQmR6ZzBPbkZFUzk5U3lBRGV5aHlC?=
 =?utf-8?B?Qmc4Z0gyKzBQc05pRXlib2JUc2RpbjNFMEhvUDdoRHcrWVUxWld4YUs5c3Mw?=
 =?utf-8?B?SGZHUXkyaUlBc2J1bFpRdjNSM2VuRHdpZkY2N0ZpblQvbXExNzhOdEV5Mm8z?=
 =?utf-8?B?Y1pXaERPUXgrcmxIb1IrT2hJUGdNNEIrVXVkMkhhU0JORWxiaWVXaVBmRkd4?=
 =?utf-8?B?dUNSSWh4WEFva084ZjRWTWR3cndZMUwvbDJOajg1UWIySmhLdHlSSW1ZSlJy?=
 =?utf-8?B?SGpEc3Njekt6RlFmZTFnMUxsdFhEck16UFFCblpXK1BIV01RVnhkMUdqY1o5?=
 =?utf-8?B?N3ZCZ3p2ZnN3N1RCU3hWZFgrOHNwaVVBMk1wMUhrSzBPWmJPNEFId3RoVUoy?=
 =?utf-8?B?TWd6K2VORURTakE5TWNPQ09hZ3FzWW44d1VvYXdBRG1nZi9jajd5S2JJMVgv?=
 =?utf-8?B?UStmRzI1MGFBQUdIK1RIY2tuZTFyTUo3YmxYUzZWWVNucXFTeGJvR2F0SGpS?=
 =?utf-8?B?UEs3QWF2YzJUS0VhWFZnQ2NSM2lVdm4zNE0rK3lYQjdSWW5Xc3Z2UUVtV050?=
 =?utf-8?B?S1phZlRNNitlbUhkN1RUR3p4YTNWSmdSRjRMZjRwT1M3dllEcGwzSEZ6QTZj?=
 =?utf-8?B?a2QyUVlGaWluUlpyZ29nZ1NZakVxUVAxd3BBU3ZZVDJ6T3ZwVXBGbzhkMWta?=
 =?utf-8?B?ODQ3d0lGMVM5Rk4vaVJxY2xRc082UFc3dVRYY2FERHBDR1FlN0I0V1RuMmFJ?=
 =?utf-8?B?TGtVOTZIbUZvZTl2U1J4aEJDNm9qMVUvRTBMT0lZdHpXbG91cUU5RHdmMkdT?=
 =?utf-8?B?bnVsVG1BZlQwdmo0RktKWmJXMm5EY0xSVTVDSnJrNExIN05LNWVTSDM4Qlo2?=
 =?utf-8?B?SnNKQXVjNGJOYUlsR3hMbmtTaGhpVkl2NTBiMWgzeXh1UzJhVWtSUzNrNlFN?=
 =?utf-8?B?OVlheWZOWTdKWnBLcmpJc3N6VEI1YUlycEdhbEsyakdUWXFTY2x5L04vcTd2?=
 =?utf-8?B?R3RZU2xwK2VSek1UWHZzaUR1ZElzT045eXlQOHlTa2pKajgrVStzbzJ5djhS?=
 =?utf-8?B?WWd0U25zL1hiejZDbGI0OEwxQk04Q1pCeURDbmZWV2VvTEFwcHQ1N2o1TU43?=
 =?utf-8?B?Q3RpVFFndUJqNjJ5cXFiWDF5QUVKaSs0UE5RQmRVR1huR0lqaWorOUJTUUFJ?=
 =?utf-8?B?NUlhME5XajNaYUJnbCt4bFBySUJsSmJJQWVST2VrK3hFTXpJNzRYazltSkNR?=
 =?utf-8?B?UjhNUUxjQXFFenlqODR1dG56dzFWRnpKTHM3MEEvc3N5Mmlld3Jrb1BqOFpE?=
 =?utf-8?B?LzFoSWtERlRLY2MrNkF0bVd2S3k4bGFZV2gxUGZjcUpTVjBmaWs4Q3k5dlY2?=
 =?utf-8?B?NDVjU1ErNHJIREkraDhsYlE4eEFXelVDWGwxSDY2QTR6eGZIMXp4bEtFYlJW?=
 =?utf-8?B?OUduYnQxUlNHUU5YS05hdWExWkJNMFlhNkZmN2NDLy9Za1J0ME5oYk4ybW5C?=
 =?utf-8?B?Q3JLd2JFYVZiL29jUngrSWw4VTR1WmI1YnVWWW02azB4U2paRVc3ZFNTT240?=
 =?utf-8?B?TzJUdUZlV0lNc2pnQ2FCKzNMVWFiYlA2bjErYnJWVlFPK0EwTjQvK3gvS1hu?=
 =?utf-8?B?clYrcmt5YzdMVFkyc041aGc1d2VSM2RIaEJGTm4rOTh3M3VTb1ZhUmVtSVMv?=
 =?utf-8?B?cS96MU5OQmZNN1JTUG5xYXVkK0hTNEpGeDN0V1VwaWczbzJWYUlaQm5idjZO?=
 =?utf-8?B?OG1lZ3hMZXY0YzBINGsrT21ISHl0QlZFVzE5UVd3bDZSVVBWWitCbmhRU245?=
 =?utf-8?B?QzdHclhHd3FnZmZURGkrMlRIK3ArdUs3TVorS0gwdlRCN1VBbnVNY0NjY0Ji?=
 =?utf-8?B?U1FBMHg3V3ZsOTkwZ3VseHhhNjFVNE42QzlhNURNdXF5YzFKKzJadmtFVWhi?=
 =?utf-8?B?dU94MU5mMlVCTU5FTDIrZ3Jva3B6bnhkdzVOQjY2VHBOTXlNNml1K1RzMll3?=
 =?utf-8?B?SEIvSW9iYm11ZlJaUStkTUwwRHhvN1pEMWNTL0hUcHBGek9FaDBNZm1BOGJk?=
 =?utf-8?B?YjhJR3Zrd2oyZUpxNmxjR1dST0gxakdnclZNYWFrMVZpQU1vdlRPaUpxTDhS?=
 =?utf-8?B?OWdVTHpET21JOHBDMDFEQm4wVitqdzdZUytjZnYzKzUydDJSMzNGdDdwaUhS?=
 =?utf-8?B?UDZqckExUGw1UmpNMlRScTE0eHdIS0YvaEpHNDkySGlLM0xEMjAvdzJibTUx?=
 =?utf-8?Q?d7AXy4Qz+i84ZBGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3912b713-2929-4346-8946-08df30eba299
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 09:54:31.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQzrNtuyQCdEpIieQw/OcCfpAC5lbK6ZzRm+FTSqsaQcDAbZwKFgSjVBaQFSIDFBDpiWv14McPmMHfl5LFVewxJhdvoPA9yIki6JmiAaZ1a5cCeDHvoidGy04O7hSE65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1265

SGkgLCBNaXF1ZWwNCg0KPiA+PiA+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1kdy1jb3JlLmMNCj4g
Pj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktZHctY29yZS5jDQo+ID4+ID4gQEAgLTQ2LDYgKzQ2
LDggQEAgc3RydWN0IGR3X3NwaV9lbmhfY2ZnIHsNCj4gPj4gPiAgCXU4IGluc3RfbDsNCj4gPj4g
PiAgCXU4IGFkZHJfbDsNCj4gPj4gPiAgCXU4IHRyYW5zX3Q7DQo+ID4+ID4gKwlib29sIGluc3Rf
ZGRyOw0KPiA+PiA+ICsJYm9vbCBzcGlfZGRyOw0KPiA+Pg0KPiA+PiBJZiBJIHVuZGVyc3RhbmQg
dGhpcyBjb3JyZWN0bHksIHNwaV9kZHIgaXMgcXVpdGUgYSBiYWQgbmFtZSBiZWNhdXNlDQo+ID4+
IGl0IG1lYW5zIGFkZHJlc3MgYW5kIGR1bW15IGFuZCBkYXRhIGRkciAoYnV0IG5vdCBpbnN0ciku
IENhbiB5b3UgdHJ5DQo+ID4+IHRvIGNvbWUgdXAgd2l0aCBhIGJldHRlciBuYW1lIGZvciB0aGlz
IHZhcmlhYmxlPw0KPiA+DQo+ID4gc3BpX2RkciBpcyBuYW1lZCBleGFjdGx5IHRoYXQgd2F5IG9u
IHRoZSByZWdpc3RlciBmaWVsZC4gUGVyaGFwcyBJDQo+ID4gd29uJ3QgY2hhbmdlIHRoaXMgdmFy
aWFibGUgbmFtZSwgYW5kIGp1c3QgYWRkIHNvbWUgY29tbWVudHMgdG8gdGhpcw0KPiA+IHZhcmlh
Ymxl4oCUd2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBUaGlzIGlzIGEgYm9vbGVhbiwgbm90IGEg
cmVnaXN0ZXIgYml0IGZpZWxkLiBQbGVhc2UgdXNlIGEgbmFtZSB0aGF0IG1ha2VzIHNlbnNlDQo+
IGhlcmUuIFRoaXMgaXMgdGhlIHBhcnQgb2YgdGhlIHNvZnR3YXJlIHRoYXQgcGVvcGxlIG11c3Qg
dW5kZXJzdGFuZGluZyB3aXRob3V0DQo+IGRlZXAgaGFyZHdhcmUga25vd2xlZ2UuIFlvdSBjYW4g
a2VlcCB0aGUgaGFyZHdhcmUgbmFtZSBmb3IgbmFtaW5nIHRoZQ0KPiBiaXRmaWVsZCBvcGVyYXRp
b24gaWYgdGhhdCdzIHJlbGV2YW50IHRob3VnaC4NCg0KT0suIFdpbGwgdXBkYXRlLg0KDQo+IA0K
PiA+PiBBbHNvLCBpZiBteSBhYm92ZSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIHlvdSBtdXN0
IHByb3ZpZGUgYQ0KPiA+PiBzdXBwb3J0c19vcCgpIGNhbGxiYWNrIHdoaWNoIHdvdWxkIHJlZnVz
ZSBhbnkgeFMteFMteEQgYnV0IGFsbG93DQo+ID4+IHhELXhELXhEIGFuZCB4Uy14RC1EIG1vZGVz
Lg0KPiA+DQo+ID4gT0ssIEknbGwgYWRkIHNvbWUgZmlsdGVyIGNvbmRpdGlvbnMuDQoNCkJlc3Qg
UmVnYXJkcywNCkNoYW5naHVhbmcNCg==
