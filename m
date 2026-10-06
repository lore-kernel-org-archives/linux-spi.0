Received: from mx0a-00617f01.pphosted.com (mx0a-00617f01.pphosted.com [205.220.165.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E449364D
	for <linux-spi@vger.kernel.org>; Wed,  7 Oct 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373403; cv=none; b=bguM4VI48Q4/dkpV2y7mms6yNDa5SgzUC4xpw9vqGoLnO1979spsbXHxGGTgMfU+lnz8aMi/AA7ksvsDEmpo/kIJ52ETZlmPk5cnfP+/dxBqpsJvVXXMMy/VKypCk4l76yZkNad28bc+G8zci+YViUiUwDJCGEbhTfKMO2U2nCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373403; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWAH0ho7d9HeLQJ/SCaRGN2LpPxP6LvvrpciTvsIunucALCw7MU+bdXJMgcDYEeRL4zNHGJWzTlOJXdQiREqra25g1AthMcZXiNHIViMNpchlStE/wZIpbyt3cjpSQtje5i1OKa9bRMj3o0W7x/X7/kOvN7d7Z0dSMz6IdBjDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.165.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247527.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697002oR3309987
	for <linux-spi@vger.kernel.org>; Tue, 6 Oct 2026 20:08:02 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b5e00p1-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 06 Oct 2026 20:08:01 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:52 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:51 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-spi@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:49 +0200
Message-ID: <20261006235547.04891E490829519F@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: QccysA1ppQR_3pqUoBT9HCZl2IHtxfMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX8xWoJcgg2x0W
 Sl26a72/BZg3r3k35RQmvzYMu08M7NtNsBfmt35p9xZPDzaC7f/ve+gjn4yKMkKgv9/6TYt7a4S
 VK7nGN1OMWef9Q6RTn5EudyA1jGId+bFx3YXCf9WlCbHkf0soBLD/ov3RY+yeBJNP9Zq5epc/Jr
 AMbA1bT6SPDzFtw1yVeibnI24m1XxA60pRlOhDAanfsWRDfA3t1c2zIeFGILWhYoNl2UbNh5uU+
 xauNlykWAkZwJlyCZ32sKpYi16WXoa1abIwwnDTR2MZtxrpmMQ9dYnTTEVZQLz3yNvoB6DHodic
 fMPTAsOV8rUCpB8eHTSZ0IdiKKWHbhmJ3E1jQ4z4WPhagT1QbZn94aTcSMQud8kvG3i04PMGtO7
 TPuImt0W3RiPX3VbyLhZ2CTRhgryIv+Yh6Kh2EAqNwWFYc2JePDDCKBFepE79a6aOxG+7agLvhJ
 lsV380mJWOfYhOVAn5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAwMCBTYWx0ZWRfX7n8tlqFMLquX
 G428S3U1SOoXpsam6gPin3SN6h0hwnzOsWwirpdLn1N4BnFBFLpOobPXMlk+Iukh5Zb65JzkSXs
 FiXbllw/qSL0C5c0mkCApGXfW/dZBB2BVOc8LvkmYCdLRKaIKlXG
X-Authority-Analysis: v=2.4 cv=GvTXaU1C c=1 sm=1 tr=0 ts=6ac58d61 cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=GfZueQGhKz3ujf-POmTq:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: QccysA1ppQR_3pqUoBT9HCZl2IHtxfMg
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070000

