Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5251378D8C;
	Mon, 28 Sep 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592139; cv=fail; b=ehwU6OFaSi2R1NhgUUpDTCWd1XmIg/CFdwYTg61mPWrRUppVjvyUlUO21M97CPHPvpRV/8Iu3Vk38TMp8CJOQWbsLXKduhM2PvZ6ccNDrjIHoJ5ctwfhcNdTGgOz8DjNEfA2kcIyUYkL8nMJAppEInUwEgYhEjGTfzkN/hXSmg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592139; c=relaxed/simple;
	bh=1WDHeJD214VRBBAXvHvhUCEKpIKXFRUqad3QrrfFtzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ig7tbuPEevnkv5JHzojTXaSNEqrrKx/oeuSol9HBFVm/BrjNB1J5PUOAsPhyMRij8ZEJ/6FqrnOL40jODS+KO38B3gFjwC2JtJ6VHg4ZLrKghsCUft3oUDzaStNNtN9Yd7QM+baw1PYEYe0GVilBYxJwTNstWy7YgIf6W2agenQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rR2T3q+R; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rR2T3q+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHd6glVRCNC3Rhd5RscKE2olQS9Gg7EaLV3dFNjjeKYTdJrydFzOnSxbut5+DbqhZg9UMKZuc60SZsPV9FKgD0pJffWChuP/ln2/H+EgHeovxD+guhCYb4t2vq6TnKqXjwA48vylm55O7lKIOIxeUcIlEws6V0I6MH24hlv80lG+sxBdeXiPwBEDzba2TgG8jox+/WzaBbBFGoOfkko7p9nMb4KppX4G51Hd32nX2rx2oQ7PEXtVFyFVI8rlKDQu6a7pAReIdoa21exOWVG9vxDJ03rKm4tXT+Gze1otKMHUtPHL1ya1MUyoRsllpsfwlaMhp2QAPwpC6ePU53016A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQeBeKSHAbushvMp+X1gKHzNUl+EgWFB1mpjfj1DYKY=;
 b=UOswNyvsGTzBZwmZ4vQEOMYQh607gdslvIKf95FEUXxGw7jHxC6kHORCCrnjA3ClprGP9Nc+NaD+Lv621Zd8sXFihP//F8odBZbAIMZ79JLBhNEbbgZrc22aDD8dk5Q/no8QoM4zrPvUsn48PwANdDdUWxhrRv3ZLehhSnKtoh1CI5Aa89dpga9uCM86zby9QM476tTq4AhA2Md6D7DqP0mYUBkYafiPCffLGRe+//TO1btMeU+V0uZPWZncY3y1F8aq0wsJVVog37n+/IoND9o5i2pl61BmCvceEBmLAzje4zS9d9xGN9Q1sL8LGtYnmrPhq8acY06yqwW3gcJRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQeBeKSHAbushvMp+X1gKHzNUl+EgWFB1mpjfj1DYKY=;
 b=rR2T3q+RHOihGXf+ZPQAb2r8aJMYr6WJX9TB15j2j41qls0BIQG7aS1xQY0Nl3E3aW2N1jdrgi1JpispJmMQIvx4H4N0zPjB97Vuf6dmQgu7q50ZQX6O+hJTOUJEp+naXi26g8exat3JEZF8Y+zP8AQHhLToTyL6BTxBpZ19+eIdEAaZFv57PFXeE7pt+vrtP2Hnlg6t+3cKyuDxi5fUc5FV5ysjhmddUP2RLmm6aIt9+ub3wmzE2l1C0H3qI6xdvNQjC0Tbz6rm5NS4kcCKI4wbqmytog+zxy+WOOo1qVw38EEm530RtV0Dq5F5vJ0JvjkN7VkNHPwazvgEeJVy8g==
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13)
 by DU6PR04MB11207.eurprd04.prod.outlook.com (2603:10a6:10:5c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 10:42:13 +0000
Received: from AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb]) by AS8PR04MB8820.eurprd04.prod.outlook.com
 ([fe80::35d2:bfbc:a06e:fcb%7]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 10:42:13 +0000
From: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>
To: "Bough Chen (OSS)" <haibo.chen@oss.nxp.com>, Michael Walle
	<michael@walle.cc>, Han Xu <han.xu@nxp.com>, Yogesh Gaur
	<yogeshgaur.83@gmail.com>, Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Thread-Topic: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
 reconfiguring MCR0 and DLL
Thread-Index: AQHdHnn8mtV/xpfGAUqE7UZWq2EG2rbd3BGAgAAE/gCABk4EAA==
Date: Mon, 28 Sep 2026 10:42:13 +0000
Message-ID:
 <AS8PR04MB88204E3900A3A9639911E178908D2@AS8PR04MB8820.eurprd04.prod.outlook.com>
References: <20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com>
 <20260728-fspi-clock-v2-2-dbe786a4a6eb@nxp.com>
 <DLNGOZHD5KI6.26QUK1IZB7UJY@walle.cc>
 <AS8PR04MB8820ABF469B46AD6AD36AD2490812@AS8PR04MB8820.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8820ABF469B46AD6AD36AD2490812@AS8PR04MB8820.eurprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8820:EE_|DU6PR04MB11207:EE_
x-ms-office365-filtering-correlation-id: 2055d108-792b-47c7-0af4-08df1d4d286a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|38070700021|4143699003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 7TJx3Y+Ov6tWpC0Dv4ET9lxmzHk1VEk40dbcBrXQIOuUR//eYAeQPavhIO0UTqufBMd0B0bL1g5BUzqElFuC//SDCR91K9K8MOgKCBD7XYDJgN1hFTZZY/6blhIdN3lxQpFD3RuQjFYeEUDwCll+S7YQ03i3iyaPxR6H0TIJvauIDNiOrTrP58pO6jIbRIhG8jt67FT2hx45AcuPkLMjruyXzr32QS9H0pL+pIcz7k+k+Kj05ygDyxZyEA6YY+ytfTSSLbNC/zWrnhq+kK5NASl9Dkn1I4JHU48HCKUXhepzbiZm+JQ5vhD5sJ+UMAnu6Un9DDSFCIpCyGpH4yT9kZwu07ap2wtPJw9OirVbnu55bjmZMwnc1byWl9WoOUO/X7nBvTrkEBmqCcFpAWk6g252Qci1Xws53soZR0qyfhQBgPhK0b68JVD4rojzHTu9xAS/Xt94qstSsva9UfoVUV00M1ldALTbu0bgFsJAzVmD+IFIj1zlZJ3k6YBYeuj1L6+/u4LOUHQNtNhwaZ3gWZ/QHeijArZ9ng71FMTDG9KxEq4tSCTkv0JY7qEQ6uMVI43eJy73nT2p5yvQhmCtM9DJmoEwwUIHfrQf1CbtLrMRzRJ5gwsGdZ8P3tGGJYS2zjiBNH5PDNCV/eK/T7qsCiI0W3Ox4slT2YL+ZPvLuS8QJoEn+C/ZgsczARN6j/EacQ7COEC1K3dJYOuOA0sZW0etaHPU5Ivyp4X6FSmQN7g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8820.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(38070700021)(4143699003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WmJnUE9udmliKzNwMXd6b1lRaGgyUFNwZmVkSG5xNVJvK1NDTHdJeDV2?=
 =?iso-2022-jp?B?RlVNSzFzVXBwR3FXUCtoWEwzTm9LQnFCVzlSb0dNdU9yTjVVbytYSnA0?=
 =?iso-2022-jp?B?alQ5TTRxWmViV1lPdG9USVV6d25wV3E1VzhTbTk1Rk9nMVFmaEFidFYz?=
 =?iso-2022-jp?B?QytpM0o1ZGhWZzNFYWRJM3Z0OVB5NWlINjY4VWtJNmhyTGpDUEk4VDY3?=
 =?iso-2022-jp?B?UUNHeGR5UXRnL0dydDJHQzhwdS9zdWNDRjZQb2NJaHR0dnRJSE9PbmZW?=
 =?iso-2022-jp?B?K2hiaU1kOTU0ZkRlQmhFQ2p6MGZwUW4xNjkzbENCbXhhSnJtWU9iWk9J?=
 =?iso-2022-jp?B?amJ5dzkyRG4yS0h3akFSdjczUjNhRFBVRHZsUGRGVFVJSEdxblE3MW9p?=
 =?iso-2022-jp?B?NFhreVFWTmgxSXZsbWZPbnJDd25SUHd5Z0JXY3JiK0RxVEJCbWpGcWls?=
 =?iso-2022-jp?B?UWF3MDVJTER4WllLT0VJQkFZZG5YMmJVRXpZYWJXWUd2WTYrSm9JenlH?=
 =?iso-2022-jp?B?bWppcGVUWG5mU3VoeDg4R0FPTFl1SWdCZGFiMW5tY1dManBBY3l0M3JG?=
 =?iso-2022-jp?B?blMwUS9NZzhuZXYrWVlDQlowWVYvRENFRCs4eWVLdnN5S2NTNmttL2tL?=
 =?iso-2022-jp?B?WXdjY2hRR3NqaDNIQTJsZmNSSTF0SE44bVRVeDQ5SEJXNjE5RUVVa3Vi?=
 =?iso-2022-jp?B?ZzhpUDNzWjdWclBPL204dkh2dnZRZmYraHZZY2huZFo5clUyNXhBM1NY?=
 =?iso-2022-jp?B?dkZHQms4ditQTUtYWWhyM0hLUEd5NVJESnBrQnpYa0tqaHQwTUQwQlNG?=
 =?iso-2022-jp?B?VUlNY1F4eDRMT05aVGk3TUoxMUlYcEhSMzIwUWRDMm9LRzduSzZyYkYz?=
 =?iso-2022-jp?B?c29vR3NjSTRGU3dXT2tyOEZacE5qaW01dDRpNURDZzQ5NHBqT1lDVTNw?=
 =?iso-2022-jp?B?dSt0UHp5UlExMmlaNmxVNTdzT3NTaFZoanZQZHNqSnd5RzV1YXBnNTB3?=
 =?iso-2022-jp?B?NGw3LzJ2TFN6Y1B5OTBIWG9zSDVtb3YzU1lraHdFZEFya2xIWEszWWhp?=
 =?iso-2022-jp?B?bHNqV0s4Z2pad0ViL0hnaG9Kc3BETllMdDhEOWhnajR1a0ZPNFZha1lX?=
 =?iso-2022-jp?B?QlMzYVE4TERJTGxMblQ0OC8rRGp5SVJJcDRMbXpGYkl1ZCtwSzVIT1hz?=
 =?iso-2022-jp?B?TUZMU01YdGRYZ2JYT3dobVV4NWgxc1hjdExDcko4Mk5IcFNoQ1M5TkR4?=
 =?iso-2022-jp?B?TFBtVCs0ejhXTENqck9PUTJ2RkpxNnZhVFpFUlJ0NDFOTEIxTWw1UlZT?=
 =?iso-2022-jp?B?YXRVZ1JSQ0w5VFBTbXg2cFE3Rm9HS1dXTzVXRGM5SHJWRVRqOFcydS9T?=
 =?iso-2022-jp?B?WVVLMGtCWHQ0bjFRMVBhanljejk0TmQyd1lCN01QV1loMXBoSm40ZDlL?=
 =?iso-2022-jp?B?SUxjcHJBYkhMSmRwTHZNSHI1RFBkZlJtTXE5Tk5hakdxdFJ5enhuamJm?=
 =?iso-2022-jp?B?ZFc5K1lUaG5KNW1IRVVISi9BNDhGeTkvTkJvRXdpRUNxeDVpYjFhK3dD?=
 =?iso-2022-jp?B?c0RDU1BhUzNtR2EyckNRN2U1RWxnSUlkYkZYczVZeHI1M2hPNzZWRzdz?=
 =?iso-2022-jp?B?S3pPOHNoK1YxUUFPV3Q3ektvT1JxRVFvbGRtTWdzaFpXVWN3a0hUSHQx?=
 =?iso-2022-jp?B?Sk9IRzcrNGt3S0lrWFBvaHoxMW8zZFArQ2VjNU1kQXF3OUpPMjM3N1BC?=
 =?iso-2022-jp?B?dGlpSDFGUFF3MXJJbGZBVG1rYzZvam01Q3Z6c3FYUENFb29PWkdvL2ll?=
 =?iso-2022-jp?B?ZDhLdjV0d0pkK3UxZE9wUWl2VW90QytQVnJHbHo0SFpRRWwram50dUhN?=
 =?iso-2022-jp?B?RmhseU9TR0doVFpOUkpFWkNyQmJ3cE05VHVuajNwQ0NDZHluRklzVzAv?=
 =?iso-2022-jp?B?aVlUYXNvdGVFbCt3Q0dsVjFNdER0b0dsditEV1Z4WW8rY0FtU0x5d3Er?=
 =?iso-2022-jp?B?MFVBbFZUaEIwQk9nNDRRSUVDU04xQ3hrbGcyVmRtcWZjK0F3REJacnNT?=
 =?iso-2022-jp?B?UzZIamxGRDFLMi9RTXVIQUh2NmI0dzB5RzgrQysyblJKUmtZdzVjTkFn?=
 =?iso-2022-jp?B?TkliaCt5QmFqbDIwR1A4M3llSUdLbVBqb2RzSndnNHJ0VTA0RDNKdDFD?=
 =?iso-2022-jp?B?QWNVK1ZPODFLS3JYcHhSN2g5VWQwU2hsem9NQ2s0MTJKM0c3ZkJKTHVo?=
 =?iso-2022-jp?B?SnlBUnNKdEI4b3JrTWM0bGVQWkhUTVBUemF3aUFLOEl5Q2FiajZIMkR3?=
 =?iso-2022-jp?B?aGtDY0hxYi9JYVNRZkVLeDVTU3VrYnJSNmdMcnZleTBlbFVrT2Y2SnE1?=
 =?iso-2022-jp?B?WmVNem81bU1zUFlzbE5qMGhxMXJqbE14bEV1bndYaHhQZHNOeG1XQmNL?=
 =?iso-2022-jp?B?eExyZWM4ck1hU2d3QnBGeTFhTlJzYVdKRms3aWd3blN0UFBqYUxYSXVr?=
 =?iso-2022-jp?B?R1hzVGk0?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8820.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2055d108-792b-47c7-0af4-08df1d4d286a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 10:42:13.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s345em3NM4aCNBI1j/bIPYQ8VcharD9JD2C5QHhTM6E8VS0DaK5RDODplzbwQ7X1BwbBu86phjuV9fxgTj+XgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11207

> -----Original Message-----
> From: Bough Chen (OSS) <haibo.chen@oss.nxp.com>
> Sent: Thursday, September 24, 2026 6:25 PM
> To: Michael Walle <michael@walle.cc>; Bough Chen (OSS)
> <haibo.chen@oss.nxp.com>; Han Xu <han.xu@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; Mark Brown <broonie@kernel.org>
> Cc: linux-spi@vger.kernel.org; imx@lists.linux.dev; linux-
> kernel@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>
> Subject: RE: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
> reconfiguring MCR0 and DLL
>=20
>=20
> > -----Original Message-----
> > From: Michael Walle <michael@walle.cc>
> > Sent: Thursday, September 24, 2026 6:08 PM
> > To: Bough Chen (OSS) <haibo.chen@oss.nxp.com>; Han Xu
> > <han.xu@nxp.com>; Yogesh Gaur <yogeshgaur.83@gmail.com>; Mark
> Brown
> > <broonie@kernel.org>
> > Cc: linux-spi@vger.kernel.org; imx@lists.linux.dev; linux-
> > kernel@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>
> > Subject: Re: [PATCH v2 2/3] spi: spi-nxp-fspi: enter stop mode before
> > reconfiguring MCR0 and DLL
> >
> > On Tue Jul 28, 2026 at 12:18 PM CEST, haibo.chen wrote:
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > In nxp_fspi_select_mem() the RX sample clock source (MCR0[RXCLKSRC])
> > > and the DLL control registers (DLLxCR) are reconfigured while the
> > > FlexSPI module is still enabled. According to the FlexSPI reference
> > > manual initialization sequence, MCR0 and the DLL control registers
> > > should be programmed while the module is in stop mode, i.e. with
> > > MCR0[MDIS] set to 1, and the module re-enabled (MCR0[MDIS] =3D 0)
> > > afterwards.
> > >
> > > Wrap the RX sample clock source selection and the DLL calibration/
> > > override reconfiguration in a stop-mode window to align with the RM
> > > and avoid reconfiguring timing-critical registers while the module
> > > is active.
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> >
> > This will actually cause the following error on an i.MX 95 19x19 EVK
> > (imx95-19x19-evk.dts):
> >
> >   nxp-fspi 425e0000.spi: DLL lock failed, please fix it!
> >
> > Any ideas what causes this? I'm running the latest linux-next kernel.
>=20
> Hi Michael, thanks for report this issue.
>=20
> I can reproduce this issue on my side also, will look into it. I'll get b=
ack to you if
> I find anything.

Hi Michael,

I find the root cause. There are 2 issues here.

1, for the log:  nxp-fspi 425e0000.spi: DLL lock failed, please fix it!
    Yes, it is really involved by this patch, For DLL calibration, need to =
be done when module enable (MCR0[MDIS] =3D 0), otherwise, DLL will not lock=
.
    I will do more test on other platforms like imx8ulp/imx8m/imx91.  Will =
send one patch to fix it.

2. for the dump log: WARNING: drivers/spi/spi-nxp-fspi.c:1079 at nxp_fspi_e=
xec_op+0xd88/0xe3c, CPU#1: kworker/u24:4/64
    After debug, I find even DLL do not lock in 8D-8D-8D mode, the first tw=
o command also done successfully, but the third command always trigger the =
WARN_ON(ret).
    Here is the command information when I dump the LUT.
[    1.887237] nxp-fspi 425e0000.spi: CMD[9f9f] lutval[0:879f879f 1:a700b31=
0 2:00000000 3:00000000], size: 0x00000006
[    1.897633] nxp-fspi 425e0000.spi: CMD[505] lutval[0:87058705 1:a700b310=
 2:00000000 3:00000000], size: 0x00000002
[    1.907950] nxp-fspi 425e0000.spi: CMD[3535] lutval[0:87358735 1:a700b31=
0 2:00000000 3:00000000], size: 0x00000002
  =20
CMD[9f9f] (RDID)=1B$B!"=1B(BCMD[505] (RDSR) can be done normally=1B$B!$=1B(=
Bonly CMD[3535] (RDSR2)  trigger the timeout.
the spi-nor on imx95-19x19-evk board is mt35xu512aba, and it do not support=
 RDSR2. I add the following change then issue gone:

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-s=
t.c
index f97f2dead8c2..35bf386bb66a 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,7 +180,8 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor =
*nor)
        nor->params->cmd_ext_type =3D SPI_NOR_EXT_REPEAT;
        nor->params->rdsr_dummy =3D 8;
        nor->params->rdsr_addr_nbytes =3D 0;
-
+
+       nor->params->opcodes.read_sr2 =3D 0;
        /*
         * The BFPT quad enable field is set to a reserved value so the qua=
d
         * enable function is ignored by spi_nor_parse_bfpt(). Make sure we

This is involved by commit 63489002d397 ("mtd: spi-nor: Refactor Read Statu=
s/Write Status support"), seems not only micron-st is impacted, I will find=
 a correct method and send patch to fix it.

Regards
Haibo Chen


>=20
> Regards
> Haibo Chen
> >
> > -michael
> >
> > > ---
> > >  drivers/spi/spi-nxp-fspi.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > > index
> > >
> >
> 6de6d432cdcb2ee383a02d72f20000045903e176..a426b8d92193a4e303f4
> > 11cd17c1
> > > 6cb31c3f3873 100644
> > > --- a/drivers/spi/spi-nxp-fspi.c
> > > +++ b/drivers/spi/spi-nxp-fspi.c
> > > @@ -867,6 +867,7 @@ static void nxp_fspi_select_mem(struct nxp_fspi
> > > *f,
> > struct spi_device *spi,
> > >     unsigned long rate =3D op->max_freq;
> > >     int ret;
> > >     uint64_t size_kb;
> > > +   u32 reg;
> > >
> > >     /*
> > >      * Return when following condition all meet, @@ -896,6 +897,15
> > > @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct
> > > spi_device *spi,
> > >
> > >     dev_dbg(f->dev, "Target device [CS:%x] selected\n",
> > > spi_get_chipselect(spi, 0));
> > >
> > > +   /*
> > > +    * Per the FlexSPI reference manual (initialization sequence), MC=
R0 and
> > > +    * the DLL control registers should be configured while the modul=
e is in
> > > +    * stop mode (MCR0[MDIS] =3D 1). Enter stop mode before
> > reconfiguring the
> > > +    * RX sample clock source and the DLL, then exit stop mode
> > afterwards.
> > > +    */
> > > +   reg =3D fspi_readl(f, f->iobase + FSPI_MCR0);
> > > +   fspi_writel(f, reg | FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> > > +
> > >     nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
> > >     rate =3D min(f->max_rate, op->max_freq);
> > >
> > > @@ -928,6 +938,10 @@ static void nxp_fspi_select_mem(struct nxp_fspi
> > > *f,
> > struct spi_device *spi,
> > >     else
> > >             nxp_fspi_dll_override(f);
> > >
> > > +   /* Exit stop mode now that MCR0 and the DLL have been
> > reconfigured. */
> > > +   reg =3D fspi_readl(f, f->iobase + FSPI_MCR0);
> > > +   fspi_writel(f, reg & ~FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
> > > +
> > >     f->pre_op_rate =3D op->max_freq;
> > >
> > >     f->selected =3D spi_get_chipselect(spi, 0);
>=20

