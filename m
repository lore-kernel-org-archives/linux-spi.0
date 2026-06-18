Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC23CF211;
	Thu, 18 Jun 2026 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768294; cv=fail; b=Aa2uzsWHsG781WG32rLQ+stW2Rj4BR8L5CYMydiAlaD1gL6RK3+dm3fDBF0la0xWyOPhkbf4csx6OId436B2KMGDXel19wA7u8kpK6i2OH0KORRg1SKbo4UPvw+tmJmQqh7Gwd3LprxYp2bmM7JNb/LXzyr9mZgSLNJuP93dgzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768294; c=relaxed/simple;
	bh=LMtmo/WUC/A+I0HJKJTAB8R9eaHOE9iaISmxs8HTIpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msb0zHH1hCQzwhkid3oIsACuYvDcMwcq8AjNpI6lERaUeZ3Ld7B+8oYtaMGrCE6eR+FJ2VS2I00Z0eM8VndLodXP7QMPO0JVuIsfrN6tKfLIJBWzv/6Q704FoXmSDR0DZc+hi41hr0ry6bAZVdPpsRnjgcLSSCRdOnUo0n2jYbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aWQ+eU8z; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VfcQTaGX; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aWQ+eU8z";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VfcQTaGX"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7UQ3k1333596;
	Thu, 18 Jun 2026 02:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Y15+UpW9VPN/huHKTZPkcM1Y2nWfTKcuRilnh9JM6
	0g=; b=aWQ+eU8zUA6NrxzoRIq2db5yR55v1iRRpCcDzjIBMmrKWTA/kVt59utza
	BtASNPA35TxEgEVzfT9uUdY6cWncgv1hcNFLyCb+WqSmIOJ962wvb8NDa8LzRXo0
	g25sJJmDsy0XZp6xdRf8IMxvIeaoe0SMBLwk6Gn3p72kyQ4x9LsE8Oo5fF0icxqs
	5d4ribbvwzklBJjRFXihEsBf8Syf7TEf89wJQloKgiHMMJfly/Yca82eQqU1Amwx
	xlfMG9nwZCA4hH7SbAdnTFnPiRDkTZLJtAxNriItGQRRZ6kiZe8KSUxFinQOFa60
	XyxQNkXX+wsYpwDCZTz0EKq5tOHhQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eutvept2h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T40PIVITm+iBxZUrLCXOHIhFMLqhieGDw+o5mJOi/yKwUGIn1ZlF4gJCKdZl0IoHozzlhd22AjFjc3LfDUC6S+ir1ti1QGUopgGyhDBSnFDlg850eb3IePvGpnF5mzjN8PMXDnmtrzUJ+V0EjEy3s3vR31uMADrxS16LsfHtG4ROBaK1Hnukqmvrpokg4Ykwjmv4TnhioVEpxwKr0m7pAilS0jJT/kWQ8hl9iyiVctBaPIgKLKI/vh+EkWh5PlZgB/mIukSrizulQQNVQtSVJKlZYMvCI0BhFQLMoofdN/681SZ1WrYeTID5M+CuhnTLIs6uMR0gAutbWp9u0vShqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y15+UpW9VPN/huHKTZPkcM1Y2nWfTKcuRilnh9JM60g=;
 b=RTY9UFvpo4zttDgVAONg7X96JO+X8kb2A8Jv5sZYVP+cDOfjIhq+rDu8hrC/haDmVXE/7tdu2QdfQ91waOEV/MQtVy+e9ZSVJ/CDjrstkU2WrTkzFSeQhh3mxDY5QI+bIZ/075G2orY+NPPMoBTVMcxW2+Hu8uux7WqiO7EAovEdEt6t5BikVw86X63hwivfHjNEAQZWXUy2JakW8JstWstRMiCeES3Li+L4H4tDMrRKbJ3ieJd9pB3GJsBMivDCdLVSbPpvWnhWRhz+mjkfOI3RkQKKOv3KcR6yCo/7ZyozMc14tdZl2st7G/30b+Mkw30T4tlO63zsExkbFqBmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y15+UpW9VPN/huHKTZPkcM1Y2nWfTKcuRilnh9JM60g=;
 b=VfcQTaGXTbXLK8EeKfZmOY0Yn7Znya2JJMckb+NhbyGxH3tgKrMQnYoxbBbPTCQ8m7V8idjlni62Fa2DHeF9KM1daX/BV0EILoq+bQoR0job1gXTfj21PV50riwLRGEgu2+c8I+gsw4oElHSpFOmNZ64X7qymYvzx333mwwofbs=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by IA1PR10MB6760.namprd10.prod.outlook.com (2603:10b6:208:42c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:37:59 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::a9) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Thu, 18
 Jun 2026 07:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:37:59 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:55 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:37:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:37:55 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYve3521710;
	Thu, 18 Jun 2026 02:37:50 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 03/16] spi: parse spi-max-post-config-frequency into post_config_max_speed_hz
Date: Thu, 18 Jun 2026 13:07:12 +0530
Message-ID: <20260618073725.84733-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR10MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: c27673c0-e7ce-4316-5b9a-08decd0c8578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|921020|6133799003|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VUtLE1Kc2dvvUcPbc56Smpe3yD40yiT7G486IEihSsDt8Uapda/01C9S8EZIMRIQMGRdZfrc7fyc3zxBxbf0amT31/EnYtwnpitVQgluRMbscq8Arjv5LKpTPgkhAwOdVXvy+g9Eu5aCb8PuC3kTK8Iu5nJdEMW89+3Y2LjVcNBkKLZdaQyYrrf9l32jWkgX0FoMpca7/JjE0I8oop5hgHdBiJF9bS+HL36HQ7JHX9SkKZSulQpPZAMhMnJ+vhXmW6TnGkwjveR33mG2BZL15K7x/X7DpY4bp5A9d9+Kroz4Iiv/730kk5ocZUmjjtwZHMBsyBoyvh/X1bCrWEXknHqR1MvxQWxa0g0g2UlIo2Nd/jOU2tX9aLTaDcRmzQCXn+FESfSWyQh14ACGyFbzoNgityHDUuC7bzrIzv7Y93CFuPq+Yru3voZKQSwVtQ0DGAMTlRAdscWOeFvSByAT8GOQ9rUwD3XYM+njutylfRDt6vmd5JHg74uSjy3SGirmel5gHAGjyCp62Ze2wbeZ3x3BB2fcb46drLc+PeMLAVnX6Yu6Eo924docTpts2uVVytHUbqNdCYCRPK6Q8EJOnqPuj3cirRrc9s63aO9LyLRaL9fKIqUdgHN1yDPJX0LWNWahbml1qjcnSh6BzIkzidVlXFQUm8DkXDNFfvd38gHtWXnSjwNZQ1gX+JgpEm+Dtw0nHT/1D05+UW5TwdfsuYw9pJ06gwQECIbW849VRFY0iFY2lsFqJ53I+j4NgRsBW2aBKG69xvAXI1qG4lko9g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ENQWRjYqa+68PIlmyRVwrwyN62227SviaSO6L4DwysdtKXVuW6J4KP9P2rB2KxesdikgxwHt3PREt2bZEQRBcVWi2Q7IwPcyG9d+FVQu9orcES9suKz7pdMpeC62gPF6AF8qErWAotz1REcNZRuKsvUerQgyPvBvPs10OLQxJGgFUCySSCYX/y16+VlEqsOh7aA8G4ofr0VZ5YvVfb2wXUXNMo7SEvwhvvZ9zHwpcNHhZH4bL6867Mf2P7nDZUWy3G5Fg/ev2d+Kt+heXPm4jCGF9oxLyC8vt+kxqXkBxcdESIKXnPQi2haYV7v69RyJCe8eTbEirYd6OU7hBbemS77Os1+TIzlzDq15njHHwHNKTRK82bA5izkKZSeF6jTuUhHPz1O2XoCUf9rCOakiyBl8v40C6W0eG/dC3fgs4IZwdcmGf+B5iv+O2DT4jq6e
X-Exchange-RoutingPolicyChecked:
	eAel2wQ6gSCzAJW+VEBJ31X2aH8UfxjF31DflndcDxtSTN4FeVOZ1RUucsu3J3OHF9/qrHvLYbu+jJqqe0MQtfyWTZcmQSmQp1bKhlriRqNXuOmdzhE3R8dWMEMyTSsYHcrgAhJvY5AUkkBQoLaSKHNagbVFAib7E2Gj1i0pnAdPftpQMPQmO91VKGB+djftzFfrM39VT9AkzHuo546akeyT8YFxMn9clsOV1vcD4RpBIXN4ZqF+x4J4807xfEbzD0FtKQI6DF0qkvH4fIfrOe7WPDPB2W5IrzXYt3W+2t24+DiNN9QMSEsVqGrD55+nu0crQwtdU3ycHWcYADQpQA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:37:59.4773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27673c0-e7ce-4316-5b9a-08decd0c8578
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6760
X-Authority-Analysis: v=2.4 cv=PtOjqQM3 c=1 sm=1 tr=0 ts=6a33a05b cx=c_pps
 a=333l4QiDdYhx7c8CB7C9lg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=2Gi1gDZmOG9PIfG5304A:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: I7zLsRuj4AJv9-xeedLwf_2y4Pt_3TdG
X-Proofpoint-ORIG-GUID: I7zLsRuj4AJv9-xeedLwf_2y4Pt_3TdG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfX1eFNfg2ckMHx
 vTjJlR02YGQAr7SWV6U9Fc+p616juwwo8GeWVMx0JknUMArjWNACB9Sv5z2/PkJIiRVNXS/Vfbf
 vF3/si1S7PCeR0pSzpWlNnecR/ikTfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OCBTYWx0ZWRfXw1pN/dHV0HhT
 8px5eH37oi10EB4l7rDXXuoBF0Sy4eLK5cAphu8gpbo6bw5kYfiXKMuF3lMdDI9QVm82qJLRW8I
 rmED8FcoUGKqLhNji0m3nnZHvdOenwwHMBVsePuiXql63msYhL8dYVJQ4GuTumqV+FzFD090c5o
 umVGs1iUHYK+f3nR+CRpYyuXRFeGfAbh2XxHYd673CLaVOPfLfc3rW9TWrVL0W7Iij6lzE1OZ5g
 qPtrIp/bu0JQLybZ4+FgcQjwjkGmesUaUug/rJ4c8zBZEm9I8rBO/9yi3ujPAO195OpSOuqhysb
 /L5JVyNZtnvBFyaQGzX8unsCarJnzGaottLBkBAACdN1JxZDRmG8o6mul4o6fywkVxEGpBZyPhJ
 LNsKt7TnZxL5C2h+oM7mW3oFOprdv4kuOwdrFnYAwFwC1LjBAp4vSHoQ7IEgfnqm0MVHUDPXpGs
 P91c+tf4HT4+Ipkfd/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180068

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 76e3563c523f..36951ab47a2f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2599,6 +2599,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f6ed93eff00b..2d90ec91450a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -139,6 +139,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -191,6 +193,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

