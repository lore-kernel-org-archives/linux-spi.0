Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDC35E94F
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646181; cv=none; b=I20WzVJOOcn2hNPIQPXiWiotmIBSOV81ksS/aOGRlYwetJnwSlHb5VGGipL+IHY1yLLwR55eD2Ztxp2iwzPkpVL6Ze1tHgueCaQzEUjmNYsDP1Xush8h3njHybA9OQFmcuZtT0E6dErpg/zbJPvvDeo7lH3pbOdw1GJDm8Crr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646181; c=relaxed/simple;
	bh=3k4yRXSRua7NYMqAmmhy33cZ3AnCSJOK1rbJA9IReO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M04STdcUGtXzMjjcJeNnQwFHpRyuYVu5nSFloVWYKyplGPK2Npufwak3oz1BI1Ro0IvqtCYo12u+3sYHF9nc1sCDFJMPoBjus5tyhmYJbkS6cGBXOs8pSa7uQRDt3xPuwlvHtPexSIC++ABDlhEaCCYAw3jXuA5rW+92O+GevRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJObNxZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJdnFqM3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJObNxZo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJdnFqM3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P895vx878114
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ywz9kH7gTln627j++0eOYkrz
	Mzb6+AiHqb1QNVbCm78=; b=cJObNxZoa+HbrFvBFQ1ru1TxDdBS/19QcmdXzbsS
	JezWSTJ/JX6BEnSx3McaDZcdeRb8zxcJzt9OBCsmpJ5TbONQYMbmEoQXrw64sQKf
	+knun4kxmL+UuXAoIeVu2eeJdoDwUxzlTFYHo5k8TCUSyPXow1jnxrU1VAZ8b0Ck
	3y9kD7g9xKnIqG9hMv9IkhKaTlNAipvMBpAHTYzMTRN81ghQAbFEpV91PvrV8tWc
	b1aWJoSxXSMbwAQEArCCERwR63DVMQeE1thTJO9Qc7WQ38z/vr45Z9pmttd65BWE
	sHIopSczy/pbsFYxJVJUHaCWDWBE28+IsSynzfO7mzXeBQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8rqukcgk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:22:58 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97caca2faacso102269241.2
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646178; x=1788250978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=XJdnFqM3O/XlABx3vN+uuDqSsk1T1XlnK4ciR7rzuNx/cimJeHM+oKlkGzO00d2LkC
         4oIhSDcfvwWRqsEoZHVxZGIecgEL+9Q9oD1NFiC88KY8o7j8CQ8TwvKecTJuLxt3KbRa
         aROB+QLibMF8BFUikX9UhJhvHHpe8o2ETS3VYIwmo3raI004dokWjbzhoU8A8X8tqjFb
         GeGDtJOu0c+Bw8UYGThoLhEyOr2aYdr1okVxFGJl3kM1SRVlAhZgychQ46WyZtbWECDX
         W4ZhaD/an2jIozTcjFTIgM5ELs9cxB5LW0SsT34c0KZ8B+yGZ0CIOaYnBnq621Ahw0UO
         Ji1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646178; x=1788250978;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=tTy6jHruEGalh5iD3JE5b3ixxx2s3yEq+b/jAxc8X4B9JNylhGHO4JAaPWSsm82j3/
         iHql7mWLcxiPDqKgqmyO9lQftzy4KEyqZZuPLq+4cYpuPXBRx0ML2FqCp7SMUBIAVt8u
         gPOpPpeXnXIu+trN5x1iAx2qyuGwdYfZw4NWTPZrMZn2bwRNfKduElM1hTWj6VBLKQcl
         DynQaGXRBNqFr656Qg+qXHJ/8Y9Dgq+ZQi3mrNogbst/BjttxAAIYHZXWrer6Bdg8+9e
         4ZhKrgrs4mKblNKXyH7a5zD0Hgn7pBp3gVTuFat+QExLtBOSpowxWmuHUWDRyB2kRBx/
         eatg==
X-Forwarded-Encrypted: i=1; AHgh+RoKHE5eZQM048anxm71tTK9wL0C7ZP7dJlC0GVYdtIBd+3DvxFemco8YDJl4+5xUZWHJ2c0Zw/26YY=@vger.kernel.org
X-Gm-Message-State: AFuF++nQC0r3X/NweKiki8CrwJukrj+BXgUP+Nzzt4pMz5vx4+HYWBO6
	aekg/IyztIJZ6hj4I9ouon4MZ18qUbL1AwB8wlpGsfbtRoE9QhciYVT1lv6cRWDxaTbqv/I4QDI
	USY/s01dzrwFFdo2PiWH5EppQNay7UJI4GA6pRu/1Oztc6XclCpoWDr1P3phtLhQ=
X-Gm-Gg: AR+sD132JKwt2JVo6x17hjEtgnGkSWpRGkrPzQ7OZTJw+WqnSj/k2CqRSK+67/T40ys
	NS1PojAMNDbQCl78jPaGaGM7V+5NkgikwsY8uDiZR+Nzy6vyWrfEdrcTjSnKP91UpJ6doengV6h
	mNAErSiPyels3NczHek3O0yLu3+V84qIbnFvRK0EpdTVdrpgUgHvOk6JycAvWJuTrdX5MBJH7yg
	i6JJJvifGw5znvpgl6De/nh862UNzvIp37JhzYhyetgL4IKFQ25YkWMb2Rw/mugy4NiGE7vkTXI
	dPHeO4aZfIc8ufccCUPbo6wzQEtDAH0YH6BPorImNPZnHdm/RMXV/CianCZoaARhls6tZe4uyE9
	ubw5gFrNPl0151A==
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644162137.1.1787646177502;
        Tue, 25 Aug 2026 01:22:57 -0700 (PDT)
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644138137.1.1787646176998;
        Tue, 25 Aug 2026 01:22:56 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm14366325a12.29.2026.08.25.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:22:55 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:22:53 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Message-ID: <2ah2wpjrqixhnws6y33tlkuep3et36q6typfd7ausgaslykmrb@cn6usezfkae6>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4-8snou3r-XmiX9XCanSfQUIKeApal_a
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX8961Wo8dLJ2l
 RWwJKXcOGSrjUiKkKZ9udnyjMlPP323zy+ts72FqHkjiYSdms2UHSJ8kBBuqqgo0BArxpbvE6qO
 v2cGE2Exuv6g+nod3sCV2IKQcinBu3w=
X-Authority-Analysis: v=2.4 cv=CbQ4Irrl c=1 sm=1 tr=0 ts=6a8d50e2 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dS1doENrTls30Ym8nGUA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: 4-8snou3r-XmiX9XCanSfQUIKeApal_a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX12h6LoRDBbEG
 1mC4514PiGLIq90V+ElYSTjVshe6jq/d5WyLGa+49AlMloz4r3eG6EsvXJZhXKdp8IlXzZvX6wz
 B2CrWbem6ef39SsiyVrjuB86t8VsFtNwFtve1Lv9meiCBSMUlXFuUMFnJ6rJcBxqV174Mr7xG/4
 IyyqTgjfb90jlkItkUhK8/UJ43m1ID06ihrXsAGMxD+y+E3kdRugPTFG4M1IB6DYMhl04eqxL76
 3Lh5u2JPRsIR97mX8PMSq3mlkixbTzTZIZ5Ap0exkcgmQuNVXEE0Q0nqZ6lysPwPmZrG51nNYM9
 gG/HVk6K728avsw573JS/UPZVUyq33U2BBJWN4uqlc3pjakHKCZrtO5KzXOZgia/icpOGKXY/+h
 bIQ6CAy6IRPVRUlZR+4jjg/SNAeQb0GRcIK8XIwDgmVKbBZiBvVoHH2Six0lDZC9g3Dis1ZzZ70
 SINUFaVJIkYB+2LjSZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250070

On 26-08-05 01:27:39, Praveen Talari wrote:
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
> 
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
> 
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
