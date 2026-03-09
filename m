Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB723536B;
	Mon,  9 Mar 2026 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023009; cv=fail; b=gXVi/1SJhxzhtGQ4DOt45ruT7CeWfaNZTNChfkQHEgp0XBlwVkvmopE8ZjmavYQ05+0rK3KxAG4cuIf13mPmlGhpE0ZggIHRk+WVpZpA8FjcSfCWiSrtmJPa9voQBfY9SqgAbkI/qmpbkA3fK+HmW48Tgqd6JBzDR4m36sLUDjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023009; c=relaxed/simple;
	bh=1CVgoRwXugByHaYuGe8EA/98GAZM0qgKjdKVP9mv48Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rU7r8DjY5kcI0y/CNGYq8ZOnoPXzH3GnAnzmnIHGpEUuBzoYpwYaYZ5xgfrgCtwzfy4PNITj2xImTju28DVfxtZAdlVsPRwHhNlXWdD+ZyZhIV7S4qawJ17yPQHZiH3ixilDgU6qTsJMux1dTGN2GDd3KFE0xfzJ/D/j4YPln9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IYkg10+q; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IYkg10+q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6dyvFWDbvcdQDQ1S8WCM8nhKRdZyMC2Zy637KwYs3+RyAGStk8SeVueUxT8sNACa9ESp9By5i5PgFCCmmF3UerT/dYbGnwzwjFRYJfip2gD93dEAKf1te8jM5YU4IaoGRZxM/BAhBT9yakslkaLzhe3Uc4mFeWUUudZcLmDDfMPARk8MUC3glflKirnZWVUaVuR6NozRzS9rpDapS54NOn5TDawnSUouTclIFhZSmv2RwoLIhPxhsxOLzmZjjU0u7yK5o9Lvzyn1z1a4lvdatcDrfGuDGl6/jbEGXVQ2a4gGYE/qxSf1xMcWzBvFSmbhf5TLN0FAT/6QsrFrTFDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CVgoRwXugByHaYuGe8EA/98GAZM0qgKjdKVP9mv48Q=;
 b=Byrru9llZ+NqA+lGFOazCrd6GKAbv6WYPrCYGD+seiFyEFq624hqFBrtN/aok+0qMWqEInG3xuxAGPTRGcRmEfPE/iMmqxqF2lZkXvILtER/xx0hIZAMqllBSowQAkuoXmy5PsGHiWjyrf4fjEfnW0F5AszIUURBFb+cd6yoU6sn5lMa9S78PQz5RYUsL2ci2ZgrFdWerwExfRZsn0mjq76L/cgJrIgReQkAaz1BGNMxtad60HlNjZGNiNTM733AFXj8JoG3kkPNG81KVspuwgXQD5+M5jdRNSohotPHGJuJrPqmQYDDaeX1S485/+eRZsWbmIjvl+tRjX/YWFfcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CVgoRwXugByHaYuGe8EA/98GAZM0qgKjdKVP9mv48Q=;
 b=IYkg10+qjFQoWe2p0Jk4nMRsL4jnTBLlxIXLW7GCu2E5KmBL3eEfcIhMPn+2nEmpGW+XDRuh2Stu3eEE76pr8MAsbd1LisqMVBCILgXVJpHdbsvmmXQHMPOq/2K7UhJ4dN7/updUoWuIaoU73e8CAVM/zqIiaSpJlYidhNAk+13a23baWSG8trVpxCDpf0ooH+PwTpoeKUMV2xB7wIX48avSbcz7Q4JBhuXyXh7t4Nrauz8bQsaVm9pwLP/o2jlGN/d+VRrWJ5bCpiErMVRiTjRcBIBywrgBvj+uwisoHeg2T0A9uzE1DEJoNx779RkdYbmJ7DM07gImiy4yPqzoVg==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by AM0PR04MB11965.eurprd04.prod.outlook.com
 (2603:10a6:20b:700::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Mon, 9 Mar
 2026 02:23:25 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 02:23:25 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>, Han Xu <han.xu@nxp.com>, Mark Brown
	<broonie@kernel.org>, Frank Li <frank.li@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>, Frieder Schrempf
	<frieder.schrempf@kontron.de>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] spi: fsl-qspi: Use reinit_completion() for
 repeated operations
Thread-Topic: [PATCH v2 3/3] spi: fsl-qspi: Use reinit_completion() for
 repeated operations
Thread-Index: AQHcq9UhISa2z2emfkGrKW4Kd+32CbWlf6xA
Date: Mon, 9 Mar 2026 02:23:25 +0000
Message-ID:
 <GV2PR04MB122728CFDC8EFC412F06A0EA79079A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
 <20260304-spi-nxp-v2-3-cd7d7726a27e@gmail.com>
In-Reply-To: <20260304-spi-nxp-v2-3-cd7d7726a27e@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|AM0PR04MB11965:EE_
x-ms-office365-filtering-correlation-id: a3adc090-a160-4e57-416a-08de7d82d7b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 xtgdqGE2Q2bXzvzYI2GmPC7BEAG190iTc7EuQax0AVFu6Xeq68TYIe2sUIoDY+3GTsg7Li2FuUzhR5d8lamhqHQ/gpd+8gKVBbCjZHZwMJzc16hUH1UkHTcxZ5TpHgZ7LKXnNW2h65LcL4PY65jeJIz5FjT8F/256J8G/EHLcTut+oSJgAkIcbZfeJpgtz9UzfNQtPhEw1Yh1Oo2ZncxssD3yuU40UHHUQiOGAKxLd1PP7RrRzQ7A6m9PoQ9clK9/N+FIx5gu2mcone9KkQxlCxSWke2neTLJzorrk4albOY3wNFpMj35QWOKQWbqvbw++HuroJHQ4B+bH3j1XZZz5EkB1u7dHl999c4HfhWOBPI/hbaJXyXjyCvSZiU0ltsbRf7zuLs+WFprsSGMdcJxg0e+4uPo/J8fiwF6n0bIce1TaiY5GqwAQAxHwSOOiM9HEflCSagZFBGcXTT+ZJRKx9p6OomiT6ByR+K4fbbiS2RFEHgYWes4bjyLzoUAk7Dm03qozHQinB+Ch8nka0Sj5HHFMTPjtjqTsVDT29TCaFxwew6KYcCbH9ztDUYnGcpE2L1GanBTQymeysf/3/eo+n3MmN4IQtal+/v2dRkS6QVtfH9WfrLZWcsDSlGicWvQd7qcsKaIaPmToM2hSV6RDdAuXhzIMDwGlKslbjIyRBm+ExH0f7KeTxTQ5fxZ0v+3Q2x3TMYfeWbk7JnZMexBEFeijY4do0xi3WXtd+AG+lSt0hLUBGwge1xs7tdxLwrkirXEoM+ZFQ+acIDvvt/IH33ClG6TPPEHJ8p2BYzugU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjhqaVZRQ0VBc2VjZTkzaGdpeUdXWWVzU0pNMUdGSFlwcnRkUkM3bnRxSlFr?=
 =?utf-8?B?Z2srTmJYUzhzNCszTnY2U240OGtPdjB3UytWUVNaNDd4QU1obmQ3b3FVUG5D?=
 =?utf-8?B?b0tTR1JWSGVIeUQ1dm1RS3NROFA5djhlMmNzbjJWblNmQlFDcmNxZnpVOFIx?=
 =?utf-8?B?ajcyVGpHK2hxK21ZQksxZ2ZNV2hsNGNlanJSTWtUajFsUGNsQmhuMHh2Ri9m?=
 =?utf-8?B?S1ZVZ3lyQ05jekdPRkdsYmxMeFVhdU83YWw2b0lJQkZnSVlxbkhZOGd6dlU4?=
 =?utf-8?B?cHNiUHFNU0RBeGNwSWN6WU03V0lMdTB1bmlWSjlpV1EyelZZWXVnVlZScjMy?=
 =?utf-8?B?RXQ1NGJWWVZObGhuQ0o0WmxkaExkVkxOaWI1bXhyMTA3ZmVBZzVSN01hVVEv?=
 =?utf-8?B?NVFPaTJDNml0UkVDcWdLTSs3R3Z4cjJ1MkREMTdXbnpPZ0JEYWpRb2x2SEty?=
 =?utf-8?B?a1NPdUt6U2gxT3lYNnM2WVNWNG04eGlCNDhjbVROaXhlWFU3TWJWUGlGbG9J?=
 =?utf-8?B?Z0xzWUFUc0EyaStzSlNOa1BRa3B2MXF5L3V2dUw4WFZreURWT3pLWHhXc3JT?=
 =?utf-8?B?dnU5dUo5alVuQTRVMEVrZkl2TmNXd252eUJ1MEhycFMvWE9LbG9iVjRQMTVL?=
 =?utf-8?B?L2t6NW1yK051MTFmRHk3SXNRVm8vTHZVSVRlMWtWZ0RVRjRLRWcwV1htVGUw?=
 =?utf-8?B?OHNGTU8xK2huTThkK0VZZjhyTFB6cm0wWU8zZ0tZbjF4N1BtNXo1TWxBTWdY?=
 =?utf-8?B?eUlaOEZ6ejk1Z0FnejUwRURRdW95bXZxWHQ5a09ldHV6Z2NqZ2xsY0xGYU0z?=
 =?utf-8?B?ZmRRNUpEam1qd1piUmVVc2V5R25ubjNxeGRtVjlIL2U4Y3ZZdHV6TVFMZUp4?=
 =?utf-8?B?VjNhdFRkbnVyS3VPRjNYclZpU0JRNHV0OUpnb1h4WW91YVhwVHVyVzVaTVNz?=
 =?utf-8?B?c0lpb3FiVnRvanJUa0owTjFrS2hadktKaEdUUVlmbmNON21PbkxzdUkxL2g4?=
 =?utf-8?B?bHVud3N1ZVF1MFRBTkpHQ3BVZEJGOW9LVFBOMXp4RkZSZDlCUnZBaGpqY0tU?=
 =?utf-8?B?YnpzcWFaVUc5NDJmaXBvVXhIemtGSDlmczI0ZDg1TlNndnNEWXZvSXMxNDRH?=
 =?utf-8?B?VGgzdjV6SHMveUJITW5BanBXUGtiYVZoTHlHTmkyQThUbUUxMkhNTlZXQXlw?=
 =?utf-8?B?NXFwQzVDN3ZKSUphZ1NEbkQ1K0ZTUEdBRHZGQUo0TTJQek5KWGJHeitIRi9G?=
 =?utf-8?B?MDI2Y09LUjltOWx6YW16dTltMElMa3lydW13U1lrY29jMURTS1NYZHVwZTZQ?=
 =?utf-8?B?dWZmcVlBUGJVdnR5eG1uVDJ0VDBidTd4NGRWa3ZwZzErVGVLYXpjSDFnQ3Fj?=
 =?utf-8?B?dUFkM1RmZkljdXJIZjR1d05BNXRZWjc4MVZJdVRzbHc5YW13eWExMHBTVFhh?=
 =?utf-8?B?Nnk5Tzlicjk2QkNaWm5lcFE3b1YrbTA4Vi8ya0I2dnh6eVZBWjhVQ202eWhJ?=
 =?utf-8?B?dGF5YjlFckNTOEN0SEIyTVVEWWtVZFF2YTVRNWFqUkRlOGlFRHhSUFVodjlL?=
 =?utf-8?B?eFFDY3k5djY3dVpIOUtobEgrcElJdXpDb1U2czYxM3FaVDluSVFmN3dXc3Vv?=
 =?utf-8?B?L2cvdkZmUnI4bjlKWDdhdC9QU1ovMXpuQUFzb1Q2VmVpMWFPTjZCVEhRTCto?=
 =?utf-8?B?YXJPOHdRVnFBNjROM2gyR1NvVU9GVXhFVlpDY3BaSkRJUEVabGhldkQvVDhy?=
 =?utf-8?B?QnlDdzlrOVpFckVOYjVNTGRNbkp3eVNESzFmUzZuOTE1VUFLSFBlR0hYZklJ?=
 =?utf-8?B?NXNLeEgxNms2UU5ka2VOOU40dHRwWm1sYWtJSk1zNzZUd2dXZFZVb3d0OFhI?=
 =?utf-8?B?NytyTzZGMktvVDRsTXkzMmQzMTNEUVRjWTVRd3FxS1lYQWdpUmtIVGw3QUph?=
 =?utf-8?B?RWlMU1BNcFRRbWdiMUhtSWdGMVVqdUVKcEZ4RG1RL0FyNlVuTnF0emluSXpr?=
 =?utf-8?B?ZVdBVHkrVmZyVUs4NVl3MWNBSkd2YW0wQmoyTHpCNTdBMy8ydzlJbVVNcWFx?=
 =?utf-8?B?TUo5SHBETnFMRTNLUlpoRmh1R1ZINkN6TWxtd2l5YzNsd0xhdmZtOGx6bXJl?=
 =?utf-8?B?SUpyMWF0RHAzMmtudEdVUnU4TFFKNHZ0WlM2ZU0zcnlpTmtldDVUVlpuVEdk?=
 =?utf-8?B?NFRCWDJZZzAzbHNmcStVTUd2SjI5THJJVTlLSDEwaDNJQk1jOUZHeHdrb2ZE?=
 =?utf-8?B?TzJQZ0tRVHJ6Z21UUGdVSkQ2Z3lFc2FBQmE2b3l3SzRlc1J3QVFqMzlDbWxv?=
 =?utf-8?Q?qALDGqwHzaunkaXB9Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12272.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3adc090-a160-4e57-416a-08de7d82d7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 02:23:25.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NU2N838W9mnGFotZ2cCz8VTw+Dhkgbd8whyuzNc/9LF/fOJ/lDw5BFHnnwbxNDgr3ahi97MeRDatjDLTUlE3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11965

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGZWxpeCBHdSA8dXN0Yy5ndUBn
bWFpbC5jb20+DQo+IFNlbnQ6IDIwMjblubQz5pyINOaXpSAyMDo0Nw0KPiBUbzogSGFuIFh1IDxo
YW4ueHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IE1hcmsNCj4g
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
WW9nZXNoIEdhdXINCj4gPHlvZ2VzaGdhdXIuODNAZ21haWwuY29tPjsgWW9nZXNoIE5hcmF5YW4g
R2F1cg0KPiA8eW9nZXNobmFyYXlhbi5nYXVyQG54cC5jb20+OyBCb3JpcyBCcmV6aWxsb24gPGJi
cmV6aWxsb25Aa2VybmVsLm9yZz47DQo+IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVt
cGZAa29udHJvbi5kZT4NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0
cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEZlbGl4IEd1IDx1
c3RjLmd1QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDMvM10gc3BpOiBmc2wtcXNw
aTogVXNlIHJlaW5pdF9jb21wbGV0aW9uKCkgZm9yIHJlcGVhdGVkDQo+IG9wZXJhdGlvbnMNCj4g
DQo+IFRoZSBkcml2ZXIgY3VycmVudGx5IGNhbGxzIGluaXRfY29tcGxldGlvbigpIGR1cmluZyBl
dmVyeSBzcGlfbWVtX29wLg0KPiBUY2huaWNhbGx5IGl0IG1heSB3b3JrLCBidXQgaXQncyBub3Qg
dGhlIHJlY29tbWVuZGVkIHBhdHRlcm4uDQo+IA0KPiBBY2NvcmRpbmcgdG8gdGhlIGtlcm5lbCBk
b2N1bWVudGF0aW9uOiBDYWxsaW5nIGluaXRfY29tcGxldGlvbigpIG9uIHRoZSBzYW1lDQo+IGNv
bXBsZXRpb24gb2JqZWN0IHR3aWNlIGlzIG1vc3QgbGlrZWx5IGEgYnVnIGFzIGl0IHJlLWluaXRp
YWxpemVzIHRoZSBxdWV1ZSB0byBhbg0KPiBlbXB0eSBxdWV1ZSBhbmQgZW5xdWV1ZWQgdGFza3Mg
Y291bGQgZ2V0ICJsb3N0IiAtIHVzZSByZWluaXRfY29tcGxldGlvbigpIGluDQo+IHRoYXQgY2Fz
ZSwgYnV0IGJlIGF3YXJlIG9mIG90aGVyIHJhY2VzLg0KPiANCj4gU28gbW92ZXMgdGhlIGluaXRp
YWwgaW5pdGlhbGl6YXRpb24gdG8gcHJvYmUgZnVuY3Rpb24gYW5kIHVzZXMNCj4gcmVpbml0X2Nv
bXBsZXRpb24oKSBmb3Igc3Vic2VxdWVudCBvcGVyYXRpb25zLg0KDQpSZXZpZXdlZC1ieTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+DQo+
IA0KPiBGaXhlczogODRkMDQzMTg1ZGJlICgic3BpOiBBZGQgYSBkcml2ZXIgZm9yIHRoZSBGcmVl
c2NhbGUvTlhQIFF1YWRTUEkNCj4gY29udHJvbGxlciIpDQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4
IEd1IDx1c3RjLmd1QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9zcGktZnNsLXFz
cGkuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMgYi9k
cml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYyBpbmRleA0KPiBhMjIzYjRiYzZlNjMuLjU3MzU4ODUx
MDI5YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCj4gKysrIGIv
ZHJpdmVycy9zcGkvc3BpLWZzbC1xc3BpLmMNCj4gQEAgLTYzMyw3ICs2MzMsNyBAQCBzdGF0aWMg
aW50IGZzbF9xc3BpX2RvX29wKHN0cnVjdCBmc2xfcXNwaSAqcSwgY29uc3Qgc3RydWN0DQo+IHNw
aV9tZW1fb3AgKm9wKQ0KPiAgCXZvaWQgX19pb21lbSAqYmFzZSA9IHEtPmlvYmFzZTsNCj4gIAlp
bnQgZXJyID0gMDsNCj4gDQo+IC0JaW5pdF9jb21wbGV0aW9uKCZxLT5jKTsNCj4gKwlyZWluaXRf
Y29tcGxldGlvbigmcS0+Yyk7DQo+IA0KPiAgCS8qDQo+ICAJICogQWx3YXlzIHN0YXJ0IHRoZSBz
ZXF1ZW5jZSBhdCB0aGUgc2FtZSBpbmRleCBzaW5jZSB3ZSB1cGRhdGUgQEANCj4gLTk2NSw2ICs5
NjUsNyBAQCBzdGF0aWMgaW50IGZzbF9xc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJaWYgKHJldCA8IDApDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiArCWluaXRf
Y29tcGxldGlvbigmcS0+Yyk7DQo+ICAJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIHJldCwN
Cj4gIAkJCWZzbF9xc3BpX2lycV9oYW5kbGVyLCAwLCBwZGV2LT5uYW1lLCBxKTsNCj4gIAlpZiAo
cmV0KSB7DQo+IA0KPiAtLQ0KPiAyLjQzLjANCg0K
