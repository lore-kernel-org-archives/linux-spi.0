Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E33A785D
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352108; cv=none; b=jVI5HQUh+a+sul/nOyK/oIBNYdMARNSJSc9OFT6mH21wmxj6ZTmTX2WFzP3dNAJdj6nD/xalFdgM58/JcspFWS6Yz3ogOW0mDHh2qf2yJ/jUNH1/9hg5EHutIWIJ0JpZYXtmjEzs67Hk/kGu/gsdfq1udbCV5HjxbATtYyNA6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352108; c=relaxed/simple;
	bh=24x+vWFLjhUk5l3YpK3HhMGF1FGUmyEy33Vjj+/mG7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1XSd2ficWCXjAYIigsRBMLKiJUfTI/N077LGVfvD5D1bUpFXRl/9VgnkDp2YccHipNT2AX0IgJsAykkP1bhHhcEz8gfbCOUn4ivzyYmM5g22u3uWQ9klD2HzD4usi4neZ2MniTlWWEg9/5V9D7lGEGsL+kh/ilUd3JscOn7was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPdAahHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZyWk+42h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPdAahHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZyWk+42h"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFBpq972248
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 15:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=; b=nPdAahHJZa+SmQ7X
	Om7qQXhhKSV6hKNfnZMEJofwS+PyJwzNdiSnFkYEd0WC2+Qnmv82TRM1NanVF4Ei
	kPZIzNyrHhiFC2HVnrUEYWP9+cmjliCJZAfCIERVQ9jENehf83WUqQPvaqq9hE2U
	2AIvqqa6zEzH7Zb+7xwZ7EkyB+QCB9JKZpzybhzZfiuqyJIZUiH4evYwGcq2ubBH
	mShl3zLv2Mxsmp99YT9L6v2uQFIgt7gRvH4sEMJu19vctvEEfbw/LyXlgM4mTDZx
	wT8YV8gvcXE7JjMRycdk0mzgU4BWQ+Bqfrh4hVKG2PbpqpqmD6mnMoZBHwWSPThW
	cw3hyw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r1fjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 15:35:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ead919557cso11594286d6.0
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352104; x=1783956904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=;
        b=ZyWk+42hnl6FkCzOPMsLh98YteMOUNwMwbaua5kF8AAx380qFDz8eCxO4BEA40kyBW
         Fts1RbOc4dkiPsa/NBtl4DR88VGrkgW5W4JHTipIdZ5pzoWiHcXd3L24g5vkJVXeDMWd
         s7033Z4byi9NFoTxS/ncBgaJrKUt2D5q+EeO8gglCOA7G3kq/K+EAbYiltCX69gMypn9
         Mm4ei6wVLDjHdtdvzHE62jkv3V8IwpylQqiXCJuwSNpFhh0xNA7PUTTGnsZ3cXtwOEfH
         ZVndiaVbQNlIY98KOoQH/0DfIVHOglynwrRGYaosePOfHhQyv+Q2pgCk0dU3AD/AbkDd
         NkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352104; x=1783956904;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=;
        b=jaLd/yt+fFIGVy3CuDuPBXrwtiaUs4gN9T8NAGRfZdu1bS3vkMQ22BiTvASwJysTNe
         A8mYsxyfozpn7myPcq4Vw/8WIWQ4l5m77Palkm01EHfxnmv5EdtnUQV2VExoE8a4fcwU
         U9ecH5S4weIpLodrlaFbdeP+PsnMZZoffENA6fbh18j7bqm5s4lo0vv49tRWU8eHUJgg
         Z5sReb3t/uM5p7If2SM6qBRNTjgFuXXo/+RcOl/XZvXEAsks4HZ1y/hDBbD4no1HjiYn
         dyW5aVkhDCN4Iej1N0kDjPEBK7Y26Vxm7Q2X7Nfcx69UI/IWA86CG4QzOYTiR3IHjM8K
         rtAA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt0WnA0jAJyiwV+W6MiUVoFcJnPAgYVHQ3TlwsfqHI1Y4Py3pB5iE7Lyiipcl7YX8t3t5CdxdXXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/2sVC11sLXFnv6NcMHurWBfowVfdgMUMgIYOcaVZdbI8bzNP
	eE/xMy/aLYRpwLn2424xX/5hu8cYawL6jKCWuBYlKL2O3bJaC18fKYqyKJ2KbcSiJ9BWdjDY806
	FcTezq1nWJhqW5VOo4nY4/BnOLeb83XaYpgWZhkOx1TlkIOZsz5d17QZNwVqrlhA=
X-Gm-Gg: AfdE7ck8eX+BXQVuZdZfjxmafU+ej1MontrTI+JYhjYv6qc+gc69MAIfcH1AUcEP74n
	ojbEY900KuS3DyrRMNPUfPQkLBZuNQZzdbZPGuD362iovUu1ZwaAOHr7jXF26x0b894Q/7sVxhT
	1VDiSiKqleRCdGyN+0D+/e2WCvcpA5QwBLQ3E6mpUyNqNM4BJYzSCnfuRfLCXeQm7f9VCPlawh7
	B8Tn7zVgn3Lda7WjZiLtxMzeoltv+CbZ5kE8rDdu2b2xbMfxWmMmtAskEhSQhfa1DTn6PL551Aw
	D+PznNcmA7L7FAR+QgJuZHrKXV28BwqEFGkt/D6C7diw6SKyHQbNdTqu8QKgfiaKkJkskRTOyDN
	4kmcG6j57JY/NATFBEoPjOD8HOe0GhZsrIgE=
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr98385031cf.6.1783352103958;
        Mon, 06 Jul 2026 08:35:03 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr98384441cf.6.1783352103372;
        Mon, 06 Jul 2026 08:35:03 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054fe7sm772422566b.10.2026.07.06.08.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:35:02 -0700 (PDT)
Message-ID: <8b30a278-3a53-4f0b-93bc-ee1822430b51@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NyBTYWx0ZWRfXxKKIkxQBkmW3
 zw8auhIG4+GFmoZt28eo/M7Lmj0gJsADcN4w3qnzi6PkrLEX4i2RS/+JMl0MHERfJ52t5hvU/2Y
 PceneDJzO25Pq41Ie93F1EDonlyK12upTgL9rOaAbt6uhfCRL1WElth8Pidos+2X7YiwaTiiAZN
 oT5zYJetdSTAunqtw/cB/tBQO7T9tBeaAIpXFo+62akAxrekoOIKDWITHQ9FUCHWNSW3AnUQrsF
 9qxqKuhXmwjtMUWmX/li5mgm39UEhkrkPaFz35pT9b6eYJEMN0MwdxfLt6NG1ri6IVZECtNj495
 +tYt8Asl+ugKHXojRorFDL24F07yWMyOLBW448yqzf0LjmfFBCer7GEPiqKzLL6ce2MnutA0uOg
 V5zyM/utmWjLuYkLV9qpbs5e2pGhOmHRDZmSBaZTQv9hTnKx2PTAQPW1JsS+LpuB+SQj884fVR4
 gNwDgQt03feMh+GQPwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NyBTYWx0ZWRfX/nWqFEir/qXc
 l/JmIFp+KkM8a658mS+qZPUf+8ElPMKyoJMW4IM6+iKiwJWfphFyCtvKEeSQeJlw3fT8e9CRFa4
 lisTzHPRn4/nPXGUtcWhNzqPUNYI6d0=
X-Proofpoint-GUID: AqseW5y9qOpGVEEXdx6u_njEorqNiNkM
X-Proofpoint-ORIG-GUID: AqseW5y9qOpGVEEXdx6u_njEorqNiNkM
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bcb28 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=wRhyhPH_MPSplg4SnB4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060157

On 7/6/26 1:08 PM, Praveen Talari wrote:
> The GENI SPI driver reports various transfer failures such as command
> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
> interrupt conditions. However, diagnosing the root cause of these
> failures is difficult as the hardware state is not captured when the
> error occurs.
> 
> Add trace_geni_se_regs() calls at critical SPI error handling paths to
> automatically capture GENI serial engine debug registers when failures
> are detected. This includes:
> 
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - DMA transaction failures and pending residue conditions
> - Unexpected interrupt error status
> - Premature transfer completion with pending TX/RX data
> 
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of SPI transfer issues without affecting normal operation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 26e723cfea61..7db0836308c2 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -3,6 +3,7 @@
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/qcom_geni_spi.h>
> +#include <trace/events/qcom_geni_se.h>

nit: this could be sorted alphabetically (Mark, could you fix
it up while applying?)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
