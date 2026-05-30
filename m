Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C28347514
	for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136430; cv=none; b=uDjXty4ZZd0MtQsJZQtW4yXc9p64g4eojNIknnJmDJc0la8sIXtK2rm46XUtqiwpT66DcGmUkzqM1hvPjUgwOqWRh+DgqMZjP2jynuENjetNlZsV6cHn9YM2TvB3dEq8TrixTh8FObbKOhykcAToeaGXq3/gyC9aVgKY8Soy/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136430; c=relaxed/simple;
	bh=35VdMsjmS0v8dh1CHRiPhqq+k7uITgm7avOyoT5qusA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5j7BtxWigOdJGLWDAyRxXYqiikZFtrUspAHoJBlA54tPtLsecIkojoFH42g3/Ms1xy2Zv3raGhTwZIQbg8cF/aT5spoT0KsUBL+NKSbmaenPCFZAMc95mQdgTnOW+0v49E47rDbDba0qTKx1QQk+2nZnF5j4Ze3I35XenX+y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAItoU4o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAItoU4o"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490686877a1so46252035e9.0
        for <linux-spi@vger.kernel.org>; Sat, 30 May 2026 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780136427; x=1780741227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUCw4AYxN77fr8cBRoZeZFoHBmuyuGZ+QkqYbRydK8M=;
        b=ZAItoU4oou5vEoHAtmJijjFpXtVUrUX7XW92SJOJ3FgBfhnGo4/50sh8cySx1/TQNF
         eYerKBS8DcXIyCiazVP1tL9M04rfFfAwgBkpYE/MGDHZsFAws4aLkhJCQR1+hjhXeP1M
         ilXm9AL6BDWBvvEJjXLclEXtJiXNDKPJgjDcGRCjEDFO9XBmudhSpz6Ncu0FXOp0ABaI
         qKkRe/udZSJZ/PZF7nmEOGXMXYtwsb/dDebP9/NALd1zmetmVYSWMh6rJFOunEM6lq1/
         eO7xd484pB86lubdWTdfjEwog9ecdSzvrJyv4lZ/i6BS9b2aNtBU1+kXmOybQ/nAmn/y
         66OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780136427; x=1780741227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUCw4AYxN77fr8cBRoZeZFoHBmuyuGZ+QkqYbRydK8M=;
        b=qMORazaw08LZfvGMo+vnZACAX6gHjXvhxx2w2OmhfUzfiRZOwzB6eAFXz/L4M2iKRm
         uk9f+6fLSaUZIKQV199RwMosteyfRkIRYSRMc4uBet61jmqj6IPq4reIB10+F3RY0lSr
         rz8xArl9oxzFtlRIwjC6fK72xnnsxEV/aHXHJjqKiH1tWQ4RAXTRYGe/EBE7XPtKJzHA
         4jZh76vC6Qb7Tb7C+LgzBBEWJOV4kT+6FAuwFArSZDg4o/alpNFGWHHHGVF8L0t/hxWo
         wDqmPETXQXdXqW+lTN0qR/NtVgfUz3bWuQFfZCQaoqFwPgyUrVqoGOBKn56Wmo0iGHOX
         G+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/X4GzrHSNBCD5qUoU0TAtpp8uG3SC+Wp66tcP1kj3ieDn5frG6fs4Uqkj34jXxm0aJjmuAjeDxNtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8xpWrr3Rkt1bFwFUmRB4IMkih4egGTxss+IxjGTrUQWZRqIc
	HgHuEjqauEVb0k8k5RvmQeEZjnU1i+PYXec3hKF/maZsSFf4vhrWIJrJ
X-Gm-Gg: Acq92OEW8fmUXWmrIkCYDcp85lKSxakxWB1YNDMoovjVyOUX6GH8jTRWe9RpDu8pC4a
	TOBm8hKtVJJBfE3fc4tZMTqm3vJFervwHykunSBfMJygSGhmy9qEHfza7pKNTzzUbJsdiGTAMTE
	29LfA8M8GrDXPnDVYx+8tYIgSNShnS20Xc4q+pHkspr2xSph+7GNv7wCHt1VzxzLZRbLu0SdWoL
	biVgvZ9dlsroHEPFmH6npkBRW86dE4pwU7xmb0+MBXcQDSURQgB5PMssY2SjAnmvbIGRIv2P5f6
	18lXLTvQraMwKnlg4c850GUyjNJVYLsLqkfBExZvQVLY4XG38iGCvMzAg9y+Gz2JQ8G7wJkXSOn
	joqASvuShbY74wJT9ra/5mHsxBZLYjfiI8LcTe+27mWOuEjzgJq9jeWkG3AZ1ajxt6s22DgC+bo
	YhX/PQDxzG0eM+Lc0yyqP2TFyi3EbR+cXmdAdv8eFroj//LH+6RaTlHXVsprC9Twr+fmkIJa4=
X-Received: by 2002:a05:600c:19cb:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-490a2a43c41mr42348235e9.9.1780136426957;
        Sat, 30 May 2026 03:20:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c128dacsm31436165e9.32.2026.05.30.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:20:26 -0700 (PDT)
Date: Sat, 30 May 2026 11:20:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Collingbourne <peter@pcc.me.uk>, Jani Nikula
 <jani.nikula@intel.com>, Ville =?UTF-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, Randy
 Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] iopoll: use udelay() for initial polling
Message-ID: <20260530112025.66897837@pumpkin>
In-Reply-To: <19509a36-cf7b-4f2b-a25c-2c1293c19b6c@sirena.org.uk>
References: <20260519102446.209723-1-peter@pcc.me.uk>
	<ag23HbvCqhmK0Ph1@intel.com>
	<CAPQLkRhtdV5Whv3ZNtZ8Xwq5V0chaQ8_tUbh7VnTexezid6EfQ@mail.gmail.com>
	<d602e4ec24533aa239f04901574b4f4826640455@intel.com>
	<4e8d842d-790a-44ad-8b80-a0a8df1fde2b@sirena.org.uk>
	<CAPQLkRi1aP3N2d7GzrRfXF0xDyamt_n9AKzFvV1WdpNk0ZymJg@mail.gmail.com>
	<20260529122016.0059f55d@pumpkin>
	<19509a36-cf7b-4f2b-a25c-2c1293c19b6c@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:56:23 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 29, 2026 at 12:20:16PM +0100, David Laight wrote:
> 
> > I think I remember someone saying that the spi hardware interface normally
> > generates an interrupt when the request completes?
> > So for spi this is only fall-back code for a few systems.  
> 
> For something like spi-mem I'd expect to have interrupt support, we go
> all the way down to fully bitbanged though.  You also often have
> copybreak cutoffs for smaller transfers (and quicker operations) where
> it's more efficient to poll for completion than use an interrupt, or
> PIO rather than DMA.

I do wonder about copybreak cutoffs especially for systems with iommu
(which has started including x86 systems).
Many years ago a colleague got a figure of ~1200 bytes for a sparc sbus card.
I suspect that the iommu setup code has got more complex (and slower)
since then and the memory copies faster (especially if you can do overlong
aligned copies that include the required data).

For spi-mem writes (max size is probably 256 bytes) that take 100s of us
it is best the sleep (for timer or isr).

spi-mem reads are another matter since the only delays are those needed
to bit-bang the physical device - which might be at over 100MHz and 4
(or even 8) data bits at a time.
Possibly worth using DMA for the data (to avoid leisurely PCIe reads)
but polling (ideally host memory) for completion to avoid the cost
of the ISR as well as avoiding context switches.

For the much slower smbus and i2c you pretty much always want to
offload the 'bit bang' to hardware and wait for an interrupts.
(I've seen ethernet drivers 'bugger' the system by repeatedly reading
the phy status - that could be done 1 bit every timer interrupt.)

> 
> > The code has this comment:
> >     /* Wait for the write - typically 0.6ms (max 5ms).
> >      * In spite of the datasheet values, I'm seeing 200us writes. */
> > It waits 200us and then polls every 50us for 2 seconds.  

FWIW I wrote the comment, the code below it, and the logic on the fpga
that converts the PCIe slave cycles into signals to the memory chip.

What I/we never resolved was why some chips/boards failed to act on
the 'read status' command issued after the first delay.

> You can also get fun with things like contention on shared buses.

Indeed - and in places you don't realise.
In some cases repeated reads of a slow device can restrict bus throughput
enough to make DMA requests underrun (eg trying to use an LCD panel on
a SA1100/SA1101 strongarm system).

-- David



