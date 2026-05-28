Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF893368B5
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995007; cv=none; b=QZdVtkjaf7qEAeZ8I9dDabh58dk2AcPGveL8oGKvecz/jdRmQ0rzizdXGMFzePPT79Guo/X3jx0WyOOxSR8pcALFdzU04E/OV5Rkg48qh+Pl+DX1bQYzzteLWizcPuHgCEnsCbQB1qouMa0Nsw1nvYYlXlFIVuBX+j15V0g9PSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995007; c=relaxed/simple;
	bh=paeGq+rWMQnSZAQfy3+y9zJjzTZ7DbWxJrLxFBILOy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QwTo+xnWI4fMjEbmfi1wwzaqBckBIyffVxny4WuUjZlRNue6/633qP04KKYSNUZnlWAtI7meVGICsbiM+wua8ggRxxV3gCXrCM0TK+2i2IrR8Jd+fTeLZdeFGqtvRpItgKb4vGT//DzYllaWq1FuadVeXaIMpeRCYG5wWHqyAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dok1X5Kv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TduevX06; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dok1X5Kv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TduevX06"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SI52wn124483
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 19:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OipNs2AfaqF81i04o0nadF
	204cKdQrRojdSAvovdFgs=; b=Dok1X5KveVEc0OVvIpsCQ2K2WsyUFGcxt35aUF
	lVRc2GexNMoXWqM01FX4JtucxWPTZ+r8F3ohgEtIT8JVjW6v6m6Cw8WDy1RiV2DL
	0T/oyURi9lCynFz8JDji8nd5qQVrjMh23aPtje9zfGRwbW82YnZ3IgiV+Zj0GTZG
	zPYI8X37tyGdS+EMaznqOeUatXzps1UbHpxpotqyM0r746DcmAElbO6Qy4GGcz5f
	z3QQ2LU18Ttoh8BznhH/+rIR7ndux28J9lJ9aXTuS1laQpTnrmLnNo8QON5KhGT7
	HrNa+eVe09YATDlo9qNJ+o7IepkxwVnZEquouD+h343eZ15w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycc932-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 19:03:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so12322792a91.3
        for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779995004; x=1780599804; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OipNs2AfaqF81i04o0nadF204cKdQrRojdSAvovdFgs=;
        b=TduevX06azHELZhdCSqCNJmPcf+8ux6l+CYy/Vfh6u34/0UpPQsem/fZnnrydVqkvt
         pR+4Yw1Z1p3dLpq+HHn5FXu1p+SJ4tuhnRWY+F2WY+SUcLw7UXw2hO8EYKUKPeUNg0Av
         ohwjzNoBrp/AKYUVbaOLBNomhJs/rVn+9ad4IveoM8yPsv3SfpnGY1FDgzxjIeiSNeXa
         O+2DhOSvHOOjP12JPByekdOjAJVI0c2hZ3JiWAHQZla+xFSud/HUfrI/p0790fB/oxH2
         1FdBUmOWnEn6ohhPUS+GXKYeqCWZf64HLDHEuRfahaBZPAdaae7SVDYpNXDs+PhFXNFi
         5MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995004; x=1780599804;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OipNs2AfaqF81i04o0nadF204cKdQrRojdSAvovdFgs=;
        b=ToHwfHWcsacfj1bdjIqd/peH0d2IBwg2iGM7rsG+8CQDHRurXcy6/8wH5wR1bLBECZ
         L0kB4QzlnSdZL87IicvVpP5utATHP4leVSWj7T57RORZTOowSeFXkhkpIHQiGh5zENHX
         R9EX5P309eSe8dP/jraqK0UYY3w9LoKZdaPMPdTm0vkMiadsR3EMPtfTN4cfyNv2kMCj
         OUsGvauV4YimZvnAhkvFIZUew92Pt6fIBF7nl2UDIDS/+8mUAhorWPCM9ANAL3a95+Eb
         Pyu1QrVKEggEdw6JXJASwAEiHP5p2XwNPbvYMrffm0Hvfprub2AE+K5PT7qZ/jQEfkBe
         TNwA==
X-Forwarded-Encrypted: i=1; AFNElJ8qLA6kxBylkD+zBB4+Hua2ZM5LdipqsK1LnAXWGP/X8m9H3z05OzEAjuT3IO9+6csl2dDGI+bL7BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdG5nHEC1VqUrCYWK2qENZGt/GWsC+G5uHyNJ4lJSt53/CUiJ
	Aotbox58Ogrh7ty/mDhYmDOFydxB0e1WJ4Rd4EDdx12MnxFzD2S/qTkLrWadjvMX0bGGUahEQR+
	Pht4JhodnDgDHxbIXM44ttjF/tuW3ioZPjB2DkLWmcqV8GhYEMD0FCtr1tb5/kdk48Cx3Klg=
X-Gm-Gg: Acq92OHEKj/j0xmbHcwIJHJcA9lCSnD1IyTCWSa+4p6cPQi2udcPusXmTUd+5u7LRnY
	Ej+uHmaNuHQkT6kI3x5t+XVAGmVgvCtXbvJqA3MVrajdwS47eD0Mh3AELdlknHtsrSjXq42zjP7
	gtUwRAsoRzGd3L2d4ZvqcQQlRYOd5508+F8kapIpDxYsPndTqC0JO9LxpBDw1WoEuvN7P3/XRca
	Pw9xsDmKzMDoVTT23bnZFR4tiwO12LIyQsCmx2HID9heRWBsRSwdDp+OX6lo7AHz1DU8mAP2W+s
	mvC32boPdykOvuBuGK08K+09jksiNaltjoZ0uztviIXmo4u3VzmZUNX2sjjSMkIPQXdpADYqKDg
	iu2AeaTOQfs47VXiTqav+O02ZydiUvQF+uNkimoJhWcHOq2YWB8YP9LRSF6LqOZY3RbkF
X-Received: by 2002:a17:90b:5588:b0:369:b9db:b885 with SMTP id 98e67ed59e1d1-36bba8af135mr299558a91.15.1779995004112;
        Thu, 28 May 2026 12:03:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5588:b0:369:b9db:b885 with SMTP id 98e67ed59e1d1-36bba8af135mr299509a91.15.1779995003470;
        Thu, 28 May 2026 12:03:23 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90be1699sm2708341a91.12.2026.05.28.12.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:03:22 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Fri, 29 May 2026 00:33:08 +0530
Subject: [PATCH v1] spi: qcom-geni: Fix cs_change handling on the last
 transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGuRGGoC/yWNyw6CMBBFf4XM2klK66P4K8RFKdM6RgtpKzEh/
 DujLs9NzrkrFMpMBa7NCpkWLjwlgfbQgL+7FAl5FAat9FmdtMXAHywzY8guvihVV8XAgSs+p8g
 erVWmOxpzCaEDqcyZRPk99LC0cPtv5T08yNdvGrZtB8oQ+hKHAAAA
X-Change-ID: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
To: Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779995000; l=3603;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=paeGq+rWMQnSZAQfy3+y9zJjzTZ7DbWxJrLxFBILOy8=;
 b=Pef9xiIMQLyIjLswkPJ5B7zJDZbFEO8mFAmRHVdDHXrPubIVJdUJca+jxpkd6UvTjEDu+OUmf
 EHoxlwILRiPDWyGDx+AsBHTSSEgqBYDhWxFS4qMyloPlwKY4XUZDP/2
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a18917d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XIveKea9zlLi6OhspPoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: RFH0Z1Ef8R3uoK5wS2Dd15PUFqhS6zsK
X-Proofpoint-ORIG-GUID: RFH0Z1Ef8R3uoK5wS2Dd15PUFqhS6zsK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5MiBTYWx0ZWRfX38TLPgEfvjLU
 AzyBXmPXvTP4pAhLeJ6aFimsIa88ysiN6QHDHGINTDz/dCJZGV0LUYdXn4m1kD4NwG8tO9EBlOk
 qZppK4Hhh8q3SID5gQYRsUQFEoQlm0geuKFxF1IuCqleAwKlFYGd0cq6X9Ogc1npGvZ3CKlqKK6
 1iWpDQDekisRoC9kmKaMLGmRbdtHH7slBmpwXqqcVHbTdzwpZvHwxhm9xVD4rwAcoi/MGmMsrrJ
 +HCoD/JMYQaUNjyJKnWki2Tz0RHe1T9Yqu5lBnUZ7RyU1k+CZ+gXo6VORm1nP0f7BPf3ydAoDnp
 rpd65L1AhYU3X3L39SWLHYteKkYh0GiwmzRLE6rQ01AwKjnfMPs/uEKmIZoKpmUMUlfa/IBjBgu
 DKLFDPnZWPXohOm0lLRuz0lH6XdNM97Lldn4DKg4gDeA9E9XIHc2aD3Clr5E+e4sl4yNngYskGh
 mAY4naaA8qwPyuqLlEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280192

Commit b99181cdf9fa ("spi-geni-qcom: remove manual CS control") introduced
automatic CS control via the FRAGMENTATION bit, but missed the case where
cs_change is set on the last transfer in a message.

For the last transfer, cs_change means that CS should remain asserted after
the message completes. Since GENI SPI controls CS through FRAGMENTATION,
set FRAGMENTATION for this case as well as for non-last transfers where
cs_change is not set.

Additionally, setup_gsi_xfer() was storing FRAGMENTATION (BIT(2) = 4) in
peripheral.fragmentation, which is a boolean field consumed by
gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Storing 4
causes u32_encode_bits to mask it to 0, silently disabling the FRAG bit in
the GPI TRE regardless of the cs_change logic. Store 1 instead.

Without these fixes, TPM TIS SPI transfers deassert CS between
single-transfer messages that use cs_change to keep CS asserted across the
header, wait-state, and data phases, breaking TCG SPI flow control:

  tpm_tis_spi: probe of spi11.0 failed with error -110

Update both setup_se_xfer() and setup_gsi_xfer() to handle this condition.

Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a04cdc1e5ad4..0618f6bd7878 100644
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
+	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
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
+	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
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

