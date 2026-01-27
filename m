Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2F361DDD;
	Tue, 27 Jan 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527596; cv=none; b=sRaZGB8TmmN4YQZp05pRgI5NkwUOHkAUdls4MUwuO7TnzyAY5GCoLKwqwbrhKekEwANwITtNd153e/T1IQfgtCXvzbuu+fAK8C3iCrBDbyKb5aRcODnEk+2uPYNyaaE0cPk5O4xRuXgk3wlEKCFaCVdF/2FveSg/pWUUEJKlF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527596; c=relaxed/simple;
	bh=dYa5olGV5Ovym4kdRU41YQW/yOjhtzTTkf7NlzCTG9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbG7+7yZ6BEZdHkzDHbnHtxKjcK89vAbWL38UhRuUfTN+ko/F+SNtadquPLdANaWQRoQmdSymma0C2tLor20qzelyRJR7p3DKQEmcO3MVhZUv6ET3bjZ4SOE97OWLRf37nIPTRb0ObFEiWiStluMd0tSndSE9DefY6Oifffvld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=huObHeSK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="huObHeSK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R7ZCPm002091;
	Tue, 27 Jan 2026 15:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xqu99C
	dbC13msUmPOJ0seTS13d0KFZIImxUIko7WsTQ=; b=huObHeSKQg81ZTN5aEJkJv
	xeQkVYo85ZmTAWr/CpW0AXMX7iKH+xPOcxF9ln0yPrsF7GUSTeKB7A5VXghCNrvu
	LvPFMT7P5R4+AsDnfaa+n1C9vMoj5CkosATFMvYEw+Y71FnfTXW7oIPLk+PfrfDB
	iuv8Pp0/3nsiP5jpMjqHqQqhRChHjgJJyv+xXuyCFH71qaAU+CPIAaFsQnEvS0li
	gxzytRWcZVLnAjQIFSiIHxVu77kmyF3QlCjbM3hgSuFwLTpDWfYkCUXKSIO8RG4C
	1D/LmWxbUtBqcKPVCJIDcGuQYKY3qfgecnsaRCosZiyX3IKiZie7BhnizkoGwAjA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6x6na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:26:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REgUAQ023624;
	Tue, 27 Jan 2026 15:26:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjrymf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:26:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFQSbO30802544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:26:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 813E35805D;
	Tue, 27 Jan 2026 15:26:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD2158056;
	Tue, 27 Jan 2026 15:26:28 +0000 (GMT)
Received: from [9.61.135.234] (unknown [9.61.135.234])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:26:27 +0000 (GMT)
Message-ID: <ea339dbc-e75a-4792-8d39-c28b3cb6d0c9@linux.ibm.com>
Date: Tue, 27 Jan 2026 09:26:27 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] spi: fsi: Drop assigning fsi bus
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
 <279e26a6740f10d119be7ea01d4af596309b3bb4.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <279e26a6740f10d119be7ea01d4af596309b3bb4.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AVAAnG4OM8_4wvRcJOjTS6VghpN8Vzrz
X-Proofpoint-ORIG-GUID: AVAAnG4OM8_4wvRcJOjTS6VghpN8Vzrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX4L2T3MY+hFiP
 SLaI8uqZehSKBPTIkeWDOdM7D///z3g4QiLPvF91R6xOB7XJjsNAjeXDLTuhZLriRLKzDD1/+wv
 IN8xAgyluBjHrnxijkRDNhmpqK0UAv+AEYEDrG2gJvJswcg+VRQKW9/zBNMSXg+WbWx97vZc7MJ
 hT/VfcZqfpPVKTOBLxNsvZk4bmrGGIr3j5HuO5X2H5cIfLPz5z8mnbevPiX2WrfzipIrVQO7EqN
 aU29lCm/JG8t1GFk2gbJh3IEMXqY1Nd988HVgPPXShtdqyQ4PUWkp831SAThEsenCKLPxc9YAqv
 T8o4YTt4vRi03Sqwjgi2syFRTglQNmcwWGjozaBooh+CRwttG/83PG40tPOry0sR5YXGAyj5Jlg
 GEFxbiQbxbw5idLfqH5C42eAUhXn/tODdxhyiyACX8luhrtdyXpGOGHpZEUDpQvtalD/AR7ePjH
 LZ7PLlmB/cCA0BvH3NA==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6978d925 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=bKyC4-_fwZ91YHrlqQQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125


On 12/9/25 5:40 AM, Uwe Kleine-König wrote:
> Since commit FIXME ("fsi: Assign driver's bus in fsi_driver_register()")
> module_fsi_driver() cares about assigning the driver's bus member. Drop
> the explicit driver specific assignment.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/spi/spi-fsi.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
> index e01c63d23b64..f9c15b99dba5 100644
> --- a/drivers/spi/spi-fsi.c
> +++ b/drivers/spi/spi-fsi.c
> @@ -595,7 +595,6 @@ static struct fsi_driver fsi_spi_driver = {
>   	.id_table = fsi_spi_ids,
>   	.drv = {
>   		.name = "spi-fsi",
> -		.bus = &fsi_bus_type,
>   		.probe = fsi_spi_probe,
>   	},
>   };
