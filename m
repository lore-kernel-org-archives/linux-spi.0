Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EC1D9A54;
	Tue, 27 Jan 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527802; cv=none; b=mv1LpcIAaMkFed83rnF3plUgyyksTJmP+CvEfMwDhalv78KVZ+1pPmVXGYv6Dkm9nUanZik3ZGPE9L7TQOBJTLgK1GMdFM60Q+CVuzEBYL9hT5UINaAqou+F3kq9ATiuUhdkhk7YrbdSU/Y/disCKiqfAwVvM8yl04ltCis0HV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527802; c=relaxed/simple;
	bh=VMBikvQSm5+neQ6/ngeoWcn+36GOcw2gEABPUq/7xV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIXCjdLo4SZx1ECOqc8aflrq1jAnsormurpLnCj//sD+dElyyxJSRqCn3hiWtQozrROgmkRqYbpnpLcflZ69ybxKPjXYvZLhfH+EnT//wLsj/jPkKR1BpyWb+tDow2aKhKIWwGAe8cxrvribu8iG+Chm//oef1tgV3gllIt4DOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGF5/MYG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGF5/MYG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6w2hm024977;
	Tue, 27 Jan 2026 15:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ASwTXh
	s+jmy0BoPy4ymzDGB3dpSHmLSNMF0r2bdu4sc=; b=oGF5/MYGhXxMYawnpiJBjx
	0P8A+qJe1cJ1qFd6KGREF+tN6BmYfRjtdtNldbT8ci1afLHQ6LNVKPQyMQlLEPAA
	SrDh4VS7uL3+PaRDof9c/Kj/Z+3drih+n+M6uQYiofaow9Xep/RDynJ7jQzTj+tc
	YTuzY6GO3G9BJ1i5QHlCoCb5r6ge4xa1KN803Om3Zcc4NET6DAvESUXp85aIwNFq
	714OzY//CJvJRBbfBv8K6Uaa0/CvgfvkuLsDCtBbNe8n+hWialcedpfhakmPNvkF
	9jGLMtEMRR+asuF/4c8ydci0Z3rcNJFuegYfi22F6h/qJLMDNoZ19GwwquZkhObQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvgxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:29:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60REPhtm023625;
	Tue, 27 Jan 2026 15:29:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjryx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:29:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFTqLU39191070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:29:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFD625805D;
	Tue, 27 Jan 2026 15:29:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF4258052;
	Tue, 27 Jan 2026 15:29:52 +0000 (GMT)
Received: from [9.61.135.234] (unknown [9.61.135.234])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:29:52 +0000 (GMT)
Message-ID: <e852b379-eb7b-4088-ad47-471ea1d755e2@linux.ibm.com>
Date: Tue, 27 Jan 2026 09:29:52 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] spi: fsi: Convert to fsi bus probe mechanism
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
 <fc2a758ef00844dd5bd614a25b36a4a38355d12d.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <fc2a758ef00844dd5bd614a25b36a4a38355d12d.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6978d9f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=pbzB7dRMngX6iMUxCd8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: sVRmaPvr_PcABlahgqsIsKl0dz9afe2r
X-Proofpoint-ORIG-GUID: sVRmaPvr_PcABlahgqsIsKl0dz9afe2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX8sboilql3Sot
 7IplFzLChXS8ynBOoOZymUzjBXSqjf/kn1yYxC5WDdm2m48hcSHidHQnDdKVoqwZ8d/hcbR17De
 HluFJ5NXlJaUsTG8TD1PSkRd/dayosuYiULUse/Fy8R0GZvlqkS8D+lmdVyyMGlXO5j7qrp5hxZ
 phj5mrxc8TnvVHPSoD0NDZyVbg9gxi1B/k9G8Mki0lELhr2YAMgXe+3BIJ4lPpqHl80/yp1Goar
 PeHyvFb4j4Y3Ie3Bjhve3/rBH7psXZqCLzkGcOPYMhrBtV14T3L2LdkQyatr0Ve1vlizyH7jZyl
 fuf3gGZFFWNqIx66ek1JMDwhfiTqj8MPXY3982cKzxX/qCChfL4MFADbM9YFBxqguS86a5sx4pu
 eN+2W+E0+e/ZCx4N6IvAgLXWEHU2zHb2mAbH68BFr77jlGET06stbR3N2R9gMW7HMSTXslxnUan
 ZxGH7BVjw3lpas4DBog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125


On 12/9/25 5:40 AM, Uwe Kleine-König wrote:
> The fsi bus got a dedicated probe function. Make use of that. This fixes
> a runtime warning about the driver needing to be converted to the bus
> probe method.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/spi/spi-fsi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
> index f9c15b99dba5..07dc3d24f2c9 100644
> --- a/drivers/spi/spi-fsi.c
> +++ b/drivers/spi/spi-fsi.c
> @@ -528,13 +528,13 @@ static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
>   	return SPI_FSI_MAX_RX_SIZE;
>   }
>   
> -static int fsi_spi_probe(struct device *dev)
> +static int fsi_spi_probe(struct fsi_device *fsi)
>   {
>   	int rc;
>   	struct device_node *np;
>   	int num_controllers_registered = 0;
>   	struct fsi2spi *bridge;
> -	struct fsi_device *fsi = to_fsi_dev(dev);
> +	struct device *dev = &fsi->dev;
>   
>   	rc = fsi_spi_check_mux(fsi, dev);
>   	if (rc)
> @@ -593,9 +593,9 @@ MODULE_DEVICE_TABLE(fsi, fsi_spi_ids);
>   
>   static struct fsi_driver fsi_spi_driver = {
>   	.id_table = fsi_spi_ids,
> +	.probe = fsi_spi_probe,
>   	.drv = {
>   		.name = "spi-fsi",
> -		.probe = fsi_spi_probe,
>   	},
>   };
>   module_fsi_driver(fsi_spi_driver);
