Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4B376A19;
	Fri, 21 Aug 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312985; cv=fail; b=jNDn9nEGuUM17/42UHMcRjvlWnmZUlIFpL/OKgkxR0A+ipMo2lMUjiK8yX/0nphGQ10A/ktdMobJfi2Q/v/Jn81hnOQ8K1nqpP0Mf1hpNdQyNTC9s6JtYcsCodapwkEKdmgXZ7p4VCz0Y5hQ1jNGj72OoJrrBeHjacOhTYpaOiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312985; c=relaxed/simple;
	bh=jWsZQ8OrcqpFqX4dCEKZbtqhz7uNq3Qk8YJy2FkPPYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJhEqu4J7iITD2Rab3vDi8QCoMrcPkT1GwIyD+tDbxYMKRpiN7mVxmLuW+mqug2rZB9vznA1c62bwvQ8kmQeCpqHtMf9bhol5VXEZTDaNuQ8Y3oEiA+s6b94YW+U02FUhS5I69A0azqw2AigzkZgPasY2QkU8fCXBB58XEpTwKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ADRqtyBO; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nf1cblEU; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ADRqtyBO";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nf1cblEU"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KRtn2887015;
	Fri, 21 Aug 2026 06:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlC
	So=; b=ADRqtyBO876YlWVkNJ79gQXsHAp3BrCDYt+S0KbbigaLAe8q4KwdEql1B
	8ySfnHBZQuyckfRzQRoalxYp6aQmv9pMHVVhnDtjbAR+Zp6qO169ZX4T9dd7/eOf
	5sbuMiZcXVqoKqmvoX3UxxefGLgGi3eMwAp4P+WrV/VAYTe6vkGUcJg/v9Z+E3bx
	r9fxLHxCTFpT8xxAQEufFDd2TMFMp4vWZO2tA61HYiWGihjtDbRlu6ZU+6J5vYfw
	u/QCV3T2pQsIkJ6g/gmHrVup5FjcUAyNoNQxquR824ZtX81G2oz7XDNgFNWtnGs3
	pOtUHHWgq/eG3vztUt1kkVO0WiNaQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g6gke1mhq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuf6iKaB0XWPt9CEFV55q59wmoGxENH/+8UgW3xsS8Ue2kFLuf8pghEfV0+Bd2gxGKxGiXk1bjetGl/XBGVbmzjz8TrkoCtoXknMhpLT59ZRN6T2cH78QcDlidZvE31M6VQlT5F1CyQDdzr2Lpdbd33ThTIipGWxa4h0FpkVHqp4zK5BV+l8jGDN+TeG/uaI6Kxmrg/uoGz0FsylCyfH0NRDRby+yU/nqjgqu6rt1u+FvbVMNRlXYTAnkDFatDPHb1b7l7GIfEQmxMJdCZAouPGE8+cShkEA+RMyY46rNbSbFb/A7Y/RhJmzhU6dbWSe8OLGUNHpfEiWNGOLpn7dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlCSo=;
 b=phou3BQLkknoDg8+6Fmr0WmGdYCEHfxtR3JnI0jXQVLPrzaZZlRqVZGjT3RRhxyhp1ppR7nfHoPFZiCSE0ryPerIjDuzOie0ZC+vZ/uL3CG4PdvWPHJmtDpv8neIH814ZzcOzfqOS0qBnz83AXO4q+R3JbEbJg2v+7bkaAw5/lzulSNTaEgOlfv0JOmM2AdrDLLd8qZn1PFKF+uq0i2eguE2SGQrjsm7tj24T6//S41GRFC6ddcsU1188P5aAAclGetYpxp8QXFUOex3CMgWRLbUZBSDteWLxMwBF4t6M/ukA4U9+kNNCJltvMWHpHGqbA0dYW+xPzMxUYosPvcerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIKfefqLLNKtwN3tukdkBIjsxtF9B5GgFsNKrzvlCSo=;
 b=Nf1cblEUXBbj1UWzGc3iR8inuSKm8T49p+HKhHbC7HYbI19M1fMvF97Vbk4bafdHpgMwaSa9EokPXpnD5dfzCHum3F1nRRyAkTk7pMuf/KhY3xrfTD5QT9LYOp/jFlfOLU2GtAdDy1DWAdpMnKQbI+c70gNMenFNxBUKqL4dl5s=
Received: from BN1PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:e1::12)
 by SN7PR10MB6288.namprd10.prod.outlook.com (2603:10b6:806:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 21 Aug
 2026 11:49:29 +0000
Received: from LV8PEPF0000005A.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::ac) by BN1PR12CA0007.outlook.office365.com
 (2603:10b6:408:e1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005A.mail.protection.outlook.com (10.167.245.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:27 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:04 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:04 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlg2022942;
	Fri, 21 Aug 2026 06:48:59 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Fri, 21 Aug 2026 17:18:09 +0530
Message-ID: <20260821114822.4040338-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005A:EE_|SN7PR10MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb77eba-aeff-4bb4-7aad-08deff7a40ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|36860700016|1800799024|376014|82310400026|56012099006|921020|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ammip5y93WrBxfw5ilMkGreNgoFP8naCqiOiXjZ5xpzTj4soJhEDZc3h+nidmUoemdhlORCwhCzLGvm88+IF5w34FkZsIULJRRaT2hfmITjwGlkbKHEXVmwC+q53L8aT3Pnt5u34pGtUT1hpGHUdX2O0wwlhv2Zud7eXEcl60njAyp67HbFb/Ck9J3mbxnuvtlIxRO887Vq/5K6vmt+w1iOAXw2+p91H7c/TQMLKyfOK0N92zjAUkbKA4mwhpqqEnqSgsBvzJHUxIhxXdVfRCxf6cASXYYQGRAnt3ZPg9wjijuMUpMSyJM/+zQbx62N5l1hbwLMPhNxU4+10zfC9vjHpbpWKmbrMIocVDg9WfezN0T5MZbTmb+PMKcijqS2AwAquAtPNL7Cz0dniW1Lfz+eznxy30lYOfF6TcE2c7wMOxEZtQdJl2YjSZ2NAFaUPbWAeq2MvP3Y1n4DDqv02icPpWUtxcPHB+rRev02g4HPy8nz+8LutyDrtvGJDEDlid26xcHxbHHaiqKiLyJlJJecsQxxNMf1/dVriL6xktj60O2CUlnVE/UkBL+TwmeCb1JIiOwxtW5Vy6ExRJ1S35CgBR6b26OtMvO5ishKd1KGPl9vpqenpp/VoroqLmRKnfQnfubGM17bx+gnXQeHV86jIPbI4Vfe9h4GZuqDhOJ+owp26skevCxbMoBWFNTo6UGMR7GInygbqK19yi4sOqpTC8Eorc7ZiB4ZMM+XHg0voytXPM0QqqSwn+n6E8E1p
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(921020)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vbhnyxbFS0U2Cdw3XwyMXSBstX/vXumUfQPLYzDwdod0qjMnCI8k32YWIdZT1ZfQmtQPdwpMHggjts+2+ZaY2nigpZM8spdE4DcYHaJ6Oj1r0jOACPKNMoYYuOM6q6IrYxrb7GkEwpMu4VN344x/4iISlg6gOOLb0wZUuZ4TPDpztRYmZVVqbGw3omXI8XQAZa0sSDn+KfbOScvSt290hndtpYyDIIeBosoFXQbkZgH1hk5TuMiP3uGQX6DrCTBSk+cZcxvHt17E96uyF8h0XidilcVwLEYFoR4pkcGqXdHs89k7z0EF1tNLgWqL3GItu66XKGG1MAWtG0Qr1JJ8tj/FQZYGvE7e9104/ahoEmL65CTpdu0LDuamTKt9CklY2xgmIkTNqz5fPiXKCCCGOPMKMsRSJgRxDyk6bUp5AHCN5Qs5ysWrv79Dfj6e38F7
X-Exchange-RoutingPolicyChecked:
	TdrzTPJrW0SdpBnbuyRHFl7zZ5cD4RLVmiyzq/+00+bDL6YR7Ulyts5XUSH1rbTgoR1r9l14jzwQoSuOyYQfqle9NKi7O1ED6iYojMW1TWJT/kgFX8Zi8WbGmRQHshKRhTCGi+1K0ubeZ7E3NdF5QCOSde1fuFJXX4piPiNUu+ybyMC0FwUZflggM7rsmRWOCTukySoKS5E1cKCR8pXySlpwBDkmqq8kzch/nXchRTne2yZz+uauoE07tQfVM9STgbO79Ch5fMXK/fVzC1yo1gdkbQu8/MTzPLntglrcKEQo9CYfNhdc9F0jDfCakONTtbJxAwKo8a3uDr9URlCgVQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:27.2326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb77eba-aeff-4bb4-7aad-08deff7a40ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6288
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX4EwpSzYp1yKd
 NBGcOYcue+VtolMIp6x/YM4uRlVYQ3iGgBytNtUYTst4QmYcWUrgu0+1NtlCwoYlBhG84o2Ywi3
 Nj185iHf05h1Df3K+a82YIvaY58kdn4=
X-Proofpoint-GUID: yqnn4_HszUHF5xRs1TqjRVSMnvpbeh6_
X-Authority-Analysis: v=2.4 cv=Fp41OWrq c=1 sm=1 tr=0 ts=6a883b4c cx=c_pps
 a=nYaA4L0hYP7ZHAKl0WLIGg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=XczTfz52Gg2yNcvB9tIA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: yqnn4_HszUHF5xRs1TqjRVSMnvpbeh6_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXwfv0B/MYUnFk
 jWeXkkCqCIRqtdaNOD58vhBapRke7cDVdphDDwp9R6edKmUkzlaY/nMQSx8/f2wcaPZRQA0iMHq
 HirtMU0r7UUQ8TmjOmngLfVMcEhFs8DWq59wh9IPF3O5E1swI5zLy4GAMxJYZ00twbddv6J7Kq2
 gaGAv1SQ3M/aHmi1PMk+vtPw4Li1ULkwHfQhqpcpJE7u6dqAI/m+oWk9LWTQZRMJfbF0e4TdRR3
 vcaIKwEglxXLlrk8D2MSRAqwyo2e/F775UH/q1RNJ8uDY75sakdA7YbL746rgIN8R4xCUZ03MU7
 H0jwcqACjQQTjkCYpnznL9Xtept26XlnRukhxqvWDW9WnCRExY0OQYcWIZq88qNskA9ia6a2xjt
 a3Ai5zxqPT3YBu7BF6JPocqESsbjgGF6yijSrsjeE4caApAdneSEVLTLOgPTL9nIdmzdiCof8uH
 OnioAsNmfw4l6/eu01w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate. A callback return of 0 with
max_freq left at zero signals that this specific op variant cannot be
PHY-tuned (e.g. a hardware erratum blocks it), allowing the caller to
try a different variant without treating it as a hard error.

Add the corresponding spi_mem_execute_tuning() wrapper. Like other
mem_ops paths it serialises access with spi_mem_access_start/end for
serialisation and runtime PM, and rejects GPIO CS configurations which
cannot support hardware-level tuning.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cd4bc4c914e7..79e89de1ce8d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -693,6 +693,49 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if the controller doesn't support tuning,
+ *         or a negative error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+	int ret;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	if (spi_get_csgpiod(mem->spi, 0))
+		return -EOPNOTSUPP;
+
+	ret = spi_mem_access_start(mem);
+	if (ret)
+		return ret;
+
+	ret = ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+
+	spi_mem_access_end(mem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..b69f671c40e7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -348,6 +348,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -378,6 +387,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -469,6 +480,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

