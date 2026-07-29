Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12702429003;
	Wed, 29 Jul 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315395; cv=fail; b=WxRJy0fiy2euurQoaWet2Qf6fyVrtREr3ZN0JhfYHNnRnOP8ViAgfjI+Pt9UY4wFtabRog0xJV7QOmPFEEYyfTLDGMBObQWrcQ845mNibvTj72iOs6H+czNXgFR0l4iUvjAM2mdR0SLvXR4OWIsvtf8dlNcPO3QMlrFhxY8o3p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315395; c=relaxed/simple;
	bh=FYXZj+b0JyOYd8PK5bFiHKh6qWmnGeAvf3R3QcbmrgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PU/CP7G89eC/hExNkhzBDGlzPGTdabbS6Q5G/M3tvPQOrQ+prgxtWAL6vJa+sLzRWVJKUNRf/KaUYPLqA2RMPW8WGntF7312q7UtXME1d7GLe18UswezliLoCtvzcF0pm1FBtwKmctkL6243iM7Os9LhkDj4o31qTalnCeGkEaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mvLsPgud; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mvLsPgud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT5q+fVXxDrEtKSac8y9q9O6yMR4oKqhZ84XoWBPQIgKHPWenX2+3fh7UaDHdte5mbWT/Ii6rFGQ72GtSZI9/zsLUIY6ILY7sdV3FkbhOMHg2ysO/SEhlIIgCdhFb1P3J9AlAxq8bRpyYwBhLcs9QevCpxqqlQOUa2e0gJpzbbXM0x9+nRNnk+cefxfg35s3hd9v32zzE2fzHyxYP3ybDomZ4EW2GyOUCAOTg08HOKyk5jd8m6e2alCFRGWWGCSvjxfqU7YOEYxgX8jbcRdhKEiVTlh59PTHL/E4rMtsZ0TgIBMTaopxJfYauX3XnnAjKKo+6sJUhTsqmZJNyJPL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYXZj+b0JyOYd8PK5bFiHKh6qWmnGeAvf3R3QcbmrgA=;
 b=Callnaj5SLq3Us09kqsjq+I6zPYAQ3PHIYS0b6dh8EihBxTIAFUG/bgwa63c0d/MgaYvvAAwX3p4WJ9vTG6zJOuYhic274i2ykvwk2shDajKF8MRv71KdZdTrpF8lL9AtCzc+BulcWtnBr/okSqsiQC0EKtD33dkUSkegmRXXi7h3orA51d/mvAeFlgpoN48KHhJpln77ykW3TyMqejztD40R+rWUlyQYkI9JO5yS7ugG9LwdhOhchWr66QdGn8669sAEzJwhHNw5mOFFq9IpYLn0I5LkMif/LwJhpLrlogeHM2AD/zFMz3X7R/AvNfJDpUTUf4m0g4sIl23/9ez7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYXZj+b0JyOYd8PK5bFiHKh6qWmnGeAvf3R3QcbmrgA=;
 b=mvLsPgudwjZF5tPyw+I0A+VUmr+TUX6kqvRwVERxYC54uuDsB1qfaEXabdgxwzdJx+i9EcmjsdUoPTMZUvLuR95cMA4KzHI8q6sEb9yhLMo5105oEY2FmOlQGern45Tqstn0E0SmwqXjcUunOfL04IIKGKHcrn1D740vfAXcxNTVCEiVoIOv4opjbBn2aA+qX3N6nAxo4XJweyOWqmHtO3kELtlcRD7n0w41g7VJylahRh14APex/FIruPlCpsZSQk0RtUIIKIhRDFdyE0PifV+BYYVfhMR16926OTgcZDHGyblAUZxwjzVI26coppw0qTgH2dtrACROel4ksPj6Ew==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by GV2PR04MB12137.eurprd04.prod.outlook.com (2603:10a6:150:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:56:29 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::9cc3:2ef9:9259:e963]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::9cc3:2ef9:9259:e963%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 08:56:29 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jiawen Liu <1298662399@qq.com>, Han Xu <han.xu@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] spi: nxp-fspi: propagate default setup failures
Thread-Topic: [PATCH v2 2/3] spi: nxp-fspi: propagate default setup failures
Thread-Index: AQHdHmfSBS8tE+edf0KI4ISA+VFqy7aEKrhA
Date: Wed, 29 Jul 2026 08:56:29 +0000
Message-ID:
 <DU2PR04MB8677F89F80EDBC0704EC0F5190CA2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20260728080443.153827-1-1298662399@qq.com>
 <tencent_F25742D45315ED400AEA2E39210242FCFE0A@qq.com>
In-Reply-To: <tencent_F25742D45315ED400AEA2E39210242FCFE0A@qq.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|GV2PR04MB12137:EE_
x-ms-office365-filtering-correlation-id: 76d73a2a-f62a-4db2-7933-08deed4f47b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|19092799006|376014|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 wxcnK4xZgoBb4TZqa1IrXqBD399igEuRJLNggAxDS8zYccoP8Y6A7Tp8kGxxjxfdGCwyQ0TpGpJL+oIM+2v9JGOitNPvTYPRfC6QiiUv8i8RGV7Yn12Sp8QRKvA6V+1nOWyLun8WGInN+LI3ieBOWoH825ywlbjBjj00JSxrIqRIsDGo5+gDcJIvLqCc9gDVoNigYqhTg2G7/3yT51r1DsF+SnR1FTD1LpWHLcmZBXBG8If5sfS0RlVFZQbpaJEL3CFEYBHbZKJnv1reJECSad7ZJzX8ajCrirz3TaNrFj2mNfK7eSVVD2Drrgfp8eNOPz67Rddbj3PIy41tD9PfaQRe9p3I6HnnzSlef8dEQ5Qw/zXJf21nBb/Wl2f+iUUmOqq+mYg6jb/Dzs9Fq6j4bB2XDpj0FRDWqYMtwYC7DLmMQ9U09/9Jzru70xFFCUsnlDv4lpJQD80+eI1OrX3lgUddV/4JcEZly/mZlxtAdybCAqEt3M5AKplmIaFndKoXKeTleUcsx2NwWhiw/H6P/uAkyb7/nctSfsY3vQmHc3SgYlRaNREowN+VJgFo/XDKunk+7lC1AmGK7x72YG5lINjamKRGlXuFXo0PGkL6WsryvfMJvHMWj7yJV2vKbicKZmqN/ARIWePlu4dLI5HXDQU5lKC+dzYdBhYL4wCqjMDv4S2N2lhWp0Dv2XZICTYmNB9ck76zh6QfOIibZlKfbE/8J4QR7mxg28Iq6h7bD9o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(19092799006)(376014)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ays3Z05SSlpBOUdiejY1YmFvZVIrOVlGOHR0eis2NEx0K0xhMmV6Vy9MMmxM?=
 =?gb2312?B?VVFGbXdPUDU2cmo1TnJpNUZNVXRRU3VWcU0yRHVGVmEvMHY2TlNUZ2laN3E4?=
 =?gb2312?B?QWdjb004aVAyQkQwOWl6ZzFqSUhZY0M4ODJ1VmttVHM1UlF0d2J4ZDlwSkFD?=
 =?gb2312?B?NERUWlFCVVNVZ2FuTURWM2FTWk5jRDBnRWdLbVYzZ2k0UXlhOWZOQWVXYXZH?=
 =?gb2312?B?UU1lNlBjbnhySVJPM1BVSk5URzloeDZ0MThFU1JsWFFTd3IxbFJlbU1DWjBO?=
 =?gb2312?B?RGN2b1lNcWduMWhobmgxSWVUelR2Z1REdHBFbkltUHB6SCtBRFNHV0thWGE5?=
 =?gb2312?B?c2l0cnppMXN3SjVESzliOEFCcEQ3TmxBZHBtL3pVLzA3TzlNTjFoZWZPeEE3?=
 =?gb2312?B?ZGJ1TXRudmNWb0Vqd1UrNnZTSjlLZ2dXTFRndHZSVEdCQUFnSFRoSnFycXJB?=
 =?gb2312?B?VG9jbWZFQmNpNkJlNWRhZmR0ZFBuRDZrM2tsY1VvNzA1NVRWT2RENWxVcllC?=
 =?gb2312?B?WFVrNklaTVVId2MxLzN3RVV6WUV5eThJcmV2cXBhNG40aVlYZnNkaTZCU0Nm?=
 =?gb2312?B?ZXlRL3JWWkg0T3VHSEhGdWxkQXd1MFl0SGxLaUJ0NzJpNHF4MnZNeTBMVmpr?=
 =?gb2312?B?NHpzd0EzM3hHek5ibjRLSUh3YkxHMnRwQkJEeFgwb3kyamdjVnM0OTY0RGRR?=
 =?gb2312?B?YkQranExZmFyTEthTFA4WEd0WUM4VldoRm9NUlhMOGtoRnR0NkpnSXA2Ui9B?=
 =?gb2312?B?dVE5cHJGb2hQK2pRZkY3VmlCN1ZFS3BPZzQxd0lUWEJYR2VTbkQwdmFkbVhl?=
 =?gb2312?B?SDN0eXd1RkJTWWlYMUpVZWdlN2NxUTRja1NLOEpSMjdaV3dRZGNsRzJNamZU?=
 =?gb2312?B?QXd0bWpNNGJEeVpJaTFKY25PcFR0ejlBTUVSUWZvR3N6c2pacnk3RkgzaVZI?=
 =?gb2312?B?aU5mL0RHQUdGZFJXRVQ1K29yK3dBaktqSmJyMGVXSVRGL0NnNVhIZ3dFWGUv?=
 =?gb2312?B?UVhpcEtmVlZRRjVHa1VsWlhzbjV2SStlMUdSdVhQdnByZFJtN2NWZ3poREZT?=
 =?gb2312?B?TUZsb0UxRlc2RHlXT0pudVRocTNRblUwWXdvR0RIMklKTTZvTFh2UThxWG9h?=
 =?gb2312?B?NXR1UE5DTXFmQU1MQUk3cmo3MG1Od3dVNTRabDRwUWYvemorM1g4RjR6YVNL?=
 =?gb2312?B?UHl6M0JoNXR5VTM5eklpVzc3c0xoUFZNSGYwVjhKelV1c09ZYU12OUUxSzV2?=
 =?gb2312?B?ZjB2TWdtWCt6d2NiMW5QN0RIbmNJQkp5cEtsQVdXNDBSNFdEb0Jsd3kyenVq?=
 =?gb2312?B?bitubkpQWk1TUXk3eSsycG5na0N4ZCtEWUZ5cXRUM1VmZ2FpdlJuakpMR09K?=
 =?gb2312?B?UWRVbEk4SHV6aXM4TU45U2tPdnFyZG03d1NVVlhHSzJNeGxxNFRpN25pT3gx?=
 =?gb2312?B?bGJ1c1V0MWU3RU5ud0xRVXQ3Y05hRW5HSjRTTUhLSVpEYWNoSk9iWDdIb2V0?=
 =?gb2312?B?OWxaRlEyejJ0OFc5QWR4dWhEZTNaejh5NTVGa3ZTdENhRWlqNE54S1B1QmVh?=
 =?gb2312?B?ZXBCYzdQU3RMY21LSkZtOHlLcTdOSC9GcTNBU3VWdkRPRTgzZWc4Sm91b3Zu?=
 =?gb2312?B?bGtuNlhuK3Z4MkR6NEsxZmVndTgvZG80OGIzN0RLa1hRaUVSbXJTV2dkRE5P?=
 =?gb2312?B?SmNISjd6bkdVcnBoNG9FM1JoS2ZEdFYxc3BaQ1dwWTAwRERXMkU1S3djcWpO?=
 =?gb2312?B?SkRRbE5oQ252M29idDVoUWNtRWJXOHNmV3JPYWF1QXRVZGlVQXJMM21qeUVX?=
 =?gb2312?B?MVRMYW9rbUVmOGYvMjRmYmkza00reGlTcy9FVkZ2OXVhdWVWbFNiNnl1Z0Fv?=
 =?gb2312?B?VXFsTi9vaTFmWWhwZWtNRldBY2FiUmRnZnJTc3JlTGE3dEt6NDU4TUZKeTgz?=
 =?gb2312?B?cGRnK3ZwQVhCQ1lZTnJuQXUwNUlHLy94ZGpmVFV5YnVkUDg2NldxMEhXZUNL?=
 =?gb2312?B?VXI0Q1gwamRFRitNSCtKRnNpZkt4ZjZCNTA2OVV5SlpINERRTkFLYlNFNytn?=
 =?gb2312?B?TmU4VnJ6ZnlxSWlIMlJaaTAzcnRrblV2dlhLUUFRWWlBeVo4OW5iNzFPRFk5?=
 =?gb2312?B?cWViOWpXOFlxckgzeGlLK2NJY3dLNDY1SlVlVjZsM2VGbWdIL0grR0V0UHJ4?=
 =?gb2312?B?MUhwVHJoQ2U1WlNGK0IwYWJwRkZwSldaekNPR2ZZaHRaWTJjREVyaU1zeUhK?=
 =?gb2312?B?azdrazV4UU40ODcya24vT0hBYnljZTl5QkNyRGcrdERwd2grVU1WZFRUbDhW?=
 =?gb2312?Q?1eFCuGt9HkuP3oIOS3?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d73a2a-f62a-4db2-7933-08deed4f47b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 08:56:29.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v1zjLnBfRN1P+fViPyfizYICFpA2pGQYWQIdA1IC087Qgtv7sd5x5J4YylegCcK3PEVi4KUFbVadOKXv7QBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12137

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaWF3ZW4gTGl1IDwxMjk4NjYy
Mzk5QHFxLmNvbT4NCj4gU2VudDogMjAyNsTqN9TCMjjI1SAxNjowNQ0KPiBUbzogSGFuIFh1IDxo
YW4ueHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFlvZ2VzaA0K
PiBHYXVyIDx5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2Vy
bmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYXdlbiBMaXUgPDEyOTg2
NjIzOTlAcXEuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMi8zXSBzcGk6IG54cC1mc3BpOiBw
cm9wYWdhdGUgZGVmYXVsdCBzZXR1cCBmYWlsdXJlcw0KPiANCj4gbnhwX2ZzcGlfZGVmYXVsdF9z
ZXR1cCgpIG1heSBmYWlsIHdoaWxlIHNldHRpbmcgdGhlIGNvbnRyb2xsZXIgY2xvY2sgcmF0ZSBv
cg0KPiB3aGlsZSBwcmVwYXJpbmcgYW5kIGVuYWJsaW5nIHRoZSBjbG9jay4gVGhlIHByb2JlIGFu
ZCBydW50aW1lLXJlc3VtZSBwYXRocw0KPiBjdXJyZW50bHkgaWdub3JlIHRoYXQgcmV0dXJuIHZh
bHVlIGFuZCBjb250aW51ZSBhcyBpZiB0aGUgY29udHJvbGxlciB3YXMNCj4gdXNhYmxlLg0KPiAN
Cj4gUmV0dXJuIHRoZSBzZXR1cCBlcnJvciBmcm9tIHByb2JlIGFuZCBydW50aW1lIHJlc3VtZSBz
byB0aGUgZHJpdmVyIGRvZXMNCj4gbm90IGxlYXZlIHRoZSBQTSBjb3JlIGJlbGlldmluZyB0aGUg
Y29udHJvbGxlciBpcyBhY3RpdmUgYWZ0ZXIgc2V0dXAgZmFpbGVkLg0KDQpSZXZpZXdlZC1ieTog
SGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQpSZWdhcmRzDQpIYWlibyBDaGVuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWF3ZW4gTGl1IDwxMjk4NjYyMzk5QHFxLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYyB8IDkgKysrKysrKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC1mc3Bp
LmMgaW5kZXgNCj4gNmJlNzg3MTJiNTM0Li4zZjFjM2VkNzQ4ZWIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNw
aS5jDQo+IEBAIC0xMzYxLDcgKzEzNjEsOSBAQCBzdGF0aWMgaW50IG54cF9mc3BpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaWYgKHJlZykNCj4gIAkJZnNwaV93
cml0ZWwoZiwgcmVnLCBmLT5pb2Jhc2UgKyBGU1BJX0lOVFIpOw0KPiANCj4gLQlueHBfZnNwaV9k
ZWZhdWx0X3NldHVwKGYpOw0KPiArCXJldCA9IG54cF9mc3BpX2RlZmF1bHRfc2V0dXAoZik7DQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQg
dG8gc2V0dXAgY29udHJvbGxlciIpOw0KPiANCj4gIAlpbml0X2NvbXBsZXRpb24oJmYtPmMpOw0K
PiAgCXJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnEsDQo+IEBAIC0xNDA4LDcgKzE0MTAs
MTAgQEAgc3RhdGljIGludCBueHBfZnNwaV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlDQo+
ICpkZXYpDQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiAgCWlmIChmLT5mbGFncyAmIEZTUElfTkVF
RF9JTklUKSB7DQo+IC0JCW54cF9mc3BpX2RlZmF1bHRfc2V0dXAoZik7DQo+ICsJCXJldCA9IG54
cF9mc3BpX2RlZmF1bHRfc2V0dXAoZik7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0
Ow0KPiArDQo+ICAJCXJldCA9IHBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUoZGV2KTsN
Cj4gIAkJaWYgKHJldCkNCj4gIAkJCWRldl9lcnIoZGV2LCAic2VsZWN0IGZsZXhzcGkgZGVmYXVs
dCBwaW5jdHJsIGZhaWxlZCFcbiIpOw0KPiAtLQ0KPiAyLjM0LjENCg0K
