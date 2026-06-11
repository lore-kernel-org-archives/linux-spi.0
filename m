Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356122DF142;
	Thu, 11 Jun 2026 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156011; cv=none; b=oYqt++li5UxmyD6WIbGBdJhU7k2pE32i7aFqQV4ZLz2hrzE5aBP+AFx8KstzF8srCpHX5N2GgKLRe1r1qch2tWvabxQt5bOb1/XxocToiYTagXkc8liflL5vSS89ei3H8/lmOvdLx5pQVBNIPux5uK0L7dqP+v2bmYydB4NpWmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156011; c=relaxed/simple;
	bh=5aFwWi9VmwlzvMqFCCzQnJnz4qC1nMXW5GA7UJT3toI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwKvIxA75jJDVxYlVDd90eKWNkXFJ8Kc+Rssi5hwbKMVpdwU+Uq4xYdXWEHp3NCJXsxo7CBLNTNzMxuhRc+xW1Iv6hN+mQmh7TFv41O+8RwdT2+luvpW9otkWEsFH+YSGtg2FRX5FWX7iTAla8aZaUH8OeHgsARqJFMz9FLwJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Jun 2026 14:32:17 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id 672322068E61;
	Thu, 11 Jun 2026 14:32:17 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 11 Jun 2026 14:32:17 +0900
Received: from [10.212.247.31] (unknown [10.212.247.31])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 051C3107185;
	Thu, 11 Jun 2026 14:32:16 +0900 (JST)
Message-ID: <c1c09630-d01f-446d-8924-6057d7824191@socionext.com>
Date: Thu, 11 Jun 2026 14:32:16 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: uniphier: KASAN wild-memory-access in complete() on early
 IRQ
To: Jaeyoung Chung <jjy600901@snu.ac.kr>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sangyun Kim <sangyun.kim@snu.ac.kr>, Kyungwook Boo <bookyungwook@gmail.com>
References: <20260610115622.773149-1-jjy600901@snu.ac.kr>
 <20260610225705.37b09a7f876e5ba07757377a@kernel.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20260610225705.37b09a7f876e5ba07757377a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Jaeyoung Masami-san

On 2026/06/10 22:57, Masami Hiramatsu wrote:
> On Wed, 10 Jun 2026 20:56:21 +0900
> Jaeyoung Chung <jjy600901@snu.ac.kr> wrote:
> 
>> Hi,
>>
>> uniphier_spi_probe() in drivers/spi/spi-uniphier.c registers the
>> interrupt handler uniphier_spi_handler() with devm_request_irq() before
>> it initializes priv->xfer_done with init_completion(). If an interrupt
>> arrives after devm_request_irq() and before init_completion(), the
>> handler calls complete() on an uninitialized completion, causing a
>> kernel panic.
>>
>> The probe path, in uniphier_spi_probe():
>>
>>      host = spi_alloc_host(&pdev->dev, sizeof(*priv)); /* priv
> kzalloc-zeroed */
>>      ...
>>      ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
>>                             0, "uniphier-spi", priv);  /* register
> handler */
>>      ...
>>      init_completion(&priv->xfer_done);                /* initialize
> completion */
>>
>> The interrupt handler uniphier_spi_handler() calls complete() on its
>> done path:
>>
>>      done:
>>          complete(&priv->xfer_done);
>>
>> If the device raises an interrupt before init_completion() runs,
>> complete() acquires the uninitialized wait.lock and walks the zeroed
>> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
>> return false, so swake_up_locked() dereferences a NULL list entry,
>> triggering a KASAN wild-memory-access.
>>
>> Suggested fix: move init_completion(&priv->xfer_done) above
>> devm_request_irq(), so the completion is valid before the handler can
> run.
>>
>> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
>> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thank you for your report.

Indeed, if an interrupt occurs before init_completion, an exception might
occur depending on the status.

And I also confirmed the detection of KASAN using pseudo interrupt call.

   BUG: KASAN: out-of-bounds in complete+0x74/0xf0
   Read of size 8 at addr fffffffffffffff8 by task swapper/0/1
   Pointer tag: [ff], memory tag: [fe]
   ...
   Memory state around the buggy address:
    fffffffffffffd00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
    fffffffffffffe00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
   >ffffffffffffff00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
   Unable to handle kernel paging request at virtual address efff800000000000
   KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000000f]

> Good catch! All resources used by a callback, should be initialized before
> registering it.
> Kinihiko, can you fix it by reordering the initialization?

Yes, I'll prepare to fix it according to the report.

Thank you,

> 
> Thank you,
> 
>> Thanks,
>> Jaeyoung Chung

-- 
---
Best Regards
Kunihiko Hayashi
