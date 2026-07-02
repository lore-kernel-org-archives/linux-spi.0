Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C348BD5A
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003045; cv=none; b=CFq2rREafNRpxUSdqy5iy22vYLeHPAZEk4gBB4VGD5BKhGcPmHskFrapIN1/QbFBmDfgaot08zZ5mNMCAT2sV5SfVrp0hI70iDdJUSP2M2Vw6Vyc4JY7WIxuHNNB/KJ3JeNMG81QUrsqXzMsbtkc23fG9oix7h9BztPKTLlPEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003045; c=relaxed/simple;
	bh=4XBzZoo+h4kmWuzy4werglNgVdZotIo17q+T00nScV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5FLWh2G6S5MTIXUWl1EgmpBLJXNMR1DAnUeyD+tuEK2YVHQpf35Jw4KEcVnlrzOJoc7F9ES99kcsaEVOGsRLIlXEzjPvo1aG4QYM13HVVqErjBeTrEylTGU0vSWWaEj6I+UecWKHW66QKi5Tul9xvLmSJziU2/med2yL+PNb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLDyEODg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kK5It9yM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLDyEODg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kK5It9yM"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E39Mu661156
	for <linux-spi@vger.kernel.org>; Thu, 2 Jul 2026 14:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wP8xgeRMrZjwY+GUgtUjwAJL9TITkBUKSSIOh8p2URI=; b=aLDyEODg9lmuyxeR
	95JclMHUoHPWAA07RSFj7CrZpz9XisBgNI5ooc2ZTSD8B0zacGJjqYnee5C8GV/8
	hcFDgum2qxl4OHSB1i6JohXLlt5Cfpq9df1wqo+U1rOlygfLfh0T59O3nvhKRirq
	M1f52hOzY/roEPnpnq7zeuCLDolju0nZBkfDmJ+TMrRPVT2vGw0N8DPUQGavGHjk
	nmrPBUczlRNtqBZRjq8gL1p45Ayv9mw78LWuB5VH3SIWvmQcApWO5lRore7eVo78
	/lBogVmDVCUWMfd68Oaup5ygBFMowf0axEkXap6V0r3yABNKUGMxpGzdVvfsEyyP
	1D1wrQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc0pdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 14:37:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37e1f96b248so2888856a91.3
        for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783003043; x=1783607843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP8xgeRMrZjwY+GUgtUjwAJL9TITkBUKSSIOh8p2URI=;
        b=kK5It9yMAzRN2t0zEExikRFgnd4LVWZMv7cwK9lbardXTxSolNgr2L37S1anb2bpyK
         o71CS9VJjvd+UAeV/5RLF5dM7rebMpLXDRUVFFM5SL8j5lbT7LbBmrfprd2TsskFmnHx
         9Oa/h02DUZ0mr6rRk4uBErsJB2VQb4bxoIgGO9XWw+2rGGadWJwUIKGxwyAmcr5GO/Vy
         lWcLloW4HB0vrWEZnGZycAJUJl+wOXtKWJqgcSh3YZSCr5YdcDNUHkTkphcBDBGvPwxo
         MxRyX8t/IK3tzdD39ZIWb46hItbdko1jMyXIwhV9awwDB3wn4+l4tS6LuL5aAcbME99n
         qivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003043; x=1783607843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP8xgeRMrZjwY+GUgtUjwAJL9TITkBUKSSIOh8p2URI=;
        b=oSRbkaVH3CctyMKmUJGCp5jdAjCzWCLf+Pzs+4detSsr8/GzoPMDEjRCuUbURmekrX
         OSERLGctQsCMezx85+ZnqnRfTSum4y7LGGyajLNM6pO47bagktut+OF8qbVBc2iTa3BL
         SJEo7UCEXwKJ6Py7GNFN+LVvnrfFU+ezyQJ/nhWNheIHfxWMrJyoaByLwMUNIYRrM5JD
         OsaFd2eLHhFKpV4LQXQkwoqXaWjs9w1TRehc02VrrtStg9H70WJYzav7Lhx3/WXQK2om
         urYQwQ1/J5zxIXPXZpX9ohlq01mYtYMFfLFWvteVws+E1ed0t4zJWvSBEAYOK+AbnTL0
         z3ag==
X-Forwarded-Encrypted: i=1; AHgh+RoOxnH4b7L8ErU3Gvvhqs+WSsZn7qeFQKnEhaK+Yqp/m0wn/Y+hN1r6SgCxaG34DHUKOsvPkv2e3Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAd11ZLP7iIsD92x0iZKV93oaRIV+2YKiE1giYwPNyyOf5KpOY
	M4DCh+cS4w+xNUwDiuqnFDSWxZr1qJ7sJfbLQNXtQvGk9TRmSVHtrnkpn91FOwXWBV/XjOx9vh6
	oFCPVNSncq4Zf1ef0zVVYTd8ix+VuhTiawQ4xwnBb1r/fNWqBTjElWrpUJTYm/QE=
X-Gm-Gg: AfdE7ckmOg4VUoXlapCKUKdl20MmenNjXicF9CDrcikMfOhee/h/YYMWEYV1vgxiYF0
	PdEVkQ1bMavENjjjgPRs1l0OTdvDAWDCxWN+ZzoKlqmOU8WaDzO8p+f/fcMgqYJzbBk9PjdB9rg
	YunOmZh4AMBBoRDavXIdyzS98AZXx0a8Nk0IWtiqO59AME6ee4xUSYhuRoWEGT1VeZZWdrg2Nbf
	yByzd49AMV1PW2HFsDbF5m1dV0G5iW2LAuq0qhTj+tJ5o9Ln5xZc1Zn5T1IVRsVhbDir6qDFDaW
	Ywtc+WXJFpdAkYVwhdjW5z4TzaOP5yU4g4R5gLKDKO+Rh9BzBJGK0xB8mwj3lkrCZZ9nsc4BrVo
	gyO5kAU8zF2EsBL0PDOQHoqhaDYktweiwHpNqtO4Iz/k=
X-Received: by 2002:a17:90b:1dcf:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-380aa1c7ac5mr7876868a91.22.1783003042552;
        Thu, 02 Jul 2026 07:37:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcf:b0:37f:e326:6559 with SMTP id 98e67ed59e1d1-380aa1c7ac5mr7876812a91.22.1783003041894;
        Thu, 02 Jul 2026 07:37:21 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.110.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b4c5577sm11801265eec.0.2026.07.02.07.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 07:37:20 -0700 (PDT)
Message-ID: <4e41d5f9-1b6f-4037-bb4b-9a5cf3fe0821@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 20:07:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PM: runtime: Clear runtime_error on supplier after
 failed get_sync
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
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
 <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
 <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com>
 <04b67f29-2afe-4c72-8c9b-bbde56f27a83@oss.qualcomm.com>
 <CAJZ5v0hc5yYphPjtF8kNBTPaTaVDxq4Fdb=DRuQ953EAo-CMqQ@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0hc5yYphPjtF8kNBTPaTaVDxq4Fdb=DRuQ953EAo-CMqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o9VHk8hB2WgZUSCcBZsUJqwhxlcms2X4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1MiBTYWx0ZWRfX5o1HUeWJB/75
 2IS6PGUjUwddK4hTLOC5oPnqtfI+7VDPjp0KyEIgYEsFCvVLTG+WbLTxNZZRcOZpt/uLG/g8nyP
 567UZ8zxiuUTuCX79gUHIAf8L7JIYdXqEledNXb7McpTe6I4XrbFIA99RbXM9Ovq6+2rIf30Wsh
 /L4WpRmzHQCK+LmPPtQcz5MZUKo3p/C+0uytvA71GwTJZQ/v23TLsf3rshKcG6PFbkX58eT+/ej
 OnsN8LPT1yXGu/0B0m6dRUvDkQ9w9+jhEnkSpbfEXZ+NlULuww/BgBkWDhdiVDCrvN6p5vOsZCY
 tZAiqaNVt1dYsaTlTjWDUvJKN9wIQHWSMUIHocldPXUM/K1sIDcFT+eitUvfc0SjpR9C76ePesu
 SmLqbCy4wlXUlfO/tct0LDhZ/zd16LwA01Eozw591rkrhyngdJ7WAGBNWkJf3Kq6H+TjXXMoZ6L
 InAp38QYn3MuufBuoqQ==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a4677a3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Hw27I4OjMF0sY04QisIZkw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OjDW0bff2K29XYBzBmMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: o9VHk8hB2WgZUSCcBZsUJqwhxlcms2X4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1MiBTYWx0ZWRfX5Iil2tZe29h9
 qEfJlFSjS5Vzpo6fPcTXO/V1g7wzwP7IQrJP7cm+NFwkoc/+IhGdkFDmBZjKuI86+zZdGEFbALw
 UojlqrMCPSAY3TLzdC20VOjeTCTN5Lg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020152

Hi Rafael,

Thank you for review.

On 02-07-2026 18:29, Rafael J. Wysocki (Intel) wrote:
> On Thu, Jul 2, 2026 at 1:53 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> Hi Rafael,
>>
>> Thank you for review.
>>
>> On 02-07-2026 17:07, Rafael J. Wysocki (Intel) wrote:
>>> On Thu, Jul 2, 2026 at 8:08 AM Praveen Talari
>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>> When pm_runtime_get_sync() fails for a supplier device in
>>>> rpm_get_suppliers(), the supplier's power.runtime_error field is left
>>>> set. This causes any subsequent rpm_resume() call on that supplier to
>>>> immediately return -EINVAL at the top of the function without
>>>> attempting an actual resume, making the failure permanent until
>>>> runtime PM is explicitly re-enabled.
>>>>
>>>> Fix this by calling pm_runtime_set_suspended() on the supplier after
>>>> pm_runtime_put_noidle() in the error path. This clears runtime_error
>>>> and resets the runtime PM status to RPM_SUSPENDED, allowing the next
>>>> consumer resume attempt to retry the supplier resume normally.
>>>>
>>>> Change-Id: Id5067d09caca464f663fc95fe745d037e9c56664
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/base/power/runtime.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>>> index 335288e8b5b3..9811d024d140 100644
>>>> --- a/drivers/base/power/runtime.c
>>>> +++ b/drivers/base/power/runtime.c
>>>> @@ -309,6 +309,7 @@ static int rpm_get_suppliers(struct device *dev)
>>>>                   /* Ignore suppliers with disabled runtime PM. */
>>>>                   if (retval < 0 && retval != -EACCES) {
>>>>                           pm_runtime_put_noidle(link->supplier);
>>>> +                       pm_runtime_set_suspended(link->supplier);
>>>>                           return retval;
>>>>                   }
>>>>                   refcount_inc(&link->rpm_active);
>>>>
>>>> --
>>> I don't think that this is the way to go here.
>>>
>>> Can you please say some more about the specific scenario in which this
>>> happens and explain why it is OK to effectively discard runtime PM
>>> errors occurring when suppliers are handled?
>> This was observed with a consumer device whose supplier's
>> ->runtime_resume callback returns an error (e.g., a transient failure
>> such as a timeout or resource unavailability).
> In runtime PM, errors returned by the suspend and resume callbacks,
> except for -EAGAIN and -EBUSY are not regarded as transient, which is
> why they stick.
>
> If the driver or bus type wants to signal a transient error, it should
> return one of the above error codes.
>
> That said, I can see that this is problematic on the resume side where
> it may be desirable to repeat resume attempts in the hope that one of
> them will succeed.
>
> I would then consider changing the runtime PM core code so that
> power.runtime_error is only set on failing attempts to suspend, but it
> will not be set on failing attempts to resume.
Yes, that's correct.
I hope the changes below address actual issue. Please let me know if you 
have any further comments or suggestions.


diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9811d024d140..88450438dc88 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -470,7 +470,13 @@ static int rpm_callback(int (*cb)(struct device *), 
struct device *dev)
         if (retval == -EACCES)
                 retval = -EAGAIN;

-       if (retval != -EAGAIN && retval != -EBUSY)
+       /*
+        * Only stick the error on suspend failures.  Resume failures 
are not
+        * treated as permanent so that the next resume attempt will run the
+        * callback again rather than short-circuiting on runtime_error.
+        */
+       if (retval != -EAGAIN && retval != -EBUSY &&
+           dev->power.runtime_status == RPM_SUSPENDING)
                 dev->power.runtime_error = retval;

         return retval;


Thanks,

Praveen Talari


>
>> When that happens,
>> rpm_resume() sets power.runtime_error on the supplier and returns an
>> error. pm_runtime_get_sync() propagates that error up to
>> rpm_get_suppliers(), which then calls pm_runtime_put_noidle() and
>> returns, aborting the consumer's resume.
> Right.
>
>> The problem is that power.runtime_error remains set on the supplier. On
>> the next attempt to resume the consumer, rpm_get_suppliers() calls
>> pm_runtime_get_sync() on the supplier again, but rpm_resume() now
>> returns -EINVAL immediately at the top-of-function runtime_error check —
>> without even attempting the resume callback. The supplier is stuck
>> permanently in the error state until someone explicitly calls
>> pm_runtime_reinit() or re-enables runtime PM on it.
>>
>> when rpm_get_suppliers() fails and we're already propagating the error
>> to the consumer's resume path, we should not leave the supplier in a
>> state that prevents all future retry attempts.
>>
>> Would you suggest a different approach here? I want to understand what
>> the preferred recovery path should be when a supplier's resume fails
>> inside rpm_get_suppliers().
> Well, this isn't really different to any other cases when runtime
> resume fails.  If it fails for a given device, it will also fail for
> all devices depending on it.
>
> But fair enough, please see above.
