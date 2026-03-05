Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F2F30C637;
	Thu,  5 Mar 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750090; cv=fail; b=GN6BxhpMfwIwEta6t/bkvhxDXCGmwdlZycCOypwWsEtuFALfgcnjPsmyURgNtEzeJQyJJNFO9pZl8oL93WhM2xJ07RodmhhnQSl7WIpg3IjX75yXwYdJYxBt1wSvJ6JU03wOk/qOu9TlHaKjS3Pxy50//p6tey3VBocFlSJ4udo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750090; c=relaxed/simple;
	bh=TKqLLOgLq51jVj+6Z75cYdjWjRUL54JTnC/kgBrFFLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPLg6NDrwKf2nZuG0sCsm2yDBByL2m7pqmys/5TTHR4Yxe9+dno/WpSx4TF1WHjfu5i4+plbvm6TgDTwlflNA1PGzkLjvMQeaNB9yA4w08e3XRY8d8OlJjR4n4Xa7qSQ0i/tdzlvgXAOsQ58W3AME0E/psx9EQgkqZINn6EfJo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cnTt8ytQ; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cnTt8ytQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIWqGAJu3Pi0osyn5UCcH2k4MdIYIW81NiVu+RL5Huz1Ik8uAfS7ZJ+ZpIKQI4zcfuQZct+zZyzWOCRCYiLc1dKGvYIgy5MZLc2EQAtS6iwzZD+RRAxuQsuPgkYdZ96gPmri2+ZIJVuhtkHa5XKDb8usFISHmJVajTympU3iE/wRFZiTt7JbKIHs8+ZptTw5Ku0XnXHOskaVkrZpU1v9nDsNupgRYfZiHEhsqNKRl6iaSmyV9fiKS+EGRakz8c/QPB6ylGs0YIhyq10n/gDj/WOiE8s7NBQpDZ3cRb+ovvAIzY9g7Uw28Q6q9Dtsnr2WknQoMSy2TPEbummPLPWNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glLgvDuv0o3E3/oN87IDsPUt8k57ykiCOkDQWVE1t00=;
 b=NdY2N+09LcOmbS2sPN8vu/imS9Tdv5qcCvOk5znWeEheWx1ATGCca5fM3f7/rYQKOisglUzpI2RqV47cLLk6GK94C13HtuPxc35k72oEqn6B3qRSxbZwad0poy53+zngJo+1RhPtwU+4CoKZpYIWsMMGeuXtTNUc08aFPC5ncoIiEgGWN+hDMOb36dX4i6xtzdDvDHJNcvuYX067KRZpig6gpD5xd7IalpydWMJXDGNHMlw/Nuq99ql3dioEk9/fgjNjem2vAA2su+odkTs16wadk8ahNx2nsoACKEf5EBEkq8pGFb+p2BOiGhrZQ9i3gslUdaZxgiZq+5mSCLWS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glLgvDuv0o3E3/oN87IDsPUt8k57ykiCOkDQWVE1t00=;
 b=cnTt8ytQMD+rcS3EXxSrMAc9knOWLYLMYBLhppfSypG7Gii18G2zqNKBETtLLmLRGt3T79Z9L8h1qmPQ2mDPwhGiLwKtvX2psHPkJtMV/85iW6oM4A68H8k0u9IwMw/7sPxIUJMfFhaDXbymujapqcyAARDyHtDMGyTsFSfdXEUtJm+lpaGg0T8pR9O7kCNVUkbTf0+J6jsFnhaWwN5ahxoYP8c1/IgF0V7tpXv/7Ip0Ch9+nWMLiPqMKEaByyiovE0YUruIB4UMoKdaoM9h/COM/+u2NNYmy2nJthaQKxp0IWowSjVVUN7lfOcJTbR+zuiQYC6BYqbx05iylq59qQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 22:34:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 22:34:46 +0000
From: Frank Li <frank.li@nxp.com>
To: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Han Xu
	<han.xu@nxp.com>, Eberhard Stoll <eberhard.stoll@kontron.de>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Michael
 Walle <mwalle@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH RFC 1/7] spi: Add 'rx_sampling_delay_ns'
 parameter for clock to RX delay
Thread-Topic: [EXT] Re: [PATCH RFC 1/7] spi: Add 'rx_sampling_delay_ns'
 parameter for clock to RX delay
Thread-Index: AQHcq1EdL8acAPHpxku5HHIxU5RQb7WghDQAgAAE62A=
Date: Thu, 5 Mar 2026 22:34:46 +0000
Message-ID:
 <PA4PR04MB9366BBFB4EAD4C4867398265887DA@PA4PR04MB9366.eurprd04.prod.outlook.com>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-1-9326bbc492d6@kontron.de>
 <20260303210131.2966214-19-Frank.Li@nxp.com>
 <c5c762db-86f5-4ca8-b2da-a7e0b73b8f27@sirena.org.uk>
In-Reply-To: <c5c762db-86f5-4ca8-b2da-a7e0b73b8f27@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9366:EE_|AM7PR04MB6871:EE_
x-ms-office365-filtering-correlation-id: fbf04fef-394e-4529-6c1b-08de7b076768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 Xb3oExehlP9LE8T9KThMOoUzn63mOc8VOxFRge2tRcA5B4y9RlrRUwefwtdLrFG56SKk9xoNH29QMdJ06IuxifaqtCHvjt4Og5ObcjZCjaQhI0IlqkUfKj+wO3iguliTX1SQR8+0vhizDSQDf/DhB40WwB18ye1g0jP2xVgDwhf/L1gaSJE+lgPu8Rkuvy1DUv3G0PkXUbwqmAqM1aXfmB/TFO56pxEnjxpO+NDdp0w3m0Qu7iKzR9FgAkhahjOlEIQy0jto0eFlTiCOw01P9BHAS4pBN5TnTbTd8E6LFErPnJETi4ukAYVANVi6i4e05lf0jjA1Dd/tQmCq5oTeVcdcxR5FTtCoKDApIl2BWw7HU3kf4gH9/cViTcbfUFeG0lDy1gITt3ejGx3mh+E5wK3wOGLdQaZ5sfUxVbA30VmVNv+aUWzGx+rfojtDRozCFSkpLsFQJxyIoxBuJrpwJ/T2fPWPKKp8bbXqXJWc0zaacCovTLFcFraw6VnxfzCUhknr4kR6DXT08nJN53PNFFVLu8GREUlXf5MUbS38QVEBS0DrA901TiboIk0p1aU8hIjk51OtKWZJgriT1GhrFLYDgTtl1d429Sutg9Qj702H4zVcB34MOS9vcQJOYPZoPab0f4TtkVYlLDTHeog7MHn766ilRPl+7qb5uAgbE3VE26w8g+/S0QvAlXxAm/krr/gVDFJSsaRK/vRafvnUEZxIW7r2vAw+WPo8PYzlhhsPiWzCLlv4mUvqZwOnZC+hY3x8vEJnKDDfBK7cyAREfwAdOARF20pbHkJ+mW+woE8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pQZOuTggJpLuLF9WNsVNv4OIjXiYE29P2oHbbuacbFmQdVGR7IqkApM3QWxq?=
 =?us-ascii?Q?qIFjVCWlOpO1wgO3zBhA/vCJLINoufE+WXaCXwtq4tUDhTRQ1gj/5vrUgFBf?=
 =?us-ascii?Q?pQTv3DqQwI1fxpP5NH4nRa0vZNqvyBA6KJ5pOZPgZ/MFDTvs9nGb0sR9xe7X?=
 =?us-ascii?Q?Q1V962PyEwhK2FBl5YXDA9PBZcX7vU8nS1n43wkWAvfWw5fyrg4f3D8W3WxQ?=
 =?us-ascii?Q?Vmw3C+IHPQzli4Nr+/j618HKyadAdYBUIQwNmdPl3IPaWtAGEtdW92/KXNju?=
 =?us-ascii?Q?VUEqlYld4E7NvceEn+lRr94+xD5plckTtcaGK8pYJ5QSfAXuHcnXz5zqQOLR?=
 =?us-ascii?Q?tolt4WH0voa/PItI89EHOLy0neYJRdPJFhYgduAVZdqMjakAEslwujeWRN6q?=
 =?us-ascii?Q?yHzL7NkKLwtbNadivnk4rZiY0zYYt+jKiQeLLNcdLJXHW7YP2ymQnFoEM1Hn?=
 =?us-ascii?Q?22Suw5nJQiSmwEDi8Y9iNeHq30tnNWbVRU2+WVD17Ieq72k5BELr7zGDJExs?=
 =?us-ascii?Q?LC1aLenJXogYogU3SozNCUf9P7Rz+WHZjFrKMbW9X1GVPAut1Vk5jyxrvOsF?=
 =?us-ascii?Q?UKlNiA0/nL9AIC+y6hBZkJ6BXqwAFZNr2c3E9MHDfJ5WFB2sj81y9r+TW4oq?=
 =?us-ascii?Q?IBLwfsnASFEodt0AXeGlOsYxPlGcG9Kynb3+ohfyUJL86cYTl8jbMH7CJxbz?=
 =?us-ascii?Q?mrTR5rWLYSi/qA4Jq2/iyybK8GxG719e7F5I589ND8s59Fz4FQhxRcjinEwl?=
 =?us-ascii?Q?g55HGMOsMzBudZYntoWpSN2lYXDlUxesIBEEgGseTlOdEw2LIQ4O9THLuG3E?=
 =?us-ascii?Q?EP9tMWrYR5xCG1mb6MA8QIS9HCiK8q+3/Mng0gm8x/d+d/bK838hhGiGpHGm?=
 =?us-ascii?Q?CVOsrWW1w0LPVRiciMhSBFi9mUCyuqGHclBHCWwlCXBITv/WPdujBi0noK9c?=
 =?us-ascii?Q?Nuzp3nVyV6xnafYMBgmJ+flkDuXFghOu25pO0/cHRdQoa7xiZrLwSdTCCUxT?=
 =?us-ascii?Q?7d8//4aBTyRtu3HjFNdMdSawWWDOCx1ozoA7WZHMNFrGHB+yfY0jqQNWiBsO?=
 =?us-ascii?Q?iFBTPwH0hh0BDrNEWxoVD30ZxxFi/4KCcHgssTZvq8MluWSnD03JCm9/AvHR?=
 =?us-ascii?Q?mPT1BYFQpm3CeVgjKg1JTNhdaauV7TUXCbY0oNvMmV5YrKpISmpvKaWAmqKs?=
 =?us-ascii?Q?KUEjx7UUBjHkt3mGzbkcJO2lNS4gbTGeIf2geaNTRjhVyAqiRpGI4Xx+/SnR?=
 =?us-ascii?Q?Ar5f1GqGxIbG+GbdRYWdUcultA8C6nkVEHC6KBw+yiuPtg3DIcxYH/252KvY?=
 =?us-ascii?Q?4aGzfxrz7tw5Z0gt2APxRARMG+vp7Gxbis2TslEl1P7jYdmMMK4rNVjmiVjJ?=
 =?us-ascii?Q?U4iYs+pcYW/B7VhN+Of7st0J09vu1x849+KmTjdKza5WVClFCu78HPcTEUUa?=
 =?us-ascii?Q?1/ZrXuh6VVFta//5BURCgQtmOnwf4TGsd0haceOgaiI0167v1vv4tweHlRkv?=
 =?us-ascii?Q?O22uX+I2ONPoxOVZyh9hvDJXFJcRQ9VhwIVEgF0XEPYKzPOEJUABUFHxNvmy?=
 =?us-ascii?Q?vAaWizW99+OmVE7Dm9dk/bgD8yrv8Bme6CRlbaRq18deAsPTd++QGFtRWfGE?=
 =?us-ascii?Q?1g1v5Mh25lQ6qDpera1WQ9YRn4fY7PCJeAJ/k4bhaFtF2d79cU7CvfJrn0Si?=
 =?us-ascii?Q?br4YLHSmDjqEZYnTX9bO+I+0NIDF22YjAnnsDM+UfPMGOCp+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf04fef-394e-4529-6c1b-08de7b076768
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 22:34:46.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHQ0YWrpNaow3b7G8Qj5ClI5eS9boF2sklByJnrllGAb6D7iTja43iC+cYN320hdUQg0Lay5pH7yFQP86YBmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871

>=20
> On Tue, Mar 03, 2026 at 04:01:14PM -0500, Frank Li wrote:
> > From: Frank Li (AI-BOT) <frank.li@nxp.com>
>=20
> Please add a human step before sending these reviews.
>=20
> > > + * @rx_sampling_delay_ns: spi clk to spi rx data delay
>=20
> > Comment is too terse. Expand to clarify the unit and purpose:
> > "clock-to-RX-data delay in nanoseconds; see tCLQV in device datasheets"
>=20
> I'm not sure restating the unit in the comment as well as the name is
> super useful...
>=20
> > > +	/* Transfer characteristics */
> > > +	u32			rx_sampling_delay_ns; /* clk to rx data delay
> */
>=20
> > The inline comment duplicates the field name. Remove it or expand the
> > block comment above to explain when/how drivers should use this field.
> > Also: is u32 the right type? Consider if negative values or larger
> > ranges are possible, or if this should be `struct spi_delay` for
> > consistency with cs_setup, cs_hold, cs_inactive above.
>=20
> ...especially given the contradictory feedback here, and the comment
> about a negative delay is obviously not appropriate.  I'm not convinced
> anyone needs an explanation of what to do with the field either.

Sorry, I have not careful review AI bot generated result before sent
Out. Please discard it

Frank
