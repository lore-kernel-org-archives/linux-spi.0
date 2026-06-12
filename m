Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45C36B043;
	Fri, 12 Jun 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274812; cv=fail; b=NCTDIiHKB37CdWuuf3YPgucapfYgTi8Zjwodl2fkfEep+4UKMENdav0vQx2k6TsXyoIdcvm302oCduuJnpboJ4lLcmtK4rfsEaWJJgrYDdlEbrP73JFnU96+BUVbySEPxE5+xbHa+ABs1QIYNtgUhceN9psLoPRJDCtYW87xTC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274812; c=relaxed/simple;
	bh=fLie5pEZB21YpdkaLiUUtj+J30qtOGCjz0OoP7vfxo4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TNoRW0xAE5qNgKurhBH+8qqoevCqEzJEusZ5bW04tDS/PDere1L2jdhQOefieF+YJqdIsJQLGQaY70Z32XytuLsjlFCUddYYwVsuR0FCDAdldZ+j7e0Az2z717yxzn71n4SBI8GzIbdD3GC0G37sMgbjpOt4y5BWOcuhxqRoEYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rsi1lanv6DGhZJyBoPJgR80mokyiO1U/l0CUMmbQ6aCi5vvlB6C9NSBdX/nqOPRbiqH1mOnIRfLUqbX4zPQ/fTEjSwpk+qIbmFB3oSIo50C60xskNEuUjfMxCb/YW8ulK4NOK+TCC6W3QJ/VUws5D0KQTP8jCmhICSwxOOqtVlcMcXnfvE5SnX714NmgzvWZkfSWKqI2X1tJzMiyMbfRWIchW4hIF5yXKV0ehInIdClqBap0qEeRzjx3SF0feF15yubjOBJ+9vq5XMuqu6ihlxLV4gNh9AJarv8s/NbBwj54dZbB3jibQiG88jYOtsL61Ri0OsGYk0cXwgfuYoBuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV9Arc+tH+msPyEyY8KzEuiezBHhkfImdsFTfuPpOMQ=;
 b=Si2uWh727axILiC85NGtSTxz9gflun3Kl2kWnHcNmAFHPIcfd3IwCXn9sGBe4ECPXhNk75NUz37Au8sEGr2RhoCB+D9SoXBtjclTYLrwAOINDxPnhTzoxLMFq1whV2m6AkmaXXmA24E4lsDrDPuyPgzsPbS1qDFajppj9hdegENQSoEwI01uAG68bois4wHaDLG6pWimceZwjNHFRyId9q8hDoi5mq+t0emnymEi1i0hVUcTvvFeqN+YYi3gylT58L0sl5zqDL3Ivfz1tkgEn58R3M6xx8wXAwG60fcqTvQhn4WpL42bkq0HMZMDEQsGfJed3Jw5Ng5VqvUCspFRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 12:59:08 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.014; Fri, 12 Jun 2026 12:59:08 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 0/2] Add support for Synopsys DesignWare SSI controller version 2.00a
Date: Fri, 12 Jun 2026 05:58:54 -0700
Message-Id: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1dfe65-bafc-4d3a-2f0e-08dec882641d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|366016|38350700014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	CbKbEw9F3vH4nVSIli7GR+8bOSkqF2FspXj6aPSiT+u2I7HIju8dWA5wIETyyIG1gxuMWo16PMFWf4NqdquiNTmkPqatomOlqFOVMblxPi4Ep8VUsRpf1q7cvsOADP+OiH/g/YT5NPxLKN380PCCY9U6PcUGDIJJJ0mn19SMFWWjeAFGf7+NSW+i0LbCqedDjfQnaPOQnukzWriuLN4QDt/flPodcqtxfBDSROsI84LTN58e6AkzK7W/64OqiLuAmZYxA367r/IuuPkSijbwX5s8wupt0axAd4r09tqlYyHQGlmaSsvj7347jlJ6xgmOv0nMrkbtmRFWDcueSsdOfX0xEZGxT4qdb+9m22igv46mySB6qFjk0NzEeINEwtZiNHVvvxEBSpHACtGA3rikz2+rLB+YazB3kExgcZP6//zjVoktnr4u73+J30TcTat+gZ5XdlPqL2Y4JpatO6EIgWerzzn7MhoNjHTkHbGcFP5EOXxCxKyJZqW+Msm9qvSYvkYD9sR7qv9EHQjax9NxNixwYfJCl1lZBIk17wnfS8xNrU5oobDMERli4gG6O6Cc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(38350700014)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhO+2L+4PmxQ7tU/7la8pNSiPXpIobkylCCrz4upHCFkH3hUg6Uv3WT4roeO?=
 =?us-ascii?Q?OVkElAKUwDvrsNp7vW5O/85tR5M8TTPcQZo08HxyZJCKWaxneVmkSGsOIuE7?=
 =?us-ascii?Q?amqlNU4ud0fcj4RwYcnY6DjZlpsqL8xp0draVFGudYAo913+JUe3UFJLvtAJ?=
 =?us-ascii?Q?rOE4EsPljSGoYqdGAGe2R5lQfHpFIPNC6xyJrqXCDWLL59Fhbpv/424d3aAj?=
 =?us-ascii?Q?CmPxn9sBz3QnIJnTDDSf0+EE7nsqbOMsPwa/bZHyQ9qXq75jVJCZAJlZIP3u?=
 =?us-ascii?Q?D/ziCpbIekCXNOg45PaWz+Kv2/R7Lj1uQ/wwbqPBMu4AX3TEaikDlDMAhrg6?=
 =?us-ascii?Q?sgWkonKSAvbLW4R/vq96GraCeJkLzARAdL6CsBAuD0ZyVIf5JbDlQlTwRPuc?=
 =?us-ascii?Q?u1Kpm+czrfZGaHa/NrZ3aPlAXhb6I5SoVYSnkHMq3m6c+a9Z37xeugclyOxN?=
 =?us-ascii?Q?fbXSv/QGfyi870whRI0ASYGbBxV+OMj/4lxdZ3wERNZ4eCXZc6NFpfxRj7gS?=
 =?us-ascii?Q?yX4uoCQm2DM5A8JLw/skN9cTNSNQz5Chr6e2s1TrJfRP4ko1z1idP4XdjNN8?=
 =?us-ascii?Q?MvdDQyg84bGZRPlNY6ycbXRCDQn+qMelfTZXK/zKP+gpEbDGBbaVF/1rVdZ1?=
 =?us-ascii?Q?q4A3/L2IJKtc+mSTG7gpMfTyShmz7XMzWZccclYoEAkZkISKFQTxXxQb/EZQ?=
 =?us-ascii?Q?gid+qCdGk3wyMfIQFJ+kDwuVVMF5yK/6PNxQi6FxZ2Rd3sWzaB4iw6pCqlMD?=
 =?us-ascii?Q?dWvP+V8Vy2EuUQTMg6Ek+3WflAf0gKiG1j4DMBSfdYbVqnIJhjtE+0OI2xb9?=
 =?us-ascii?Q?ezfCK4DoB13pFTtv3DxrrjUM5hknrXHmoaachJlaiO6EcdpMkAhrNDroyBxj?=
 =?us-ascii?Q?wRaCPixJn4uY6KvT1Dd+6p8VDZAJbnYmEl1fzZ/rPcb1PXo6rHiF1FxBUuCv?=
 =?us-ascii?Q?M/bMnsXSrJQdfYl4VzSdLRM8YZSzOkK4fQ+1MS1peKBkJZ65d31ejwApbvVP?=
 =?us-ascii?Q?rWAgbwjCX7HSc0YCDdNqvLbNDPxWCIUOPF4Ey1K/eIUtzC7AH38LNJHkqXNp?=
 =?us-ascii?Q?O1jrnEdpS6RftvmoIhsapzhIwzsd9x+InFKKiC01PBh/vsCV/Bvvl7s/cu80?=
 =?us-ascii?Q?IESYRJWjTDv2SiGQQbjNj7zrEEf6mPDpsHvpixLVMnBJhM201e60KDC07PuF?=
 =?us-ascii?Q?IAwaowvYvXFdk4EDTDvkwzD1Us0dxC3TULDDnhLTOm8eJWSrkLXtmK7Wo/SN?=
 =?us-ascii?Q?hVdcfOodOJloNo34g9dH4zabik2lkIhmC8fzzLRPziQc+c2nKUl2DMNXQ1+0?=
 =?us-ascii?Q?ttoN28R9wTf6xl7/Q1ui3rNy5Zo3JpuDblGUK7sd+Kj35kNlZNu2BAYjfYhi?=
 =?us-ascii?Q?g4tI51oB0yDlmmxJW7ZNwdwVhzfJemYcrJquMd482Br6S1MudXomI0Zpue0d?=
 =?us-ascii?Q?/Ttm0/jDI7EQ+EkiWhOby5WiFXSAaB43gFRwdyvmTYPhyJn+ILHUu2nReXO/?=
 =?us-ascii?Q?+Yp8F283w/pC5o9GxEklBa1FOjFzZyASs6DXePhggbyZ7t4rCY9k0aP/tLRR?=
 =?us-ascii?Q?ONCh/xg4RDCd19FaW75kcK4fwEYB0lAjXEREiokU2QsVRhfNFGvNNr0UkI8B?=
 =?us-ascii?Q?zJMbZyvwCP/SNuAn21EjSji3k16VN4EYaIPXOvlHO7JtbO9wYlnAqTzR9v+5?=
 =?us-ascii?Q?5hu9igMm8esLpGoVurmWgeRVHQI0BTp0r/fos6ie3m2Y9pVoFOeFcjVl03QO?=
 =?us-ascii?Q?aOMe+kedsb/NAgSRpLWsC4gbs7zKLsz3GkimYLOYeJD3oz0Z+JCw?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1dfe65-bafc-4d3a-2f0e-08dec882641d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:59:08.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzBL0BQBYcWr6Qt2WHP0gyxKJp0u191CULxyvKawH38HUd1Kp+cKpTGq3EyKtLiGUwJvMGNB4nB3uTKT1hz5m3rLlUDN9M8Od78jdgdm8xVnDOPjMDg6Z7Az0vBzNR1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Add support for Synopsys DesignWare SSI controller version 2.00a,
which is used on the JHB100 SoC.

Changhuang Liang (2):
  dt-bindings: spi: snps,dw-apb-ssi: Add support for snps,dwc-ssi-2.00a
  spi: dw: Add support for snps,dwc-ssi-2.00a

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 drivers/spi/spi-dw-mmio.c                                  | 1 +
 2 files changed, 2 insertions(+)

--
2.25.1
