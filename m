Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876493;
	b=zEFQE2yWvUlUc1vVeTZCuOeNkHrgLIAfEhS7L4GEB+38wGIj7FcvjrINPf14b9umtZNL
	 0f7ZVAfNCYAnG/1YycRqQdLTyiu4csWmsV9QLg9ZwHIAN7z3eJSNVMeazM8b4ry3zH9ZN
	 fkehly1NX+rSCPg+HqMhfjo1GfPftPwS7Yas8B5YLcGyQ5jxsQs6OlCvP/P2CHdRZjv+0
	 2DKkQTziUZM/Fdr4ldK8JU3QFMbd0bXa2HrVxakxudAqRiPbUx8+5PHT3JAxBTtlYaaCf
	 gyQCIFe3mqaG+K2DjghTTSxQw0r87vbAVnSqnDmlANfgZNAP2/2ej44liCTWffWLXCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pXaPBEzBQ1F58GvKN+8hwWgIsZYHRtBzusYiyElko3M=;
	b=xe1zffAMZxHf38yKYhOd/kOwUFGyd8Ih7W7lJrPfm1Ljlfm11rXCingAxOgcAxu+COSF
	 ApWwlT2yXELd8iZB7UwGrLwiB5itqa853uFryz/RyTOAPCOjMVo72pnyeq+Nvzo6LSktg
	 Fq3/F5SpjPhcpDOq4tmtt8A/e9xJjPFGc9idP4AwB+kzhZ3fIxsA4BPfN+oqaH9MuXNiR
	 L1KHJq043Zd1Iyy1L7n8xt8bYGPfR9qcU4pfJK9mq0/LEtZwdNLpzDybkikoZOYgYOFmh
	 3wkrHHLOkm2XxKhgE1nYme+Kmecq0fVLSlP+srQq2xjd9ftsOXr1G5l8us10p3dIsjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=geHIAVcb;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Kz56IXI7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85D606D82E;
	Thu,  5 Nov 2026 11:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC85D606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=geHIAVcb;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Kz56IXI7
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wGuH2214858;
	Thu, 5 Nov 2026 05:01:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=pXaPBEzBQ1F58GvKN+8hwWgIsZYHRtBzusYiyElko
	3M=; b=geHIAVcbdVpS1uOsQUgy/2bjoDefIyJOewZMzDvFLQmG8jVzJ4w04oRKQ
	DYlcHtoY2keefAk3vXF4DBEx9B9+4/jnFCUWLa2i35g48lFQ4Zwal+29fo3MWWk5
	yK0kDyxBcWHRdz6klJ+adbOYcEUHW9xdddeZMiscCmQCyavUEWR0zfwYrlV4o8Y0
	1LGH4ANp1tXAmivXdNVNVBAjPt8ExLbVKSwGKueN1jRzPEdZtlxtVM5ZpRWT5PNd
	HcxQ6/tV3IK4US13tJRBAmFIPL1mlA+aKoOBpYN6fEFl2XQ8RaxGe7v+AFoiGREk
	8wWiQ8XFUcOJJpJ5fpVmCY4k9lyFw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k29e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:01:16 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of/SamwYIbAmwdkyILbH+UtUgl4D6HES1Rn7bRMQxVH2nz4uMUSguPPKQn09NBvT3fCWZRPo7/urjt96kZLazezI4FgMxsGg0LAF0xQQ/oGPl1agwq9kHN9wU+EO6B5tK2p6WJTgzpghIKgDR1ve11rmZtRVijylDAniC5pInnjEsWCLRh8qz7PEN59dnl8rp6Mb2KZjqKBO4yYz0WH/2VN5yYq/RF1opgtpDXPLS0uen5+Fnp71MyNVJ0YWXBEa9qWh2mDRcuq979CLSfq8l0c6inbvtQCdAZtOD6bXekA4B6IJTXj7XYImUcYO6lj4koOVxHFfaZvfuXyqPy4tLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXaPBEzBQ1F58GvKN+8hwWgIsZYHRtBzusYiyElko3M=;
 b=TZMIapVVlvIuHErUReGX4Mdhyy2XhBN3iVvv0QGDrXIpnfMOcIClRmnwCkLehdOSdsH7yLdOx419U7Xi8VvolHT3Vj44DxdZOtycfkO3PoNem4kxO2auTtSx3JiHZAzqfR0oBOol+PKIN2fG9LyW2RJ0r2W0c0NH/sXMgNL1D84wW8DdGBEYWHFs3+/Hj3FiQYnw0efKXASMH/fx3s+nEnn3cgKfh+CkbuyfwAljFV4vIanRiZxoytVrd+IdqQEIud3iVnDUY3htDixN1VSxTAVsodiFfbG6sCzAjjDpTnYWnUcjkznQmpggyWJqupDRAizWdzVRKabXM/6SeAAmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXaPBEzBQ1F58GvKN+8hwWgIsZYHRtBzusYiyElko3M=;
 b=Kz56IXI7hdPUNQQ9O7l1fsbl6BKCZrd5F+LZybQbekPuGwS8lXNV4Ce6lW+psIMh9wOwRtRBqxgKOk10V6xY91E/6nCp27W0FGaGCX47zWgUieV60TM47yTSduW6nHykpFPKT+8W5EYGTtuZ3zB/2CfnGCG82ePCi/9QI9q5QWo=
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by DSVPR10MB997844.namprd10.prod.outlook.com (2603:10b6:8:459::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 11:01:13 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::9f) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:01:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 11:01:12 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:23 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:23 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2P4171076;
	Thu, 5 Nov 2026 05:00:18 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 17/19] mtd: spi-nor: extract read op template construction into helper
Date: Thu, 5 Nov 2026 16:28:30 +0530
Message-ID: <20261105105832.2134313-18-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105105832.2134313-1-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DSVPR10MB997844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4e01ef-2206-4a56-15c1-08df3b2c1af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|23010399003|1800799024|261026121527099003|261009223027099003|261102123227099003|261021121427099003|261022075727099003|56012099006|3023799007|261021123027099003|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	8oSyhMtkaWyNInvUrlwX/5FMQ+1SUZ+uTUO5zIRYTJ8hGUkMWhU5Xq8e+2uGgh6XwFBnRAPl3n9fZIy+2NwWnPnVLx0fnGynzcMaWAJcBrcHilHI1x1s8ygx2Lh0FBv8bTWjwGZbDA6K3k2DZIKCNBpm7yTvvuVvW67XmLFT/9QLcUjvuNfXcOBmbFtkuXTmFF21srPR2RRkNdeUEVEX9/YZnbU+F4BGhkq3y2h5vm0Pzst/3sC/hGsc5k7s75Qk/g6S7LuJPosQ31HZwEAAUTNwyymOVTrWB1GYg8vTbP7kCXMpBR1Vr/Tf/iuNBBBGEMCx+4SUolXh+Tp/Kdi89DZdNlmy6mgkqw0bIY2d/mjucIVo+ovafNfvg9oF1F7iqqk1+cpq+bIwLW3D+4GpcR0/If5Lxw6/XDgv8wN7hP2aO4jPxMrFVk0+dL9pb9sOjuFnfw2rpUvgapt+FmJX5j+ILIZWykgUGIVzg97TbgMqvNeEx/p7v18gLRxx/hr9kEHihaFJhS3rWL98vvrdQuQwNOWMo8TlSK1MVG/dh0gho9st1rBvsqQtWOsZ0V2kFy7QwA2w6EVC1XZ/nrqUyoj6NAv8QOJEAI1P3aaqj2KvxUl82jjPJrlV780dcmp+O95NeW2hcisqkRzq0YMjN1n06gt2kHeJwwcjvUa2AvNul/QgofvB3S2kaVp3cTw+9nDUeCLdgOAwqE+sNpj+ddLAmuRC2Dx6Tz+/lgCPYi+L1RbPio9yMypvoRPa9syY
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(23010399003)(1800799024)(261026121527099003)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(56012099006)(3023799007)(261021123027099003)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OE/Mwamv42/2r9ZkviD3Fa4EMDijVcMp6DaTuezXzhD/jiSCFTGKDBlQMVxDso5rJjl86KwPF5OMMMeflZrWLIHSTslW1yEr8ENiJy8p2Iv3/XmUNcvcJQqKvYUDIHNulg9SllGXi+kJRQ0GH/DwhAI/pRD4L9jEejWqa+8ZktBLaSYpuN4WVlVQJHswKqitB+5zqSDhv1Zpvja34iqHlH8iJasywqb2W8sY1t1I6gXGuKpc2OI7Dk65E3Rfm4aJ6bsx+qFhCib83e0QWGAgJuXqwqzW4a7gN4TtUBnqpRCbohWC43BW8yOLo0TlrTlR4mw5fhMzdDCgaI2EoT9o9KVMMSPGOJnHnRT20bsHJEs+dnh2YDpTtFcoU3qQQ5JjLHRAcMT1ZaezybBC4Vo0Qp7IMUtqpI+eZjM9hIj1eUb5M38kPcUFcs0rC/AIns7r
X-Exchange-RoutingPolicyChecked:
	pYmFYnJU5tmkDKV7GTtssc20FYqCdjtrpKKGeI0DWs4KL3mxhPGR08mhTMO4s2Fj4nqml06ziXhQ8b5J989DS2x1keaFSfRoKqkjtvBYupYGHpYrGQH9lZPGSx0Enj1gVfswZBnRKZ/ie5ku1mXD/OXtHQTPYokEI//kV474Fdj6zew4iQYwR0e5/zVUEb4gR37J8XMSdXz3A83CA/i0m7DGIvDzbZjC8csa5+DgJ0X1U5Y7wVTSfPk2MN6UD//5U62DjPPn4lDHrnZp2niBzfx0Wx/dpEVGgeBoLLzIsc+eB01VWp7SmTeD2TMNZ8tE9dSVYopoBHRGVCCY1ZmZJQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:01:12.5673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e01ef-2206-4a56-15c1-08df3b2c1af8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997844
X-Proofpoint-ORIG-GUID: yTP9iIlI4LrOmMAR_MxSCEfw6-qFBFRQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX56KwXk0FAN4k
 MZmcz5BH3VDpY7uuL3CMuhxH9VekJYE1UvQ9FH4N5Hj9U9VyCrqVgDFSNPYFdr67puROm9igQW7
 /VK/08yBSQGfYDPjrRuZO8+1JEpbOls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX0/CIkZnRNbPL
 TObLPKq+RxBT7UNBOtaSaWN/KNW0Yw0/y1cg/2KUN+idR1heDsvtKojWuTyltnupfCdpUBtk1I3
 RQxGaE1bKaBClz6xvr7+pg0cgQIblOdLiXrtS2nGEnhi/vQWDrqhMh8xciAOpS6wUQMXTp5/8CQ
 nagb3s9hx5K02Kid4NtZ6o/7yFY6maayEfhA+u2NVz12T1iL4dkrtrdqNY2t3mdKc1zemprNimI
 q7auf0DDd3aTc0Sl5+1wqbx6LEFs3AFFNa6jzTh0bcey9JCOlRKi56FluY3E8oTeivu1c6qDmeN
 8iUHzxCazIuV8vL2MzS3n6KwkdwI3dxCCbpZT8sLZ/DgPTl+jSbiDYSCNo9ldDBBn+B4z4Ak3Do
 Sl3lW6okOga8mkOGneSYI2wTVjQy63RnAlQhSLFD/f4acz3mge/bPsGCv+ZYg9ZDC0FwKkqFiac
 FmVyCYIviVKlRgBaACA==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec61fc cx=c_pps
 a=J0oTDZHsw5jmD/+vARdUUA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8 a=4qKnfErNU7RVUF9lCTYA:9
X-Proofpoint-GUID: yTP9iIlI4LrOmMAR_MxSCEfw6-qFBFRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

From: Pratyush Yadav <pratyush@kernel.org>

Extract spi_nor_spimem_get_read_op() from the duplicated op-template
construction in spi_nor_spimem_read_data() and
spi_nor_create_read_dirmap().

Using data.nbytes = 2 as a non-zero placeholder lets
spi_nor_spimem_setup_op() configure the data buswidth without a separate
override; callers replace data.nbytes with the actual transfer length
before use. No functional change.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 90524c58602e..d114d828a788 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -189,6 +189,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -202,21 +233,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3491,28 +3515,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

