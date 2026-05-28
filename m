Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1CA3AD527
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960463; cv=none; b=eeh3FmOvfBVpRDnc/BA1WN7iKdkb5Wnep4ebYaWc1FUkY4Ks6mF8QFw3Sy6xvSYGRio8+V0+xilJJbhE4gdo6VQT1p7mial9LQE+b7zQFY5XP2mvmGfFVh0XiwdgFZAzJkFpQVeS0OcjPWFwu4rA4tXoB2QqsZym9UW2uuzNnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960463; c=relaxed/simple;
	bh=XdBSUg9eFlABJMaUoqozr7F+IqqtjOkM6/VxB0P+ZWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oh45930F3ci+mhyyA2TTs9FO1thfacw+ybjMAN1H/dBedFMs6bJd2M9P0GOVt4I9wDjQfbgSSYiExRLHIlMKxg9c5GF5jfoCxnGkQGjVvOOt6VtLP9akFNtAeaXHhvNQYELTaGj39ERtqaQzuI5b9fIdvj/ssGWpJCqp6JNhTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDDZmzOS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDDZmzOS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 099ECC62445
	for <linux-spi@vger.kernel.org>; Thu, 28 May 2026 09:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D479160495;
	Thu, 28 May 2026 09:27:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E5DC10888054;
	Thu, 28 May 2026 11:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779960458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XdBSUg9eFlABJMaUoqozr7F+IqqtjOkM6/VxB0P+ZWc=;
	b=QDDZmzOSM6P0VJbKo7CzRTESxAINRNqzZ/PLcih2H1KXTDGYUODIdon72wOry2DHIif01z
	OK8cMrqBO/d2576mPe4Sk+OiVRC85r8dRvnDw6VU2YsCmRYL6lGBE1nlShGGpWicFVnQ24
	xAwMjTLlZkgMIAkum6TKboxGE4EW1OQBsmd0DeRNDh+htqgijW30P5y5O6pKIL+lDXa1KJ
	o2MJq/G5YcSZL2qBFMd2gK32s08fqI0y/eKe2OrtZzE3kQH1DAuHOVapg9PFj7tavplrGv
	pz4C+I2vcAbNetEZSDl7tSBJDymtRCfHPE0epMzLdFxMWjfTWB+sM6tqyyhzUQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <xtydtc@gmail.com>,  <vigneshr@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: avoid mutating op template in
 spi_mem_supports_op()
In-Reply-To: <20260527173736.2243004-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:07:36 +0530")
References: <20260527173736.2243004-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:27:36 +0200
Message-ID: <87h5nrg9yv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


> spi_mem_supports_op() accepts a const struct spi_mem_op pointer but
> casts away const internally to call spi_mem_adjust_op_freq(). This
> mutates the caller's op template, which causes stale max_freq values
> when callers reuse persistent templates - subsequent calls won't
> re-apply the device frequency cap since spi_mem_adjust_op_freq()
> skips non-zero values.
>
> Fix by operating on a stack-local copy instead.
>
> Fixes: a4f8e70d75dd ("spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()")
> Cc: Tianyu Xu <xtydtc@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

