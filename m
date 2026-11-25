Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610121;
	b=1+dn1iCWMr5QdleNIYaM4Fs9N49jBkORt36IIZ2ieo6ZeTnSA6CxO54KqC0zURwVVZD7
	 3PFM9jv2GwzXOAlxDHvwAj4SVD6SYRCAVZhfBRUT5fLuO6S5VX+AQE3DQhg8wChNFkFbi
	 yV8M8GJxhw65Z9qWqRIIiVKSmc5rMaZcgNoXHqBOZNip5o6EvVx8Jz5fEWV8+o+XGQcz9
	 cYJQ7UMTxN43OIK/PD+/xeG3+Ahho4M4O1J7OnliZl7fD2XPah53e1o6+z5+RBmmRbbsX
	 tetx/RJUYzhZazfMtgqgGt99901e75CwMVWCZ7bf2FLADooGxJr2XWu9PPIVzwfxivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610121;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7gCWm5f0fW+q26OPY8/fXasB7P14OVIPDrLLral8tUw=;
	b=IDUOibNZRRKUrRoGr4KeqAv+RSWTeP0fQrED8A57ZdAAO78xDfozs7JlC5z9MBKgGLa7
	 tjcUATIfmyWixxTLDHlKAeKSHxUh5BphqqdxYbSoVazIBOwhAJbvCvn3KJihH+VjfTKsv
	 s5c0nuplulY+SVaxqGBzLwUXzB3i1xa7QRmoo4NeGa9dZJixTZxG1ItSfO7xxUl6n5pwe
	 a0dxgUANt8rQVaxPuLv/ssiGDMw3GWcuAJwEpIOU++BToEbOynGvyCm6SalTriP6Xd4cl
	 K8Y1WeVvQxC6Zu7VowG+FmnWl0nfjm5Q8BMZ/YxZ2RNigakLAYfqE3+mhgkADhCUWSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dy48WX7r;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="BBC9h/Cq";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2773606A31E
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 12:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2773606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dy48WX7r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BBC9h/Cq
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mQ2X2121282
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 12:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7gCWm5f0fW+
	q26OPY8/fXasB7P14OVIPDrLLral8tUw=; b=Dy48WX7rv3vTqORDur6yYnutQxA
	Y26RUD7aZsx2TqWGe7DHrzftE7gpmM5fDLnaWRlNcSDAJ8x2dgOdtOPL14HEiv0n
	sQxIGa3FZnvqD3qifZW+OG8QwB7NX1DIvgUHKxeGuw6MGNu9CdJ5h1Ejz+/vyTe8
	zDMT7TT6ufSyLPPyIZsgL3muvmskAl1Bdsq9n2LTRIcDOtCczSKkRvlAoDn33x01
	yBleK08wnT/AFWNQ7Nq3kLTKkeWmxvfwbMb9qQPe/fLulV+xc/PPr70h3h8tC4KH
	ji3RGFbwlEvozhohO+uPpber7PC99KTJPo8CM/RScgJy5mh1Yn8cm8N15FQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vukru1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 12:35:19 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b25d977b91so6181376c88.1
        for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795610119; x=1796214919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gCWm5f0fW+q26OPY8/fXasB7P14OVIPDrLLral8tUw=;
        b=BBC9h/Cq7h7B/PE7l/MXSTe7eYD69cqrN8BlkwiUXtKcFBeN6FU3XhwHprZ1BcRNuI
         AKvbIYslQ+FYAWaqCdBunddQLVHFd71LFNDX/e5L+g5i7nZ3WjgFPSopbGVvdghIHBQB
         yHT19MYfpXSpKTGTyOtEtUXlYaBk6nXbxh+rj9OQMIXL15c/VkTbUxR0pbfyQXVqvCVT
         iPKo+8agSfPKgf45XSbPaJkgB5jNBLSbxdU/F4PpZA7ufoS3aAg3kf+Zs/vuYMcKjHp3
         xXE5R+pHxU1nWrK6x//pqvIE18JMuD05ZBCpqmLeez6iUrslSmKntpC027lfy5D+DDk0
         kAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610119; x=1796214919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gCWm5f0fW+q26OPY8/fXasB7P14OVIPDrLLral8tUw=;
        b=mksT+Epjz1H+HJ4bZINYC0/FLrjQ4PwWqeoSUrTFEJ7MWjWW8ePSOPyTDCJAwEfbCR
         M03ruyXhXP4BL2ftkkiCqVvsiGrFhzQNi3EfqNjGyxxF0fXjjaTyQ+erKvbrn9EafSMi
         VtdvQ28VBkl/STc6uyiYCYgi3soghOpfsaXligCHVZ+F9NIBW4lsLCJeIcNd88+Y/Cr3
         j8WvBoIw5xvH40UDtVaqJBWm3Ima5OIv8BHTb+B3oR3O/Prznmf0zmR+AT8gpwyiLylq
         ikdHmiTPS0B27USBwqlu6JdTW6n7Cf7QHw4JP+5RwLNGVojn2gCQH7aT/8NpuzupE1G+
         5TZQ==
X-Forwarded-Encrypted: i=1; AL+hErHNYVUCmYO38EZdMljS+GutB4pj5JGygW5/JnGL/IakkrxZKMsSprjvca1DLyvILT5Ri7yE8bq5his=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ah0Pn6hvWRYg5L6bDSQebKQWfVNdFJDu4RO6OB5h90Lk4Myil
	NGGBokYfhpnEGnZdDfUaGOp8tvVK2Gc84aFnDm4Im9teBF5p6FC75aqCTVjwV+J2EPi//mbIDwU
	MZkWGTtRTPV6OSNolMr7XhVjMwcasmxko8ICi1ihJ+SD5/Bg/bG9YDhReuAh/LXZVSLmJRK4=
X-Gm-Gg: AZFdTZfQt0npGWKlM3VUrNqvlNOY1LgVYa/ISlTOcSk0ZMSCkW76LHYT3t8ccg613Ip
	WVush3oDUuaRtAGHLntnZo/2Wbr7PgsCKlNbn6t/WoIiAo+3Wciz+QQJu+OadVPAnSxBbn0g5q0
	D4r1tjxeNJ5P0J6flN7qurI2HOPzwiEXS5ihDJM52crJuDZuSzIMlb2qHpa8Lo3ltufyR9Ff9Bt
	HWyW1iFl80EyBayCAolaeFiB9//TinwNH9iF4wItWFyYZttY9nWHiuhlYh40/L7pYnZOtC5PUCC
	clu6k5j+EybP8Ak4oVmUwex4I/JHPE5NgMEXIVqubgD7FQrJcCchJ14FyZ8CEpRzZ2yTgAZ9/Ai
	Kib4IRYx0Dm3ntPj1YNmC7mT8EETd1jy5TwH4MmM1dNKwjSXDU3S1cRhbYiC2HQTpHwBCMmta3t
	2DUcVUaju+wVmLMTdiSCZuiJaXGAIVM+s9iCNfoA1xnZ7vpp9+f6+Mgvw=
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b5568f03abmr16213738c88.36.1795610118697;
        Wed, 25 Nov 2026 04:35:18 -0800 (PST)
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b5568f03abmr16213718c88.36.1795610118165;
        Wed, 25 Nov 2026 04:35:18 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm66856523eec.5.2026.11.25.04.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:35:17 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: spi: Add compatible for Qualcomm Seca SoC
Date: Wed, 25 Nov 2026 18:05:11 +0530
Message-ID: <20261125123511.401747-1-yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <04e8a33a-ad20-4f2d-845e-1c0b13984a69@sirena.org.uk>
References: <358f1284a656582ef0ea0e2b7bc07224372f9fdf.1795517702.git.yadu.mg@oss.qualcomm.com> <04e8a33a-ad20-4f2d-845e-1c0b13984a69@sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06d607 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=38CvgGhHUT3NM48cmdEA:9
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: nKksRCvhAh_mtfgbnbLCBciJCs-8QgEO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0OSBTYWx0ZWRfXzTPltrYKXcWU
 rJ/hsWTtoxcxiuOJ/L22r6TjnahqXWMpNrGOSCNLslLP4/7Z88M9C/a20Uy+AnGiLrQ1ik1AsGm
 /9r1gbWOhrIU9ytHnPdaynwlOhmBt+8=
X-Proofpoint-GUID: nKksRCvhAh_mtfgbnbLCBciJCs-8QgEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0OSBTYWx0ZWRfXxZ70LqVqszsg
 41y2DoF1E5fqXesO9jzQe8UbCJF2ym65hx2bTdMgmGGbZIXozwgzmU60bTEIMMYqtCHzR7OFcju
 w9kFzfjdrzdruSfECfNNZ3rwv9ksY1gZNVUb7INqHgyzvc7/lqIuw6esKwpAY8uJr63dZfzB67a
 x0+olR+W7U9lC4UMk/5as77iOWFGDzKFpkIYJ1JvWN8pLs3poJhQiTj/fcgjIW9jqyMLCMC0U6J
 M07zSeRaaLfc+tvam+YB8/9y3SlIqbCsGyCKKHwdbFNYIC0crLYYe+ZMz2EXWm6vQ3WA18aTrS4
 InHptpUJXu5TVwkdhRzhJFLeUo3IckFgBI7JvgMshZvoWjoO9AoH2pAMfuT6dwA55WT/a5wa9nv
 t6/V5+zYFbHfnsfUM8CZ5dcqjz607AzQIpTt+eoLxmFKQqshprdHMb26cmwmIpoB75aw6PoszwN
 8oBmTZv91J/QrXdzdHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250049

On Tue, Nov 24, 2026 at 11:35:53AM +0000, Mark Brown wrote:
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.

Noted. v2 will use "spi: dt-bindings: qcom,sa8255p-geni-spi: ..." to
match the existing commits for this binding.

Yadu
