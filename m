Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3C459AC0;
	Thu, 23 Jul 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804607; cv=fail; b=ufUkfYZtBqdQWaj8UTHi+XUDJrQIBnzokmsLJplp3d0/7APJKirmoCeaV3J9jmYgubJY5Istk0kGEw0dn30MNBA0rSgTe1tiV2NZ+YZb8J7+kqcsiocyLgy8uJQJ7TCq6aAW6jb6V2wG/URHG/FNv24e6AOcmRwVgAome3vhftY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804607; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXtxavVLMazXb8m4aYtWJZbU/5xDYJ9X9/RHEo2tlqu+b9L30CY75pLi8E/WHUPDLBOKdmJ5mxXmnBoSPDZwe34QK3nKfkOvLG+P2LWcWYcCEkoesez0h+en2xOitryUtcTc5ojavONnC9AEUvCQY1ONYSDyHXPQJCBRdTjLi3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KR5jED/H; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XUPKDAGO; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KR5jED/H";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XUPKDAGO"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9MCVN4110983;
	Thu, 23 Jul 2026 06:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=KR5jED/HWWn5odMVjOBhqF74vtIFdPFl/d9InkUzmuWa5t6/+TUMlawUx
	0jOC2h0ka91d9G2wQ2ZvowlgGvhvBuksG1IT7FPU+HtnDP6MPfhfu/uJkqK8PGqi
	gI8diVMvIJyuNcxxJUDyUxjs9HyaV+JG8Uunv0I3op0ubpzr0+obqyoFNcoQExMk
	vNJtmzfKgpQc7K02ycPTk9D5dQ2oXlBijRkUi2MvwOq2UWlLB79SbNO/2K4do7Ug
	Bm26m84SEakeKTbllSOeA+zFTQU7YZPG+8hzHPOE427vzDX+fL2kEYSA0oQiCwWN
	O3l7SLY0TSqJUuKHoqTVklwzvXhhQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fkg908cu8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:03:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4X91dFGIe6JpyjfRH9jBVFtqARFrL0lav5HuKwLgKj+4mLxnhIksRyoalfRnaDeiSnaGhQ22kmPuvtp7lFztnuWcwpMCoaRa/d1WSzMEVvrMIlys1+tkz2Y85yu4dFjidXe35qTMICfZ6V1iZoEfvXOA6Oom6W/rmIzepoPjVuIoSSEir072eQltMVQSEtdhZnaiUiSWzYLrm6vue5X1hFAv92egip7yx2ixOpuMyjbOEkf7CUguv2FlUKEeGCX1GZ0KsF99i56zjf9VfknMT9g8hXxwRN0q7KsNrCLY2h5ExsEMVbgnRVTqWs27KyYDr+QSieD9uFKwUKxgcQNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=vF0ACWZiXx5azuBBw4q2ffMYPHKn7KQ3A+u/5gUe8L0AVF/o03fqNeXebYID/A7YMcEUsAugHU5GkuAUKl9ufu90pGMVMhA2F+oLyoEtgtIyaRhHNvzM2ecGDPssMMPt/Mz5fVRyMg9nSmpMgty+EClJd8aLwa4cfrOdD3DPICREp12xQleRMlmCWUtgVpNp92MoLeqzFhpUW976nZnkuWmOh3yJMNI4IL6p5N9RDCuO82+HmbEc/qLGfmRBEoBXsB59dDTbWwX6nycmCPlLJB4Xh7/m6RkUhBmqf6jRGUBR8pROuaKqWB59r0JkAnC6ZphLq8QLwwICFO8XZp5fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=XUPKDAGOV/qL6rIlu7S/2k/bVlrbBoZeknHMlv5JCVFu8p6+4APD2nuiGJTL+cE3O/K5JKii3YWa3+ZT3Tn5WoKJFVk8ZeoFF2Hwrp6zmsZzNzC82t0NnK5eXtosXNyMpnR/jUujA2/yrgVg+fwtJjm+AtdfoA6zvQrgW9k5/3g=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:03:04 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::19) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:03:04 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:03 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:03:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:03:03 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OW21577597;
	Thu, 23 Jul 2026 06:02:58 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 06/17] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Thu, 23 Jul 2026 16:32:08 +0530
Message-ID: <20260723110219.3180747-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|BN0PR10MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5151e9-c01a-49f9-dc72-08dee8a9f815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DMxxMmgy1ofgVr3w9o82vZYz71w/C29vigBZOUmGdo7tIAECox+zTuUh6tiEgV7KEYpe5LgJjrVnihVHdql6XSo2AF/02vMXu+cB8YHSCcO5sHV72p04pbtiG3CwmxK0SN+a+MpkaqzbkJWVvEERPwFtKTdl+8vPuBnhYWtwxy74kDeFeXMzi4qIdjNUkCHNksMfLExcpUXxaV8MYEUo/ccmNuZPordekjj0RBvneXVWVwTS9XIMg3fc6kPY7d5WN6pvYIIw4n69dsvTMCYcV5xQ+wxtdxnifFTYvaRUHw2cR8rQ0FJ2acokRt+NLtX+ylzFGtH62KOJHrqb6XQPgBTszwiOkW32zO44aCeGTQA42AfPxe9z72Q3QiShTzRLCqiWisl9dNbqDY9qZUW9yGBAkKj2TuE0dSNftrw3OpL3FDkiWKvOM2w4q9aRkIoB40wGVCyh6rTVm3EfzumAN8jA6XitmkikXlzTIxIQwQPBlV7lqnl34x8Uuu+T0UydbUihSg0KIDt4eBZ0EI1t82irjZ+VLem75Gri2VZgdgcnItbcKW4N6t78Q4CqtFWjs6I6wqIM4Q44eRvjbb/jS8I42n5h3DJQop1TENLhVKt3ku+ELUllFiGA/g1incbCPVmlnWgswZpnnr0Lu9CCIDZD4OEyvINeo/v3XLo1uzeTAHpcXHBrQN7k/oiMQORmDCxiN+guEpE3bWaM+YVqnBfQP52TGEGe4wOQhRNJAyuodpxOrdLiOXNDU2SrKl0p
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(10067099003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OwgQiodx7LNxvlSSSvEXXVmMEGPMamEVe0GyDq0/i0UpwyVeua+HyTUzps6wXBKK1WA525QdSB1SM+QivMO2jD75Ds/vqFsiAyNYuTW8Mdke7E/DzuY7WGBU55/TISvUTUaImD2+KEJuU+T7GRkZ7Ll0NsWIvvedLgA685fclpNgvScvBTTzuDbXEfsZC+LOr87gBvWtM6eBIN7nn7Ssk4EoQg1u/9JSl7KFtvTPzXJf2A5Vw5vRrlOLOduVKW0nmioq3y5BeRa4vHkgoLhO93P/ZIJ2iV3Y3DVMVlfLuuJiCg8jgUPnpsnYIZkA4KdqJ5qoK7w2aLaF1vkwse393EF/pV6ALRfT9eJXYULqqMGKeonMBsDknj5YQ1aMadaITZQAHlEB49O++j3Y6d+biGbzPaAUNADGtrVmGv6nqTDuVBQx5NXLAHFqULgVzJlo
X-Exchange-RoutingPolicyChecked:
	WaLmqN/fwkxYrchyKiVXGP4Gy1+naWuOLYhOyukoCwupbVlPEN+pthIhMbdlM1D3W5BkYVG4d/axqPpvVNPm7vep3BtYUIVsVlyfcLq2p+UEL0mEgL6jhMzmhO2uioP5H2zboBNhJKhtKkoR/3G3vJE0IudAz5Amwb4wdPmTAG36MEDV4FX7+nscI9wncssR3JCrnU1vUU0IWJWFpQFKw4D7bdz6exyWTjWHtuXi+9Joe/jA1sHONnZKBmgAMxfK8SXxXmcoSZ7j/iclrrnK2v3DxD6nnsG6JeQHDxSAjAFKweNhhv7gG48raG9dsnWXR/A8UX7vKwVNgvzYDAgPXQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:03:04.1760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5151e9-c01a-49f9-dc72-08dee8a9f815
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXwhU/6dx849KT
 c6P5lsYUkiDtEuqs9WDH2TFfIXobXqRtsKwHT8myWMONRr3GxL/CYm9SZ3cj69gLFxPEU4JFpxP
 Lwcb1+MtDQmoldVOLYmM/TqjazaatQFHJUiGx4THp6224hrr4XKUVEWCCPzO3CVlM9mp+rjUwpn
 ILpkXBcYKC1syywDs3on6ZPrfj+TvZyUFgAX3mk0frZurpfoDEMWPW7NWdYRdIG9nBA7OTpc0CV
 Qs4GpORMsxjyT+Q5CzZ6UXYDobUPpygGytSGDjG12N2l0vwzXJgzlr4p2ufDYUXtmsxSBIBt2+b
 M+cTASdi1sNFilSxp9JJnG2IBBkrx6AAgl+2YJfhs0sSYkP8oFOyh5gGM4tBMdmZyiy1/SD2i2D
 iNUFIKkxyQ0oleAAMkeOiqpn/9gvUi/5vS6DL7Rr8wCDqLs3CEtyLZK2pI49Buvq1iZkC83FTUy
 ouFVuaTWK8ou07aoFcg==
X-Proofpoint-ORIG-GUID: CBfeBlyrOMm4qt_xXyIUX6LbJuyWB5Ai
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a61f4ee cx=c_pps
 a=T1Ebi/dL4O4Qy7Yf5tf31Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2vpyfyhlguDYHLkT4YcA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXx+OqXGM0rpj/
 r1BMjklEtl16eY7fE/BCP1fbkuQtpPj9VBnXSOHT1873GQglD6GjJpkFcKpqnGD8Cz/OFccIumu
 fZeNEU0V9Dp+B64TZ9pro9sI/xNcKR4=
X-Proofpoint-GUID: CBfeBlyrOMm4qt_xXyIUX6LbJuyWB5Ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..f8e266372367 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -457,6 +457,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1274,29 +1296,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1

