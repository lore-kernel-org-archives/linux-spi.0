Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD592EBDFA;
	Wed,  4 Mar 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609001; cv=fail; b=MJCYshAJkaewIw1VOmycl/7WSX3thGjPqqCWYhhuYxg+WjeNsd2FU2undSLNqMceM4QrUiP4BPPi5ufBx1Xv47JT2/g7rSt+vI/Ee6soCMZqLV1DV5HkPZzZRvhsfxtzYpbLQssQ1CfpDGaFlPROJkwUIpaZ2VV7nxjdNAr5uSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609001; c=relaxed/simple;
	bh=Cw/NWFDU/fMLZq3ct8aixPQVTAZheQ6P1bV3rQ7tYHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bwc/L71QVxpRkVv1QsV9PbvnZAoTAVtVCkP8/ErjE5dXG/GUrCDJ2+W5DXks4TYLcoE6z4LK0XOCE64ZjZdDzIlFVibEEhY0KnWAp1t5VgHf6cqcm3rzpWpAnrlvJcWEdR5faZau+3MT/tPjYiZ03Qjn61YGS3ceqc/PZTwdqoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C10LM7I/; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C10LM7I/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOiGSovxDTSSa2eYA3c+vimhKO56Fu0Hy5CH+mXQzGQ9ADNq3vSW6WC4iytF2/NkHdAZaPZMqnC5LOiq7zxIx8NHVqGU235a8DQhWGpoxvNMnkoeMkx52guYcfQXhHDjz6EFvkojpL/1L6SoxaGrZCLCJX7VF9SrHV/ATLMCtUxT3TaFZAFi2O0PFndV3j7tUIBhnFDYvrEuGkkqDd/fGNjFX0Zx6uM0Hlq/UNOg7pqX/GRxhwR3OeQGSEEyyyef+u2M16/n/xP49g2b4Jy9MXumH5uFvRNkZfbX4F9CoyGygMXUG5qMrFTPvyUZCnc2r9VH5iksY4tw157nkEGxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw/NWFDU/fMLZq3ct8aixPQVTAZheQ6P1bV3rQ7tYHw=;
 b=VdCBUStQfhSC20recNqNd32zCAmwLLobjK7XrU1Glt423PWRUIvRGQ7/JCQhtQrDP9RYGQv0hIDjOTJ+MzV7KpTY/xmKJ4oGrylvqNVvJFobADCfHmtuC74ebKEfIT/2O2NPVR4t2eMqKuF83N4I0YIDjNmfG0O1CPkeeEwdY+Heq3xVFklw8Ft4ZKLG7yqhouXxTL+5q3ScQdeWC5SuRgtt5LIASDB8nzYaHiYHCqUBYcfZOxAWOEIdBuNrAmhlnhmJ/GkEC0zkMyaJ7jc9tm5E45VZJ7gPLIBOd9xuHOxrcO4s48oY+2SGgdEa5rHiO7hIhM37fIqWYTs/5Wxabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw/NWFDU/fMLZq3ct8aixPQVTAZheQ6P1bV3rQ7tYHw=;
 b=C10LM7I/u8VYWtRk3eeRz5Sob/rNq/nfPDrTjZFRV+GgUjizX729Xk+kIZvGYpt9q27KTzDJAgYIAfgCw/u5AMsa8tFiRbp5KSrnpphjp3djW+rOmHvof9yRF7dv3y2/nWveauPc3YgabcD5H6FmIMKPaIHbKz3Npq6Mg0i5csUuUTTQ6zMAMdZk0F3wfHf3jwclrxQBeEMbNdk7j1K0SCdQfuBU6Iq9DlSApIrVdvFwRww81nufdDry4615HPH5x1lmLKH9a3iA3pQhFtmI2Ix0ielk3cDCkGy2zM5q2BNzXua6p+un13gY3OWtEQyFbFHkgo8uXDSN7o4is/H+Dg==
Received: from DU4PR04MB12275.eurprd04.prod.outlook.com (2603:10a6:10:62f::18)
 by AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 07:23:17 +0000
Received: from DU4PR04MB12275.eurprd04.prod.outlook.com
 ([fe80::88a6:c1a8:65b2:aa76]) by DU4PR04MB12275.eurprd04.prod.outlook.com
 ([fe80::88a6:c1a8:65b2:aa76%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 07:23:17 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Felix Gu <ustc.gu@gmail.com>, Han Xu <han.xu@nxp.com>, Mark Brown
	<broonie@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated
 operations
Thread-Topic: [PATCH] spi: nxp-xspi: Use reinit_completion() for repeated
 operations
Thread-Index: AQHcqxCq9DcDXtsQJkeFtEwGZhMHyLWd90ww
Date: Wed, 4 Mar 2026 07:23:17 +0000
Message-ID:
 <DU4PR04MB12275755ABE75588FF75BF65C907CA@DU4PR04MB12275.eurprd04.prod.outlook.com>
References: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com>
In-Reply-To: <20260303-spi-nxp-v1-1-b78570db28ce@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4PR04MB12275:EE_|AM8PR04MB7315:EE_
x-ms-office365-filtering-correlation-id: 4bea9d5e-3e34-4b40-227b-08de79bee7c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 aY12CA1nXeAQel86G/0GjcmwxH+2FgFXiZbsPmaHQCd/bwgZJ/suW0wsYQ6GwuU4yUb3JPoFMsDr0MxlzT07dx1obLhxsWA7uXWBr6rX0O5INqD0XNM6fNlsokNkEced5PYuWyHzdfc6wEvCHMiS/zLdI5s2HnuZPbTiz5TADoztQe4oss3TqrxwkStL979s22C/c4BvzLWseKyiShMdM8VtWx2U7EEZiDKiZtXkLWwlL1V8uO85j8eM6R83tMtcPgZPnjcraS2X31i7Jzkzgf0E1A47r4VjGetjLwvtv663Y3u9tV6fwg6gNdIhrzpzamPM8m3YrZxKE4J99zA4h/XiVrx9tLUMvCg9KZAvx1LMdco+5MJQ5WyHqQbCZ1cd8yeI/6yNfhx2n+GmTmjacw1O5CSsGVmxtsG3DJolOF09fjmuvIxvahfDik8vcV3GFJTJdpW4MokicMsvw3pK0C2fnl6Lc1ynpxBo2eTMFwD3a1O0vRPjqCbEEGHAh09elNCo62SE5+Zu4wHDEjzXcEZYlSskzWSYQ71JD9rfYH1Uo6uaZuXBqDkwhwJAd28shv+bVoz7oYVBZaIoL7Ma4//nBrxKY2PisYVkATBwS6GzmzRiYluYyAKkT9mk8RLfLIhqrpUmed6j9e18BI7IXzoQRNjnRQ/oxfpyzLtRPF07jFpgjfTgptNn7XTbMlxqhwhGcbOngcclfgo7J1eULnqPQIdjO6yFP8fJDmuMRtup/OvffFZMv3a28IHYXJaTF+1l7PG+eYG6PIAzeifjnvWixxwxDamM2ngkpB1Ad/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB12275.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3NHZVNxcGpRbnBMdHg4Z0FacGp2Mzd4MEd1dkNjS0FVTU4wdkkrT245cUFT?=
 =?utf-8?B?MWJBV2s2eHczNzhRSDVYaDFyMk1Fekh0VzQrV2VvbzhyK3BQbTRiZHlnRjh6?=
 =?utf-8?B?QURqaW9hZUF3MWhMbDFkTVVhdlhqcWw1bTUrRVVnZE5ydE5nRTIzbENURlRI?=
 =?utf-8?B?aU1YMzd3Ynp0S3BjaDcycFRSaEQxcE9PNUgzeDQ1bnBGZStuMW9vUDcvb1FG?=
 =?utf-8?B?cVJtTzVJMkl5b015am5LR09pakl0R2FoNHFEV2N1aXVob2JxUXlWc3ByQUdR?=
 =?utf-8?B?S2ZFZk9qM0JScWJaWHZ3QTBYUXBGdk9LQjgvQmlCZndZTzBWV0NKdzgvM1Y5?=
 =?utf-8?B?RG9CbTBkUTdhMnZyZ2ZXYUdBUElCYUtqd3VTZ1RVVSt2YnBvOXhyeEd1OVF1?=
 =?utf-8?B?alZuNmtkMXJjaHpDZXFjZE9ma21lZFYwNHZvL09oVFJIQktnR0ZzbHZNZ0cr?=
 =?utf-8?B?VCtEZnpTZW95ZGFYRWx2L2hoU0htN04rR3UvMnpvbWNZUE1PcS82YjNucm1a?=
 =?utf-8?B?NnFkcGFvWHZnUUpKa01ONlphZmxuY0xvVVZlWlpsWFRkSi9leEpRRFVWK2RH?=
 =?utf-8?B?d1pteFBuaFpGSmQ2S3pxc28vYkVWWWsrMERmNHJTczNmVXVYSzlXWk9qcWV5?=
 =?utf-8?B?UFVBUnJKZHFqKzBaRmZRTUxuUis2ejU1MGdSWE0xMHI3a0NsNlE2RWpJMmpJ?=
 =?utf-8?B?K1VtMDVPUzhRcURuRklvcjkzcmtQdXBTcmZKSFB4dk5YRlQ0ZDNlSWsvQnls?=
 =?utf-8?B?RWR5TmY4MEpXanViaWRFbHZlbGdrYkZaaDFIL0UzdjZiNWtJR2Vlcmc5SlU3?=
 =?utf-8?B?cXE1RVYyM2VEaTl5L2t3NUsxTTVyZXRVQVViRkxYVXdtNE1aT0JMd09BdG1t?=
 =?utf-8?B?MlpCYXdsOUY2MHk1YzVlYnpxb1hNcW81cHBuRTU5WXNVUi9jdU00UEsxTGJT?=
 =?utf-8?B?MmpNS0g0TFJzUnE5OUFGYi94THVlWXd3cXJrUEdvNWJndHVKVkVXTE03YXBJ?=
 =?utf-8?B?ZUJWcDJkMjdBZUVBZUJlQWxVSW5MTHdVcGdoazV4TVZMZWFIMmtyaFFUR1cy?=
 =?utf-8?B?UjRsR25Qcjk5SCttNU5veHNJSTZObXRSN25oTkFJLytDdExra25va3VFc3Fh?=
 =?utf-8?B?RW5nSVIrMzZvbjNqVW5FR0w5S0VNSE1CQmh6SHhtNDJMOElFdURBbkZVSURI?=
 =?utf-8?B?Tm1uZjVqWjBlb0xOdVlVWHYrRWNRcGl5T2VBbGNNUHE3NGhSTDErdnFRMmNJ?=
 =?utf-8?B?WTZ6Nm1lSmZGWWpFeXFHL0t2N2tqdHhBdUduS3lpT1Q1b1dVS2tqenVxd295?=
 =?utf-8?B?b0lFTHk5RjFvdFE1bkhCMG1NdDFtQ3ppdkh5TlJiWFZaZ21XTUlIY0VqdTFn?=
 =?utf-8?B?R0NnY2xPUjNlUHhPMkUxYUVXZXlJYlRGWnZPLzU0SE1xZWFaWWJISmJYQWsx?=
 =?utf-8?B?SStTMkpsbDNVcGVQSGxDYUVyYTU3M2lQQ3dwUHFITmx0WFVCSkVXc1hadWlw?=
 =?utf-8?B?eUJyalU5THpMalI0aDk4NDMyZVNVRlVPQkRHV3dqaVRtQjRlVXo1TWt2N1VV?=
 =?utf-8?B?WmZTWnM3YmljR2NLWWFqSHB6YjJnTGlzeVJKcXBuZHNLcDBMTnpkcUZyS1NU?=
 =?utf-8?B?UG9WeWdraFNuTDBDUlFwNXc4LzdZWEFEanE5eU4rbUJCVHhVN1dFMXhpaHA3?=
 =?utf-8?B?dFZZMjBHaHZhb2dUVGxMa21qdi9pbEdTQ0JvQnhpUW0xd0o3eXMrOGYrTjJk?=
 =?utf-8?B?aG1mTEpST3Q1bXRWZTZUakV6ZjBRUGp0ZXVQMEdyUFZkZmR5cHNZMElUMG8w?=
 =?utf-8?B?U1BpSGsyNFVDUnJTQTQ1V0VzUVR1K3VQR3RYK1JVMFpqaFdia0hVa1J0SWJk?=
 =?utf-8?B?Q2pzd2ticjZWYmR4cmxVWEpOL21WR1c2QlM2UmZ0NnlTK1ZKODVHeERCNDIx?=
 =?utf-8?B?R09ZQ3JsMExBOVBrZGtKWDBQT1J0MWF6cTFmWDRUT1RxVlVidmo1VHEvVWdU?=
 =?utf-8?B?UGthNFhpOFE1ZUNqNjA5eVdjcDk0eVpsSU50VTVpQi8ydHMrYVF3Yk8rejFM?=
 =?utf-8?B?eTdORnJZbnFuMEExc1p5MUJ5SEhPbGZneDdTQWNzRWJuUkprMTBsOGgvamVG?=
 =?utf-8?B?S0ZXVGZFYklnRkt2SEZlc1EwM3BNM1M1S2tIV2wrVG5TU0w1bzRtbFZmNkR3?=
 =?utf-8?B?Vkxnd3g3YmRYSjN4b3krSFU5VmpPZlduNXdUMzE2cmhpRjY0YUdFcURzNFAy?=
 =?utf-8?B?cU9SSXEyVUdTRmplcHlJQ09VbUNtSVNVSkNvUnJhRkJmVW1TZ3crYzF3a0p2?=
 =?utf-8?Q?1rFlX9g7/H+mFifc4S?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12275.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bea9d5e-3e34-4b40-227b-08de79bee7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 07:23:17.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4EHajub7jUjE7pZW5GKfH47vyqRFWTORxKUt+rtkahi6MzdM5x9/l62BXIIU+RWbYmhIAnxsyeGz84gtZSp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7315

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGZWxpeCBHdSA8dXN0Yy5ndUBn
bWFpbC5jb20+DQo+IFNlbnQ6IDIwMjblubQz5pyIM+aXpSAyMToyMQ0KPiBUbzogSGFuIFh1IDxo
YW4ueHVAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IE1hcmsNCj4g
QnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0K
PiBDYzogbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gRmVsaXggR3UgPHVzdGMuZ3VAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNwaTogbnhwLXhzcGk6IFVzZSByZWluaXRfY29tcGxldGlv
bigpIGZvciByZXBlYXRlZCBvcGVyYXRpb25zDQo+IA0KPiBUaGUgZHJpdmVyIGN1cnJlbnRseSBj
YWxscyBpbml0X2NvbXBsZXRpb24oKSBkdXJpbmcgZXZlcnkgc3BpX21lbV9vcC4NCj4gVGNobmlj
YWxseSBpdCBtYXkgd29yaywgYnV0IGl0J3Mgbm90IHRoZSByZWNvbW1lbmRlZCBwYXR0ZXJuLg0K
PiANCj4gQWNjb3JkaW5nIHRvIHRoZSBrZXJuZWwgZG9jdW1lbnRhdGlvbjogQ2FsbGluZyBpbml0
X2NvbXBsZXRpb24oKSBvbiB0aGUgc2FtZQ0KPiBjb21wbGV0aW9uIG9iamVjdCB0d2ljZSBpcyBt
b3N0IGxpa2VseSBhIGJ1ZyBhcyBpdCByZS1pbml0aWFsaXplcyB0aGUgcXVldWUgdG8gYW4NCj4g
ZW1wdHkgcXVldWUgYW5kIGVucXVldWVkIHRhc2tzIGNvdWxkIGdldCAibG9zdCIgLSB1c2UgcmVp
bml0X2NvbXBsZXRpb24oKSBpbg0KPiB0aGF0IGNhc2UsIGJ1dCBiZSBhd2FyZSBvZiBvdGhlciBy
YWNlcy4NCj4gDQo+IFNvIG1vdmVzIHRoZSBpbml0aWFsIGluaXRpYWxpemF0aW9uIHRvIHByb2Jl
IGZ1bmN0aW9uIGFuZCB1c2VzDQo+IHJlaW5pdF9jb21wbGV0aW9uKCkgZm9yIHN1YnNlcXVlbnQg
cGVyYXRpb25zLg0KDQpIaSBGZWxpeCwNCg0KR29vZCBjYXRjaCwgSSB0aGluayBzcGktbnhwLWZz
cGkuYyBhbmQgc3BpLWZzbC1xc3BpLmMgYWxzbyBoYXZlIHRoZSBzYW1lIGlzc3VlLCBjYW4geW91
IGhlbHAgZml4Pw0KDQpBcyBGcmFuaydzIGNvbW1lbnQsIHRoZXJlIGlzIG9uZSB0eXBvOiBwZXJh
dGlvbnMgLT4gb3BlcmF0aW9ucywgcGxlYXNlIGZpeCBpdCBhbmQgZmVlbCBmcmVlIHRvIGFkZCBt
eSB0YWcgaW4gbmV4dCB2ZXJzaW9uLg0KUmV2aWV3ZWQtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCg0KUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gRml4ZXM6IDI5YzhjMDBk
OWY5ZCAoInNwaTogYWRkIGRyaXZlciBmb3IgTlhQIFhTUEkgY29udHJvbGxlciIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEZlbGl4IEd1IDx1c3RjLmd1QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3NwaS9zcGktbnhwLXhzcGkuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3Nw
aS1ueHAteHNwaS5jIGIvZHJpdmVycy9zcGkvc3BpLW54cC14c3BpLmMgaW5kZXgNCj4gMDZmY2Rm
MjI5OTBiLi43YjJkZTU2MTI5NjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1ueHAt
eHNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1ueHAteHNwaS5jDQo+IEBAIC05NTgsNyAr
OTU4LDcgQEAgc3RhdGljIGludCBueHBfeHNwaV9kb19vcChzdHJ1Y3QgbnhwX3hzcGkgKnhzcGks
IGNvbnN0DQo+IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4gIAkJd3JpdGVsKHJlZywgYmFzZSAr
IFhTUElfUkJDVCk7DQo+ICAJfQ0KPiANCj4gLQlpbml0X2NvbXBsZXRpb24oJnhzcGktPmMpOw0K
PiArCXJlaW5pdF9jb21wbGV0aW9uKCZ4c3BpLT5jKTsNCj4gDQo+ICAJLyogQ29uZmlnIHRoZSBk
YXRhIGFkZHJlc3MgKi8NCj4gIAl3cml0ZWwob3AtPmFkZHIudmFsICsgeHNwaS0+bWVtbWFwX3Bo
eSwgYmFzZSArIFhTUElfU0ZQX1RHX1NGQVIpOyBAQA0KPiAtMTI3Myw2ICsxMjczLDggQEAgc3Rh
dGljIGludCBueHBfeHNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAN
Cj4gIAlueHBfeHNwaV9kZWZhdWx0X3NldHVwKHhzcGkpOw0KPiANCj4gKwlpbml0X2NvbXBsZXRp
b24oJnhzcGktPmMpOw0KPiArDQo+ICAJcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGlycSwN
Cj4gIAkJCW54cF94c3BpX2lycV9oYW5kbGVyLCAwLCBwZGV2LT5uYW1lLCB4c3BpKTsNCj4gIAlp
ZiAocmV0KQ0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBkNTE3Y2I4Y2VhMDEyZjQzYjA2OTYx
N2ZjODE3OWI0NTQwNGY4MDE4DQo+IGNoYW5nZS1pZDogMjAyNjAzMDMtc3BpLW54cC1kNzBiOTdh
OGRmMDgNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gRmVsaXggR3UgPHVzdGMuZ3VAZ21h
aWwuY29tPg0KDQo=
