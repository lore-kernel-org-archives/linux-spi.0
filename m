Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073E369D5E
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994612; cv=none; b=NpE8szehvEuDPsvm9wwOv+pzlnALo9qXzhKEZOK67p8Y17PqJBe/ZYm690xaYG8uYqcRjiDGJ8GOCze+hO/CHhFPu7MeeDW2ALLaUlfZkWyfeazsigdg11g4Y5Fk5E03Z4v5iMY3VilvmfysQi+V+XMwk1Cu0RrPbHiHWDV7fb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994612; c=relaxed/simple;
	bh=stn3ZEPLR1afpqAn0RrmIjAKSrCZN4mu3yS/RlOo3eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y5czA/lzq2wrui8/ZOPzYocfZnz+4SZAWSoucFC1g33/tEcPJk6ONmf+F/az7RG4nmKZAVf+7MnwLjAUSEJmHN3y9d6Mw+CUqF2KSoDGjz5kU/AA2mHKI5YY+WG1W1eN74GTH4du41B3xYFYSuBHtyGPFSbGqZ3vk/zU8qQybtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dsOCcKvB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jNcIeAdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dsOCcKvB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNcIeAdT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rf0M1568427
	for <linux-spi@vger.kernel.org>; Tue, 9 Jun 2026 08:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yNCq2Ath3e/Fyu9ozR8E4s
	0geoHbdmxBpm5kJ3fmgVs=; b=dsOCcKvByTrHjuEHVBo3f7p7JBDN3z4008UxcR
	INoWtI7y8kPulGhU1j8ll91HA+D8ap6qJ2A5LtamOYzq7O3nhcL6JyU08PoRwFzU
	q07yP9J5+3A3Gn1ZaVohsBR0tak6dubm+KAh3wcYjVoRUVkvU/P5BaOZySNsWGUN
	fhwomfmFhwb5wx/sdoQGJVP67lMggtkw/D0pTPg+te9KDpyYQJMuvbqsFFWgsRdg
	YIhVkOAClBtu6yZp94BSg3I2C2EU1sCnIpEXgvwZzRIA/fjsSoJW4PmlUbmCfT+M
	eukD4nuZCC69nrl2vptnZYuxfzsZ3+vFCrMgkhj77kJbtxdQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx463qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 08:43:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0b35fa876so65475135ad.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780994610; x=1781599410; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNCq2Ath3e/Fyu9ozR8E4s0geoHbdmxBpm5kJ3fmgVs=;
        b=jNcIeAdTvbFjYveo8SfvljCNAqSTLWiLJy6BmSDRx+XLJyNloLP2Bdn2KCXddBETj5
         oOZm9RVhB104Hde9H21eBBvWZj1d9+pwPCA9aES9UpKXw8bitvXuo3ig2n6DJNjhzSzD
         rjWrvliyv//UyY8Z1C7l6gxccxt5d5UAn7bE1rXyRx5GD2J2TAcvzRgPCSC4zI6Nd+IU
         50+YGFIY3X61Zydc8uElwejtFbeF9x3cYoSr/YQ1YJP/nml58mrW0g29p6xPafffSy0F
         1NrWbYPWMRr97Q8SIKdZZURkLa4ELkSApyPOhzxxU9B8HIWBIhr2eyK1n0c9RZelgkaH
         xrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994610; x=1781599410;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNCq2Ath3e/Fyu9ozR8E4s0geoHbdmxBpm5kJ3fmgVs=;
        b=Jb4n1Ad31xE09MyHAoSBA0MvyzGJao+WNOadS87lpaReTPsSbfzI8AMSXnzMB6mRH+
         KFrReYS7vjSULStYanC/cyrgeuyN4Kq4mbgVJd0x17NWHK0puuZw59sZ+HIaa+K2NIMx
         tBEGrMPFdG/fUXQ1FkkGh5sPpuw6YoBhoejcPzp1EIw46EDy+VQNRiUfaw5IZlqKMqJv
         oL6wATmAAqpqLl9E78LS23LEg28Wl6Ab2+gZ7oliORStOhmax1bNgUtpUvwNC+ai5zA3
         sOJpTXxvHDfN5txama2uqjUJxEA2Vr2cuQQ+JT64fPCn5WMkR/ii9rIVKfy5Wutn7ssW
         Ehhw==
X-Forwarded-Encrypted: i=1; AFNElJ9jSVCVmryOcYnt71MENkCkPdAJASnsrJP8CScWfyJvFTG+eY9+1yOGOhDBYaB2qQwMuFoK4T402/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WNgIfTM8wwN4cde8zTSGsq47BSO50P+p+WdMrJsx+YqJsi6+
	S5xRXGZAWYC5+l6DQtcbSrjaueJScanzw2CoLsJWtuNGm3LnmHpQMXcD6mUlq4SmaFA50bHDk/2
	K2bowMG5wg9QGuU8TdY6AETqJ7wBthcW8RqtbvTbg9P+ULXjjlbXK96AHn/Fvz5w=
X-Gm-Gg: Acq92OH9SUPhxdhWrZybX+81D4bziJZ8vFSPhfYHKTPF84PFz1pDwNyyDw41oZT76KY
	wAI0hOdjIgmvJdUapwI6gV/VaSvqGAkzx9LLkAb/g8XYuYXlq+62iZW6ABy9MTz2vyPLGlqdiOe
	3/elTiUe+8hNEWekrcJKKjT7Wli8L/2PXbHp+U76dZp9z9EyqL8bTyjhyY9/oAfK4NrDAEH37a5
	HiZi+EmvJfedQNNd+pg6NeYAxMFujfxu3781fyT8mC0LEbV7zu1TEz03G7/aAtVDb3pvSR5WrZr
	LClX1sCu9iN3SKlpOUAIkZPG0Hcr1/U31QLzc+7RRlgozWDgCazBWGZF18J8lwyTEMBS+nDTF4d
	VedV5z7k2u4aMarioW/P/XsAGJplCbAepbXPvvtEXkKoR2dDSw2nyBSOKHNrZYGVUdhg4
X-Received: by 2002:a17:903:388e:b0:2c2:2a8a:af74 with SMTP id d9443c01a7336-2c22a8ab260mr164651305ad.15.1780994609560;
        Tue, 09 Jun 2026 01:43:29 -0700 (PDT)
X-Received: by 2002:a17:903:388e:b0:2c2:2a8a:af74 with SMTP id d9443c01a7336-2c22a8ab260mr164650765ad.15.1780994609051;
        Tue, 09 Jun 2026 01:43:29 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm196489635ad.32.2026.06.09.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:43:25 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 14:13:09 +0530
Subject: [PATCH v2] spi: qcom-geni: Fix cs_change handling on the last
 transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABzSJ2oC/4WOyw6CMBBFf8V07ZA+VMCV/2FYlD5gDFBsC9EQ/
 t2Cce1mkpPce88sJBiPJpDrYSHezBjQDQn48UBUK4fGAOrEhFN+oWdegMUXhBHBetn0Zogypgb
 UGKFzDSooCirKkxC5tSVJK6M3qbIb7tWXw1Q/jIrb7JZoMUTn3/sLM9tyP1v51zYzYCBqQS2TQ
 utc31wI2XOSnXJ9n6VDqnVdP10iVKznAAAA
X-Change-ID: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
To: Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780994602; l=4275;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=stn3ZEPLR1afpqAn0RrmIjAKSrCZN4mu3yS/RlOo3eg=;
 b=nkbi4Vvc7G2lHmDJt3Rj5R8XMXZi/OL/bi7cdRKFiLoGGQhE2jhl5Ye03gsg95Jnr7XwSWOsW
 2jHB9f3fv61CeQtR2jnjRo7JDaXa7FV6h2yFwLqnJ2pwa9C3i0oNlHQ
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a27d232 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=RAbU-raeAAAA:8
 a=wpeXKL9a9D_Roaqk1GEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=JiizpSU_mAIq9zsZDqn2:22
X-Proofpoint-ORIG-GUID: orfcMGJ-OVOEsORp_W1N-65GvxN1ciZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA4MCBTYWx0ZWRfX9F9OaItX60aN
 4SN67bgzAMSIkj1l/wg2iWW0sotL26jWwBTDTn/t39iHpmCxiY291ILskFBlTPIoTq01wXdQ9d/
 Ck73hBMypRMz9NrHefqxFXn8UhDzF39Asw24KM01Gz6Oo0yv/bSkjMpxxHOpRExqfweRzoOFGP3
 85nlHhgbUgT4JhzSI8aLTtw/2YXiAJjIyj7OhX17oQ+BIye3VrYBOHgKJeFjL+tHWsYIrKy+Qws
 ZpHRul0742xftNz8rtyRHIgoXotz3QYbn4KHOWHebrqNl/1f/go9VGxsCGJ5Bb6V6RQrMBRhfRT
 llW7h7fJqBdwh6dkk3dnGd4OTRO9qQNJ7zvSdrGDv5y3Dbb3d1eGBtDgJhY5kmysUe0MKZt9Gyc
 QMN6s6woOmpoLwiiTpvhrw+x4e2Wyg==
X-Proofpoint-GUID: orfcMGJ-OVOEsORp_W1N-65GvxN1ciZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606090080

TPM TIS SPI probe fails with:

   tpm_tis_spi: probe of spi11.0 failed with error -110

TPM TIS SPI sets cs_change=1 on single-transfer messages to keep CS
asserted across the header, wait-state, and data phases of a transaction.
CS deassertion between these phases violates the TCG SPI flow control
specification.

This bug was introduced by commit b99181cdf9fa ("spi-geni-qcom: remove
manual CS control"), which replaced manual CS control with automatic CS
control via the FRAGMENTATION bit. The FRAGMENTATION bit controls CS
behavior after a transfer: when set to 1, CS remains asserted; when
cleared to 0, CS is deasserted.

The commit correctly sets FRAGMENTATION for non-last transfers with
cs_change=0 to keep CS asserted between chained transfers, but misses the
case where cs_change=1 is set on the last transfer. When cs_change=1 on
the last transfer, the client requests CS to remain asserted after the
message completes, so FRAGMENTATION must be set to 1 in this case as well.

Fix setup_se_xfer() to set FRAGMENTATION when cs_change=1 on the last
transfer.

Also fix the same missing case in setup_gsi_xfer() and correct it to
write 1 instead of the raw bitmask FRAGMENTATION (value 4) to
peripheral.fragmentation. This field is a 1-bit boolean consumed by
gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Writing 4
to a 1-bit field causes u32_encode_bits() to mask it to 0, silently
disabling the FRAGMENTATION bit in the GPI TRE regardless of the
cs_change logic.

Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Updated commit log.
- Fixed typo in code comment: s/keep CS between/keep CS asserted between/.
- Link to v1: https://patch.msgid.link/20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com
---
 drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a04cdc1e5ad4..26e723cfea61 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -449,10 +449,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		return ret;
 	}
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			peripheral.fragmentation = FRAGMENTATION;
-	}
+	/*
+	 * Set fragmentation to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+				   xfer->cs_change : !xfer->cs_change;
 
 	if (peripheral.cmd & SPI_RX) {
 		dmaengine_slave_config(mas->rx, &config);
@@ -858,10 +863,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 		mas->cur_xfer_mode = GENI_SE_DMA;
 	geni_se_select_mode(se, mas->cur_xfer_mode);
 
-	if (!xfer->cs_change) {
-		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
-			m_params = FRAGMENTATION;
-	}
+	/*
+	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
+	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
+	 *  - last transfer with cs_change=1: keep CS asserted after the message
+	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
+	 *     keep CS asserted across header, wait-state and data phases)
+	 */
+	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
+	    xfer->cs_change : !xfer->cs_change)
+		m_params = FRAGMENTATION;
 
 	/*
 	 * Lock around right before we start the transfer since our

---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

