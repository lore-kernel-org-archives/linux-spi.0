Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B004480340
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188389; cv=none; b=srf/Q1lotpw5E7BIRgBTt8PuP5yDqzpBEd2EWuOyZMy/PHTF1YJLcqzyzzX7d2Gk3UG93V5p0abgg+mu1ELG8nP0Zgwu+oBfTTNgNFFPVIGyRDVvbp7Y97lu8ufCUgSLYvtPd2J/0U7c5T5TFHa5N2rX7+PHIDIYnl6f1JvY/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188389; c=relaxed/simple;
	bh=pYndXf2KAGQT4uraSK0I2EebaLVY2dqZbM0fqBUTB/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXqVAHyVmKQQGdz82tHxruuA0adwJ6/UKGjXbURJgxWRY11jxpVu7NvbpC/rT0kvIiEArFIht07QydDKiCAG/JT6eP6ObBBBsj3S409OpywmgF7AHxGvXYMsP1R9tv6LNHTIzY13w+SbixyZYXSbr9KHEYSdtYbo10fR3YQdfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgN5964V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PAq7OFpX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgN5964V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAq7OFpX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6grZh1737228
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=; b=MgN5964VrMlkwu3o
	mQtLMtF/QdtufHM6bYJkRQObsPCzDl7u3ojwpJjlvhUEXypr9U2hhuJq8KmZzJHR
	AcBxzUv4uSiMG0WDrMnnzsg39z5rIUrdwD4AiLReR7w0qIDwyFjM2yk+bcO26U5S
	c16gDYYKTIMZUsL/XcYGRgaGxO6T51QXQP2+sPrxEff30dy5lXhdPhI6/uZBkwI7
	72D1AnZyFBw//yg13cXLjivUUrhRN3u1V9IiuBhQXpeYk8AdfYgcNKOEzMKTDnmd
	x7CcY8YY+I3qLiSVBXUzouZXkD8zu5FDJPw2D7DAYj25LjePCf6miUffdayib3wW
	razlOQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju912qj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:59:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so3043635a91.3
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779188384; x=1779793184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=;
        b=PAq7OFpXZ9X8D2eOnmixVo8tw6Gjm1vIA6lAcfRxYsk1UHrj2qNySplQooy2xWKXJY
         5HgjExk3AdU1J5DnVz9DUs/K6dsB93e4fqtemo3VYQ9DS6ZsroUNaQq+AtnzaCIDdkK4
         OLVdLmomVDUR1ytTdQOsYBRa7E9Jdt8dWC94XJ/WDgSFVetGwC54+56nbVV7DIV19XGm
         unwVXOKgie2xwYT/Aj8oSYc7TWOdTmgHmwYtByHZ8ciIFXj2LSFdgGO2Ry3pqpmRr/xq
         olf58xcX77U48niwXLaNM5ZszJdIzmacNaWdYWjxq2A/61jtWLHOtXGdy0NMzZOu4RrQ
         Yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188384; x=1779793184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=;
        b=jPqCbCstpml9Mq/d1stDqo5cTktqKE3VtPJC4Hz7iT8BtXB0AYHYebow2W0E5Q1uyV
         PmghKoUjj2ZDxw64BIQUySeOfcfEI2pcdEq2vW56Q+Yi8sQJjVGqOZIs2GOCOT76gk5E
         8DrQBuEbi2DTtg30gKQ8Qhk9beSOhql/IjdQRuYv0VLaBiCKo9zEaMnxIapcPxVfgcac
         iCh+QR3fbul9JejAM3oPbZhfkI1yXDTD66JlRHXGHqra3xIcB0udJyUtXQaSfseRlWBU
         XK8KDa692Rd/MvSPW2VuxLbqfDv7VJXIoIMdUOiC/3+7kXp6OpQJiYQsK9/9mHTJkr7v
         kN5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+M2I7Gp+r0ZLUkiAAqVLg+wqJa6Xgzcu0oAPbWp9gmgLMitsGn65ys6eeThLpkTywJHK3PYyheesY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivQMx5YA5mm8Nn2snvn/2mbY35z0OdUAS3Kwv1zPWZk5VUJB9
	AjJ2i9EE+URW0HPyhfB2JrVVyWR0qqoHF4UVw3xhK4ZkHxkQdjY/XL7lO5r3Bf7Y5l7zUWI4UkM
	29QgEn7RzF7IYGGh6jbBSxdhqeoICCOGy3cHF/TTYjqonrSa6OejAVCe0fynRvcE=
X-Gm-Gg: Acq92OG6IYFfHXkPIoo2Hn1WhIXIke09287zOWHmVI0NbczRYrVKtut6L6ye1kSnS8M
	E5UKBFA7eSXwc5lqspoE/aw8RuhrInnQ4BEZQev5vzv9P6MCco3JaYqb3xqCLFW45/oQifd/sNo
	N1CSDFhjdagwyHlD+ieZf8tG8TKxyNLSJGal7o2w9snXzvKTAWcIWdWF4VfsMnmBToDNDsqgyKB
	Cm9PxrM+XH+yl+ZKT/t6yAbmjC/TK67Hb/uaUInCLZ0TzJz8rTKM4E1r3mN+jtsZkaA7zrcjDzK
	X3MkQMkSmM/k1UyiPPtM3EOZ/ajKAPSMT2V+80tJadnCKN4pMazCfUQYeoaXrRfAECEqiXfn1Uy
	+hYN+Qlzovz4hlGgVja732CWD6J+wdNAHhPn6Cuhs7VKdpEvyWs51n4+VIX/DA2MFh7M=
X-Received: by 2002:a17:90b:1d84:b0:368:433:b697 with SMTP id 98e67ed59e1d1-36951ca51ecmr18877724a91.19.1779188384463;
        Tue, 19 May 2026 03:59:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1d84:b0:368:433:b697 with SMTP id 98e67ed59e1d1-36951ca51ecmr18877703a91.19.1779188383967;
        Tue, 19 May 2026 03:59:43 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369514361b6sm13809344a91.12.2026.05.19.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:59:43 -0700 (PDT)
Message-ID: <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:29:38 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KlldxlB1-LCRppc64UtOl21g9LVH0kMV
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c42a1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-fVOaADM36-ZU2ItTmYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOCBTYWx0ZWRfXxyMInGVm66vC
 g5/bZCeybuuT9o8m1oLuZa2vAiERKIfKFBoUvkoRlqJtg6AkSGN/qTAo9UTV7Zy3w1Q1UpbFIMR
 rQd4xpDM6mqHjV4b9yoDmAJrDv383P/+gyN19R7p169JlvkUTz/YrHwXxOd/6cDOPsGjlBh98a6
 u1n0p4VZl+DjFvElTXQ/RViE3nBtWkxVWDhZKIVOCRvPKTwa8+gzQpu6Dvyi45jBE5FbBAYavFy
 TJKCgh2ieWIMbtPqqyXiUGRls2s/29hCaoaIkip4/hsXBBUIZdxD5/bLoFhdlnM0NvVJp3nkxD3
 UPrrcqplRczHqeJ0gUvCc+z5jCweycyC5M3tlZwG+vxQCjDKvDXQ6rwfhxzXdEB2Xog6xQmQD87
 GQAJIzTR7/TW7tnxuc93IyhED66NqrQj/49DdVdloUONDJQiS6Hw+CfQJLEdmxi9DiNDhr59sM4
 3cu/7Ty0pk3einsKKzQ==
X-Proofpoint-ORIG-GUID: KlldxlB1-LCRppc64UtOl21g9LVH0kMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190108

Hi Praveen, one question below.

On 5/18/2026 10:30 PM, Praveen Talari wrote:
> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
> These trace events enable runtime debugging and performance analysis
> of SPI operations.
> 
> The trace events capture SPI clock configuration, setup parameters,
> transfer details, interrupt status.
Don't you need trace logs around PM operations ? ie. runtime and system PM ?
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]
