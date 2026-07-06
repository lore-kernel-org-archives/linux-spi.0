Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A90420886
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343070; cv=none; b=War9Njevm5nSKnHecg/tLaqC0ocFg0FxKHrmHlfbN7zQgi4iLrOvwEWfQxg0eM+BC2vU/e66ZRKFpo9iKT+8xMukk1SLWqCnG99k/30KX6NO1oAlfk9ir4wmcGDLh2lBxX/5sDJgDk9lyKflVwyDgV87TdgFgP8ZKoKPg02qt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343070; c=relaxed/simple;
	bh=9/7QPfKMTMI/CjWRhumszI3/aGbVFOoiMgVoaf9cHw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ol/knd52WZ47Tm0K4PZ40Xgni5QQHzZanpU7QHPeJeHpJ3IGYgsNCDP26jj5E8uKzSy0h5hty0wYwT5O02l18J1yU9YHKQKlVHJcco8tKCcIlgtYZsLrtfL42izaNgMHAbREAz2IewwoUOdVdaMEXl4TNqtzYlstNF2TilEWirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JapYqo/b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QXWY6x+c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JapYqo/b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QXWY6x+c"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxD1V395287
	for <linux-spi@vger.kernel.org>; Mon, 6 Jul 2026 13:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pWsnU3ydAXBOIOITNJSSKAM8BpjQAyuQui8bRCBB0A8=; b=JapYqo/b3DOlXT5l
	YMkVOG5SkD+soPzoW2SxJcmivNrwV0JagYLz/i1Yzga4SuyiMddZ9BOzp9AY3VUC
	ZB+ETwaWTBYE6NkT8O6hB3MrGqkwoUBLOLV3OCVJvHIMk1sMG7WbYFJk4EiEDVMK
	A6oAebTAZ9ge/1H5uZTGMSAVfn5v1ItcScKJByUgdfAfZ5qsG6M0NjQbef4hLPlT
	JRh/wZ1lUSLTwa19my23fMtBUNR9r/eJrT7V+Q8J63mMlQIPc6TtTOmCh/ovCzRu
	21f9oUxvn8bpiG4mzCmDG9+Wf1njfa2eNPEuWfVhcHV8EBH/M/igw9ujOvGR0pl7
	y9GzUA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpgt6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 13:04:28 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7eb4f51ba95so141050a34.3
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2026 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783343068; x=1783947868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWsnU3ydAXBOIOITNJSSKAM8BpjQAyuQui8bRCBB0A8=;
        b=QXWY6x+cx2dKGLfJxcCMYyeYgLCK4kvzLzPIr5N53epyzrjAFmAhBsXd4ykBgDewub
         lezYuUVXl4k4CjF+ORKxtn6X5ECF77Kr+MXaOE5hRMjERRILo6N7zf/RCZ+Zw8eLrk46
         xXddJyOeEnr5DLC4qi1m4Lt+biwjFyK/K2B5TjmXJP4qE8JOyvenTiFacgMSmjWUSxJj
         CVvGqNwEAkkGSXFnausahXeKcVbosgIAxIqvS6co8XtKR/kvTlcYeYSDgdAgpusBzW4I
         mTWXT1k6TZ1T7BcQYXz2YDv6u+ES+6n+zj+QoeSV/yGhvQFMYMmvU/9PSdrD7gT3u7yt
         cOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343068; x=1783947868;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWsnU3ydAXBOIOITNJSSKAM8BpjQAyuQui8bRCBB0A8=;
        b=Uy1DTmOdLDbSDEedowVN4te7CHAMmC+4X1dWhI+moEjPRs/1nf7Rva9CaJdki7SkLD
         Ulhscs/U/k+5qMcP0O+bG1vR1lTrA905KknZr7U2R26p25oq4WZ1ksWU1ky5D/QTsvOa
         DKp1s+T3Db8BcPZFIn2+7ZyGoykCJ9te7Oxag8H33syFLzN6gtUMK+iIEBySF5mdmWdg
         BdLBsnIcSJ4pyMSEvgHJqjQ2UZLkcYvqCa4cltqGGwVMqEwifC6sbARJoiWRcHQgae41
         6pSghFRE6SyooOmGo5tgvVtN4nD+YQnrDSq8145Z444BHSVEXIowgxKBXfWEu9gWlus9
         D9Hw==
X-Gm-Message-State: AOJu0Yyf3fDXZ0ZQjNXWZpLQ/eMnnR5MEdKUW04PLXLSJtpbN8Z1xf+5
	h0sNcbBRXh/u96xW3g229fmhPuV3yqHPrppXKvWtCOObIufFlG7ezfqvUR2L7VVBbHiBLsbM+23
	yKQXKqKszgVN9gGkOHw2NJaHUmXHNfMAXHsxC07OvoHkgSOioBO72z9gnYIlaFls=
X-Gm-Gg: AfdE7cnZjTZlUBHVHM2asqwtJXwBUp3/twbCT4YzViOBGC5a1NwF+htpQ2iiCyXKXzg
	hbXfkssc8bhsKcO7YeyPoOyFEKW2ocN2YDS4PUznFg0WySQgWDagNj3F5r+6cnlhOX7+M7w8I54
	XmdS8G7QMEwUZoGbWglck+BwsYvqSM265AkmCYNYqN/hcsYVriz/Xy20IEVgs1gtDi02T2zq1YT
	wuRPFhqOWB5C3eX6UGip2oUvQdnYQeRvVEr83sNUDVn7bxnrV77jJSlHf6Q+5w1N7WHK3Q029Fj
	moZtBVRzGvWuHm5V6jNNNdShkTkP/l0oDpHi1B4YbA1F+jEOfuih5dXggyVnic5XCNw0u5psJdO
	EKXoYQRl/4bvYDDeZ7ZgiC/xLGZQBzskOfsc=
X-Received: by 2002:a05:6830:348d:b0:7e9:e1ca:5316 with SMTP id 46e09a7af769-7eb7f1933cfmr4339229a34.0.1783343067629;
        Mon, 06 Jul 2026 06:04:27 -0700 (PDT)
X-Received: by 2002:a05:6830:348d:b0:7e9:e1ca:5316 with SMTP id 46e09a7af769-7eb7f1933cfmr4339199a34.0.1783343067095;
        Mon, 06 Jul 2026 06:04:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbef44sm4216078a12.31.2026.07.06.06.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 06:04:26 -0700 (PDT)
Message-ID: <b5b46eaa-a579-43c0-9e8a-31dba0481a60@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan
 <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
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
        driver-core@lists.linux.dev
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4ba7dc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=p3Hybbcu0AkdvJTjDJUA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: 0MIKQSBgouyIueLTSy2fozamF6Ce00ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMyBTYWx0ZWRfX6HETMYbPGTbX
 B3LEXV6k3c8RKTkeY1FKrUs7+EBpfY0j34ZAT0wlcDIpVzsyFLRKAWiwr3Y0JnTlr5NExAeWfd4
 DkO9m4fiTUlHajqMeLaAkNomgnzbrkOTmBZdC3CpXFX7Z7B6eTLZJTiCge/j/avaTdG/9sTvPQB
 ZX3pNmBLOF4aDLo5Oj9IU9fExgDdCR3tL5ELBhKSLUayb8UUIomEGm0VEprtNTCrm85qFn0AEuz
 +oApjnMT+xXJfLIEImd7TL+kDkzRu0lYM+QzHCgoZvhT+H7xpx6egdvg9t41WxrJtTW5dHWHU7t
 q/pYBlczQW8/9yQYMzIFfsg7PyjVYbqFdNQ2LKO38mQW/oa6URHyXz56W1YNUklET5oTDa2x4tJ
 9Irs/T8h1kRpk7b8TXMtYpHRyndDd5/WbEh+h5LqPoBvGgsmp06Vo/y/WSBSLIMSnjUAyEY3Axd
 ZLh0dNt0FGzS6g6M5FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMyBTYWx0ZWRfXzD2tBST7jKHi
 DUDDIyLfjdFjKY8OAk9aRC82p5LT/P3qw1aed/yrDn+txdUZanq+bP/Ej7peXPU43KMwbF9rN+L
 tKoWTdYKUPoQE0X0o67kM/7SV6+/j5Q=
X-Proofpoint-GUID: 0MIKQSBgouyIueLTSy2fozamF6Ce00ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060133

On 7/6/26 10:53 AM, Praveen Talari wrote:
> spi_geni_init() calls pm_runtime_get_sync() to power up the device
> before accessing hardware registers, but never checks the return value.
> If the runtime resume fails, the function silently proceeds to read and
> write hardware registers on a device that may not be powered up, leading
> to register access faults.
> 
> Fix this by replacing pm_runtime_get_sync() with the
> PM_RUNTIME_ACQUIRE_IF_ENABLED() macro and checking the result via
> PM_RUNTIME_ACQUIRE_ERR(), propagating any error back to the caller
> immediately before any hardware access occurs.
> 
> Since the macro handles its own cleanup on failure, the out_pm label and
> the corresponding pm_runtime_put() call are no longer needed. Replace
> all goto out_pm paths with direct return ret statements and remove the
> label entirely.
> 
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI based QUP")
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
