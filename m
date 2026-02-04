Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89545347BCA
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224544; cv=none; b=b+v4vVBV005v62NGd2Zs+0v15K1zG/p3yKXmG43DrdcjxhKI1MaYGwqscYMYHKTs4Wz3kSgDrDjPo7JuVbULancZCrWtfHwZJraeaT9fHtRBKU/3nJJvXPrrYs536TiJAnS4UNs5PWTvrkKlJ2RNJ3dPpc9QdgRQEmnO8sbYyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224544; c=relaxed/simple;
	bh=nnHZV7AAqXqUQe1d4STMvjxcVhLgLzrieyguTS3hyRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYPHbUBhbjqbzue7gAhQkUBxJtvkAyRcAQuQEqFqwcanvhWJ8JU9QWXZ5vu/iJ/vFuCnQc0jsSXeRBxDSHk2EEp4rXd1PwEMkYEXcifOPzs+ZguZQFFz091Ka35mPz4Rfd5DenprC+H/An0ZuGV54f/csQd+g2tjbTantY/7Dfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nVIWh3Td; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bvQ62GRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nVIWh3Td";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bvQ62GRa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIeKa2167677
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 17:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l7TtHj/lcyNRtk/zB9O7SKyf9AfO0zCvDPAlhMJjLD4=; b=nVIWh3TdH4xB2dME
	o7yG7ali2uxi1kbp8C7BSvguGE0KNKwxGm6+vHAbmNGvRyXFQ6hHW5LLd/xjaeiw
	fO+xiMThzB6PIe7TPRB4PClittPLJauPhkii4n6RUtMztWh0yHZN4yLhcdmMJX6k
	Zvw5+lIbsZaxiJxsxnLFfbL/K6e4/dj2b2i4Cqj7efbg/Tmj9xsjvpxjGAPxRzwr
	lJMnnWKuyln/Wj54dzdEAndlyMKbS1cKOQH/MwtxQFU5esDv7vOEnqHmPdGDiwTR
	X9Oj7Af8DhnsF85UQYcPyUMdto0JV6hByLcy+z0JArZDChEzmCbJvjfPEUXLq62g
	g3G+Wg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c45nvgynb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 17:02:23 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd4b12d78so8129a34.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 09:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770224543; x=1770829343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7TtHj/lcyNRtk/zB9O7SKyf9AfO0zCvDPAlhMJjLD4=;
        b=bvQ62GRaJ2cGTMBCt8FFGPy3Eyw9n7cCHa1HpYvHQzh2stPtG3q0SsK8Yn/Sk1fKVa
         MKfjh3PtOeuw+HZJ0QQ+2ovak3YRQJwmoP3TyBoCtz4AYuUrPpvwQfbPE9xD/dSgkIlT
         Io6ZnqtiN7nzzA+NWSNu2YKm1anmd87mm7ishz13sekjnQ9qjopZs7A9ZJJ5G82T+srI
         69QNozrjC9vPYT4J0YE3Fj79vsed7cnnDO7lVBcilZCh0Qw+Fam/30Jssx5ZjyunwHBS
         F/6cBsVNTXuw7UnL/+D095CafiyjHHRZ3+Pdsv3YhdHquI0dQkdOwDjunFSpUTaBG51p
         OIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770224543; x=1770829343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7TtHj/lcyNRtk/zB9O7SKyf9AfO0zCvDPAlhMJjLD4=;
        b=EFw1mArMUuduLutnIssAN+DFN9lwvobXrI4xiO2Xvs4NnjjkP9wSNzE0tnXjYFVMuo
         gFvPnJP4uQ4HPOEh4FwLw99OZReRKh20Bj7VvMXIeOYlZ0xj0HgdUyyCZEW5cGvmcpLe
         m0p69SINiUwvMnb0hMYQeGlCt5XxTf7BZdBPtNb2JVWnwTbXmpt7qU2Ny2ZPq3uLZkNe
         dZdLd5Odrv7wNLt+QEc+Xl/ldEYHEXV7u6glHcpz1Cxasg0I51Qrp/hu1Vgx4GMibkU9
         AHag0jq7/w2U5bCxy9piZRnFKgxDQ3GfLH4Se+25KmDZ5v4fqy12TpBVeO8YQ1FWk+FB
         rmFg==
X-Forwarded-Encrypted: i=1; AJvYcCXtObIgjx5xVl2Q8XT/3b1H7n4vi9coJVbcxOrfOoAWzXJSTatcwOAj/owEWFGnde+QOkDlOAqqddw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2DyicFNpH/AbVJDX65NgKdeHYGDmNyb5cspspMNqYJbKs8mj
	JbOfKPXcIHQqq4DP8JD4NBzDVz7tRUMso5fooSXn2jD9U1hB5Hj8O1h1GRrwM0eeUVIYRo2DSgM
	HWHE6PNt4cDaSW3LSmt0yOQpFaG2WO5LKj14gjIhEQdLQmUVyIIwDo1GcCpcOzx8=
X-Gm-Gg: AZuq6aJxgbOTYfL3nUB9zHz4QzOFRrMvZAWuBZbeyVBMrSyBIwtzaayJYeCS2dp64jt
	psq1KaHEkrQNXwCIYY9XRVlkL41SPFhqi+/uPozTxIErET8nC4RP8y0lbY1fDoLZZVkh4/nke9b
	J1i2ZhG78iXYxrhPMx/mwSpRfPHAsA76XXpSKqHHXoy1wgaR69ouPoWTSHiUX5ih1Bh3VabEfn7
	F+DoRvT2xs5lB47FMPW/7PF/to/9gx+iT7pppUR/+u0yBZcCmFzljUfhMYlFR0Dp8N+Eo91c8fo
	WzHxb4R0Ha3mrD1Ty9/OaxFudJf6iggpQo/MfVJR0B3q9lKfeQHBkfKQuKTpkRWQLY2lezCXTtv
	diwqzF/wa2vgp61Bopz6U/bJhOItE0RvlzLQ2jwe8D0S2P/SXe6xSOsBWYVfJqMExUuQ=
X-Received: by 2002:a05:6830:3153:b0:7cf:d9a3:12c9 with SMTP id 46e09a7af769-7d44906702dmr1774032a34.7.1770224541751;
        Wed, 04 Feb 2026 09:02:21 -0800 (PST)
X-Received: by 2002:a05:6830:3153:b0:7cf:d9a3:12c9 with SMTP id 46e09a7af769-7d44906702dmr1773924a34.7.1770224539871;
        Wed, 04 Feb 2026 09:02:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6594a228ed0sm1492639a12.29.2026.02.04.09.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 09:02:17 -0800 (PST)
Message-ID: <3ec4b87c-f967-41c0-805d-27c62093e990@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 18:02:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] spi: geni-qcom: Fix abort sequence execution for
 serial engine errors
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
 <20260204162854.1206323-3-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204162854.1206323-3-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyOSBTYWx0ZWRfXzCCA0fqezSYD
 WgkNkYd53yR/VKCceW4uk1VeNi1fO8sn5pve1a+qHc/pgQySEgHEorNNYU8z+BKyt8k3rHlO+EH
 OgPnUwEh5FaBt7kUZLpoLnjQFWbHtHcVz53XkGwLbZtK2uilYXMbKPqNb7rCyG7ElMnW9dTL2Yg
 unjxYRE6dp44r5GQv0lv/hITE6Wy5tLgtxiTAXP7c4jOgp+r0Pnwlm1ngDgHZgODbKkymEOLWZj
 IHzG8hdPujLzn7wVBaYdMiUkwTZELL77fMrZzX+3QELJNsYhINlQDDx4traZzv9QDZaZ3u7aUOO
 zTXolLZ7omYYhDbVaO8Uvoo0xenL3nJDWkBxkNgKZOZgrjY8zdr8wQ7T15iHnk5oKQ6r9gNZLyp
 OpxjGnPdRT7YDBr/ZdXuAcJC8VFdprEch/I83wxN8ftLZTK21TpcBWwquze2jXH/Xmv28mGv9CU
 n8y9fpRAJXOh4wcGlVg==
X-Authority-Analysis: v=2.4 cv=DLmCIiNb c=1 sm=1 tr=0 ts=69837b9f cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2ADkXApKhB2aXO0F1dwA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: L-7Mr8LkM4zpOvOgjTfVUu3Tsla526dJ
X-Proofpoint-ORIG-GUID: L-7Mr8LkM4zpOvOgjTfVUu3Tsla526dJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040129

On 2/4/26 5:28 PM, Praveen Talari wrote:
> The driver currently skips the abort sequence for target mode when serial
> engine errors occur. This leads to improper error recovery as the serial
> engine may remain in an undefined state without proper cleanup, potentially
> causing subsequent operations to fail or behave unpredictably.
> 
> Fix this by ensuring the abort sequence and DMA reset always execute during
> error recovery, as both are required for proper serial engine error
> handling.
> 
> Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Well I never left such a tag, but let's say I won't object too much..

(it potentially carries legal meaning)

it's fine not to leave any sort of attribution for small changes or
suggestions you receive during review, perhaps suggested-by if someone
says "oh btw could you please look into fixing x in xyz.c too"

for the code:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
