Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859618DB35;
	Mon, 20 Jul 2026 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510176; cv=fail; b=uC4RtysmysSEfOp8ZgrhwN08wVv3R/9mVe1EjzfZEDfhzt/Zh0YzUwlDJ7G4gyOoXhfHR4B0VYo9w6hLfRXEf8vUDaOaNAgr55bQ9JarKucXkV3ulALMM+W2lVE777TcXeP1T0Eti48DX9o3Vp1tyjfY5DxWKFM+aH+pPihNFW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510176; c=relaxed/simple;
	bh=3Os+2CmkDFbbUZi+71SplRahEom7wRkeM4UGXPoBBps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oLf9KN9Zt0L7ssAKTZ88izArwprm0gZTHiljEBF2E0hsUE+V9uH4QNHPtc/SSNr+7ZUoCX+/rdP7Yoeud4jfhmu29sB0hzMY8tMuN4Aw2MSM3EgDjGI6lXUpJr9b4rmt+hSSVJCmQBKWFZprnRkwe4OuZjWv2JmiSScQ+tPj0fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkh+Z43SlVvGK7xHnf2dWcsm6lDo00H7YT3POgo1vC/Nlk6l5YJPqbL6RxbCaI9D5O1EV5JTOGlMFjuiRvpplw1A3SylGCagDstMnF4wek7j4eUkTHQdk8f6wnnF/0yjkxsT9GCGUAJZoAMIwQhEbsofCZp2ughe2a2X2Gi32bYehw5sKELf7MLDAkxrVjHeHxnk56oKdBm8xUdTggLnG+vppWBWiNTOhF8qhfaHknd1ARVskMAAzeSrNpRgMfr1dZ8S5Ejl1ZEp6o3c5lM6jI4yGxBsuBv1gPdTOAX9HLmNXUAhcKW959C8+yP88BMxTazlpAF0RY4yKzA5pLuGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Os+2CmkDFbbUZi+71SplRahEom7wRkeM4UGXPoBBps=;
 b=i8sYulRbXnVdYUxqnm9C/6o8E3evLxRKk0pd00PALMy1VEBLRscENuzC9Q+q96Q3SVBuz7QR3is+NzIlLsvvWQ+Z4cZCIn52HFLMMSKJmTH+/e0Mr/aiC9YUNw2vnOFMMqSy3pNXGWIQhqFaCXn5EPkJNC2amkg3BoeeAnhq6l4oEPSIlKvaUVAbNmQYK+TVAy9O1IohoHpYOkBBh8c1yAN2mgYrBFzecp3zLMxUJvviWSb4ccHf4lY/K5GYyWT+XcoXvQkdD2USViLmjZE/hE8W8e/roewqkE70wGfT6V9E3nDXZtFMK6C4GiWz035xwr99UbTK7i3fo2/Z2AFD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Mon, 20 Jul
 2026 01:16:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0223.015; Mon, 20 Jul 2026 01:16:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sudip Mukherjee
	<sudip.mukherjee@sifive.com>, Serge Semin <fancer.lancer@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 02/11] spi: dw: update NDF while using enhanced spi
 mode
Thread-Topic: [PATCH v1 02/11] spi: dw: update NDF while using enhanced spi
 mode
Thread-Index: AQHdD2caqlzJOHf8JUKbzJdxM11CtbZ1g40AgAAoVbA=
Date: Mon, 20 Jul 2026 01:16:09 +0000
Message-ID:
 <ZQ4PR01MB120201747536FD82A78329ECF2C32@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
 <20260709055204.138168-3-changhuang.liang@starfivetech.com>
 <ffb4b4ad-b928-4aa3-92ad-ce58ec0523d8@sirena.org.uk>
In-Reply-To: <ffb4b4ad-b928-4aa3-92ad-ce58ec0523d8@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1154:EE_
x-ms-office365-filtering-correlation-id: af2f8a6c-01ca-4aa7-10bb-08dee5fc7b6b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 feBmitiiDwrmqWBLOQjN7EGxHLJHafIf09WftrxG62EuJ2dQ0+4vbYv9Z4MzXItjgQ5pmFZkQajXSOuSnR2eHn6+N9KA6fnyAiS2a89LvhI6Z8oQ/vXbaSTWI9ZODe5ObEpMMTxt6Z5y2Pb5pDXegEjupJNnglTm8TiaJNZj4l9s6RbEOs3xY+k2L+4JAoj2Uz45+QotHeLEhUA29J0Xh8WePfuwyIHGkzWPfO7WhOl/1cpyPv/GAyIL5eItZ7fDQYMMi4vO9IJJXjLBzzgy66QlTgrLPElcnPAePnM9dPfLb561qrzqreASkCnKVIN3/51D9P8ludsHIxT8mKhK54uoVLs2JbohuY2kYD93n1jnZLZjnpQOwR3hpOgKlbR92htstN4+H8DwfkY3wmn9vQRMhSWXSXQShHTZ0r+/PNRqUYTvp1/rOJIEkmC4ghD0fpWepgIlbxFbA8VZ6HSaf++nQbRhMPM5YnQU1xZPAE7FdBaU5SeXNpBatLmHWQ/q7wsClWkcHK7HBIGf9GqAVb7bKtG/eQ6Q2mQ+BSQnUjZWdb7LSeNyKrPUhxdCXRGP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGhONGk1K0wyUWExbVZ0YWxqMDdtQlJJMndxc3EyNXdJK0M5c01JQjdXbGI0?=
 =?utf-8?B?MFl2TlRSSWMrU1JZN0lybHM4UzFhTkJjc1dUV1h2a0xlenNmbEVIeFpBV1F5?=
 =?utf-8?B?QWxLV0F5YUhIVGNSRGZGMnJNL2NFVjRnS2xKb1hmUDE2WlQvMHRjaGJGdGpv?=
 =?utf-8?B?cDRHRWtRWnBXOHdZcms0Z3JZUHlWUXBTc2lueGxkRkM0RlVaNXNVeklMbVVi?=
 =?utf-8?B?VFo2aU1jbWJOYy9hdEdPZENxN295N2N1Q01SM3JNcmlWNjM5WWpYQklxdGpm?=
 =?utf-8?B?eS9KcklLQ05JKzJIN3RQaDJzcVBDSDJlSkhLKzYzZUJMQ1h2Y0Ywbm0vSTAr?=
 =?utf-8?B?c1RTbjkyb29lVE44UGhZRWE3THBDWlZ0T0p2QkN5RjI3amxFaEFXZzJDaVZo?=
 =?utf-8?B?U0JnUHY3bmVQUTJVVHpobXlSZ3JJSVBZbWRESU1WeWlWUGNkelFkRHQrczNa?=
 =?utf-8?B?Vmxad2NkSzRCY3NuVlNRT28zV0Q4OVN3TElmNThEemdsTU1QZ1ZHZ2JVZDRG?=
 =?utf-8?B?RkFQNWlPWXU0VndZSnhvc1RVcnEyRng5RW9SZFBMYk00N3JjNGgwa0FPWnBK?=
 =?utf-8?B?Q09VN1cyZHgzMVdFTm0ycklIWnFNUk44K3h6RmVRZU1ML1FpdUttL0NqRExu?=
 =?utf-8?B?TXhmSGpCUklFc0FpKzRwR0JKVFd3a0JxVlV6Z0RYNUhHd1dON3M5QU9QM1gz?=
 =?utf-8?B?QytjMWVwK1FqYXUvT2t2MXpnMzNoYkVTeDdLSzdNVENXSmNhS1VXZFBOR1JC?=
 =?utf-8?B?dUVVYU1LakR3ek52V2xBbE53TC9HQ3hDVkN6ZEZLTXI5N0kxWEFsR1Jkd1p5?=
 =?utf-8?B?WXdtdS9WbDNlZE9kMGFJaWlUVnhnZUkzZmN5ZE1nZFNjT2Z0bTJiWHNzR2pz?=
 =?utf-8?B?V1kvQnB5bGxwQitwSDBDMGNPeUJxSHd4Q0psaUFNSUt0TlBxSXRORXp3Tk5Y?=
 =?utf-8?B?cDVvajNXT25ON3NZMkJEbjBNRnJ4MHM2R09xck5ZM0t6OGZKeVRTcDZpNTNt?=
 =?utf-8?B?T1MxdVpQNkZ4amo2Zm1VWnVxcnpsYUc2WUZCUDVaY1VIdEwvaldhWVhDR2wr?=
 =?utf-8?B?dFZYSVgzNzZZVDV3ZWlGY0d6NUpkbkpoaDhOaUd3Qm9yWFNBL2Q4dnZVdXdD?=
 =?utf-8?B?OEVwcmpmYzg4cnJMRm5IT1BaeFJ0aU1OVmdaeVdNWnNoZDZMcWV1S1JMdkxG?=
 =?utf-8?B?dHA3RmJOUWtGRnEvRXZSTzgzN0V5YU1DcjZDMVdjZGFpMTFKb21FUWUvT2gz?=
 =?utf-8?B?b3ZyNGNwNm9lU25yY1duN1ZlQUtzQk8yNk5xeXo0eWpkN0ZFeWJuOHQxTFZV?=
 =?utf-8?B?MDI1NUhPOFg5MTkrMWdZY3dmYXpwYzJNSktUOHpGR0ZLa1dPTXhmSkt4UUxX?=
 =?utf-8?B?MklwSHBhNTJtY3kwUnF0bWpWMUZMV0FDeXdpRVp4VUpGcGxjcUlGbUNLb2dP?=
 =?utf-8?B?SzIySzFObVR6cDFiMmNQWWdud1I1T2FLNEpFYjJxbzRNVXRqZG1TUGdDUVFG?=
 =?utf-8?B?Nm1kNyt6emN0dnVqbUN4Nk5hK1JaQU5tSUNiVUtMOWxJMzRUV0YwenJ1TEQw?=
 =?utf-8?B?NU52dDY2YzVVSnRVem5yVjBzUzl5dkZvbjYvcy81dXlzaE5QeDcrOUp3dllD?=
 =?utf-8?B?S2I2OU9SOU5ndjNwdlVnekdVcmhYejRVRThaaGhRTVRZWnVER2s1UDhINGV5?=
 =?utf-8?B?S05wbnhJSXpUZW9FMmVVc05HckVQeHN1QVZrMmVMZHlwSVlCWHc4N1hiK1RK?=
 =?utf-8?B?ekNUV2k3cWFzTURRazUzeW1BK2h5aklGUXE3NWdoT2tCK1psNldtbU1lYnlu?=
 =?utf-8?B?d0p4UEFySUhzRXEwVGtxRjIwTFV1M3ZobEd2d09rSEtQWm1mZkhWU3pXSUd6?=
 =?utf-8?B?V0YvL09SeTBYZDQ5cEpSd0dDMkd5RG8weHdSM3prL0tua1o5Ry9KNEUvcjVF?=
 =?utf-8?B?aE9zMjFpSFVmb1NadCszdTIvYzg2VFUvY3pndjczRzcrdHlZbmNZdWNWTVlT?=
 =?utf-8?B?aWp2RWZBWnFsbnlpZ0FLdzZ2RVFDWUI0d0hzVTFtSzhPZnVEUVdjekJnN0E2?=
 =?utf-8?B?UXBPZUZkbGhhWWFxc0tmZCtwaS9NZHg1L2M5R1hTS0pXUU9tUFZvNENtZkhY?=
 =?utf-8?B?UmpNOTI5ZEl3amVFNGp0K1FIK2JZdnhlMUdmTlZPek5LYktJUHVnbUpYRHFU?=
 =?utf-8?B?amxUc2dhOVk4Y3dSaWYyek1OVnBZcnN3djBJdEhOZGVMUGVQbkpMVFo4MTJt?=
 =?utf-8?B?dVg3MTVJMzRBaGJLV0ZKOHdVNWJnU2FaU3dmZHNub2RocmFUbW9ONWRFN3d1?=
 =?utf-8?B?akE4QnVGWmVWeDBrdVhSTW1hQzdjdkhDK2xSTURWSXFKN1U1MzJpekg2SUtW?=
 =?utf-8?Q?CZts13vobixfriF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: af2f8a6c-01ca-4aa7-10bb-08dee5fc7b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 01:16:09.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4C4+P/9gOpVYwh6Z9uIczqp3b6KoWRBFHJF9DVbEiPQ0WEd4lnIW3PMxXWhfjUpy7oPufgNen6AQer9lozta3CHchcjiaqbjwAc2JOWtehZrnUGMzhnu7yIXFO8H0XUO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1154

SGksIE1hcmsNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IE9uIFdlZCwgSnVsIDA4LCAy
MDI2IGF0IDEwOjUxOjU1UE0gLTA3MDAsIENoYW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+IA0KPiA+
ICsJZWxzZSBpZiAoY2ZnLT50bW9kZSA9PSBEV19TUElfQ1RSTFIwX1RNT0RfVE8gJiYNCj4gPiAr
CQkgZHdzLT5jYXBzICYgRFdfU1BJX0NBUF9FTU9ERSkNCj4gPiArCQlkd193cml0ZWwoZHdzLCBE
V19TUElfQ1RSTFIxLCBjZmctPm5kZik7DQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUgYnVpbGQ6DQo+
IA0KPiAvYnVpbGQvc3RhZ2UvbGludXgvZHJpdmVycy9zcGkvc3BpLWR3LWNvcmUuYzogSW4gZnVu
Y3Rpb24NCj4g4oCYZHdfc3BpX3VwZGF0ZV9jb25maWfigJk6DQo+IC9idWlsZC9zdGFnZS9saW51
eC9kcml2ZXJzL3NwaS9zcGktZHctY29yZS5jOjM1MjozMDogZXJyb3I6DQo+IOKAmERXX1NQSV9D
QVBfRU1PREXigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQg
eW91IG1lYW4NCj4g4oCYRFdfU1BJX0NBUF9ERlMzMuKAmT8NCj4gICAzNTIgfCAgICAgICAgICAg
ICAgICAgIGR3cy0+Y2FwcyAmIERXX1NQSV9DQVBfRU1PREUpDQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBEV19TUElfQ0FQX0RGUzMyDQoNCldpbGwgZml4Lg0KDQpCZXN0
IFJlZ2FyZHMsDQpDaGFuZ2h1YW5nDQo=
