Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB0332EC1;
	Tue, 25 Aug 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678359; cv=fail; b=N2bpqjrcztFQovlagTgW6MFfhaCbforYtDbGXMIbGwuErkFlOLpOPqt5LPWi0cfbgUeDGac9lphzyisLG3CReThbs4MD0LyL8taGNVmqsMEFNsyxHDAIUMmwHc6iUHyUp1szFwrOA1VViQ3mRAWLLUZJBa54cpDKX0HQ54CesDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678359; c=relaxed/simple;
	bh=ethEtAEy2ug0eWMGebkCcVv3cK5/02J+qMrqHw8NCXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE/vBHzSji9+1qwUuNh83ag6kAM2v5yP1wtBjhImO3oKMLcQa9Wsd0O8/WqdvT3Q7DfvMh/X7eEbX5uS1hLQ5D2cUGysxIZtcuM83MywIq4Ip+kIoiUQ0Xain5QGfA/nHFiZJm+XUZiibyTMVI6CMGG2YkTPCLsJk+jzT6c0Alg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Fs4vE9iY; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SfpZLdzQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Fs4vE9iY";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SfpZLdzQ"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVBlo1690193;
	Tue, 25 Aug 2026 12:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=59mu2vUYYmgDiChzc1EArKTAI2d98yMuT7h9HRGp/
	2Q=; b=Fs4vE9iYLdlgLbMmPOezQBF4LarocexRuajn8iQN++Zak2qRWtKvvZjjO
	RvsNcLK2l9G6+04aT76xnGILRFApeeqZq1w2ihuVLQYrBJlbAmELp206eRIJK8o3
	fnuhRDOdkN0xvLXnTFi6HcETgFEMW1clsv6ARwKEFEPbMXOmmurgtdjhmzaWpEYT
	L9tGvwd8Twr0kvSsAcHQdf2rIatjlFFRsxQk3Tdg3BhTrYezN1+cxOMmWWmiarmT
	QQrPlfq46XDnj0wK7og3u1OQjvGPuqAyB+/X4u/Gc0ZWj/mC0ZdtJkGkZ9ypP5Ru
	Ey6N50X9qgg9S9wrWJreu2H5OQPFA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g8xf0dc0e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiFiuEFv57YSWJyz8rPhjbyDnCtxAmfChdOIAedC/Qe4PLAStU6bqJIkYpWaFkd6ON1E3Lm6fAo09mkHBebCIq3wUSohLb/xk4LaY9maUBUfQ9eihBZ7LZxn0ixFGfAxfd8k659MnACa9RZHEyR468yFhw0D29cZBMQE010rjNJ+1mq27nTmTzOAc14Uk6KFeLloY0HxJymSmLk0xgUcPeHKST7U9kqOZRuSIT8l2QGMUzOBDfgturUgs8PQIHTHsqZVnn6f9SDmWItVLB50s1+4HG+/Kn0A5KjV0AlVAbto2uMM1FbMz8cr1LBW4Fo0XDO5Jm3ZBr4GrNzmLFFP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59mu2vUYYmgDiChzc1EArKTAI2d98yMuT7h9HRGp/2Q=;
 b=i3ei++0lUn/sHi/GceUqMDX9DdO5W4TDVmhduj4FZWt4TDY5LtE3mR9+/Vy6qjVE+yKv65ObXcgs+9cf8H2C+fce3mi7YIImcE2EKMScVZXzOR9lpCb7aA6UXA4P1eF3ETm4Vnia8lWCq0Lvbeg8EfC6sjClIRs9eGc6xmVlk5ZmtnCxoVy8HEOsliZywwEsEbEamu5qV9SltxJDT+nWyiSuTTfuMvciDfVeN1km8gC9juNcSf3WFqK4xuQ7XhaHjB+3KuEvhFzttdTKyyFbd0FRvnWgwQ1USC5Z46fRgnNPo7ggYNz6buWpp8mlxnjeqi4erNeipMu8FP4yQFQpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59mu2vUYYmgDiChzc1EArKTAI2d98yMuT7h9HRGp/2Q=;
 b=SfpZLdzQE8nyxfyrwa8FTAOAAtwoDjqAAVYFKr/Y1v9B6CGi8IxprGsE+t1J6HpcYvTd7kuSSzxHUw2CRNSImEhcfvrNhFnLIsCJA1TE09mcOj+TkjEkCd4Dtg7od+FWDPSYXGqJK28fFJ5SXwE3pPcpcw6N76RsA0/qiIGFYbA=
Received: from MN2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:208:23a::33)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:19:03 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::66) by MN2PR03CA0028.outlook.office365.com
 (2603:10b6:208:23a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 17:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:00 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:00 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:19:00 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3c1436664;
	Tue, 25 Aug 2026 12:18:55 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Tue, 25 Aug 2026 22:47:32 +0530
Message-ID: <20260825171737.776052-14-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eba1f52-48aa-421f-c653-08df02ccf493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|3023799007|6133799003|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	V/z73YH8Qzxe1tfd6Xd6mRXcirZDLlpZutRDjw4gBEJgpsiJ1CcMIGDcyKfmMdI6rlxM+u3gbtYe6gqBXssHtXPp9LL8GMY7QsqOc3TbsJQCZW13sGT19h3PTWUmAyAFOeSKgJfLEBccAfivQXpk1701djjhZvcwQ2KynCWiu4i6y9fRE0RAxPZ1Osuf/FN7n/tXx9qfrUi5Q+i66hEobX4w2ZWwJz3ZBJinBGZgiuPvIMvkr2rCYzDpVaiOE7aDXTmY018edzvBavK7FPanzUGoEGLgc/Ss+fxkQYSi7QnSfT2EkLre1DIU8noPKSirXRcYb+dLN5o+TLCzcafEBli6D5Q/Exo9fwyD7LSe/oiKSFVJ9YRRLZwLesLDwY37KPEMWLfNQy3vVy86K6GTYyafcf7xzdIqvKS6L6GH6rDVA6jHEEGLL6J33nqeP/xB1/h1rtfQ3R2KR7o83TkFL5unkjyasa/wpgE2x8GJv5BazOcqZeggG0s8H5E3MTuMzwKX3KWS4wJvB4dXQlr07BC3Les00Ww2qPIp3h3hTLMDcfihMfbClHPAEI3jmaGQVLl4f/W+Zc4q9yE5BSqLNMdD2oy4jyJ/tfkKHoGcqqWS5hF2UXzlcwXf80+siwAxToDxgrFRZ2RKN8HXGmdHL/W8BssrIYgEQk6H4BbVVl2TO0erKJ9c3Ib4Kc8rLwIXKjk/acPEJ/15X1mIv+hpHlXzOTSaM4f1spG3yNCVbiJbTYC2uyCjyI8XAumA1DQm
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2YNgWuXPDBc6tjgVI6CfUocbMlSlKZdkqtkw5T3Es4d/nlXM9kfjs9WUd4eCSyTVSCckNtWYtFcZISjkhKf/MEOP2J0zHM1gZqI7pDNXVovViTHi3gJilS7J1/0kUGOpcoJT+1utXUM59E+3UgJJ+3I8QJI/BThWaxX/NyyRRUQvGiayGqa1hAzg6jf0/qi3Gq0eP7qmkoqiZYcwot+WGO/lcrEWwwtVw3fRcRHfchp4SUGO3LUyxRAJHAubbkl8o3gyAIRzrpbPUYr+4sU4fOiwoiXDT9y3jHszt4Z0IXlb2oEuGc5SGk7rkd+xfz6y8aXa7Nh1eBWj8zefSkyLOwQY1EeXOBD3IRUU8Wl6nJLKLZ2FflsEY3wfkuoV/Q4oAVckSuEed17EcQTurDxolCkO5jfFOOqKrnG31cfVQUIYfL++TORDzgFZB7dSsJ56
X-Exchange-RoutingPolicyChecked:
	ijvZfjL5076gl5RQW/u6/9+fbDOWMrOt5s4idpOQ3q69Y2eeVetZsx9wDu5XXpDotjQRVfUoO/3qspM4BgBCjJKwI5bSXkGIq0Y5wWdvozKjAaJupw2CUozBcL3ovqCcwConACc14T+8UU/4rstJjvVahcZYH9nwmgyd+p125h4MvEWAYqdznfRS/aDrt1CuY+rtN5FsqOqXpH1xCBxTbr3f4y+EHFsLYhy7ZD1aJ09ETCftZ4EuIEaXP712RIHX64NYcVXkcOF6v6emHn2lLhUdsGuL4VxbRZfH9nxfRgsGohB4ag2OEHk0IZF6ql+SfKrVG03r4j6UclfWzapw0Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:00.8670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eba1f52-48aa-421f-c653-08df02ccf493
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-ORIG-GUID: 3u4237IVfI8uGlIKRkhgn-CCir29Lh5q
X-Authority-Analysis: v=2.4 cv=Fow1OWrq c=1 sm=1 tr=0 ts=6a8dce8b cx=c_pps
 a=utCgUvwJB6m4OHweciQmMQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=okWzP3EbMLmikBYkquQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXxl7ROesJH8vB
 ADupiCOBEZbuGpwUW39sf6g4d9ypFAegt/ly+u7Cea17C4usLW+x18GOtv6JBN74ArgwV0ViVTR
 dZvovRMEID1+BJBIrFxL5NSOCB+xF3U=
X-Proofpoint-GUID: 3u4237IVfI8uGlIKRkhgn-CCir29Lh5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX5vTV9oObM5uu
 qZgBJCqoIKZEWrksnvyykD9rEipkoTt5oJreLJqR0Pz2pgST80pQIe78BiJFTjgKUxFtMba7TqL
 ndFVr5UZ8ZGWrjLbCePhBLG73h4uONtweNXjnkV6Io5j42Q3bFu4Ia0oLbqOI6P4Y2tnS0ZELpn
 uIwIqbZb9BTIMY1vHlE9d1CSjUi7Ux0ZbsoP26IhWSBx/ULBTV9qf0cWoyYZoBSEnBBtH5opQw9
 x5/upC9Y5PZeR+ZhBHcN94UlYhSuWdt1p2AKGHgs+fKaYkbF/9JPSekrNfelyhwTxwKSf+H8GLm
 usFMfDR6prR6QNkLqVtpKtWNXdOOpamiBH5JTsXQfhIvCfC7GP5o/Q5GhlbkTFxY8ZU099TkTTT
 0z691eXn6tfkLYmGtRV+U94KFuocreh10+jJK+nvatWMfwbmSjUKVP35W4AosJeS9Rj0bIsrjsI
 SKCwzmHmbWkTZRhrk+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 20ece785c97a..530335f002fb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1610,10 +1610,19 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (switch_cs || switch_ck) {
 		cqspi_delay(f_pdata);
 		if (!cqspi->phy_tuning_active)
 			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
-- 
2.34.1

