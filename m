Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B851FCBD
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069121; cv=none; b=XqSz7cCo0oYmZ+feE+N1SzrVLwz1EPLHV7mYVRpGY+NoQR0rcsdO31CHMxFk0LIKRjjRCofGj782J4/xh8jIA2rUijcMmqpo3EZntPqDHSbHFOHDREimmH8Ollq2cF8sh5iaQ20PdEo8GoYg+49HudJrtc0YFkh2qSHw+YwGSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069121; c=relaxed/simple;
	bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iY4DoAQkBGDt9JO02JR41JXX8cbMkYY2dpyhN88mxuUR4eNVjBxGs6eXNBhapzrS9fh/j+C9n7zlXdU3u7YyGdByXPGhozac7JCRs9Gh/FKevlWsfBKOkEm/hHhpc4c/2Gi4uc6YSQiOEw6/zaIkiHXxVdEv/SZKyZB5QKpiiuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKljQCPe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzwOTpSZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKljQCPe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzwOTpSZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPu6V1596362
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fn80m7lvIkTjz807COGpVE
	82JK0kaqF+rlFlpuCly0s=; b=pKljQCPe4m8ZDljQiurPI5am68GgBOMrgcdWYY
	7qp0lbfjVuJmJiR1wFrlmBprCAZ1IYBJZajlZcYLnoWXBc/QxDMGKGMYBXRbScml
	YyQrb7HyJgAxVpdBxrnVOa9ps7CAU48f+gkbPIqjUcrPblsoo0GlS/ZrHdK21Etq
	mg92OeS3LSxAP1kFuVgTkzIDFPcEA9YJ1JEKMQfduWfeQT4teghicjS47L60aesO
	c5NluH+rj8SiUjVw8Db7ENRUcm0D00dLSqoP07fmmyajp6vAlvOUVNp6/OloNHBf
	TkO36L8XLx6dT85GTYQCOJMplll2/gTDwrARXjqOX/JFY9RQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8hme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 12:58:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9501034c4so21034975ad.0
        for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069119; x=1792673919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=UzwOTpSZt9VEGtO/vrfcYI8Z/y+BMCpI0/Ht2epOuidC7nem9S5M/yzrXJ/z5OcYSJ
         e6ntvGbXjVJ0yUrAYYEWpUQ8Qz2sJFfOncO8MekN7Hsuve9H0VSS7oivkWTzokMGyE2R
         GKzZBZKSv8+BK8LVpWmbQuF/hQua8J+ls3pvs9GGP4Q7A5rYwK4TKl7WSEQ5yYUvcc+1
         rlsD1D+JhHq8es/jOIGKgyxpqterDwjurG+qDOjGi6W7NPmAuvWz1DBAySJAyWkX4EHU
         sAk+e+oCQSkmr3DZ8sToyIfhs9b//x1d1B5IVguT9qjHysdPtQIh1svEEUG6f/9w8nVN
         ZrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069119; x=1792673919;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fn80m7lvIkTjz807COGpVE82JK0kaqF+rlFlpuCly0s=;
        b=qFBwC1WxFevB6wlDAFuPbDF2POZYEmaBzJMp5889J+KsCF/UGDU1J/JA5nyyZJg5Ba
         dTmmrMZ//A91xzogO9Mltb5KzMt28aPavbW2fXjEo6Mnwe/z9+TXZdWLRSv7at1Um+FO
         4N0nTK6hwMJHI1GkQeYwv0pdceUe/oWkHNacgs5eHjjAlm7sLc7hqmXCkpSguSLDsYW8
         aE4hUcpFhXjp0anhFbkVSbqR2Gp/HBBD3XM+BPYgKQQt7UnylZeIWVvOEVwYc0W8yCJO
         W6aTRbqJzZgHvMofNu/gWbSdD3AElgxtpyX/JiGbFZdsIXHTV1Gq6zqXCXrH704ErRfm
         jOug==
X-Forwarded-Encrypted: i=1; AKwUvBwhShUnmTLH4mHI1d+Y4zaLduZ+9IP5Rn+gtjuiKWLoZOO6Fy7ukEz5PG0O2ZJ8FkHvSnaNlGAtPIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6Cv5Z133tIQdBOqiS6LkaNz3iik61pym8EVxZ9VT0/9zz0N8d
	sj3bY/CSp5rfaKjBDrJqhsU/H3NlxocZCfncNNx7uBERfUADLilRR2KaaCbcIcFgcWo2oDRpjiU
	Hm0wvv7jndN6ksrpSrPzL4pyTaO9O8WZBuY92xcfeQKYmvFofBIMMbGOaox1njHw+hauk7Fk=
X-Gm-Gg: AYBFou2yG5IKjqvZQKUeStvd8wihjq9udekJyMbcO65GVF33H+m3G5dkZ44u9rxkO9P
	PAlCU9cyRzTXrmBa0Ik1/eM+/xNLY2OuZ332RHQvSmrNrby4HkrAHbn8IvE/gcHonJSMCxpyYAy
	yWuQ04ylUlIclDAhyVGgqTd22xDinUrW8pzJy2ZUEY4ef6A1TJTtoPI4QtKHmcgfTDrgiuxqFsu
	p20LzjR81KPxgJoJQoAUIPzDZ9WGjrHIjWE/yrSZDjy0qKzmQ7t3Zd/tVFEGMPAyJluv0FuSbTB
	qz5r3ymJUBUmOO+CP5JWCiGTJ0NwieOCtM89XEmTzUjlGS7npp9e5R8juwCU3KURlXw2VocMEkB
	0c+q/DSIPk+2hLJ8v5ZLaHNpje6RfhM6wrw==
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166590045ad.50.1792069118754;
        Thu, 15 Oct 2026 05:58:38 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:2e3:1bb4:610d with SMTP id d9443c01a7336-2e842f31562mr166588895ad.50.1792069116492;
        Thu, 15 Oct 2026 05:58:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:58:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/8] soc: qcom: geni: Derive SE clock configuration from
 OPP table on SA8255P
Date: Thu, 15 Oct 2026 18:28:20 +0530
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzN0GoC/52OzQ6CMBAGX4X0bE27RBBPvocxTX8WqQLFFhqN4
 d0tevHgRS+bTDLZ+R4koLcYyC57EI/RBuv6BPkqI7qR/QmpNYkJMCjYlm2oSX5EoduLGNDXYlS
 tqL3r3mRcJ20v3DCIUaoWKdRQSZMDQCFJejp4rO3tFTwc3xwmdUY9LpXFaGwYnb+/FkW+eH/HI
 6eMFpyXXCqujca9C2F9nWSrXdet0yHLhggfFSh/rkCqsIoXVWkUKgZfKvM8PwHOdkKGawEAAA=
 =
X-Change-ID: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=4235;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=v70FRW5iiRhX/4+aCXUZxMXenF3esiNtKu86as7Ptlk=;
 b=u1m3iW5BCkVT1gNC6NXOBIobcvi6p6ZecmCB7PJ6QxVqlmRw8ffyqb9rCaDH04jFYYTlQZXWh
 YSWnLJ0Bgu1BjkBTlL/XVn6X+JoGHcmU9dOvlGgu3Qc/pr8Uza3vAAY
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX5vSHsJv6/d1C
 x6H6s1VmZwhBklZnKHXgEg+kjELePg7/a9giC60T/M44pIsPVuhMWSkrNn3YDKlqQmjDmGvP32C
 fnt/7eayV+5FJUyejYypg6S5P+oiG+S5VL+GQR5YuEIrxgJjmTFRZurQZFrnkb1vSdjrV/xv0fA
 l04EHb5cjVhc3XAUEf2YmqwIfwWKjdhQCWXQag575G2BlkzbBS9qjE5euGqM+A9uwd+sIIvgQCE
 j1ebh5TPWFLxKopOZtSpyRQ3Awe6FxJN6t6avKSjGVU4ZJZnktTv9s3GPhfzkbpWwK3KbME3NtR
 DrHLZGBvp8r/vAHjUI+iQfhFxAHYJBSKLLg9eKuXgWajpp3BNE4NzByj6NpXrfzZO3LmuhdydNB
 ZyB0BAR+NQM8trV3qPyZVaOyOMTNCxSKn71x4ai7C11wQAi+sHwjMhbNVct6gYrZ4Srag1TVlWF
 6cTCjGFVf1oVHTf36+g==
X-Proofpoint-ORIG-GUID: v_FzvxZAVCBm3xbImsepo30DYeVZVlaH
X-Proofpoint-GUID: v_FzvxZAVCBm3xbImsepo30DYeVZVlaH
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0cdff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=2LTROXezBIF7KgQVBLEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX6qwGQ9MEETW5
 QwGg1NWmhp3YzkZ5qJxJB/D63VlbEPAeHwx5uVEC3tqXEFRn7nJCLHc0VHQXPcCzuByQLRqOw+2
 p5lHoWdJ3OctO3w93NfhzvrrLW8JJ5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On firmware-managed platforms such as SA8255P, there is no Linux clock
handler available to determine the appropriate SE source clock, source
clock index, and divider values for a requested protocol frequency.
However, these parameters are required when programming GSI TREs, where
the hardware expects an explicit clock source selection and divider
configuration for the serial engine.

In contrast, platforms using Linux-managed clocks derive these
parameters through geni_se_clk_freq_match() using the source clock
information stored in clk_perf_tbl. Since the firmware-managed path
lacks equivalent clock information, protocol drivers cannot reuse the
existing frequency matching logic and instead rely on a direct mapping
between protocol-requested frequencies and performance levels. This
creates a separate clock configuration flow and prevents
firmware-managed platforms from deriving the actual SE clock parameters
required for GSI TRE programming.

To address this limitation, the performance-domain OPP table is treated
as the representation of SE-supported source clock frequencies. During
geni_se_domain_attach(), the OPP entries are used to populate
clk_perf_tbl and related clock performance data, allowing
firmware-managed platforms to leverage the same clock frequency matching
infrastructure used by Linux-managed platforms.

With this change, protocol drivers can use geni_se_clk_freq_match() to
select the closest supported source clock frequency for a requested
protocol rate, derive the corresponding source clock index and divider
values required for GSI TRE programming, and apply the matched clock
through the OPP framework. This removes the dependency on direct
protocol-frequency-to-performance-level mappings and provides a common
clock selection and configuration mechanism across both firmware-managed
and Linux-managed GENI deployments.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Added a return check for set_rate.
- Remove redundant source-frequency fields from clock tables.
- Store the validated frequency in gi2c->src_freq.
- Use it for OPP configuration and runtime resume.
- Preserve exact source-frequency validation.
- Simplify OPP level iteration in geni_se_domain_attach().
- Keep level initialisation outside the loop.
- Increment level explicitly after processing each OPP.
- Link to v2: https://patch.msgid.link/20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com

Changes in v2:
- Add new patch to remove OPP rate reset from resource deactivation
- Add new patch to vote source frequency via OPP for I2C
- Compress the SPI, I2C and serial commit messages per review feedback
- Drop a stray blank line before trace_geni_i2c_bus_setup() in the
  I2C resource-initialization helper commit.
- Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com

---
Praveen Talari (8):
      soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
      soc: qcom: geni-se: Add helper to set SE clock rate via OPP
      soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
      serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
      spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
      i2c: qcom-geni: Vote for SE clock rate using OPP
      i2c: qcom-geni: Use common GENI resource initialization helper
      i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

 drivers/i2c/busses/i2c-qcom-geni.c    | 58 ++++++++++++++++----------------
 drivers/soc/qcom/qcom-geni-se.c       | 63 +++++++++++++++++++++++++++++++----
 drivers/spi/spi-geni-qcom.c           | 24 ++++++-------
 drivers/tty/serial/qcom_geni_serial.c | 26 ++++++++-------
 include/linux/soc/qcom/geni-se.h      |  2 ++
 5 files changed, 113 insertions(+), 60 deletions(-)
---
base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

