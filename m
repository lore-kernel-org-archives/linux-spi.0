Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876479;
	b=zP6qUgL+TNs/0/F+nZd0GyGOZTb3nWnnp6P6zDzZIyA2TBpAIRK8u291Jp9XnYbvpv0I
	 gcE+WuWVdQQESfRaAzccxa95c2Mv/h3uv6JCY79/cmHCCPnj/9Lt9bvp6lePqSiWphRjB
	 Wbu/o0KdvP525L3v1c0A+9Ga8CCohUEYD2RK+fS1a4fQxxJfekwmYU93g39Gq3uaoXy1n
	 QXzWI/b04dAIutPQJLGCFdFBugclTK+QAqjEt4T75bHWbiKYK3cP0eYhP3NqB8JzxaffQ
	 02XDc9AjKSMcqp5OpbX+g9/n2M2VhAFw/iq8OnLlbNw7fkK2RVUGkI/4O7nx2baOKCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876479;
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
	bh=aAR2IsmDPo4C5FMP5gnhZ2BxDUxKQsurPIetzViNWG0=;
	b=Bd/aVPyObR2sG0ipMoUnmdUUSd6yvGB3xV+PznYC0AD8j+iTvjPP8rHoIqwIj4ktBjic
	 a08B/lZVyVo7A2awa33mQIMRXplHee/GK4MbvdIRxx468CBpGgbUCTnG70WdDu0GGeX6M
	 rKZqjrwcmmXvZIl1Z35YZQrVo6zO3ZzGSkqW/6ZrJK0boFgp5GUD59DmhCJ/lhz5M86ep
	 ASOSIRd6xJPEMgLrZ4iz2DN2rf6NP6MFluPq8ivpLUk0QizZj7V60Zv9nJRRn4o/HtKTu
	 bhf/uH4+at/uNHnURDH0nE+kUKuWYLM2gKGY4tVZ7aQISBAvI9WGe0TuGTU+Nnppu6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TSR084AB;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=fIcZ3kuV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA470606A33C;
	Thu,  5 Nov 2026 11:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA470606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TSR084AB;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=fIcZ3kuV
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59wHYn2215002;
	Thu, 5 Nov 2026 05:01:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=aAR2IsmDPo4C5FMP5gnhZ2BxDUxKQsurPIetzViNW
	G0=; b=TSR084ABK76HbqrTuZwXCHRm2u6/9QPnCoFL/nIfg5OTf6aisTfuTb8Mm
	D877WDqv8rG8ZzezmIrQ2LG102idcLnPcXKm8/dUQzwgdZPhZt6kf4Rcxhq9yJAv
	A/k4H89kSJpuPFwlt3RJ7fHJZoFZfzIlKsP8kUjAZhSBMEgjUebvnPc6oHmFdPEl
	ZVrtiiy369ddQuVs4IPKbS4izJr0vv/6Z/yYjs7MJSF7wCWA3/DSdUyOT8mlRwj3
	CHHVrp9p1BvBgEApt74OjakqdrLZ2fOZzXVNMV8IB9zzlg+B+9t5sb9ODK6CCnUn
	ppjRIZY5M/tORz07+JoXeCDPbiMLg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hrgp9k24s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:00:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge2t6Lqm0XgYN4555JC37FjWqplrQzkRTYcRE+c0q01lBLNxhFAfkolCX/wz9jKQEv5hcdLWKhBhsLwA69fuB01fjPF14B0uZzqZe0fa5EUoEntAfUBaPdt4/AMESMhTpWWh4rPH7vw4/OXDCNOIIL+YEYwdP0/ketykmpdk2KAEYzAWND/1YZAeuC64nz7TSYHjgNnpu3S97TkvelFbi/rgcOo2K5M5GMS5+Va1YTRQYCgzDjoOGIsz4c64Dp4ITM/8RKSj6+V7HnZwKUvlZSyllDadiH0fVdtT9c/vgi1AmV2wgWagYglWIFHMU0lO4OYszqIOP/hbw9n1+UKXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAR2IsmDPo4C5FMP5gnhZ2BxDUxKQsurPIetzViNWG0=;
 b=qmQ9sDgSacCHOU7WTNOfUKlNka5zX448yZT/WD/bfXRUte56LDk0N8U+lpuPSyHAD0FhCj/a3s5bB86qmfXwEFR0zO8UgXrlPlkfy6XCpgxlNhs93hLBbBtUhKIXlVFPFlUhv0dXEB84GwK1Qwyv3HoqVj0fD2A7mgyujNzmzoemjrf5NMi6RYehAKCIs3hR49pIsrkHP3Lo7vSSf0nhYoIUmKl3xDoMiHToPDrY7qnVrTicRV6sf+IkZzURdNnnOBQHZL5ugngMI9RXLbAybb2H01/Yc7h2XuoVUBFeS8jKwXnfFzwdvJOMnSNZ2aA7eK/q5pfuU6+/ntMlxBCKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAR2IsmDPo4C5FMP5gnhZ2BxDUxKQsurPIetzViNWG0=;
 b=fIcZ3kuVUfRW0dbqSdtirlfzWUZ2B5iKeqo2bF5fWZQpjb/J1vOo1tWoVE3hgvakr6kh8I8aTfSImXuinnZjrF/8Mp0pgBofRF7UCsmqteUnutRX5gez1lKDLEYvNo2LQhqeHh7oar2HNgCnwA6mqWd3oPy/Tb3gnmBiDNNxBTY=
Received: from DS7P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::17) by
 PH3PPF87283933B.namprd10.prod.outlook.com (2603:10b6:518:1::7b4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:00:57 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:8:25c:cafe::a0) by DS7P221CA0025.outlook.office365.com
 (2603:10b6:8:25c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:00:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 11:00:56 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:35 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 05:00:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 05:00:35 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2R4171076;
	Thu, 5 Nov 2026 05:00:29 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 19/19] mtd: spi-nor: reset max_read_op frequency for security register reads
Date: Thu, 5 Nov 2026 16:28:32 +0530
Message-ID: <20261105105832.2134313-20-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|PH3PPF87283933B:EE_
X-MS-Office365-Filtering-Correlation-Id: 686fea99-b6ff-4fb7-10e1-08df3b2c1158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|3023799007|921020|10067099003|261022075727099003|261102123227099003|261009223027099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	T3lTeg/bZqu25SdRAevfAue4Np6jcOzabDAcO6x+dl2uh/PSiqt9MUQmkMIilJrPtqIrwTxId7mbH1MW5TqlnyOsOIMpRvgx2ot0223hyGJPpWvGd0lHg5sGqdWItCYN14D/g+9iqlpQfTBLePFuGoMmhqJLXDpPOmBBB7tF2Rerr34iJsJeTzD0HZLksH07h+IAdqFkhNxGYjLBmwAH5LlhE0c3v+C+MxappK0VELJsy6ZwMbpQNgXB03kEPFrJe+n1lu/ell9UyComlGYDTG/08ZR5J3QwwsYl8692GxYO46160H8rx2TI30ZkY7X1CFis/XQh8eAHq4Lac8TigUuXieFekFHKaWERYe7Dw0Qb/1c1UQtdAz0BGQUi6wPfb2FsBZ+mVBEJnnA+GPNBg5c6vUb/ov3Dd0ovIGd8C33FAznHc8mznVYXxsnLmB06i8CqbIbgBaeVL3nQxrKpaAFmEbTvfm7I7sdgryLLlxA4ULTH6nFiblLFH2mwuKRk7avD/mMr9o+3tIRxwbs/uv7bKeX4nkkPJThU2QbviIJEmCmXNfp9wB6N8ozSp9K51u+12bcWoe4J4odGpGDWsKVTeOTTolgthb1p5pDcYgqO7mP/Tc1XgMlECYOelxirvvW329d5WO44qhiwkqqM49Wwmq7n6cTkysoMtyF18ymrR6CXcWGZK3fZ+1l1v8wgEs7MLSirBWZ3IiqtqPof58dSYU2Jfug5D3gOCOLKjiX/3TdRXTFXLD4IyjT0QKhy
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(921020)(10067099003)(261022075727099003)(261102123227099003)(261009223027099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YcSFuqTSkspCBaeWx+8KmnA38EjhEtiCbK4kFH8bEZRDO9n+ObO4dMbQ9ft9pTUZImtNmsfimP9dD6ozahMicR589Gcbvh2gLZ5HQdIJCN1P+RUjjJp2JVxb3VFwqsg4i3DxhNZEh4Us89jg0tR1Vof9ReQIE7i8V/c/a06berPbbZWruNRNgwySS3pJK6fNmtQ5QsJC0IwV+FYzEiu+XkpWuLftlCE9b2+5kRw4U+8PjExylbcPxzqzO0ANJP/XVTBn0J/KQ+Bwskh+07mAdEEPCOlD273V+febrrIRKR2jkTkFTrzFo9J9reRGCnRgBPGz9SnOV2m1yd4y/2OEMmI/9smO1XzhKgVMYCHYuHoSFq6M66rBHtHz59P/JX0VQaxnxYY0Fh+GiXouK29K0xWj3v2t+nzLnNgWPyD9LOlLcps3K13HZAzeKLH8RFQB
X-Exchange-RoutingPolicyChecked:
	1SDXqJNBV0uOZFEQmRDg4P/wsBf7IFzPM2xX6P5SGLHfWcrRfJALl4kpeRFRY2H90krzQqQ69G7616GOFfHCYt+sWH7DY3iRfqWrBTmeq/Pdq2yc/E0IqNtyXqBygbJRe7xabm/fLtW+Hi4g57bvYkdNpjh1eZNQVXBg9il/04oZmXEvvf8+PGJiSmyOBnt2WHpYvlfAG/iSY2C8DpnxdIRfvA8sRfNQr9ssGx4KvaPcFcVRlUwJUm3GWZY26+ou8t8Nf/kz8z195Ngf8l5OKWS8bmDvPEBjbbP1lBKPALa0oQSej+tj8qOU2GtEMrche6FBSbQ9kYzRmF75f+HyLQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:00:56.4544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686fea99-b6ff-4fb7-10e1-08df3b2c1158
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF87283933B
X-Proofpoint-ORIG-GUID: WAHN4wn0hDdZBUwzB0Y11tBkZPGLvoWG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX1BwgfXpCD3Kj
 qq2Zf6THLjtYu6qnMfwEaxdE+gPKV22hcPEEMSDT/hTXE9Oi+/sB3PH713R6XWzICSQbIl+P5MI
 /Rgj/wB/PlYTTIHRkZVAzOaRnlBj6dY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX166cA+pvr+Rm
 w0XuQ1cUmHGDM0yCKEXAtq58I7DHKOyb670Sn6dU0UMylOExXOT4RNQuHwZT82Fg4OrvY10KiLU
 zYnNhzipV9ripXKVFx8E8yPhtKyXesNo9+w/YjDnuXr02LyVnyamk/TGQF3cSzLqqd81g31Xb1B
 nO/KCbU2zdyzQX4waAaIPPAj9hEnp6PbwvSt+frw3cKmulDBwPZxtwYmFADKItE4dxrXdfHkVhO
 LqZJlsYSo3gSgSVV0pBL0re5NAKahQPkt9ikHDUd+kpjxMUjieln7oZK4LMmtOZhKeIqf4uYvSN
 wgvTK+4nqv0hKQ1yvyZOVvq/KOnKB4LV5emVNoqZ97X9XDxndtjRhhM1O5jJmMQ5e4ObEwcXVe/
 /Eeu+NGDZ7H5W6kaelLuQGbNMn0gIa2iRRCJITMOiRuCbShQOzpiJwY0+xEpM4bPfY69ogGgSas
 q9DWvgieQVVj90snbEw==
X-Authority-Analysis: v=2.4 cv=D+jSufRj c=1 sm=1 tr=0 ts=6aec61eb cx=c_pps
 a=5av3elwsUCsOTZAZyay1PA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=lYk-SqIzvLeQdPIeDaAA:9
X-Proofpoint-GUID: WAHN4wn0hDdZBUwzB0Y11tBkZPGLvoWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

spi_nor_otp_read_secr() temporarily overrides read_opcode, read_dummy,
and read_proto to issue the RSECR command in 1-1-1 mode, then restores
them afterwards. spi_nor_spimem_get_read_op() already refuses to
propagate the PHY-calibrated frequency onto an op whose protocol shape
no longer matches what was tuned, which covers this case: RSECR's
single-wire SDR shape never matches a tuned high-bandwidth protocol.

Reset max_read_op.max_freq around this call anyway, following the same
save/override/restore pattern already used for the other overridden
fields in this function. This keeps the security-register path's
safety self-evident at the call site, independent of the shape check
in spi_nor_spimem_get_read_op(), and keeps it correct even if that
check is later changed.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/otp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index bb9a801b3ceb..9a25953f5ea0 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -39,6 +39,7 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
 	u8 addr_nbytes, read_opcode, read_dummy;
 	struct spi_mem_dirmap_desc *rdesc;
 	enum spi_nor_protocol read_proto;
+	unsigned int max_read_op_freq;
 	int ret;
 
 	read_opcode = nor->read_opcode;
@@ -46,11 +47,14 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
 	read_dummy = nor->read_dummy;
 	read_proto = nor->read_proto;
 	rdesc = nor->dirmap.rdesc;
+	max_read_op_freq = nor->max_read_op.max_freq;
 
 	nor->read_opcode = SPINOR_OP_RSECR;
 	nor->read_dummy = 8;
 	nor->read_proto = SNOR_PROTO_1_1_1;
 	nor->dirmap.rdesc = NULL;
+	/* Security register uses an untuned 1-1-1 protocol; force base rate. */
+	nor->max_read_op.max_freq = 0;
 
 	ret = spi_nor_read_data(nor, addr, len, buf);
 
@@ -59,6 +63,7 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
 	nor->read_dummy = read_dummy;
 	nor->read_proto = read_proto;
 	nor->dirmap.rdesc = rdesc;
+	nor->max_read_op.max_freq = max_read_op_freq;
 
 	return ret;
 }
-- 
2.34.1

