Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55A2417D1;
	Mon,  9 Mar 2026 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022991; cv=fail; b=YIP7mQn0PJNKjjrF5zwg0Av6pfUbPtCg23qWVmMK4hA8tHLIHAkwzdAFJw+jEOrR2df3Nrww0ypie0XZsBHb9QUMHafnAo8jGO2TcQ6Sfnlav17jjxX2TgyOaBZz67me2I7A0RwJQw4TXpUdx9uTcoK1mvlKzE6yRs7VXQMScCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022991; c=relaxed/simple;
	bh=ts4mUuytCjRsTG8a0VFtMLRCDKDVJIic3eVf8oiQ1R8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnXcLraKkJ+xRLQnGb9/519F10wHoX+h7HqMITLw31Na9Uq8TaRatlIPjgJzLfe3qakFxm5kxxUtZzhTsOVOteVWpBoRzNGDTDW2w+olWDY/y3DwB+qAljhrAOgI6u+C5VOjwf6ZtqJInVQRHb5XtExPnBCiLaNNUu93QYANwsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lspg5+RY; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lspg5+RY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMvyssxGEcNRFC01CImhqkVWI21WS9idUjnIZoYoYyF1HcCxpxzN/7FUg6DXE2p+8lc3wjjKVmPgmnFpl9qrlkcZTX+ROT5dmQDz2PgXnZTuegbsZ62arp/HU2vyDkxclpueEaR0B+koVjbkf/Ruf4vbdFPZCT3007e7RyntfVC690jpf2KHUeOHzcVoyOtmdT2V1rAwQPLCQ/hjCK75t53rEc3uSZqkVfuCwYbTk+wUUnmgwoSLu6GpaR96pmcuetyrcQ1LXivnwLIvVAcyuQUoOJi8Xgu9wH6Piw+6TASrrmiYPOb4GZLhRsjPMJ12bLMnEKhIRpwWQWoo8B6ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts4mUuytCjRsTG8a0VFtMLRCDKDVJIic3eVf8oiQ1R8=;
 b=x3sww6lKN4RUwV1AnOPjL4Apu+5/iTbKzy/+VzVBBsMos5eGut2BuWleG8ccSGWmOP8AfBQmcmc8i3eBWDc+kH0ekr2Unq73q0mj+528QsrTITam5ZUJwqD6GKEXO3em2kHzt6xpBhIg9cFSojIxV1ufUTWtgHfTvw/3/mz2pTs4DfVVJxiCFlsWvstUkF5g0v2XBGcc7WCy+/Y3FzBvGltHZGyxhfcNURnEse7qgvwdH8MKCLP0/tXxe3Yjl1e/Db1/Q0AuUgYXga8ysE2SAJaxSd2nmdI7MTG2KmcSP8lhvQE8OT6kmOc3OWuHr4PjiSvKkkVFr7FXvktJUR/xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts4mUuytCjRsTG8a0VFtMLRCDKDVJIic3eVf8oiQ1R8=;
 b=Lspg5+RYjUfrPpT52KOiW1bKtHlB3zdh9Sbg+4a3ir1Kn1nqbKgbRy+vHyJhQf2sD2yhGo6u60uYc89XcDPR2HbDUlr6ikCSKH5HViccU44YYEugLTIua3OfRsDR1bgdx3dXM8jdHH1HpyA8XnEbMCePPhlg3yI2mhw5RRU29QvGqLIHmbae87UP0vxgbMORxGSWTdyPiotQXe5TtZa/Z7ye7r1Ss1cc/j7+6BYtpvMJkbM0tHB5jkXv5rmN86wgs67da9TOrWsEctPIS/1tgpJ8pOKmHEkz/Ro4ueet+6FrGOvgITbndFCozXUiMVhyed5OG6iQJrNkHCng1XlTPg==
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 (2603:10a6:150:328::18) by AM0PR04MB11965.eurprd04.prod.outlook.com
 (2603:10a6:20b:700::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Mon, 9 Mar
 2026 02:23:07 +0000
Received: from GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908]) by GV2PR04MB12272.eurprd04.prod.outlook.com
 ([fe80::3c9e:6f28:93b5:b908%7]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 02:23:07 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>, Han Xu <han.xu@nxp.com>, Mark Brown
	<broonie@kernel.org>, Frank Li <frank.li@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	Boris Brezillon <bbrezillon@kernel.org>, Frieder Schrempf
	<frieder.schrempf@kontron.de>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] spi: nxp-fspi: Use reinit_completion() for
 repeated operations
Thread-Topic: [PATCH v2 2/3] spi: nxp-fspi: Use reinit_completion() for
 repeated operations
Thread-Index: AQHcq9Udmr8VDotgXU6g+i/wN6pzj7Wlf32A
Date: Mon, 9 Mar 2026 02:23:07 +0000
Message-ID:
 <GV2PR04MB122722049E826580F586FFA9B9079A@GV2PR04MB12272.eurprd04.prod.outlook.com>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
 <20260304-spi-nxp-v2-2-cd7d7726a27e@gmail.com>
In-Reply-To: <20260304-spi-nxp-v2-2-cd7d7726a27e@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12272:EE_|AM0PR04MB11965:EE_
x-ms-office365-filtering-correlation-id: 0bf00cd2-c649-409a-5852-08de7d82ccfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 6SeCfhqxL2o6CzBcilp3BhInYe8PHmWOD0F+Gk8+iQo9Mimyn7EL/36p5sEgHdtBXWgx2EmQToNRMICXumPWKYV4oltTp7QU5IT5uQB4xITE8Fe4pugs59TIbyGRG2eRv3zZt3qickNeR61yJb4I8N4zyJfCIR/p21V2zp881WyYY4bY+rXRTFkWzBHKLuliAUHFj9fkwlv7gl+pqk/azxUIsMbnVDnoQChxQ3IuXEvmXlXCbuctfSWfOdrWQzYOwEmxo58akrQgMlH+PbbUqN1upXvRD7MU60tAInqXUhMcGy8pF4F/NBnW7DG6yhy8XU/2CeUPKumO6/zCb2nnZnPEKDOCb1KcRhcYg9ZSqUd3m01BO1W/byYqbfcburInw74v7l4JAobDQXohJLETfq/oy6b8AZ94qp8U6LmAwSnPySGHL8MOqTP1HabBc4Myi35/I3JvNPE1+aKEUt7ULVuE5Euy9/JoHHnRuRT2GdTa/X9YcjMl2u/ZxltkZS+EI0Qe0ATCRCMY1Hx4Oc8Arxg4FbnKh00Al464iPz6nGP3kUYCuthulnrPkeGJgnDrut6NzQ039Hc4JZJdzJOdjMpPShZkpelDAIF3UkO32Y9biDmMMI78Elnl8/R+xlCv1S/KWWDPsInrqDEwyOtsIPqeDGj3MAOW0rwLsPWkzrEO92xKpgY4txSb/A/Hl3KsMVmJ4gonQaAW07nKHbyGQBFMw6Rq75+0nPZ2PJjw1g+VL7GXIbKoTo8bjmn4cIEINjYVaajChUJG8hH67jzAV23PB9Fb0OirOHW+f07Hbxg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12272.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHRoYzFGQTBaYWNjN1kwb0grdkVNR014WVVaTzZFOXN4R3Bsd1VnTDE2V0Jq?=
 =?utf-8?B?amxvcFJjcEh3RFQwN2dmYlRGUGQ2M0J3b1BsUXJxeGNtUDVLZ1ZFMjJNTTkx?=
 =?utf-8?B?U3ZMRkhySEh5dU8vcGx0S3VuK2Y1Qi9vR0pLeDFleXpQNzhPSlI3N3M1b3k3?=
 =?utf-8?B?ZXBGMGdxdnVXa0grM0JxVm8xODFKV3VhS2lYdVQxZzhMQVBjSlZSbEo0SzdN?=
 =?utf-8?B?cmg3L202TUVQWDFlMVlGdW9Na2NYWU1wZDdxQU1qM2MxMzRqMy9sdW9JQmZX?=
 =?utf-8?B?NGxMVTFvbFlkMXI1UThaOGc5aHdEb2RGckNPVG9FY3FoelhxUVZvOUR1K051?=
 =?utf-8?B?VzEvemZPNDhWOVFkd01RdlpLdFNHbEY3dC9EZGl6VVBoMlhGVnNpeHZmWHBF?=
 =?utf-8?B?bUxmUjNOck1XWDBoMXd5alhOVzA2WXhXbnpvMjE2NEk3bUhKUE5udit1d1hH?=
 =?utf-8?B?c3JTVHE2K1M3NEU3NDFuSElqcXg0SmkyWi91eFBteXJ0SXNmQTlYSE5DaGJr?=
 =?utf-8?B?K05QWlZLV3dOazk5ejM1MzB5dnQwdFFOb21USFRERmlzYzdIQjJUZjlkSEJJ?=
 =?utf-8?B?bThXeGNiVktqSHNnODRNcVR6ODBOem1uMU5pTkh6bnBmRklOeHFGWmVxQVRh?=
 =?utf-8?B?Y1luaVlFTTJydGZ0eUFKZ0FDekdyRFU3azJLMFE1V2NidjZVNXZia25VM3JN?=
 =?utf-8?B?dkF0TFpKVEErczdjVHJZYTg2c0dnV1dzdGowaUNVNDhieVE0TStpSGt3eUZY?=
 =?utf-8?B?WlU4ODlJUmw0QlhuWC9Wd3k5aEkyaW54V0diWTBrUHVBamtPT1o3R3Z5RFZG?=
 =?utf-8?B?NTY4elMzSi9IdUFxMDd3bU1NT3JuYTRSaWltYW9oVjZqV29HVUdsdEQ5R1Yx?=
 =?utf-8?B?VjllZnJBZGYrZzVndndDaWtxZ3hzVlpLU0hWVGdKaFIwaEJ6RmtvQkY0T2ZP?=
 =?utf-8?B?MjdIZWxPOHlQcWxnZkw4dWRVVWc5Z3QzNThmMWEwMHpuTXduOVFKanhMWWJ6?=
 =?utf-8?B?RnViOUFrWlZTWHM1Mktja3AxZTlKRUJHL3czbHp3SEVoeFZ4eTFEOGo3dXdl?=
 =?utf-8?B?dFZzQTZ1bWtSOXl3VWsyNjd3b0k1aFk0TkQ5Skt1NXUzalVtcUdhd043TExh?=
 =?utf-8?B?eVpnT3RxT1Jja0xWOEVJRktUUmJSRzEzeWVtWTlia1NCSFQxSmxxREd6bjYz?=
 =?utf-8?B?KzBHRFN3c2ZpdTZpRWJqRVpPRWp4aTlTdmdGREUwTVB1bzk3Qkt3VTIzZE1n?=
 =?utf-8?B?S1lPb1YwRHNya0hzbzhERjl1K0lYaXBaREtEeHQ0NjBXMGYzL1VLY21jSUZO?=
 =?utf-8?B?UmtsNGluYzRpQXgxVE1tN1lKdFlwcmQ5MXFaSWVGTkpNcmZVeFlBMjFMVVZH?=
 =?utf-8?B?SUlkU3FPTm1YTmNhcVRUWUFvbDVWWVpKNzNZVjlZSUFjcjRaR2dyU0NhbWxj?=
 =?utf-8?B?VVdXait2VWg0OW1GSGsyYWUzN0JaR1ZtWUhGM3dvWXQxYzg3SytYc0RRejdt?=
 =?utf-8?B?QksxSEhDdERZb1E3RnJnYjNnUkxFY3Z5dmxvcm1OYkRMa3U2bG50SFBIY3Qx?=
 =?utf-8?B?MW9pdGNGWElva3pDaXE2UUQya0p0U3VBZk1KRTViZTQyMER5YTUybXExbGsw?=
 =?utf-8?B?UktSMzBzakdhZmpaUnJjNllENnk4TmQ1d1pRMTRkRzZ3YnY1SU5pMkxEK1Vm?=
 =?utf-8?B?MVNLV2JjcUlBMDdMdkl0OGJ6bHJJOEIyaFEzRGtoYUJ5N041NGNjVXY1TmVv?=
 =?utf-8?B?L2pvTlBySktpcm1KczJQdE9ZbEJSYkFQRE9jNVRCWGVFbUFlM2dUMzg3VTJz?=
 =?utf-8?B?Ry9NLzZvbzZvWEdxZTdFazJGQTdtQW9yOFVpakJ4ZzduK0lneEozMHdJOTZC?=
 =?utf-8?B?L2F3cXkvZXQ5bm1Ua3NCUkthMDlQMUw1Q3NCK1JJaEJydnhaTGdQcVgxQ21h?=
 =?utf-8?B?eHZOYUd6ajNwOXNZUURZdWpnZHpUM1JkK25NTjgwOE11bG9TbE4zeFNEL0l5?=
 =?utf-8?B?Z2JxS1IxMkxGSm84dnJmUkRhZVFuQ1ZEWHRjaGtQamFQRlgzWDI2SXpSSnEy?=
 =?utf-8?B?RmdodERvenhUdWtFVXJQTmFiTFpOUmNHRW00ayt1UmtmUjZiTTBnSUJIbzBk?=
 =?utf-8?B?ejk3S01TNkg2U3BZQWlqcHdiNFJHZ2V0YWYxWjhwSVpvbFY5RFljQzNTSmtO?=
 =?utf-8?B?ZjZkbkI4QVNDZTlGM0VocjE0dndUSkEwODNHdmE1Vllzd3ZaOUwwVWtBVHlp?=
 =?utf-8?B?aXR0clUzUlQrQzR3WGJsQlV5RWJUQWNPTGxrNG9wREEwMFZtd2pHZ0tLVGlq?=
 =?utf-8?Q?n4rWsb6Pp0Cy/ohKMJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf00cd2-c649-409a-5852-08de7d82ccfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 02:23:07.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuCgD6yYXbdcqvv1KgbxjWcsb03WkATr6JPPZK/1WG6R8UYX+Ah8Zo7cpiaKQoWrL5TSySmaaBAZRNB8MX7wlQ==
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
c3RjLmd1QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDIvM10gc3BpOiBueHAtZnNw
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
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+IA0K
PiBGaXhlczogYTUzNTZhZWY2YTkwICgic3BpOiBzcGktbWVtOiBBZGQgZHJpdmVyIGZvciBOWFAg
RmxleFNQSSBjb250cm9sbGVyIikNCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggR3UgPHVzdGMuZ3VA
Z21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIHwgMyArKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyBiL2RyaXZlcnMvc3BpL3Nw
aS1ueHAtZnNwaS5jIGluZGV4DQo+IDMyMGIzZDkzZGY1Ny4uMWUzNmFlMDg0ZGQ4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9z
cGktbnhwLWZzcGkuYw0KPiBAQCAtOTk2LDcgKzk5Niw3IEBAIHN0YXRpYyBpbnQgbnhwX2ZzcGlf
ZG9fb3Aoc3RydWN0IG54cF9mc3BpICpmLCBjb25zdCBzdHJ1Y3QNCj4gc3BpX21lbV9vcCAqb3Ap
DQo+ICAJcmVnID0gcmVnIHwgRlNQSV9JUFJYRkNSX0NMUjsNCj4gIAlmc3BpX3dyaXRlbChmLCBy
ZWcsIGJhc2UgKyBGU1BJX0lQUlhGQ1IpOw0KPiANCj4gLQlpbml0X2NvbXBsZXRpb24oJmYtPmMp
Ow0KPiArCXJlaW5pdF9jb21wbGV0aW9uKCZmLT5jKTsNCj4gDQo+ICAJZnNwaV93cml0ZWwoZiwg
b3AtPmFkZHIudmFsLCBiYXNlICsgRlNQSV9JUENSMCk7DQo+ICAJLyoNCj4gQEAgLTEzNjUsNiAr
MTM2NSw3IEBAIHN0YXRpYyBpbnQgbnhwX2ZzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQ0KPiAqcGRldikNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCByZXQsICJGYWlsZWQgdG8gZGlzYWJsZSBjbG9jayIpOw0KPiANCj4gKwlpbml0X2NvbXBs
ZXRpb24oJmYtPmMpOw0KPiAgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnEsDQo+ICAJ
CQlueHBfZnNwaV9pcnFfaGFuZGxlciwgMCwgcGRldi0+bmFtZSwgZik7DQo+ICAJaWYgKHJldCkN
Cj4gDQo+IC0tDQo+IDIuNDMuMA0KDQo=
