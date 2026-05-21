Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CF30675C
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353400; cv=none; b=NwT9N+E69hHuoeI84MNcQcKKFNAEZwRnRuiIWUs/o4hI3zVbBdggOK44eiakFTHb3X1jQ0/d7d9wdfUDTKIzUIbExtnARGDD3OH7HRYrdwUun9mQbQDPhSKtoFf+lvbATiMaFaTa75fNJcoURoU3AiQ/ll34QKgH5x/KKVVsZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353400; c=relaxed/simple;
	bh=WCZvhCtju2ALnNkB/dyRi/nnFp8xIIOr0dEsissD+fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szUt3sV1Uaj78Z70VxbzXtBT5oo49oUPzDiI09CQz0p2iHZwgu9DGhDpt7z9UByHNpX3BxGzlnF6bzkZXFNnAteWzcUHejRgdo9qPjUx4ip0tzJLjw8Y+Dt1dQv0Rqr6VTBKM6/uAIEmejy0nAk9To52/xb+IwHPooJEfOEYY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kCun69/M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1FutHMZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kCun69/M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1FutHMZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5HVYl3085785
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 08:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=; b=kCun69/Mp0PJRves
	Lau8l5tDEHendJ5/prEBN5XRB8asHhY61z2NVCIcD3rEDnotEQTvpXpdwxXBf5/Q
	gbcpVblnCwjHXSZpHHCypUWK1Dv+2PV4dWiloFUa5EVzKxbr8tu9RG0wsWyWgYZU
	gGBngjuPSFiCS0QArvh1ZX44+/NGUxjzv2LBBZ2Cz21fW7WYPCk0OzNmos8SmVXZ
	5995lZGnYKzFU/lqIzE5G6EF4rwxuv+0ffCn4QiGorlxY0cpfUGEXf3kOBEeZh5p
	JYUt/+P9VLUbjtSKEce7Z4NfhmJdM9QxGTH4ztwgcvOh2NP+4d4cP0X/weHhtDDy
	y+B3ig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9c7f4gsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 08:49:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so168123601cf.3
        for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779353398; x=1779958198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=;
        b=d1FutHMZDmjfS6L9w7a9QQtCzeXbbGWlnUaJzPUuyM4vBs687ATjg4na98hw11ZIXa
         gKam8EFbJf/sknzBDtE8uRTteFsHUbfgSBEjyxfjg3jcXMy+atM0K9Xck2iDEDdw641v
         YdDHiANdAIis6HEx27dQpXo/eWKee0Lufqe02UrMUmyKO8RmwGqvXo2MNQEr31M2ZUN+
         O8LtE04+15L7qrUFwfaADGcWMYVnUJzCZbQ/ES3R/KQVw49K4JGArWmwTEMVlF4gWV5T
         xc6aqYvZlfUoTq3x2J5BdbfKyt3GIl81CDsgT3ICgDthI9Dt6McgFJfyZok91EK9/ATq
         PdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353398; x=1779958198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+eyYGxzLV0DgLeMRlYrMnVQl0ZZxnZ3h2lIptTAZys=;
        b=aP4yc0XzbHtapvU9q1/GAH4z/z70CnI1N7LaSy8P+e9De33Nvdw4HzJYmQ/Ssxe6+w
         JP4Gp33lXzLItBXkOdaVaFv6ao1Aw3roY4aJyjGnc1h2e1Gay27jVt1uwv83Qvv0gGsQ
         L/C+/4MmkbJbumrcA+5CnASxpvO3FYM8/8ABWbwvsP26prK2Tid0mI4SffJX4ScC06fg
         +liWbI/qQQ92DL2KFdz+7lHiSJFFzORrf7vTlfiKnEaov/UbfLI06reRFd2UC3uA8O1v
         7e669/20eRW09jiRY3ScZjwYaZvGWLQ49wkY/Brz1gtjIMNoUH47/Q0O+w9T3iqFwsy4
         ebvA==
X-Forwarded-Encrypted: i=1; AFNElJ/p1WRR/bx/02y+/LS4oCoHRTc/ClAik4I1/hFll36eEhDuadkGLctP40X35SD+FUtGs4kTPRXUl1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fzrNrGCh0iuzfZEaCgvJ0lNFuwyjFZoRtDxvMtC3hePuZD3L
	G2tvpSJP2F/fa5ofhahIBxlFS7DFM4mwoQIe3yVqgKilv59PXuYLqlpsDkO+jS7Wzia0Hna6NOu
	sotgUx7KuTatJa34KESf09tN29O0oyrSuThcx7Nr1C0IE2sZQsve2p9Ub1ZvEjp8=
X-Gm-Gg: Acq92OEQ3MVdpeKUD+JIc6F6UM+rE/tUuzVjW2ehX7ihpUiqJuhEEl9j8PacQlumKJ+
	hRUEpM3607tDwpx42fW+dpkHPR3HVze8cVLt+9wxCLIA6e1Q38fug4PBii+a0UGlwqlQTf7wkTH
	wW5Hr8xPQYAbJu8V7+KlIuSAwyQif6P4/VXJe87S1d2BaD1484MbkI4uRgZT0Rbl4osu+43eJ/s
	CzspSL/TLEMJUeZRdclUJYZm0TkHhMloORuu/QwHVTnWWLlGmkFni0xP46Vfeui8mpZz2NvejNv
	M64R6gOvlELDp9MYWxdCyZkvzTflCB/KAPUkG4dmVIBc0CEDs2zi6fpz/6oU8aj25UM/QJUHR1f
	plr6GWbo8BRGU2/m7ZwM5ZkGurF5cBAcDXH0g6dwRiS9/4UVGug==
X-Received: by 2002:ac8:5dd0:0:b0:510:1543:31eb with SMTP id d75a77b69052e-516c560ae9emr22797351cf.53.1779353397823;
        Thu, 21 May 2026 01:49:57 -0700 (PDT)
X-Received: by 2002:ac8:5dd0:0:b0:510:1543:31eb with SMTP id d75a77b69052e-516c560ae9emr22797071cf.53.1779353397341;
        Thu, 21 May 2026 01:49:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903cadc03esm9295345e9.9.2026.05.21.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:49:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Lin <thomas_lin@lecomputing.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org,
        braden_zhang@lecomputing.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH 0/2] Subject: [PATCH v5 0/2] arm64: Add LECARC ACPI IDs for DesignWare GPIO, SPI
Date: Thu, 21 May 2026 10:49:55 +0200
Message-ID: <177935339258.17744.11531359965950896952.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521-lecarc-acpi-ids-v1-0-ae0ae90b2817@lecomputing.com>
References: <20260521-lecarc-acpi-ids-v1-0-ae0ae90b2817@lecomputing.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a0ec736 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XCN6OSF3ifbBXE_oKz8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: VdeQ6AqdMhVnhTTiisSRMi2n9lRnVzNM
X-Proofpoint-ORIG-GUID: VdeQ6AqdMhVnhTTiisSRMi2n9lRnVzNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4NiBTYWx0ZWRfX900G+DqzWuck
 Jh4B4KTS1P6eflSLQieCQREk2fpGqBGp2m8zEESOKd9DhgeOT9HVb21z1V7rSUpil/6mqFZmXET
 SSuuiWPKzWBYbFZXhhlW92Q+9dSE1KfMZUMyAyQpaa8tKYGldH6kSvE8668nzX5DOYN/Cyu6gn9
 QeDDvAH12XImGH3uA694fUuVkTTDRQGXc7TpN+6BiqiKqQV4sFSM8AvlO745FWZyhytGEx40JGB
 kckKquggXkqzeamCIeKEucNFmBqaESip8gv8fv0+ow9FF98NkdQgEyg4wfFqg1UUwuLuq7iU2Bn
 Hk6rFSFDUiEEumd0oDNeF4bDCBvZEJeb9McFNaXE3QG6iZ3AaJt/T40x5I4PDqkv0e1X4qqIaoN
 ESux3eoiYSYap5HwGHBEDOH1+R1m0PZBCcjm2fSNpTe6vjhJS41/oZCWdCpYR2P/CIEFm1F9V1C
 dOrDJb84zCpCeUHSiDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210086


On Thu, 21 May 2026 10:34:48 +0800, Thomas Lin wrote:
> This patch series adds ACPI identification for LECARC SoCs that
> integrate Synopsys DesignWare peripherals.
> 
> LECARC platforms use the following ACPI HIDs:
> 
> GPIO: LECA0001 (V1 register offsets)
> 
> [...]

Applied, thanks!

[1/2] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
      https://git.kernel.org/brgl/c/d01bf517cbbd5a4b0c16ba2d5107bda0e361b00c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
