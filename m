Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522590;
	b=sFx+wluqqUNF0y+Qy1ui2S9tHY5zD1D+zeT6n9Hh06M1TsvIZ6ZezAHdWB9uuXotGZ9p
	 mvwHzhMzBuIFCMjOJguByxpLiGRXal/jPCPCDj8FZlp5ZfMCXwGMw9FYfya9sKSINs9cL
	 n427DsM0BVFIrjiwxsmCbQBgJaJciCHFWBvpgC8Ounxw/xHbkYNZG5AqGVYc4gx0AE5El
	 wwnIfm/gl25TSWDE9rYv7Kw8Dw/uTag8DM75hYQu3LfwVimZQm/FG+SV92Lo+QSsbmXvP
	 XMUY0jEzOBaJejFmMz7NpeRVulWRsn9lbAXozrgYHehI9OZ873ka9lFqb57MHyfJE1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522590;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bOFKsbxpH4KzFXDCaYL69M3Fbp9dtS/WswHdh7QQcJ4=;
	b=VpL8E32mQS4LabVf1GPTPMAsa4cCc5tVO/5miZj50zV8eHjYJxT3t0ZFo5lqLWztby48
	 9eCKD9E7oiBOr1janxAbIpC0jFWZ+lPl/jvMrBO6CqJf6kSQK0XvpUndU2BrFTlP2eyfY
	 fuH9rB7+jQxMw6zpkDoo8z/lIhf5TwUPYgT1saov/CVdJ+Hak8TQbuwZ8Qoe09tMbmcjd
	 ynaQ8zM2LEF1m8eBXOrri7jBphfzRSDVfy6X/3SnfCDW+dNHdEiJmTYHospykKzKYF8lp
	 dq0HfVXTNNuA+gH3gCRkEIQIRH+QiX7IZFIe4MZ606iwtJ3x3LhaaBDa8hF3ZS3kWyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b2UARMif;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZMiupnBT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CF606A32A
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 736CF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b2UARMif;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZMiupnBT
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCDOdY2848989
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bOFKsbxpH4KzFXDCaYL69M3Fbp9dtS/WswHdh7QQcJ4=; b=b2UARMifHJia2SbY
	SR2Fffq/WX1293Eg0LtfWiMZ/hVw5YZ7RIDDB9FKxHHy4miA7up+IjrD7nVzZUuY
	osoCdQjGp3BtGCG1IIjup/Df0hX8faAZh5ARECl8M5qlfjZnk6EU8bOLIg7r38lD
	eOXTP/xi7uqgHX+vCCEcT/T4iw8vjvyYB4bykO+gRgPIk2ASLL/Zg1f1Ge7fGUBX
	n+nOs9Fj87UDrwbry8/lnjGZddYXbTsqO18B/n5uVSDIXZYDadyEgeDWXbd787mB
	Wa6OXYCm4r+UoRWzOewcSLy09ZcFvkUsP1ZuOYb4fFRjUjqy05/XJ/l6MvNgGnJD
	JBMXTQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7r0ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b930598cf0so7499320b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 04:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795522588; x=1796127388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOFKsbxpH4KzFXDCaYL69M3Fbp9dtS/WswHdh7QQcJ4=;
        b=ZMiupnBT/NjZ+hbIwXq7cL0wW6Mr4IErv76YEunZHTAX+SF4J4uZpGOcecDvKLuzo+
         e9NXOfCaK1FZHfQs124DVo9aVO4esZgSZ1NnKK4WfmimT0mOzcKr5R9O+PF/uSnzkU7I
         ZhVp5ctoXCqx41KKw9JMmBRPodzuC9T8YglldJlY8WD9mJVECSOAj9o3/RH23+9g0RA+
         4KCotLc/x7D1INLsTHyi3oCt7qqZnJExCA+Bwz21GVOv70vLqSyUszYLQNBi5yiEJPeH
         bGOQ4SRTSf7lQF8n2Wrh/O4YBdAZADPbL9VdalxZJlavJP363J5ZS4YxCZi4Ai4151TY
         R8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522588; x=1796127388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bOFKsbxpH4KzFXDCaYL69M3Fbp9dtS/WswHdh7QQcJ4=;
        b=PxXD/aK8E0vDtC2bFB8BOFzL3DmUWN1aaUc1xG0Cpszz1KbqglcXkeGbtGrFX69tyb
         zhXTeTHnGc0oc6pFgg365a+WoNKzr/RJ//NAHOqnlyhTqhxvL+tB4u3PnO1PvStx1eyj
         Z7ElMWSifTHZYRHGyq3wdgE/vSd2s/iLs7HqgGsczPc42VUwGhs0rkD/BZFK4lURYj4X
         TCmvx1VCyUIuVDaQvjTxW5x/BNSbGeUDktgzkBYSX3NAHNMPdiYmp6MxL2nfnpDcI8ST
         5RfTWz+86Pm73VwpckGkVwaDxjM7QSSw+YUdjphEzAKlqYxTfweIbjMYq3AWBU9hVPEj
         TMCQ==
X-Forwarded-Encrypted: i=1; AL+hErEGq1oY5OcNkPvBZM9wy9/OYASXnNPKUHcm56y4euozhzyTjZDpvn665sNUA1BvUbLcTnr+fInH/HU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VVzPp9rqztLH9j22nIIovzsNAEh7+3oK0cG5E0uIPnyR+35lD
	sRtJwB6WpRPWM3R//dJXlwiWQ8FYnr3HnCBpf4Q/FLUo5hvK5WW9YdqlHMjNQ46wX/BRlcVZjzi
	PajPGCOD8maWx+hQvQxTB4aiMvrVIxujBY+fS9bH3jfDGoWMCdWFkMvjh4LECNTA=
X-Gm-Gg: AZFdTZd5ytvPu3tyCRMrbqLxL81yh455oXX+d4I5xGPI/dUbeVjDvSCF0rH7WWw3chR
	AuK7Y0o7NnvN40LyaEHyMLiBD3jhGLRwwON1ARFVc3o2CgxQqlAWC0bctJ3TKjpO6U2s3Ac4glT
	B4OAORbxd1P68CcgNqpqwZK/HMvpDFRzEXuyuUxbQ56Dquc998YKXL0z2quPvx1ShdKMX1TOVkR
	vzHtD9M3Qis1ETUs+NE9bie4yYAtGhuNfGnzRHfkjv6eEdrJ24zCQ3r34M93dciCnCp4imfkYFg
	PuDnysDhuvO8kPXFw8gUqm2AufTy4wZ5DNcVzisXPmi7CowM9GabNCW1P/flEUlt2Xva4aVp6es
	ut4pA0jDyc8qXuiY+6+HViM+LkmnPNaRBRibbdyygSufnZ4RV7Bv+5G3HxPF4zEeICccWfNkLgm
	KZuM3jvUxQ
X-Received: by 2002:a05:6a00:b80c:b0:8a0:644a:d1e6 with SMTP id d2e1a72fcca58-8c87bfa20b8mr13052703b3a.28.1795522588283;
        Tue, 24 Nov 2026 04:16:28 -0800 (PST)
X-Received: by 2002:a05:6a00:b80c:b0:8a0:644a:d1e6 with SMTP id d2e1a72fcca58-8c87bfa20b8mr13052667b3a.28.1795522587825;
        Tue, 24 Nov 2026 04:16:27 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm7245572b3a.1.2026.11.24.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:16:27 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:45:25 +0530
Subject: [PATCH v2 4/6] soc: qcom: geni-se: Define the QSPI firmware
 protocol
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-qspi_qup_upstream-v2-4-cd69894107c8@oss.qualcomm.com>
References: <20261124-qspi_qup_upstream-v2-0-cd69894107c8@oss.qualcomm.com>
In-Reply-To: <20261124-qspi_qup_upstream-v2-0-cd69894107c8@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795522563; l=2240;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=55ZlMjRkdONF+TCCiT2mIr0TCDYDNs9cTd+Da/93QPU=;
 b=v08YvBaHpvji9aixFBPMZtsrOMFNQDH8Osu6qZohJxJgoC6EYZ94wDW0zH9toEdvjXxxfeyP2
 K7UALWXHdfVDAVOFiu17M69dE3J8HpEAiDw3wMsqbZj2q1tY3NpJWjx
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX0drRImbYfiRR
 oI4mlMqlp0ieMrcQzRWxJ71/+v56bEsbTzX2aLTDt4b3MsvvkfoTrb7CvJYHEzX4Sedgy7z5pOu
 eA+brPNqvnmLikB+JA/GKgej3TLEQ5c=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b05801d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=sUBs2YLvzM1exbN-AwcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX0Fgt087eU+8q
 HXg5Qa8r5cL6q8Tua/HbtqeNTuNAjESdQ5nDdj77QFvbzEvLmX1eqY1fNJuxQ+1U6lXcSepStmK
 s5kK1F/U/5zQ9KGHyl53XiLR8AwE8cBZx1KQB4OQuLrWmpWBCzDvB5SZMHHtgXa4HvzidzGAQlR
 cPlYOQcIxUtKAwcPza7z+3DS7ocNm45Ff2c/NOYoIP2a2FvfWBpU5CCUqrI2CxscT9gF72f6aXH
 QmNTjpAFnNPuCZ+WZmF3a5VlCby9QL8oZaBst7kR3ozBVNP0AgDCxRcZ2ROtnpSSaLrfJQ8xG53
 XoewUzl9zUcf1tQ3jHLUE1IFp2ATZgzM9kKfh33tZ1JXJ4Cb7+4MvxgIdjKP/3QrzgpBZabuQSQ
 bJUYIqVp69TzZahfZU0HXufoHtfYBb67ZX5+pSVo8xe/VAxU/4y/X1K+3mOw6e6rXDRqwEH6mYn
 M1891CIANXavSw1Np1A==
X-Proofpoint-ORIG-GUID: YeuOsNT05dTMko9o30_fQkauWw6j28lT
X-Proofpoint-GUID: YeuOsNT05dTMko9o30_fQkauWw6j28lT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240047

The QUP Hardware Programming Guide assigns protocol ID 9 to QSPI.
Add GENI_SE_QSPI with this value so the GENI SPI driver can request
QSPI firmware and validate the protocol read from GENI_FW_REVISION_RO.
The firmware loader also matches this value against the firmware
header's serial_protocol field.

Extend the protocol-name table with a QSPI entry at index 9. Use
designated initializers for all entries and reject unassigned protocol
IDs before looking up firmware.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c  | 12 ++++++++++--
 include/linux/soc/qcom/geni-se.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index ee519108c107..270e7c44425b 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -126,7 +126,15 @@ struct geni_se_desc {
 static const char * const icc_path_names[] = {"qup-core", "qup-config",
 						"qup-memory"};
 
-static const char * const protocol_name[] = { "None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE" };
+static const char * const protocol_name[] = {
+	[GENI_SE_NONE] = "None",
+	[GENI_SE_SPI] = "SPI",
+	[GENI_SE_UART] = "UART",
+	[GENI_SE_I2C] = "I2C",
+	[GENI_SE_I3C] = "I3C",
+	[GENI_SE_SPI_SLAVE] = "SPI SLAVE",
+	[GENI_SE_QSPI] = "QSPI",
+};
 
 /**
  * struct se_fw_hdr - Serial Engine firmware configuration header
@@ -1581,7 +1589,7 @@ int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protoco
 	enum geni_se_xfer_mode mode = GENI_SE_FIFO;
 	int ret;
 
-	if (protocol >= ARRAY_SIZE(protocol_name)) {
+	if (protocol >= ARRAY_SIZE(protocol_name) || !protocol_name[protocol]) {
 		dev_err(se->dev, "Invalid geni-se protocol: %d", protocol);
 		return -EINVAL;
 	}
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index f77c3a47c3d0..e2b93afba4c9 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -37,6 +37,7 @@ enum geni_se_protocol_type {
 	GENI_SE_I2C,
 	GENI_SE_I3C,
 	GENI_SE_SPI_SLAVE,
+	GENI_SE_QSPI = 9,
 	GENI_SE_INVALID_PROTO = 255,
 };
 

-- 
2.34.1

