Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85061437440;
	Thu, 23 Jul 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804591; cv=fail; b=ixgL6hxfZ2VJN+A6rn5lmVfcGhnj2LmMUhMIjw5HWUSfLOcrn2DRZ0wVBEg+WqrtzrcZZ2Xm8UDHbiECKvctX8f9EjJ8f2Kx6kkD7lPiV6ab6L/s2HQ0BY5DK6f9jhaDNE5uFt1Flz9C1L1BzLl17tI2M7+7OEtsrdYsOsV85ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804591; c=relaxed/simple;
	bh=NpoT/cBBl4rAzM2NVlulrn3aPKLC+iksPz2nkPNIsok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvH6ieUhBseGmA+yOYLMqKy/Nk7m81MKuFA/sOJRnBkHAZjiAdNE7RPPivdrpbMtcGs1EA8nqD6YgGOInua+HwAb/LQPoJ+0GRbZvP2vNhf/deumurqoBnmxkfjvDoK1mISHkftKPLa7jWjeVYBtaXHir0b+NhoqDrK90ewLnJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KRNnc083; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vziFv/Li; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KRNnc083";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vziFv/Li"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9JjoS2008553;
	Thu, 23 Jul 2026 06:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTY
	Hk=; b=KRNnc083EkARV5IyP0SwtH7WNrY9MQwwGfTkGx9TdZOOsjTE0CT1gYrB5
	DI+8uCOmhsMasyqyQWSQdV+ScPQ2xgnz6fcVytM4eBgcrQineniXmLJtmPGLX41j
	VgUgVjxzK1O0VXATr92fW7eqYmg/MB6DhdCVhbcSL7MA/TShzHgwLx2e7cw13xSX
	x5I7KTCmUZOFXubYbILpyHIudWQx5LHNK/yHh5+Drid9ZUfJ4Zsq1M9vrhafbDgu
	iCulMrkgbdxxfdDbbp+fEuhqckZ2bBdB62wMUOeYM7nT6QzvtPHvI3hdxxVuX0rn
	r2RF91iDXl3OPPcvhjFoNwQGkZt8A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fkg7ugcd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:02:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSl+9Z3/8K+TCV6Gvh5fKd2No0KL4XoRBPZpKJAEdE3I4c/m6isd4y3atx7KrYnrL2wtGDSDtFSzTmm4WfkCvLrDhXaCr6igfSYJPoIGFfXG4yfTRsHzOadlMASVbJBXW1CPgVAxJkSPXxVgNHe3JkRUCi6iAdcNxm7UkV5lPc2tSJqwD2qOVbJGCGmEVRv5eqRMbEjkSE1EcnKGKh8dKzZNsUjzTHC498vhnGnY2Unq15fk/tYzREP1k44txMuyZsNhu/Tg8OzbxB+FksuxgQ9+TX39XggX2ISfUHruloW9LejA5hosN694wbnYtHpAV+6eE4hDcvGsvNDSL3pZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=O19sTkioV4DOvLTEDinqoXZwMcgcIfklf1/yoBmmcfJ1LAom+6b7NlDjmxH4yZX06ag+qGKaP8VSnRBJVZ385lLNISnsV3lxj8GVsN7nvuhl/LmExEah357VQkOps/6lDue8EBJcTObF36pvcaelM3k8a+Pb4S+dfQCxgM4P9RKPJNizapYxhr837gZoTYzY+Pt0atXM5Kp18BUqAPBY5YANykRVLp+rrzR/+RlsAaD/WL/6E8QE1R2XHlutZz6VoxyIF2soCelsxyPrgwN3XtxIxKg0MmEBSzlAuvMWzAlNH1BfnkMUn1BjKMA6LI1xxWOBxxHCMysWeMiy71JZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=microchip.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pWYfJ1EP748IQC6CtiOQMdvqHr9KlmObkQrKfpTYHk=;
 b=vziFv/Liw925XUKvQFgNjwi/HfKDK3mwpKNujzD+Gu0Jm+0+Mu+Glp2GwXshV17uDqDCGp7ENuZGWCntudyK8IfoKkN5h9BkA2iewR4x1RwcYeT5xACMiaC2/8skslA3DqYp8VjtSXiDAY8OWjfnH2HGiKWAzfGEn95/NuWLAxI=
Received: from DS1P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::19) by
 MWHPR10MB998054.namprd10.prod.outlook.com (2603:10b6:303:2a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 11:02:38 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:44b:cafe::39) by DS1P222CA0026.outlook.office365.com
 (2603:10b6:8:44b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:02:36 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:35 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:35 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OVv1577597;
	Thu, 23 Jul 2026 06:02:30 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v6 01/17] spi: dt-bindings: add spi-max-post-config-frequency-hz property
Date: Thu, 23 Jul 2026 16:32:03 +0530
Message-ID: <20260723110219.3180747-2-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MWHPR10MB998054:EE_
X-MS-Office365-Filtering-Correlation-Id: fc90bd39-3b25-4ad9-82cf-08dee8a9e771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|56012099006|10067099003|921020|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ikw836c3h4W8dY9f8WLtkFVKmuzcjWkd/aIoA8bHid/5Uwh2yzypYiwpVk4rMmn87+D7fKEKauDGydd3mGQELUMRgUKShiBQONZjujEvcOCAx0BjKjTOQ5Kv5Sr5Qfi+KmPXWbZSh4BeMDxPPT5i1V7PqJsATpGLuLbWQO++0aZ4+8mhtA/c1mwNK9c8ju4zaPUSfzzz7Jaqus99qEtmxO74NZE+7YmXTUKQ3AGG3gT2hkEYwfLxK1jDfoaLo2i1q3fhALa7o379qEdLkGNaTNsnGIsW4/mCydGJF9Tt5gCv/B2yEL2/jUQMz3uqu1Mk315DbEZ5wG2UHq76TuyiKYGUm+6FyzRIJg8vDiw6RBfJZEw0XC4FLuKld49cekpWpyYPk5e5gYt9DqaTK8NcNw0X240h4GwxCgoIu5j27p2Eadd92kjqkG9yqK7SyXyhPod/Z4uPrtuEOPKwmJ6D+DKC3B0LRtHRti5bCU6jEiWkHj39uuUxYVTpg59jjyISKKtoEENb7oZOF/224JOPR7g+Tk1NiV+anI2Fg40rEhEIS3kbO5FdAPgvJP1oVam078VYq3gOjVpv0uFX9vZkuzGNSJdXiJ3MG3vv06RvidtiFp7KehTLneT1K0f6DutcmDWUVdQkyfI+SF+DXb4UFsgjFLgRA2HFE5HWKFC1EAcMda6RYOPEWniFAg75oWR8ri+55HdiRLmlnqARWCCJGBGog6Pc13lOuSnHqC4TM2WNf8Zo77NEsXmN2qotz9hO
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(921020)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L+qwpiIGEj0CdoUNwgRL6B9sshOgYJfpen1uxA2BiOjmqtCyyvlk/gfMzWFerQupxMINrMD3SanNsYTO7MH/+e6jpmMl2/a1VzM1e3QQHyedu7HDEEUG6vRp3DSpig39HNscCYlKrtaNtDLIHRx+N+YMjuratG12ZZBNTF0mgkSEcqU7YtEQcYY00nJtb7LTav1zmR7fmEW63i2HexnlxXfi2MmnmTSPijolRGnZgkRBqQxOjf7b9wkTIlC8EAlW9tstMQmB7OSMldgY+u5uzt6SZ24rFdkXL/eDRWj1GOQj7RLRgQlYsCX9NLvfmVQtN/vN6q33MCW7/JPSRJc3dddPGDp9jTpdugQiGzX9xAUDkSOOxOYooFMIj54ALVCJ2FLYTNduqWq8imFgw4DuVk8QHuuTS+YbeXBZiqfqKL1kM5jBOIvgaFXW8mjdOHMR
X-Exchange-RoutingPolicyChecked:
	icsqEhjB3LXTBP41P+++f0QLy/NCQaGpSWcCL723Jxv38icGAW0Owh2KHb/N1DqHULGouOG9b/xX+jia/5COIzhf+Nv29WmOhrcGGI1dSzvO9GkW8rZ7Q3yw2oeDVk11T7sPuBCaW32JHI87ZkkPxWMOCKiR/Y9kM3z6Gayave0zz4EWDr5O0f9FIpvbbVE3ufmdg2POO33zK2z6W8ji5qr7Jyc7UIobYEsadaeEeSlDPzN4aot8MyJ5J+uDVxnnzdGgpxQtfRTwx9owGn+tzJvmGirQWfSLOdETUqnQ7O+kbuKmF2dgPdjJV53ueOIjkK69+2uCdn4Tu7ytskmjnA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:02:36.2536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc90bd39-3b25-4ad9-82cf-08dee8a9e771
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB998054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX5P8pH1nYrOrB
 4GRjFAdGuFB5nUV85P6h49wQ5063QdJKGA/gROH39W5uPPYHGtO0mLGM/bheqDaUQiYYmOL8+Dd
 a9CiL/VAONtHZTJP89bLfT+Pr3a6J+XS8csNbPdsqEscmasfr7pv383sYzlmXDstwCJ9oWStEZc
 gDrG4rHN4ix7V4WV6p6Q2a5vWA8h9T+mJ6cxmr2XA827pmLfIuQoXIKgsqvY7fY2EjuCUbTCzwo
 ZIU3I1OJOIRkc5ZRw+BvMH2hd+v/FMy7yMHRAupqieUHwLPPdhxorGTiGxJj9EAOBHi9EgrL6Uz
 FvhouKUuMjlHvRTwTGVw1Uo1XKTeeRKP1Z+E33cRUmqj4VuHBcUVJoeKTb3xc0MnYODU5pXTkAK
 WhUALhrQyXeJhBIMuXrY9frOQGd+DX40gDZ8A+UuoGJrZrS7hbeDNb/y3I9Qs4fdG8r5mCHdu9g
 7Ix+WSXf2g3/DT9W0Cg==
X-Proofpoint-ORIG-GUID: jmlyWCyN59VwXbxHwT5AnbGrTNkbKGhs
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a61f4d0 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=skPbNTvFiSR7kuR3s9sA:9
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX3XUKCBqQX2Xh
 D24eSvTtVmpqZPzQun5laDD/5QRu8cWVd32BVykqSfZF1RpYbCa6GC8AnHwSKHcKNwMG/RpIBux
 7at0IlpSfXF2+WwQQIR4e/OPtlJQ8Kg=
X-Proofpoint-GUID: jmlyWCyN59VwXbxHwT5AnbGrTNkbKGhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add spi-max-post-config-frequency-hz, a generic property for SPI
peripherals that operate at two distinct clock rates: a conservative
rate always reachable without controller configuration, and a higher
rate achievable only after controller-side configuration.

When both properties are present, spi-max-frequency gives the
conservative pre-configuration rate and spi-max-post-config-frequency-hz
gives the higher post-configuration target.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..84976fd3ee1b 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -45,6 +45,12 @@ properties:
     description:
       Maximum SPI clocking speed of the device in Hz.
 
+  spi-max-post-config-frequency-hz:
+    maxItems: 1
+    description:
+      Maximum SPI clock frequency in Hz achievable after controller-side
+      configuration.
+
   spi-cs-setup-delay-ns:
     description:
       Delay in nanoseconds to be introduced by the controller after CS is
-- 
2.34.1

