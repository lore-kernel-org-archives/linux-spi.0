Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9D329E6C
	for <linux-spi@vger.kernel.org>; Wed,  6 May 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050267; cv=none; b=JoJn5uJoe/VjfJtR9ZE/xOKa2/0LIziLfICpeQQV+PcNPK9igyKg32Ya7hyJySkrBziZZ+maQlGPMrW1MAd/PYQwrmZoUc0MVol29k0F58wF9w9HFGCAHqIGGTzN/9KAxk+322RK8miIXHDJk97six8vqC6a7LRlAudfctUOZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050267; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=r0IJ+Qsbc+1BCIAshdETglqx7IvJuEg+hZgK/l0TZjDv1ZfKbnJLWLtWWNXyTgoW9Pt4iNhjJYex3jeT5Km6c4ZndtQuz+HOnJzrhimD0+EW3gZiZceTWN5WeOp0Z40wHCi+Sgtxa1W+AiWSjlX4GFhq3nwhhQNinn5+4nWShs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UZVBXcjg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=agAhrd0P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UZVBXcjg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="agAhrd0P"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6466mcPJ912107
	for <linux-spi@vger.kernel.org>; Wed, 6 May 2026 06:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:to; s=qcppdkim1; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++L
	fAOrCAj6OvBfk=; b=UZVBXcjg+tVq1orlkTqtJGLsznuL2DmzlcNTQYe5OJQRQp
	kmk517KLnu1R8tx8YXrwEY4Cm5FEDqnrKna28F2eqrbNMg0RjcZ5aSBRtwwoocqp
	4LKN3x8Ql02LLGzokaM7q8MYfQ9vdcq3xsQ09xpi6TF0BboYgvgqIZYnpN9CknAG
	bRl04TdROC3hVzGPlsZKUZa3yq6J5rZLFPHMNGUsoFhexwd2HhIVKmLEVhKxjH+t
	kyaDpc6Ke0k3QdyBkl5ER/OgTHDTA3TV4ErRAKFzKhS9V6L8DdVOIkCDsvH0Bp97
	leZpnFkrPi5sp5rnLJxN0/p/cgjH/u1n5Uo+NpWQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jka28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 06:51:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso3360154b3a.2
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2026 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778050265; x=1778655065; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=agAhrd0P0XsqmcKAiZ6v9uhXTRZsePv1OEyLuhtEakDRObj9kBfU8OFvegH2HHPrwR
         VJL8+wKuPcqSGHxUeIOxC4W/2us0C/VcXXWi1vUklJn/q3lWUqeSzRCES5BiJQNGTdF4
         VEq60OsgpxZadJXsFLPq/STxx08EWENQu/OYBGY/g3huU3eXQOWLxkKry7N30v+uvYjs
         LZA2Br6y8RnfyXD5my1jXxoBZTAkFq4zYBrHYEnHnNGEcwPw5EETvisu8vaXiZjvD7FJ
         6d6bjjagpu8Bvqivy8lpVGJi5GzaOJ4kBOuD7SacAdLDqk2lUG/HNlCAwyCi4Jj1ltDW
         bMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050265; x=1778655065;
        h=content-transfer-encoding:from:to:content-language:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=AIwFrdWpIVbSJgtbM36j4CnCnNzRpvqlvFScHfvsD/As5eIagYb0Rqgj8fCZJFlEMH
         DN7ZI/xfdc+HmiKBrjO9SpfGc8nQZgr8bh897eKoI+bwuzG4E3wDjTFJUbpUsW1KuphI
         Y6yGwtKmOZMBC7IecMU05Avr6SOHFzOJmU67w1+oalw+AqqB33SQy0tRsj6m4E/DkQ6s
         KxvQWLewRCoErCh+8wHDnw5hY+srYqketrIJqXHTnoURIHBtB2rOshzAs4cuvCVR14oH
         a0j7suA6tuSoDPkTxb0LEmsB46BbaJ6gA1NfApHR0jWIUwn/p7jcseqq0cZEyswY5xnG
         kkLQ==
X-Gm-Message-State: AOJu0YzVSsJChTK1doGx6JjbRRdJzwjMGqyOsNunmX6ZaIt21g9oRfY0
	iTw4eJMydSpbCycFHylLinESi3ath2pPGC06QST4saK3EhBJTHACIyuP94w/npVW59n5OREOHmz
	AIoJXL3QWSSQlJTCc5YWMQb6U3TF+WG/KGshbz4j6Mgk599KkxDXJinA3ZUa+RzC+q0zEaxXH/P
	11
X-Gm-Gg: AeBDievSu0tjlKh0/1aqpobpgXuiqAvsE9P/cTI+kAqtoekEWLE3OP4pLeESMdF9rZ1
	Z5NskKEDSjswHfPd08pP34nOTQv0QMWLTes/VVX+h1mqPe7nu/XV4tGB4yK3VLecW5DZfSoVXGP
	V4SVLwbfn/KEM5z40ltsdEOviSohFA3OYpR6ds8kuN3ruWg9M/BZQ4MFUffhFM22o2xaNtBpzih
	lhpgASy+eGija/h1mRkxtZHQevJKxpyPxNeUeQHBA5fk3Juzlhhw02VSqUPqrFQ/HYyzC3Qxjaq
	OZMa3GZHfd87cw/p/CbmYdqMA+gfASH0uhnJ0jWNFdqMZ227IagK9PfZ/5Go+Wh6K691PApcZ40
	MFr/Ot9hAosYOnYb/2AkvNn6nNpn6pD8uvnvt0/g=
X-Received: by 2002:a05:6a00:27a1:b0:835:6173:dd2 with SMTP id d2e1a72fcca58-83a5e352301mr2000913b3a.44.1778050264633;
        Tue, 05 May 2026 23:51:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:27a1:b0:835:6173:dd2 with SMTP id d2e1a72fcca58-83a5e352301mr2000888b3a.44.1778050264137;
        Tue, 05 May 2026 23:51:04 -0700 (PDT)
Received: from [10.151.36.91] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d35b3bsm4113020b3a.24.2026.05.05.23.51.02
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 23:51:03 -0700 (PDT)
Message-ID: <a97e9061-ad5f-4ab9-867d-c022ae79fe1a@oss.qualcomm.com>
Date: Wed, 6 May 2026 12:21:01 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-spi@vger.kernel.org
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA2NCBTYWx0ZWRfX4ONavOpCJcgK
 XDNsKhN1DKBijohnqcMPmFRJo+UfNO/xkHQ7VLITRw7A48mr7XZCieYH0PyNWYDKnVA8uGM3A9Z
 zfS1FZQbf0LJer8lp3yLFkeHJ2ZwWtdeEqRVO/K4Ld7NqNOgP5ZdwiSjIh4yJa4Z4xHfg+PpKe7
 uk+7Ig1FCDiCd79Zbsmpl9lrQAbsUjTUqRWys3/RfG8H1LEMnX4hPwhOFIKCan44nWcoyFn0SWk
 KnTIlWmhuyNzWl6eZ9xbLqizmjdvplKeWe+OjVWmC+V2mabY0qw916OoaHafZNPkwZF5FpTceUv
 ls1nq9tuEtHo/Vrxw0P7Z3RdpP+wM8SHofS7Czjgx48B7Ph2LAIyUbWr9BKjKAv0efpwgZaCdgt
 c0rlfFwv7WsIe+kJ2NHObUR5gFL1SZfqUz8q9jgkaBq/Yy+vEQDdGApUzHm4wfGZjmbtb4wHQvj
 6XdCNep0T+VPTHRA6WQ==
X-Proofpoint-GUID: uMzbVTrkoYdN6OLecCIq6SaOsAnW7RQo
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fae4d9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JV2eVSZHMSyV4Tj97bsA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: uMzbVTrkoYdN6OLecCIq6SaOsAnW7RQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060064

subscribe
