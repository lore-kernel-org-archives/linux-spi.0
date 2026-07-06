Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C71D4DBD96
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328021; cv=none; b=R41YrEjTCGKnB+s+iePD7PCe/KOqdlVCxa+Qj73h6i+Yc9hEg0kk7Zk2ToQzUwuub4ZvOypo2lMN4tML2us92rhAoRmZVwM5h0zTvwxxKcuo7dDnDK+kFa6ThQkpHHOH6LMq3DAgLofrPsZpSe90SNsbznmBIOoDKdeV7iEgSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328021; c=relaxed/simple;
	bh=kv9UvjF4OBgXx5N1hdvWktzSDOGEwPg+1mlUNMbBiJY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EN87bEQYaCf5JCX8ZpsmiqybwWOPuyO0OW5+kI36xPHj/VoXx+MD9q1kjIr38riljmUfMy3iVZ9DGVJHC8mUlsPNT1IqA7Pz36vxmM45jC/5m6iaLxfuE5tExVxtgAnMKSrXfGvoy0Fb0DHjn+T+A6411ZI1ic6GfTTt9n0LP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3RYKBiw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FLlKWHzO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3RYKBiw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FLlKWHzO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6668N8Vp4072537
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 08:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xQyaC8kg27l0TtZIDeouQj
	A00fl5IzZHks8WCZaGeYw=; b=e3RYKBiwj+xC81Ik/Ry7deKZXGPkps9t3ajky5
	mUHlTjWh4meh4OtAmnRBud6iL9Bg9N9I16/PlHzDUNxA1MPuoQaG0ioboHbY8M2x
	UUk+ZoUkPLZuiU03Tl2OnDw5RhoTPDVKTOigAcVpVhH83a1T3vNWNiEHAarh2Yfe
	0PXGPsGDU/8e9KoEawpih236cWzezXKALka8+w9t/1+UJzs5NDLJ6+45Gq3Hv9lu
	iT+iDd2QQ/N20gSrl8pLKDS6nl0lJsgXuZTTVQlXtMnaNk35ad5G7V5bVPP3De+h
	hVoPa7cCZ6X5SfhuV9U9+9LFLzydqowvxuMbc031Dfovpqpw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t883yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 08:53:25 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84622d6102dso3752178b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 01:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783328005; x=1783932805; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xQyaC8kg27l0TtZIDeouQjA00fl5IzZHks8WCZaGeYw=;
        b=FLlKWHzOmvTUi1J0FniMBguV0DT1YnmrVC+7G+LScxyV6McqJG1QDeBM2Xk6G7TOBX
         DakDzMRE32z5DiXlaYgAvQFt0HA/G5gu4pQ6sRrH5GtspkSWqAkzx9nO3IyIC66QarvX
         gRgMkBo0SDslXhlzQ6Q3siZDxscULvqvA0PokgWv8ALuJ9a4AnVugN+6gnnVzhLZaJ/1
         LcDjfDvo1S99j5D5LMoMuwX0Zsr0c3gxrtg7Z+BzkiHFJGlrOiPs3KRuybDCc0ObOcqy
         k6xtMAbTH5HcF0d/I+lRBmmGqHM+yvumu/Ro1rKoPXnmXD23GwDVQjuNPH6byfbI0Fsf
         M8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328005; x=1783932805;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xQyaC8kg27l0TtZIDeouQjA00fl5IzZHks8WCZaGeYw=;
        b=dXsB5N5VBXMixB+ttFTgcUJe3FvFQ/1iRHhYVUSeR1ghLCQc1BvaUH1LDcVQnlsnep
         5w8kyOnq5VrCJiCyrX6bpc0PuOlekz0ONzybkdW54sSN+WvspErxIX4WjLDPwPBRQ0/j
         G3nqoHv1WRcOmRrVlGV9KcfSgZfwjeFYoTn2dX/GdSnBt0lDKayFeNueNDWy6mhngXgs
         tnhxM6Bwpf45tghldB0268qp/CiQq45AQ5A1Y2mLCkY4M5JzjFbQgu9EI1ukC6lK9t2E
         UFIkvlDl8KP1SRGXOsHVAvpaUq7nN6ewhkYI/zI97xZUjiALG89XPL3xE9CruRLlooHX
         RD5g==
X-Gm-Message-State: AOJu0YyythwUQeVg8KU//JEVeM4WKk3TKwphl1ZUQv4X8V7ZieZoVQ+S
	t9ggbs4L+0Gw/AM3LFx1BVIAoHc0gsBsEa5V8Tkdyg4Aj85vmweH83HXIi6gjbKAip1HKiyw7Z6
	iZrNCG02qAouwSsrFjNZA7BO1bbg1wz0Q7n97ouUv+mWD8dJbxXQrp7c3Rbg83VE=
X-Gm-Gg: AfdE7cn8igVch6zJZC59O1W/TmI8E1XUMIVT/AHQZPUsq+fgptmqwxaFq0EoUNUp4he
	rb+EEfOfybzI/TzuJekhQ55S+fk24a1S2iW2OX1MsvaJu40em6yQAM6W+jtcQnHXiHs1ynbvaNl
	FJnWNe6KWpmc/qmIELpbA/RnycQ6/sSnT0eNpS6nvR9GlTdxfyclocAMscKd2wwjd1ck8jepOLR
	uqSR7+I6hBZUR/S1ZSCJuZcwZUFFdo+4M12b0cWWErReL1iBLZMHxUzB3z4EXXR5po/8+8p3Y/z
	jF2eP8qGT9ahUfKA/iyjwPxIfUvCtveBOKEY+g3sMuFJWy4KmoTSGddVWqUEMbLTiM/nbz1KLNV
	hBuG9UEX8AXvR2OHm6LPmN1vTCSCd7Tf+86KoASphWDys
X-Received: by 2002:aa7:8882:0:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-847f6ee37f2mr7547862b3a.35.1783328004733;
        Mon, 06 Jul 2026 01:53:24 -0700 (PDT)
X-Received: by 2002:aa7:8882:0:b0:845:2ff5:b66d with SMTP id d2e1a72fcca58-847f6ee37f2mr7547815b3a.35.1783328004019;
        Mon, 06 Jul 2026 01:53:24 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9e12csm3411834b3a.21.2026.07.06.01.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:53:23 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] PM: runtime: Fix sticky -EINVAL after resume
 callback failure
Date: Mon, 06 Jul 2026 14:23:08 +0530
Message-Id: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPRsS2oC/5XOTY4CIRAF4KsY1oMpaBucWc09jCEI1WNp/wk00
 Zi+u7RuXMzGTSUveXlf3VnEQBjZz+rOAmaKNPQlVF8r5o62/0NOvmQmQSpQsuYNXU1M5M43w5H
 6bFtjm4TBjJ0JU5+oQ2NHMo2ldgrIlf7WHmztNh5YWR0DlomnuNu/cpwOJ3RpYZbGkWIawu35U
 hZL76VrkB/rWXDgyntXCQ1COPgdYlxfJtu6oevW5bDliSzfmepzRham1tuD3lpwzUb9w8zz/AD
 BtxpibgEAAA==
X-Change-ID: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783327997; l=2169;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=kv9UvjF4OBgXx5N1hdvWktzSDOGEwPg+1mlUNMbBiJY=;
 b=mn+rVKDPni6XEuSuNPFes5p7k/c4PzNztMybdKlLJYgI6PIK5HSfOADRi3ogBmqhDFX9uVZQy
 NrjIgpAcN4eBPNCytloZRClJGZK4bIp80HuDvav7fELIF7FKAdvj7Ol
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfXwd1YVNWfW6cv
 /qInzA40oSmaLQvr7mQxRhoNF6QjghgG2Uyi0FFcwFSgg0OtrvvArkJBdVtzru6UiFHLZk+X+fx
 lv2l87FBPzjLx8A5stO/cSXfaOReaj4=
X-Proofpoint-GUID: qUd0WtoBrEhxv1XBiv-p9LSeMzzraz8K
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b6d05 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=rhjnKYj_BpsB81YBZ8oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: qUd0WtoBrEhxv1XBiv-p9LSeMzzraz8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OSBTYWx0ZWRfX3wK9T2rO6X+x
 kpiRM/8mUQ6ytpSFPLVvs+gXVTJ8v8FXxROZfOZbIGfV478tVBAzuABDdMst3lKWhVcXFCgdFM1
 HK6KqyKnmPGtACQQ4D0JRQ4YcsLLsG3YYtxzRHe+DWmghHH2vHe4R2fJYBjZrV+Sb5LjdbORybX
 GqgehK9RU1mcgQmgAdPLXYNwixjIOelJ9NI49sk2X2wD6PtVjrkWiQGmTk6s1RtSaN5m3R5MVaY
 +K4Z9GNKVBFSJzJgghYjrTY9B0Bt52uqZGfEVJaLz9wq/OoRZY7ut9AVFvjdr5k29VWAaZUVPY+
 te0BQ83yKE1lLm2EqB03FbAMoi4nzoCgK5qJRmyCnsiXC8E1Z758yAtm+6/JzH9wFeekVfzofbF
 P0XdxzPKi4vgFF6fR9M1w760HfvTCKI0ICU1Mbo3y7iuYuqdysGykmCpt/Rp/nyw1Z4Tn6DGHeQ
 MK73MhqQ0wYwBkHiD3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060089

When a runtime PM resume callback returns an error, rpm_callback() sets
power.runtime_error on the device.  All subsequent rpm_resume() calls
then return -EINVAL immediately at the top of the function, permanently
blocking any future resume attempt — including those triggered by
consumers trying to power up their suppliers — until runtime PM is
explicitly re-initialized.

Unlike suspend failures, resume failures should be retryable.  The first
patch fixes this in the core by only setting power.runtime_error when a
suspend callback fails, leaving resume failures transient by nature.

The second patch fixes a pre-existing issue in the spi-geni-qcom driver
that this scenario exposed: pm_runtime_get_sync() was called in
spi_geni_init() without checking the return value, so a resume failure
would silently proceed to access hardware registers on a device that was
not powered up.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Moved power.runtime_error assignment from rpm_callback() into
  rpm_suspend() at the fail label, per maintainer feedback.

- Link to v2: https://patch.msgid.link/20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com

Changes in v2:
- Reworked the fix per maintainer feedback: instead of calling
  pm_runtime_set_suspended() in rpm_get_suppliers(), fix the root cause
  in rpm_callback() by not setting power.runtime_error on resume
  callback failures.
- Link to v1: https://patch.msgid.link/20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com

---
Praveen Talari (2):
      PM: runtime: Only set runtime_error on suspend callback failures
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

 drivers/base/power/runtime.c |  6 +++---
 drivers/spi/spi-geni-qcom.c  | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

