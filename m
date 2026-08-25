Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3C37CD2C;
	Tue, 25 Aug 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678342; cv=fail; b=XIc6Xaw7ahxUjLKx5SkocASyTkE6EsRRR/NIv4XyEbP3kvblNRSLp/uvUIx7cIWzt96F/EC/kIfBkhsRvsEXphOMH99iQf/Uajj/nUyvCz6C4BVgyAgrQUpC+btGhZYJR7Hwtzwt3v1cAgTuEwWPITIKnDPbzYO8Z6kglyhmDj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678342; c=relaxed/simple;
	bh=bK36dcmI9LM2Zo2CmHrCSD9+IDm/OlfxjIURelHEDek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFHSFqBJio5+lhpONfWkOLmmeLNdPPB+j9IkuSEGgLpXHV4frua03GA9Qjgjc1nWeEELekGLmJt360DdGU6cn8BTpwr4bthzKDfByyrHU7orr33igJsJu12NL0sF5LV5vuJvBXQ/q85Qh2WtICyfpEcB5zgyyR0z2QRYJ3P7QwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=F0iJAxhM; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lI2X8u+k; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="F0iJAxhM";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lI2X8u+k"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVbku2046020;
	Tue, 25 Aug 2026 12:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StE
	xc=; b=F0iJAxhMzu1P3DOTDw4UURSQQ2O3uPqDMVB96aQs7Tnumq30jMSsglnwh
	EAQR4h+e/XvgrIRZ0yQnQxXmoFKd+b78zwQNpu7cfTA9ecPxBWm1rL+6JKfcLR9W
	M9Hn+tZKP/wuRrUsQPBeoOuqWos+5yCWEHzBEF7W5FsCFFK3m360BgnSM+BXoWC8
	hr5jCStpnoy/3sT/nYVUiA+q+ni5U42bpUWKR5dxMpWDTQ4pPh/X6pt3GpZ4Vrmv
	2AGhaEeFF/g35CuJpkt5AoAmrA0nhOvvACmq8B3i9wmwxRVm2vscc6z8tqi6wxUp
	IbIhl2Z8LxpT0C5ZqMeWxWAFjgJVg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnm9cw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfwdzbAk7kj5Fu17ph3XCddFxlIhBcHujOe1Qiwr/SzKJZO8Ds7HT1DxzVg4u9LJ2iJ6Ef4QFJ4uRbJ9nTyrtZD5TKidnkDPhfNyo7FaQ6ixiEg8tFwxzKE8yasPx6nsBL1pzyXcoGPVxuBO6Ql3MqGcrM/5EhYnV7yXhU6JcCVDTyrnQNGmL/joZtZTgAmoz4N91tCiB5spZaiEfG1Rd2hJLDCxzL7XW3W+1tMguNEBsVWhVBFkV2qCQQc+GMfX7Yw45NZOe/lRQJaI4r8O0UnK3RShIRzz2yaRWPXd6FiI64c4E/6S4mmpL+2erIIq7CaN9VBQuYaCJKwK4ZZqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StExc=;
 b=sCLeza9W4RYuTd8Vcrpt9gxTG7Gdwrai1a1XQ9IkrCdDpmclPG/AVe6qxBWi6C5QSSvOv+6qQ8ZuL0UwhTzYcphPzfdOZpa3kxddlUZo4UPCyLq1agIKBVnXZgz5Jlj1mIt+sdld7dH6mGfkHDjBxkkdEPkKkSAGB7SnBOxNJJI0iDpvTXu99AqHDP9AlCOvXZO2oTtBfBUQAJGE7qSl3maoAGP9freNEHCM6Ew2d8G0AJSbVtAODhVe2B8gRi4/ZcbTs2yoBTDocHYtodOMBcegBVe2juHSLWCA2tZK3xfSMYt2xm4K627bazU/ZiEXwCrI1TBkGi930YyPuTwa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKqYmG2fJOgXyuuCdu+UOY3ZnmCqqn9zeCJ1M8StExc=;
 b=lI2X8u+kAx5t4BQlSiYlbAggsHyL3GFc19DfeuxVsxVVqCx0CW3jxa/gP6D9hUPx9HOB4ejpqdwDko0riccxw5f+QwW7PeHxr0hQOVmtB1qJkyX+yibw8OyiZSPtVQ6K9i7yfqmu7XnVRBOuu+NbVO4gV8S8BG1rwR/bhqV2lrw=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by DM3PPFC0AC38E58.namprd10.prod.outlook.com (2603:10b6:f:fc00::c47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:18:34 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::16) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:33 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:10 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:10 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3T1436664;
	Tue, 25 Aug 2026 12:18:04 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
Date: Tue, 25 Aug 2026 22:47:23 +0530
Message-ID: <20260825171737.776052-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DM3PPFC0AC38E58:EE_
X-MS-Office365-Filtering-Correlation-Id: 194559d0-c528-4bca-f990-08df02cce443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|7416014|10067099003|6133799003|18002099003|22082099003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	XNZ1CcILC2zD7T/wzqhTaYGOWBwKcde/RyvGEAgPu3QsflXHYQrrqcn+rsVbmSSpojTT/OK7DEvZ77sXlFiJy8RF69CtqHO3JdZt8iLJhOgD+b5IIi+fQKxvPZ6spmUQLf8Sl3EY1s7qCZIsAHB4LeHPxT+jgSDWV4luDpB+VBA9pEE2ElZjHog80dF4ADzjks8EU2VO5yqr3/sUD3dkJk+h6l82mF6ntKKiyzxfyqYhNw5MYmHoThTUqwzJBsOw3ueFR9nFD3CIpmkWTuPn8KYtii77zLnu79TheA8jZ6gRj3yivqA1Wz3zZ3u1R6DdH7d0S7W69qu98Y9wOK5+l7DnUyFv2a+OcAqtR7Vr+wqnLbhsCXHYIyP25XH642DVXr5bMBribGdEEfFSHzWFu2AcjWnyDdWnvuPkSW8DzxOUNTGALGPn0pOa+aV/084UlMhSDdypKIpMuA4zMYYhMI95K++2H3e6XeKPECx1YybLBxN9AEAIQKoKq9X1kroqrT9Ch5pQfn5nPrAgxRPsKF2q1lvchdWV2PwAlv5HEYuxFQ4w1GUlO671wfr3zOKzkayFv525pftvhblu4dKvTKU9sYeF6w8zHs+2jsq8gn2Ch0wZRq7HBXpPqgaAAjgWny64AlaMZcfnMdGsRFgADuiffbjtFhFfb2knZnjiRPfnJuxHbGQpKvCK+BFep+P8nEvKqifnp8YujnW3vMKhdDiptxpaRj3AbmjmYsQQqI/kyGEg0uozT3nKkGyeVnhe
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(7416014)(10067099003)(6133799003)(18002099003)(22082099003)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	muwDYtPJY7utrF1tCP9iK18m4fecRqy6QRqB71otl1Q3C5NB6fqfSEjHDZABwBVCItrF5eLycYffhvE35inXotioFWpRr+4cGeQif4PYRUZ3ajTZRXBOLkaxejK71zjpeJFQL+lKjimlr5mfxtNfQteSD0syGOI4sqTWiVGzlbqPBcrOyMlQkiSCGxm1O7EArqSaBArB72pDYXdp69Ri7GCuMG/vWoH70l3IXx+1LM/gOVogAEEj8bXt0AiW8xXFxHEwvIzkPG2RD3/V8qf5JYLegNSmoEfRtddqFE2JyT0gfT6rFqaBLmD9655WxYNPWr3TO4y6VMW9sooTB4Mzb1XpuxKD+NO4Ec71ho19FBBers+FBDiXEm3D+0Oq2SZiznP3iROrEM9NWG3ehcbWmTyJWQQLt+wosqpqWIGfwxEpqEv92GdJBlKmIcKQ3Xw6
X-Exchange-RoutingPolicyChecked:
	V8jveera9W0XRFYIOmDbSBiZmscEuu+KhVd1egDlsFBaVq4ey7xzGwI4zYO7lFs747piUnfgAbOsmhbxhraHHajj66TcVjUSd835KTjauayw/N/HfoERrV4nUDhxtiws3ir95Lmg6rqc9qi3UyXbDWlta2FaLHqdeLL72e2cJxCLLCafGjVoXPLBrF5HNxHK+CiYVI8VpaSRppXy2Qx9lt0BKv7mcG55ZS96X6rj1dIcA4VeP9R8asmHOKmTBtfOINjqcOsoyhqxoD7r2Zwj/G1f8Xd2ynCEk7QJeyL9rL/hA0F48PxCvpGPifwSX+SnU1I51H09Bhw2ww+rSIIPiA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:33.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194559d0-c528-4bca-f990-08df02cce443
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC0AC38E58
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXz4RigTU/hHQP
 Fxh058YvpbiIRt60YKqtV5zEqh27QwtOBpE9DEa+aQrmyolvPvy/saavSsEIMge1vZpkifYNyxQ
 XyhKgczGJcJTPD3i4NdkQ7mo+SyJQwk=
X-Proofpoint-GUID: D5is1DiYAn2E3L36mQ8SgGgpedYCW28X
X-Proofpoint-ORIG-GUID: D5is1DiYAn2E3L36mQ8SgGgpedYCW28X
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dce71 cx=c_pps
 a=CgODY3tvNtn0KPtxrBvszw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=gHTh7DRQwxBKnKwRL7cA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX/CYoJUSEnJG3
 CmfB9vp0BPlmS4iVwT+p6qE7MjdSDuECYpqz5T0TbSbxEQOrvQwkRy+ZOCiqEPdCb/gftCiswij
 V2wrQDtUyKv0SmTPO7GSvWOriTm7G9vy0c3OvBsGgL1m9uWCtVaY0+GpyaAH5IfysqGI43fumVN
 ieMEMpvl0610DI7NW421sJyaeU089gr2Eoo0AQBjxzJlWka1N4pu38HIv2w8PQyU73limnq/Ui6
 ttCXE9pnauQb427fy7saSNn2CgTkFG/DrmYXmEFjO1cd/L8z0bcqQi4+TRpvWfnX+NOPob5U1cx
 k7ANzjiK8Joz23ddoorSeQ4uD+rb4nLauuPYoi/jBcv1hETkoM/XZTHgfBM2QJHQztCKiXzO+1o
 P9ScXPAcz1GuqxnysJnF2wWnZq5oK1V/3ITN1jhqZgMV7N3sAxpXOVPISmWRLfCcBP9q2zH3900
 02PlnWBWXD/i5RnpsaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Extend spi_mem_adjust_op_freq() with a bypass for post-config ops:
when op->max_freq equals post_config_max_speed_hz (the value written by
execute_tuning on success), return immediately leaving op->max_freq
unchanged. All other ops are capped to max_speed_hz, the
always-reachable base rate. This places the policy at the single
existing frequency-adjustment point so exec_op(), supports_op(), and
calc_op_duration() all see consistent frequencies.

Also extend spi_mem_default_supports_op() to require per_op_freq
controller capability for post-config ops. A post-config op runs at a
different clock rate than the pre-config base; a controller that cannot
switch frequencies per-op cannot execute it correctly.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5f973ebfb8b6..cd4bc4c914e7 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -206,7 +206,8 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		return false;
 
 	if (op->max_freq &&
-	    op->max_freq < mem->spi->max_speed_hz) {
+	    (op->max_freq < mem->spi->max_speed_hz ||
+	     op->max_freq == mem->spi->post_config_max_speed_hz)) {
 		if (!spi_mem_controller_is_capable(ctlr, per_op_freq))
 			return false;
 	}
@@ -623,9 +624,18 @@ EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
  * Some chips have per-op frequency limitations and must adapt the maximum
  * speed. This function allows SPI mem drivers to set @op->max_freq to the
  * maximum supported value.
+ *
+ * When @mem->spi->post_config_max_speed_hz is set, ops with @op->max_freq
+ * equal to that value are treated as post-configuration ops (e.g. PHY-tuned)
+ * and are allowed to run at the full post-config rate. All other ops are
+ * capped to @mem->spi->max_speed_hz, the always-reachable base rate.
  */
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 {
+	if (mem->spi->post_config_max_speed_hz &&
+	    op->max_freq == mem->spi->post_config_max_speed_hz)
+		return;
+
 	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
 		op->max_freq = mem->spi->max_speed_hz;
 }
-- 
2.34.1

