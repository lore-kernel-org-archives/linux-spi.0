Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E38383985;
	Fri, 31 Jul 2026 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785482030; cv=fail; b=hqGZvwXC4f6appVJB5MCSY3Pa9QZKRAp1NIijk0UNScm2EB7He9InY4WTPR88+Q4cDDyH/XMtX1y2XmwC67FitjQrWNIjiwSgSlXa6Y7ozOSl2bw6ePMcWz9M8P5LpmM4J18P6AL1swNdgO2GcPeIu5eeZfjOTLtM2SJJQ0xrl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785482030; c=relaxed/simple;
	bh=X4GrhkwutbKOauo2K2aZU4gwGTnukVNyfUoLqHMDUJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bS4P7B0GuN0IOFGvHR1dh/3impaM0WLHUp2vU62dMBeuo82sPIdM+DBey+liAY8KeDw9zKiASeTdM4aEqpvFEU8GcYYQ9MS5z3PanC7I1ImO03OJjxQ+0Q/DjXOfulbiB8s+nxM5UqupbOfJrV2ZnMOSud3/UYbSAIbSAS4+MWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAO80/AL; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bAO80/AL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqqTVJUrsVVeoc114tEc17Ygtao5Oi3R58rL8doofapDTG0JlHIyp/odNlvZT4OtSutpLilR/eLOUlB5m+XcMc7s8Pdy/mvb6ex9/D64LUyD8ARq+BILaONfUOAWCEnGWAGKyaCM3Z9FGBlgGfN0AxO3AypacP5CS4vQRmLXz7SOlB7t9WAeDBfImUysOSXZLxX0QzYLc3kgw0rB3kdmwWSOEAxZP9mPK4QZEdhPMda5bIbxupC/NKbywZnssrUKSDpQ2bAKtOibAqL91XuQl7lXm8BNEgo94KUHqJGsMhq1hleMs4SHQ/87F/eUgZNUO3ltoGLiyumcXFPRPdlalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjjFdAB6xhdE8IITQ7chZEZlSpdjJRS/Pdy9BdImmHg=;
 b=ZnndzGF4I/4BcW9txeZhCvKOs/zwvkc5SkJhpJ5em2ZBkEjXiX/idpF/vpZHViR8Rar+YIzHkYP4r51RYK8ODD7VS7wfmHwXWHKbHpW0IVgKI5TgKsII6CLdt6hCShksMZ6w+n53z+z2jXkGU/tiKftJgC7zuQ0MHic6f5OENlHssix0vB1sRRhAcWASGy404EMCvA1ampSe9xH9dQ8GqedlpMzui+DuEapFeMRTyBhA3LeeUHT9whLUR0YPykdbBeg/wdn+aGha24H+YAuIyl53a7CcfRODza3E3k/Bh0MPFklbkzQBmMNCDrSypYAFqQLSX1vwztzFU58F50GZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjjFdAB6xhdE8IITQ7chZEZlSpdjJRS/Pdy9BdImmHg=;
 b=bAO80/AL/3Qen/hRUcXhgxH7ypBf2u/xTorbONBbiHF3DrLFa+96dTssEp/gC5H9dOEt6ntrq6vT6ZBbFJ2KG4AGg7j8zoZNVXrF8rKxZ9KyMxBKEiWnqpvQmH4+gHofXaKEpA8MGvK36KOmCYZJ0FVkT89sQcok6cbnR+fqlml0yLWCvYS3uOkHOZKrLsp+HIUQkO2GkQe6qkPYWKREJgogcYwOVxQQ5gsesgpMlk2uq6i8Xn86aR78+UohuouHGyVV5zL81ZPh6MODiXlDtHVh4hyH2mngzY8vtXIvD8RG9xwMef44kR7Jrd9xcEEMohZphWv4C79CHYixyKzKUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 07:13:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:13:44 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Abraham Zukor <abe@maticrobots.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-spi@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: tegra114: initialize native chip selects inactive
Date: Fri, 31 Jul 2026 16:13:31 +0900
Message-ID: <5pH8Hvm9Tn-0PY-swUeCwA@nvidia.com>
In-Reply-To: <20260731030134.4182688-1-abe@maticrobots.com>
References: <20260731030134.4182688-1-abe@maticrobots.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6d1723-f5fb-49ae-e747-08deeed341fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NGIUG2Pp/d6XR9dj/AjHeWl0dfa9JEg9NpWEDOI6/eF49PPrxvMlDwzflbyBhd5n/bgL5P50KFv0AqaIJGWKJsmHuDJlyqb+TLRZRqO3FeFUSAbN5ptvoKp52mdGRWZ5u2rGNCix+8hmZ935nYLnzKLIIwHjypVdiI7dHTlpnAg7kBeLB5h/+K5KTpnWpxvztA3qt4SP8IGJzTpvpVkXAPF+xCtvnAQ6WlLRTcead1zyCvVaa9ziOLijgr4csoF7XQSJGK4OljQZa6BgQ2o8VcL76kzHnTrbDDHrMRrsw894APzZgOTei359R9idJ0DyaJsrgEUaULDV8eENYFV8d37KtShW8v7/PrtXSGbZZ6a0cOM09ZgTJQNH5eUE9NO1GsYvDvrLOU01qEVv1q66KKkR5nF6VxyYIsVLc9N4XMb/ujsxyWE+/IuD47/ke/5rvoS+o9KhB+zaIqqB/zY3ULpIkh0TRVpny0zEdGJNgxd2K2kcMJ2jAqwfQ2WTkvIWWM+rzMQI7SH1GtEMF+A9jGPXOXU1RQ76hF0k7eM6r0WXDtQZUhdC7P7Lu+fsx5In8eRsjW6PFHaHbMBm495qQ2CuHmkDDQ+93eSvXLH/1r7MCqO37yFtifqfnwtRFxR75KOIr0FLO/62eShJ4xZCCmef6BHAF5YFFUpLnvnABqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnprM2czUjFGZEwvay80aUdCa3JEcG5qdk9nZGdDY1RyUkxNYmJ1YkJWTlFv?=
 =?utf-8?B?elRpWGMwazNJaVVISXhSTkhEQnFYcGR3bWw1NXhHWE1Xb3ZZZ3NRQmRDQkp2?=
 =?utf-8?B?d2FsL1ZUZXc4bXpBNi9rMkFJY1YrTGFXZjdyTFk0VzlGcHRXdXZ3dXdTQWhJ?=
 =?utf-8?B?ZmF0UkJxZDRJeEJFNG9DZEhOVERqRTRyViszRWRtUG16eklMSnNjZEl4SllB?=
 =?utf-8?B?WlAxYUdkNHkrZXFHRjF6eFIxZGNVWkcxYWZQL1I3ZUJPLzBNNDF3TkVVN0V0?=
 =?utf-8?B?SndnLzYxcXJ0aUd0NHBPa2JOMFcrd1ArMjFsRUVMNzVxOXRjZzUveE1SVUFv?=
 =?utf-8?B?QjFIVHJkRUZMTGJCZldaUERTNUxWOUVwemFnZ3l4RWZkeG92ZkpyelhaakFT?=
 =?utf-8?B?eSsrcWxBWjZSelZ0bHpsYUVFcFB5QXFaQ2U2Z05sK0hNZTB4L1ArTlNmd0lX?=
 =?utf-8?B?elJ1RVVhd0ZXSkhlUkZBajg0bE91NG9tYmJQUlYvSHpwSEE4K1F5VU9kc3NE?=
 =?utf-8?B?VVFBTm1JRHFqVWhJN3BnL2xjK1R2R3hLZGppc213TWtxbzNmZlBrMUs3c0JP?=
 =?utf-8?B?Zm5lQkZXOWFqckdRZHFNQ290TnMrdjJFQktMVC8zMjhPNW9qQVhBU0pNZFF2?=
 =?utf-8?B?d0NYZVJrc3NKcVJLOUJuYnJGN1hENTUvS0EwQTlHdmdzR0xUNnFBOFhBVGgz?=
 =?utf-8?B?c1NuN3p5MW1ZcXZVaTg1N2cvdnRDb3pDR3ZKalZpWk1UNHB1RzRZeTdzUlNw?=
 =?utf-8?B?a0N4NEMxQ1loaHBKemFmcmUxSTdFZHFsaklBbEd0V2t1VWVXZm43M3RxbUlz?=
 =?utf-8?B?aVVLYUdqRVV5dExKUFNiSUd5ZGZCbXplUlVPSlZhVFU5NEY5MXNZTWtndi9n?=
 =?utf-8?B?b2lWVmxteWRXK3JvYXZ3emhPUjl4Y1dwOGppbTRMdC9PWEZzZm1saDIwTE9S?=
 =?utf-8?B?NXpJeno5YXNiZ3R3NXE1ZmJxWm1zY3B2TXI4WEVJdTdIVVpuZGlyS2lwd3Zu?=
 =?utf-8?B?N1ZjSXVuRVJteFRScVZkY0l3ZERyd3FDRlVlb1JwcXpBL3VYeUY1dkZXdU1J?=
 =?utf-8?B?ZW01dnpkZ2tGWWRrOEhRZDAvVWNHdXUrVUN5UXRkbzEzWFhEaU1SVlZJVFRK?=
 =?utf-8?B?ODgyLzF0WkdkOWRrYUc2WlBneE1KekJSVnBRTTh4OEpFOXFTUldMaS9qMzZI?=
 =?utf-8?B?YjZ5UUgrTFpVWVorbG5sRFJiQll4bVd2YVpGWWwvaTdWT3FMODM4WU02ZVRR?=
 =?utf-8?B?RGJkTkVncXI2UU80RFNrVXNTOHA0d2xHSzNSSVBJNklkeUZOS2Q1MGlkZlJk?=
 =?utf-8?B?c0VzOXplUjVBNHJ0ZWVJSmFreXVDaDJYRHVvVU1mSGQ2RFNiVHNFKzdqdVNV?=
 =?utf-8?B?WXFsRVJ6RFpoSkNKcDBCWlBEOUVUWUtrZWU2WGsyMElhT0ZFVFI5ck85YzE3?=
 =?utf-8?B?ZEVYNGk0cFVTTldkdk1pVXZ3SG1HWGM3dmp6YVUwZ1B5clFPbmlxbGE1L1hh?=
 =?utf-8?B?L1FlcTYyQlloazVIYStKQUJuRWM3K1Faa1dETnpuaklDWDlKdklVV0RjZm80?=
 =?utf-8?B?YjlzZW1yYlZkcDkrWnVBSkpXMXAwVEJuYS9XR05pZDlVWVBrcUxkY25JSnNu?=
 =?utf-8?B?VzVGL2d0TE8vVW94alQxVENuYkNjeDFNMnB5ZkNDOU1oUEJ2a1JNOU9BUGwz?=
 =?utf-8?B?cHZROEhqUGlrQWNMcCsyakxXRE55Vmx2eEgyczdubWJpaXhKOEswTUY4VjJY?=
 =?utf-8?B?aDFBaERlbml1VDFWbERPYjJ6T1F4RDlNbmN1MkJRTEN5UndPcTdlMGlLS0JY?=
 =?utf-8?B?MVhodE55LytBOWRxSUx2VGtOT0dBVGJkVm80VnRSMUxHSUlOSU94bC9IQnB0?=
 =?utf-8?B?eC9vK3JEWllVcmNnZG1rUUEvSWVLZ2NIdmxTc1c0NW1DS0ZvbWVmQXMzSmR5?=
 =?utf-8?B?enlvTjhHbHJJMUNqU0ZTMm0yY2ZUZUxnZHdsZDA2Yk5JRlV0S1paT0RwRnJU?=
 =?utf-8?B?aFozNjB5U0paenNHRW1lOGlzLy9kVFBKK0V2MnFMdldJZkZ6UmFIQUlqSnNx?=
 =?utf-8?B?R2pmaDZQVXFPZ01ZMUlNN21LdTdzZWhicnpLNlE0ZXdyWUxwc2E4RVI1cFdz?=
 =?utf-8?B?dDZRRGg0TGVqeWR5RzBYdW5wQjEyZVNLcDZBVytvU1lFRW43eEw4WjhlY1h0?=
 =?utf-8?B?dng0UUk3R09HcFZxOHRsQ2RWZ3FYaGlvZE1jN2s4TUluQ3R6N2RyaUdrUWtR?=
 =?utf-8?B?VDZkcFkzOVNQdGtCSFZmMGZEbGhLd1paRHNoUUR3L2JnZkVoWGVhYXAyaHVY?=
 =?utf-8?B?SEV4VHFud3BJOGlzUmd5YTlpYTY5enAwQWZib01sSXUvMVB1bzArRWZjQWo5?=
 =?utf-8?Q?PLDHfse77lCMP431pjDLTPfWYgk9I6gXfD0HR/C5L8RHD?=
X-MS-Exchange-AntiSpam-MessageData-1: 6HNSjr8FNQrJAw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6d1723-f5fb-49ae-e747-08deeed341fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:13:44.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4wf5fldqW8MfqXKIBkdrP41RD3sN3yW9kwizqQygOk1MpxzikQCD34kRRlxYmoiO+q82WVU2TucrXqbMfM55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

On Friday, July 31, 2026 12:01=E2=80=AFPM Abraham Zukor wrote:
> tegra_spi_probe() initializes SPI_COMMAND1 with only SPI_M_S, leaving
> CS_POL_INACTIVE clear for every chip select. This drives every native
> active-low chip select low until tegra_spi_setup() runs for that device.
>=20
> SPI children are registered and probed one at a time. A synchronous
> probe of an earlier child can therefore transfer while a later child's
> chip select is still asserted. On a Tegra234 system with active-low
> devices on CS0 and CS1, this caused both devices to be selected when the
> CS1 device probed first. Its initialization then intermittently failed.
> A logic analyzer showed CS0 remained low throughout the CS1 transfer and
> went high only after the CS1 probe failed.
>=20
> Walk the controller's device tree children before SPI_COMMAND1 is
> written and set CS_POL_INACTIVE for each native chip select a child
> claims without spi-cs-high. That is the level tegra_spi_setup() programs
> for the same device later, so the line is already deasserted when the
> first child transfers and does not change level when setup runs.
>=20
> Disabled children are walked too. The core only registers available
> children, so tegra_spi_setup() never runs for a disabled one and probe
> is the only chance to park its chip select at the level its hardware
> needs.
>=20
> Every other bit keeps the zero the driver has always written. A chip
> select with no child in the device tree, one whose child asks for
> spi-cs-high, and one driven by a GPIO are all left as before.

> An
> active-low device on a chip select the device tree does not describe is
> therefore still asserted while a declared device probes, which is a
> pre-existing problem this does not address.

I don't think this is a problem, as the device tree is supposed to=20
describe the visible hardware.

>=20
> Fixes: f333a331adfa ("spi/tegra114: add spi driver")
> Assisted-by: Claude:Opus-5
> Signed-off-by: Abraham Zukor <abe@maticrobots.com>
> ---
> v2: derive the inactive level per chip select from the device tree rather
> than setting the whole CS_POL_INACTIVE field. A single constant is wrong
> for an active-high or a mixed-polarity bus, as Jon pointed out on v1.
>=20
> Tested on a Jetson Orin Nano carrier board with active-low devices on CS0
> and CS1, and with the CS1 node disabled to confirm its chip select is
> still parked inactive.
>=20
> v1: https://lore.kernel.org/r/20260725042944.1204409-1-abe@maticrobots.co=
m/
>=20
>  drivers/spi/spi-tegra114.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index aa44ffd09e61..d82b88c4fa9b 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -1395,6 +1395,31 @@ static int tegra_spi_probe(struct platform_device =
*pdev)
>  	udelay(2);
>  	reset_control_deassert(tspi->rst);
>  	tspi->def_command1_reg  =3D SPI_M_S;
> +
> +	/*
> +	 * SPI_COMMAND1 is written before any child is registered, so a chip
> +	 * select with CS_POL_INACTIVE clear stays asserted until
> +	 * tegra_spi_setup() runs for that device. Program the level the
> +	 * device tree asks for up front instead.
> +	 *
> +	 * Disabled children are included deliberately. The core never
> +	 * registers them, so this is the only chance to park their chip
> +	 * select at the level their hardware needs.
> +	 */
> +	for_each_child_of_node_scoped(pdev->dev.of_node, np) {
> +		u32 cs;
> +
> +		/* Only an active-low native chip select needs its bit set. */
> +		if (of_property_read_bool(np, "spi-cs-high") ||
> +		    of_property_read_u32(np, "reg", &cs) ||
> +		    cs >=3D MAX_CHIP_SELECT ||
> +		    !of_parse_phandle_with_args(pdev->dev.of_node, "cs-gpios",
> +						"#gpio-cells", cs, NULL))
> +			continue;
> +
> +		tspi->def_command1_reg |=3D SPI_CS_POL_INACTIVE(cs);
> +	}

Why do we need to consider cs-gpios? If a device has a cs-gpio, whatever=20
we program here wouldn't reach the device. The if condition is also very=20
difficult to read -- please use multiple if statements and normal error=20
handling patterns.

Thanks
Mikko

> +
>  	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
>  	tspi->spi_cs_timing1 =3D tegra_spi_readl(tspi, SPI_CS_TIMING1);
>  	tspi->spi_cs_timing2 =3D tegra_spi_readl(tspi, SPI_CS_TIMING2);
> --=20
> 2.54.0
>=20
>=20




