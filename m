Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A33876CD;
	Tue, 11 Aug 2026 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473314; cv=fail; b=frhGdsWTzCPuiBA2G4SCKIlYJTsHnJBKGgVcvP4TS2+yJ63UmNW9Llnyb98FQqzPIumee7sKi6sTG+uIG76mvZJJqbgy3IV3z3P8dJJHsw4jt7qf6fxq0aRKUPxNFM/VgrZLTv510wr5MhH2lEn7/HuHBZwg9rZmmxzDPPel/xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473314; c=relaxed/simple;
	bh=LSX7xJd7Vwgm/bLKXPcZ5cLE1NFdYkPDcnBIWVQEjBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/fam5WQKknvG/vhPr+G3mMCn1J8sOeIZ7Ee9q0jUxcGJYIim7XdSTWVJuSD70ljfVPqGDSOtMMHAGsP6MdXC5c3WyNCATTKo8cEtsgDqjYkWKC2eGbvWL/B4ip48vUlGImCIJDIPtbWU4O1nTmijbGetoJzg0vxBgpo7XVJzTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=XSb51lRR; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jfp9rhaI; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="XSb51lRR";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jfp9rhaI"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGM7Cn1823863;
	Tue, 11 Aug 2026 13:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Klw+Hpw7Xo1fMhBviBQ9oPnuoGquCmHUa4MOBKs3e
	qE=; b=XSb51lRRBf8hLqeKwNd6N4vuGXQXawedE2Yct2R7L/83EWSRA+CcIjlwr
	i9BKof7pv3Rnzht7M9NnZBzEeycdHuB/gGS4gA/lErK3crKgsqhmBPO/3GvahAXr
	qYyz1bG4+ei+XabUPBIArIjjl3YHTMRtzvo1IvVinWby6vva/bYIIG7oQi1s14KC
	tJwzmXzmzNzTwDAmzQVl8caoO/D8DPhwbtKaD8HY9UHoOuZS3dljpYMalYqrwRQQ
	NptnQ3gwmx6jB+XABu/0udq8NMOh9PG4OBZ0BoktF5LGgzJxGSUcTBvunaI5UlPg
	GHNa1QLT6zAMzeX9tWPBvS1m6Le3A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00wnbkap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+w8ztnwp/pCbwV4KTJaJTeVfRX7le1fKZDM3F5txE/Oq8cXyk7gov101wWQMXc3Kcl66Hvn7tmCe+Uq0ubNC2TwbXmqmgCjS6g9mLW0En55nWJJZdl6ej/DLezCT7Jd2fLXn10+bAkvFpPOD+s2zkwae+/I6hMolCaHpaWOsDNjFD5tnYIaFMUNWb8mvbnbbbQodqGNSAhbE8RXTTULWI3AzGX0c7ugWGzhLDM6VL21DatdVmVwkRthTZIVwcDFkrl1eJDBUqHAc8KVLw0BukMukRpPIMZBwvW11NpZaUO1TY/9T/qt+qWSwW1qA4B3IiW1DvHrcYIJIsEY12Olcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klw+Hpw7Xo1fMhBviBQ9oPnuoGquCmHUa4MOBKs3eqE=;
 b=t01rjbAWc8j4VMqOkf67zbkE3w8/9LPnYv/xbQ03jsPlyKenSpGLRKhtJWYLzTOq/WsK9Un34LK/lKxk1asSPmkZ/KihSTPp86dstF6e+TLJqa/eebalFRNDHXnIfI2yqJAlxGd/9XG5l6eNhRvRjGxjU4BMUIc5kNCXt7fk8m/C2/uXLY/E9QKvViROYm78QbgJOytLen+LkBLMEEDsbNvyI0CRJpYXmWqn/F7fC7fQ3w6KxeJYG5GEcyda/Y7Yh0+ZV60Y0cj51kwqyrCLuua3VeV4V6Zik4CgNvFXSPhRiUWI+Id4mK5SZLemSK9LJEKnzGuII9xpE/YzHdxaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klw+Hpw7Xo1fMhBviBQ9oPnuoGquCmHUa4MOBKs3eqE=;
 b=jfp9rhaIG/JYjVhKeZahtgn8eScOYzhtn/9fmvTp6SdwcgNUGu0sFQI0O7ZWpYlbVSxOTp5SyL/EvLTx8hO36np1rtVLAGeIsnKic0mygJqv+YWQyLAqLepvabF/vHfkJUKFTwPwQPga5phbPffgADTmsyTQUbnKt/WE+rd875E=
Received: from BY3PR10CA0015.namprd10.prod.outlook.com (2603:10b6:a03:255::20)
 by CH2PR10MB4149.namprd10.prod.outlook.com (2603:10b6:610:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 18:34:57 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::99) by BY3PR10CA0015.outlook.office365.com
 (2603:10b6:a03:255::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 18:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:57 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:42 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:42 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe8659766;
	Tue, 11 Aug 2026 13:34:38 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
Date: Wed, 12 Aug 2026 00:03:11 +0530
Message-ID: <20260811183313.1550425-17-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH2PR10MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0f082f-e6fd-4037-858a-08def7d73e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RchTOJlqCyWR1g5FnDhgXRgkd/9OaUGg8yXZfHYTJvNSNUzks8MHvWZ33Zql5mehTkp79ItkaaXtSFepBR5bml7hgjNnqmYglS28KDmxwJgsl41kNXaUCOoNIfXrDOwt3xpyA0dlyKfVNLLJ0MHO2LEQsoSIBULtjjPi/HqTApipv8LE9syhyH1GCZ6/yHX5adO00XOdG0XYVEajd0sMDTQSBAX0SduEk1nONetYp9EWib6K6OyAG8EL4MToJ5JwOjOVal40QZ6PI9NJh4MqrNkzzVzLYQ/7Ul5rkC7a1KzOLt8Xcn3BfNqgNfkunGkyJNCTJmzagOtsbxEajIrh3WggcHDKCCk97acDOtzQ0ow6bmHHHY5LnULj3PGDDA7O6Ujt3hsT53YT57xK8NPA4gcBJ8Ob30HcNMYM9rCXXj/C9MWy1iRnXXskOnvXWnalo5j1bV2HJNMFlloYL+VhXxXTE1VsybfvOCiFqO51erR4fR9/3u2L9vSes4HBEQRYwvvKqzYsm/wpdIs6ha7/KBXBu9HGFCUh3VX2wP5bbJ0evYR/RUXEpyxXD/T2IQYTjl1OvmEIXfniZQxFqVUfkt5Qfvw6r4DKpW4U+EI6pzgx97N1/DHi0lCTjFVg/DR0RNDJTijHPu5uyNyL9bmRFZ1PCfUMsljVcSee0NF5t+iqCqPY9bmcD2OoLgBGc5D2e6uL/TE1QKczk9lLRzoTiRayilSpAe7cBpN1H4nWga/5YZtl8YEq9ZsnvkjSU6Kh
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SCo6i0D3v1jOahkNo/VHQUSVyQZGIma/BCF/OCRXAQ/8MEl6HXs7SkvWwJw6iO5as9BsOyllssO5SFpjCQSe7IQsdBiFjzz5oQNE4g3TZWgNj1ExKzwZP745bMfauTLeZOabkq4lryK7czi/g+JXLbSZ+T51CD32KedQoXYZWGdbxA9duLUcVk9/BGZo6XzuUzEBPVwgFi6kmDJ5yYax6Rf1H8X4cRRrflxWt6U1fXGJ2v4jzfmfPPZNuHu8c0jyKK+3aRV1VM7TRAzyAGHg5MDUJfNqVXV7Jem7MfOyuFqlJ7KvcEqrIXIwSb0x9uWN2wmTdB3HLqhVe3MbpT0AZsME8DMH53gthJVUZh+usQqOLkFUMqjaQrHZTERyxfBG5x1wGC4/6ruFWAmQTql17eZs4rjfSjMkiecG4di5l3lcRQcq/FGIGdoBTlEQoYSM
X-Exchange-RoutingPolicyChecked:
	Q+RExGnJbpOx6J7zqsnz0A8ncouI2jHs2gP76z3qVFIwk8IX8lojhlAzwsOc0PTh2GGgK+8gnlEmElgM0A3Mb6WMQxiWZJsiNfhUp0BBsFP0RR47KDBOnS1iL968oBV+TglqAhCjZlieqiDLWpxuU+pB66GOAa6OxWNgZoMS4Rl4QfR3vDCCDK1SqOsg1+NtuIHyhzZu6SQG9g/gr2uElm3sz+SSl/7ArTvW8/+nEWNd5Gn68emxJceQ8BzG/scO8KW/eZcnL2crSznWUZdm0KmMANlek/T04KltsikBNxzmVhrY+dm1zBDuZwfD+Pv/nd1kcTOvGnQNAQc0iRfYZQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:57.1463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0f082f-e6fd-4037-858a-08def7d73e8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4149
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX1UKEoF+Ho7zX
 J5a29BCyionAZRxFaC4WAY60NRwhvSEtVHhl8L0fHqUMqwXC2480rjB7rjpl98e7CLv3g2fcmXB
 NT/jc7pKMVVo7KZUMV/XjFvAnnJUSkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX9mejKKNTnPbQ
 KQR8rH9sBLCl6q4OZLkCH0coeEQorTOwsauNqCvnB4Lo1n4EFzBvH1TEJvpNJ9OMr70UOh5vKmu
 +gj0xioceYPqxnexIiRGiVDNltYRlwzS3vJdKF4WeiT3+FZHwRveBQcQ/CNwJrPXizUjGscNHkM
 7xFV18sc9shD7Du42g7t/qCsgtylTRAeWFEwpK8ObnHwxH1TfbXdtXbki/1YbJbEg0hyWfyubG0
 mq5fpx6kW9j6n9q+hbJ2FLsDzVMDKW7vwgBsv7BiKDH2SNWvFfZ+votipXwuKNWIP7ZT8SYL32K
 8r6auiVhyRFwbFKlB6N9qQnBd5ja2rX0ZKxWGP1+sXqz7wIjj/lr7pBZSaz8REzI66Ic69WHAuq
 +PYr23m0gDc2S0HNPZ+YYvf2q/2D9iJZvXhP/Niv4ogDDW2KvDTji2UUwv/RmyNrGBDdTLH/89o
 LDzv0R4CNgbWhqnDnkA==
X-Proofpoint-GUID: 9SAfGmxAgVBr5jA9-Wo3w5XNQA53m52y
X-Authority-Analysis: v=2.4 cv=cYziaHDM c=1 sm=1 tr=0 ts=6a7b6b55 cx=c_pps
 a=021mb8W6rIxzgUEI7A/+3A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=VmYIjnxWTCUH1C-J5tsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9SAfGmxAgVBr5jA9-Wo3w5XNQA53m52y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Add spinand_optimize_controller() which calls spi_mem_execute_tuning()
to negotiate the best operating point for the SPI NAND device before
creating dirmaps. The validated max_freq is then embedded into the
dirmap op templates so the controller uses the optimised frequency for
all subsequent page I/O.

The function tries the pre-selected op variant first. If the controller
signals that optimisation is not applicable for that specific op
(ret == 0 with max_freq still zero), spinand_try_ranked_variant()
iterates the remaining variants in descending performance order. For
devices supporting both ODTR and SSDR interfaces, ODTR variants are
tried first; if all ODTR variants fail, the bus is switched to SSDR and
SSDR variants are tried. On full failure the device reverts to ODTR
non-optimised mode.

Add spinand_reset_max_freq_ops() to copy op templates with max_freq
zeroed before each execute_tuning call, enforcing the invariant that a
non-zero max_freq only results from a successful operation.

Optimisation failure is never fatal; the device operates at the
conservative base rate.

When optimisation permanently selects SSDR (either because a ranked SSDR
variant succeeds or because reverting to ODTR after exhausting all
variants fails), clear the odtr_op_templates pointers. This prevents
spinand_configure_chip() on resume from re-entering ODTR mode with
dirmaps that were built for SSDR, which would cause data corruption.
Reusing the existing NULL-check mechanism avoids the need for a separate
flag and is consistent with how spinand_configure_chip() itself handles
ODTR configure_chip() failure.

Move spinand_create_dirmaps() from spinand_init() to spinand_probe() so
the validated frequency is available at dirmap construction time.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 221 ++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h |  11 ++
 2 files changed, 223 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 7c3341f1fca0..dfc9d0871e91 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1284,6 +1284,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.primary_op_tmpl = *spinand->op_templates->update_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_write_op.max_freq;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1294,9 +1295,11 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	if (secondary_op) {
 		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
 		info.secondary_op_tmpl.data.ecc = enable_ecc;
+		info.secondary_op_tmpl.max_freq = spinand->max_read_op.max_freq;
 	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
@@ -1745,6 +1748,17 @@ int spinand_match_and_init(struct spinand_device *spinand,
 				spinand->cont_read_possible = false;
 		}
 
+		/*
+		 * Save the full read variant list (ODTR and SSDR ops) for
+		 * ranked controller optimization. Only saved when all ODTR
+		 * templates are valid; spinand_optimize_controller() uses this
+		 * to fall back to the next-best variant when needed.
+		 */
+		if (spinand->odtr_op_templates.read_cache &&
+		    spinand->odtr_op_templates.write_cache &&
+		    spinand->odtr_op_templates.update_cache)
+			spinand->all_read_variants = info->op_variants.read_cache;
+
 		return 0;
 	}
 
@@ -1923,7 +1937,6 @@ static int spinand_mtd_suspend(struct mtd_info *mtd)
 
 static int spinand_init(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	int ret;
@@ -2015,14 +2028,6 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
 	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_cleanup_ecc_engine;
-	}
-
 	return 0;
 
 err_cleanup_ecc_engine:
@@ -2051,6 +2056,190 @@ static void spinand_cleanup(struct spinand_device *spinand)
 	kfree(spinand->scratchbuf);
 }
 
+/*
+ * spinand_try_ranked_variant() - Try controller optimization on variants in
+ *				  performance order.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ * @iface:      bus interface to iterate (ODTR or SSDR)
+ * @tried_mask: bitmask of already-tried variant indices; updated on each try
+ *
+ * Iterates the full read variant list in descending performance order,
+ * skipping variants in @tried_mask, and calls execute_tuning on each until
+ * one succeeds. Ranked iteration finds the best available variant without
+ * re-trying already-attempted ones.
+ *
+ * On success, sets spinand->max_read_op and updates the matching
+ * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
+ */
+static bool spinand_try_ranked_variant(struct spinand_device *spinand,
+				       struct spi_mem *mem,
+				       enum spinand_bus_interface iface,
+				       u32 *tried_mask)
+{
+	const struct spinand_op_variants *variants = spinand->all_read_variants;
+	const struct spi_mem_op *best;
+	int ret;
+
+	if (!variants)
+		return false;
+
+	while ((best = spinand_op_find_best_variant(spinand, variants, iface,
+						    *tried_mask))) {
+		*tried_mask |= BIT(best - variants->ops);
+		spinand->max_read_op = *best;
+		spinand->max_read_op.max_freq = 0;
+		spinand->max_write_op.max_freq = 0;
+		ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+					     &spinand->max_write_op);
+		if (ret && ret != -EOPNOTSUPP)
+			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
+				iface == ODTR ? "ODTR" : "SSDR", ret);
+		if (!ret && spinand->max_read_op.max_freq) {
+			if (iface == ODTR)
+				spinand->odtr_op_templates.read_cache = best;
+			else
+				spinand->ssdr_op_templates.read_cache = best;
+			spinand->cont_read_possible = false;
+			return true;
+		}
+	}
+	return false;
+}
+
+/*
+ * spinand_reset_max_freq_ops() - Copy op templates and zero max_freq on both.
+ * @spinand:    SPI NAND device
+ * @templates:  op template set to copy from
+ *
+ * Called before execute_tuning so max_freq starts at zero; execute_tuning sets
+ * it to the validated clock rate only on success. A non-zero max_freq means
+ * controller-optimized; zero means the base rate applies.
+ */
+static void spinand_reset_max_freq_ops(struct spinand_device *spinand,
+				       struct spinand_mem_ops *templates)
+{
+	spinand->max_read_op = *templates->read_cache;
+	spinand->max_read_op.max_freq = 0;
+	spinand->max_write_op = *templates->write_cache;
+	spinand->max_write_op.max_freq = 0;
+}
+
+/*
+ * spinand_optimize_controller() - Negotiate the optimal controller operating
+ *				   point for the SPI NAND device.
+ * @spinand:    SPI NAND device
+ * @mem:        SPI memory device
+ *
+ * Tries the pre-selected variant first.  If the controller signals that
+ * optimization is not applicable for that specific op, iterates all remaining
+ * variants in performance order.  For devices that support both DTR and SDR
+ * interfaces, DTR variants are tried first; if all fail the device is
+ * switched to SDR mode and SDR variants are tried.  On full failure the
+ * device falls back to the best available non-optimized mode.  Devices that
+ * support only SDR skip the DTR ranked pass entirely.
+ *
+ * Optimization failure is never fatal.
+ *
+ * Note: tried_mask is u32, supporting up to 32 variants total across both
+ * ODTR and SSDR. Flash devices with more than 32 read variants are not
+ * supported.
+ */
+static void spinand_optimize_controller(struct spinand_device *spinand,
+					struct spi_mem *mem)
+{
+	u32 tried_mask;
+	int ret;
+
+	/* Skip entirely when no post-config target is configured. */
+	if (!mem->spi->post_config_max_speed_hz)
+		return;
+
+	spinand_reset_max_freq_ops(spinand, spinand->op_templates);
+
+	ret = spi_mem_execute_tuning(mem, &spinand->max_read_op,
+				     &spinand->max_write_op);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(&mem->spi->dev, "Controller optimization failed: %d\n",
+			ret);
+
+	/*
+	 * Any non-zero return or a set max_freq means we are done (error,
+	 * unsupported, or success). Fallback only for the op-specific "skip"
+	 * signal: ret == 0 with max_freq still 0.
+	 */
+	if (ret || spinand->max_read_op.max_freq)
+		return;
+
+	/* SSDR-only devices have no ranked ODTR fallback available. */
+	if (spinand->bus_iface == SSDR || !spinand->all_read_variants)
+		return;
+
+	if (WARN_ON(spinand->all_read_variants->nops > 32))
+		return;
+
+	/* Mark the pre-selected ODTR variant as already tried. */
+	tried_mask = BIT(spinand->odtr_op_templates.read_cache -
+			 spinand->all_read_variants->ops);
+
+	dev_dbg(&mem->spi->dev,
+		"Optimization skipped for current op; searching for best variant\n");
+
+	/* Pass 1: try all remaining ODTR variants in performance order. */
+	if (spinand_try_ranked_variant(spinand, mem, ODTR, &tried_mask))
+		return;
+
+	/*
+	 * Pass 2: switch to SSDR and try all SSDR variants in performance
+	 * order. configure_chip is guaranteed non-NULL here: reaching ODTR
+	 * mode requires it.
+	 */
+	if (WARN_ON(!spinand->configure_chip))
+		goto use_odtr_fallback;
+
+	if (spinand->configure_chip(spinand, SSDR))
+		goto use_odtr_fallback;
+
+	spinand->op_templates = &spinand->ssdr_op_templates;
+	spinand->bus_iface = SSDR;
+	spinand->max_write_op = *spinand->ssdr_op_templates.write_cache;
+	spinand->max_write_op.max_freq = 0;
+
+	/*
+	 * Only ODTR variants were candidates in Pass 1; SSDR bits are clear.
+	 * Clear ODTR templates on success so spinand_configure_chip() on
+	 * resume does not re-enter ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand_try_ranked_variant(spinand, mem, SSDR, &tried_mask)) {
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		return;
+	}
+
+	/*
+	 * All attempts exhausted.  Revert to ODTR for non-optimized DTR
+	 * operation.  If revert fails, stay in SSDR — a mode mismatch
+	 * (ODTR op templates on SSDR-mode device) would corrupt data.
+	 * Clear ODTR templates in either case to prevent resume from
+	 * re-entering ODTR with mismatched SSDR dirmaps.
+	 */
+	if (spinand->configure_chip(spinand, ODTR)) {
+		dev_warn(&mem->spi->dev,
+			 "Failed to revert to ODTR, staying in SSDR\n");
+		spinand->odtr_op_templates.read_cache = NULL;
+		spinand->odtr_op_templates.write_cache = NULL;
+		spinand->odtr_op_templates.update_cache = NULL;
+		spinand_reset_max_freq_ops(spinand, &spinand->ssdr_op_templates);
+		return;
+	}
+
+use_odtr_fallback:
+	spinand->op_templates = &spinand->odtr_op_templates;
+	spinand->bus_iface = ODTR;
+	spinand_reset_max_freq_ops(spinand, &spinand->odtr_op_templates);
+}
+
 static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
@@ -2073,6 +2262,20 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/*
+	 * Negotiate the best controller operating point before creating dirmaps
+	 * so the validated frequency is available at dirmap construction time.
+	 */
+	spinand_optimize_controller(spinand, mem);
+
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(&mem->spi->dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_spinand_cleanup;
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5f4c00ae72a7..7eacda949719 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -792,8 +792,19 @@ struct spinand_device {
 	struct spinand_mem_ops *op_templates;
 	enum spinand_bus_interface bus_iface;
 
+	/*
+	 * Full read variant list (ODTR and SSDR ops together), saved when ODTR
+	 * templates are valid. Used by spinand_optimize_controller() for ranked
+	 * fallback when the pre-selected variant cannot be controller-optimized.
+	 */
+	const struct spinand_op_variants *all_read_variants;
+
 	struct spinand_dirmap *dirmaps;
 
+	/* Persistent op templates updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+	struct spi_mem_op max_write_op;
+
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
 	unsigned int cur_target;
-- 
2.34.1

