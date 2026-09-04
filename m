Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912DD3AAF78
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511793; cv=none; b=SBpF1SMhK8pcgmr479t5Yj/QSOlz6OmkVLKQ7VCWAUMs9rXAJ7u8QV0374xcMf42iH0KRRCAnmAIBQbwLmHP6iXmbw1UvfGEFlTYKN1/Py/WTbtIUHhYDt0IglagmbvmKZQ3A+s4lzODMtnuTlI7aYJOTySTEgdgMYAZC/o+rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511793; c=relaxed/simple;
	bh=i5WV/wG5Dqysz3kgPy8ahQVJUTCnfA7qqWTM0oCKVDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1pmQTNgOnUmhlSqpDlwZuDpr3q8eoqnJH0cUGkRTd6JK05xliaGHqQ8GzB05MPQKzjLhmSTnyd2Xt+ipa0NSwFbLKauwSv5lGLLGh+tt8e75Lks/Ml4sIRsm3eIzRP++FXOdQeprNu+qlH6mzLlExgmJBO3UF26BCT623EmgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L3rY66/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJC0pqY0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L3rY66/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJC0pqY0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mdKA3112630
	for <linux-spi@vger.kernel.org>; Fri, 4 Sep 2026 08:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=; b=L3rY66/ZPsUMtp1m
	yZ5+t8eehR1pILzku+yzJTRv9c8fPHtBIRhJAtktnQcepeykDJVJPP9dFR2egT22
	WMOXcRbe7Va+vtP5a2Tw5XvojiVIYPLjk+2ee/Q+6MSvITBw/WKAjdD3LvXvVF26
	LHt+lhPazQ0+TsN/VttyPFw27t8eLdEf22Tlki6wwUyZl3ujIeNXuPW7NsMR+17k
	RBztDGxY7tL+s/J3A3kCF348jxqh5vXyDwFaa4WQ+fHJXk80JFxJ/g66dtXvCviO
	mvoG7dfdtvdRnFPa8nMAyyN5Din8JuJqzFYNdbhOwTPy2doKvYdhxWwtaGTwxuOy
	WGtymA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp780xa9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 08:49:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9349ba88188so11643485a.2
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788511790; x=1789116590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=ZJC0pqY03lNzU1bS5U2QmJ43xCEZkGhJoFLhlCtmUuci2T5nrM5Syaim0tOEgEyL9y
         h5PgqpWtQH99ohsps2z4Dz7LISjT4Av18GH9g0LX8rMMQQ8dKtEOgWtUZOeRCDOW53jo
         8Gn73ejHn5YZUMspBhEzZHQUeO6+A+ltWCKwCdYtkZREvoZ3LXHuqzbvLUfAMKWKd1Rj
         HPG4TpV5P6Cn6pRsgIwDAJU8u/kCj2Dlf9z2jA2tMQ2bxNVewzIUYLjrEsY9u4v6f4/5
         WMKY3s1mlItWGdffdfNn6Whbui2hIT83V8fTfFcxh9QKcA5EHd12N/snvqzdA/CieXdi
         i/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511790; x=1789116590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j18BJPt/DvGT7g3N2UqsrZWAWZ06VMwJihvlhh2lFbc=;
        b=qMaE9+/xBN/ZGxyLKGnmOKFz1fMjmlvjnKLDAKOvprMLKJH5ooGVt65zTaoYo352JL
         2ksishE+1mPOo1lv081/P2IEmd2/vCzI91Zs5EggYJpOwBzXKH5THLp5aqjIS+ZVsO4q
         X8fieSlkPhp37wVlI34NYglzdp55HNQlAcCc9t6nMY3FTyTydpsUmoaBTmn7SETCr7sR
         nvoD4EE7BkHxHsVH1n8++67w25Fif517voaJpBpFjjrJ5wzI7U1oLi4gDgRaB6lQHjRD
         7m/bbDkSpPGW1Ab6vi7NlpI+yTnin8tyC3Bu0Q2PpxSLJDv/EtwKtfJiDEQkT8X1WAFa
         SINA==
X-Forwarded-Encrypted: i=1; AKwUvBz0znGYaaUCuZ5KKLMdITkIXixZgsMD5BNbTGPVG/UfS6/SJNtM5HyM5QUWb3FVP5kLNHZdalVIwJo=@vger.kernel.org
X-Gm-Message-State: AFuF++knJrLzOQ7xuGTcRnbCbsnDhSoo3IW6kHypacGi5SMnpgHEQPug
	cLwSvuv10tX/x5KhzIRq0nAY/N2+8nlSP4LSaCaJz6oyLVhqjnL2DKZ8zcc0wc5fc3yI0gg+Ha7
	HGzGUYwbn6ZwEOoQzS07n5c19wFRgHfwMTGU6D06eYI8L1OC3fkvx1kAJXO9VqwI=
X-Gm-Gg: AYBFou1oLAiywA5ajHWlFktfxDSd+iSzKxzFTXmdLOSfMTiXaNAh4NW1bk5ODtkc5EL
	IMO6kllFlop/T5/tcfDCDPlKxjqc9ZObx05CRKe/VfVQk3wFfxQl00bx/CIXlLs7Y+WkDIp2Luv
	BgTMpuxgHcnpWZ81ocVnP2ACKiRHXHcy7tiyj6UIH644kcLh3Eao5vpzlHJFUr9SYGBJwHFJE+o
	64gu6WIPvkaOjPkrSLfeL0syAjneGQH8DdqaIZ3oU8T0Xod/ZIuOlsVac96ezK8fNYc/6OQhNV1
	DhwL+GohPXbosT6cLBpkzCnYy6G2ic7isTgSgGddr9F0EElAALaco39KQ00K4C9sQujC5Xis29f
	r1UHJqGMzkA00odNVlvqJIg==
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146197085a.6.1788511789707;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:939:85aa:dfdb with SMTP id af79cd13be357-93985aae0c5mr146194685a.6.1788511789302;
        Fri, 04 Sep 2026 01:49:49 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68a6a1dsm867795a12.7.2026.09.04.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:49:47 -0700 (PDT)
Message-ID: <813aae42-22bf-4029-8f04-54fc555a2a1c@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 10:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
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
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfX/RnZLx/sruIk
 NHNKihazIC9oNkx/G1/Il+xehFPhyzpW7y5yNJWdzKJLSQTG79XU7kMKyW00xh5biyIV4sUdjIh
 dXGx+ians7Odg85L0RfiTsVSZps+HP8=
X-Proofpoint-ORIG-GUID: OVNnE8SQ7z8uJW4FbI4EpWyaLQ5Ls_8I
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9a862e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: OVNnE8SQ7z8uJW4FbI4EpWyaLQ5Ls_8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MCBTYWx0ZWRfXwV7phIUU9N1x
 oLIwaUpZqC6ygiDffbmFnfUxztnomw9M/mvqr87IX7fvrk7YFC2i2ZD6VB92w16w+Vlc8+BFeIG
 LZLs1O/9K+CvxO2YLEoiKLbNC0eMl//b1ZL5tvlTsxLJaKXZEET7EdfDWGx1G4eKvtjMvJqYu53
 bDptr26ldy+pl3HJmEbL4A6XuDSnzL3ujmdnddYuFaGFWGyYMSO9ZYyEvlv937ak+NoG+d9yCxI
 leNY8CqQnoPtqGnRqAnFF/9yQoAIhfYAWl3sjSe0NWLNnRwgmaJay+rKA+MLP21cKwKRE2vhWwJ
 7Zy3gpdYSlYthOCQtYFin4c2dXZ6vX00iV1VRPA9qvgWNwmB9gqt0zE0iiW5o1gclyr7bz1orIX
 vtYuFEF75U1rRA0ujLqruOJswZRekKgSIMvvJNUFlmGHWdUs/5puC4a3qAsvEjIW1vlGXpEEN5r
 nk/r9LStlGv8nesZnBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040080

On 8/27/26 7:59 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.

I believe the opposite was the original intent behind creating
these helpers..

> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.

That is, on the other hand, a valid reason

Konrad
