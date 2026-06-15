Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27540D586;
	Mon, 15 Jun 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520563; cv=fail; b=PG0dDpwrF2BFeJEz7F4hl2Fm4LAtxc+d23CSDwJ2ForS3VSxEsn9J4gnn0vFNUK5XsjSwtR6CEApyoa9HHjfNfEFT70d4CDcOsH0bUNCR2xBmhPfmPOpUa4DSArbZqWc7utFJKip/cH8KO+qDyYdeC++rkxk/xEc/mwLJY7qK9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520563; c=relaxed/simple;
	bh=6j4SnovcgPBXjsqdZPskmcKamBA+VRaLAZRvlvgqT5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H79KALUbwzQMT3RUBPomfhZuD5Oc0IELtccIffELEvGHQuFPlX+7ExychqGSNAy+FtYJIeaQUQvLtOu1nL/S2shv0Q5mdMT+hENwk1aD4oA53+u0tD6PdFXXv/KcbfvnR5rwhxq92EHuzB96rsf85pXXEVo3UFsIG563HGLrjYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/TxAgNl7YtUfCXF4wVUeyO6QP7HbDscVOmHu3PpnOlDDgMKyk+h5ICgaPHFqx/xscFhq/4eJrJCl+R8izKFyC941SvoI+8Zw4JgXI5ISKJjWRe8vSmZE7Z7MvWgKXWHqftqPtFmvgdiHVw+apjFFlnwENqTTyZbbU1cz0fpp6fNzeck03aIO3JINCoVZ2C4KD+Z4XBvIZmKlwtByiAW77h7vCwvTKpIw5Jtf9mCA8hb0Vkh5iF/HrfY/AylYwpceDhM5Kj/nlr9pQGn8o2vbqrm1QQFJX/ixBt7CimoG35vNB3sXx6DHM6emJdmLKDMRhvM5oNHvZAi/U1SNLGRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ttlWh4pifoM5lJ0B8MAq/7QRdKV8ba6hOjxWCme5yk=;
 b=EeZdL62OhdqYZQPzRr5hcxPGjZLY0ZiyZvXtqVUpBXLIjIXNp7M3k0O1g5mTP0LD/bpXPjqr/jlsf9TF0c4GyRe3GKpQArricWltjIiStZcYm0hMLxvYNZcmNkFurElSKvY5TYzb3qJAzF6ay+QipDAd/v0uM+hlIc5oLbM0wAvP3kFLempRg3ZFhg3yXDzK8WOlRzVwPAcB7dstmMXAyJnfKAJyKp9Tnm27wCsOW+cFKIIb+j+9KE2Zgplm+w49Fi74kKQAl9hyoqOSYVRRNwiqCcmK8HiYwgH0DMRcBqPRpkBDG6vv2Qq+XaG6+0gPPz6pL+of8qYf2b0+TNzfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1250.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:49:07 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.015; Mon, 15 Jun 2026 10:49:07 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support for
 snps,dwc-ssi-2.00a
Thread-Topic: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support
 for snps,dwc-ssi-2.00a
Thread-Index: AQHc+mtCPJneHTK71kastHnYdP89lbY7ISyAgAC2QrCAA5WxgIAABzew
Date: Mon, 15 Jun 2026 10:49:07 +0000
Message-ID:
 <ZQ4PR01MB12028430668DE1F9AE8645A9F2E62@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
 <20260612-mute-aqueduct-029ac227314e@spud>
 <ZQ4PR01MB1202FA8F122134F7153D26F7F2192@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
 <20260615-disallow-dosage-333752ccddc1@wendy>
In-Reply-To: <20260615-disallow-dosage-333752ccddc1@wendy>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1250:EE_
x-ms-office365-filtering-correlation-id: ceee6ae1-2e3c-4d4a-ad74-08decacbb9cd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|6133799003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 QmrKGZztT29mR+IZ+Ltw3VxYqBFpWKlYouCynUI+e8yK3XttYQloBxkMwSbl1HdYTuRWMq1gLvTgTzt7IAwIQ8yTOA8TviBQN3c5zIbQtpypoNcSwjRU3NukfGJ1oI0mAHxeKbECMBAFd+H0vbuxQUZ0WCANLDsbtb43UfbJvwgL3zNUdTKISn1RMQjbBsSRq+k5asz2Hi2nQuP6d7S6GtU3LuCJgVm1SHN4jf0Q8Dpu1vISXrOPJPp34ROBseKydfFYvGk3OGUzw6mUw9Ti4fKhT0i8r5l35i70WQreW1tZiSi3Vje51sukUu7c//9QagNhP1t9LZ/nD0XajEGUjFyHCHXMjgtTbnJpCyJZ12bFJQnWPV1Yqzl4cOHGjebsMP+ZJSPp8Z4EHFkE+Zazj8mru3wxbVcyP49xNDSf7JeyY9G1N7L06niOvoyRNl4vQa2CPSebDLm4bWgTpvYC8eLEaP1ACZOR4lS9bD+Tqg+OvtGJbx9/kT8plSHzngS2xtX1dKDxwAyunzZP4BtNEabj1DFlL2mNxZ9TO6SIJdLo1EyIzHcRANo9p/zemS8T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(6133799003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ef381ysyB4p9V8a9CJScy/SscOrt3y+lW8iiLZlwtemHEY6OIpVP4wjMe3w6?=
 =?us-ascii?Q?0NbjlLdEY7w78N9XgRCJMuUweIa/BgUOiyvEtKX2AKkOfIP7UKtEFqGD8l+J?=
 =?us-ascii?Q?qT63Cxw6DrpquzFghowojMoc/m7ZGka5HxynjLyWhiuAfethNT1JrpqXcgXM?=
 =?us-ascii?Q?qjawea6R73lBTVnfc+pK4LadppIL/u94XZJSuRX3/EbzO/YyBcYCk91EcJSG?=
 =?us-ascii?Q?T2KH0qFOXYXBs/k30lfJDvykaylyS0EeXVZdXC/nypua4liGcxza1mUjgGqw?=
 =?us-ascii?Q?YKjBjROgo31sU2WdYK8KhqqMxAs6U2nH9HT9oX+4nOhZLMyDc22cGhPDV1O3?=
 =?us-ascii?Q?WJ7its8A/G+pnahKNa7ym2VNiL1htuhQHkZedn/cdAyf9srztAC5MPsAzS2V?=
 =?us-ascii?Q?zcM4YcS+A7KR5gHQpYxnv8c4VPORcM8ttLr+GzY1KUf9v98Otx80dNyvlgb+?=
 =?us-ascii?Q?bxOKiG5TGZWnqBjDpOSqVlAGvufmAbpisB0FVI8ZjIPmyFvfKlfYLyw5T4sQ?=
 =?us-ascii?Q?hV6XIll8TTUE0Px2GljPeejnThG7WQ68vX85faDDmpdg7EMOb9G2QSgCaO6V?=
 =?us-ascii?Q?ofUzk/jPm7QXoe44cYe4ok3YQROPCdS7ZONNNAZRIVH+uvg6ynymT03z6B/e?=
 =?us-ascii?Q?Y/g/1A/T7/dSkL7Ud/WaSwIkYssL8r+Jg5g5aDoIDM1cNjlF9uUXEpQd4hcc?=
 =?us-ascii?Q?2rpyl/WO0A+R+U/r5KboMK2dLxMVGt86tapqS740swdlBXBjmdpqlFOUGTxD?=
 =?us-ascii?Q?3/3BJr3qxQmIjz0TB1VicRt9gNHobY/WY3dgujrkjC2SKh7mtPO2xRk4k03Y?=
 =?us-ascii?Q?T0U+pjMFyubm9k/uQILVIOdmJ6q7j1+OGndpNbAxkEw0+nsMjPYwjbw8JfDK?=
 =?us-ascii?Q?bEjQs0xtKMfr0Rf449JLZPVVofJP2Uvn03UxSLtc8tRsrcYHDzMqhFpvdKr2?=
 =?us-ascii?Q?DTntC6jELqFTuu4JBIs3UqEnLuIgUtYjc5SSodPY4sPmJAXvtq1kDz11ehJF?=
 =?us-ascii?Q?BhUuBLKNDqSbq9QO9eY/MxNyRqlR6YQ5lHbvg2L1RrN7LidaKAx9g/DrwLik?=
 =?us-ascii?Q?6pjvEUxQe+xeGniljJHS6CUqyAIkBy9pzhHDHU57HeBTxXZbjom7zeh0RMdu?=
 =?us-ascii?Q?litfAQXpJ6rW9eZCT8hbIKXESKk3r42IEgAHr726jUN7DdWftz1FAwrlwhvv?=
 =?us-ascii?Q?O6ceBuVkgKdda1jUnoiRr3aDqgSHV1ZL8CY4Ln00fYrboFOdpJ2T01uubQDb?=
 =?us-ascii?Q?5LO2Z1BP2tCf5koYSQ6d1nGtS7iU7x6mmCFUbRzwhhrAYAuuzOMftwZM6GNo?=
 =?us-ascii?Q?bpoqqapu7NIcoi54GPd9paOP6+m5ORap8nJ2yVgH6+pNOAIGXHVJZZrK2bVs?=
 =?us-ascii?Q?+kHvxgRfhzjjejb3WtyCcc50skmR3desFDpB8NBLC+PmMbsq64EM6HwXVzPJ?=
 =?us-ascii?Q?0mZgGQuS0SVGPMidd+Dpw2dW8lym7kvQkhTr5FZzGUwq0sZpEIyTvjRquj5W?=
 =?us-ascii?Q?B+nThtExeEWjVomPiMIbKpwFOdA23pfm178/XSPesJ1b9raGdxbxUtCvj9TL?=
 =?us-ascii?Q?Sys/w6DGY/a4bzo5dlu/xOJrrrtIwugkbfI4B4JQb6UySGwyBspMZgXyXhlH?=
 =?us-ascii?Q?xtqlZj2JMr4mQXr4bop8/lJYedjPktCcDGgAFnUD4ypY8TG3AHKR5WEa49uM?=
 =?us-ascii?Q?LOyaAvkArtRHmpFLTq1c2lN4JEQiW30rGHSxBcpQ1AKdxu98WJH083aS93jK?=
 =?us-ascii?Q?xVArTvHBWn3eIrykhSOJRz1Ns0eKxjI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ceee6ae1-2e3c-4d4a-ad74-08decacbb9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 10:49:07.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIDgmC8ti2gz2TPnRsu9mSLr3luCSe825fPE/O9l0UuXgVlJ55z+dQiRjNsI4gOFabwMNyXLpEMY6Smkwp2YOGT1y3jNrDJBRXi3vyarPCad6tXFaxjKIpNb9D0yLL32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1250

Hi, Conor

> On Sat, Jun 13, 2026 at 03:38:46AM +0000, Changhuang Liang wrote:
> > Hi, Conor
> >
> > Thanks for the review.
> >
> > > On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:
> > > > Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
> > > > DesignWare SSI controller version 2.00a.
> > >
> > > Two things. Firstly, driver patch suggests a fallback to 1.01a is
> > > possible. Why haven't you added one?
> >
> > Will support fallback.
> >
> > > Secondly, I am going to expect that when your starfive user for this
> > > appears in my inbox that it has a device-specific compatible, so you
> > > may as well add that now.
> >
> > Our standard SPI control is completely based on the Synopsys DesignWare
> SSI controller version 2.00a.
> > However, for the controller that accesses the flash, a set of
> > modifications has been made based on the Synopsys DesignWare SSI
> controller version 2.00a, and the driver part also requires specific adap=
tation.
> >
> > Therefore, on the JHB100 SoC, the initial device tree source I have pla=
nned
> looks like this:
> >
> > spi0: spi@17f20000 {
> >       compatible =3D "snps,dwc-ssi-2.00a";
> >       reg =3D <0x0 0x17f20000 0x0 0x10000>; };
> >
> > sfc0: spi@18000000 {
> >       compatible =3D "starfive,jhb100-spi";
> >       reg =3D <0x0 0x18000000 0x0 0x10000>; };
> >
> > Thus, I plan to add a new "starfive,jhb100-spi" compatible string for t=
he
> controller that accesses the flash.
> > For now, I intend to keep these as two separate series.
>=20
> No, if you have two integrations of the designware IP with different
> programming models on the jhb100 I expect to see two different soc-specif=
ic
> compatibles used. I don't want to see bare synopsys compatibles on the
> platforms I am looking after.

Okay, I will change it to the following:

spi0: spi@17f20000 {
      compatible =3D " starfive,jhb100-spi";
      reg =3D <0x0 0x17f20000 0x0 0x10000>;=20
};

sfc0: spi@18000000 {
      compatible =3D "starfive,jhb100-sfc";
      reg =3D <0x0 0x18000000 0x0 0x10000>;=20
};

Best Regards,
Changhuang

