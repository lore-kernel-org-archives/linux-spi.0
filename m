Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012057.outbound.protection.outlook.com [52.103.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79532AD2E;
	Sun, 16 Aug 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786888380; cv=fail; b=Wx62J7awJXxbQeAqe3VEJerFUg6K51OYK3HjOSLvaTXC+Jb9pL4w7CzfIj4Evy8rCVVwlOU1x5Axiun+dzHzih8hxB19JX+ovVFyJjrdqs3SPH7vZu3S5wVTjWYPPa8jIP/y/NTo+G0lQJsKr6y+n3AwjOvN9UeEm9dK064v0kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786888380; c=relaxed/simple;
	bh=QGztCPs6ffKvUdHsV2MM8qd7XkYFX4i38RBnnqZnnRA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YcQk6PQfnKCioTumDXcOFyeabliWYAinlPizEyuAfPujtahNoNVUHz618ekahy1s05jTcjIGSza8i+uZVAG6sa2mi9zyBva5SQS0BlI7F3s6rjUzYR/WmLXYsChmWGLJQUUliTMKG7mrdErhdU9yUpAm5K3fNdD3fC2NL5M9q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hckpPimh; arc=fail smtp.client-ip=52.103.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hckpPimh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBlC2ttpW+GdXCN3b8iYrbN7cATeOKm16X1Y4ViKL3fBEaEaTmlqcZ3hRUyHomVEFu+Uec79jJpF9ttisVGKX7tsTiNrOgfindNQgoY6LBeIM3hvJ9c5AroNC/UZ09nPwrZlgbS9X/1R1TcMTLv+24PCmh2hTlVO91GfL0+FLIlxwmFn5aYv/O06QE4n2H1J8dSbs002S3ZLu7AaFSxI6H//vy7C75hIJbkJ8SnO/GJGktdLpEFPJJIWKEP7oUL0Z0cyLbxfLDX8f2GjVqApSkd0n32gXviDFAX8Svgs2o6Hwo70yF27VphtfDRH4jpco0boDsx5fcBhvYktAX0dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smB7V0vbyUlDm0qpJzmOsxrQtVLo26vp394SgODFTcw=;
 b=LI1Uei++OFhVlWrKsuaS//dUxrowrmHrGzdCMwB3skdUiq+5HSpcv0ravKCaM4F/CoxUU72E8CrJZDTRypYGU4ZZUPzzhrA1HaXAEkevOwu3ULoqgcs8tfNgIgkMGs3tdyjaebeQtB9q0UgDSMEv0dRA1/846ptnO6iMF5iA6oTfSL9wLZmAh/ZHTVZrscHWmGPK7G2PJ2W3Nyhy/Jrf8TgIVEdIgBJOumUyEgtPyUtSafntzfa+6TxJioBSJp7iDEAb6JVhYPZLv1fYJJLhrx3ed322AV/gdeWf7eTfGZ+JFlgbMrNyxkJVUHpMwYcZ24pnLsKVzas5BcB9mMrXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smB7V0vbyUlDm0qpJzmOsxrQtVLo26vp394SgODFTcw=;
 b=hckpPimh5pySIpecD+lSzBCmyQRg36NCoa6jqwN06nwqAXoNBJonXWMhtayMX00A4qdm6KU5nFWcPOVlN1d60fzv6p3UWHWyS4B8hDLydaydqvKcoFlzV2H/k8H33YXQHlV8pZ0maDfy8z1znAyYwXZBkz+SS8D2EOACKnWDlYGfjmcZZYrlyMPD2J1CaKnbd46FTbLqLP3JdIs+picArbAKc04Y7R7bDW0pTgyO2jpiJ66HyrdDgFYM729hy1myM92EfM3L3t9zTD4B4naz+lxHgW1a0G9WBZ53RGn4bmyUEjr0FSkNShyPivfE72PeP9/vGNx1mI2VZgKJW3KPaw==
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9) by SEZPR01MB5205.apcprd01.prod.exchangelabs.com
 (2603:1096:101:eb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 13:52:55 +0000
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612]) by SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612%5]) with mapi id 15.21.0315.014; Sun, 16 Aug 2026
 13:52:55 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: quic_mdalam@quicinc.com
Cc: j4g8y7@gmail.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH] spi: spi-qpic-snand: pick default ECC settings based on OOB size
Date: Sun, 16 Aug 2026 21:52:32 +0800
Message-ID:
 <SEYPR01MB58823B8C66E5044EADED1609C9D82@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To SEYPR01MB5882.apcprd01.prod.exchangelabs.com (2603:1096:101:1e1::9)
X-Microsoft-Original-Message-ID: <20260816135232.2672709-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5882:EE_|SEZPR01MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: fadb36fa-2ec4-4299-e45e-08defb9dac20
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|19110799012|25010399006|4140399003|5072599009|8060799015|51005399006|24021099003|15080799012|23021999003|12091999003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s3BjSmowsWKQlG+d3Si+gF3nB3y0LTUrERxYayKs0Gm9+1Q0nWXr/wOxirs0?=
 =?us-ascii?Q?gg+rY9X4UYfVM4lTW31431qF9jsSwVrSdJas6PMAPVT5+4ekXKdEVVgNWK7y?=
 =?us-ascii?Q?6Ayb+dA/tDTPVcsTafw+4m7WJQ9V/tX5J39ZHsy0/wuyeoro1ElrQOhH8bp7?=
 =?us-ascii?Q?t+EjmVJ1WR+0vUTWCqXD8/A73NobCk3TsThwgAD/+ErcwNfFz2qoip2Abc6T?=
 =?us-ascii?Q?sWEBOgmKqG+10XM/AMNVApZP5w1i68UXe20y5NfUQ3Sn+PAArpVKk1XgyU3Y?=
 =?us-ascii?Q?YtiUy3+8Sk483Dwk9zWhnTfnQJ2hl9Le0HjepS9ughlM4xn0ABiMW5Y7CLOI?=
 =?us-ascii?Q?0g6sD+JpkZfuXKAjsXcW97giCi62jcTjqBpl678H2Bov5tsuqjy1L8epHM46?=
 =?us-ascii?Q?wpUPQwCu18husLAcC4tuZ1jgbu/ACWJl+9qEqlWOysxi+FJjP0fW35pTYTGu?=
 =?us-ascii?Q?wLIcqjL5k2S/cwUAKHbLW5bt0E7Q4cLHddDf9IMKB1weP5EydkVy3t6Vo8hb?=
 =?us-ascii?Q?y/Exp8/OIzW9+P2WdwDXNrhRTNiERY7XluUB7t3lvnmkbCMns9LB/dwIYjU+?=
 =?us-ascii?Q?wK8++wwRrrMK0XvJNELYYybUj2ci7P05/a3GxKllYeaIZi4T4gGDB3qf8aCe?=
 =?us-ascii?Q?ty6RrFN4BdU+ByKfdjl2mRJFfKZGWojMxFPitqJqQkddg3uou+rX0JebZOGR?=
 =?us-ascii?Q?lTgLd5fgMQq4z1juNBx5O080riQ7txWr2AnQZ/0gdQilXXeMt01ynoVhs/PG?=
 =?us-ascii?Q?Iut2d/4Tdi4YoMOcuYOBQ+3ao9VrkVFNyJszxpPsaxAuaWmBgf9EofWuvOkD?=
 =?us-ascii?Q?YbgrG/kUvmgfSPAjZuJOUbgLKP3MMaPl3ThU5TR+RIF161EnIYSejpeJcn86?=
 =?us-ascii?Q?3v7ccwFbTKADBhwFYUCgq7A0F3F2LrMH8vdUaTpi8lggPD3z/RES97AJzthV?=
 =?us-ascii?Q?FT9wuIl4v2rjHEa4A95CLvkCddO7TiM/NsaKJaV6bdPik+PFIdmzihq8Tu08?=
 =?us-ascii?Q?6bKiRx89xzQVmC2nulDkIVDHYw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VywMvarkX1/TmlCnnFkDT8I3vcSI3dsgRYUK8sL4HjVfAl1hFo4YEXQFA6iF?=
 =?us-ascii?Q?PKLXfxKYj9+m0fl2d2yeGkrDexv40iD37DaJ7UyFVjTS7k1Z7zofS9Wk27a+?=
 =?us-ascii?Q?wB0sha3Yk7PgaGhZpk0BrGHxVG8y9kXWwWAC1PLjlHwjX/TmCMIvJ9aMzeHQ?=
 =?us-ascii?Q?0/8sfiYzpEfWpSh/IYImHV7dAX1zp3FksiH0xNbkXKDtGAMhcigsshXCI6r0?=
 =?us-ascii?Q?TyonAnZGzbBtA65BAsTzCRTy/GSNibdVdC2LbnhfxIlphEaOwWWM7RpHDzaq?=
 =?us-ascii?Q?Xtbn0eigj1fuhfVTJ5h6g5MvVzygwXFRN+Xu4tY0z/Wt9Ai+yA37919buq5r?=
 =?us-ascii?Q?mMXrEkLyQ3Tq82FhsQf9pHnSKPI5URYVAttcZcnq/QlB4fYQ8ZmPot/hPpFP?=
 =?us-ascii?Q?Y2CHTS/SLQ97PPcZdoBVW8eYahuF9XePJ49NLbZpyC7aClNfE2YlRZH6bsNB?=
 =?us-ascii?Q?nXSuxT6EsesZAssJcrJt80bMYy+OzgWGu6D8pOHGZluBZbOEMaoTbQ45JyQN?=
 =?us-ascii?Q?GX2wJYoCjm2YBElqDdEd31YaV+I95541wcffZ0Z4emEUNsGgTJ+c145usBb4?=
 =?us-ascii?Q?VKSC0d+nki7DRDPMOGwJzH/gIVpr+/dJuhUSFnmh5q+0kTo1EzSsbCy8BgT1?=
 =?us-ascii?Q?O/nX9mk2Gp4cXU2fOlXiVB11BOPgJ07pEXTCKe2m1FLTpdX7iBa6wTkuslDN?=
 =?us-ascii?Q?qn4h2sos5lP/VRa94MUIm5XPXfYK+zCndz5+8JzbmNtOWkShuK9FrwnhphQD?=
 =?us-ascii?Q?qlPLTE0N46xEqR5cS7Aa/PnAHKnJn6XCc/M+tgNcQzt9Gmx2Lkb/Ls8Rt9IR?=
 =?us-ascii?Q?NCVEW2Pz2K4V+GYmuh16TBZfdPfcm5scrHP0Z+MpM7cg1CyNZ+Wluy2DLTEv?=
 =?us-ascii?Q?8BqpsDGaEZMloPMqSXdY7m6AeTneokd2m+NfrBGs9y5Rvyz+FoS/rTC8BaDt?=
 =?us-ascii?Q?mIJYA1Y+WGghLcJteCdQBc9OBpMKWYjXY8dPBPBBls/0Bv8NZ/zRxcqGdhOD?=
 =?us-ascii?Q?S1KZbidW0IcdPZIf2jF5Ezb2Ok5q2UcljN66nGPyoRUmXTCLpDqZmywrqa9z?=
 =?us-ascii?Q?SUrnDuEpGZ28Am8gGrdraYuiS7A/8LA/m3Flre0HWllRjsdYtzv9DVwzvYkE?=
 =?us-ascii?Q?uiQw87JgrE1ZqjmqWkBa66NRXKGFtlIvZfO0MWKiiZykk7yj3Jt8qzUwaGSr?=
 =?us-ascii?Q?R83lA3ptP2ZVJjYxZVxrjNleN4ULcydKbyhY0tlb8A19PGbAkOD4sUns3ctA?=
 =?us-ascii?Q?2hP97LYQRBJCM3FLxEn+nJfin/OaWz/UKp2FbcZWZ9xw9vvzdAvS736/hEJV?=
 =?us-ascii?Q?Sk1FJKCMSww6VSWtM6JzoAXjYwMafT0iKlT47bspPwr4svCOQJ0eM/AZyMOT?=
 =?us-ascii?Q?phrekDY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadb36fa-2ec4-4299-e45e-08defb9dac20
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5882.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 13:52:55.1549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5205

Instand of using the ECC provided by the flash chip, QPIC handles ECC by
itself. So the ECC capabilities of the flash chip is useless.

The max ECC capabilities of QPIC depends on the page size (include OOB).
For ECC4, it needs 64B OOB space. For ECC8, it needs 80B OOB space. Use
the max capabilities as the default value.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 drivers/spi/spi-qpic-snand.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b6c58d9cfe14..9d94e69cae26 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -248,7 +248,6 @@ static const struct mtd_ooblayout_ops qcom_spi_ooblayout = {
 static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 {
 	struct qcom_nand_controller *snandc = nand_to_qcom_snand(nand);
-	struct nand_ecc_props *reqs = &nand->ecc.requirements;
 	struct nand_ecc_props *user = &nand->ecc.user_conf;
 	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
@@ -265,13 +264,16 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	if (user->step_size && user->strength) {
 		ecc_cfg->step_size = user->step_size;
 		ecc_cfg->strength = user->strength;
-	} else if (reqs->step_size && reqs->strength) {
-		ecc_cfg->step_size = reqs->step_size;
-		ecc_cfg->strength = reqs->strength;
 	} else {
 		/* use defaults */
 		ecc_cfg->step_size = NANDC_STEP_SIZE;
-		ecc_cfg->strength = 4;
+		if (mtd->oobsize < 64) {
+			ret = -EOPNOTSUPP;
+			goto err_free_ecc_cfg;
+		} else if (mtd->oobsize < 80)
+			ecc_cfg->strength = 4;
+		else
+			ecc_cfg->strength = 8;
 	}
 
 	if (ecc_cfg->step_size != NANDC_STEP_SIZE) {
-- 
2.40.1

