Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793249409;
	b=J897OcICdDaITeJ3ItnR2Tuu4IxUrKXJzYRceO+87T4xJawIx1hvm2g07twL4vyNkzUL
	 XPCryh4/RjS7Oq9PQBsGsqHHkrtHh3wg+7T/q/SSSfAlyuJsOZ6dzqSYabCgulnOZp9/5
	 clRZGWONz2FAa84EsXMaKOrIkfXZFNJIf0dgv+zm+CDxxmEyI9YxXpTo3WL9ZBqq0FNHy
	 vqvL5AvCMf+VzOl8U3tQKNW2BACS4UJS8V0sdDuL9kzNeuNxI58o2JV32Yao/eOFfkdB3
	 /oOptkM03fLK0h+0EWC17JCau55OlDQiVd71L6LuRMVD7KWRkx7RP2GnSVMIBFb2Ylw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249409;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NM0XvwHBc58Q8em5QK+V1dvbtVBQzHa4tnSzamXdI5s=;
	b=eUgRqBn5DlO8GmxU00eQ8N4bahQjPcRoNIF3a+i1qoBFhJAezSgT/SjMisgK3C4dFz/4
	 9DU7YPf5bOi0htZiKAvWtjy7F7s/LMEz3D23Y0d/EGq9N12EOFuMHSfupNhOh5ExyyZ8Y
	 m045YCCe1W24IY91oBWIlI0zMuG1l6cHfHXtG0YIVUDuJvLJBjVq39vchwG9ds2VRSii5
	 kERYbv5aWLvsuwrG9c4HRu0mHz3KqQYPLTZyGS8DP/9tbWSuMaSKnJeVmB2haFN37Xaix
	 RXkJoAClQJE9ZDs7ZpjwJLhcRvLt+CVANXGz6NO1wdyKDhHC6yPW6osORWITqWS5VOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=M23OsTdK;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=YqkxuAYq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDE606A31A;
	Thu, 29 Oct 2026 04:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CDE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=M23OsTdK;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=YqkxuAYq
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1leid1491220;
	Wed, 28 Oct 2026 23:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NM0XvwHBc58Q8em5QK+V1dvbtVBQzHa4tnSzamXdI
	5s=; b=M23OsTdKDVIUZROqOyZUZvwApjINXx7KQsKHGKBcyOlJFGK+Df0RWkvLE
	OerERPwXLf+DdnasgkKbK5TKZv2A4qTP6DuJksKcoKHXI30xWC0Z+XhfFyIc4xxM
	GCLcYj9lQjTETxVJmkzlKfzE0KeLHIts8agE/mWGMWk2E77SeIHo4PYqy6lcew3I
	eXDpRNyI42TeWzdGH6nFHg5zn7NFOqRHjEsF2TuJOVzkHMsCjdna91JJklf3HTgA
	ERGWP8foH7Xdeo9YHqj+G0KbltFfo7FQcqqwHWnByWLFe86q7jWgHW7VavLxRDuz
	gnCZuNpoJHZh6k5Zx+07yX5C7JXew==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hkr262jrm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 23:49:33 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncpJLIosm2eKALM3fgFc7imXunR5rcM8BwwWCMhdTrG2a20me9bjvCD/Ruuk6ZVw5F0ZICutos3XaDM02GLkKYWZtaBnVrhwpLgUTpoDX5D54uc4IFfruCtHXyIHnGkKjAVjl0t0uHq4lep1ahpya1NJA3itI4D6wcjQeGv/yC1+wL4Z6laqs0DV51bCGLw+iECLEo/cVs18cyVAA2CnN0vMBTuI1gyEDo1drTRsqwB0vf05Y6WpxPMqj4zesAopNLDq/dOVXit3Jg0FbxTj70SSudpp4kd/reopoWaftWK0wyHTH8SfbnpFwnkDn3QJQamHVphVLKtwEcLceFSdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM0XvwHBc58Q8em5QK+V1dvbtVBQzHa4tnSzamXdI5s=;
 b=NTBDI7OX3VsQdk9nu84x+RU+/j43Cwd48IwkPqdua1qRGk0owegFjvaXlUjADEK6fj140zNHnkcvgTb/4YT5Barh9vPH3IfAjiPevl6YL9YU8O04vtt5DMnF7xvZdvYXNl5Vpzb69t6ocbBIuLEv3VlNkbhQgXaegxhOPfcJwSrz7Yr7PnbbtwaUy9cuN8Yyk32p2epRxZD+YPl5tg/zx/iCjWHG0KKhS2knUazfuVkpkPQTqmOKM4I7l4WdbT6zUoxW61z6JcocZAESumFtsDxIVGkr8l+2lVRUubsudzrbxX2+DppMoZ5Udnm5cMBb/EJ2HoqIVfZMD6QGoHM1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM0XvwHBc58Q8em5QK+V1dvbtVBQzHa4tnSzamXdI5s=;
 b=YqkxuAYqwzTO7f3gJj+zP2cF7hBMOCBGXUUeLKu4m/CbvEgS7OZ9xFrJzqwbnpqiWT63xwkWuv/5VVuP2YHnW9CrYBLD0Hj/Qe8KqzOgGmPPHUd7QROKTKk6hBaE2ZqqLKpmdUi7sygXa3Dr9105IlOG7qlG34k0/jwUib2a50w=
Received: from BN9PR03CA0537.namprd03.prod.outlook.com (2603:10b6:408:131::32)
 by DSWPR10MB997827.namprd10.prod.outlook.com (2603:10b6:8:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:49:28 +0000
Received: from BN5PEPF00046989.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::96) by BN9PR03CA0537.outlook.office365.com
 (2603:10b6:408:131::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Thu,
 29 Oct 2026 04:49:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN5PEPF00046989.mail.protection.outlook.com (10.167.245.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:49:26 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 23:49:25 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 28 Oct
 2026 23:49:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 28 Oct 2026 23:49:24 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69T4nJQd1206465;
	Wed, 28 Oct 2026 23:49:19 -0500
Message-ID: <87ad0389-983d-4fd9-8c4b-0daa108a040b@ti.com>
Date: Thu, 29 Oct 2026 10:19:18 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/19] spi: cadence-quadspi: add PHY tuning support
To: Santhosh Kumar K <s-k6@ti.com>, <broonie@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046989:EE_|DSWPR10MB997827:EE_
X-MS-Office365-Filtering-Correlation-Id: 7244f0e6-0dd0-4f22-92d4-08df35780287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|921020|261028144727099003|56012099006|261009223027099003|261022075727099003|261009221227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|10067099003|261026121527099003|18002099003|22082099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	Vw+3jAG8iG2fL3mVsf8c6n8ckuoRXJOgm732H4l1atpkzVVcJm9y/PNeh2Z0HZkCEPzec+F9Q/Uf13gZyZnG+BeqydD/b28YtlkpT6SoV5G1FKrvrbmsVTsqR0tdzdPkg6nHVEYoVSdUclzIb9F+YcHNL331m5ZeS274utNrMhMjw50q7I3AXp/2PcuEbN+iGLjb8W1GsWA1O3747Tsk1FHwOF+AWJqimwJ6KUlAn6G33Hve9YLh9lhIrgKvcLBhzDl/BSOtbD83CvSckSY9VC5/U9q6m/rTi08lh88bYca6AFGt9/A4WBWGQHhPG741CXvpfq3vj26TR+QAUzUtfoyGOy3oXmzLLsMtVmtatQjd+gt1wfGWP214ZiYijYrGz0Ny8GeBvH8Rs08oZNsIVavt7NdA5yM+QRxEUnYdmTKYTie4mWnp1v63IZex3z33CZgrro9IN24Yl93vjbDz4b7GcERhu+DPyO8C05YaLLa9nLtBZZ/LblSgMYzD8RaLdaJQyaFkWbtENDNCODxA8WtDQJQDdrKO3UrEZXTM7/EMOLA31DPOekUexwli18FuC7qY2/T0P2pqk1115blcMO56b3q043Lbhltu7VE6iZpNCNHRg62KZf1h0QYW3sLm9Qs3GXcGeHCe+dCeeIS5sTmgpxm6XDlM7Ai8eBwvYoI/ggQzeZMT6z6rQutJvsMUMQYDIkfaUiIOKTaZst0XKQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(921020)(261028144727099003)(56012099006)(261009223027099003)(261022075727099003)(261009221227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o/jdZmwd4yk/SAncPZ9O5m+HiCsxwU4r/vPE9CFnkwI6qJCMrDAKJdqmEpclBRwwJL2IMMShlOyIUnDqw2fkE+u7AZUj3xYCyOnXA00eHzFMEZGAoAWXULvhwjkFtJh+zq8enyqbdnekcrujuKtSnbH42DhOOH8KO+FALEgVaRTqYczJGEcZJMctCRRXL/+NgeuiwtZzq65rFtKYJWt3rdrtYwo7Lj4xLlYs74ZUvw0UjosfmER5OwUHoADTN9YR21ObcZZGalkjsQhFqac75sVIW734/2XxZwbcKfvyyehc8+BLhvcsIohyr5kPVWxZ47k78KS5y7pw8ddE7OgEGZ/r/NEewDAKcNrhlL3MaQJiMnHcJNALyiNxaR+liYpN/oX5lBz/C9y3F049nImJY4bMzDYLML8771THR0U3UocufYdDdO6v1hsOUb3pG5OQ
X-Exchange-RoutingPolicyChecked:
	GLGZLenwZKKNk4PPd82BLVOLBRl1FDvjIL6JJWUdBVm098af7lDfpRA9l7WUlQY/RU8AuBI2Q1PwDnCcivbPLgjYR1mCt0gIxA4aSZPAdpOz3hqMdjHB08IxntOcqTEzubY6kS0peQ393eg180fRqbQ4J0Eb0fnKkn8+0ICShs0OCrA4XlVxSZ9+/QsJD5Uk/JtfeU7aQ2vz6ZXJWge+WMh3zXHzfpUxFJpKDjNeLOQUJAUjytj84Macbmw7/fZNm92z/Mm17Kl2MvFmogHkAmGhdn6DoT5wmgZ997/SvaJdhzrllrxgXLrwOsNiWSpipToxpkMGli2YqIGloN32ZQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:49:26.3491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7244f0e6-0dd0-4f22-92d4-08df35780287
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046989.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997827
X-Authority-Analysis: v=2.4 cv=PImaavqC c=1 sm=1 tr=0 ts=6ae2d05d cx=c_pps
 a=5W5/h04s0UwUCg87NMYX9Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=TEq_OQO6hDZv-sJyDy8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zgm8MQm3jdvQYSzLPQK7do-OPQC3nQpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxNyBTYWx0ZWRfX65TzNwYJT4Iq
 foEKrD9XnT9iisMlcZVuNqHCsBDc3t8+eQpEfVVKUBdumu2JRdLwZeURIVX0M5cdLMtuwUGiTYb
 86MqImnsbdhM0rQifiJyaXG1Kd9r2QJTxU4/ml292QIRoV6DLgajP1rmbGrv6fM889GVqmRzrT1
 Q5BDtXPY0Zyb60h8BX2/MA2rUkZ4S1Z+hAiZy/dafUSNxBbIKOQG4aw2XqTPOa0ocm2lGfA0Ftu
 BRudxiVbYaftpel/B+MM+THsjmLYHN+10QXlAmxmxN/hvJZtJZEX2rEvnwFcj0G5ezW9qEHK3Ca
 WOKgtIGGLfXAMkOEoJkLqpcY23PuHUr0K2Thk6EEG5gxVEE51QzA36Lh3KFX/YjQFym371p4pLv
 La00GmeBo6H5kG1m3DThSD4nHcMY/SNxtHmzjWIctnjoPb1QrB/st7NQlkU+qw+aCPp+fVkis/S
 55TQaMYnK8ZWxjdiH6A==
X-Proofpoint-GUID: zgm8MQm3jdvQYSzLPQK7do-OPQC3nQpL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxNyBTYWx0ZWRfX7jwi3nUfwMcS
 ofZR1fgKYJDRM7K7dtXekS/JFTUgkdbi2YT9Y+tgFrri3yuz5Hsk1pfkKc7UMnG7rrYfHov+jox
 LF6D7xHdEUsgzq5BNNE1hpXiGtxqnq8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290017

Hey Santosh,

On 29/09/26 12:05, Santhosh Kumar K wrote:
> This series implements PHY tuning support for the Cadence QSPI controller
> to enable reliable high-speed operations. Without PHY tuning, controllers
> use conservative timing that limits performance. PHY tuning calibrates
> RX/TX delay lines to find optimal data capture timing windows, enabling
> operation up to the controller's maximum frequency.
>
> Background:
> High-speed SPI memory controllers require precise timing calibration for
> reliable operation. At higher frequencies, board-to-board variations make
> fixed timing parameters inadequate. The Cadence QSPI controller includes
> a PHY interface with programmable delay lines (0-127 taps) for RX and TX
> paths, but these require runtime calibration to find the valid timing
> window.
I tested the series on J784s4 and J721s2.

For the whole series:
Reviewed and Tested-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen
> Approach:
> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>
> SDR Mode Tuning (1D search):
>   - Searches for two consecutive valid RX delay windows
>   - Selects the larger window and uses its midpoint for maximum margin
>   - TX delay fixed at maximum (127) as it's less critical in SDR
>
> DDR Mode Tuning (2D search):
>   - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>   - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>   - Defines valid region corners and detects gaps via binary search
>   - Applies temperature compensation for optimal point selection
>   - Handles single or dual passing regions with different strategies
>
> Patch description:
> Infrastructure (1-5):
>   - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
>                frequency achievable post controller configuration
>   - Patch 2:   Add spi-phy-pattern-partition phandle for
>                NOR flash PHY tuning pattern location
>   - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
>                spi_device.post_config_max_speed_hz (0 when not set
>                keeping all existing DT fully compatible)
>   - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>                op->max_freq equals post_config_max_speed_hz, return
>                immediately leaving op->max_freq unchanged. All other
>                ops are capped to max_speed_hz. Also require per_op_freq
>                controller capability for post-config ops in
>                spi_mem_default_supports_op()
>   - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>                spi_mem_execute_tuning() wrapper in SPI-MEM core;
>                serialises access via spi_mem_access_start/end and
>                rejects GPIO chip selects
>
> Cadence QSPI Implementation (6-14):
>   - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>   - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>   - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>                verification (NOR via spi-phy-pattern-partition phandle,
>                NAND via write-to-cache), SDR 1D and DDR 2D search
>                algorithms with temperature compensation, AM654-specific
>                execute_tuning entry point
>   - Patch 9:   Reject 2-byte-address DDR operations via a new
>                CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
>                around AM654 OSPI erratum i2383
>   - Patch 10:  Refactor direct read path for PHY support (preparatory)
>   - Patch 11:  Enable PHY for direct reads at the calibrated frequency
>                when both transfer boundaries are 16-byte aligned,
>                falling back to non-PHY DMA otherwise; also reprograms
>                DLL on chip-select switch when two devices have
>                different calibrated settings
>   - Patch 12:  Enable PHY for indirect writes of at least
>                CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>   - Patch 13:  Reprogram per-device CS timing on any chip-select switch
>   - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
>                runtime resume, since the DLL loses its lock when the
>                OSPI controller is power-gated
>
> MTD core (15-19):
>   - Patch 15:  Extract spinand_select_op_variant() into a shared helper
>                spinand_op_find_best_variant() with a skip_mask
>   - Patch 16:  Negotiate optimal controller operating point before dirmap
>                creation; iterate all read variants in performance order
>                across ODTR and SSDR interfaces; re-pair cont_read_cache after
>                PHY tuning via protocol-shape matching
>   - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>   - Patch 18:  Execute controller optimization in spi_nor_probe() before
>                creating dirmaps
>   - Patch 19:  Reset max_read_op frequency for security register reads
>
> Testing:
> This series was tested on TI's
> AM62Ax SK with OSPI NAND flash and
> AM62Px SK with OSPI NOR flash:
>
> Read throughput:
> |----------------------------------------|
> |                | non-PHY   | PHY       |
> |----------------------------------------|
> | OSPI NOR (8D)  | 37.5 MB/s | 218 MB/s  |
> |----------------------------------------|
> | OSPI NAND (8S) | 9.2 MB/s  | 35.6 MB/s |
> |----------------------------------------|
>
> Write throughput:
> |----------------------------------------|
> |                | non-PHY   | PHY       |
> |----------------------------------------|
> | OSPI NAND (8S) | 6 MB/s    | 9.2 MB/s  |
> |----------------------------------------|
>
> Test log: https://gist.github.com/santhosh21/e1b5c7cc5cad4acb94b67e826d971ab9
> Repo: https://github.com/santhosh21/linux/commits/phy_tuning_v10
>
> Changes in v10:
>   - Gate the frequency spi_nor_spimem_get_read_op() propagates on matching
>     protocol shape, and add a patch resetting max_read_op.max_freq around
>     the security-register read override
>   - Split cqspi_tune_phy() into cqspi_tune_phy_read()/cqspi_tune_phy_write()
>     so PHY_PIPELINE is never set on writes, per AM65x erratum i2189
>   - Fix spinand_try_ranked_variant() to only clear, never set
>     cont_read_possible on ranked-variant fallback
>   - Fix other, smaller correctness issues raised by sashiko-bot
>   - Collect tag from Miquel
>   - Link to v9: https://lore.kernel.org/linux-spi/20260825171737.776052-1-s-k6@ti.com/
>
> Changes in v9:
>   - Fix off-by-one in DDR PHY TX search loops
>   - Fix cqspi_tune_phy() to unconditionally execute the disable path
>     and restore CQSPI_REG_READCAPTURE on enable error rollback
>   - Fix other, smaller correctness issues raised by sashiko-bot
>   - Link to v8: https://lore.kernel.org/linux-spi/20260821114822.4040338-1-s-k6@ti.com/
>
> Changes in v8:
>   - Re-pair cont_read_cache with the selected read_cache variant via
>     protocol-shape matching after PHY tuning instead of unconditionally
>     diabling continuous read
>   - Rebase on v7.2
>   - Collect tag from Miquel
>   - Link to v7: https://lore.kernel.org/linux-spi/20260811183313.1550425-1-s-k6@ti.com/
>
> Changes in v7:
>   - Serialise spi_mem_execute_tuning() with spi_mem_access_start/end and
>     reject GPIO chip-select configurations
>   - Fix cqspi_phy_apply_setting() to also write the calibrated
>     read_delay to CQSPI_REG_READCAPTURE, previously software-only
>   - Use local op copies for pattern write/verify instead of mutating
>     the caller's op templates in place
>   - Fix the READCAPTURE bypass bit in cqspi_tune_phy() to match the
>     value validated during calibration instead of being hardcoded
>   - Enable PHY before starting the indirect-write state machine instead
>     of after; the old order was a guaranteed deadlock
>   - Add a new patch to reprogram the PHY DLL on runtime resume
>   - Fix continuous-read and ODTR/SSDR template handling on ranked
>     fallback in spinand_try_ranked_variant(), preventing data
>     corruption after a fallback
>   - Fix other, smaller correctness issues raised by sashiko-bot
>   - Rebase on v7.2-rc7
>   - Link to v6: https://lore.kernel.org/linux-spi/20260723110219.3180747-1-s-k6@ti.com/
>
> Changes in v6:
>   - Add maxItems to spi-max-post-config-frequency-hz property
>   - Rebase on v7.2-rc4
>   - Collect tag from Krzysztof
>   - Link to v5: https://lore.kernel.org/linux-spi/20260717185116.2065505-1-s-k6@ti.com/
>
> Changes in v5:
>   - Rename spi-max-post-config-frequency to spi-max-post-config-frequency-hz
>     per DT schema unit suffix convention
>   - Rename CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk to
>     CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR for clarity
>   - Rename SPI NAND identifiers to remove PHY-specific terminology:
>       spinand_configure_phy()     -> spinand_optimize_controller()
>       spinand_try_phy_ranked()    -> spinand_try_ranked_variant()
>       spinand_reset_max_ops()     -> spinand_reset_max_freq_ops()
>       spinand_op_find_best()      -> spinand_op_find_best_variant()
>       phy_read_variants (field)   -> all_read_variants
>   - Replace bool odtr parameter with enum spinand_bus_interface iface in
>     spinand_op_find_best_variant() to preserve the existing enumeration
>   - Replace cqspi_get_phy_pattern_offset() with per-flash probe-time
>     phandle lookup in cqspi_of_get_flash_pdata(); fixes incorrect pattern
>     offset selection when multiple flash devices share a controller
>   - In cqspi_tune_phy(), reprogramme and resync the DLL when the active
>     device's calibrated settings differ from hardware
>   - Edit cqspi_phy_apply_setting() to update phy_setting.rx and
>     phy_setting.tx alongside phy_setting.read_delay
>   - Reprogram per-device CS timing (CQSPI_REG_DELAY and read-capture register)
>     on any chip-select switch, not only on clock changes
>   - Move post_config_max_speed_hz early-return to the top of
>     spinand_optimize_controller(), before any state is modified
>   - Remove dead NULL guards on SSDR op templates in Pass 2
>   - Downgrade tuning-failure log messages from dev_warn to dev_dbg
>   - Rebase on v7.2-rc3
>   - Collect tags
>   - Link to v4: https://lore.kernel.org/linux-spi/20260618073725.84733-1-s-k6@ti.com/
>
> Changes in v4:
>   - Add spi-max-post-config-frequency instead of extending spi-max-frequency
>     to accept an optional second value
>   - Replace spi_mem_apply_base_freq_cap() with spi_mem_adjust_op_freq() extension
>   - For SPI NOR/NAND, execute PHY tuning before the dirmap creation
>   - For SPI NAND, execute PHY tuning across all operation variants available,
>     perform duration comparison, and select the best resulting variant
>     by taking controller-specific restrictions into account
>   - Move i2383 check from cqspi_supports_mem_op() to cqspi_am654_ospi_execute_tuning()
>   - Rename cdns,phy-pattern-partition to spi-phy-pattern-partition,
>     cqspi_phy_enable to cqspi_tune_phy and f_pdata->use_phy to use_tuned_phy
>   - Remove redundant spi-max-frequency parsing in driver cqspi_of_get_flash_pdata()
>   - Extract DMA refactoring into a preparatory patch
>   - Rebase on v7.1
>   - Collect tags from Miquel
>   - Link to v3: https://lore.kernel.org/linux-spi/20260527175527.2247679-1-s-k6@ti.com/
>
> Changes in v3:
>   - Drop spi-has-dqs DT property; DQS is now enabled automatically when
>     the selected read operation uses DDR signalling (dtr flags in the op)
>   - Extend spi-max-frequency to accept an optional second value forming a
>     [base-freq, max-freq] pair; the presence of two values signals PHY
>     tuning intent and encodes both the conservative base speed and the
>     calibration target in one property
>   - Add base_speed_hz to struct spi_device (spi.c/spi.h) and parse the
>     two-element array there; single-value DT is fully backward-compatible
>   - Move frequency enforcement from the cadence driver to core: new
>     spi_mem_apply_base_freq_cap() called from spi_mem_exec_op() replaces
>     the per-driver cqspi_op_matches_tuned() and non_phy_clk_rate field
>   - Propagate the tuned max_freq to dirmap op templates after
>     execute_tuning() succeeds; store persistent op templates in
>     spi_nor.max_read_op and spinand.{max_read,max_write}_op so the
>     frequency writeback survives across the probe call
>   - Replace NOR pattern partition lookup by name with a
>     cdns,phy-pattern-partition DT phandle pointing directly to the
>     partition node
>   - Add CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk and reject 2-byte-address DDR
>     ops in cqspi_supports_mem_op() to work around AM654 erratum i2383
>   - Remove RFC tag
>   - Rebase on v7.1-rc5
>   - Collect tags from Miquel
>   - Link to v2: https://lore.kernel.org/linux-spi/20260113141617.1905039-1-s-k6@ti.com/
>
> Changes in v2:
>   - Restructure the .execute_tuning() call from spi-mem clients instead
>     of mtdcore with best read_op and write_op (optional) passed
>   - Add compatible-specific .execute_tuning() call which can be called by
>     spi_mem_execute_tuning() if exists
>   - Handle tuning requirement check by controller instead of spi-mem
>     clients
>   - Add support to write the phy_pattern to cache if relevant write_op
>     is passed or get the partition offset which contains the phy_pattern
>   - Add tuning algorithm for DDR mode
>   - Add support for DQS
>   - Restrict PHY frequency to tuned operations
>   - Link to v1: https://lore.kernel.org/linux-spi/20250811193219.731851-1-s-k6@ti.com/
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>
> Pratyush Yadav (1):
>    mtd: spi-nor: extract read op template construction  into helper
>
> Santhosh Kumar K (18):
>    spi: dt-bindings: add spi-max-post-config-frequency-hz property
>    spi: dt-bindings: add spi-phy-pattern-partition property
>    spi: parse spi-max-post-config-frequency-hz into
>      post_config_max_speed_hz
>    spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
>    spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
>    spi: cadence-quadspi: move cqspi_readdata_capture earlier
>    spi: cadence-quadspi: add DQS support to read data capture
>    spi: cadence-quadspi: add PHY tuning support
>    spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops
>      (i2383)
>    spi: cadence-quadspi: refactor direct read path for PHY support
>    spi: cadence-quadspi: enable PHY for direct reads
>    spi: cadence-quadspi: enable PHY for indirect writes
>    spi: cadence-quadspi: reprogram CS timing on every chip-select switch
>    spi: cadence-quadspi: reprogram PHY DLL on runtime resume
>    mtd: spinand: extract variant ranking logic into
>      spinand_op_find_best_variant()
>    mtd: spinand: negotiate optimal controller operating point before
>      dirmap creation
>    mtd: spi-nor: run controller optimization before dirmap  creation
>    mtd: spi-nor: reset max_read_op frequency for security register reads
>
>   .../bindings/spi/cdns,qspi-nor.yaml           |   17 +
>   .../bindings/spi/spi-peripheral-props.yaml    |   13 +
>   drivers/mtd/nand/spi/core.c                   |  328 ++-
>   drivers/mtd/spi-nor/core.c                    |   94 +-
>   drivers/mtd/spi-nor/otp.c                     |    5 +
>   drivers/spi/spi-cadence-quadspi.c             | 2275 ++++++++++++++++-
>   drivers/spi/spi-mem.c                         |   55 +-
>   drivers/spi/spi.c                             |    2 +
>   include/linux/mtd/spi-nor.h                   |    4 +
>   include/linux/mtd/spinand.h                   |   15 +
>   include/linux/spi/spi-mem.h                   |   14 +
>   include/linux/spi/spi.h                       |    3 +
>   12 files changed, 2671 insertions(+), 154 deletions(-)
>
