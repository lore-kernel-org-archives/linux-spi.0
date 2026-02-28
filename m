Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021102.outbound.protection.outlook.com [40.107.42.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90620C463;
	Sat, 28 Feb 2026 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772249906; cv=fail; b=Gou3RxKqQr6Twx27AGst6jPJ7ckgJcN472+nQ7wZWeUDK0F+itaWt6zpxVdZ8t5DeTzt27xA/yKrzv+Gc6P+JZ0sR/dlAnYS5QO3sWrR1otel5G/KLzTPnyqedh9dIkDbTbQeWmEhTfSILPXwJeiXiJt7/H8088TxTpYTWOzP38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772249906; c=relaxed/simple;
	bh=92sGdfNew5QiCkgeuhjAtz2hdqMUlOJ4e8eY13yBR04=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LwwDMTbmKzxAq01j0nQxxELmj56c6LP8GSsFmXCFhBR7oNiv26gIjZZbAYMDYcio5+vRTeNWFS/IX3UrZNehHgOixZFPs47pXJbjLMZFsrGUx5w0vKu5bgoYlL8NphTqbsQAlIdyYsyIYItZEVqmprV9ii8fcnHjc7GeAbzCrGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telechips.com; spf=pass smtp.mailfrom=telechips.com; dkim=pass (1024-bit key) header.d=mytelechips.onmicrosoft.com header.i=@mytelechips.onmicrosoft.com header.b=jCNOPIEe; arc=fail smtp.client-ip=40.107.42.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telechips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telechips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mytelechips.onmicrosoft.com header.i=@mytelechips.onmicrosoft.com header.b="jCNOPIEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eagSTG3kxlvzt00t6H0++Oi6O7BDjl6SX2gxAzb/RAcmXNzIwQ/cXx0qM8aSdYJyNwFsyMxfK32YuO9oosPZRgmsHwlrhH3VKSp1SbWHF+ePL1OeO4BFTL1607buJhdEvRMq8zDaiWK3Uiqf1TGAc/1kR2ttW+IiaV7MPO8rvCnBRD1jHYowAC3KGhn7kWh7eBFXHOeiOWU7VuLZXLpJMLyFb5n6Kjr8PMjCt5CtFD4ZMqQM4bHzpwIFlkPPgshp9+r9DmRwzdNGinauni+mlXB0UvrMOOwlt+eJRAzTiQV9KPV1GxzvpFuGA+CmCbhm7qsO6EIbDawgoWkmxNMEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viOZMb41Qzd2XvPy8niDT+33S+VAwLCPtTnyjyxhDWY=;
 b=lH2W48xZv7bpJDEeiQuBN127fRtyZ9u7a16Xnghzr3Zh0kPpXxx+f/nKCFoJ0Gs5D4j/+Acr+NgK7rFzq4r50zKbtNdoqSu/eM6nfv5Pa2/BpItZXPPzJzNl+UhxQSWWaht0Zat3pMU2QAzzdYRWABqaLCapiD6x6qm/WJnp4zH1EN7Do0dnGwVj0RTgAZmprtXNNFhE6S4DULi2ya6njPX1sFu6jhdql+Pv1ku6rg0Pi2nScXiZG1MKV0n7Qter7CSI/dlK0DLmmoj7GD67GjEIi/6wt0py06AZwUtu8urSeWRFjM1kyQ6bCn/BUDVcn56KBhXeuNQYQWj7K1B4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=telechips.com; dmarc=pass action=none
 header.from=telechips.com; dkim=pass header.d=telechips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mytelechips.onmicrosoft.com; s=selector2-mytelechips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viOZMb41Qzd2XvPy8niDT+33S+VAwLCPtTnyjyxhDWY=;
 b=jCNOPIEeJJzq2eXXREjd3bomDwcteQSJH/pzpKEmWdvH3GUH2v6wGxUbMvg6bpcfRhXsAUi/HPd9JNgq4F7UeDh/tfitiKmn6bVOCgn7BPc55Y3ISDSBQJlnkIFp1in5dLHg4ARqaS8jQwGQmTne+IHtkblywGoLOb9a9u/itr0=
Received: from PU4P216MB1182.KORP216.PROD.OUTLOOK.COM (2603:1096:301:95::8) by
 PUUP216MB3188.KORP216.PROD.OUTLOOK.COM (2603:1096:301:169::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16; Sat, 28 Feb 2026 03:38:18 +0000
Received: from PU4P216MB1182.KORP216.PROD.OUTLOOK.COM
 ([fe80::9f74:bc32:6a8a:b7f3]) by PU4P216MB1182.KORP216.PROD.OUTLOOK.COM
 ([fe80::9f74:bc32:6a8a:b7f3%5]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 03:38:18 +0000
From: =?ks_c_5601-1987?B?yKvAr8H4IChZSiBIb25nKQ==?= <yj.hong@telechips.com>
To: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [BUG] Possible circular locking dependency in spidev (buf_lock <->
 spi_lock)
Thread-Topic: [BUG] Possible circular locking dependency in spidev (buf_lock
 <-> spi_lock)
Thread-Index: AQHcqF1nVR7uC4lpfU+eVpzxBYzHJw==
Date: Sat, 28 Feb 2026 03:38:17 +0000
Message-ID:
 <PU4P216MB11829B6BE6520C897F0DCE0EFF70A@PU4P216MB1182.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Enabled=True;MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SiteId=9ec49ece-9398-4634-9468-0ca88a890702;MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_SetDate=2026-02-28T03:38:17.089Z;MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Name=General;MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_ContentBits=1;MSIP_Label_254aa743-8abd-4226-a04e-84db594c20b7_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=telechips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU4P216MB1182:EE_|PUUP216MB3188:EE_
x-ms-office365-filtering-correlation-id: 64c423de-64c6-4eef-0d19-08de767acf92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|6049299003|38070700021|8096899003|4053099003|13003099007;
x-microsoft-antispam-message-info:
 /cE3vkun70LOG9HOTwjZvN1VgkPdzX5frkLSroNFH3VdPasbiWrG0EtNa7vIaqAxcZu5gof+8Vsw9oKO5g4JMjBhHdCjc/0o2VNj78+AQ8j3W6tiqkxtMa7QqT46uzV7vWt6NnYZvEJmW3SfG+3gCoJolANVvKx5SGB/+byiZXYPZHm+nx64ydsKVTTqNLxdYRdnWVsb9cxws1TIDwvTT5m7yEr+WysRB6wF2+FZfGt0R0Avd3by97mfUjdFA/5xbrlfe8SyvqtbevaCSslECiH77knrNMA5DlHC+1+o3/dUIgF0N8QjkgAJodLt3B6Yupj6wOAYISc3UeU4CgGRhR5OOQrFJ8shMYXbFfjLBOTHYHB/TidBfz3T5rb/UnQTNDif9aEva6kM+OvCqlWUaZBHZq34kPwu8ZZMEUa8FosvwLHTDQrAwfdp8dREfJadxGr9cAJGav+fyhUgIKN7i8dov5uLJdex67XtlfTm9jNjrnKQLGarzptMIUYmvGTniiy1cLpd6As6UzSq0K1sP06KVqe8XJEhn0Bpqt4rQrmv8oJcuqwnMxQadj5Jw0R80f16Jn5AlntV6XDiAlAh1yXOdes7mOeo60b61GU1geYUsP1rAqtzSqnecElxYC7/cfXpIx7/s73YmWw+UvQlDcV24IdBxSoE/tEZrPBrSxK5/IN1sqyNx7qFmJRcUgNfFG4rTziVGjpPjfYmo4UdhXlFETlYeOTp2iFRlloGcfdMlR6IhQ29LKCuaQ9Jof8H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1182.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6049299003)(38070700021)(8096899003)(4053099003)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?eVc2REgxN2JXMldib0t6YTFhbjVSNURTaTRDVG9TSlBJVE8zZ0tU?=
 =?ks_c_5601-1987?B?Rlg3emF5elJydXF0dVl1MGJsdjdQVnRpMDJkWkpHcFFYSUVZRTZJ?=
 =?ks_c_5601-1987?B?T1FjbDV0ME1kN1VDK3AxSE5ERGxIRXdDRmFnVDJaaUNGZGhDbWVV?=
 =?ks_c_5601-1987?B?eXBDQ3NjZTZzYU01ZUt6aTFsRDlLWks1cDdxcGRoN2ZsMyt0d0Jp?=
 =?ks_c_5601-1987?B?S3FyQmt4ek0xQVRmeU1lZGd2NEtNN3JLK1NMZXR0MHhHelZUMVFq?=
 =?ks_c_5601-1987?B?bEpHdS9JMmQ4N1JENlVhMmtSaXVmSzRJaFZIakpTamk4cW5FL1gz?=
 =?ks_c_5601-1987?B?YlMxdy9weFRjRzBQdXlHd0tuNHVqR3ovRzRZVTljc0F4TWdOSGdK?=
 =?ks_c_5601-1987?B?NUt1NGlrRC8vdEdTWWZLVmNYRWdqWUw1eDlJaWU0Y0dEVHlBOFhW?=
 =?ks_c_5601-1987?B?U1VkbFhrKyt0UGNTbVE3dnBGTkp6aFE3SDdsamlWeVZLZnhYdi9H?=
 =?ks_c_5601-1987?B?VWxkWjBVdDZZYmltcEh2ZUUrTitXS2U3NWxBM2tUTjZXMGhKamRo?=
 =?ks_c_5601-1987?B?YXFvRW50d2dTUDB6Um1rS1U3R1ZEbmptRWxONEZTditrKzZ2Zjl2?=
 =?ks_c_5601-1987?B?YnBOZWNVR3FnekZHWkFYbzBsZ25VMmZsNTBYeTdNSyt4RFF4aGtR?=
 =?ks_c_5601-1987?B?cTJITndTM0RLRXluVGFuc09TTFkyTnIxTUd6bEcxS3F0U25MMTRr?=
 =?ks_c_5601-1987?B?dytrSmh0Y2srL2QrTzExTS9SbEJ4cFlhcjJES3ZIeUU1eDh2OWhQ?=
 =?ks_c_5601-1987?B?RGhVL1EyME1qS0UyTUpkaFUvU2xJdG1MU1c5WTF2MEMxdFIwTzlw?=
 =?ks_c_5601-1987?B?TTE0UWllVlVKUko4aUNycW50eENjazkxaGxwSGxvTUFvSkxGYnh0?=
 =?ks_c_5601-1987?B?ZStkN3MrcVdYNyswZzM0STNJTTBLU0hwcmt6S0V1Z200TEtNUFlm?=
 =?ks_c_5601-1987?B?M2hFTm1KdUFEUUVtTkJSVmd3dkY4UVZhWjE2Q2ZDY0lCWWVIblFG?=
 =?ks_c_5601-1987?B?ODhQdVBlcU1BWHg3am9ZU2NIMk1UbHh4U0srUjJTS2hPRXdYYURo?=
 =?ks_c_5601-1987?B?VEVSbUpyalFibUFQZkVRRVhSVFUxaGs0Z2R5dUplVXBnenc3UFU3?=
 =?ks_c_5601-1987?B?M1o4T0crYm5xSlVsOVRqN2xXSXc2dDlLSC9Ea2J4WG1NL0JzZUts?=
 =?ks_c_5601-1987?B?YWxuZ2htTXQrU1gycnRNZGNvaDV2NmYwTHhrcjFZTHdmcjNQcnNL?=
 =?ks_c_5601-1987?B?bG03TGpteThDaDVUQ3ZZL0xNMVR5UDBrSVpDYStndDE0UGNGNHhB?=
 =?ks_c_5601-1987?B?SkxvL2FkZzloenoxUjFoajQrUXYzK3hpUndrSGpjN0paQ1BZbEJQ?=
 =?ks_c_5601-1987?B?SDBPZ0gzN2pHeE9nZE1lRXB0ajkzRmdzUklqV21xLzJtbVJPK3Jo?=
 =?ks_c_5601-1987?B?ZlJQRVk4a1k4UEpQbjlJZXRFdFB3Zi93bnlneUNSU2o5ZnZMeE5X?=
 =?ks_c_5601-1987?B?MCtLNTIvVmNGYzVJK0lsVy93dVNZL2R5YnI2WmdIcjJRZkc5dWdG?=
 =?ks_c_5601-1987?B?TjVvVEhFZEZLWWlCWEptNThROW4wTmlzZEJYTWg5WHJXUFI5aFV2?=
 =?ks_c_5601-1987?B?Z3BZbXNLZ3lsVk5vM2tBZmhsLy9kWDFNZnQ1dDdZZUxMTEljN1JV?=
 =?ks_c_5601-1987?B?QnA1TUNaQ3BSRWx5REJHZ3Q3ZEc1dG1jeWd4RHE5ZHZackRmeld5?=
 =?ks_c_5601-1987?B?MFVVaXdON0N6ZVIrRmh0YmJTTWg4UlhKdlJmR25VbDAzdVhIWmUz?=
 =?ks_c_5601-1987?B?dEYwSEdrSlY0MDlzWEhGa2dYSWRMbm52VWtibGlJZ1NzVGMybkRH?=
 =?ks_c_5601-1987?B?LzBFUmlmNzJLTVI2M2J4OXNJeVNvZDZ2MERZWE9BZS91YTB6WXNN?=
 =?ks_c_5601-1987?B?RkxUd1p1ZUhQalpDTVRTblhEbkdzcXVsU29Gak9qZFZKNjRoN1RD?=
 =?ks_c_5601-1987?B?RGFpM3JTT2FGejlwUDNJT2FTM1Q5WUFiKzlRbWIzTFF6ZEVYZ3ls?=
 =?ks_c_5601-1987?B?OHhpR1ZFWUZuaE1YekptMUxRWmZFZ3JIQ1lQMFpPTkVaMEhUWEZF?=
 =?ks_c_5601-1987?B?ZnZtZ3dWVVlxWHZQYzI4YmN5ZXFNT0RPYlJXUlFFdjJiL3ByUUlY?=
 =?ks_c_5601-1987?B?S1VqOE1wdEcyRzBMUlc4U1FyVWZiNjhTL3FHcnYxM1NCS3hsQ2ZI?=
 =?ks_c_5601-1987?B?dVdhbGl3b0J2Z2lBckFqVnkzU0R2bW16djRsOWFTeGJaM2FEaXd6?=
 =?ks_c_5601-1987?B?QUEvK1I4cHRlaVJYZkJ1Qm9ySEUvUFl6T1FJTWxIS2VZbVpheFN4?=
 =?ks_c_5601-1987?B?RFVpSlZGWDBSZ0pLNDRoT3pNYW1OQm1ONEwrTUVQQnVrYkMvVzZJ?=
 =?ks_c_5601-1987?B?bUZEZDhBNTJsWVZDaWJXNjRUTVFCNG5RVm41SmhiMHJwV1cxaWls?=
 =?ks_c_5601-1987?B?VVlQTko1UE9OS2xnOXZyMmdSZGRUVXQ5S0NmcUlidGE4NHVuQjRt?=
 =?ks_c_5601-1987?B?RDV5SFR6azlLTGV3VEVMc3hsdzNlOHZKb01pZGwzZkVFUDROUkI4?=
 =?ks_c_5601-1987?B?MWoxM3hSUStEZmJkVUdvZ01UQTVEcnVxdWxWaDJieDhFdz09?=
Content-Type: multipart/mixed;
	boundary="_006_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: telechips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1182.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c423de-64c6-4eef-0d19-08de767acf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 03:38:17.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9ec49ece-9398-4634-9468-0ca88a890702
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BK2i8iN1il1PxJezon123yv+r2sb+3aZCohazJEXb35C2FC4bhQI9iVyepnQwyzSabYJesLyF2USHOJt2kexQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUUP216MB3188

--_006_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: multipart/related;
	boundary="_005_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_";
	type="multipart/alternative"

--_005_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: multipart/alternative;
	boundary="_000_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_"

--_000_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgYW0gc2VlaW5nIGEgbG9ja2RlcCB3YXJuaW5nIGluIHNwaWRldiByZXBvcnRp
bmcgYSBwb3NzaWJsZSBjaXJjdWxhcg0KbG9ja2luZyBkZXBlbmRlbmN5IGJldHdlZW4gYnVmX2xv
Y2sgYW5kIHNwaV9sb2NrLg0KDQpLZXJuZWw6DQogIDYuMTIuMjMNCg0KTG9ja2RlcCB3YXJuaW5n
Og0KDQpbICAgNjAuOTc3MDY5XSBXQVJOSU5HOiBwb3NzaWJsZSBjaXJjdWxhciBsb2NraW5nIGRl
cGVuZGVuY3kgZGV0ZWN0ZWQNClsgICA2MC45OTYxODBdIHNwaWRldl90ZXN0X3RlbC8yNTYgaXMg
dHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoNClsgICA2MS4wMDE2NTZdIGZmZmYwMDAxYTEyM2ZhNzgg
KCZzcGlkZXYtPnNwaV9sb2NrKXsrLisufS17MzozfSwgYXQ6IHNwaWRldl9zeW5jKzB4MmMvMHg3
MA0KWyAgIDYxLjAwOTY3NF0NClsgICA2MS4wMTU0OTVdIGJ1dCB0YXNrIGlzIGFscmVhZHkgaG9s
ZGluZyBsb2NrOg0KWyAgIDYxLjAxNTQ5NV0gZmZmZjAwMDFhMTIzZmIzMCAoJnNwaWRldi0+YnVm
X2xvY2speysuKy59LXszOjN9LCBhdDogc3BpZGV2X3dyaXRlKzB4NDQvMHgxM2MNClsgICA2MS4w
MjM2NzldDQpbICAgNjEuMDM5MzE0XSB0aGUgZXhpc3RpbmcgZGVwZW5kZW5jeSBjaGFpbiAoaW4g
cmV2ZXJzZSBvcmRlcikgaXM6DQpbICAgNjEuMDM5MzE0XQ0KWyAgIDYxLjAzOTMxNF0gLT4gIzEg
KCZzcGlkZXYtPmJ1Zl9sb2NrKXsrLisufS17MzozfToNClsgICA2MS4wNTQxMTRdICAgICAgICBz
cGlkZXZfaW9jdGwrMHg4MC8weDcxOA0KWyAgIDYxLjA1ODIwNV0gICAgICAgIF9fYXJtNjRfc3lz
X2lvY3RsKzB4OTQvMHhkOA0KLi4uDQpbICAgNjEuMDk0NzYwXSAtPiAjMCAoJnNwaWRldi0+c3Bp
X2xvY2speysuKy59LXszOjN9Og0KWyAgIDYxLjExMTk4OF0gICAgICAgIHNwaWRldl9zeW5jKzB4
MmMvMHg3MA0KWyAgIDYxLjEyMDM0Ml0gICAgICAgIHNwaWRldl93cml0ZSsweDEwNC8weDEzYw0K
DQpGcm9tIGluc3BlY3Rpb24gb2YgdGhlIGxvY2tpbmcgcGF0aHM6DQoNClBhdGggMSAod3JpdGUv
cmVhZCk6DQogIHNwaWRldl93cml0ZSgpDQogICAgbXV0ZXhfbG9jaygmc3BpZGV2LT5idWZfbG9j
aykNCiAgICAgIC0+IHNwaWRldl9zeW5jKCkNCiAgICAgICAgICAgbXV0ZXhfbG9jaygmc3BpZGV2
LT5zcGlfbG9jaykNCg0KICBMb2NrIG9yZGVyOiBidWZfbG9jayAtPiBzcGlfbG9jaw0KDQpQYXRo
IDIgKGlvY3RsKToNCiAgc3BpZGV2X2lvY3RsKCkNCiAgICBtdXRleF9sb2NrKCZzcGlkZXYtPnNw
aV9sb2NrKQ0KICAgIG11dGV4X2xvY2soJnNwaWRldi0+YnVmX2xvY2spDQoNCiAgTG9jayBvcmRl
cjogc3BpX2xvY2sgLT4gYnVmX2xvY2sNCg0KVGhpcyByZXN1bHRzIGluIGFuIGFwcGFyZW50IGxv
Y2sgb3JkZXJpbmcgaW52ZXJzaW9uOg0KDQogICAgYnVmX2xvY2sgLT4gc3BpX2xvY2sNCiAgICBz
cGlfbG9jayAtPiBidWZfbG9jaw0KDQpMb2NrZGVwIHJlcG9ydHMgdGhpcyBhcyBhIHBvc3NpYmxl
IGNpcmN1bGFyIGRlcGVuZGVuY3ksDQp3aXRoIHRoZSBzY2VuYXJpbzoNCg0KICBDUFUwOiBsb2Nr
KGJ1Zl9sb2NrKSAtPiBsb2NrKHNwaV9sb2NrKQ0KICBDUFUxOiBsb2NrKHNwaV9sb2NrKSAtPiBs
b2NrKGJ1Zl9sb2NrKQ0KDQoNCg0KSSBpbnRlbnRpb25hbGx5IGFkZGVkIGFuIGFydGlmaWNpYWwg
ZGVsYXkgaW4gc3BpZGV2X3dyaXRlKCkNCmJlZm9yZSBjb3B5X2Zyb21fdXNlcigpIHRvIGVubGFy
Z2UgdGhlIHRpbWluZyB3aW5kb3cuDQoNClRoZW4gSSBleGVjdXRlZCBjb25jdXJyZW50IG9wZXJh
dGlvbnMgb24gdGhlIHNhbWUgZGV2aWNlDQooc3BpZGV2MC4wKToNCg0KVGhyZWFkIEE6IHdyaXRl
KCkNClRocmVhZCBCOiBpb2N0bCgpDQoNClRoaXMgcmVsaWFibHkgcmVzdWx0cyBpbiBhbiBhY3R1
YWwgZGVhZGxvY2s6DQoNCkNQVTA6IGxvY2soYnVmX2xvY2spIC0+IHdhaXRpbmcgZm9yIHNwaV9s
b2NrDQpDUFUxOiBsb2NrKHNwaV9sb2NrKSAtPiB3YWl0aW5nIGZvciBidWZfbG9jaw0KDQpUaGUg
c3lzdGVtIGJlY29tZXMgcGVybWFuZW50bHkgYmxvY2tlZC4NCg0KTXkgcXVlc3Rpb25zOg0KDQox
LiBJcyB0aGlzIGxvY2tpbmcgb3JkZXIgaW50ZW50aW9uYWwgYW5kIGNvbnNpZGVyZWQgc2FmZT8N
CjIuIElzIHRoaXMgYSBrbm93biBsb2NrZGVwIGZhbHNlIHBvc2l0aXZlPw0KDQoNCg0KVGhhbmtz
LA0KDQpZdWppbiBIb25nDQoNCg0KW8DMuczB9l0NCg0KyKvAr8H4IChZdWppbiBIb25nKQ0KDQpT
VyBEZXZlbG9wbWVudCBHcm91cCAvIENvcmUgIEJTUDIgVGVhbSAvIE1hbmFnZXINCg0KeWouaG9u
Z0B0ZWxlY2hpcHMuY29tPG1haWx0bzpsa2pAdGVsZWNoaXBzLmNvbT4NCg0KTSArODItMi0zMDE3
LTU3MjgNCg0KsOax4rW1ILy6s7K9wyC89sGksbggsd3F5LfOODC5+LHmIDI3IMXat7nEqL26IMbH
sbO757/BICgxMzQ1MykNCg0KMjcgR3VlbXRvLXJvIDgwQmVvbi1naWwsIFN1amVvbmctZ3UgU2Vv
bmduYW0tc2ksIEd5ZW9uZ2dpZG8gMTM0NTMsIEtvcmVhDQoNCldlYnNpdGUgICAgOnd3dy50ZWxl
Y2hpcHMuY29tPGh0dHA6Ly93d3cudGVsZWNoaXBzLmNvbS8+DQpGYWNlYm9vayA6IGZhY2Vib29r
LmNvbS90ZWxlY2hpcHMuaW5jPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3RlbGVjaGlwcy5pbmM+
DQoNCkxpbmtlZEluICAgOmxpbmtlZGluLmNvbS9jb21wYW55L3RlbGVjaGlwcy1pbmM8aHR0cDov
L3d3dy5saW5rZWRpbi5jb20vY29tcGFueS90ZWxlY2hpcHMtaW5jPg0KDQpZb3VUdWJlICAgOnlv
dXR1YmUuY29tL3VzZXIvVGVsZWNoaXBzSW5jL1ZpZGVvPGh0dHA6Ly93d3cueW91dHViZS5jb20v
dXNlci9UZWxlY2hpcHNJbmMvVmlkZW8+DQoNCg0KDQpUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNo
bWVudHMgdG8gaXQgbWF5IGJlIGNvbmZpZGVudGlhbCBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBm
b3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4NCg0K
QW55IHZpZXdzIG9yIG9waW5pb25zIGV4cHJlc3NlZCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBh
dXRob3IgYW5kIGRvIG5vdCBuZWNlc3NhcmlseSByZXByZXNlbnQgdGhvc2Ugb2YgVGVsZWNoaXBz
IEluYy4NCg0KSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVt
YWlsLCB5b3UgbXVzdCBuZWl0aGVyIHRha2UgYW55IGFjdGlvbiBiYXNlZCB1cG9uIGl0cyBjb250
ZW50cywgbm9yIGNvcHkgb3Igc2hvdyBpdCB0byBhbnlvbmUuDQoNClBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBieSBlLW1haWwgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBl
LW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRlIHRoaXMgZS1tYWlsIGZyb20geW91ciBzeXN0ZW0u
DQoNCldvdWxkIHlvdSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRo
aXMgZW1haWw/DQoNCg0KDQpUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgdG8gaXQgbWF5
IGJlIGNvbmZpZGVudGlhbCBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0
aGUgaW5kaXZpZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4gQW55IHZpZXdzIG9yIG9waW5p
b25zIGV4cHJlc3NlZCBhcmUgc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5kIGRvIG5vdCBu
ZWNlc3NhcmlseSByZXByZXNlbnQgdGhvc2Ugb2YgVGVsZWNoaXBzIEluYy4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIGVtYWlsLCB5b3UgbXVzdCBuZWl0aGVy
IHRha2UgYW55IGFjdGlvbiBiYXNlZCB1cG9uIGl0cyBjb250ZW50cyBub3IgY29weSBvciBzaG93
IGl0IHRvIGFueW9uZS4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGVt
YWlsIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZW1haWwgYnkgbWlzdGFrZSBhbmQgZGVsZXRl
IHRoaXMgZW1haWwgZnJvbSB5b3VyIHN5c3RlbS4gUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9u
bWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlbWFpbC4NCg==

--_000_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I am seeing a lockdep warning in spidev reporting a possible circular</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
locking dependency between buf_lock and spi_lock.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Kernel:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; 6.12.23&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Lockdep warning:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 60.977069] WARNING: possible circular locking dependency detected<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 60.996180] spidev_test_tel/256 is trying to acquire lock:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.001656] ffff0001a123fa78 (&amp;spidev-&gt;spi_lock){+.+.}-{3:3}=
, at: spidev_sync+0x2c/0x70</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.009674]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.015495] but task is already holding lock:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.015495] ffff0001a123fb30 (&amp;spidev-&gt;buf_lock){+.+.}-{3:3}=
, at: spidev_write+0x44/0x13c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.023679]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.039314] the existing dependency chain (in reverse order) is:</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.039314]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.039314] -&gt; #1 (&amp;spidev-&gt;buf_lock){+.+.}-{3:3}:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.054114] &nbsp; &nbsp; &nbsp; &nbsp;spidev_ioctl+0x80/0x718</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.058205] &nbsp; &nbsp; &nbsp; &nbsp;__arm64_sys_ioctl+0x94/0xd8<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
...</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.094760] -&gt; #0 (&amp;spidev-&gt;spi_lock){+.+.}-{3:3}:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.111988] &nbsp; &nbsp; &nbsp; &nbsp;spidev_sync+0x2c/0x70</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[ &nbsp; 61.120342] &nbsp; &nbsp; &nbsp; &nbsp;spidev_write+0x104/0x13c</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
From inspection of the locking paths:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Path 1 (write/read):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; spidev_write()</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; mutex_lock(&amp;spidev-&gt;buf_lock)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; -&gt; spidev_sync()</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;mutex_lock(&amp;spidev-&gt;spi_loc=
k)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; Lock order: buf_lock -&gt; spi_lock</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Path 2 (ioctl):</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; spidev_ioctl()</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; mutex_lock(&amp;spidev-&gt;spi_lock)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; mutex_lock(&amp;spidev-&gt;buf_lock)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; Lock order: spi_lock -&gt; buf_lock</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This results in an apparent lock ordering inversion:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; buf_lock -&gt; spi_lock</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; spi_lock -&gt; buf_lock</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Lockdep reports this as a possible circular dependency,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
with the scenario:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; CPU0: lock(buf_lock) -&gt; lock(spi_lock)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; CPU1: lock(spi_lock) -&gt; lock(buf_lock)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I intentionally added an artificial delay in spidev_write()<br>
before copy_from_user() to enlarge the timing window.<br>
<br>
Then I executed concurrent operations on the same device<br>
(spidev0.0):<br>
<br>
Thread A: write()<br>
Thread B: ioctl()<br>
<br>
This reliably results in an actual deadlock:<br>
<br>
CPU0: lock(buf_lock) -&gt; waiting for spi_lock<br>
CPU1: lock(spi_lock) -&gt; waiting for buf_lock<br>
<br>
The system becomes permanently blocked.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
My questions:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
1. Is this locking order intentional and considered safe?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
2. Is this a known lockdep false positive?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yujin Hong</div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 12pt;"><img style=3D"w=
idth: 700px; height: 27px; margin-top: 0px; margin-bottom: 0px;" height=3D"=
27" width=3D"700" id=3D"image_0" alt=3D"=C0=CC=B9=CC=C1=F6" data-outlook-tr=
ace=3D"F:1|T:1" src=3D"cid:b06a8048-029a-4a38-a0f1-8f4f478ef253"></span></p=
>
<table cellpadding=3D"0" border=3D"0">
<tbody>
<tr>
<td style=3D"padding: 0.75pt;">
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>=C8=AB=C0=AF=
=C1=F8&nbsp;(Yujin Hong)</b></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>SW Developme=
nt Group /&nbsp;Core&nbsp; BSP2 Team&nbsp;/&nbsp;Manager</b></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;">yj.hong</span><=
span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt; color: blue;"><u>=
<a style=3D"color: blue; margin-top: 0px; margin-bottom: 0px;" title=3D"mai=
lto:lkj@telechips.com" class=3D"OWAAutoLink" id=3D"OWAa3290fc6-2bba-d58b-26=
90-7a58ad33a2c9" target=3D"_blank" href=3D"mailto:lkj@telechips.com">@telec=
hips.com</a></u></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>M</b>&nbsp;+=
82-2-3017-5728</span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>=B0=E6=B1=E2=
=B5=B5 =BC=BA=B3=B2=BD=C3 =BC=F6=C1=A4=B1=B8 =B1=DD=C5=E4=B7=CE80=B9=F8=B1=
=E6&nbsp;27 =C5=DA=B7=B9=C4=A8=BD=BA =C6=C7=B1=B3=BB=E7=BF=C1&nbsp;(13453)<=
/b></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;">27 Guemto-ro 80=
Beon-gil, Sujeong-gu Seongnam-si, Gyeonggido 13453, Korea</span></p>
</td>
<td style=3D"padding: 0.75pt;">
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>Website &nbs=
p; &nbsp;:</b></span><span style=3D"font-family: =B1=BC=B8=B2; font-size: 1=
1pt; color: blue;"><u><a style=3D"color: blue; margin-top: 0px; margin-bott=
om: 0px;" title=3D"http://www.telechips.com/" class=3D"OWAAutoLink" id=3D"O=
WA8a3e77fb-399b-25d5-d5e1-8215aff527b4" target=3D"_blank" href=3D"http://ww=
w.telechips.com/">www.telechips.com</a></u></span><span style=3D"font-famil=
y: =B1=BC=B8=B2; font-size: 11pt;">&nbsp;<br>
<b>Facebook&nbsp;: </b></span><span style=3D"font-family: =B1=BC=B8=B2; fon=
t-size: 11pt; color: blue;"><u><a style=3D"color: blue; margin-top: 0px; ma=
rgin-bottom: 0px;" title=3D"http://www.facebook.com/telechips.inc" class=3D=
"OWAAutoLink" id=3D"OWA4fabe12f-12bf-b6fe-073f-d2ede46da363" target=3D"_bla=
nk" href=3D"http://www.facebook.com/telechips.inc">facebook.com/telechips.i=
nc</a></u></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>LinkedIn &nb=
sp;&nbsp;:</b></span><span style=3D"font-family: =B1=BC=B8=B2; font-size: 1=
1pt; color: blue;"><u><a style=3D"color: blue; margin-top: 0px; margin-bott=
om: 0px;" title=3D"http://www.linkedin.com/company/telechips-inc" class=3D"=
OWAAutoLink" id=3D"OWAac5504f4-1b96-c5af-8f45-c911a61a8d47" target=3D"_blan=
k" href=3D"http://www.linkedin.com/company/telechips-inc">linkedin.com/comp=
any/telechips-inc</a></u></span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 11pt;"><b>YouTube &nbs=
p;&nbsp;:</b></span><span style=3D"font-family: =B1=BC=B8=B2; font-size: 11=
pt; color: blue;"><u><a style=3D"color: blue; margin-top: 0px; margin-botto=
m: 0px;" title=3D"http://www.youtube.com/user/telechipsinc/video" class=3D"=
OWAAutoLink" id=3D"OWAb5a4c8ba-ecdb-c54a-168e-99f0bca1498e" target=3D"_blan=
k" href=3D"http://www.youtube.com/user/TelechipsInc/Video">youtube.com/user=
/TelechipsInc/Video</a></u></span></p>
</td>
</tr>
</tbody>
</table>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2; font-size: 12pt;">&nbsp;</span></=
p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2;">This&nbsp;email and any attachme=
nts to it may be confidential and are intended solely for the use of the in=
dividual to whom it&nbsp;is&nbsp;addressed.</span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2;">Any views or opinions expressed =
are solely those of the author and do not necessarily represent those of&nb=
sp;Telechips Inc.</span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2;">If you are not the intended reci=
pient of this email, you must neither take any action based upon its conten=
ts,&nbsp;nor copy or show it to&nbsp;anyone.</span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2;">Please notify the&nbsp;sender im=
mediately by e-mail if you have received this e-mail by mistake&nbsp;and de=
lete this e-mail from your system.</span></p>
<p style=3D"text-align: left; margin: 0cm; font-family: &quot;=B8=BC=C0=BA =
=B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
<span style=3D"font-family: =B1=BC=B8=B2;">Would you&nbsp;consider the envi=
ronment before printing this email?</span></p>
<p style=3D"text-align: justify; margin: 0cm; font-family: &quot;=B8=BC=C0=
=BA =B0=ED=B5=F1&quot;; font-size: 10pt;" class=3D"elementToProof">
&nbsp;</p>
</div>
<title>Telechips Email Notification</title>
<style>
      /* Set the font and font size for the entire document */
      body {
        font-family: Arial, sans-serif;
        font-size: 7px;
      }
     =20
      /* Set the font and font size for the message content */
      .message {
        font-family: Arial, sans-serif;
        font-size: 7px;
      }
    </style>
<div class=3D"message">
<p>This email and any attachments to it may be confidential and are intende=
d solely for the use of the individual to whom it is addressed. Any views o=
r opinions expressed are solely those of the author and do not necessarily =
represent those of Telechips Inc.
 If you are not the intended recipient of this email, you must neither take=
 any action based upon its contents nor copy or show it to anyone. Please n=
otify the sender immediately by email if you have received this email by mi=
stake and delete this email from
 your system. Please consider the environment before printing this email.</=
p>
</div>
</body>
</html>

--_000_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_--

--_005_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: image/jpg; name="=?ks_c_5601-1987?B?T3V0bG9vay3AzLnMwfY=?="
Content-Description: =?ks_c_5601-1987?B?T3V0bG9vay3AzLnMwfY=?=
Content-Disposition: inline;
	filename="=?ks_c_5601-1987?B?T3V0bG9vay3AzLnMwfY=?="; size=4559;
	creation-date="Sat, 28 Feb 2026 03:38:17 GMT";
	modification-date="Sat, 28 Feb 2026 03:38:17 GMT"
Content-ID: <b06a8048-029a-4a38-a0f1-8f4f478ef253>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAbArwDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2vUvE
ej6PcLb6hqENvMybwjnkrkjP5g/lVL/hOfDH/QatfzP+FeO/Ea/+3+OL8g5SArAvttHP/j2a5SvT
p4GMoJt7nLLENNpH0b/wnPhj/oNWv5n/AAo/4Tnwx/0GrX8z/hXzlRV/2fDuyfrEux9G/wDCc+GP
+g1a/mf8KP8AhOfDH/QatfzP+FfOVFH9nw7sPrEux9G/8Jz4Y/6DVr+Z/wAKP+E58Mf9Bq1/M/4V
85UUf2fDuw+sS7H0b/wnPhj/AKDVr+Z/wo/4Tnwx/wBBq1/M/wCFfOVFH9nw7sPrEux9G/8ACc+G
P+g1a/mf8KP+E58Mf9Bq1/M/4V85UUf2fDuw+sS7H0b/AMJz4Y/6DVr+Z/wo/wCE58Mf9Bq1/M/4
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

--_005_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_--

--_006_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_
Content-Type: text/plain; name="Circular lock warn.txt"
Content-Description: Circular lock warn.txt
Content-Disposition: attachment; filename="Circular lock warn.txt"; size=3995;
	creation-date="Sat, 28 Feb 2026 03:37:10 GMT";
	modification-date="Sat, 28 Feb 2026 03:38:17 GMT"
Content-Transfer-Encoding: base64

WyAgIDYwLjk3NzA2OV0gV0FSTklORzogcG9zc2libGUgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRl
bmN5IGRldGVjdGVkDQpbICAgNjAuOTg1NTc1XSA2LjEyLjIzLXRlbGVjaGlwcysgIzU2IE5vdCB0
YWludGVkDQpbICAgNjAuOTkwMDExXSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NClsgICA2MC45OTYxODBdIHNwaWRldl90ZXN0X3RlbC8yNTYg
aXMgdHJ5aW5nIHRvIGFjcXVpcmUgbG9jazoNClsgICA2MS4wMDE2NTZdIGZmZmYwMDAxYTEyM2Zh
NzggKCZzcGlkZXYtPnNwaV9sb2NrKXsrLisufS17MzozfSwgYXQ6IHNwaWRldl9zeW5jKzB4MmMv
MHg3MA0KWyAgIDYxLjAwOTY3NF0NClsgICA2MS4wMDk2NzRdIGJ1dCB0YXNrIGlzIGFscmVhZHkg
aG9sZGluZyBsb2NrOg0KWyAgIDYxLjAxNTQ5NV0gZmZmZjAwMDFhMTIzZmIzMCAoJnNwaWRldi0+
YnVmX2xvY2speysuKy59LXszOjN9LCBhdDogc3BpZGV2X3dyaXRlKzB4NDQvMHgxM2MNClsgICA2
MS4wMjM2NzldDQpbICAgNjEuMDIzNjc5XSB3aGljaCBsb2NrIGFscmVhZHkgZGVwZW5kcyBvbiB0
aGUgbmV3IGxvY2suDQpbICAgNjEuMDIzNjc5XQ0KWyAgIDYxLjAzMTg0M10NClsgICA2MS4wMzE4
NDNdIHRoZSBleGlzdGluZyBkZXBlbmRlbmN5IGNoYWluIChpbiByZXZlcnNlIG9yZGVyKSBpczoN
ClsgICA2MS4wMzkzMTRdDQpbICAgNjEuMDM5MzE0XSAtPiAjMSAoJnNwaWRldi0+YnVmX2xvY2sp
eysuKy59LXszOjN9Og0KWyAgIDYxLjA0NTU4Ml0gICAgICAgIF9fbXV0ZXhfbG9jaysweGE0LzB4
ZmMwDQpbICAgNjEuMDQ5Njc2XSAgICAgICAgbXV0ZXhfbG9ja19uZXN0ZWQrMHgyNC8weDMwDQpb
ICAgNjEuMDU0MTE0XSAgICAgICAgc3BpZGV2X2lvY3RsKzB4ODAvMHg3MTgNClsgICA2MS4wNTgy
MDVdICAgICAgICBfX2FybTY0X3N5c19pb2N0bCsweDk0LzB4ZDgNClsgICA2MS4wNjI2NDRdICAg
ICAgICBpbnZva2Vfc3lzY2FsbCsweDQ0LzB4MTAwDQpbICAgNjEuMDY2OTEyXSAgICAgICAgZWww
X3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHg0MC8weGUwDQpbICAgNjEuMDcyMTMxXSAgICAgICAg
ZG9fZWwwX3N2YysweDFjLzB4MjgNClsgICA2MS4wNzU5NjFdICAgICAgICBlbDBfc3ZjKzB4NDgv
MHgxMTQNClsgICA2MS4wNzk2MTddICAgICAgICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGMwLzB4
YzQNClsgICA2MS4wODQzMTRdICAgICAgICBlbDB0XzY0X3N5bmMrMHgxOTAvMHgxOTQNClsgICA2
MS4wODg0OTFdDQpbICAgNjEuMDg4NDkxXSAtPiAjMCAoJnNwaWRldi0+c3BpX2xvY2speysuKy59
LXszOjN9Og0KWyAgIDYxLjA5NDc2MF0gICAgICAgIF9fbG9ja19hY3F1aXJlKzB4MTM5NC8weDFj
YzgNClsgICA2MS4wOTkyODRdICAgICAgICBsb2NrX2FjcXVpcmUrMHgxMWMvMHgzMjQNClsgICA2
MS4xMDM0NjBdICAgICAgICBfX211dGV4X2xvY2srMHhhNC8weGZjMA0KWyAgIDYxLjEwNzU1MF0g
ICAgICAgIG11dGV4X2xvY2tfbmVzdGVkKzB4MjQvMHgzMA0KWyAgIDYxLjExMTk4OF0gICAgICAg
IHNwaWRldl9zeW5jKzB4MmMvMHg3MA0KWyAgIDYxLjExNTkwNV0gICAgICAgIHNwaWRldl9zeW5j
X3dyaXRlKzB4OWMvMHhjMA0KWyAgIDYxLjEyMDM0Ml0gICAgICAgIHNwaWRldl93cml0ZSsweDEw
NC8weDEzYw0KWyAgIDYxLjEyNDUyMF0gICAgICAgIHZmc193cml0ZSsweGQ0LzB4NWE0DQpbICAg
NjEuMTI4MzUxXSAgICAgICAga3N5c193cml0ZSsweGUwLzB4ZjgNClsgICA2MS4xMzIxODFdICAg
ICAgICBfX2FybTY0X3N5c193cml0ZSsweDFjLzB4MjgNClsgICA2MS4xMzY2MTldICAgICAgICBp
bnZva2Vfc3lzY2FsbCsweDQ0LzB4MTAwDQpbICAgNjEuMTQwODgzXSAgICAgICAgZWwwX3N2Y19j
b21tb24uY29uc3Rwcm9wLjArMHg0MC8weGUwDQpbICAgNjEuMTQ2MTAyXSAgICAgICAgZG9fZWww
X3N2YysweDFjLzB4MjgNClsgICA2MS4xNDk5MzNdICAgICAgICBlbDBfc3ZjKzB4NDgvMHgxMTQN
ClsgICA2MS4xNTM1ODhdICAgICAgICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGMwLzB4YzQNClsg
ICA2MS4xNTgyODVdICAgICAgICBlbDB0XzY0X3N5bmMrMHgxOTAvMHgxOTQNClsgICA2MS4xNjI0
NjFdDQpbICAgNjEuMTYyNDYxXSBvdGhlciBpbmZvIHRoYXQgbWlnaHQgaGVscCB1cyBkZWJ1ZyB0
aGlzOg0KWyAgIDYxLjE2MjQ2MV0NClsgICA2MS4xNzA0NTJdICBQb3NzaWJsZSB1bnNhZmUgbG9j
a2luZyBzY2VuYXJpbzoNClsgICA2MS4xNzA0NTJdDQpbICAgNjEuMTc2MzYxXSAgICAgICAgQ1BV
MCAgICAgICAgICAgICAgICAgICAgQ1BVMQ0KWyAgIDYxLjE4MDg4MF0gICAgICAgIC0tLS0gICAg
ICAgICAgICAgICAgICAgIC0tLS0NClsgICA2MS4xODU0MDBdICAgbG9jaygmc3BpZGV2LT5idWZf
bG9jayk7DQpbICAgNjEuMTg5MTQ1XSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbG9j
aygmc3BpZGV2LT5zcGlfbG9jayk7DQpbICAgNjEuMTk1NDA2XSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbG9jaygmc3BpZGV2LT5idWZfbG9jayk7DQpbICAgNjEuMjAxNjY3XSAgIGxv
Y2soJnNwaWRldi0+c3BpX2xvY2spOw0KWyAgIDYxLjIwNTQxMl0NClsgICA2MS4yMDU0MTJdICAq
KiogREVBRExPQ0sgKioqDQpbICAgNjEuMjA1NDEyXQ0KWyAgIDYxLjIxMTMyMF0gMSBsb2NrIGhl
bGQgYnkgc3BpZGV2X3Rlc3RfdGVsLzI1NjoNClsgICA2MS4yMTU4NDFdICAjMDogZmZmZjAwMDFh
MTIzZmIzMCAoJnNwaWRldi0+YnVmX2xvY2speysuKy59LXszOjN9LCBhdDogc3BpZGV2X3dyaXRl
KzB4NDQvMHgxM2MNClsgICA2MS4yMjQ0NjFdDQpbICAgNjEuMjI0NDYxXSBzdGFjayBiYWNrdHJh
Y2U6DQpbICAgNjEuMjI4ODA5XSBDUFU6IDMgVUlEOiAwIFBJRDogMjU2IENvbW06IHNwaWRldl90
ZXN0X3RlbCBOb3QgdGFpbnRlZCA2LjEyLjIzLXRlbGVjaGlwcysgIzU2DQpbICAgNjEuMjI4ODE1
XSBIYXJkd2FyZSBuYW1lOiBUZWxlY2hpcHMgVENDODA3MCBMUEQ0WDMyMiBNYWluIENvcmUgKERU
KQ0KWyAgIDYxLjIyODgxOV0gQ2FsbCB0cmFjZToNClsgICA2MS4yMjg4MjFdICBkdW1wX2JhY2t0
cmFjZSsweDljLzB4MTFjDQpbICAgNjEuMjI4ODI5XSAgc2hvd19zdGFjaysweDE4LzB4MjQNClsg
ICA2MS4yMjg4MzZdICBkdW1wX3N0YWNrX2x2bCsweGE0LzB4ZjQNClsgICA2MS4yMjg4NDJdICBk
dW1wX3N0YWNrKzB4MTgvMHgyNA0KWyAgIDYxLjIyODg0Nl0gIHByaW50X2NpcmN1bGFyX2J1Zy5p
c3JhLjArMHgzNjQvMHg0NGMNClsgICA2MS4yMjg4NTRdICBjaGVja19ub25jaXJjdWxhcisweDE4
NC8weDE5OA0KWyAgIDYxLjIyODg2MV0gIF9fbG9ja19hY3F1aXJlKzB4MTM5NC8weDFjYzgNClsg
ICA2MS4yMjg4NjZdICBsb2NrX2FjcXVpcmUrMHgxMWMvMHgzMjQNClsgICA2MS4yMjg4NzBdICBf
X211dGV4X2xvY2srMHhhNC8weGZjMA0KWyAgIDYxLjIyODg3N10gIG11dGV4X2xvY2tfbmVzdGVk
KzB4MjQvMHgzMA0KWyAgIDYxLjIyODg4M10gIHNwaWRldl9zeW5jKzB4MmMvMHg3MA0KWyAgIDYx
LjIyODg4OV0gIHNwaWRldl9zeW5jX3dyaXRlKzB4OWMvMHhjMA0KWyAgIDYxLjIyODg5NV0gIHNw
aWRldl93cml0ZSsweDEwNC8weDEzYw0KWyAgIDYxLjIyODkwMV0gIHZmc193cml0ZSsweGQ0LzB4
NWE0DQpbICAgNjEuMjI4OTA3XSAga3N5c193cml0ZSsweGUwLzB4ZjgNClsgICA2MS4yMjg5MTRd
ICBfX2FybTY0X3N5c193cml0ZSsweDFjLzB4MjgNClsgICA2MS4yMjg5MjBdICBpbnZva2Vfc3lz
Y2FsbCsweDQ0LzB4MTAwDQpbICAgNjEuMjI4OTI2XSAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9w
LjArMHg0MC8weGUwDQpbICAgNjEuMjI4OTMzXSAgZG9fZWwwX3N2YysweDFjLzB4MjgNClsgICA2
MS4yMjg5MzldICBlbDBfc3ZjKzB4NDgvMHgxMTQNClsgICA2MS4yMjg5NDNdICBlbDB0XzY0X3N5
bmNfaGFuZGxlcisweGMwLzB4YzQNClsgICA2MS4yMjg5NDldICBlbDB0XzY0X3N5bmMrMHgxOTAv
MHgxOTQ=

--_006_PU4P216MB11829B6BE6520C897F0DCE0EFF70APU4P216MB1182KORP_--
