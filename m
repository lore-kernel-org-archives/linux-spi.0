Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06841D63C
	for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2026 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926548; cv=none; b=hS3YOT9E+N6dvYUASKTFDdn+Ac72euRks8JLhO/wLXOGTWO42RjFqfRurcbGas48rkt+dkVFNE15fjBijc1TZS80SmKq1YIgw++zZfyBlhgevRTaekAk3MAH2EpKxAhn4CJT0MCsYTvhhGQh5v56DDR/4hsASKnS6A/tt0MKtho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926548; c=relaxed/simple;
	bh=mI310DaNs876VMDim8Q091lWct4gLOccE+n3AIxZDOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eF8wSgwqfxkwUL1OmG8B90syQ3D7ukWwfNoQ4bdq4n28Lf/kxbMk4BrOjqeC9h0CwAFDsPbpxgLSRG+Ejq3r/enFRvMLQcz3vIjpY7FsuyHv/DNt1sLI9Jlh/VKOJ3PsUKFvH/H+VUYAt3O1wteL0Dz8/eXi0/qHtYCyU4fhabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fG9RCmAA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ID/SBgiL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fG9RCmAA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ID/SBgiL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dZ551713210
	for <linux-spi@vger.kernel.org>; Wed, 5 Aug 2026 10:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sdYuzRKiJ5uVc1LtpySkh3YZr2AA91sPs89/7eafEQc=; b=fG9RCmAAzbSyKz8q
	5BkBKQR1sWcDDJkaoE52WSI/meObVPAi88rIeH+rQrZ66WkZFrA7nvZy2PTLsJDF
	Ckvf6F30brDIq4XGZYlC6tDmDezAspImiFs0pAD7mNBu3PCedNO+t1sALmYMR2SY
	DfEhQRNtEr93H8hQ2pUTxExQaLuhf0a8A/wqdoqdeM9qU6kaYunhGduJIVXFllq/
	FS+LBuxA8mtOiyNBGjYBzLFeroc9iZRxoKrMLWHf5+W9TXXBUgR1/n39lbEwCPId
	B7xfzjTpUg32UsBM91EwzD0gucnLpHGIlnr2yOXXQPXWzzIgyBREKgQtO7x0ZKq5
	7jCW7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuwbqsq82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2026 10:42:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cea6a46766so15793025ad.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Aug 2026 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785926544; x=1786531344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdYuzRKiJ5uVc1LtpySkh3YZr2AA91sPs89/7eafEQc=;
        b=ID/SBgiLX63mjqCav07BnpnH4Ojr6sE1kMd5dIxCZTERnsMnd8OHhj3PG6RvAZlnor
         UeH1PJBId9zqKp6hC/v5gVLv/Vh/nG4FUOdsGgZQz4W0V+huEsfNtvFpmcsqFuYNKUu8
         qI59lhw2VdIOzrnGS4YCjKaZCepM2AsLf27RRF2IsdNSXZTaAbIlxP2IQuFPMPcqiwCH
         7MdR3LsOTX/kL04j5aG7L/3jAtvp8w2vE8I5Oy/Qhy7CjTQiuc8fpowrXEaE73L2HskC
         IllrpuITRhe2/mf0RbbsNKQueuw7gqIbtA4ejHrr2yQdZvVZ9pEyayw4tKXJksVZa7X1
         4kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785926544; x=1786531344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdYuzRKiJ5uVc1LtpySkh3YZr2AA91sPs89/7eafEQc=;
        b=fA7KC2xqYZpc8SfXD9QUJuxJCQFU0hJey7064EBbXXia0a/0XXifNW3iEAxKP/S2nq
         p1FfUYYDjYtM8chueaeHg6vwxL8b+0Hsz6hwHPVr/k/w0t3/TrN7Ko3oRUTYqBcmeyqr
         HRoioCCRuf2J05XbqhKqae93I4qMGWvpx7SPToT53kD1xmbk2JRTz+3V3kmIALMZb07n
         dP9cKM3Xr9hspv060Qz/YGdvevZ1846fFODlVwRKgsgK2UPrWA/Ti+49Ad/73vXqlqtb
         qH7x6cLj3WWNQ70Fge00yGrdTrWsoiXdG9MI7ZaPQ+EIHfT95aYt7/I59kFdN53gUAck
         RXoA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2VK4WIru06+TUDDzCIUBQsdeauuMUONg4lyfWAkPvSFt02icFcbYIgJtUPDgi1mo3oLZEcWy0sEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnpmktv2/WG1VsfwdsO9umfAXhH7fpXIgg+XLRF7p836ruZz9c
	ye9aQVqsYeKacavEjZ6KwNr1Yh5hc5up6jvFxqG01kQ0T8doKBq+ZmHuMKPEIiynEU1WYWTz66s
	JwwXjGvLWWpyMkuOnpJS8YF7afBPKUuX/gVVgpDMUP1CKWcx0zoOyGbsOEsgmsp8=
X-Gm-Gg: AR+sD12uaNL97fGz21Z8NL0fPx0Ia0V3DqaNAO7JyILIsW/1G9bjglu+R/co3taljH2
	747ccV5p8Jclah3BwTZ1smH9v3Y/3r90nxAtkmrOahMUUaXD7u2CKxx1F+B4cfC2eK7+UvTfraY
	6jzdgU2BqnvjdA4HEFDTa7nkwhl5GXEX1NVcYRbU3D22DFyaEd3pOyg+bLQdR7p129kXxF5Sgzo
	XnR+t9rfb7x9jfwtSJOkmwEqAmbCXIid4Su/x+8fIEo2IkNNYbc7mzJBoCFOR84wLsCauocSTv5
	CBXLRF/l+MUD6qEFHjOIPJTC1ZBxtfKa2HRWDAP331w0Pp8V4yE1AYQVlBQIee/XJJe5dSzApGb
	P8eJrlj33qyjNO3A8Bu3RiMRwIo3lfhTTUQ==
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d0ca71b3f0mr69165185ad.2.1785926543973;
        Wed, 05 Aug 2026 03:42:23 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2d0ca71b3f0mr69164685ad.2.1785926543516;
        Wed, 05 Aug 2026 03:42:23 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa49295asm16131265ad.45.2026.08.05.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 03:42:23 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 16:12:10 +0530
Subject: [PATCH 2/2] spi: qcom-geni: Add panic notifier to suspend
 controller during panic
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-2-b5db170d491e@oss.qualcomm.com>
References: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
In-Reply-To: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785926533; l=2610;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=mI310DaNs876VMDim8Q091lWct4gLOccE+n3AIxZDOw=;
 b=6+wQDeBVvCCKxZKYtJlBvMiHfh6HJIecwMDhPfJieXGc2OwwxHaMHY0gvSxVmZA3p2Qyphdks
 G/JPdfKLqAPCgp5WepUq0vEqs3UhZ67rgQLYvcaMnss0FF4ngUHiQk1
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: FRbUNRa-CEFE6wmV7oAgY1wnwKUtJ26z
X-Authority-Analysis: v=2.4 cv=B+uJFutM c=1 sm=1 tr=0 ts=6a731390 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uSTXE6O-h9g-VyJA4lgA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: FRbUNRa-CEFE6wmV7oAgY1wnwKUtJ26z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NSBTYWx0ZWRfXyMQHU+csNCSp
 ze7HT8Qw0kdc2vb1wsTMtyOAPEdNjs+NHSQUYgeNit8XZSJOQTxaJZL5b+1RgaMcwwQ1PB1KIz8
 TA1KJ1+V9O4qUS3B38wqf+5jpq5Tg+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NSBTYWx0ZWRfX3QO1X5bf64z3
 SXC/rMo2wg9nBSicZRBZJnoeRMqYKhR7woQNOx8HYnHZRfCl5E90L7eFkxCz7Se84yRn36BOM1o
 iDw5v3w+qmXZMeXhrlCY/He3efUVuOeZsZHlyBaLRmj5i4EKf9fARi9Xd9m5gXaDDt4wjDREwLQ
 hugj2lC0tyfy1gElyS/lXjtFa+bZMCpFhNskh+IVuxHV7i9dbHeMlwePzCmw9rYvKG9P8gbxEe5
 g+CeS0SZ+qIKRWY7sy3EHyQhLW9yeJNFPq55bX5RNHjqn/aCiwD6uMvIQoK5wc6cUcXaCgVdehl
 1WTOVhJ6EaFAYF9XllGprqDjXDRZPiZnC6Pli19e3KFh7wNLI5YB9fml+S6xx0dFJpGyA7gGvl+
 dGNNSeKZXDnNsOnzjld0XtC9SDxAwCXoLISkPnc96p+Pzd6P5tLazO0jDmuQTOD9sT6k++SW7ZF
 loqq60vrY6+6bRsZlWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050085

When a VM crashes with an active SPI DMA transfer in progress, the
SMMU raises context faults as the DMA engine continues to access
IOVAs that are invalidated when the VM's memory context is torn down.
These faults can affect other VMs sharing the same SMMU instance and
obscure the root cause of the crash.

Register a panic notifier to suspend the SPI controller, stopping the
transfer queue and preventing the DMA engine from issuing further
transactions to invalidated IOVAs.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 39d67f19244c..dfd87428e84f 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -115,6 +116,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	struct notifier_block panic_nb;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -1073,6 +1075,23 @@ static void spi_geni_shutdown(struct platform_device *pdev)
 	spi_controller_suspend(spi);
 }
 
+static int spi_geni_panic_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
+	struct spi_controller *spi = dev_get_drvdata(mas->dev);
+
+	spi_controller_suspend(spi);
+	return NOTIFY_OK;
+}
+
+static void spi_geni_unregister_notifiers(void *data)
+{
+	struct spi_geni_master *mas = data;
+
+	atomic_notifier_chain_unregister(&panic_notifier_list, &mas->panic_nb);
+}
+
 static int spi_geni_probe(struct platform_device *pdev)
 {
 	int ret, irq;
@@ -1161,7 +1180,16 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_spi_register_controller(dev, spi);
+	ret = devm_spi_register_controller(dev, spi);
+	if (ret)
+		return ret;
+
+	mas->panic_nb.notifier_call = spi_geni_panic_notifier;
+	ret = atomic_notifier_chain_register(&panic_notifier_list, &mas->panic_nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, spi_geni_unregister_notifiers, mas);
 }
 
 static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)

-- 
2.34.1

