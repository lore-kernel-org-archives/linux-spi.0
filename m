Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762919CD0A;
	Tue, 16 Jun 2026 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571325; cv=none; b=BIEP7Z961lFzhPsU6LJxOPE20k+kRclVRpn/2DhJRl861XtL8aUGkGZR84WiaZ1mZXEHwSNGGfd1xJLJD50CrethfrqnqlfOCp9x00UlJdI06TLEL0IUySSd5GwyIoLrgLpgQR0+Dfklb3ab8Johs5IUbK8T9cU9OcSosuj6jyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571325; c=relaxed/simple;
	bh=1KFCMJZeA+NZ41B35LSi3cPHCY2Un4nFNNEnAWs3/oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEhsNXkR15dc3NyXAAV6j2vPsYqEal0W6bR9D6XTZJIxxcQrE5WSsfJakH2EEGUKuKWIyu2vf1LuvijAjB79JURTUhuCFOTqLLkh0qLHBRWUk9tvJUQRl0PbRVjfnqMEntrjGWEQrwqT01b7LH1ZiXHWzVA4+e9FQSKZ4N/Z8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 16 Jun 2026 09:55:22 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 1ADB52091480;
	Tue, 16 Jun 2026 09:55:22 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Tue, 16 Jun 2026 09:55:22 +0900
Received: from [10.212.247.31] (unknown [10.212.247.31])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id C2AE2107185;
	Tue, 16 Jun 2026 09:55:21 +0900 (JST)
Message-ID: <863fb28b-2608-479a-bc70-3407884975f3@socionext.com>
Date: Tue, 16 Jun 2026 09:55:22 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] spi: uniphier: Fix completion initialization
 order before devm_request_irq()
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20260615023415.190655-1-hayashi.kunihiko@socionext.com>
 <dffb3303-6371-4415-ac0e-488c421e2555@sirena.org.uk>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <dffb3303-6371-4415-ac0e-488c421e2555@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/06/15 20:45, Mark Brown wrote:
> On Mon, Jun 15, 2026 at 11:34:15AM +0900, Kunihiko Hayashi wrote:
>> The driver calls devm_request_irq() before initializing the completion
>> used by the interrupt handler. Because the interrupt may occur immediately
>> after devm_request_irq(), the handler may execute before init_completion().
>>
>> This may result in calling complete() on an uninitialized completion,
>> causing undefined behavior. This has been observed with KASAN.
>>
>> Fix this by initializing the completion before registering the IRQ.
> 
> I thought you were going to rebase this, why resend the same version?

Sorry for confusion.

The patch was rebased due to upstream changes.
I'll resend it as v2 with a change comment.

Thank you,

---
Best Regards
Kunihiko Hayashi
