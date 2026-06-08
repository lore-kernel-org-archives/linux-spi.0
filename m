Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BA36A374
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918910; cv=none; b=CN0Zoup8B8hx39cn8SkYZ6etbP+J/esRiJQ06UgFgnnWvbHGVedstrlXVDTIgymKVnB6ze5o2WNu5vEHieU620MluGuCsgLL92bfdfq3wo4iUOq4ui13eTpuRrwMZG9HrR5JwgIfvtz1//XUUjoVgTr2j6Thj2A5UH8pTPU4QH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918910; c=relaxed/simple;
	bh=1M1RcBRd4la/fLxNsDGz3QeC1KhXloFpR5ofR1BWNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAc8Vfy3Il3UWIwAgP3M0/fshIhGAeH5ipoyUBsV2YFPNLbY02ooJkFpMembmx8wExLtk+ZLmKqQ/bkq8kXMAvetGDfG1ITmHZHrDtvxskjloz8NeUBjkhYGG9WpEIych8krfqfPHx5TDSw0SumgMUUYOvfXM6aLiGOqxa+xmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sN0IjegV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sN0IjegV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36da151a152so2893687a91.1
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780918908; x=1781523708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M1RcBRd4la/fLxNsDGz3QeC1KhXloFpR5ofR1BWNrk=;
        b=sN0IjegVRrRw/BfpBmA79sm0fUlQujg99Paz9zErA3EtuhJv7M9cJUlCnXKw66c6p9
         MuDf30S8v5rq3d2iT+1pqBy3p9pqD1v47pJYTly+3NZMgGsnaJ7dtQU0xL3o9L7hbx0y
         c1WhA5Tvxr/JhojfYrZ7ncCdZuo2B9b8PEiLwrtGbjQbk8oc0UXxvzVdf336w25kXHfo
         UVbK9NWSIP9BTdIvh3WVRqO6MVpE5+oHRLSpYtm/QHeJgpbHxzjQvDo6mG0BqwBrKrLC
         LrEfjtfZ4JmgPugXtiZCIrahaZEz5zBDvUfImslEpKgwbCzdeUJpaWUC8zJc9Ry8DM7P
         ZFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918908; x=1781523708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M1RcBRd4la/fLxNsDGz3QeC1KhXloFpR5ofR1BWNrk=;
        b=pcauL1iJ1A7UsQ5LvAu6kYP+/uGdtFVdPfKc7im9xMMFwPtJSGFarNO9+47IvYDnoG
         Kh3PtaH3beaO3xNEez9WVNOhtDwdrS/ZBEMItuotL2Qj5hNiwAh/S4hRTheq4KCxZ15q
         rP+cRe/tf1uwc/UTPlp/odkjzYD8Id+cWND13mfC6FTcDXTP6bQAPYdfkeWkRSRuJQoh
         MPqq0O51XmhFNRT0KpKp7wy+L+i7UgYH88oxPNdtYHx6MVulAJdz0bytsmk0ok0ognRo
         l24TYibUgZ46CFHo8Pdz6yddEWcqx33qsA8Rz29Uub6toEWkh1Pel2/UZFll54tvEUPj
         3wng==
X-Forwarded-Encrypted: i=1; AFNElJ8L8YkjKcK/O7W6PrCxk0oqf/TpsY98LExC9AI/apbq/S72aMFs3X9tu/ad8C39FviGfU/ALwOaqp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMtlQfstlGYBldajRYxt5VfyP00rFVLe8nOB5JvkgILFGMxVu
	MWy2nWulN1mCUGx7dF25xI0z5jwSka7Rnk+dqghLo+3AVjKg7dEUwPYI
X-Gm-Gg: Acq92OGELspdWKlKHOW21Hs+cyd4ay8UyMPKeVsU4wmoV6vbB8JPBrWpdt2vaMtkGd+
	TRR+CIwAZsjU9ujkq/EmxHGhE2gNST0JrzpOMccYtB7sXS38gsWXoZvYLoqZX1xV5klaMs7/76o
	o8xmFfiBR1Hfal2NuYqk0mCpaoCCRAUNKSZMehMwl8AUyfQFmbfAxMaMl0VdgQIOiBQ4zO4SQ49
	0zStaunLyDnofb1wkfT2XxADnif3gyhG4KQIaCh97nEePwaDoq/9ItPOPHK+aScLLyy1YjFU6eX
	qBZfH+cwkUTV/rTn90s/iDCP2/Uk8Pf7OR/f1gW1k95FE8Fk4s/RCeaDlzmgK6yJeq+mIBsRTP7
	Lb4ld7c3ZzM945RYqxhbtT3JbWNHCzVH7h1waC+ODa/wfAqX+h+Wa/XIQdekbllz5pz++nQYQM7
	iwWVVcIbLmS8t51bqrILcPmoJkuRLzbNfCi5y5Y976sQLXtCtgq1xP1DhMF1zdcbN/cChO4ihWl
	jqbxFHhrtEoiQ==
X-Received: by 2002:a17:90b:280c:b0:36d:70c8:3a1 with SMTP id 98e67ed59e1d1-370f0480fb5mr16381695a91.13.1780918907971;
        Mon, 08 Jun 2026 04:41:47 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb3a9fsm7074534a91.0.2026.06.08.04.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 04:41:45 -0700 (PDT)
Message-ID: <c8df1abc-5764-4ff5-9229-f3ac9bd73a6e@gmail.com>
Date: Mon, 8 Jun 2026 19:41:38 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton
 MA35D1 QSPI
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260608025009.1504971-1-cwweng@nuvoton.com>
 <20260608025009.1504971-2-cwweng@nuvoton.com>
 <20260608-aquatic-alluring-asp-b5fcb6@quoll>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260608-aquatic-alluring-asp-b5fcb6@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thanks for pointing this out.

I will fix the DCO mismatch in the next version by making the commit
author and Signed-off-by consistent, and I will also make sure the
send-email From address does not conflict with them.

I will rerun both checkpatch.pl and checkpatch.pl --strict on the full
patch series before sending v3.

Best regards,
Chi-Wen

Krzysztof Kozlowski 於 2026/6/8 下午 06:02 寫道:
> On Mon, Jun 08, 2026 at 10:50:08AM +0800, Chi-Wen Weng wrote:
>> Add a devicetree binding for the Quad SPI controller found in
>> Nuvoton MA35D1 SoCs.
>>
>> The controller supports SPI memory devices such as SPI NOR and SPI NAND
>> flashes. It has one register range, one clock input and one reset line,
>> and supports up to two chip selects.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> DCO mismatch.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
> Best regards,
> Krzysztof
>
