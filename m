Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789052DFA3A
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500393; cv=none; b=RqYMSgrF2JaXXElJl/LxKuSS8KTYtprGS3HGMIWcpcVjrTk2QLMdCBxH4AldPnFIybHiESCZ1yl6LkW8Yt7k2DvtY1x8b0JihT2tQD6qp+8d+hk15wOZ5b692PvsqRUTN5REm4gIOl/fK4lc360BgtCvpLnOVedqXqLPCOqn8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500393; c=relaxed/simple;
	bh=emINAwhEdkfsCilu9nNqVofHlxVuxUp5a2dwzajD+DU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PKs5//+DoD8oEx/5q3CUxAa8zj9PsEKfJxqWvxUiyILl6xq7RlIwvz0XTMjdRJfNdIPYbKyi8EvnBd9ugxv50XyUIlpq95W6Xy5D6pGOPE4aY4p2EHAOsjRWAM1PHUFMutgh3V/nZIsMcQSlotzSC0YAwBhaQu4Z/MBSDn3i25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdgVV/4k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdgVV/4k"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842307473b5so2085467b3a.2
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 22:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781500392; x=1782105192; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRhvIeiIyul2AJsnx4A30gTmufAraYOArEgk4zzsBJ8=;
        b=sdgVV/4ka2LaW25BqDp8sBA1eiPwgAzwhLvA3ghmyIPd/O/qMlWHXR/ChUCbdGoyB8
         Pjbb9ANO5IoMmkdDl1WtRe9bpCp/qZEo8TrBqnV8iTqnWSfzEDY16s1SUQ/5xCJPlWsd
         pwgRCaW3wpnMeaO3BhofZc7o3xmOsdnP5XK+9EnhWqwKLCRtH8ZAzl1ARcfyJqmqOo8I
         MfjPMG7IcGjDBo8UpX/q2XPq59CNFIH+SL92I5BpOuT0+uqtbEsSY7rU9m+e5gX/q7ur
         Tn87xcVPRvEBt0uCy7wUhNzzSXJYg6i91WB46aQyNQEOrTsNZR16z8MDtItykekbHEkE
         miBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781500392; x=1782105192;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRhvIeiIyul2AJsnx4A30gTmufAraYOArEgk4zzsBJ8=;
        b=jCTBqOMhACSmQ4k1Z7I1NdjWwCMa0R/I9bzFBRRW7RlnNTust0Oe8XrD8o4cGHRoUB
         OhBP4EWA4MAKyYwqe48EsF+fcxPKQxVsGwLOUcCwNMdW261Os6+tlTQ+Ofds/94kZ8GF
         Jk+3H+0N4uyf1/pS2SKHfpEuvZHgoxCpVH1lKm1nqWqME2DxF2uFUVbf2T30T3BgQStu
         YcJOOJBk6dSXC+KbH6qKzflAAiDfGSFfg29EwfNPXwgMj0faiOQoy3TyO1kJnQW4HmWS
         UGVWUcbpHXF24Y7dLnVwjQE+E+GzmdIo+rPhxmPJJJzqDq7BcxvdduNa/olSZPn2mVpE
         SPDw==
X-Forwarded-Encrypted: i=1; AFNElJ/v3S4A47YZo7R08DhYNPYJedM58KPBkb1/oqXOhVqI9ZvUNu2bdapIdKw+DVFLNevkEZYTi5hxdyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2RdUkMJaSMVIk6x9soRGC+POvdxYUsOdUtGxYfEDn+RVwQz5
	mR2sQhZ8VWPKLYVBfG/dO5mS5g2XUrRMFO9bcbcqL+ZsY6UdORvQNMIE
X-Gm-Gg: Acq92OHthKbIrsPSb8QuhQFvcumU1IxQGLSOZqln4lKPC9GVWosNH5R73/UeeJHT2Tn
	AC3iR1Pj5+n7jc6STTAGBpEVdDLa+bUvN0oGCQ+4+/13M4AqY30Ztn+T0mE+KNCIJcxZXOC0NCh
	0lMwXayeZKi32vdprF2+5zsL+9TrdblqrxxJn1+0vdlxnugfBTNoJauSppAvcn1qWz5VoM1nyTD
	e1LxhkxiJe7QqwdnEWKZGd+N+BBegxjqlcKfgn5Bzt6JyCAG7s8N8OQOPl9oYO7KZCOViOdr6yS
	N5dIeLTRHUcbLKcfuT0rv7kA870gbrGIV2i21HaIjwtVq9aFCoo96CGVfuLKAoMNuvA9sls2eMf
	XBkYGIJ5YHOWJ218z3t+8GgafBbZrOnYLOMcKJTaFqzIStAokt+tnDrhT0D7qsHgDDilWU7vFTB
	Q4OgHXCOdWaHfJ7uWxye311/J2KPh30GHQ2QSUyrq0A0iLMmIQBaLiwmRjrBRFdkuyjMxZUutYM
	l/mngJsyNAtQdNxqV+QRMU92+AEXLKkPpHRi+yx
X-Received: by 2002:a05:6a00:bc8a:b0:842:3029:6b2f with SMTP id d2e1a72fcca58-8434ce8cfc5mr14414930b3a.33.1781500391703;
        Sun, 14 Jun 2026 22:13:11 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:f7d6:b126:ef49:527c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b02268bsm10092227b3a.46.2026.06.14.22.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 22:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 22:13:10 -0700
Message-Id: <DJ9D6KW9FPM0.1KCC9UK5L9YR@gmail.com>
From: "Rosen Penev" <rosenp@gmail.com>
To: "Jisheng Zhang" <jszhang@kernel.org>, "Nathan Chancellor"
 <nathan@kernel.org>
Cc: "Mark Brown" <broonie@kernel.org>, "Rosen Penev" <rosenp@gmail.com>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org> <a723320d-20e1-4e5d-8a11-d63f84bc8f69@sirena.org.uk> <20260608180927.GA2211222@ax162> <ai9_1ZrxD28xE-U6@xhacker>
In-Reply-To: <ai9_1ZrxD28xE-U6@xhacker>

On Sun Jun 14, 2026 at 9:30 PM PDT, Jisheng Zhang wrote:
> On Mon, Jun 08, 2026 at 11:09:27AM -0700, Nathan Chancellor wrote:
>> On Mon, Jun 08, 2026 at 11:31:33AM +0100, Mark Brown wrote:
>> > On Sat, Jun 06, 2026 at 03:26:04PM -0700, Nathan Chancellor wrote:
>> > > Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
>> > > allows this driver to be built for 32-bit platforms, which causes a
>> > > semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Supp=
ort
>> > > 32bit and 64bit slave dma interface"), as readsq() and writesq() are
>> > > only available when targeting 64-bit platforms:
>> >
>> > >  config SPI_CADENCE_XSPI
>> > >  	tristate "Cadence XSPI controller"
>> > > -	depends on HAS_IOMEM || COMPILE_TEST
>> > > -	depends on OF
>> > > +	depends on OF && HAS_IOMEM && 64BIT
>> > >  	depends on SPI_MEM
>> >
>> > Why combine all these, they're not obviously related and HAS_IOMEM can
>> > be turned off.
>>
>> This is just a straight revert of 0c5b5c40dc31, so it is just restoring
>> how it was before that change.
>
> For the long run, it seems we need to add guard for the marvell support
> code, then I will solve the readsq/writesq on 64BIT. But it's too late
> to add new patches now, let me do this in next development window.
This sounds like a great solution.
>
> BTW: d58ecc54bb09 ("spi: cadence: Add 64BIT Kconfig dependency")
> introduced the 64BIT dependency.

