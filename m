Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F03750D7
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972539; cv=none; b=fggz6J8nPv1/sqEU2LjaGDL2sMz9FeoHFz2fKjAvhVWyEW6k+Ro+efn1zJ9s6RDbCfrLbsFpaSpJwo8MRhBHBQw4oPcczPLfWVQG8JyrLFMIkv9bD5H8F3FZqqypbuec06RGgmEmXMM7NiKaFC85bjOn1nbtcF2nOkmdwYNmu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972539; c=relaxed/simple;
	bh=3gW8zaHZTaZH07dB3PSD2tlZ2KSpbkUIrqHW/ZG2DTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKIzsSmc44OYynJIS52vjQzOI1BCi1IPsWEIHWkBi3DrlLFLJBa4oQbMx5K/BRBRpsOgaxIA3mR9O5nswjHQESuNHDYLWcG74TT68lgIx4PlJz2GBX7IACD+7q30uKYpwO8kvVWByYztdw7p3kyB6aZwP4QUI1x/bq+R1z1KuXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSSO77wm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghsGl7I5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSSO77wm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghsGl7I5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KJVk3050669
	for <linux-spi@vger.kernel.org>; Thu, 2 Jul 2026 06:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h39sTfM/7b6zwQc9sQowY5+iDwhDzkCtqaJCY9Xe/i4=; b=CSSO77wms8g/Thlh
	QWnP23UVl5YNzU1dblemyAMvjjOaN2OOJjWkEUszw5mgo6v5spXgHnzo0NRBG1St
	vnUvqIm/czvbiWVc1RTDEDk08kHF5TjFON1EprJFbAS1xowuPzOMsms0RoqZ/WVy
	SbcNzfGsb7euAWWUdHlwQ7A7l+V+QGgjQ0Xbrr7xoj6lcJcIoZPecWZyGgeHeWlZ
	JGB1cu17q/v/XuANtgtNW96jHpP/GrTGDJadh7x1GQpIS+Zqfwx7ydPr+hLSMibT
	d2WqRH22Lzc/nhPNEQ411xsLZJPKEeTTbwCkmYXOLq9WgMaleYhtwKqYJf1SD9Zv
	CK628Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gptkam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 06:08:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9d8549d55so12951215ad.0
        for <linux-spi@vger.kernel.org>; Wed, 01 Jul 2026 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972536; x=1783577336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h39sTfM/7b6zwQc9sQowY5+iDwhDzkCtqaJCY9Xe/i4=;
        b=ghsGl7I5ZvbB1T4R09DdyrdcvHM/sYER0f6dyhRip1TbId47S8orUMtvlG97QXf9E+
         +7h3hcuUfUHCCs2cOBi0wWHLBrKifH8RU/Xpi1w0zffMxq2bpAK+VoxXdGhPE18lNn0S
         Nh7f5CyxmU4bGHuB8KHWZvNwkxM34fJ4GR+++eeR9cqbPH8GX9rZ9OnxcPSDVRF8z4Ox
         yfxz695456MH8y4r4RjQEYcCiv5q6WmO4CUmziWIEZNYp+B1kdQ1Gu9XpwKlevy+YA5L
         pMBPjAm3jVvnlO4Q3dHKBOunBP7sSZK4INGjJ+EE6X+wchOwGknTBkjUd7z5+qMrbzxp
         oIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972536; x=1783577336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h39sTfM/7b6zwQc9sQowY5+iDwhDzkCtqaJCY9Xe/i4=;
        b=UgeeQlES75wvvKcdqSqf4NN8xJeeqW8m56dl1snfILPEotp2seC0PPypNbRWLWRkL1
         XL69I5mGTce1kQa9Ar3Vndh5bJsibzZ6cMh8chLm4avgE6nHbOlgRxpeBOUaXmuY0yUR
         q1hyP93Fqxn3IPcUYMJ27kXTB2tJXNaN1dTXCsfvb66YjD+Cbd+wF0Y14p/MndX/4KU0
         KT3VbQYGr9Zj5jxvr1u/TgfgJR9GulekQiRXjkvoBikLKHT/uJqFIXYS2w/U99ofebYj
         DldFnulpvGq2yqZsFKElE83BWpivFHLF/da+cJ/PD5A83a6Vx7aApWdyBcSb8ayfekvH
         0OiQ==
X-Gm-Message-State: AOJu0YwdnMv6E2jr0SbICLLiOff0flXQuUkjkGBdw4JmuOpPIFraTm2d
	Mq/30w2TpkCzXoueqeZw6NiNfJgxirG+fuwof1Aak/j9cp9Mzg0KcGWbWkwWMq8+fOgloA4frGU
	KT1kPZ1hkqIB6m4/Ana7vd2/7RsuSGBv0vTxjbaRijjh7+HDmdOnVQrMFbfp8jQw=
X-Gm-Gg: AfdE7ckSeU7k+9dgkbFKkjhv/2D4kEw0PLirOV9BxWpJaB3WC9oId4xxrGn+o2hUUQB
	Xw7+YG9usXi0kMirYe/BMqNXelNBmxvHcgPnaFcrwEutNeYeujn+2+WuIo0/7BrE+866K0lhdKk
	z3wB4MydFkwIbbFgr2sWPQD1JGyiivqgf+LqEjwx9Q9dWuXaZE2Ux6zu8BFPHNKndjn6QjmG9WF
	/Oi2o1y4YkIpT7oBnhE2jUNHjVwrvkmEkN55SnWJ/203b+O3CKVktaoUHiyj0WHUbIiiRHavkiM
	FZ7CUdqWQVxN6mWlu7Ut8BbnK17jxWDEu1xV7Qr6PGREeV+IJ9lW11UKr1Hu69JxoJqFWnmPPjn
	lYrJt7+w9ARe5HLWCd5dc2HwmrYjLzH2luLTByw+OiQQ0
X-Received: by 2002:a17:902:cf0a:b0:2c9:b480:f5d0 with SMTP id d9443c01a7336-2ca7e919a7fmr47080405ad.39.1782972535652;
        Wed, 01 Jul 2026 23:08:55 -0700 (PDT)
X-Received: by 2002:a17:902:cf0a:b0:2c9:b480:f5d0 with SMTP id d9443c01a7336-2ca7e919a7fmr47079835ad.39.1782972535001;
        Wed, 01 Jul 2026 23:08:55 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:08:54 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 11:38:21 +0530
Subject: [PATCH 2/4] spi: core: fix sticky -EINVAL after
 pm_runtime_get_sync() failure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-2-6ddc317011c0@oss.qualcomm.com>
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=2420;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=3gW8zaHZTaZH07dB3PSD2tlZ2KSpbkUIrqHW/ZG2DTo=;
 b=29q6KRWQU8V4i4fHxADGTApIS279oVcDa3pNLRh5g5n1yTQmxQyfbqUR7NucTYjcZ8NTVr/Wp
 J3HsIQgJDIfANgr4Q9vXDiaSNg2+I7qAPx/Gz4pOL/3+cx5wLvxkVUM
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX3aeSr/bxH9QE
 USeHwNaZIq9HNUfNwFB27o+OQej79kYqaSp9raP/GwWeBTkEbFNo/Amu0zwwzyC6QJ5C8wN6oYt
 9q60WCjc/6BMjKwv7REeoSLyW13Hsu0=
X-Proofpoint-GUID: SntJVQB4K9T3CmfEt0jzPiQ94pbhmxJ_
X-Proofpoint-ORIG-GUID: SntJVQB4K9T3CmfEt0jzPiQ94pbhmxJ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfXwiUNVtl/lbkp
 jXnqkVa8MU6ZUpfwlfQOkqOoR+D4nomni/UdHLLHuhqcjiK3qD/w6NjPokiTnT5zituOBdbsiGQ
 2Vz7XiYBmRwCYKm+1m4UmNNHrj/wDh0k+LUm7ukfbfF6X/l8TuxzRCbj7uxW6itq2SuLLdFGKXb
 hNKPCFiQs/wWx4xYEz1H+A5ysYdvO5tZdaAr1pGzHBJqJ+cSk6GSlhcRYoEY/yme9KfEPoZI2sl
 uQVgGcEBZhW/OwwkvsJigl4GPs/s/yupwmED1+AosxvRcixipu2c89rvQe00qimE25vF4Qb7xkT
 Dg9EAw0QCGohLBxOUwy2p6NBG42ILwOU4kedZWvTXIcFzCoJd7pHpDe7VJTP3kcU0ujbpsIW1oU
 +1MGZFNbaZxdhEPbHuLC14UxOMLXz1zE9JnQbSxCod73RdIeBxed9AF02NPdnQ+BH6lB+lzBkv0
 AHJG5rSdg5V+gp6sqZA==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a460078 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=02vcd1kolNyrAxwz3cgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

When pm_runtime_get_sync() fails, the RPM core leaves
power.runtime_error set to a non-zero value. Every subsequent call
to pm_runtime_get_sync() returns -EINVAL immediately without
attempting the resume, making the controller permanently unusable
until rebound.

Add pm_runtime_set_suspended() after the pm_runtime_put_noidle()
call in each get_sync() failure path. pm_runtime_set_suspended()
clears power.runtime_error and returns the device to the suspended
state, allowing the next transfer to retry the resume.

Symptoms observed:
spi_master spi2: Failed to power device: -110
spi_master spi2: noqueue transfer failed
geni_spi 988000.spi: Runtime PM usage count underflow!
spi_master spi2: Failed to power device: -22
spi_master spi2: noqueue transfer failed

The -110 is the initial resume timeout; the -22 (EINVAL) on every
subsequent transfer is the sticky runtime_error; the underflow is
from pm_runtime_put() called against an already-balanced count after
the unchecked get_sync failure in the driver.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f897789a44d1..8d5c8d7c5a1a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1746,6 +1746,7 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
 		if (ret < 0) {
 			pm_runtime_put_noidle(ctlr->dev.parent);
+			pm_runtime_set_suspended(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 
@@ -4016,6 +4017,7 @@ static int spi_set_cs_timing(struct spi_device *spi)
 			status = pm_runtime_get_sync(parent);
 			if (status < 0) {
 				pm_runtime_put_noidle(parent);
+				pm_runtime_set_suspended(parent);
 				dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 					status);
 				return status;
@@ -4121,6 +4123,7 @@ static int __spi_setup(struct spi_device *spi, bool initial_setup)
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
 		status = pm_runtime_resume_and_get(spi->controller->dev.parent);
 		if (status < 0) {
+			pm_runtime_set_suspended(spi->controller->dev.parent);
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);

-- 
2.34.1

