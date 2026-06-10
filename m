Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2A40E8E2;
	Wed, 10 Jun 2026 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099832; cv=none; b=TRB2jeD6R26GYY5EcQVf9KgSWY8bW9ryUS0fuXQMqUJmsaRoGgMSwkVnnlOCsfQOKukTdwElIDjFxNORdbpNRN7rEMQWjaZIvYeYEpS4r3LomVVQ5Gv51T5OWWMhBSnn+ygc52LQi3UlOD8NU2jXpnDwOehuAT9Z9OeQeVrv51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099832; c=relaxed/simple;
	bh=s8oLbEHNwPN5WX0VrFfQdKOs4ykZfwvm9K04jQ7sIcQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GsgZk1Zx2uf0NJakfKiX7GgSWbGYeYzwwYKf+B4RgGAFdahvwgvi7jkaULEU64HD8K2/vQ/HUko54MVSkyB6H/NdsvkAjDnJpi4n7fVkwZcsS6rpCMTFkahRdnExSnC4FzdEr+rk2sNbgn9tJfvFzem3V18IbreW+anlQPIWasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmcQeluZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmcQeluZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EEA1F00898;
	Wed, 10 Jun 2026 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099830;
	bh=4AXF4TiGWRD9gssnSZPpvDBAiuDASCdIK20Xtb8YYC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fmcQeluZlsBtVz47/xZCWVIIkhZfpEfMjEEBzMF76HjuDdKXVrOTNK2T1Sy/mH/v5
	 +I0DkJF/IXCa92wEUJ2N5CLYu343kBcAh2o6QrOZdYUDdgM7TMpj1li679igMb1AbM
	 W41jHIw1ozr0CYgwiJWPJ6zyhwVjrlKok3rBsrXMzydjS7qJav2BTflUeJbTH/nGGp
	 e5mHSf6XkdN9f9jFYiKOTUfqbZ7IU3dcFqJamfmcf3U7r0pqrEg/2Es+i44mLvhjl2
	 DwSM34f/kkQs3RcgfQbI57SYKWmk2lel1vjj/2WAZ6JLDTS2q9/0UuaNztIR1H4Azn
	 HwERQ5H1kr8vw==
Date: Wed, 10 Jun 2026 22:57:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: Mark Brown <broonie@kernel.org>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sangyun
 Kim <sangyun.kim@snu.ac.kr>, Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: spi: uniphier: KASAN wild-memory-access in complete() on early
 IRQ
Message-Id: <20260610225705.37b09a7f876e5ba07757377a@kernel.org>
In-Reply-To: <20260610115622.773149-1-jjy600901@snu.ac.kr>
References: <20260610115622.773149-1-jjy600901@snu.ac.kr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 20:56:21 +0900
Jaeyoung Chung <jjy600901@snu.ac.kr> wrote:

> Hi,
> 
> uniphier_spi_probe() in drivers/spi/spi-uniphier.c registers the
> interrupt handler uniphier_spi_handler() with devm_request_irq() before
> it initializes priv->xfer_done with init_completion(). If an interrupt
> arrives after devm_request_irq() and before init_completion(), the
> handler calls complete() on an uninitialized completion, causing a
> kernel panic.
> 
> The probe path, in uniphier_spi_probe():
> 
>     host = spi_alloc_host(&pdev->dev, sizeof(*priv)); /* priv kzalloc-zeroed */
>     ...
>     ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
>                            0, "uniphier-spi", priv);  /* register handler */
>     ...
>     init_completion(&priv->xfer_done);                /* initialize completion */
> 
> The interrupt handler uniphier_spi_handler() calls complete() on its
> done path:
> 
>     done:
>         complete(&priv->xfer_done);
> 
> If the device raises an interrupt before init_completion() runs,
> complete() acquires the uninitialized wait.lock and walks the zeroed
> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
> return false, so swake_up_locked() dereferences a NULL list entry,
> triggering a KASAN wild-memory-access.
> 
> Suggested fix: move init_completion(&priv->xfer_done) above
> devm_request_irq(), so the completion is valid before the handler can run.
> 
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> 

Good catch! All resources used by a callback, should be initialized before
registering it.
Kinihiko, can you fix it by reordering the initialization?

Thank you, 

> Thanks,
> Jaeyoung Chung


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
