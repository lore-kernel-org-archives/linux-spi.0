Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9C2FF675;
	Tue, 27 Jan 2026 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527874; cv=none; b=YkO8+qIR7EMQ71h89ySCsMMHLJJ3npSEdNF6e5kujsf3Z5j7GTEPkcL0XSjOAlPE8EtPk2ABBWJAetxSUJcFgG32A71oSaGf9Rmu8K+fk7bxBQCKQjYAtOxp8JCeu7eTux1MVOQpErarcQ70yMwsmUZPZGxZnxn9XBO25a1Sbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527874; c=relaxed/simple;
	bh=mKMgqTHIao3cqh5a5VAqibt0COVUzLmPfGS+shLM+dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnrZpTQayszviOyD+FKPW0GlOJV+LyRSExPYQPT3lth2V6b3iV1Ui/gQ5HWkAdB7BeZpvSjwZXkUHQINo3IJw44zHn37PfCCRNltOMrIuYJPMAnhC7hEeplJFmocozMvTEUKyZRX80uskO5Z5cbazgDQSMG7IRSYnHsm0JufgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iCH3j8ia; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iCH3j8ia"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R53arZ031029;
	Tue, 27 Jan 2026 15:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CcuRSY
	pvHj6NoHofQbMK93lkeOoKjGd3IwYs/c/IxcQ=; b=iCH3j8ia3qRRLntKhAZHwU
	WbCNDPZtVaxKK4wvgFSTcNtRgfu60RXVXdxYtMsZVJq22XZ0OP2pauAY+ynIxuGq
	eGkG8UCNBbVACirf8pobSq2rN90OGqzww7XxnyVkjUcPj+ldyzcf+At3EYETmxQJ
	zQhLJZ/HzcuGz9mGRGTV1V2EI7yn/FXVXQN7P1HGlvAbCxzAVg7JWiOkdWfHn62d
	d01/x5wf4JUgIHkSL2U1Xmh8uJXuGebLmSq6mmRTVFPu1DHB1Sf/IOseSFAqeNa3
	Y6vwxTHRwzFVqlcXTtzvJIoz9gSYJ4umc/UHMj9OVp3RYH4E1X1PBsyvmncJREfQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr64ajh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:31:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDBBYE006725;
	Tue, 27 Jan 2026 15:31:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sy994r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:31:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFV4Cv31785556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:31:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F219C5805D;
	Tue, 27 Jan 2026 15:31:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BC2458052;
	Tue, 27 Jan 2026 15:31:03 +0000 (GMT)
Received: from [9.61.135.234] (unknown [9.61.135.234])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:31:03 +0000 (GMT)
Message-ID: <e29b29d7-b002-4d18-a476-dd129154ba08@linux.ibm.com>
Date: Tue, 27 Jan 2026 09:31:03 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] fsi: Convert to bus probe mechanism
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
 <rwvoi4v3wcrfcbj2sg6mknlasp5klrlpacgwgl2jvwh6ub6vls@iovrqjblvz44>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <rwvoi4v3wcrfcbj2sg6mknlasp5klrlpacgwgl2jvwh6ub6vls@iovrqjblvz44>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX5+4qhV5CuyMd
 6mz2ij7H/90BTOVTToBPAGimZNpON3mEFuu8RYU2ei3t1OzD0z66dwXvU1ojN/gMNAcx+qORL6O
 CUbQh0t0u2qfpUZM7/KJzRESq3SAw9r2FQrk5uIyTv1CDnB3iAFpLrvMUdfCTULY38usEWFRHl4
 DWYOHv9Eg6qLc2C/wrZPFid4htoWdr9duOKeYK+S2bPRdasBX/DFXB8ZED6R3+kPSCQpF+Xh8tN
 QeCeA/8RasupiV36oqfT6e9L7Iy5YB9eorhwCY96vQL5uvOCD8DkdzgclNTqt/OT8VhReX+uiIu
 5uVv0HagKt7VT/ArPdu/m9DoiJhbgHngy1rPgD77rrWgPxAPDxzSgjNUJWs3aFcZMa5PWxzaKid
 VLTBl2vvO0ph746qScEeAj92RY2pwlJ8fx02QGbmM7ZUq8AQ+L+7UFW6ursd4HR5sivvvIq3J+G
 /fBR64CN2AxZWKNjD8w==
X-Proofpoint-GUID: OrbwkcODKPI3bhAADLWK0Xbh4LjB6tbb
X-Proofpoint-ORIG-GUID: OrbwkcODKPI3bhAADLWK0Xbh4LjB6tbb
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978da39 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NN-yl_if-6FwqtqQtZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125


On 1/12/26 3:47 AM, Uwe Kleine-König wrote:
> Hello Eddie,
>
> On Tue, Dec 09, 2025 at 12:39:28PM +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> this is the 2nd installment of the series converting the fsi bus to use
>> bus methods for .probe and .remove. The changes since the first
>> iteration---that can be found at
>> https://lore.kernel.org/lkml/cover.1764434226.git.ukleinek@kernel.org/
>> --- are:
>>
>>   - (trivially) rebase to v6.18
>>   - add tags by Andi (for the i2c parts) and Mark Brown (for the spi
>>     parts)
>>   - Add a patch converting drivers/fsi/i2cr-scom.c (#8)
>>
>> In the earlier thread I thought I made a mistake for (implicit) v1, but
>> I confused fsi with fsl and the problem doesn't apply here as it doesn't
>> touch the shutdown callback.
>>
>> This series is not urgent, but it would be great to get this into
>> v6.19-rc1.  With Mark's Acks and Andi's tags (though they are not an
>> Ack) this should be fine to be picked up in one go by Eddie.
>>
>> As before there are two commit refs that should refer to the commit for
>> patch #2 ("fsi: Assign driver's bus in fsi_driver_register()"). As I
>> cannot know the commit hash yet, I wrote "FIXME" and these need updating
>> when the series is picked up.
> gentle ping. While my quest to drop .probe() and .remove() is still in
> early stages, I'd like to see this series go in before it bitrots. It
> should have all the acks necessary to merge it.


So sorry for the delay. Thank you very much for the series! Greg, please 
merge at your earliest convenience.


Thanks!

Eddie


>
> Alternatively, should I ask Greg (added to Cc:) to merge?
>
> Best regards
> Uwe
