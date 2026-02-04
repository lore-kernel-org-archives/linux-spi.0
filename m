Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362394279F6
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222549; cv=none; b=aVIWseL25qUynNCo78J12c0W1KI0rLT4qRa/jRRZcQWFZnW18gz2GWRYrpmaCvq/eMe/PPplGsb00vnEuFZGf9uTmEJC+dVlgo7Rfae4TlYILEkw7Fk8QcywS91TCjK2Ny6RvZeUYRj0antF22oMv4rFDPAeLiynXTPjFih/dYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222549; c=relaxed/simple;
	bh=sWb5rIpEPBjBGqjRCRsJwTlXgQOnkNWUkWCVvpAoluc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NwEYSuXOWyTPw/4W2kAKDTRGXxoAtbcVSlFDSYQ+JyNtN+wcpcT/u8ZJRM8/aFeLQhKmskymsDQJpOquD5hNktjXfsNoehT0bbAgZWUoTlEHUeM7G/0jVHYv7VLGDMX4nlgTvzJVOO0+sEpm4rHl9xyo6JIWCh+8SPN2RrkOKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b1ErX6Kx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csT/FdLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b1ErX6Kx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csT/FdLE"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CILgs898830
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=U+zSDPLVq06odaeYOuxBYn1640aYkkqXmcQ
	o5+R2vXM=; b=b1ErX6KxTxW/j7pmZd2V3SDNRpQ9ZWMhm9tQxAkKWgXbtH5KX/d
	G6PH6jUQXPDDQDSVxCsaCO0mcqb6UQXrC750IYsY0hkqi5GozmNmICjvhntFHn4Y
	oin5lRa5iHnGWC55uTyJH91F495oK4+qHVyvVKL5TdOLdumpQYAE7jlteQ+1uGeS
	IptdXYuz+9koXu8dARltYaUGNPqaot3Ow1Sfs+LJbf/kBRI88aiUGNN3tGGRqXoq
	ep8vyAS29pYL3YW2XsqK9xwd1OxkfU4ozoBNnXxpMDUXAsWr3c7gSVAaEDCkWOmU
	MZzq6DD9LbGZ/pFb3ZTvQJ5Ax0QY4fmBSeA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wh3tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:29:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so65615ad.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222547; x=1770827347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+zSDPLVq06odaeYOuxBYn1640aYkkqXmcQo5+R2vXM=;
        b=csT/FdLEFL2mEVE3RP10BJ6PeekEv94YRsvQyxS7oLmgF1E7ublFJ9nRKMUYrs8hNh
         B+ar4kEWERHTV22wThzzQLI48/IaBCQerkMeWE/LqtY2Fp9tY8ujDzHrsHmSLShOUs1f
         xUOOgnwOK9k/F+36/XfbA/PQTtoh/I9uB2M7kaA/boWq6dJIluVshP5sW86i9hMGnNSm
         UuNoML79Zylpe1SDqRcF4QflpRFp6XiXB4o9BupZdwOtJ3BTrZJlqNv2a2WMbJ2btLqD
         gRXmQrqh9PYqdmv4vYvRcZDQPs+K/zcAzPkCFuZTlRmZ4QaAZQaScEf+WGU7BXbyHWEY
         PfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222547; x=1770827347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+zSDPLVq06odaeYOuxBYn1640aYkkqXmcQo5+R2vXM=;
        b=YhIg7yYDYUNccdceVoM6Al8Rm1RUAecuE5ajcWIigQyOBa6wfbE6VHm13/Bui++Rjq
         MbAahZQ2NDFSRLvt9guL7dwyp490JYvyVL1sPf0RmBp5r0kc4O4hcnmA8xfo+PV0s5Xf
         n2aK25N5PzFDjAhzIGegK5ELwGieHVylNU62OI4N/oyvAzkWT3UM5y9EpM887Kc0BAuW
         +OWVUhlOOxHhBJ0ryrDUPaSKa7HWismALZjeccLSleEtsi6FHyL2roWcZA6ZWLk4a8jP
         6+6gJC46M1ZMXpJZ3+67HRTWNJpCksQJQOKS5suYTCx2+NzC8yP1jLjiAcYkXx1rKqSv
         jKfw==
X-Forwarded-Encrypted: i=1; AJvYcCWl5XcoRHXu08mpZxHy7NZaamZEOICCWKZQii1WMe8HxbifRC/jmILzz3DYHwclBdLYw5TVr3/s2Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYIpKhAB8oQmfsHs4reQhnkpS7S31taAZQX0V9P+U8WfKbIVd
	gFGyn/JjGADihn0gE53BbaOzJUq/onoDuxAnNnAKWjKmFs15CeWZTXUmNy0ePVL1WD7T+LcKxe+
	mq3cONjluP9ECTv4+bBvjjcHE2RkPMjOEBKw1aQLWOHjw7eFVD/nzgIfpgF9zJ/0=
X-Gm-Gg: AZuq6aJkkymgn6CEjzYVxyXN0mtvATGcJdcrrCZtUS1pkhk1khUpuvASzbSWciqKpRX
	hzdF+27XnApu9W7jF8TCDGghWyQ2qHls7pozs3yWye51T8RFttVjnOa+UveJIkdTgPMZdZQfJE1
	cSfVatjibootyQpGVruZgvv0D1HuNDeKWW5cPddd9BGiZ7xgmuA4R48N+1WmcPCTryDELVbxb0D
	VXMimwtfQxS/dBWFH+6mnKUiRFYPw2Ze3aAZK1GGQlIfkfTYSQI2BnAsZEdond9RcGkLR5a8/U6
	+N0w+WN6IxSydYfRGjJk5ArbkhD0LBXPv40BOPOVqXYFvn7CddAi24TC4w4PId3vdnX5W6iDFNo
	1O3WviO0O0CRBLuzPl19cAj5T9n0D8FzZk7Xckc+HoeM=
X-Received: by 2002:a17:902:ea11:b0:2a7:994a:c02e with SMTP id d9443c01a7336-2a933bc9c52mr38601305ad.11.1770222547000;
        Wed, 04 Feb 2026 08:29:07 -0800 (PST)
X-Received: by 2002:a17:902:ea11:b0:2a7:994a:c02e with SMTP id d9443c01a7336-2a933bc9c52mr38600905ad.11.1770222546405;
        Wed, 04 Feb 2026 08:29:06 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8515f36esm2546878a12.29.2026.02.04.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 08:29:06 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Improve SPI target mode support and error handling
Date: Wed,  4 Feb 2026 21:58:50 +0530
Message-Id: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNSBTYWx0ZWRfX07u/UMyFzwQW
 k8Y6tfYuUrbihqOm/c3PxNo90fvE+mc5RTVAWvxJQgBSDGdFZ8XEwxEc+Qw0oiyxbQ8iXIyenrA
 h7fKhDVlZHmbVodF/vdqk/Jdzy7sGygACdcYg9YC0oztMON2OeRVClMokmEPzAqzNrssSg6Xztk
 JWNnezOvHTepZkvmr4QK1gLtTU1oF1w8ki5g2NlEVuocHEo357n/U0F2HwffLCmnSUEL2a3JDGP
 9SKpYZKD3p2Tj85OI/GFeRgw4ltI/sIA5quWfp4x1mfr/Np1MekU9DFAQmCMLkZyTMplzxoGpce
 RNxK0YoMRCMAmfud5UwUf5iMFlZThLJV9ndUY4qNqte01iLCcXbh/TFqi9nRO9xSXyqP0VUsQRQ
 sSENhnoIY5E+wzk2H9MwvA856wge73l6fEqo9mb8BhBhC2Sdxh3AhWRUYmczCnVpQHQo6gvOiRg
 JMYT+beQGqp0QIqjcVw==
X-Proofpoint-ORIG-GUID: IniYnL95i2UfldsJ5PZpUK39S9S2EvBN
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=698373d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fVkAZgIkOhdXw_bALp8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: IniYnL95i2UfldsJ5PZpUK39S9S2EvBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040125

Enhance the Qualcomm GENI SPI driver's target mode support and improve 
error handling for serial engine operations.

The current implementation has issues with incorrect controller allocation
for target mode, missing abort sequence execution during error recovery,
and lack of graceful abort mechanism for target operations. These problems
can lead to serial engine undefined behavior and improper resource
cleanup.

Fix controller allocation to use proper target APIs, ensure abort sequence
always executes for error recovery, and add target abort support for 
graceful transfer cancellation.

Praveen Talari (4):
  spi: geni-qcom: Improve target mode allocation by using proper
    allocation functions
  spi: geni-qcom: Fix abort sequence execution for serial engine errors
  spi: qcom-geni: Drop unused msg parameter from timeout handlers
  spi: geni-qcom: Add target abort support
---
v1->v2
- Added a new patch to remove unused param.

 drivers/spi/spi-geni-qcom.c | 56 ++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 23 deletions(-)


base-commit: 193579fe01389bc21aff0051d13f24e8ea95b47d
-- 
2.34.1

