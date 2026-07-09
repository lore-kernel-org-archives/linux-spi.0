Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4B3C9ED9;
	Thu,  9 Jul 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585627; cv=fail; b=LW1juFGxe0U3b6GtEG7t1dr1Ha9U/OnZE2b510ha9b8saZl8QNbLPMgeyg6SsdTdz+l8PAFiI2Bec43Iz3zqHeK70G+ny/LZ9Mx/AbT622ZkuQwb/VOukPGmhHzfeY0dcP9a4iZZa1TAlIflthc3h/jWBIaUiTqok3fSc2vwCj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585627; c=relaxed/simple;
	bh=7cpcICPHq+Qk/jgsuS3Omx1Q4l11u+u7Kjpdo1axTCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SY3qFvQVFdHBe4vtWTUymzqaKjtwIHjKqHdMH2c5Y76TqWcr0XMOCSrOZNp+7aBq1I0UVEXApovHi56PKN4Ul+1KLzWvcY1Sbm5hZ8tjMqdQOYmjjorA6wIb/DoQk10w0dwXgG1I3mbEFbFT2flR6sAEJUoYTVhseKPCSa9NHlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Xh6jB/RmlRR1/tyRc91VhIE8KT7oEWmdKlX90Am39YyF3DHpcZODs/CnftHY96ORW4JfTKN2O0SGJdba5N5YI0rrnredVuMr2qb62wfDWc62NM4De1u42h6LH8qhVbJBS3mL/TRChyMbRn3MVuYbsjQyr/bKiV25bZxQglYACxbdu3601OvoDf/2BHtFq4f6MTPDuhHO83L/4psC0x4b2+WrCOvMWBp9J3RL2iZV0jC8Lz69cVwbdCP1+EEbX8luWZh5GWW1fewFaPQNjifZbHL2Zi9gxFmzdG7HJ8U4aJDJ011+G4ADbGgOEg/4eZ/ewpAtcp44wlSYp2XeTbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6ONyc5FmdIpneIeFyv9LyiXKk+7Cgdbx+54q9r6Q/A=;
 b=O7LRTAEnDhHjU0Yfo+k8k+ELfm0ZAxhrkHviUHQEWE1Ixo/s+yDaoTyli+YcCBZRGB7m6dGteVV+6WpiKO8dFe9QZ2TZarWxR4M3S4jIAJRenR1X8UbOyHBG0gdkRCIeJpqU+ldhphODpVj/3/AZdjkjDKBgkrC5E6KIjQWAAQF0MAUxVd+jrmPYLZk34vpUmA6C2t+eWcDAgePTgKD9loG5xh05xublMKKDm4O1KSIp1ahx+/3bPdSkodIZ/9mIvDAo/oJRALYCFyDoXnXIC7iFWI3pvu5rEW98sm4lSyQTproj3s1ZVbB2ByPAPSQuACmNNz4I4UYKO4yRBnbjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:18 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:18 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 02/11] spi: dw: update NDF while using enhanced spi mode
Date: Wed,  8 Jul 2026 22:51:55 -0700
Message-Id: <20260709055204.138168-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d4d585-7232-4c38-8462-08dedd7e3c81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8VcftRsK4pkHyRCjAFcWr8aGiLpenonrNxrh1PGgMU47jWYdwGeYpEcvokH2BPrh76xFOiIvzr3gzsIYSU74bOcS4FJiut9hKJLBJaT91H2bknUGOBR1IxrZkgUztG+qUSkD2CKcTMPjoU1ekDvTQCkJepE4mSEj26T4p9s9vU1Gg0yafJLaCSjH9yA62pSqP9NTW2pjAEml110sSWZTwMMbhzaBCHu8FvJFeK0onEycfCDGSCnsUboVimY/dqpQ254/HH+YxOmOBAK/a855RKVEYnD+O4281jrO8CIWltvRpscIXNEoF0wa90oxPWnD7HnHpnnxtxt+fad0NTSA5AYxZajTv5sm0TTnBj5Pf+/4ExKhxLmWR6ri/1P++srK+s4qWvn2OdF5v+JAToLVGd+Lm/cFNGDh962x/QPnhOQwiFvT/Qeo/cQI4LtIo4lRDUtyBnrrC5WQzlcGPtP/SvPE4ZpT+k1RajrPnUeR1nmdyn5/6UHB0jfQ778f634d1YRujPGLT4iBA71L1zauAv/k2jlnlUiV/U5yiK4CIpPkv77oV0dh464cvBdTFxAE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9yT7KcBLc2BZydlBHzx4DI11VY30YdWRWnuOAxdEKUVQLduxoMzLFRH1Iph?=
 =?us-ascii?Q?DRl2VHJW1takuXI5GkIzPPX7otKPQjXlQFANTcHceYGb/uyXcAaYJM+jtaY8?=
 =?us-ascii?Q?34co7F8jpdGJf3HOEQsmhB4I1aPijaYVqaNbQkubht6VKgL6hy4Yg3DPxirN?=
 =?us-ascii?Q?0v13i4Nrkpwokdj/AL0jtUYSjB2Oa98PyTAaKlhcObOLTHeYmspA7V6LK37o?=
 =?us-ascii?Q?F6wwGgnu3UzLXI0oJi0dAsK+itGvqxTauZbDxUUBZ3+gx384VLknRE47HNoK?=
 =?us-ascii?Q?u1JfIy6bwDWSQsBiD8R6GsKIuBvMPNWpI/fKTL0w1/SXm29QZZkJdgh4WLy1?=
 =?us-ascii?Q?hsJ1v4ejVRYM0EwEh5BpTzcVBQ5UmraSE/YMS/Nx00Dsv+GK2MzMNT/QSlgn?=
 =?us-ascii?Q?gVSoTRH5gjrgqoOE0ws9UkeZjNr+U7FH7q8ucOS5bmF40f8dFTx0jnGuHFFl?=
 =?us-ascii?Q?RX79t4BX0HWjdtbT3NYw/H49hUrCpKwPqcOBKC/GKFrlvJ3vMe0iyUKjYLS4?=
 =?us-ascii?Q?Lhk6Pn+i+hGOFLxRRPzTqOOYrhWpMqldqCxW5uuHqY33cLuSRI8TnVvNduy8?=
 =?us-ascii?Q?Pi583eR49xr/OBtUIWIKFbxGA7IeX6lgevs5hPEJ0f+6+/xMOllEoAJYxJSI?=
 =?us-ascii?Q?cMRS+PiwlMWvDOIGqufbINt5TyjCSXj10+VcUjqTD5p6/FIByvPWlSNUhS/L?=
 =?us-ascii?Q?NoajteqbQw1ugCnbBXX+4nw6lnnEB+GYEmD/grBRJibpsY2aJR3zQynh+jsK?=
 =?us-ascii?Q?vKJV9Pv6W4b6DrR6IVtT4KKvEPOLDv9HhgmSvgJuzao5sqqBXCribqeA8iwy?=
 =?us-ascii?Q?NgBeSGJWfBIl1bOB6rqsGYofesSPX0O4j+nh5BfQ1v/0UIbkVHskmC8y5pQU?=
 =?us-ascii?Q?sUQM7jgQoZ2gGJkmFpJPO4uDoOHgyVms3sbcxEwbVKiEUnBCDd7+eIUhuK1Q?=
 =?us-ascii?Q?RDM2iYZKAOc1rjtGj/xjAS39jIW+cUBBJLr0pgrD0bSpFuZpgCjN9CeMkMjw?=
 =?us-ascii?Q?HezYRNlho2SaP75JOz3GFSSK9m4XCYXHCKW61+ZpD0//5K9i54EWuikpJQIe?=
 =?us-ascii?Q?tWU8lyibCg9l/F3gIxAM2MbBjnf8Jnh2B4Ykp60roaNiaDLY8wzBgED4cJCL?=
 =?us-ascii?Q?hmp2DmyCKHWzqqCPywYEqAi9zHYqOJcCh2H6V/5SpAFmsLbo6LlwhR9j2obT?=
 =?us-ascii?Q?k1MzqTlI2LkKHxsdLTWOYmSFA4NXSJnRzHLZQKpW0voXTqAkfxY0/WXlKSp9?=
 =?us-ascii?Q?TehySb8Mob3IUu1Cg/ctojk3vsiz+TvFXPT+pdmQ5TWX8sT0Upwfn3czkzTm?=
 =?us-ascii?Q?bT8Z2fmALh3UTAjkJs5vcRIcO1ykYh3vXfn2OOiG0Ek++BX2hnRwf9GNkyVH?=
 =?us-ascii?Q?3LsHYZacK/OBMDUamBUOe2wkvYo8tqtpEhZmfDERY11JATAcr/PSYtCXx51o?=
 =?us-ascii?Q?qz+74CPzWbMMvFU0Cc35oGey7qFXex7T1UOVuw8R2jBm674V3f0TI4T1kciZ?=
 =?us-ascii?Q?rgTwZxssSUf5k+YvtuiQ0TDeWIEOSLuh7k5e4NSEHW21qfox1O56P89RJ65S?=
 =?us-ascii?Q?oIJkYFRs8PUOsh18DP6SY6RAHwJS213gihPO872JagukNJkXjnOLS5D6Sc0z?=
 =?us-ascii?Q?gea4dyVBaDn3+KicKoaBxSKYzMSGoZ2UNkz63lLHvW9jxuLXXDlOmnmr1edX?=
 =?us-ascii?Q?kJ4m+hrYWLpMfPj698V7bffyIW+t6JEyOezZyW+Ljok5/nCUsOUXFcksPwpi?=
 =?us-ascii?Q?u/a2poIBirZHEAbX6e/0YgXBNMTUDX8z1uqs9k6bzFlYabjiO+9w?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d4d585-7232-4c38-8462-08dedd7e3c81
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:18.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5klGGp2dk4MOX8om4owntLq3QgEaEP5BiH4mZliTN0H3E+tyyuu8sz9k4bZhji6GFqhgMvZu93cpIE3iCansEVrNJSMiVNFSxxrrnYfjL6CMgyaOUn6ACSZYcnVx2mn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

From: Sudip Mukherjee <sudip.mukherjee@sifive.com>

If the transfer of Transmit only mode is using dual/quad/octal SPI then
NDF needs to be updated with the number of data frames.
If the Transmit FIFO goes empty in-between, DWC_ssi masks the serial
clock and wait for rest of the data until the programmed amount of
frames are transferred successfully.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
Co-developed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 86e3e7487bc7..bd41e1b4dba7 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -348,6 +348,9 @@ void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 	if (cfg->tmode == DW_SPI_CTRLR0_TMOD_EPROMREAD ||
 	    cfg->tmode == DW_SPI_CTRLR0_TMOD_RO)
 		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf ? cfg->ndf - 1 : 0);
+	else if (cfg->tmode == DW_SPI_CTRLR0_TMOD_TO &&
+		 dws->caps & DW_SPI_CAP_EMODE)
+		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf);
 
 	/* Note DW APB SSI clock divider doesn't support odd numbers */
 	clk_div = (DIV_ROUND_UP(dws->max_freq, cfg->freq) + 1) & 0xfffe;
-- 
2.25.1

