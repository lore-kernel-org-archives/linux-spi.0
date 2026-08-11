Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761E396567;
	Tue, 11 Aug 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473299; cv=fail; b=J3DU2CmMo9DnFho6Np5C0yXqpO2SEKG1cM97HfNcyCZWz+iKo0fBO/Z0xeVxgZzIzW0+Ycubq9+eUq/kUGBZNVkk6RGzwSrfH5oYR/QyditPIa4Lfq1xPmAByJtQlKfDPEtvY2QwVP8gsX92/rsAe5TC+KtYlgGAgJeY1hm2C7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473299; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH3S6ueuFID8m9WHERoCCQMPLLLnO9XfXECZ9JZCaDcf/YXmdj+KAz9nAWcbpb+vHY6bgWb5cKZOGD1zhARpDqfEMnC0sABRPQcO7F7oziicNAgla3rFwgPOnKHTzd/djs2/KUIAVteaTHAkbGsa2BrSbw7ADHZZI+k2vPwYZMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VHY4cyro; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JD89VWsh; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VHY4cyro";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JD89VWsh"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGM8f31823866;
	Tue, 11 Aug 2026 13:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=VHY4cyrolfSBHXaa7mzyJuvh+Z7kON18owhWHqC7CBRRRs5FA4s9gJ0jP
	ebbJYNfvu3BdynhGGaMADf/+oXYmRTC7qeNqjmy8hQyJPRO207Go1gJXyHS9rZQb
	YvZfecuwQsDCZ8JmHrM75MJU3UN89o/DkHDkSOlAoo5Eu0IVX7u+7aavE+3B49gl
	QQnabeNXcxLmc/WLVxUh2GtchAjPeURCXs0PqqvWwoAjP8ayR5R4KY+jGbI51gkl
	uZO/BvGplFGkX8G9yd0z4ApqlcEtwvPk2i0YL3FYRbmWzfrswVLEn0tvYJ9+NKxb
	1eRdZFbgbGdBa/gqVZ4g23NcPkguQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00wnbk9c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moIhtydSMvYEjKr1Azt9LxPAVyoiUd4Oqc0XbWFDPLBDe0DDsNwVUP67I+pep3OgCOLpbXxvU+YJ0QfUXYpm58K5y9ru3jxnBY3Lq6nsQowAtUgjWuNuiYyPk04aWZ6Ert1lrqT1cy5wfzsNawH5Ec3KjgVnFZCzlr0iBFB9B7R2he3iCpmCMZyu7FuTOsJPFq0lcCwYHPUBmo+XuYdVJYmMiKWbtyX3goi/RJdzDZz9vd7xgw2SbY5ShSzLqpOoDVJSN646EHWF5/S5lnnCGz72eg0Rd+XuFcmnCjNTq/dQkDB4rQUGF1gd3s9DsrRCDKFQTJ/pJKgIVL+0i/qBcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=V0M/7qMrIu78rt/ljOyWnmNnICRXQeWDDYaHNvYWcua8MRnAG1IRLSQjYJZalSoQrgvzkXZ4EFwFPq8A5qDIb/XXjYXjYY16y1kxXXtN5NQl+TNSLpqARS0yfgS/pXeh+jH518QiHvCkXWyoaTRykONNYalrnbjeBLe83uG29QNgTsKPc312nZ3V9DddsT08PulTiZaaNv91oMKSdf0XydpT731Xr/hnVInEt2+OG/2oPpurriVZfBtc9ztPfRg7rQj6TvcjhyPH9J4+oD8mckYQhqYIyU0di70ZC2lHmZHeI/9JqawWjZ6MLcJ9PosqYX9VwQMGKU23vNIGKfbo1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=JD89VWshsDXoeRea5HaEZRrPz9nmQAuKTrfvfzf9seZsTz+BA6b3Onw5TGNbmYMiipBiI57uylwiW2ylKEhSHT59uIs4xUBWDOlK39CkfMHW3Crm4+cuvEc0KmVKjeyFQnpBI9l2WVubQAFZj5eTX6vaxDl/ecba1Ay3q8VDyGs=
Received: from CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::18)
 by DM6PR10MB4265.namprd10.prod.outlook.com (2603:10b6:5:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:34:36 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::8f) by CH0P223CA0014.outlook.office365.com
 (2603:10b6:610:116::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 18:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:34 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:33:58 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:33:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 13:33:58 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIdx659766;
	Tue, 11 Aug 2026 13:33:54 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 07/18] spi: cadence-quadspi: add DQS support to read data capture
Date: Wed, 12 Aug 2026 00:03:02 +0530
Message-ID: <20260811183313.1550425-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM6PR10MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a12d71-28f5-4235-fccc-08def7d730e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|921020|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xVPWXlqZQskH2y933cwuUawTGodfeQunG5pSAR93PoZFYPZXJhmPOx5y5i058H9QCigjYaVmH1y+QQRNpTqO0fmaCTX1WDgsI0w5t0biWmw91j0wo/LIhCVkDuJX+lQS+SRQ0tpVez2yw3puetnzodbeXBRut9BkDqk+BMpXWvVUlcKa0ZH4MFkk/uqg6x7vK7+UpL6sHkJIkmXFN879O0cKIjkGU+WvrSxjxpk67qO1sA5RyeUhopFwvtBB+QlrXIJ/nDfzIjqvg+YNpKreyrCeblaaUao80aAqs71lj0gMoIhWUe+89NnGEhPKTXae96xsCWp6Jb8iqex9/IubSPUj2koZlsgR0/Q8OHubO8AOaff9aCAtb2AKWUTkzMev+g7e4gfensDqAeoQR6OvaOQQJgxKKOQdmFa9EsOh2abx1UzyfFAnEbeHxtYjbspCVYXsfN4/iwLWrcITCYL9rJF/7UxLkFQ0NVhb1YKse8jixkGgjEb8DYMlQbXlEPeCwYO21SskwDIP8tMSy963IQKjDit1DL2IIVPnktUyFV+yaCMxzXMGmWdJbxXvgE4XYYpRsMGhwgAbFCLYnbhW8inZPHayLtPHoey7jqgyDVs/oEHuUlEQmfzk5NdXWx5qyLGWMbj5+/Vpr0V4+gGxfqXH+UOAIG6/QW4YRePLgib+VB6pkeiI7gHwqONsE+tQjFa6KT8IWwggu+vEMUOU24aErrJh0XYcM0KyHJmuzX7iYTOWykUCieNuEVW5Yquv
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wZ/V3TDNAfDy4PEpYJhJS2htczFGjVHDnnJFJwyAdmP23sOkfKgH5Wj5mM7GDaBL3SF14q7UV/IevwZWpfXfL/5rF+3UBvebNVsFBJXgWIeve14EOYXbz2CJKvTRbbm4T6h2hXk8RUyzm3dv+4dS3mISFK0JvrFE/kbr1Jp6klaLyN9ArKR7GuMDHozsjt9TGy16YGq0XhMQW3I2fas6xhh3dzg6cCD+BQa2Gc7LCDj3NFfl2V5zHnOVvgX58+4mp6EsJ7TXCuAyOgadlNuzg4Xb6IojbSdHUpsZOHQrqlLvxRWGvmGR3T6FkmittJiREL+PKoMZ/Dtm7nbG03JJA6Zgy2Xv+JYQ4Y7G2ZpCNFFRBlOLLjiF93bgJIYodc1KhGs1Q9afYSZzKbGRvQvGt7Ch6b+iw+Eeqdc6bALoueNeYeAFB8/xzoppSGTHhTLn
X-Exchange-RoutingPolicyChecked:
	OLNBDx17EOAGGUxL57WoRUZ6slBDW9nIM8PWwqudHWFKKOMbYB8KXNGdC6MZuLJ40cwa2J8pI+terOtd/hb9TouS8E7GSf/3gn05F5UBtFs1QwT72nPHFYolDI24oxa0OwKpxGdHL0YNuL0b8NAB3RAI+Zk4S/5+LZDpC8tMOkF6vPyODaKIWow8OZSjkijYbR4os8uqNi4fZjWXz7oCcvywaRANX3SghZIrGtarpmWISwXwvUrs8Lv5khCPGVjosuiZmLo3K719tdKlM+PT2YPS4GvWOKt2AD6LfU0AydX2VgA3wiE/effl5MCLOuJqcN7TJBuR6S+/bPz8Z/YnOQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:34.2706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a12d71-28f5-4235-fccc-08def7d730e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4265
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX0PjPtHS8Gl04
 exRnOz0Nk7V0sQLTtL4A1/jTQACpeUPi+onmTyiwLFO1F+0Is9RX4eUihC47/Kx0caZ1FoNE/8L
 Othyn7bA0Dei/o/SnVjSAHMAe8h6Ss4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX5PWwU9okWjm3
 v+AY3d9a8dGCoHmMBrSOPveO8YSVEJU3QNG2JDAR19FmfZ8zTfqVjxQoGe8kGZ8J5uFEioBzhFC
 k7XpOrTuOceeG9OgZwMt/2/q/K7WzO+ZAXHkkSc+8k6HvQWjluW60dtf44gCZkUMbbJO5OktFSY
 ngdwkl/6RKBYjOwz3/+7KUm7QX5gOAftQqdAfP8UBXTCy16mhecqAZ3T7ESnSEDUM8UiOaQJ8Eq
 FzAP/kYFj0qTQ07k5/DJNMFf1/TF2VXwLwCUYNp03Fz4k/jaNQR22lnJoKsKObK8ln9IwmoG8uQ
 7Ut+ynbJOugyg7cpbst4OBlpkRnB9Ttpm40cw7doP3XrUaGckW0rQyA3/wv3JH8L/iOQ7ZqlTUO
 O7/lkffowQIkxoiJ6RHvdDS+ITtun6i1gd+MQsEEYWbWb+S6WqrqbHXd4lv+3kYmB7btMrkSUtF
 fdruT+njGLZFmaykeoQ==
X-Proofpoint-GUID: BvvbCXM6H_EJSCeGNI69P3dZCFna6whP
X-Authority-Analysis: v=2.4 cv=cYziaHDM c=1 sm=1 tr=0 ts=6a7b6b47 cx=c_pps
 a=kBTuJkHEWKOaoYTOH1TR3A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=by1YfaDFVIW1-MDklf4A:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: BvvbCXM6H_EJSCeGNI69P3dZCFna6whP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f8e266372367..046fa5d69b0f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -458,7 +459,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -476,6 +477,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1317,7 +1323,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

