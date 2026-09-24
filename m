Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2114.outbound.protection.partner.outlook.cn [139.219.17.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944A3D0938;
	Thu, 24 Sep 2026 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216062; cv=fail; b=Ulo/9svhGlXKKLwIHA7fxkKT1ZItgzG5hnVPQsjLu44dI9+4prYaa7yULKM2ensnowmAq1UZ/ukhUKveyKtNysngiLdMzVbYaqLvuRSDg58gBigC70g8tXT5o3L54lnCWdvqlRX2NrN9gUdl0q8rvxK176B3U7HmqjcvZGFCx2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216062; c=relaxed/simple;
	bh=Ia3CYyAdZZW3piAHlJTRZasCVfkhQlIGSwi/Cijq9dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRYQNpEmQ+351qsAub5FkFzXa4peFJ+KD5PQkcNxvTbqh90M7gOGr0oaWTtxxrHKwFC85z24pJStJ1yFx1bjWDESJwcn1vTNe85CIaux2U53nKoo/Fhfnk/9YJBs4pncfmvOCdTuueqF5JTX8B5RcayqHmok/usBtdHRqlH36f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsBntQxYTNNyPH2X6YcuD2gQTzKu4OxbCxrSPlHR0x3MzJ4PSJvy9Vt+ZRChCorRXmDTGkA/BOT8NQ9QndFpgZKxM5KOIZqxYKwgBZsC2IPoeYF0uH8QUbW6y8thqV+ko2to4BDkynRO8dFqMWsa0cx2UCSrLorujwknZnDT6/XOf5GGGRJVsEb3vBiuyZYOdX3G8pEStg0Hc6QEKEFA6pp1ITGiUcDC65cGL01leyJkM22XoAe9AVlbdf9+OEPVquRErwoMZ6VeieasB+z6sbdCeS0tROc/6knr4zgBTdJS4LPr3oR/1srtDLhee9sumaud6oU4dcTy3nsBvNGKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDdNm46XKjIn/W7AgPkR9aFsJXB8LJvc0qOBjWxnzTM=;
 b=G7NJp8YnNfm8laEI8lbINYfqcAXaEi1snGLwl4cbVZJf5Z/4cyPUfK6NNUzVVHdC+ateehqMGcHkuedkEoXthoVGRHsQ78E8uF2MLIPjsGEqKzKDaISwCm0Nsp+shZJk1HzlRzv9MfbCLc+yhb8PTKfKLAeoegoL2xS58MSnprnVfHT5+ZSliYj1YkAZ1rELEFuDTm09Y9xqWDPvCAtlKU1dJg/Qzw69P+iRJcvYcKlFVTPpD/cgmONdMGYA163ad81n82pxLEnJX80eeI7fxS7JYcOuBbPtWSRrxLJF7eRAmLb5RqbD6lRpWyW8I8D2T9rKbDbjcNHaIhlidxHnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9) by NT0PR01MB1165.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 02:14:18 +0000
Received: from NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 ([fe80::1666:48e8:19e9:ad29]) by
 NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn ([fe80::1666:48e8:19e9:ad29%4])
 with mapi id 15.21.0451.014; Thu, 24 Sep 2026 02:14:18 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: jszhang@kernel.org
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v3 3/5] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
Date: Wed, 23 Sep 2026 19:14:09 -0700
Message-Id: <20260924021409.4207-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909143652.9234-4-jszhang@kernel.org>
References: <20260909143652.9234-4-jszhang@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::21) To NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1216:EE_|NT0PR01MB1165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fcf5158-c3cd-48e6-e681-08df19e189e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	zqNDcZBHyPgTDwP8RE5zdQFO+rdyChUHIh5uQ7rt+2kasc8FmKsrwdGT22n6jOs6ibRibSHdAoW2nahWArdDR9I+BeZfgjmhj9YuYy7i5Qr7/Kg2hxx1orKG1ZFgWgbsjFrGDgwXfeGEGY5EcfC3elhvdbKoh7HcWu2LN9b/mf6DdQSOm59T45fIs7ys4uBSMko+56o5uPL1D7GIqRJnS7u0EHgqrkHMW4mDczIS56JjNc63ihAzzB4oTB1Ees6CauA11qvQgWZ6TxcPKSOxLCGX88FigAFc7CBVLSu+6qv55W+Kvsj8PzGSicPE/+UI60Wac+bd+cx/5rRMMEI17cXUk1Ox0fj21d+kbtZetVpmrABI8CvGERR/DwQsb4/Vu+XJEqZ5XZ89Zq2at/D1ujuX6gz9VH0CsDtg+e7StI/UI1JHSqZoTq8kdKtHhiO+SYwBv5EqqYdgvz7jR9BQNBCHVPAXMqSiAoy8OWY59qy8dGxCMs078tt/L9DxP3dO2786Sa/nN8eY1ipfqwOl7F/md+tOUby5dwdTWyXLXTushDAKlowmPmhf83vc8ucB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qaue5dOsOGbse0R+ae2C5Z4UilFx1M5AM48BcnYnHU4YTB04r29o7U7g/JDJ?=
 =?us-ascii?Q?TK1b0Shnrv09FVb3bvqbq+zVdjC0ix/izXg4H8aS+z8rOBUKIQg9/l1dX5JH?=
 =?us-ascii?Q?jHFtQlMXWBFz8C2IqExRRYvutJiSVjeNce4WzmdELGvnJ8BKNOsd02hQth30?=
 =?us-ascii?Q?nKGZ9DRjjeAFshYQMxhQSJTV+s+KTyXI1QID78QFw09lNVYyKoVr6ZxdWfjS?=
 =?us-ascii?Q?F8d1jjEsYrwpQkf3tdngp5LpH5XCrc8IL06yyLD3mNRvgjbwWEr9MdftLDI0?=
 =?us-ascii?Q?eesQwnaseAPBamynmSjYNUeH3kLAaVh9FfT0MeRGvyVWvtqvwXePxpqpVSgy?=
 =?us-ascii?Q?5ApYybYAfKfhWXhQd2+rUfp67lHMEGeX8/5Mg90Dt6kPiNKDSS/wqOeKT09U?=
 =?us-ascii?Q?1wiGjnjIysDIl9pVlTZ4S/4Af3Gwhh6N0EIzZtcdmAlFLzdODLE2ikU3l0pu?=
 =?us-ascii?Q?pwZMrAq5dTo4HjmbCZQOxK8Vv7B0rMdeu4RsdVrJkaBpaSDpnhkuh1qcql5p?=
 =?us-ascii?Q?7hzBqw/ZsHMpGPwtCgFT0CYK8fKD20pVDfcrgzwoSnarjWq4I7q3Jby4dnuJ?=
 =?us-ascii?Q?2Rpm0JwhauNJe5NKibE6Io90WzG45e+r+H/VKOnJs6zUbB9YCSO4YzofeklB?=
 =?us-ascii?Q?h+mBoDrA0JOrKskpwa/8fDehB3rXELOxvrYxaOHsQ+8Wyrz97LHoPe7f/cC0?=
 =?us-ascii?Q?SVVAxIOkYnnNEM7C6RT4KRQUPBce8tOILOvx4afE0f8Yz5M/MjlVwZoD7KIT?=
 =?us-ascii?Q?mfvCgLacE0UiVeNXsGyX2J8wxWiJ35NyC/2voF32giUDXHfAQtt63U65Gd8S?=
 =?us-ascii?Q?X4KXqnw1+gl8lf2ZqwUmA4lAmjepdaKpFQil5Wq2E8q1Qz9q5q3ypuZT4sta?=
 =?us-ascii?Q?wyiekVkGAUhpoS5mVLoTsIedMN5xTy6bLy7DSU5fidf4wONoxhjJGYZkrDaQ?=
 =?us-ascii?Q?oeWmeM30gneoDFuJnv5KCTdjYtihxnYFfBUMfr6up9yPiMDUN2lQOUYBgdV8?=
 =?us-ascii?Q?FjO1SdUY4/DwE+lTkzIFOk4bROMr/8WnFDo/uBxZZsggWNDlTgYAGNFCKIhr?=
 =?us-ascii?Q?aZoEG6mfTSrTEmuve3fVCnYlw89osTaSd+dsKENLj3VaLtGsI27pDGbeXd5b?=
 =?us-ascii?Q?Dp7ErpRqNgzXbzIJYklXcRKJw2q/oFF/hZ6AwrIKgb/BkJOEdiGPcs7OUfnQ?=
 =?us-ascii?Q?ZgLsvlswnOKPiQoCpnZY1yU4GtlELpyeKU37e4nbd3jIr+63IBj0aqQgpvsV?=
 =?us-ascii?Q?dzTRqU4kHKTymoPSQq57DOkNuI2f3MztrRA/vXisRmGnsdE9xotfmTJXK2ky?=
 =?us-ascii?Q?jaSxnjTYiyKBWKlmoU+nlcfivXXL3zLhj/UBTmjWGT4UtrFsJ5G/+o/38/ms?=
 =?us-ascii?Q?q1VYC0RiDg1D47c80WaHM9iRgxYlx/l6ympa7ShQyG5fFhTMzkHNHiXFklZK?=
 =?us-ascii?Q?Py93BxsSqShBZqQ7b0Cda5Bbp8jPJB3rAsVbBCLABbJBW/Gwo2cTUtc/WNaH?=
 =?us-ascii?Q?ZGe2lqbaSftFDxl5TmmKB3JGf0fWkDpecUhmyO/HM/zdQvLG+U1uy5COgwPq?=
 =?us-ascii?Q?jSqskGxFJcHIBRfvzeJaKG92dBW+9mh2gFfo5VSvaapAVs3U5VoGpycos7t5?=
 =?us-ascii?Q?5BSPuN3Ly/ZQxQslbEX38MWjZ8YscJ2G8Mq80bdeMnlIhYBgglYY1Tc3r4Dq?=
 =?us-ascii?Q?NQ1AELWoTDz+ca4Xuj5U5VjHhqeJSGl4S+gj8jn3KEHJPDyA2kTf9skO8Kpt?=
 =?us-ascii?Q?PvUAwpKKBAWMQRIlQJguT/lxp2gZy8xm+z2by1DkyfP32ICC0eKx?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcf5158-c3cd-48e6-e681-08df19e189e6
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1216.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 02:14:18.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlR0XsTViraaGid0gvt4Qr/IOYJYtz6rdautP2KCkGw8x9CD05R99xv6kSdQuAcaJjI1rfZDQCNq10f2zpyqHAXTu/h4CPm/VxDDuDFMhXE5GoM+kDoGYqOE8LM+8A61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1165

> dw_spi_irq() need not handle enhanced-transfer's "!rx_len && !tx_len"
> case as that state is already handled by dw_spi_enh_handler()
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

> ---
>  drivers/spi/spi-dw-core.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index f4c4e9dae25e..91de357f97f3 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -284,12 +284,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  		dw_spi_mask_intr(dws, 0xff);
>  		return IRQ_HANDLED;
>  	}
> -	if (dws->transfer_handler == dw_spi_enh_handler &&
> -	    !dws->rx_len && !dws->tx_len) {
> -		dw_spi_mask_intr(dws, 0xff);
> -		spi_finalize_current_transfer(ctlr);
> -		return IRQ_HANDLED;
> -	}
>
>  	return dws->transfer_handler(dws);
>  }
