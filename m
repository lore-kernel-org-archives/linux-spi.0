Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022110.outbound.protection.outlook.com [52.101.126.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2815A86D;
	Fri, 22 May 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464928; cv=fail; b=KNdsrc6waEDowOLCFkaVJt8Ow15Iajjihlqq5KdZMqhBSC7Ghg1Gui2o5MtqCVpXASu3MHNgR0K2UMo+8xyLWMv3Nd4qfbcXXxU/oclI+C8Ujrc3SLhHEU9EXyTcrXj/cF4McddQaEWRXN3N+gupPqOjjXfyMA4t0zQiVV8TZ9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464928; c=relaxed/simple;
	bh=9n70oWzTvg3S+jvmEMrbGpNqlDIdzdwjuovZWn4u1j8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I94G9+41ZRoRbIaMqPlSdHV6w+8SeZvS2wu0z9cUqRQi6mFnZW+LW4/KneqHafgzWuwhK7O3N/8TvP3v6ilkZrLdUrs5eNJd4CW7nufBrQpuWZ5UJ4Owen8Ya+2vkSL+oIxNQat/3cy1WwcoIBvFAQtP3+Hq1gxbDbsdD9vAhoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=A9MkLbd3; arc=fail smtp.client-ip=52.101.126.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="A9MkLbd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRDdmCx7R37N+pZE/JuWijRunM2IrYoBaqIppifJUyxRijxFpc6hHAKzUGXaeXqUOEgvXs11pirdCxi6upx8llN8XU9POVVOLoa/NoFGTNMCqWzxow6G1rTdTEXClVrlo8ay8kzUwq/voRcHD4i38YJXPAR9sZMiK+v7HyRZrnigpz/2jV2DNnZHLtlZ9r7qIR1D8C2OS73bB1PIKtkQgqCe8FCwklttlTPGr8fsN1vArKyA254b0pqpQ/LacGOABFxsU+SlUvxHoLrRGEU5QBBoO5Fyf/C+uW79h/zs5TEaR8vD83SGHghdKQ/MGk2buYjIF/DdcZ4aL084t2AyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n70oWzTvg3S+jvmEMrbGpNqlDIdzdwjuovZWn4u1j8=;
 b=GGVcwKta3I+ApOPvuQcA4dZ4+KWBvc1oVhX1NsWCugDosMmtNy179wVbehPIWoQ+NpfWH0APi8XrlvfljjBVwrprdNco5qr7IrcK+iXkXYlQuMJg/kTtsGhjKgxD2nQ2byAE3bAowTjius3Gn1iyOhhNXin6DvZTUii1bQDIRWdGQEHPtA8n9aYEkTRrJK1ntCMWd2p5mJMBHyIzD+pB2RFwMBLM250zvh9yzdiaktKyqg8rS2AiGZ8IwZlBZ24D+Ffj3cjnIgWRPIaU3BkbaKui0IpZ/+Jr1Ev/IuiORe2X1jlKKpC3Yk3+HcsCOuKZrFXrjAh3UbdVABt0OAyt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n70oWzTvg3S+jvmEMrbGpNqlDIdzdwjuovZWn4u1j8=;
 b=A9MkLbd3aLMObKDvpO4/nj6WP4hQOTpwKSGmP/WrbMi0GSLkZCmIr/ifBlin0VYjS/WviP7D06RXvZdGdjGAXO3JhHVS4kIRl3D0/ZBx/+0s63zb9uPwxnn8xvq4settBv4/aogwkuM2udmi2QdxW5Ok+l8NLrQMXQWO6XHQcgM/vA4JYYaMAblsSw2ctDmHtl/2NO6IwGFpAS+6PsYMuUBHU+5l4t57ooZQErDSOr4SU9RvOGenPuLhMJwHXMBU7ZVjsYBRgak2TtjQeddb+ULk6qddEFdPI3OKZOpJJ9JijICTSzS4bLsN19lrbAIMNfdp0f4TgqceEMIy2eyCNA==
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9)
 by SEZPR06MB7077.apcprd06.prod.outlook.com (2603:1096:101:1f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 15:48:42 +0000
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::e25a:ec7b:633d:7489]) by TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::e25a:ec7b:633d:7489%3]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 15:48:42 +0000
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: David Laight <david.laight.linux@gmail.com>
CC: "clg@kaod.org" <clg@kaod.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>, kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat
 pointer in calibration helper
Thread-Topic: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat
 pointer in calibration helper
Thread-Index: AQHc6brpYFW37WKeUEyzbCcAit0oebYZs+SAgAB8Z5A=
Date: Fri, 22 May 2026 15:48:41 +0000
Message-ID:
 <TYZPR06MB5203714C130A2794585272A7B20F2@TYZPR06MB5203.apcprd06.prod.outlook.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
	<20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
 <20260522091915.65dde4ad@pumpkin>
In-Reply-To: <20260522091915.65dde4ad@pumpkin>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5203:EE_|SEZPR06MB7077:EE_
x-ms-office365-filtering-correlation-id: 786862b3-0b00-40c8-6394-08deb8199981
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|38070700021|56012099003|4143699003;
x-microsoft-antispam-message-info:
 uLvtKNHoE3jwv8VEEWI/iy8riUuoVR7jDNji2zagD7ABX9iBc+/ei7g5ONY4oHqOdnDwq0aCpS0z+uRACGiWnX9wWgX7xMolk/WWVlbgF12Yl7fcykBcFRZwiNRYQf034M7X+zxWVutLMpCmzVPrlFl21FJfQfG2VSApng46OLzYhESweMvf3orFiBWThW1dxXUVTsOK4sdyZ2n5MsUtRYc/sxS5ZBKfZ9l+YOSes9QbU9y5W6BL6qKJFdbRM627+sHJq+oP3nwSnYQeEPKaW6pRb9nSV4gzzkF3/8ZggTS96vWPOw+22DrVC2QoomraTDZN0U9q1Sh1jDS+japrTsbIHy56j1+22gZJinTbP7+RI4yaitBPBUTuWgbcv1Jt6eK7zzrIbZhDheGUT4YDcp4WQmTGwCjcIy2UWPhlAzDnxj4CLIdPhZgso/TcX4bfcVrcDiCSQmCzz2E2cwKCa10hFyum3dRBJnRomggHA0TiVIdxNz2FlPgQ9Q91gl2M/k3/aA0nmwtzcfljbVeOEIniW2RYQLU7tQMbaOh4eQvZ03W3cgSkw+ykLRCzRUGXtif32hBAEZbmgE0Gvgs93Eq3/bo5kGbKoo+0DM233tIDmUxHsVLaDSMpBpkBnaKVjSDAyLj+Ci7cKyiCfwiR2JpV0x+Ev3smBc+5SIWt9JrowqvP5aAeTUyODvdKiQ5kDf5DR/UZBunKOCI3fF+Jjo4Oyr1HGAhmZ8GGkRisTu5e3X0zXAhBvXtoCbGnnR5r
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5203.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enlOYy9XeWhHZkU4QnE3bnBHT2IwQmxRTW8xajJQdHhlOUVObzFFV3Z5SVRv?=
 =?utf-8?B?QUJmWlVGcjNwUGJjM1UySy9GYVN2YXo4MjlwRS9LWDJENVpSTHlKRnZ1MUJi?=
 =?utf-8?B?QlU0Sk00TjRtMUpUR0IxeE9kTnYweXhtR2FFcjJsSFQxOC9XellONkw0bkZp?=
 =?utf-8?B?REI0Smtrcmx0RlArNm12Y3V4eCtORkdEeGhKMDBPZ1NGbGNaeVhqU2NpeG1n?=
 =?utf-8?B?b2xlMUZxRUNldFRIWm5vNWd5WjVwR1NMM3liV1FXYUpZZ0lpUk02MkpEVWEr?=
 =?utf-8?B?VHNjMmYzZTBFNkpQekZTR2Q4QWxBaVN1MzRQRS9YV0hUQ2ZPUW82SmdId3Nl?=
 =?utf-8?B?RXRHZUo5NFRiWGdaUUplWUNpWWc3UVZsSkZ2ZVFJL1ZJQU1CbTJSUTNhRXQ1?=
 =?utf-8?B?dXU3d3JmUU9zRGhLUUFXUjNvQU9ma1FuYktPSkVKQkhXdm90Y2t5Wkd4eUlZ?=
 =?utf-8?B?bDdUVHVhVmpPQVRqS0pWLzRoTzNkd2swNnRkdGhadmlhQ0VrQ092WWxwbjVi?=
 =?utf-8?B?UHltZkQyL0FCZ0NEUGQ2UUFMMjRMM2J4c0ttTDlPVjdQcUh1YXFoY2ZXNjha?=
 =?utf-8?B?YVF6cnhKZ3NkSXFIMGhiTUtqcjQ5c1ZhMTk2MWpUaURhZVgzajM3d1dKdWww?=
 =?utf-8?B?SEdzRUhzdUpJaUI0ckM2eHNpVjhHdnBGdjRNMGgrVm0reXcrcVByZWhBaWZs?=
 =?utf-8?B?bVJKNk5yMnFnckZtWkRPbndaRC8xdXZYQnB5Z2VZMWJaQS9sRHpLUUdWOHFM?=
 =?utf-8?B?NjdvcU1kcGt4dXFOZTBMY2R3K0NQa2pZeUlhTWVZLzFQUG4yUXdIbE4wSnVF?=
 =?utf-8?B?aDdGSzhENDF6NDQ5NUN4UU9LaU4yWTJvaU9SdmNnMUdzSWphVGhPUDZNYm5W?=
 =?utf-8?B?MllTamYvejFoQjNXMTJVRDdHcmliSG9iQ01ESG9iSGlzTytoZXQ0b1dJS25t?=
 =?utf-8?B?b1FHS25CSnZ6RVFoKzZTTFBKZ1FBREZiL3BSclZLK0NnN0RFYU1saGhEWTRS?=
 =?utf-8?B?S2c3WTNUS0JCWmJvUWN3bVRFSGFhS0JGUU9mZkpWNSswbEJOVmIvRFEwY3FH?=
 =?utf-8?B?MjB3aWQ3RWRha0JNVE51aHJMT2duZ1dzb21oNnN0eFhTVmxwL1pLV1FrM2k5?=
 =?utf-8?B?eU56S0c0Y0JuZndBR2UrTXRpZjBTNkdIVE9tNVBLZll1RG4weGM5MXNVMlJQ?=
 =?utf-8?B?N2Jkb0k3YWVmWGUxYXI3dHM0Rm8rdGptNTJTQmxHN0Ftb2U0MHlrdmhYaXpa?=
 =?utf-8?B?bWZKWGpYVWdiR1BuS1BpUFMwcTBhaG94ZFZWN3BmRDlyZndPWWdaeGZHaVEr?=
 =?utf-8?B?N3NXdnRkSnc1Z043WGgrSFJpaXZRUjdYRzJNY3N4TWJBOCtGQ2xYekVQMWN3?=
 =?utf-8?B?eEVsUGEwYm44Wk5DWk5JS3Y5eHZ4VUJZZVZOUTdNZXgxSGhxRmVleHhTZkRG?=
 =?utf-8?B?dGU3L1VlWnpGWDlWbkpyOVBxeWtSMnA2YXdLZlFTeEQ3Ri91MDBnaWNON2dW?=
 =?utf-8?B?dThDVGgwaHJDK0dlb1VZYkdRS3NXcnhPdHl1N1FKdGIrM0hHTXJIN01IQXVI?=
 =?utf-8?B?dW5WQVpMRnFCcDkrUjhxR2RCbVlueEt4K1FBUzBUSWhJUFVMUVV3cC9qMkd5?=
 =?utf-8?B?VDhsOFJsaTJSR3QzK1hBVDdaUVJXamM5NHdjbWpKUkVvMTRBL3h1WGdmNU8x?=
 =?utf-8?B?VjdkWk1XY2xkNHRjcWFrMnZ6S084Vkx5T3lrbm52eEdaVU1tT3EvdVdpdm5v?=
 =?utf-8?B?dVAzdTRtS0YzSnBwUXJGUXhLMEVYckdrM1ROWFp1ZUVubzNDQ1FyMVJWSjA0?=
 =?utf-8?B?b2M0anJVNVdYRzVmV2g2TXl3ejFrMk1FcTRsdVVobENSQlY2dkdrZEFoZDlm?=
 =?utf-8?B?RG5CSE5FWGk1dXF5MHlRZlpFNVQvcHl0dXd1QUF2WUZNb2o0NWhvR1l6NXd0?=
 =?utf-8?B?WDFXbHhIYWNHVU9uNTkxaE1uWDR3RGxBTnFGWGF5QWp2R0w4V1k3UjhadGxH?=
 =?utf-8?B?dm9hdS80WXJtUTRLdjIweXRKQjlINGkyMG5kRzdjWE10Z3pjWklJREJYdy9N?=
 =?utf-8?B?b1V0Qk1BVjRudDJkSjF0Rk9pcmVLMkpsZmwyVERXTVJaQ3ZYN2k3NDdiZnBs?=
 =?utf-8?B?blBaK1Y1WkxXeDdTYnBBT2N2aFFoOEw4c1c5UWJLNGVIenI0Sk5PSFA3M0lX?=
 =?utf-8?B?VndaUkIvOWJWS3YyYWpMb2lOL2RIZVdRQ010UlFlSVB4UUVmMlJnbDZYRmVk?=
 =?utf-8?B?WTFwN2JEY0tqMXRENmI0djJGMkVKNzNOWjlWenlUalFQNmQ5bW02RkN4NU1x?=
 =?utf-8?B?bWYzMHAvZjlLUWFLNmZxbmpFRVBNYm5ET2RFVldDR3dsTDhTd0FncVcxbHc0?=
 =?utf-8?Q?tI/CLKzDh2r87Sgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j+dYUHtVfTQWNaKRqIdGqdB4H63DpYDe5O/JOQkKhdC4wdWCs1enjVcwkP8ZyMJ2RsnUlxFK17QjAz+BR0uOi8UxLnu+eI5ytTUyFaisC6/8QQhvUFTN/aWdzgAutYQeQXax6lnr3/JAcUeIhY1m2hUbglKka8Z4WAc64JT1VCmlTGk0YMsTYjmZdoaEmaiPNttEp9IurCfGh89eamZWILHR32v+KDtfuAVLLxt1r+KealyDHhK6ZB2JEtgj0e0iJsL18uszThPu7G7v5Aw8Dj3gQ4mRMdJMALeNCsZDcVU6i3GWpRxrjATTRPsH9jFSyFZhzlte1b4odVhZo/Qrjw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5203.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786862b3-0b00-40c8-6394-08deb8199981
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 15:48:42.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 772++hfCaEaiNOWSGIkZZfQCYl81XvX7GwaRPOdZ8LgV6HbhKmsCZriiA0z+xm3WV7QH8VDl5o35UB/o3IkrZuzu2vXAkDzyYzt4I73Jqts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7077

SGkgRGF2aWQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQg
TGFpZ2h0IDxkYXZpZC5sYWlnaHQubGludXhAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1h
eSAyMiwgMjAyNiA0OjE5IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBzcGk6IGFz
cGVlZDogUmVwbGFjZSBWTEEgcGFyYW1ldGVyIHdpdGggZmxhdA0KPiBwb2ludGVyIGluIGNhbGli
cmF0aW9uIGhlbHBlcg0KPiANCj4gT24gRnJpLCAyMiBNYXkgMjAyNiAxNToxNjoyMSArMDgwMA0K
PiBDaGluLVRpbmcgS3VvIDxjaGluLXRpbmdfa3VvQGFzcGVlZHRlY2guY29tPiB3cm90ZToNCj4g
DQo+ID4gYXNwZWVkX3NwaV9hc3QyNjAwX29wdGltaXplZF90aW1pbmcoKSBkZWNsYXJlZCBpdHMg
YnVmZmVyIGFyZ3VtZW50IGFzDQo+ID4gYSB2YXJpYWJsZS1sZW5ndGggYXJyYXkgcGFyYW1ldGVy
ICh1OCBidWZbcm93c11bY29sc10pLCB3aGljaCBjYXVzZXMgYQ0KPiA+IHNwYXJzZSB3YXJuaW5n
LiBSZXBsYWNlIHRoZSBWTEEgcGFyYW1ldGVyIHdpdGggYSBwbGFpbiB1OCAqIGFuZA0KPiA+IGNv
bXB1dGUgdGhlIDItRCBpbmRleCBtYW51YWxseS4gVGhlIGNvcnJlc3BvbmRpbmcgY2FsbCBzaXRl
IGlzIGFsc28gdXBkYXRlZC4NCj4gDQo+IFRoaXMgY29kZSBpcyBhbGwgYSBiaXQgaG9ycmlkLg0K
PiBUaGUgNiBhbmQgMTcgKHdoaWNoIGFyZSBhbHNvIHVzZWQgaW4gdGhlIGFycmF5IGRlY2xhcmF0
aW9uKSBoYXZlIHRvIG1hdGNoIHRoZQ0KPiBUSU1JTkdfREVMQVlfSENZQ0xFX01BWCBhbmQgVElN
SU5HX0RFTEFZX0lOUFVUX01BWCB2YWx1ZXMgdXNlZA0KPiBmb3IgdGhlIGxvb3BzLg0KPiANCg0K
VGhlIG1hZ2ljIG51bWJlcnMgNiBhbmQgMTcgY2FuIGJlIGRlcml2ZWQgZnJvbQ0KVElNSU5HX0RF
TEFZX0hDWUNMRV9NQVggYW5kIFRJTUlOR19ERUxBWV9JTlBVVF9NQVguIEhvd2V2ZXIsIHRoaXMg
aXMNCmEgcHJlLWV4aXN0aW5nIGlzc3VlIHVucmVsYXRlZCB0byB0aGUgY3VycmVudCBwYXRjaC4g
V2lsbCBhZGRyZXNzIGl0IGluIGEgc2VwYXJhdGUNCmNsZWFudXAgcGF0Y2ggc2VyaWVzIGluIHRo
ZSBmdXR1cmUuDQoNCj4gSW4gYW55IGNhc2UgdGhlIGNvZGUgd291bGQgYmUgbW9yZSBvYnZpb3Vz
IGlmIHRoZSAncnVuIGxlbmd0aCcgb2YgdGVzdCBwYXNzZXMNCj4gd2FzIGNvdW50ZWQgZHVyaW5n
IHRoZSBpbml0aWFsIGxvb3AuDQo+IExvb2tzIGxpa2UgaXQgd2FudHMgYXQgbGVhc3QgNCBvbmVz
LCBhZnRlciB5b3UndmUgZ290IHRoYXQgbWFueSAoYW5kIGEgZmFpbCkgdGhlcmUNCj4gaXMgbGl0
dGxlIHBvaW50IGNvbnRpbnVpbmcgdGhlIGRlbGF5IGxvb3AgZm9yIHRoYXQgaGN5Y2xlLg0KPg0K
DQpUaGUgaW50ZW50IGlzIHRvIGZpbmQgdGhlIGNlbnRlciBvZiB0aGUgbG9uZ2VzdCBjb25zZWN1
dGl2ZSBwYXNzIHdpbmRvdyBhY3Jvc3MNCmFsbCBoY3ljbGUvZGVsYXkgY29tYmluYXRpb25zLCBu
b3QganVzdCB0aGUgZmlyc3Qgd2luZG93IHdpdGggNCBwYXNzZXMuDQpUaGUgdGhyZXNob2xkIG9m
IDQgaXMgdGhlIG1pbmltdW0gdG9sZXJhYmxlIHdpbmRvdyBzaXplIGRlcml2ZWQgZnJvbQ0KZW1w
aXJpY2FsIHJlc3VsdHMsIG5vdCBhbiBlYXJseSBleGl0IGhpbnQuIEJlc2lkZXMsIHJlY29yZGlu
ZyBhbGwgcmVzdWx0cyBpbg0KYSAyLUQgYXJyYXkgYWxzbyBrZWVwcyB0aGUgZGF0YSBjb2xsZWN0
aW9uIGFuZCB0aGUgYW5hbHlzaXMgY2xlYW5seSBzZXBhcmF0ZWQsDQp3aGljaCBtYWtlcyB0aGUg
Y2FsaWJyYXRpb24gbG9naWMgZWFzaWVyIHRvIGZvbGxvdyBhbmQgdGVzdCBpbmRlcGVuZGVudGx5
Lg0KDQoNCkNoaW4tVGluZw0K
