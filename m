Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB93384CDA;
	Tue, 11 Aug 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473288; cv=fail; b=K4Iffx0FPMC4YPFm56a4fXNXlGH3KByR3YJiGqQbibK6fazAW8UEQ1iE4B8DQMKW6T9Q/IMxELG4HC+a3XcFY4pqhRxokTik1+zcCyt5N4+bJdyr8ITcE6S3HtZl2SchKcqldJMVYWDQGvELexr7l85cFSf0R9gEtPwGLaEdkRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473288; c=relaxed/simple;
	bh=MDx2qjP/XXiD3vIr9oQt9kMeHBFs0R28iU0agoq2Hnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/ndze+pW017fEPHt1L6Am9JoVoLfRKm7iu9W0KtoHuFbUzDz89WPIArGaWmObwJ4EmbJxJBS5EEGNDKbYT+LEjInftNFDSeUucr000NMeInQ4Q0oFYXBIdzB91GAJIPbEQFgBmNLnu2/qUoB4BYzz1/bZkH599CzrEOiXyDHnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=dIzHWIn6; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OO52v4YO; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="dIzHWIn6";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OO52v4YO"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGM8VH1823871;
	Tue, 11 Aug 2026 13:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY
	/0=; b=dIzHWIn6/SDPbjm7e/oyY7jN1v6QUd5nWHfEgyGGogzie8yNF7pXXcMZN
	ql51h4b5ZFPcJb29Ry2R4pNbPwQxzxgIT5FBIoTL5A0Jj36ymwKiOgdQ7witmXp2
	sRa8PbTt+SUPxEXI80+v3XWvvCi4SiDjE84AkPdbsT1XHZLUlkC8Fh3gryZqtCNv
	4fyiPJZ9vSAAxKLHvJ+pIgoku+Sl2z0Fz7M3ublYzvupi+IcTEDLUU60QhtFX8un
	wsssSokU7qD6XYtKA5B/lvq90u7xV6/REgMt04CFIaixxg4Df38Vwu9PZEk/nhI8
	KVK6ErB5uo6+a8y3P94O2+ZTarGBA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00wnbk8g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:34:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs2S4CONmImGZzq8HPNvrPfZxOUKK4O9t2/cL7UAkk4qkVBn+sk8/w5QZOAwMcctvn/4HQnWFxRtFx+keypkqEhIDeuvgr330+6bdtbyg3KtxJEXeq+92kE0B6csZ3VAGMdO4q9CjNCW29t3l2Tvv1R0wfCc9YRSvQJZ13zH0H777XFReFkj6E0CKuv3gI1Y9aSj5msxAihPrk9Ue5oLoUYu1yb4LAGBe+7eCyJrcO1aJN9kSaX5ySqh8PrlsIRlKcweVPI2h854Is0GTSO4YvxrydYi06R+bxmtydKvDbAOj8VhVaOB8Jaad9EAP+0uDrBdkxcks8s5d29+Ae0P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY/0=;
 b=d7/q9QlKMPfREkZGdaLZlVO8VlqQeQT0CKKDIuMCzc2HNKIkcikxCaV6yqGJRPYNHSxTm78CjQn/n5zdUiL/PkkqTv5IhNz8F4TTtOyZ51pvExCaxuco6tTeiC+hsZzKFOxGzZcirpGCSUp5t4RmNoFbuEP1H5Kgpj7irlSh6HJMXwR6KS3CVRkkcvMgmSUDvuVXE4lWzG0G+3cz0kTVfbhrxYVS84BE1pohZJYl8nuLR5mMnJMChnsF2edP6I3OHUEoShE/1F2s8Qt4Bp/yWd92fyOm+bvdR29O3WnVGgz9XWofrLD5+kKlPMxrNBaFFPQ64I/OkrwdMLkZLppm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ugXXaYOACCqQhtO+XS/9SAqsz/zeF6YSVcc8SKLY/0=;
 b=OO52v4YOA/KjqKvxkoZK7U4R7tdUq8kDgTEainR0EaivV20Ck1QQhFJw8kPlYRWwuLRFNpKHf8/rukkKUJENzBWl6/JsKQxskNm3h2N2I6DmWIccQORh7fKr92MdtQdH3noa1hb4Y3i3c1QRc+BKvstTHBUEuO7onv8gV2uq+8M=
Received: from SJ0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:33b::9)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:34:29 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::19) by SJ0PR05CA0004.outlook.office365.com
 (2603:10b6:a03:33b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:29 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 13:34:13 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:13 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe2659766;
	Tue, 11 Aug 2026 13:34:08 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 10/18] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Wed, 12 Aug 2026 00:03:05 +0530
Message-ID: <20260811183313.1550425-11-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 7596eb46-11f1-493b-ac72-08def7d72dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|921020|6133799003|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	upfKuxHQQMnaw5IO6SQnSEbcRDOdoKRJotEAP1MxAYNMGSA6fvqiKHZlUXNGVuFclIClNG7D+/HZ+RaI+umVmOGPdA/m22MXM6WdR+gmvbxlwPex9Rso47l0pRAlt4kdM64pOAYT01kvcywaLACW/6OuxTu5Je4QX3YRckZC/9CURLqLypdGo65pS//emHQtLpPNjQUsn1gUcJSVvs3W7A4saOI9WbwSFxps3whQ5O09OqYEkn9Wb7Fkw5FM1aoxOKWP16gOnHk82BIN/j+qPQ7cPCYe6icOEf5r71H6S0Z7FnhC8scny7G2DNdJ9APIDwuYbumHOWkDzpqAC3VK4joySmYPkS+a/Z+X0na4zVXc0jl/14jRG3LTRKG3FpAIA7cVXucpT/uC5gP1ywm2QpPReNUptg3pGnb+6+Njo4gifiMJ6FeRSjIJ/lLzDSHWdKQVKBc5GVy/P/g/dfTBRYE7qxTX42xBjM5ecFbJ4MXrejZlO+vhWL74qR+EkPIMFTdkIe4i94Jnetlp7wksMyFZFEKIDb0CLBLvxvIY6MJwRfW0fQsqLcACm+HALNoDJnAUp1tTbz2bst/HuQz7seiP9kR5I+nTM6UmvnRWaUxhJKbe+WUjttGLvo4SVGa21bdYivlLA855YrDnd9LLH2XlH7ycITGoR4Emdfa2J74eQemDa1+Ce3tc6pU/EykEKnT53yUGfZGTFXrBOCPEkf/V9Prlvwcg9saOscsy0vwah8NSuIk77xIRIvoSue52
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/ASxL24InyrHXEd631SniDjSdKfUYrX4rWuPEs6BWoFP+xX2EytDOtbcEWw7zM0vOg0jbZZkIVPMA7fQkibi8OnajcoGV0QPfdAvPWRHZGkyv863F52lK66HZX2RUNYTaVEefN+YcoUFJ4hrAygQKJNXtpckU4pDEdpOsiLrSQatnsVBIQ8xRTvrAhj5DczW1D/VnUF7jp2shqWmdb8cyArTBf+bhvHErce7fFa7HXZEV8nPguimQn5ZcPDBQxTj8xfYn6J4RobcpTWCjdqMvoxjujCmwl6zCrYsOzrgp+PNN/sefPVWco58hYbppHWS/k4YQfzocA6Pk/1MXE+0yY5Ff5RipN4RKzkz9GLm9toSLCKbrWYVAVNrNLqQvQ0NqM5sOjb3kp0z55KFewyXpHSs3kNIo09KDfStxmXQvjQULKKh9lg9lhxT5vdh237u
X-Exchange-RoutingPolicyChecked:
	tEvvNSKGxDZ3iTxOvGSYf+uSj68okSmUtB+QYYILMqJYg/VGpasmZqTUaeSwkCS5VG/wJ9V9F1hXWWwIQSMbeZvJegfiVUEmJUQFr/1BFUZXl3wkKKNnrZ8f/7GBCdxLpUkhy6MhUNzsIrHm6vzh1auHgV7wvo6i3/VWrA3NSdzaKIes/pf+/QQci+S/8gHLg5MQosoRzRS/ACu8BmXZsQcIaVoGab3VYmcT1czDSm73vi6gaSK05nqVV1sux5NV5aDCNzxD8VB8FNAnfCfSaAwgAWecyLZ0IvpL8OF9c/oeFdAptYGG7ozfU7sCH+Ud2HfdTtY51Bg6RpsjrGErBw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:29.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7596eb46-11f1-493b-ac72-08def7d72dd4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX+F2KThycuAVD
 nub+v/zXcpnfEbV5iERgAB19pVxvCGkXsk/+J8h2EAFUl0MNdbX50zchwyDfqZgUjlnbqpl58nf
 taMx1Pw5TGmeNczDBdCnzf3yoYZlO2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX5gpQcMiffUbh
 TNgMmVP0HHQZTDAwVKIsQuorp8KYr+iHXqpKWwL+maQ7ntVhixsWkLIm1KOxmh7UhK397WHjpWM
 9uPRVDbGVk9zt/ZlJZWJlqOmr1cwtbvqXUVUox90f4u2AP+vhOdv16/GC6J2AuCCkvMjQaoTrSN
 Ju8VgsS4NtC5RbYNx0l1HATfKDYnAkzgp0UCvYY+GnVFz6GsbI8fU7ddhqN+UCHNMbSi0IVvN92
 f5+uKMwzDqW9ggSNX1cLttDin04wXkTgvzflaacRQgH7H2l8SckCz0h5uePDP1To4sRLjwAVCda
 U7sWbDgCfH+m7t3SH+3kXo/xwqz7GzYDmJpQZV7cD954vJszJ1wYmYR5eHeLweghQpwXUADEIkp
 EVOwFtXsi2ZftXxdBIf0lRUI5SEkAlz6SC+wa4wLvv+UfafuVTq4AfFTzigzAV5oTgVrZliMssD
 76eoAwwHMsiM23ZT/nA==
X-Proofpoint-GUID: yAXZEOhNEzMwtZ6Fq5bmXqqjtdnl0suS
X-Authority-Analysis: v=2.4 cv=cYziaHDM c=1 sm=1 tr=0 ts=6a7b6b3d cx=c_pps
 a=wUEmejkcrq5hT7YoMv924g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=aauMkRGVHSVL3AvwFNMA:9
X-Proofpoint-ORIG-GUID: yAXZEOhNEzMwtZ6Fq5bmXqqjtdnl0suS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, using 2-byte-aligned I/O reads for 8D-8D-8D mode to
satisfy the minimum 16-bit AHB transaction width required by the Cadence
OSPI controller in that mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 75 ++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a1aaba7c1a7e..99a0ec0e769c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
+#include <linux/unaligned.h>
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
@@ -154,6 +155,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1528,8 +1531,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1541,11 +1544,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1587,8 +1585,63 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			put_unaligned_le16(__raw_readw(from), to);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/*
+		 * Use an explicit 32-bit read loop for the bulk; this
+		 * guarantees the minimum 16-bit AHB transaction width required
+		 * in 8D-8D-8D mode on all architectures.
+		 */
+		while (count >= 4) {
+			put_unaligned_le32(__raw_readl(from), to);
+			from += 4;
+			to += 4;
+			count -= 4;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			put_unaligned_le16(__raw_readw(from), to);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1604,7 +1657,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1632,7 +1686,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

