Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCE2D780C;
	Wed, 29 Jul 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311461; cv=fail; b=k7ifVb0WhBBAsPnagwHmjYd296Ef/s55zcD1BSwtzS8dSqtJh0sjVegP9xiu6YQmYo45tO4rNrz43pku9AIX0VmRJV0yK7oqra6Vnd7RglAoqlnsjJ0V8DytFHm7DmXL0OI6bfcxZd+anVfsDfDWmjQhQJ2olQEaF0lJvVnCQGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311461; c=relaxed/simple;
	bh=7UTgIbp9YTy66hdLyPb7eyl0pA0G79e+Vilfkchvw8k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/bR3j4jIPBkQnFOkEx+lT66AyNFbfZQ6WlRIy03IHEZt1Ymd3s6qCqisefj2y6f+DYvoHrJUq//eQXreIRpFcukeSEEJJfOv9WLp2WpahRP4bdAyzhk5RpCPDSXeFFnubwDXubf/+vBBMqrxS9Fyu1cIq51dAb7RnPxHjjy9i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DLDHQb2o; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DLDHQb2o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK35+Hnaf/Sj8IBCFoIVv01uxiwjmH8/GtDT3H++3WZi2PQv9EnrkjMWIipXZmEr/3jQznVoKjyI2i28lainF2j+6KYLvi9PX1AwcA5R65OVP/Vm/+PTq6XODktpb60n5J/LdC1/kTwbDkFWE0jy2A81A2ro9cPVwwQAsTa2gQtoLnmJoF0ykl5S1foY9F8z3CY7QsOxJ7/GczS0WZcRzYzZXNn1ZbJkZUn5eG3gSrigjeqXeEe/GkGPKJjAF0CWOKvGMQbU2Fc8dPx25phEArtFHPPif95c7iLdk/0HE1nZCrnLcXAPM1pbbIf0f2ZQ4Ubb3dDK0hH4COM4EUexlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UTgIbp9YTy66hdLyPb7eyl0pA0G79e+Vilfkchvw8k=;
 b=ivmQir59fgnruGcSFCygaRFRA+rXBrNKOmAEmZmhZJBbuqkeLaQv24cm5sy1kcNjTOz0AOnT5TYIwgyrgpMh9g2sOfxRrhlx+ke0bb8P9DXRqusA/xFruuOfXQp0kQfS9YTtCSkuIBVxoOJQOmOkH6wg14JXVpfGdCAN1+uD+QdvZ+isYHyiNb7ppFEyvxk7ojJl3HOcxSp+tWLcvxAxqo9+PRaXhYP+SKqAdZjbN6JH7UYRXayuQqtwUg0fmOTuCRVfzW4CwXarjqe2A1dHKEJF0zV/tDmXrXP5UYmKsgYEnJ9Pv8R43ewIjchKVyMok9YRJBMOAxpdZlixcX1H8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UTgIbp9YTy66hdLyPb7eyl0pA0G79e+Vilfkchvw8k=;
 b=DLDHQb2odQHNbeFt6pHmtfDHt2bRTI9qK1GZmiAfM92gdy3p7r1KG+fpe4cOsaHom2ec2HiJlfQ3uTPLX6v+WDtzhMXjSUOjHroUVGtxHtkG+MQG4/CvWl5K47f0DHEkadOAx2jtS/jMpyMI/ErBopFNabY33Fh9kE26g3JeW35LWDn9kvsPGprFd1TndmXyQzJKzccVFjdmdXN15HKKia+G3uS8dxXNcegMSBV52tGfS2BdoUGLjM/yQrs2CiTv/zXuCGmaqDQB18CwFPYnsHUWFefp0YCICpj/KqHMibYyquqkdroeELsWCHvKlye+8FtqjMf3FV7nrdXUVMCN/Q==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:50:52 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::9cc3:2ef9:9259:e963]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::9cc3:2ef9:9259:e963%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 07:50:52 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Jiawen Liu <1298662399@qq.com>, Han Xu <han.xu@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] spi: nxp-fspi: use devm runtime PM enablement
Thread-Topic: [PATCH v2 1/3] spi: nxp-fspi: use devm runtime PM enablement
Thread-Index: AQHdHmfSotTckIJj1EuhzLWCjuXmDLaEIJaQ
Date: Wed, 29 Jul 2026 07:50:52 +0000
Message-ID:
 <DU2PR04MB8677D6D6256032D9BE5A45FE90CA2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20260728080443.153827-1-1298662399@qq.com>
 <tencent_D07D657D7D49113424BFAEA7931F60DB2F06@qq.com>
In-Reply-To: <tencent_D07D657D7D49113424BFAEA7931F60DB2F06@qq.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|AM9PR04MB8422:EE_
x-ms-office365-filtering-correlation-id: 2007a9c6-ab19-4b98-56d3-08deed461d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 JDp7/g7nm+U5uI7eMBogfQaRc1v5vcLG8a99T+7dy3scg0NZKnYz5LNkZU26IPazHJguBo/tOB0MK31+5lDbmqxSgNfh8A3Gq35ouJPZPpO+aVDqw5M9pSSHpFlMck8OPqYRFeeXczwykg5K9fooC5dcTGoUeEU8xIJaa7W4/1NO52OKw+2c45NKtNsyatEncp2T2H0+LNtsK2Tg9VlKMRT4SW6IcmEOnqTV+ngOTtA791Zqm8W3CK7cw7CcLf+jZ14n3/yThnyhZn5to2Z7JIxXLnLBfOL9ejMueiPuvVVf3IHhqUdZjiuupWYVeC9eCPOlhbUC85H51F4dVwHc0eR3AtcUYv2mHDgaeVKHwrNd0hKqTdgEIqyr0DrW29rdJklJDWa1Al8/hIaHiCB0M8D5W1FJCh2O4VtQ6CbDNlAQG/L7Pdeu70ctsJ/+PQCJ1c9uKEaLU0ekX6grkoFT+1KpkO2W4w2pBdjVXWFks8w8t2YpDeCd5N3m6Uqx3FeCg7svCrZPkR7uQ+YaJHQU8Bw+e+zqNKp2m4gLc01vEyhWpWUgN+P4OGgQPOlkNUBOCtin16fIq2ccMOr37uGlZh8kB2KTq4arKethIH38Vwk1UpwmzS9TRwesooelSOux71LqA43RmSHr+xSqFHEZUu1fEiC6QLOsHcLcqMYdNoHg1q/sO2V62tYlwVi2QSy7v08iX5+2fTI0Jeg5JLNxJDoA1vttMPPGFdUeA+NjWcY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YmVMOG0xd0VReDdpUWNtc2JYV3lQVENoZ0YrS2ovaEhyWFozYUhWUDI2Q0JI?=
 =?gb2312?B?Q2F5ayszWktmRHZXVWMvcGhUS0tuWnJPUGpaZGtDRWc5engyRXFmNmlsbi9u?=
 =?gb2312?B?ZmZIckhnVE0xcEZBSTJSU2VUaWJ3QVZQak1wQnk0d2xKWXZERGVudk5UeFNY?=
 =?gb2312?B?Uit0bjRrODBhLzBTc2JUM3J3b0grSVl2dFU0T3BCSmo0R0diTlQyREFBbjBp?=
 =?gb2312?B?NmNKVk5TdFNmVWFiMkNaMjdsU1JWejhBZDlmaWdLVW1BQmZwYkUvY2Qwa1RQ?=
 =?gb2312?B?OGYrb2lPTXA4WjUwUUoyZ1NFQXZZSkpqVUxZZ3h1amtNKzZSWVp3T0ZMVjkv?=
 =?gb2312?B?a2wxVDd1NWZXeXRhZWxLV0t0WHlzNlhuckJ1Q1M1elhwZTN3eVF2eWViQUlO?=
 =?gb2312?B?cit3ZlNpRXZkSUdVcjVNWWlMbmhMWkVhVkFiWjQ3a1FoV1FiaDlEVm9OT2J3?=
 =?gb2312?B?ZkxIa1R3UzJOM3R1SEpGWWhieHVvdklITzM5NkUyMEIzSkJkRkRxT2JEU3lk?=
 =?gb2312?B?TG4wQ1hDdGVBeTQvWko2Qm5hU2lzcG82eUZyNzJWVUFFR0g5RmR3WkxtT2hx?=
 =?gb2312?B?OXhqWjZGZVZTM2pDbVR3dWlwNktXaTlhVDBGTklJakNQelRtZTdkVDJXeVFj?=
 =?gb2312?B?dTBzKzhlZVBvOHkvbVk0WnozaEhWZUZ1ZWtvL256WExIbWdzRXhxaE93WFZG?=
 =?gb2312?B?aGFhU3VvSkNoTnQxR1ZYQnFLYUlUV1YvSWsrY3JkQzM2WHE2aUlOTFg1Q255?=
 =?gb2312?B?QlBVWW1YRVE4djZDSDVxNVBkUExtSCswcEd5Q0JESTFQYWl4alFFRjRBeStH?=
 =?gb2312?B?TFlMckhxMnpZbERXdXhKMmR0blVzM3E3TlcxMGRhUU4rVE9Fa1pmM0xCc3d0?=
 =?gb2312?B?RFhYS1MyYjFwUGVGRGoyaUU4ZVk3aDBVUkxkVlQrc2hBL2RIcWlMRlRLNi9B?=
 =?gb2312?B?dUxqSXp5VDBTZVlyM2hiUjFEQ2pXT3FsalFuSkdDMVU5alptQlB5dWlEKzRt?=
 =?gb2312?B?c0NMZFdMbmNrMlVVZG9YV3JpeHhWbnR1cGhpNUFvcEhwalozSTlMeDF0QlM1?=
 =?gb2312?B?ME8ranpFSmhWaFZCbmV0T2piRTdmVGo2TnVWMGdqbFM5WDEvN2g5OFd4dFIz?=
 =?gb2312?B?S3krbHo2Tm11dlhSZDUwdWJxZ0NRZ21KcElFVnZtVjRmZHpMakVoQW1uSWV2?=
 =?gb2312?B?N1Jjc1VPZVVhYVkwN1ZnMGRVYkY5TnN0SEFlTW1QL08yL3FTTTR5cWZaMTda?=
 =?gb2312?B?dkc1d0k2Z3k5TUxPOEJCS3VHc3RrdlB5WW1KSEdYREVDMmFQaE1nTUdZK3JX?=
 =?gb2312?B?UW03SEg2Q3VXMUE1SmRpSkRTWWxsdGxIRGhQNEZqMExEZjF3dDc0N0Y2UDBD?=
 =?gb2312?B?RVFBZDlab3FRczRUYk1WYkZlOFdpT1ZBa08rdHRlMDZZSlY3MGN0SFRRaTdJ?=
 =?gb2312?B?VTB6d2dISzlCckJFOEtqR1ZuUHkxaW1ETm15UlZQYndQb0YvK2RrQUE2aExh?=
 =?gb2312?B?d1Rydlp2bkdwT01HUDRKdGd0MjZnbVlFWWFKVTJtMXBwNTR0MHU3R1lYMUkr?=
 =?gb2312?B?RE91YnR3b1FNa0RQUVJmbkhtd0tqRjRvK29oY3crQTVqUzlvWmprYWhoTGZT?=
 =?gb2312?B?QWoyQ0xiNG8zTytHNTJDek56NVhCbzg5OVRhVEZlVHhpdEtmWGQ5WEhjaXNx?=
 =?gb2312?B?ZlhqNy9McFhOK000RXlqL3NqNHg4WEVSQzhQZHRZYUxqOGx2WTJRNnVIelpa?=
 =?gb2312?B?V0NUbTFQdW05S25xZkMxcHFhdVRVOHhpOElURCtIZThqdUc1MTJpbVZ2dzMr?=
 =?gb2312?B?ZUZaN3hCUDRFcjJObkE4M2NQQno1NnpBNTkzdjJ4VG9TOWZ2d1pWUkxWSVVs?=
 =?gb2312?B?YmlvM3Rnc3YySGkxWjZkdWNqS3cycWErVTBSeGdnNHZZOUVWN1dUaXZMUzE2?=
 =?gb2312?B?aEFsV3NScE1oSHpCMFZ3TDRGeG9TOUpzeTNTWVY5UmJGZFJ1ME94cStERXlC?=
 =?gb2312?B?dlpEVG9kcGNoaEZvV3VEQzJab3hWTlBXcWJuRXNLZzJPRzJEQlBmVUNMekZs?=
 =?gb2312?B?eXVXNlNLMDBwbkdrY2RRb3ptZUpYZndDYUtTN3BvU3FQOEpiNy9EOW9FcVQw?=
 =?gb2312?B?aU9yNlB4ekQxb0NFcFprc2l5eHJRZE1qTWpJSXRiVHZkUlFGV0EybjRKTmlC?=
 =?gb2312?B?eGpieEJQbFhLeUFyeWE2NEtXVG9LemVrNkV3bW9yeXVlWnRHbFVKMTlZaE56?=
 =?gb2312?B?bTVPS3Y5NkZ4Z24vNWlQbmx6OWhiVmVtempVRG5GaUNXcnBDZlhHOXZhZnFZ?=
 =?gb2312?Q?gUHitohwHxdM9nQ7Dh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2007a9c6-ab19-4b98-56d3-08deed461d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 07:50:52.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ0yQrzGx2pxH0sLkDNeEf+rexLasxS73DhR+giDFBYIirGPZlmWuIKMnEp+Tg4x0LD6J3GOlGDqtqCcYM68PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaWF3ZW4gTGl1IDwxMjk4NjYy
Mzk5QHFxLmNvbT4NCj4gU2VudDogMjAyNsTqN9TCMjjI1SAxNjowNQ0KPiBUbzogSGFuIFh1IDxo
YW4ueHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IFlvZ2VzaA0K
PiBHYXVyIDx5b2dlc2hnYXVyLjgzQGdtYWlsLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2Vy
bmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYXdlbiBMaXUgPDEyOTg2
NjIzOTlAcXEuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8zXSBzcGk6IG54cC1mc3BpOiB1
c2UgZGV2bSBydW50aW1lIFBNIGVuYWJsZW1lbnQNCj4gDQo+IG54cF9mc3BpX3Byb2JlKCkgZW5h
YmxlcyBydW50aW1lIFBNIGFuZCB0aGVuIGdldHMgdGhlIGRldmljZSBhY3RpdmUgZm9yIHRoZQ0K
PiBpbml0aWFsIHJlZ2lzdGVyIHNldHVwLiBJZiB0aGF0IGdldCBmYWlscywgdGhlIG9sZCBvcGVu
LWNvZGVkDQo+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBwYXRoIG5lZWRzIG1hbnVhbCBjbGVhbnVw
IG9mIGJvdGggdGhlIHVzYWdlDQo+IGNvdW50ZXIgYW5kIHJ1bnRpbWUgUE0gZW5hYmxlbWVudC4N
Cj4gDQo+IEZvbGxvdyB0aGUgbmV3ZXIgc3BpLW54cC14c3BpIHBhdHRlcm4gaW5zdGVhZDogdXNl
DQo+IGRldm1fcG1fcnVudGltZV9lbmFibGUoKSBmb3IgbWFuYWdlZCBydW50aW1lIFBNIGRpc2Fi
bGVtZW50LCBhbmQgdXNlDQo+IFBNX1JVTlRJTUVfQUNRVUlSRV9BVVRPU1VTUEVORCgpIGZvciB0
aGUgaW5pdGlhbCBhY3RpdmUgd2luZG93LiBUaGlzDQo+IGtlZXBzIHRoZSBlcnJvciBwYXRoIHNp
bXBsZSBhbmQgYXZvaWRzIGxlYXZpbmcgcnVudGltZSBQTSBzdGF0ZSBiZWhpbmQNCj4gd2hlbiB0
aGUgaW5pdGlhbCByZXN1bWUgZmFpbHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWF3ZW4gTGl1
IDwxMjk4NjYyMzk5QHFxLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3NwaS9zcGktbnhwLWZzcGku
YyB8IDEyICsrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZz
cGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAtZnNwaS5jIGluZGV4DQo+IDFlMzZhZTA4NGRkOC4u
NmJlNzg3MTJiNTM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0K
PiArKysgYi9kcml2ZXJzL3NwaS9zcGktbnhwLWZzcGkuYw0KPiBAQCAtMTI3NSw3ICsxMjc1LDYg
QEAgc3RhdGljIHZvaWQgbnhwX2ZzcGlfY2xlYW51cCh2b2lkICpkYXRhKQ0KPiAgCS8qIGRpc2Fi
bGUgdGhlIGhhcmR3YXJlICovDQo+ICAJZnNwaV93cml0ZWwoZiwgRlNQSV9NQ1IwX01ESVMsIGYt
PmlvYmFzZSArIEZTUElfTUNSMCk7DQo+IA0KPiAtCXBtX3J1bnRpbWVfZGlzYWJsZShmLT5kZXYp
Ow0KPiAgCXBtX3J1bnRpbWVfcHV0X25vaWRsZShmLT5kZXYpOw0KPiAgCW54cF9mc3BpX2Nsa19k
aXNhYmxlX3VucHJlcChmKTsNCj4gDQo+IEBAIC0xMzQ1LDEyICsxMzQ0LDE1IEBAIHN0YXRpYyBp
bnQgbnhwX2ZzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAlp
ZiAoaXJxIDwgMCkNCj4gIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBpcnEsICJGYWlsZWQg
dG8gZ2V0IGlycSBzb3VyY2UiKTsNCj4gDQo+IC0JcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4g
IAlwbV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheShkZXYsIEZTUElfUlBNX1RJTUVPVVQp
Ow0KPiAgCXBtX3J1bnRpbWVfdXNlX2F1dG9zdXNwZW5kKGRldik7DQo+ICsJcmV0ID0gZGV2bV9w
bV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+
IA0KPiAgCS8qIGVuYWJsZSBjbG9jayAqLw0KPiAtCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
Zi0+ZGV2KTsNCj4gKwlQTV9SVU5USU1FX0FDUVVJUkVfQVVUT1NVU1BFTkQoZGV2LCBwbSk7DQo+
ICsJcmV0ID0gUE1fUlVOVElNRV9BQ1FVSVJFX0VSUigmcG0pOw0KPiAgCWlmIChyZXQgPCAwKQ0K
PiAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBlbmFibGUgY2xv
Y2siKTsNCj4gDQo+IEBAIC0xMzYxLDEwICsxMzYzLDYgQEAgc3RhdGljIGludCBueHBfZnNwaV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiANCj4gIAlueHBfZnNwaV9k
ZWZhdWx0X3NldHVwKGYpOw0KPiANCj4gLQlyZXQgPSBwbV9ydW50aW1lX3B1dF9zeW5jKGRldik7
DQo+IC0JaWYgKHJldCA8IDApDQo+IC0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAi
RmFpbGVkIHRvIGRpc2FibGUgY2xvY2siKTsNCg0KWW91IGZvcmdldCB0byBkZWxldGUgdGhlIGZv
bGxvd2luZyBjb2RlOg0KDQplcnJfZGlzYWJsZV9wbToNCiAgICAgICAgcG1fcnVudGltZV9kb250
X3VzZV9hdXRvc3VzcGVuZChkZXYpOw0KICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsN
CiAgICAgICAgcmV0dXJuIHJldDsNCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiAtDQo+ICAJaW5p
dF9jb21wbGV0aW9uKCZmLT5jKTsNCj4gIAlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJx
LA0KPiAgCQkJbnhwX2ZzcGlfaXJxX2hhbmRsZXIsIDAsIHBkZXYtPm5hbWUsIGYpOw0KPiAtLQ0K
PiAyLjM0LjENCg0K
