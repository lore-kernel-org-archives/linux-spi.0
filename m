Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15236307AC6
	for <linux-spi@vger.kernel.org>; Sat,  4 Jul 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144267; cv=none; b=OTe0Nupc7ZZC/oiAZuCXVAoRKqM1IK35nG+fQ2v2dvARTwh9lnYZH+dUQlZYu3C56TRpKGCwGkumLCXUKDxvKqU2s+PCkqyzCqdPm2uitujeMNyZt21mW1lRLBV71Aqpm2wz2L1bttFOUtdeWfpQSIKqZKv+Vlkh5UgSNoh5Uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144267; c=relaxed/simple;
	bh=hrDTIMmfyR0bS4ItNIUcF/yfI+80W3HJbfHRHlQb56U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBsPAYhRbS97KhpIaHRAlG2dj1teYmlixMY88oJO92jERJVwZyVJKFud3dvu97Ke+iCBulRHnNRLjYXqgiAlB+BpUR2Gt1XxU/dIXqiSt/tADGxcptlLX3uFtCOE6G9N5lqGBHcBgHn2khp8pVqvFfkT+uKpY1SbBv9/HsLfezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVj9nhfp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PewFPdes; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVj9nhfp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PewFPdes"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6644Bn7x1836978
	for <linux-spi@vger.kernel.org>; Sat, 4 Jul 2026 05:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=; b=KVj9nhfpZz/OR4Es
	g3MYKSHaopMTLEN3vkK/DHyyxVOSsg38ARKuvgG7TNmOo5vIsmbY+Jhx+MKJ4DkW
	BqEdnyR+OqQ69kNXJU16xVASNIzhaUY0ySMmQ+3iUlO3L9k4qCgoCbIbpIPcUb0m
	9pWlBlyAllFM5dVdAxTA6oF4EW8j5YzQQh9zg66rL2trn9Jq2FECFe4tSatPshuV
	2w8FTbeflcETUm60Pw+WigujBcVmfzKptw0tHkCAUzUtGsnUXylRllS/eUKQZ6Z0
	a46VgWZy7Dgix4jVASXYcPdURiH1uiaDw9mTfPCZ/XHQnEuqqNkF6q3sHd+6+s7X
	9LCe+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txeg52y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sat, 04 Jul 2026 05:51:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso1262829a91.0
        for <linux-spi@vger.kernel.org>; Fri, 03 Jul 2026 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783144264; x=1783749064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=;
        b=PewFPdesWlb2g78dH1tBfzJqcN42p137hXnStVdG5qm9tCQEoejogkIecx0sdiHnR/
         pEmeaKDk6x4wbFi5CK1HmehqIoPj7A2QXrZpO23fcKMc3f14yJ59Q1t3fCgZwbjBffYO
         z7kUVRHUvdC19OLh58QF0zZDBJFcuJDtZqQj5WCtjZU4C9slV/stUyY8o1dU+oMx2Rji
         j03LYk4d83oS904bncJLx3sY7qv9ufy9IGE5VkHQPGup44//fGM9cXjMR1fTqwOAdB25
         pCNWB/V6zCWV5LM8lTz2Vak1URQejPb58/mfhRN3YRXjvV4HxdcFJim1PuFAoS76oqFi
         oY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144264; x=1783749064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPgsw4LHcZkkkqPUiF95WWE89s3NKtA9u8XaxB5FvJU=;
        b=m3SkafLs301kgUTtZCA3RIxpB83iRW2rXwJU64lZcDMyPDaqv9CuXC3UZaOdHVNdq5
         IoFUIgSg/cy92H67icZ9/wFRea547tiIYs9ylSNlgR8jJx1ZBXm4IsDEf7dPatbdDEC4
         WEi85Ft21z6EBIifmmzVr/jiTL99VcJBO9dA5qs6JlPF6sFuO7KIVABVBVyelt4UQtdz
         1Nwh+kRS/EVEwEHVcXxiXQD1kiEPWEtn/V0YFvj4jX+YCN2BOw41CnBsbTgnCMg4HSQr
         ImFxGH78o2SjqBv/Arnw13j9jK2Q3cy/AELg783xwzy4fi9VEhDUxEa4GEgBZICnV7QC
         xlbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHE2d0COsnYDYk2FXdxGo6ov6B3LZFql5mujMwZrrcjkSbJK+JecDZJqH6+y2ac4aquq0YhWqciGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Jq+RBNvZILLy/wpqPFHMarJvdMj3jQlVfgdfIm5xPtjR0DHu
	4clk44VWhXDzwglgKZ/x2J3qZL6twSyuoVjVfZg5agN3U597wP+J8WLCLBwT+4FS6xnhLTaYt4Y
	graXRMcWUr6GY5m6WajPx5xk99kyj1tB47CZZbBW95iVU7ppSqqnOOpZlWDtpErA=
X-Gm-Gg: AfdE7ckLWjGAoISggp5U1xmGMzSLoWuMPG45jj6mAFnPvQblOcExnABTIjxRWymE93U
	djbpT6Hh06gomdGUZXQFP8vEDcfpMuvPpc+fE5aW4t2/XLFI6MMqRSsQeVKYN5SgUF5oeG8qgAy
	52mutpKzwv5BDC6IEbkDLN1rHE88n/XZbY+/Cbci1AvMUmvuhOVE3FWImfc7kcH/f+xqVLSNxbp
	JfWDpeZkKvZFxyXM1m+3Ihswdu1Zha7hY8q6rXIRngXDiX5rkz55bgT32NH2rIemsG5ijPoSx2a
	llaQiX2mgJkF+BcFl2uHmSuSUjljVEgRFsUoOSd+evuXwLFJ9vQRLauZRZhnBkIyzBmWIgjAanQ
	QqRYO7PBHStKdtnXjaQE4LqKJuLHDHoqW6LKk0M9IxZY=
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr2336973a91.3.1783144263614;
        Fri, 03 Jul 2026 22:51:03 -0700 (PDT)
X-Received: by 2002:a17:90b:510e:b0:37f:133a:3e09 with SMTP id 98e67ed59e1d1-382803b483amr2336920a91.3.1783144262906;
        Fri, 03 Jul 2026 22:51:02 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.111.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f31e7a2a8sm12120126eec.25.2026.07.03.22.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 22:51:02 -0700 (PDT)
Message-ID: <ecbaece7-764c-4e0e-b490-55d538f8aa29@oss.qualcomm.com>
Date: Sat, 4 Jul 2026 11:20:54 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan
 <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
 <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-1-578b78a0cf46@oss.qualcomm.com>
 <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA1MyBTYWx0ZWRfX9obYGwV2pOFe
 fa6y/TVMzvyu43X5LbbMmrMuYj006S4JdVSdA2ev3MbQNdmnTj7luUW1bEgZXZS+h0MaGruVru5
 PC8DCd5XBhwexes4MaP1wGz6TDTA4ao=
X-Proofpoint-GUID: pnwu11bQtKU3YNZeKoEZfy77fX1yebHC
X-Proofpoint-ORIG-GUID: pnwu11bQtKU3YNZeKoEZfy77fX1yebHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA1MyBTYWx0ZWRfX91+vyZbh3neo
 6ywpPWr2T0iwgeGaNcoxUjYhakzVwa80KRZMAg9p5exq+PAOrGA94tuGt/n2NJB2KLRubjV/4Ak
 S/QcP7/7DQZWpc7ZliW8rZTz+t+Q3WJVrYsJfBbqE+bLSbztnYMeMqjeNI1WUEges5IGIytgd8X
 KWN2tw+cOQvEfuBE7+VKnm5RfQ8/WJf7MyVVO246Jn5+/TuOnpbc2srMyC7wbY952qdspny5Z5f
 JWC6d8PaIgfetLLdAdTQENsAb6AuUDTzt+CXMeRirbn/v/95s6prY1+N79qz3ZTnISAxzarc/yX
 /dSsvwL6qQJ7UnuMJtbLzquoUj4O8Y37BsKzcDdCYAk/i4sSuCxa9wd0CzyjM9wKl1HrefSq2Ed
 z+ZgY/D9GJ3C1VWDyqbiDCLggg6wNclkuH+HxeonD7xxORAd3UsxCldGUwlXCZWPrd+jNYCR52h
 TwcJiY7avCbp/oYSnoQ==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a489f48 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=7DW+zsgf7PPjz/i6iZMG3g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cavnWwEOFYD_SYEfP9UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040053

Hi Rafael,

On 04-07-2026 01:53, Rafael J. Wysocki (Intel) wrote:
> On Fri, Jul 3, 2026 at 5:05 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> When a runtime resume callback returns an error, rpm_callback() sets
>> power.runtime_error on the device.  This causes all subsequent calls to
>> rpm_resume() to return -EINVAL immediately at the top of the function
>> without invoking the callback again, making the failure permanent until
>> runtime PM is explicitly re-initialized.
>>
>> Unlike suspend failures, resume failures should be retryable.  If a
>> device's resume callback fails transiently, there is no reason to
>> permanently block future resume attempts on that device and all of its
>> consumers.
>>
>> Fix this by conditioning the power.runtime_error assignment in
>> rpm_callback() on the device being in the RPM_SUSPENDING state.  At the
>> point rpm_callback() runs, __update_runtime_status() has already set the
>> device status to either RPM_SUSPENDING or RPM_RESUMING, so the two paths
>> are reliably distinguishable.  Suspend callback failures continue to set
>> power.runtime_error as before.  Resume callback failures return the error
>> to the caller but leave power.runtime_error clear, allowing the next
>> resume attempt to invoke the callback normally.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/base/power/runtime.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 335288e8b5b3..70d933bcd295 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -469,7 +469,13 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
>>          if (retval == -EACCES)
>>                  retval = -EAGAIN;
>>
>> -       if (retval != -EAGAIN && retval != -EBUSY)
>> +       /*
>> +        * Only stick the error on suspend failures.  Resume failures are not
>> +        * treated as permanent so that the next resume attempt will run the
>> +        * callback again rather than short-circuiting on runtime_error.
>> +        */
>> +       if (retval != -EAGAIN && retval != -EBUSY &&
>> +           dev->power.runtime_status == RPM_SUSPENDING)
>>                  dev->power.runtime_error = retval;
> Why don't you move this check to rpm_suspend()?
Yes, we can do that.
I hope the changes below address your concerns. Please let me know if 
there is anything else that needs to be adjusted.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..fab38bc98113 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -469,9 +469,6 @@ static int rpm_callback(int (*cb)(struct device *), 
struct device *dev)
         if (retval == -EACCES)
                 retval = -EAGAIN;

-       if (retval != -EAGAIN && retval != -EBUSY)
-               dev->power.runtime_error = retval;
-
         return retval;
  }

@@ -751,6 +748,9 @@ static int rpm_suspend(struct device *dev, int rpmflags)
         dev->power.deferred_resume = false;
         wake_up_all(&dev->power.wait_queue);

+       if (retval != -EAGAIN && retval != -EBUSY)
+               dev->power.runtime_error = retval;

+


Thanks,

Praveen Talari


