Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975F246BD5
	for <linux-spi@vger.kernel.org>; Sat,  9 May 2026 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292457; cv=none; b=tjAogITMvi+08obliKbCF5O3TJVOA2TjwV1Apf6qOeAZmEGMAo4G/cMEdnLpmqy2PrwSWpLKdBeE3ct1dBBL7bUIj5UJd8hEwOc1UzzR2f+9BPXgINsZqDb4wpP/sA9GuCJ2NUVYYO6wSLHzNPQ0uGdaEOLGJcwHJh3WcP0Pbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292457; c=relaxed/simple;
	bh=vgoYs9FgAhNvftMNEGkFZ6djxM7Y6gvQAHBMehPn9xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpEw25rcE4X67GB+mLuXHJsobs02b7NF78AZvcfCr2d6mAPcqQ3jXmHhxPetqm0vi9OoexZnlwcw2N9JCX5+/GyoSic64VdWqBk6qvJECZMbjuIoctGnnR/YQBpB5vaioFq7A2ty74HWRQRHkgheOhR/EY/Rgr0z1jCT1Qx9zWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFOKjPdm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQmKl9V7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFOKjPdm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQmKl9V7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648G4D8e1093668
	for <linux-spi@vger.kernel.org>; Sat, 9 May 2026 02:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+tsgJNeDYkNZrYgCDAEeXbbQuL9/T2evJy23yZXRYcM=; b=gFOKjPdmajjyCkjW
	7XwMBvhwzDTvWJNRv1qbmJXf/rjJDiXWV4VGxuiFtPLUkYdc38DXUcqcMl586K74
	aZITjCs5RdpWlDaX8EBOCEddqLoBSmceoEmaTXDvLlrafKmuxBe6Fca8yfwyr7vB
	01OKQksRnXk3ahgasrraK17qFhKpbAmGIF8S4g30ZPqpuILZwNqv3GHfFQUbVJeI
	OrBXV69uTTyxz2ynnz0z31C/iblLZ8SdJO38d6L92g3mVdysUd3CgsTAYf4MHclK
	DJqHVZfwkVw0zfXf+i/i+AdVoGCifWybaXMreqAdJAyLrj1apDIZcwTAAiYwJ4zQ
	JHrx3A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1k1d1n01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 09 May 2026 02:07:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f525565b33so3448817eec.0
        for <linux-spi@vger.kernel.org>; Fri, 08 May 2026 19:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778292453; x=1778897253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tsgJNeDYkNZrYgCDAEeXbbQuL9/T2evJy23yZXRYcM=;
        b=hQmKl9V7IDShnkKMbP1cMBtbyjio93RR//dK+g+nfYvhzwqGqVVhska7krt1BuzBBb
         zNbaFU/YDY19mAOCTGYH+ct+MbJIi+mIkhWSxxFQpZFUgWyzMqZKMc3VxsjjlxgGLYvk
         ioYxy7Rb5sMXbrfFz9DUNDPwCqigGHt/LOPSRlQg1te7Ts0CgJh+dtgpfEIfIpqYftmE
         G9MiNlNuiNC+tGtJKztObmyZM4C6Fcjq+jO6BYXWJ9PKZxuTXhV5hDYwqBM+gmZPYlix
         ztsgi4AUKpPEE6ksjl3Q3aKtEp6Nl/mepTd6W4dGzK1MXf0R/FylOY5Cm4I7OVcDPpEm
         mW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292453; x=1778897253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tsgJNeDYkNZrYgCDAEeXbbQuL9/T2evJy23yZXRYcM=;
        b=ssVPL1j3EdFqwYQSYMDUxR7/R/E8hRWdhdw1SBFFA5y3GS8rvSbmPPy8TV8gD5fwhU
         6VjTLfdbdbK4a9lAS5N+n7XA8NjuWioz1DvucLoKwsDwPwXSY5QAhbNrU8Wqe1lar5AT
         rKS/P17AvCQBnvYk43Je1anxBpgV2ICLxd/3RBdfLvNiJBAyRO1jaqpo8LVQWWByhGmI
         cU6y/0YhDw2zoKZkq4XCURACN6RA3og/zSR4zdOR8iDm9p5YZuvsWaU0wUH2dSqsHpS6
         fj54rnX5+tmOaH5FNOBtOnz85f3/aZRqvc1cl2RRX5a9nwJI6FHl6nRy2THsVzulQiYf
         2EUA==
X-Forwarded-Encrypted: i=1; AFNElJ8f17qHSV95g5r/d/zSuE0IXYaDT8MKRA5l+XmNSSbaTO6adoerCD7qa/imD9x3hAarxe9d1RHMIeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33ZN5wN1BiJLtcPTo1UPvPHKy1Kb+ARFNxmdqLSShGf6Mb+tD
	tgWdx+066hLTmZ236JPtTBvQAkum5bFVDJJI8dl0dI8t+mul8YCpk7odeVbwnyp1tZr+GUY53nP
	KP80oqE/PeSJy6lR0RJmg/iaC3cgoqC0uaabgUVwO740UvEU6AI0aE/nIuvFBvEc=
X-Gm-Gg: Acq92OGtGOKIWt3LPIQqL2KR5XS/Gadvp09T6ensjyAtg2pptdxjHZIOEi/jlUz2bwN
	z/PIRo8N5vWH8cnIzNp98xueiuEXV9L/EwfPYwV24k+iK47CYrc2HjRaiJOJXNHSeFqsZReVCTO
	G4geIJClRN/eu8WH32aTC56UgDf/SQdbitfAzAOh92LoOkZnt2Fv8CFiNVK5FPmVyxqlDpjSN11
	oM9/Y0pYHHjuflSIFaWVHSeg5qf1S6WG/jkawuUsNmjl+vZ75QvDvIR/STCuSRcSYrYuhv58LBB
	QHJf4+HhJqTfvgZfPGSm2X74qkuOLnBnRUi/SiZ6yw/74YyY5lSgATB1YsZLJg4cob1ytieqsF/
	eEFx5bWLlYnadWecoJlDjLtPrLLm+9UFoVS8RKaruu9tkN4b/54b33w==
X-Received: by 2002:a05:7300:cc0e:b0:2f5:285c:4374 with SMTP id 5a478bee46e88-2f55114357bmr7224675eec.35.1778292453018;
        Fri, 08 May 2026 19:07:33 -0700 (PDT)
X-Received: by 2002:a05:7300:cc0e:b0:2f5:285c:4374 with SMTP id 5a478bee46e88-2f55114357bmr7224652eec.35.1778292452295;
        Fri, 08 May 2026 19:07:32 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eb034sm4717498eec.5.2026.05.08.19.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 19:07:31 -0700 (PDT)
Message-ID: <4d90b061-95ab-40d4-83d2-13425e992d4d@oss.qualcomm.com>
Date: Sat, 9 May 2026 07:37:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
 <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
 <afxJmZ9MkP5eJkQC@sirena.co.uk>
 <59e36f20-891d-4a58-8cc4-6822d03daa23@oss.qualcomm.com>
 <af3spostNgoRU0Vv@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <af3spostNgoRU0Vv@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyMCBTYWx0ZWRfX2eO30syVA64R
 IYBDGSc1OjZeBIGLz+HOGIB0YFhxlAZmvtSh8TjSjaWQfoIja+aMzB48WLVSY9XBpHR/7SyXF5j
 DlkJeICiYq6N00UhxJWTkuqNSxXhYp5lDVD5Y6zTytaj+gPjUxpLXgbX2v+X0vIYbepflpLgTNt
 SlxN26BLGVmPBVrrevoh3MriYo/7KrfTXvYnvQaZRbtV7+On1V7E+GzewHmMeyYmSjYazGORH/p
 RUutzo2VqYL1gP09I8yHZcbQNjbCgAoFoT7EAxjanXdGEXyqYZS5C9fKUe5vpXjXPxrOyci8thv
 SbIVqnT8v+weauhp8BYV4yTpxVEicE8Ct9sS7Kf3OO2rj7ghS1nq/WLt6eVJlsjR5CesixMUUKo
 aIwtz0b+9+kkzKoj8xLzmB8Cv85Wulr4venKUMAiNVRhHWaaE9mo8w5ZEZqljkI/Vwmfg+P6v/p
 1zGOs4l0jESve+R4ILQ==
X-Authority-Analysis: v=2.4 cv=GLU41ONK c=1 sm=1 tr=0 ts=69fe96e6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=HwLHRb6XIJqLuLjHUzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: wnoTnP6YrJdacMImvw7Xw8QAbZ5hWwHm
X-Proofpoint-GUID: wnoTnP6YrJdacMImvw7Xw8QAbZ5hWwHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090020


On 08-05-2026 19:31, Mark Brown wrote:
> On Thu, May 07, 2026 at 11:03:39PM +0530, Praveen Talari wrote:
>> On 07-05-2026 13:43, Mark Brown wrote:
>>> By generic I mean this should not be driver specific at all.
>> I hope these changes are fine. Please let me know if you have any concerns
>> or feedback.
> The data tracepoints look plausible but I would expect them to be
> generated by the core, they'll be there for everything so I'd expect

Thank you for the clarification. I now understand your point clearly.

Could you also please review the changes made in spi.c ?
I would appreciate any feedback or suggestions you may have.


diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 91dd831d2d3b..f0d3665412fe 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1658,6 +1658,11 @@ static int spi_transfer_one_message(struct 
spi_controller *ctlr,

                 trace_spi_transfer_stop(msg, xfer);

+               if (spi_valid_txbuf(msg, xfer))
+                       trace_spi_tx_data(msg->spi, xfer->tx_buf, 
xfer->len);
+               if (spi_valid_rxbuf(msg, xfer))
+                       trace_spi_rx_data(msg->spi, xfer->rx_buf, 
xfer->len);
+
                 if (msg->status != -EINPROGRESS)

                         goto out;


Thanks,

Praveen Talari

> them to work for everything.
