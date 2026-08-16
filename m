Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012055.outbound.protection.outlook.com [52.103.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896EF233944;
	Sun, 16 Aug 2026 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786887920; cv=fail; b=FopXBG0eqZSWkrr+Thrb5JTGqqdqQ+6LF1+TAhYbEtbTNiqxb0A8zclDkpJRAoAZzB3735pQ9Zu0vaX9SJjN+Kv1hibRXRSNA8GlVHQ3MwX2Iw4rHGxyhqgEgZYSvHRKyZXROwpjH2pX/hH4vGzGazx+SgLJVAEO7QPRvDPJTN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786887920; c=relaxed/simple;
	bh=tQOQ42lsU9MLfq521dDwDrQOVIO4P2MzyWTK5Y3Boew=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ck4KZRjPPnVY8vVUBUscDmzr0KYPfY5Y0bufpASYQBkpHxfd1bg/MmDm7cLXPAuNJpQGjwXNe1evQLoiW3oayrdum/Uz7iNUZehnvA/3i9FfN1lYEGdUruIChFDxtTm6h6Cwmjd//C49WLIUB9EJQ12f09rByFai4MtaDBl/6Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Xcb39DaK; arc=fail smtp.client-ip=52.103.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Xcb39DaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swLJo3NMC54dSVNTD6RG4SszwHDz0TbYPM9GCGCwGCWysk6k6xzj3uq7x2XEt08Lxs0K0cj29r8ZW2JbhRFPr9TJHhvIpEU/nyms/pnpgQ1r/OcsCJSJnhl6SNXwX814pNv8o4xvXiqx7yhT8A/6ZFDq+W0AzoLvBS2PWBAt6DIajlAIcBkYJIABiwpku/Qm7eW2va5PhQMJJdAZE8/NshX7dWXcY1v+npCcfBMN2diwqx6yqWzYIj89Wl8FnuQuHap9wb6JIecWfJnmEkSJBaYMU+tnYOmCZMnizTVS0qHYKCuffCD+Maxo4i/RH4HPcdYb3N8XvILENIvehi0N/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnMXJ/x5+yMxBcJo4XC5ppssnNr/ZxaVX6pfNrICas8=;
 b=XB+YCvYuF0DDETSRDHHrpxjHkK8brpYEDWvOS1PnlLLC8rKV0bWvvs0Ftv+qY0FjJoiE8uwM+pRFpY8JeH9Bk2oiVpKioO/ILYbDTfPPv5O/zIQIX5yca7CArgIgkUBqJBskUQivJJVfdDO/QnoH9Nooo9d/qxiOwj1W1Q1elw9sScSbP9kWjoJSlkJaY7swcgYpkbUjPHyGNaVGcolUcCpxsRyo5tDlf7Pa/Pi5n7psOiN4AK8F1J66RchXnQcbb/XMeGi4rh5AmH+ocRRHdNxFRT4nGNef0wUncGOOS4+Uao5WBbMBnUubWPOSwmZ3J6m7YTXnAmMR04F/GNxXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnMXJ/x5+yMxBcJo4XC5ppssnNr/ZxaVX6pfNrICas8=;
 b=Xcb39DaKugIoknN0kWazozUWS+x6Gd0UurvaL2ViPWLBLysWnJYuzIiLgplEIqGNqGXnZhZKIJZr0ipDmCdDn6MgIzeMQ6dmoMI789t4Yhp2E6TuTRWWQ7bSAhN9dYNhUgxEbUXbQcFiWhNk3MPt7faYMH4EXIb8Yvduqs3C7sCRCQZ2qIkso4U8sOhH2hW96pVmW4U/dDudePK22L6G0SaNOx3YINiEzvHbNf2+ltx90M5/Hw+ojURWy26uA0jdPeywTpI7umJwo1WA+d2G5vWcEmq3MslGoVtYUX8MsChlKv9GkVZlYrw6cT35/duG/hED5jNWXFYp0KkDjMn0Bw==
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9) by SEZPR01MB5205.apcprd01.prod.exchangelabs.com
 (2603:1096:101:eb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:45:15 +0000
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612]) by SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612%5]) with mapi id 15.21.0315.014; Sun, 16 Aug 2026
 13:45:14 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: quic_mdalam@quicinc.com
Cc: j4g8y7@gmail.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH] spi: spi-qpic-snand: reject when no enough OOB space
Date: Sun, 16 Aug 2026 21:44:40 +0800
Message-ID:
 <SEYPR01MB5882367902E2376FDADBCC17C9D82@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::11) To SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9)
X-Microsoft-Original-Message-ID: <20260816134440.2670952-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5882:EE_|SEZPR01MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3dd2a6-69ab-408c-f96d-08defb9c9999
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|19110799012|25010399006|4140399003|5072599009|41001999006|8060799015|24021099003|39105399006|15080799012|23021999003|22141099003|12091999003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4tNeWaj9UFlQp5U9rrDcWsOwvd4Z7REjkV71AHRlBFDVNGRevqkK9fWUWhmL?=
 =?us-ascii?Q?4RYht3ABIRbQbRdyoLqIZmjaSZ3tnw5hf8bPA8MZMJ694KcpcfgFeWlEp6NJ?=
 =?us-ascii?Q?lPc9t5BgOHCfk6p6aRNsa7OB+9g+KB1GugZkT9SAJkI8o5j/GtY1xqWc2QMd?=
 =?us-ascii?Q?O3p9y8E0FQD9g9hZb+WAcpiF9pd8FyWoOEGhux+pelh5xcwhQeCk3TDFH2PZ?=
 =?us-ascii?Q?nHKQs/jHvRNVFYSuViK2FEElLZyKOFipIT5HsC+JFcN9yxFZXKAR7l9d/6NK?=
 =?us-ascii?Q?rIrFqCWIzlBl9kbL6WrppasbsVOFO5WjwTs1j0aLllj8ce2J7hrljhj9Xrii?=
 =?us-ascii?Q?2rFAr8s4U7cCwFrONeirf7PIXNee5o+kOgy2cARfw+fafia+WaHBOIpEQll4?=
 =?us-ascii?Q?CLZTdZT2g2350q6n8mAfAaiCrzTNtDw9P1CkiBdVQTGZCVSJhXHoC5nMtDDJ?=
 =?us-ascii?Q?LMnLeUZT5ULxHP/Kn7up4aQBDmAn/Q4fk0VADBdEnXhKklMN7atyKkYfxs4Y?=
 =?us-ascii?Q?vd6a0ZPQtQ7IplcmyQ68MzSqkEZGypGakbLKy2QA3zCKiwCmtu+7H8HCFzQe?=
 =?us-ascii?Q?fGEq9J02B9OVpIL+wFx5Apyme08y1lxE8M18ZOOoJk3wBta1VbA5e2I0OWgc?=
 =?us-ascii?Q?AaV87r2aJBW2HpecjtTtvxNWZM0KTyvC059vPKnukXEgKnYgXXKwTKuPK4ne?=
 =?us-ascii?Q?NeTOvM2gU/YxCVSo/uzn+6GrgJTWN05Nwa/Qd0xDQoOJ02OD8upXAG270vIa?=
 =?us-ascii?Q?vB22kSutdasPomSANr7chqBbzUQ+Duhk2n9cXdAHrTOlqJMKY1alWe2gIRJ7?=
 =?us-ascii?Q?scta+AmBf1P2GSnz5T3eOeA4ssyypa6e3MAvJrYxtbTRY1J+XHb2Al+5L1hF?=
 =?us-ascii?Q?rPx/6T42QPTnkWyViupjZPPkl+a6u/F9SPBE3s1efL3VQpQXuv4S9td9V8WX?=
 =?us-ascii?Q?XLc+uufqEGQsayo3/vTbdZeJhOSvZ/NMLRf8qMf5RtRZIfCncU8WqVwVlUnr?=
 =?us-ascii?Q?Ac0SsUhC8Me+FJKJJAH3vQGGp3wQFzgYd3RWNj+TNRgFsYAH/OfG7OC1qXyb?=
 =?us-ascii?Q?ZA5cdTHteed5VxRkAxyXKLo7NZiAgg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8RViz7nNcUEfobEzUx7Jm7uC2rikU5OzVA0o0TZONaxOq7LL+my2O4HKhhI?=
 =?us-ascii?Q?XIxgttu4fdzXdCfq1KNM61xxCGOEgTBfibfpqY0DNGvk9OPw4LLg/aG/HaWi?=
 =?us-ascii?Q?2+aoYugkfdFDyLu8wpOxWrgJeFUyW2I0LVzCfXkhFncq4Rdnqv4CmUYYjp2q?=
 =?us-ascii?Q?sLfBQpomPhf7XpDL0zBrBNS+czMcrrxcaWfUC/lTKCG3+NvAhacaNfs/G0+o?=
 =?us-ascii?Q?hxRr2XGtr2r7s7+ciO3gJjQUXGljcWxJ2J/et5ij+YLqAb25NVtHgZOOJHTM?=
 =?us-ascii?Q?yoxWS9viEAySaOHVjWY9VEvgKK1A0zpDf0HEn206FB9e5/Zad14vikXkKqx3?=
 =?us-ascii?Q?gXTKCF0Gz+UV1VJDqFqKDF9ljhQTtHihfC60oBfn76lJAXQnRux0O9SQfIRI?=
 =?us-ascii?Q?dRQX29gAbBu5uhFRMH37iQPpV1Fbsr8n2SjEj3VbiXbalGj/8tVDQPlGXQAB?=
 =?us-ascii?Q?WyK4HFqIwtgoAU/7Pw8u4RstOvXsHskkyxplJGRsDkYFhzroCHIUEls5ZeGn?=
 =?us-ascii?Q?gA6FMP0ohHYDZC7lKvH/oJ5wseG/onGmxbGKKPsptAyzDNxi1utnMJg7boTV?=
 =?us-ascii?Q?pDGREKp5g5W/qZ7kie7hZnMSEgvz6NcOjdDWf7Khc3/i/vX5OPKYhPpjvXGK?=
 =?us-ascii?Q?WYXJ9MapRIeWW424X3ZCbpfcPpldN/NDYxt2+Q6yUdDAgOz+x4XfecI6n9zD?=
 =?us-ascii?Q?D4lTetUy+S3oLuFHCpvUI3zvhW3eyvRORkjfH69lpMwzsYzKKFBJEf+zYh72?=
 =?us-ascii?Q?U/QvcIvkDzXKGX+yghyJ6WwbaH2qrjfJi/YBxhYJtceygxZvJK8MOt7lI1h6?=
 =?us-ascii?Q?LQ6QOgrkbw8O9J6JqocGhJuIW1rAYm+3mx8w6ZGV3NSfPDbM8BZKQN1Emzol?=
 =?us-ascii?Q?vS32qGKUW3XooVTrzH/YBIgaB4pGZ/AZIV+LnFd4F2OutFLTG1nS0C1J7Fv9?=
 =?us-ascii?Q?FRAJO8vS3IKXDV3+jckjJUiteNaLzeK7p7rwxsqp55st2TKJ66oYYOIcGO+J?=
 =?us-ascii?Q?tNbn87DEASSsnUXDP5GGvYZ6w8/8wCfO4Tme5LZBU7IVrv6tsun8hAX114my?=
 =?us-ascii?Q?bEQoqeYqBag7j2+YlVdPXHBk0ZsGB0qoWrCXwYDjGJhmIwdfrMLXN/Bqacmu?=
 =?us-ascii?Q?FlpyyXoLdqcNtrNbIYWYNyUyxfZ5oe9tjGZ/3SWzCdwiA4c59SHKhi0x6xT6?=
 =?us-ascii?Q?tPro2CPAOdZx1gY5Ywgn/26pk3WCep2n/HyfjQxnfJ9vVN97EH6cSFF2N1zN?=
 =?us-ascii?Q?WU+gtye9dR8r3NEvxW3fjn8ZrNddpb6eZkq3M8fEYQQEc/M0CKnBkVfoQSnD?=
 =?us-ascii?Q?70v0A7z3qKqiZwrKRhpAKkrTVhR+WXBDFKGbOtEvDmpjUwd9LsOpmhpC9GSE?=
 =?us-ascii?Q?DclNsAY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3dd2a6-69ab-408c-f96d-08defb9c9999
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5882.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:45:14.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5205

Print a clear error when the flash doesn't have enough space, instand of
return -EBADMSG silently in read or write functions.

ECC4 requires 64B OOB space.
ECC8 requires 80B OOB space.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/spi/spi-qpic-snand.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b6c58d9cfe14..3d0013e5687f 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -323,6 +323,15 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
 	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
 
+	if ((ecc_cfg->cw_size * cwperpage) > (mtd->writesize + mtd->oobsize)) {
+		dev_err(snandc->dev,
+			"Current ECC settings require %d bytes, but the flash only has %d+%d bytes.\n",
+			(ecc_cfg->cw_size * cwperpage), mtd->writesize,
+			mtd->oobsize);
+		ret = -EINVAL;
+		goto err_free_ecc_cfg;
+	}
+
 	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
 
 	/*
@@ -1659,4 +1668,3 @@ module_platform_driver(qcom_spi_driver);
 MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
 MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
 MODULE_LICENSE("GPL");
-
-- 
2.40.1

