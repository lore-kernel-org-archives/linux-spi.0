Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792509963;
	b=Hcetjae1ObkmOOmw+Cqs/sYWSzU//LYvKijWhvxdbnd51sWQ9l856gpzeXWAFWwGmVN1
	 vk9xVY17i1N4UkkJ6IPiCNZCwKIBu4GA0CcaR+4tSdoXnPPLjBu1WA/wgKgdrdkGX86Lh
	 ApKLu65ruXaaPi9VLnpF9jc7+MXV/mRPUCHwAMkx8JRymTxZx7VZiCcjyJzeX8ruYY5xf
	 3SchV7TEg2MuNLdcoF+insfCvBNxNq1X5EAZYFcW5GQmC4ROlHYp/NyNfnhZdswSGvTIQ
	 +0bHDf2sQCdhrFcRg7nK/ERNTc720mSPMU63sTUz66UqKirJ+Iy3oNluY1ubs/cg06Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509963;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Hjm1FA8va8/+riv4h/WUvoDEQcAlFctPn/rN4qzQxkE=;
	b=naurxvoCcoBMv+UngePu/9n7xuTz4EOdo17YYc9KF1Nk+KfvHur0wflPso677DaOFy+l
	 245EK6KkriYutyxccZBN7PiTm2MeHlDuamPifdwGLgoislOwJAtbD8Eo0/5adFF77REp5
	 pu79tiKiQ40taVJ9MRjCEUyZXSvmIFbicaA5C8VLy3BusfTnj2j+mPXnmo3uEg9rneNQA
	 rUhStC/cwT3Xtj9fU8oMWZy4C1Lc94hCEbO5N4wBC5JeNLSyM7lMJaQmE7SCds47EkY7S
	 i0OOy6N/+hkBvvhn2wa6pqibSfef9dAKTMe0VnNbAraaNhVf5YiYK4uzTXyIPGDyjPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vosm5vdR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.66
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42D606A31F;
	Tue, 20 Oct 2026 15:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B42D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Vosm5vdR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j73ga/EIj06xp8exLnoUf0RlEzl+yxRKxex3cIwJuYrIZu64eq4+AxbhzzSJa/YB0Xj2exEvOlWskQYvk7aQgv0lsKaVW5hohqH8JgWI+wtbwCHfbEol1p/WcIBjIlMSM3bf0lZV2oAI9vjtk+o3NbpQ0rBNp1mjKVzGXn9mOfPcFD5yjljCYSNYVDKmXNiravmNfS7XjjrNTfHAkMokIK8dKIzKQ2u1kSmivR7f7hEx2lV1rsyo9rBrkxmHE9oiFJTMG8Fl881zIGU8Vy/j2Guvev59jPXeJa+aMJ9MmbHlfEb28rci2mcCVWouwSL2A4XZhxobGkqqvzO3s0mUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjm1FA8va8/+riv4h/WUvoDEQcAlFctPn/rN4qzQxkE=;
 b=vS5Gol4JKdcvBljiLKj77UnWF/d1btALrzO3hQYLNvtvKCQLX9IEfScbZaM9TqgnQ4xAhEZU71RW9ZzYSxDZ70Xdi5P8RSANLAJkJz+tj0DMCSBD6PJp1i4edughpMiZwENfACfynnRVhMWOOkNuYafSs2p0BsHcsYgwdhWxBCKdUFBcAHyNRNV2z1hCMJqyDrDisMsXcgLuSxbGU/nRuHnNeHd44FpWI3eXWRBQeBT0q3Exkr8EwaA8VemP4uddRPknsP9KrBkYfz/hpMpAyQhHMYi8tA4JzJ9dLQsE/YEmERF9khFfflTKPeDNXMRtiKno/vrJ9VI2BjQDkpEpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjm1FA8va8/+riv4h/WUvoDEQcAlFctPn/rN4qzQxkE=;
 b=Vosm5vdRnm78Xt2RGW+h4HT9tVnzLBhSCJVQAzNX9Qhlg8zcS6ReD9AdUZFM8jYXyNOlGw+FM9ZJ6SncJzZZSzGhG0dcfOKhTgRjdglGGKvkubTvNfJsfZqZ77veAlX7Vwh6ZTNFf61jHbWUCwD116Mi88l/zfDcergNgf8mwbZmezgrwlEYoE9KZXPNPwGcNot5H8wHvtQyqk84lVOSoXs2zXE0v1UIAqGvMhK9yta4kpYSMSwq4AbO4GH/RPENUcDpqlhCWz/EuZOUsm2QKnypmr3wxOM1CmXlcG9ZpoKJx3vIOySRfyaGnME5F6PdPiJS3cmkrTZtABrWOcEL7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by ZR6PR04MB456611.eurprd04.prod.outlook.com (2603:10a6:910:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 15:25:59 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 15:25:59 +0000
Date: Tue, 20 Oct 2026 10:25:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Conor Dooley <conor@kernel.org>, Marek Vasut <marex@nabladev.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ashish Yadav <ashish.yadav@infineon.com>,
	Colin Huang <u8813345@gmail.com>,
	Sanman Pradhan <psanman@juniper.net>,
	Thorsten Blum <blum@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Eddie James <eajames@linux.ibm.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kernel <kernel@dh-electronics.com>,
	open list <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
Message-ID: <ateH-6zjtfy2t_tS@SMW015318>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
 <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
 <20261018-freeway-twitch-e813208aa9af@spud>
 <fd15f846-94d4-44d8-a42d-5f13a7b18794@nabladev.com>
 <20261019-cycling-unnatural-c1adbfb5c9d9@spud>
 <05e66d8f57a44c9aa87cac1c35e82184@dh-electronics.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e66d8f57a44c9aa87cac1c35e82184@dh-electronics.com>
X-ClientProxiedBy: PH8P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|ZR6PR04MB456611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbd61ff-e13e-40f1-60aa-08df2ebe7165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|19092799006|4143699003|11063799006|56012099006|261009223327099003|261009221727099003|261009223027099003|261009220027099003|261009221227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/PurP4VqCAE6zktYmsZXAF+Zd2SaRWsekgNZTVH6LdN7m0a93wH/laGo/5dccRf6mCDzcOIe6kG18LVteACosOIf07M1SHN+cyURtd7J7XPyg9B3IcKmIGfP32f4ZtnX/Hk6igR6cyxeBSbGu7Xb0iPzvGa9xSXXJJc/1c3bJuNp/q/nsa1G5jFU1Ejz/DmOaat0J9w8YrtP/pXoe16aWIfzulI8K3P9RyqNXrsyTGb47wK7bM1Dag1iqV630KOw4NgleZ1l0P3MFn/csX1hg8AfyfrvPt/+/NfoXLgGXe0GHan3Uz1p6Y7WA/KGUaEPDfrlc/CAU8b0RoZirzlMCk+bdnUflxK4NxdU9d0XleKVpxjUnAAfGO0rHUrGezsPBuM3T8UezN79XIyHQ2XqNJ9bE1CxXTyY/TnbDVZmfjEyh3BCYPBxUnFlckAu1XjI8mR6dHxnpTuaza62iaiMg26F7t8hrSfZjoslyiSzrAEUDRiO+07fL1E77mbmhX7N23nBdFmkmE2S0MR0HFa0yi+yRdZyvFt6GTg9B523rtzmgi6M3cNuL0KaPK8lxZsZ4oPHM7IyFihd1Xtrp7G9qZrdNGWYTpQFCHmkK0j+j4PPk9mEWh184k+MMZWcTb+W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(19092799006)(4143699003)(11063799006)(56012099006)(261009223327099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009221227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zakmUAnIGJFDXP9KVywOupnpWLmjqpzW6ErqT9ZciXpOu+SM8kRqHH9iJ1Li?=
 =?us-ascii?Q?Z27eehebFWSD7QHK3B+Q1+jYbf1lNHwkhd9Mwbxi0HNpf1I7Q6PuJayqRiVu?=
 =?us-ascii?Q?NbtdSUeKokBnH3j5cAUuiTeC9h9pEL7a+eA/PnOJp8j/+PwXZ7D3+YHsa5ER?=
 =?us-ascii?Q?7aUmqGUr0n/YpsVZgacjL5r9eFj5sddeEbw61SvD3pNuGkVpzZXzxgpeE0wJ?=
 =?us-ascii?Q?S5q5YNbFA2D1RsizPom3EZBl2yJALaNpnhZ6hja482cXhGw9GvN1/rafG54p?=
 =?us-ascii?Q?qRHAMyjVvOtjJ/ue0HxlD/BYzXwpnAbTLfqeTSghaUPynPUqWOiPtB7Yz9lG?=
 =?us-ascii?Q?7ynPyidxocu/4V8V19j/Hz6/P15R2J86tW4YSEEufRXTo0uQ5TEePtbeTv09?=
 =?us-ascii?Q?fHl99MJJfemeVVIg0quduK/H7W/0tjth3TDYObeK8x26tgyczb+wFllYbgPv?=
 =?us-ascii?Q?jpMVeWVukSEwyqPAW9OROzx0GiGbYa5wuGw+YM38kgA2Be1sm3ue0TnNt0is?=
 =?us-ascii?Q?xEn1lnAAx4PsN5wOUIBnd1Arx2VLTcS/itgMOkP30SN9gnODIXfFDKdONn22?=
 =?us-ascii?Q?XsVjC9vdNnV729ztqLeSwGXYgzzTzwwErR/YeWsto5EU7AwCNgh6ApK5hHeX?=
 =?us-ascii?Q?EsARbMYt1cF89BrlEze26OV/TfFfAGDOulKgtF51v2GvZs7cdsUj5LtfcN+M?=
 =?us-ascii?Q?1ZnsaoWFCduJ51xWS27fC9rBeUaZhYtUU20v+xbxHu41ZNobDj3/Je7N1SJH?=
 =?us-ascii?Q?Hr6DQ6CS4bRRLjxQ4OKf6UAjzW37N6F5B097vPsU7uPLS1hbvRmgMRAi6wDG?=
 =?us-ascii?Q?SEnUbYyBIxtPeys0L5XSZ+jw80boVqVqwjM0xYeLu5DR6nLgDvOdUIJk4ECC?=
 =?us-ascii?Q?DfaOb1kxuUeDQfoWjU27y3pnRZndP87W4F4bQW4uquPwSRoIcn16MaON85/G?=
 =?us-ascii?Q?amHheq1coqN5eXz4V0v6dg78B3oe9svc5SphZAMKdAI4kMtMNGIt9zK3iWI4?=
 =?us-ascii?Q?Zxl7cST0ot0F51xOH+Y2pie2hn9hHCFBezBDSDR9uD028Xrh0nYWupwU5jUo?=
 =?us-ascii?Q?ZQh5WbZM+tp4GABOUy+WjHoTjGaZJK2O48OHBz2gemzt2rJi0RtULUY9vhWB?=
 =?us-ascii?Q?lqkvlop4+294ArutggfpwDtJ/NZtuxTresT1mMBwovTi1RdURQtsCb3DkKyc?=
 =?us-ascii?Q?GAlMJiqoXXFBa/lKlQXiRBp3E0WNBR3rRj5GyO08wU264A+Ya1W+nDUehLJ6?=
 =?us-ascii?Q?YVoZ8GiwrK4Ox576//sI4wkqOmYTYUcX2Z4RtbUfyY5dVl0YDyW+Q9wigyVm?=
 =?us-ascii?Q?L4QwhHvsZQAc8Ln3Z9iSj8DEmsB7+WcAF/hlCZolaaSWBXPnmnYZzMvmTgKS?=
 =?us-ascii?Q?iwYltzHGOR64UOqKX9ocJEK7b9IE7DWoPw5UzpjXhytTpy0YPa0B/uUZwGTd?=
 =?us-ascii?Q?5fNvhsdLSX30lJHNcj8HU0X66JIDFWMRHEw7QBFHnJE+tfTIdR/bynXD5usQ?=
 =?us-ascii?Q?HA7fiBB0gI2OxfWV/vb+jlEttol69lcqKerD7EAV5iy373N3BZ7eBvJoXJng?=
 =?us-ascii?Q?pRLKCP8J61P16yukPCvK8qZsK/E3BAx1ToD53hZsddOoLqpxam6yj29pWMiX?=
 =?us-ascii?Q?oqSNjV25DHe8a7iFazxF1Ohsw8ceApq6Sz2Zsuf3Sfuybf6JTxcPA17fjl88?=
 =?us-ascii?Q?oR16pVl0BDOyeuCtlO3qfNcEOxIwjkuaVWvX4qn7SjCPTNXRKICP8jSGj6ej?=
 =?us-ascii?Q?cOE+qJCmU6PC6atC3c8/qPcv5Fpd9RxDJQD7Y29Eb6/mqsG8UzAO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbd61ff-e13e-40f1-60aa-08df2ebe7165
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 15:25:59.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le3gMquSBqZfcFu4UixS7aR4IdPcZqn/g0uU923Yoag+17KYd3LoST28TX3zlQ5h66csNe/0l0tSKbK2LUlHStLAauwJtYeuYLDUS3ScJUvSX7wbAo4fVvjOgoN1v7kJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB456611

On Tue, Oct 20, 2026 at 01:33:24PM +0000, Christoph Niedermaier wrote:
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, October 19, 2026 8:23 PM
> > On Sun, Oct 18, 2026 at 11:38:09PM +0200, Marek Vasut wrote:
> > > On 10/18/26 9:37 PM, Conor Dooley wrote:
> > > > On Sat, Oct 17, 2026 at 12:01:55AM +0200, Marek Vasut wrote:
> > > > > On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
> > > > > > From: Frank Li <Frank.Li@nxp.com>
> > > > > >
> > > > > > The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
> > > > > > which are not permitted by the trivial-devices schema. Move it to a
> > > > > > dedicated binding file that references spi-peripheral-props.yaml and
> > > > > > explicitly allows those SPI mode properties.
> > > > > >
> > > > > > Fixes below CHECK_DTBS warnings:
> > > > > >     arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: '^pinctrl-[0-9]+$'
> > > > > >           from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
> > > > >
> > > > > How come this did not trigger until now ?
> > > > >
> > > > > > Assisted-by: LLM
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > >    .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++++++++
> > > > > >    .../devicetree/bindings/trivial-devices.yaml  |  2 -
> > > > > >    2 files changed, 46 insertions(+), 2 deletions(-)
> > > > > >    create mode 100644 Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > > > new file mode 100644
> > > > > > index 0000000000000..ed213cbe9b04c
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> > > > > > @@ -0,0 +1,46 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
> > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > +
> > > > > > +title: DH electronics GmbH on-board CPLD trivial SPI device
> > > > >
> > > > > This does not look quite right, since compatible this is used only on:
> > > > >
> > > > > arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
> > > > >
> > > > >         model = "DH electronics i.MX6ULL DHCOR on maveo box";
> > > > >         compatible = "marantec,imx6ull-dhcor-maveo-box",
> > > > > "dh,imx6ull-dhcor-som",
> > > > >
> > > > > So the whole
> > > > >
> > > > >         spidev@0 {
> > > > >                 compatible = "dh,dhcom-board";
> > > > >                 reg = <0>;
> > > > >                 spi-cpha;
> > > > >                 spi-cpol;
> > > > >                 spi-max-frequency = <54000000>;
> > > > >         };
> > > > >
> > > > > Should probably use a different compatible.
> > > > >
> > > > > Christoph, what device is this on this board ?
>
> There is no device connected to these pins, only an extension connector.
> The "dh,dhcom-board" device was used only to test the hardware and was
> unfortunately forgotten to be removed. In the production version, no
> device is connected to this interface. It should actually be removed.
> Should I create a patch for this?

Yes, thanks

Frank
