Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744243FC5C0;
	Fri, 12 Jun 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282009; cv=fail; b=r1ecPcl+E7a1Mp/xUJeK0XJ00upu54stkpmi5l7MOi5/W68TC8QN3tWLuAv/TutFbMOZ7yDVEbOXPEiKhtgrTcgF48LjfLtzwmxdN7DRQd95KDYg5eSFMlaDHDIMcQuQA4n9nfcY4sxTfEeMx4inN0xE0xZnsVf3JpBaDPUKxsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282009; c=relaxed/simple;
	bh=y235wgCnBnln3wmvqMolgSkNIaej8jY6zjRi0jgK8zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UO1RF0FXrRpGT+A1qLPaaTHzc7Y4T8sahrj3oQodiOP6JssQIYwrGKj/QOBqOV/gwvxJQjoEDlSpXDF3BPvJ188vByZSmGHB+mgXUTdg4eAwFuZXa/60yaoM3TM2tbPN72I9qcgyN/dqDtKaBIrOueb1ATHfJOfDQV85BGHwmCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUo/DWzBUfWawKDKjFVqC9N7qqTN5wMQbSoKjaHL2Mwte+lbVMSRhAQz9k9Cgb6OiK/FXO+vcpRZRhuscwB7Od1yeU/kXVOCdwTYSkOF0C0Fp3peMNlRKY8kv569xExV+ZARWh/bWmwfy0ChVlhz05NtADhGZkxQ3R8V95RBcWzjh0lzwHKLcuoa2Tfpa6s+WPiyJFllShf3zFeh6jduitHXiUxwmuL9KOTF9aw2juFGybeqEGqmsU3CzKHR0S5l2BlCUOvJOHosh0WiWaMwvC3TtZAeMJr2TcI+YyDyvblem4zKhdzE+yAcuNqLjYRnYp5ipqzE8FQA+oQXD6p9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhznIDGbyNSZOEivri/d+I2q+1As7PP/zY0Idvv9MfY=;
 b=Ta45gHIiM2td/kwQQVhPLNGgkZBSw+D85kisMIDRKgXp7WHvp/owdqDnGTtdX+PwiSCZgOdQTba+gFdfC5PHmID3rA3OfF+aA9QcKsU+iZgDnB9H+jxAwdiL0NJh4zxeKhWZFP1N4XU80TOdjRUP9Jf4TS9ALMUzJThfgsZv3oUseGLSPAemEf4MFE/PNdTyXDUnTLnD2qp/0ZSFM42NzxAuNQGl0lxAxLJC6KJi7Pv+Z8ShHZAyO8EuvLC6tuiZyKZrLVViqfRa0L0JhvUsqvrEzAiXdtLGADtgQHcJZw2rnYthjTM5/MFNpI/s0FXB//esVWK1F63CNjGyea10tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 12:59:09 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.014; Fri, 12 Jun 2026 12:59:09 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support for snps,dwc-ssi-2.00a
Date: Fri, 12 Jun 2026 05:58:55 -0700
Message-Id: <20260612125856.8530-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcdf4491-b1d7-455f-00da-08dec8826495
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|366016|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wzhzOQbcLL5XstmeU2HQXaIxDv3w30UJFAQTLrerhnRN028Uo3DrSdWQ+sulPMHzGVR9c7vhMSG+/T1r74ewMG3vJ3kS3r9p1gAsrL/z5r3u02NOtUXxpYxPjAN0dO0XUc4OoYz9PFcHpjC0YAPrNWoNVqCPjTFm96tom/bs7WPh8+HKaLOJgiDTyU6i/IJl03fCIf9um++0t3L4BAORu2aJAIcR0i2mVxuZSOLLs0pS7vnbwzQdlsw9CjBeMdjd6rQOiT/NOTTnv+O9AwwJ70voBZG3MimYxqkR8E959F2JFTv6uoroivslD2EZlSdd59fZJjzXGkjXUuzWRkMZgLcHHChUzrAoZjI5Q89G3/ceIwbIt3doec2t1lugQshxBn/ieW4rTau8AbllO/iH6qmF1QoshZTkVv4AJ3EC4Hjaoi3ScMgAfaBhwkT78LTV9X8kQBcp2caVvxm9cIz3ShaIW9g+U13NI5ZZSxPaqqWqJ8hAY9a+2g6tinK7Ag5IJocMdvHuAj5gNrZoMiE7WInmLq/cw0OdCKduTNIVETI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rXgS7Qr7CebPlFV/WHfK0KWKg7zaIQXNM858fUZ5p5bF//HcQTNIwexDgo7?=
 =?us-ascii?Q?zSOisljGAwG/wolPQhq8imdz6a8GNDQlRe/S6HRJZvL/HgDmMCTZlEEY+kx2?=
 =?us-ascii?Q?Zdt0NV3E/9MAG//gBr45neGyytyehs+bdzyZtjvwo3QNzxeeDV5BG+8pVtbV?=
 =?us-ascii?Q?qDzMmQqPhGgpjGwGFPTOoFdMffIT9MSJ7JLiMxEH9OotOKRBSEHL/PYBSNz3?=
 =?us-ascii?Q?6ebvZLfMIBdGen1BS6ljeLGfzevG6ZC1IyrRj/sj8sImQ3WQ5HYlvFHafa+4?=
 =?us-ascii?Q?pkBnaaZMx0GbVbzBs/ziY3tItnrzJaiLTtTfI0Hzlp0HgfAkXxMO92ekue2j?=
 =?us-ascii?Q?EbF2DaypmjGB+UpIZrkRTjO1gRgnjc6VdQODEOndDRg5QambtTmTLgEpfZBE?=
 =?us-ascii?Q?l4cLKfoIP++6I6jrl0ky8iAoYhxBL8SBaiYh/uCk+1T8Hv1ywpnVTI20pUvb?=
 =?us-ascii?Q?XRRVjNlfrzg/qMz7evUMI5ygWrUJMsJzO1VdIv5uG/jlRuqJLMP2qLOMSf6C?=
 =?us-ascii?Q?R4rRr/7cVBszWSdNR2rg6t+5/Ij5BaxFrii5Q3HJowQVG7wLp05q9KXY1RE2?=
 =?us-ascii?Q?xkIW3CvDaMtjnhzJ24DwY3J8Advge//REr3XRhHA1Z2U8siVyBMgZCl0vJL3?=
 =?us-ascii?Q?YCng4wXhXpTCcJLRllK2kn16+LiPAXE9pQsRKxvau8Z7diErOpOSRBg9ptYL?=
 =?us-ascii?Q?3edMNNkcZSezDXZYhySZFRCy5e8rI1mma71PI8i3Z6hB30x81ExCbe2jVmaW?=
 =?us-ascii?Q?FnoTi0GPqU2KOXxu5/mXQvZPdK3TMRbXORUuGWW+G7Qa8Mgr1cTtQ7sTD27E?=
 =?us-ascii?Q?3uMtaK4hNIRih9RabvoBefSMvVMCtW0epkcAPI6+6ZA9DxoYyYnVkoQHvnsr?=
 =?us-ascii?Q?txrpVENp/sATyDP3x60MYtNXN/pkjZ5raAeMsViVf6Mbl1gsmZFMoLDBA2Qh?=
 =?us-ascii?Q?U1EJM1X9UZ07qczkK2QbtQj+obUto/Pzkm1RMu4k41P5FJADq21ReQNEcmX1?=
 =?us-ascii?Q?yeGhA4opVpP47QYfVbpURHSmqzBLXnnGy5+nOTQPdD4gaL0q09wBOaZ+J0Q+?=
 =?us-ascii?Q?ImBS2snHCrwQAtS5RvDyR+6fzS2Y21ZGMW9OVWlWLjzQKwUycvRrYMQn2ckg?=
 =?us-ascii?Q?5MCWcjFxYcBpXn3O0OIh71ITDTb1XilbzE6+qYgOVQa4k4IJNSay449Ss3lQ?=
 =?us-ascii?Q?Bm/rVWJEvg3q718dzXaDdqSN7nNvLkzMbtru2LxPRTCMrpnnAPwdcgEO9GtW?=
 =?us-ascii?Q?jwRMn8vDVWsaXvQ62ZzcZpvuWIKECrciN/9m7ohva6UVW/4Ps9RnhK5qUn2J?=
 =?us-ascii?Q?DUUF5g9ZrhaCeUFBAh1w2/56Ei8L5wO9Qwe3U1MktXkIpzClLr55zk/HxeOD?=
 =?us-ascii?Q?Bg+f6rOqOBkArCUtPt1qeTEhwr7K5C5UsX7DGQu6BEeWZDXyMALEnvHCBrly?=
 =?us-ascii?Q?0lXBsUcO4YT9ZkH96UgM4IHekG6gpTdkuCT1oPYqg2eEgrldzdx/1k1q4+Mi?=
 =?us-ascii?Q?9qVsyCSrfV9nFmmlkbTjFwn9TnN1KuE60i7Mmv0nO7zIfgFLkdIYXnhY3zfq?=
 =?us-ascii?Q?RmD1OKsnYLgW630uzKQchwfderl0V6czsjtfTDfqylAZ86NakHqS/JGQyy6J?=
 =?us-ascii?Q?bjcBS1ICnByeMHT+uKhY6Z/KDKEeClxfmmZv1sFAk1aW6omK1pcdGXSnGKag?=
 =?us-ascii?Q?gYzO3xvrEFpO9Ksln4C39OT+1v51pSxrJ2yzgnMrQkPpucoR+iZte4tf4HRI?=
 =?us-ascii?Q?nl8Eunr00LRRD/WRmnuMOTbsgWTMmTwgRbfokHIWdJMidlupUh11?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdf4491-b1d7-455f-00da-08dec8826495
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:59:09.2725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPGbhmJ/MD+6eKxDAT7dzRw4Sx9AgTGN1cx3P0e/uADkbq4BzsDywkwizL4YMtjBNGMQjtcofic039XIkHILnB+EILn8EglU9aqA6maXKM4Rpb/CiVPNxNQbYMuXFZS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
DesignWare SSI controller version 2.00a.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 8ebebcebca16..fb74243d4bdf 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -41,6 +41,7 @@ properties:
         enum:
           - snps,dw-apb-ssi
           - snps,dwc-ssi-1.01a
+          - snps,dwc-ssi-2.00a
       - description: Microchip Sparx5 SoC SPI Controller
         const: microchip,sparx5-spi
       - description: Amazon Alpine SPI Controller
-- 
2.25.1

