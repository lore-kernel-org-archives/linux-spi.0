Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8C4C77B1
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533699; cv=none; b=sLIyeAYf1t7N9Z3PAjY7xhx9+tP6jMjaZ85cagW5Zoe/lbnR0JjjtDZWaKbB+iwutQPKv72RBSTiaJ3kL52HrfhgFlg5FvR9LeP6oQn806KsKJ5qm68Z8gmfOPYSDVKIDyJfRDEIsPEeMjxCyo3n0lmNnJxLybwCqwwSHb91P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533699; c=relaxed/simple;
	bh=tw3o8L/Ww5WvITfoCOwxS7zP9rGFEqpVzq93fHL+pzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R39f4BiKyHTrnBqzSIXUAjj3XByHOsSCrjbHFWOvUce/GANhxAJ4QzEJJiZberA+fzpWvpvQPjy6OUURhbF3syfhFo+FBf0Q5Q3DSnGjTI9qKp6D+PCE6R4NW2g+0cO9b5r2vDLwYVIAqO34MKAptI/xRdhjPVJpKJXwsFBh2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D078rgMG; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D078rgMG"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bf88d3fc8fso28188e0c.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533696; x=1789138496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B46jY7pDsSOgAsSWPgzfJoCgRMQsU/kFbgxSGzI4vaY=;
        b=D078rgMGWa0t8wxmPdIzxiblXUSqTA4NC0gRZ/6WgPd/FSQQtzaxZPCYmxROXJg+A/
         +A4/eTggm6mpWOsdmUnFAZ7LEguk6quO6y9jXpzIaRPHsi2fTtnDZ1ZBxn3/g5kc5ugQ
         rTGgQxapIYf021/UGIEsN6anFgs7ak9Q0p/49KcunFPSLLnCGqdjw+LXfKE7toG6PE8z
         oAXxDPeDE7leNcD2RfM5E65WDrDQCHbmD/ZE5Qje7w2VTd5LmgVhZKP4ENI/bpw4luVx
         5YFyD3j9Ka5zRi3iTCVkSeX6Wqxqy8NUypyKdVNcaV4v2vn9APB430SzOn/osnoli1Fn
         O8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533696; x=1789138496;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B46jY7pDsSOgAsSWPgzfJoCgRMQsU/kFbgxSGzI4vaY=;
        b=gmKUmsl+MB0VlRATPQ6bDgUHdhjp3NKzJDpLP71lLbFVntyjwQk0vqS2BI+Z1ejUS0
         D4TbM6hdW2kXM3Hw5Czu+60b7bKihTnIVbI5m00df0AYQxNsYirU0QyMpM/0zrjpIiQU
         MZXVimPQK72vL6Rv9AIeFyDPJCKt4wX8fsP8i7pMgx/rfWbAG0jtN7k6FxCk+pkmPdCN
         M+GUrDusT4/nZQ+eYFzzf7Dc08IVpNX+JDNjO9Ze8zYL7VVj1LLpS207wADlGvkUeYTs
         3ezq+C5FNE13Y7GMdzn9ahd5FEhY59XyXxyaoDfdaYfs4BItlxDDuQXfmWtBh5bkATAc
         f/ug==
X-Forwarded-Encrypted: i=1; AKwUvBzderZ6Ra0YS/2dh1U6REJHqeT5nwDLEhEV7NzKkI30KuUooU/3+4qd5+qls32+6WDKs22DAxRfKUc=@vger.kernel.org
X-Gm-Message-State: AFuF++lhXQeZUqhSUn9VXcBU+osIK8f2xBjS70uRdu97La4d05/CyIcZ
	7VecSfvZuV+2cwVi9KpSnEpB9oMiTboS0EEdOrAWpT+R5HCNWeMiiaCem5zNND9f
X-Gm-Gg: AYBFou3kvtkSoBcv7hOjpa7VS5AK5NBNHPx3GKCN6WFA8lknmnzRx7rnKdZbFCop8uo
	Dx48h4RtaVyRsDDuWqHdC0paZrlu716eUVnk2qxSlfI12ydB94QOLZO3Ai7fUVNAkDOpmUdUvLe
	SeyRVRP2gd0G/zARXeXy+3tbUp/hoo7Sgas+6xIR/7wwht+A9FGyChvH4R8F7bjt9liSerWiskw
	LfhM7o9ZDw/2dzoHb5TzPFrebHrHOm/L4h38n2EZpKFXTdZ3xpsOegvMvL8wq3sWNlI/jlBC7kU
	09VaEv9fxbaRTVa5iQxBnaFVzel1gV0nQMZ8T1qBKNmUQhFa31E0/qjswN8+Fh6wZ5uzXK48Uic
	TmZSbj9ht+F7G06mJyqpWTN6Ds8n5wIOTghq6VfI2Qx4z5+0PhRT8UfyzUaYvfcCkXgSezPqeVB
	Imxw87GUpvZ61UmVlG3U280u43M7kWzwF80QaBrd9RbIKttugH0f4w5z6/59vipoZxVyEWOVcZK
	6ow
X-Received: by 2002:a05:6122:6844:10b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5c7ed1037fdmr799052e0c.0.1788533695976;
        Fri, 04 Sep 2026 07:54:55 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.23.4.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee1c0cdsm1742230241.8.2026.09.04.07.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:55 -0700 (PDT)
Date: Fri, 4 Sep 2026 11:54:49 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	dlechner@baylibre.com, broonie@kernel.org, nuno.sa@analog.com,
	michael.hennerich@analog.com,
	Dennis Heinzel <dennis.heinzel@irs.systems>
Subject: Re: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-ID: <aprbuZJfgKkSVakJ@JSANTO12-L01.ad.analog.com>
References: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
 <apmFOKpncNJtrTF4@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmFOKpncNJtrTF4@ashevche-desk.local>

On 09/03, Andy Shevchenko wrote:
> On Thu, Sep 03, 2026 at 10:49:22AM -0300, Jonathan Santos wrote:
> > spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
> > it was parsed by the FPGA, but never clears the corresponding interrupt
> > pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts
> > and INT_SYNC is enabled, that stale pending bit fires immediately, causing
> > the IRQ handler to see the leftover SYNC_ID from setup, match it against
> > the current transfer's ID, and prematurely signal completion before the
> > hardware finishes.
> > 
> > This race manifests at low SPI clock frequencies (~2-3 MHz), where the
> > FPGA takes long enough to execute the transfer that handler is parsed
> > before it finishes. At higher SCLK rates the transfer completes fast
> > enough that the issue is masked.
> > 
> > Fix this by clearing INT_PENDING[SYNC] after the polled SYNC, ensuring no
> > stale interrupt is left pending.
> > 
> > Reported-by: Dennis Heinzel <dennis.heinzel@irs.systems>
> > Link: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz
> 
> We have a Closes tag.
> 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> 
> ...
> 
> > +	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> > +					 reg, reg == 1, 1, 1000);
> 
> While at it I would replace 1000 with 1 * USEC_PER_MSEC
> 
> > +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> > +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
> 
> In both cases? Error (timeout) and not?
> 

The error (timeout) indicates the SYNC command was not parsed within the
deadline, but it can be executed at any time. We consider the timeout big
enough, so this is unlikely to happen. But in any case, the cpu command to
clear INT_PENDING is harmeless and can still clear the interrupt if the 
SYNC is done parsing until right before this command is executed.

> > +	return ret;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
