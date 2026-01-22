Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A5352933
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094637; cv=none; b=RAfe9GyOcvioYfJ6z5rYvxzpS+PusRSqnP1kWfZKK75XHznUgod9eiThL5CxKKlBI37FuFCpgmqPCnjMfwbnpznLxSe5fZ0Qa/PEK+ydCDkdeBYDqrIkvN1EMu6qL9YzFh3hyg1AKCBl41KqARB9fFdB9dms5bpwhzUNGAWP2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094637; c=relaxed/simple;
	bh=qakuhgJFOhsktXcKuLG1qi8pNW3vyIf3X/6YJamV62M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MG1iafV7/PpnJ+NxMiqRWeK1lRU4aQOBSIlFPzcq0PjXCZTUVGVfmTJx6KJ8xALBFQcfS4W3ClQAZeD1CmM5rmMUoX0qFtkeAFz8VD2fnquqlyd5bWnp5Y+qVPL+NpnATuqeYNZZLTwtNqu5PAqzEtBIT0A9AhL06SPLLwfZikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dZWEKDkN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXxvHEmr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dZWEKDkN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXxvHEmr"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MEige5724846
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NVo87sxbS+T
	GdNMbO32QbS2nchEhayLU5oXeqbFF+GU=; b=dZWEKDkNTPg3g6rr+c7QOjAxx/L
	47F6UEnYyJT/5DJHqYrYy7AqGqZ4SBWOUVUAPU1a0VvtVaSrVeota8826qB9HgWM
	3JRU9UjseRi41sGffDQb7wl0ytODMdi4HD4BXVeiKRPnuu+VwJm6aZ2ODu0K/ejA
	8Sd1CWqA/q8z9IcH81rHkDoLNe1I5RqDWygxi7SmnFDtGdCqHz936A/v4oD+0+8+
	o6wnl1TlAw6eMThTw3lhjTJklgu7W/agiy855BIvS4L8VJfrsdWAXVeXrIsjMYAJ
	IcZ/xyhV7ZNhDbg7hL8Ol2xWxz63VMBiSlo9Q6j3s9xWlteinaScC759y+g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buf1bhfg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:10:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so1920482b3a.2
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769094633; x=1769699433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVo87sxbS+TGdNMbO32QbS2nchEhayLU5oXeqbFF+GU=;
        b=DXxvHEmrvt8Ibf/7lY8QmyQWZeXE2kTYErIQLJVZZEG22x+8lo1tWruPBoFqJiIt5p
         yt3s+060qApY7WihKrFC26tBn6EIumPAXi1tTj8qmjF0WRPLr3MlCKPjrjWAo+7oQZva
         /3vfk0k+70UkQvcwmDAsg4O+4VNoq6xMmS8p7pjSFW9vyELcY/cZ/U4jbohAob7PqeSF
         XewUwJ07voWNnJLph1wEMNz4yk9GHvMZ5F3qd2an55ql4urIXzurFOgycEBtAgC8kW/2
         hIuU8gvD2qeSfFSS+x5UYmPd4J4OdaH93Euho8N6mrBDBpBcv0Kxyuo5F5KOKL1vy9hW
         J14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094633; x=1769699433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVo87sxbS+TGdNMbO32QbS2nchEhayLU5oXeqbFF+GU=;
        b=nE67m42OpoOF2FY3PtFm18s4/KLs9L/r9wQ5JGNuUS4uFaAufQwKGFed1ibtt/4GJ9
         1OdQx26I1seO+nqxIeKam+tYRGZl0/Hig2u3fOcA+Vzmhvd9S0R9h79bK56qMrI8l8uL
         QbP4ixKv9WXTH+YL7h+Z4EkhPBVcZbVe19RsLk3JBbdJWMGOem37pKURl7gIqOCw16Ud
         ecvAhSM+ewQTWv6z7I1r5nBl1YTjIrfr6We/beVehXxFYUQyW0LuTsnVhD56IyO4Yezx
         VkAWUITnzgnbp6SjztpGbHSo+X2Yp5I2BDtxfpqmMmV/hNGNLFt19pDsjup1/4L8yv6Y
         GU+g==
X-Forwarded-Encrypted: i=1; AJvYcCVPSIYlQvxee3RovT6qPpPLF6Etnzrc9WY0Xrc3ZUjTXSnBZhSBlLdDu15mxGk/j/L+oLxntUY3u44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUUApF2373rxKUExuHVPSnq8XXg9wOLhqsxb1WutBQyjKd8PG
	rMZWqUIzF4fxNpYqSnAPWN03whNbIVfQopVJKrN03wMKZnmj9NgNoSNPnrwX3IJ7DON/xPgEMpE
	wKj6SDNrJZ7zExfFQMe2LUncgr8Nfm7mdsjJ7jYJnwa1pwgKJpEpcftxyCU9r104=
X-Gm-Gg: AZuq6aKyUFNRxg+Rk/apwNRHpVSuxJ0EVZK+49YdOpsmcScFJLamZ1VLBZSBIShBma3
	NYAUEYMH4O+C8R1B4ad6H5THenOQ8KhB47Qf68GMNuI5Cfy+QMQtKTyEIaWj4wAjxYiPtV9DmSm
	XCZH7vqJsLLhl7Fyjb0uAyM972kD7q2thrHIIuAbe0dyhmZASjQZ/2aAy+3poC8HE9WR8nIC1gT
	jM10JEdF33S+rCfVWgm1fnbNLh+BlsXWBDKu0d2lv2f638JGeDgOg3QomTTtaT7WeV+C9ze0v2+
	DcVXBsD4OUrtKT2J9TQjXgcsDqsiICIQ6mHPX6roGFTnJs8TiRk2y27c6dn7SAQMRdbsY+Fv2sZ
	WujYR/WA6NVyXdhBlprFT4qSZU/agDD8eXWemJXXfzl8=
X-Received: by 2002:a05:6a00:3cc5:b0:823:1679:49cc with SMTP id d2e1a72fcca58-82316794e67mr1638b3a.66.1769094632693;
        Thu, 22 Jan 2026 07:10:32 -0800 (PST)
X-Received: by 2002:a05:6a00:3cc5:b0:823:1679:49cc with SMTP id d2e1a72fcca58-82316794e67mr1604b3a.66.1769094632056;
        Thu, 22 Jan 2026 07:10:32 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8217c258fa7sm4328182b3a.17.2026.01.22.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:10:31 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v1 3/3] spi: geni-qcom: Add target abort support
Date: Thu, 22 Jan 2026 20:40:08 +0530
Message-Id: <20260122151008.2149252-4-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0tHVznQu_ycoxIklJhb01NCAeLnsUe-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExNiBTYWx0ZWRfX5uv0T3cRgTqB
 sqVFcJvLduBPirLIPJ4OtEYHAD1wazEX3cusGo3VPXesUK9tSElKIa0HmNn5f4H8nwe0iiCK+a7
 a58nYOqTg8UkaGuOO7ZOtjwlwounb+P//Vxfx29AuqOhngxqY7MUD4V4Jeurx0bxZIgIZFc4evo
 yo3hGTdAF0LKlg0hYhvpo8WxKcIaO7L2udLiFivya7DDFcJ6hDL7Ig2fE9s7O1T11IHYvkvdOIv
 WX86fqtO4SM9Z4c+Ao4LC13674myIhMTu/zJHe/VJui8xU5IoSrRb8P/RO7vK4jDrqjnGHQuWW6
 FPSpUGWa8weWtQtn2+CziqoA3v9szIV1mqbfyeMKLW3KOLQComgQfAEOxl82eTvg38U7pq05HqJ
 j+qOH3aMjzjXMesqKmfEDvozckF94j3tAwFIVG/BDmGbPNCaqsj6b/5yfoSQx0NtVagcC4L360N
 WcamDkWeuwSrYV+f+Jg==
X-Authority-Analysis: v=2.4 cv=G+0R0tk5 c=1 sm=1 tr=0 ts=69723de9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=ZHV-9eCtjRHb1jRugp0A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: 0tHVznQu_ycoxIklJhb01NCAeLnsUe-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220116

SPI target mode currently lacks a mechanism to gracefully abort ongoing
transfers when the client or core needs to cancel active transactions.

Implement spi_geni_target_abort() to handle aborting SPI target
operations when the client and core want to cancel ongoing transfers.
This provides a mechanism for graceful termination of active SPI
transactions in target mode.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index e5320e2fb834..231fd31de048 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1009,6 +1009,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int spi_geni_target_abort(struct spi_controller *spi)
+{
+	if (!spi->cur_msg)
+		return 0;
+
+	handle_se_timeout(spi, spi->cur_msg);
+	spi_finalize_current_transfer(spi);
+
+	return 0;
+}
+
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
@@ -1082,6 +1093,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->rx_reset_done);
 	spin_lock_init(&mas->lock);
 
+	if (spi->target)
+		spi->target_abort = spi_geni_target_abort;
+
 	ret = geni_icc_get(&mas->se, NULL);
 	if (ret)
 		return ret;
-- 
2.34.1

