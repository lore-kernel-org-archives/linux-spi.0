Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13437F8A4
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327144; cv=none; b=dBnK6s/HQmZl2Q1f7CYRzCzzoAW4D3Yo9WqFfBOt16FYWfvtBPbozNMmFcchztlfDsM+sCDx6KVcVSAXY0EPNiBJIDB3suVmFiDFIEZ3hsBX2iaJFehxPJX3gIgr/pJEnB4z0mv45qB0dvxScCYgXn+/MLSqCg/8X2w52iARnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327144; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6/G8bY1DjqEYqyYsIoUtTNR0JzAzQOo/cyLAxlbykKUjGyzlLrJ5xgjoagV0Ky71MkJUOxUkyF2+yztHoPtYvq/VSm2SQnsXflt0uAyqekaR3ICa5u6hg+KC7+JH2QqmUq5JJFYnr9fJXTVOqa47jMHeW+Gm2A6q1OK4FzrkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g9LK/GwI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g9LK/GwI"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10760394a12.1
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327141; x=1777931941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=g9LK/GwI1KFVZ95SQXA7y63HdW17w0PobflmoZRU8/iNk2bHgx++PwQopzx2lx4tWN
         PAe7fvOsZ0BM5mL/kcggFl5A7nKLkOgP6+A0iiFAiPOZvy+fKJJOT5yNygd5z1BbVgox
         +Yre4VZ0QahPIwdIID3NdP14UHIW0ULRXd4eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327141; x=1777931941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=Jv8BCRIc5U4hI3+2DpTeDXLfRkvzSpjRKTN0mPZMIJUKjuWW2oPdz13OhH3UgY0isy
         5m3QqCDNTsjlNnK0Vc00LfFjNj4Kbvja2MwrgfwEFJzNCPKo8rztUl92LIWSCPkMGwJW
         5/C5sQjWHENQO/gr/atAKdPCYZ2HVoY1dlqROD877jTu9pFy00fV8EGgnWI4y9UMc81c
         5IQ0iOG0JR/lzbVXs6bxI0yuXwUc4P/gimCUiAVLqh3jlykj8IiSdqD90LAx3oWYpKYD
         YIWEFmjYlgiNQEot/dE/gykp+BOzvSew+YfKAhgNcSNgP6SXOttNo4B8Xfhe885E5Xja
         7l5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/RjDB74OwTngrCEDYPQKDMIneqAfydh7GECTbimRhgyQfwvyBy91ZfHH4KevQQviekWTR8vZrc/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2+iI+ij5LIeGtVlMRQLyJ1TwG0VtrrICYgbIqMOaq0Y+gcci
	Po5dFoS+9qYzkRWhSw1wsXwxltLSdlRTSSTnUVNPK5G2dNeRCgMbHunbIcTpBQ00OkLTdgj0DrK
	brVO1w4hXEQ==
X-Gm-Gg: AeBDieuGMBtjlDamwr9t1GFV8iMFqgcgF74E7JhjtA0axVA094FkGPrd3WVr4LKAdoh
	k6TnSFMkb7fNo+vRirbo/6AtJXQL+YTXpuLLDf1Pu3efjgzRfUzuBYUKd3Nofno5Lucd+JK9ZKc
	P0vLa3EV9HVtMihRInO+Rb4s0ht9MN2/F3zW3+fHXqHMVC54Lb3s6I32EOShSl9y/rmNlmIRzI3
	Amrl0hAa9smF6Sb9VWj1BLvZfJfTRSr2OXcEk04VN15bVKM4nmV9mFkBO5QfEWSLgixSkRqtw2J
	0HNmL6xyCfzoigkGWccbHUO9Zfn98yHALtEh650fb2+DXrK+e1any3064SiUjtqoMTzq2IFsjCr
	Y1b1k+Rk4jUMO/N3xZvDw1LFLPAWbZj/VKG6K287uj+uuU1AKj6n5seMzESH/Yje1dGEZoIyK46
	xtL9Xgb2Tav3MSzMXF02bWCpuAmS7JvQgQBL1mRjPgYtJZmpxslYi4ReLq4SnxvA/lfuwoeCP84
	rLwxbGRz9FP2rNbLdZEbQ==
X-Received: by 2002:a17:907:8b85:b0:bab:dfe2:5472 with SMTP id a640c23a62f3a-bb80443d967mr32318766b.41.1777327141328;
        Mon, 27 Apr 2026 14:59:01 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c37ff67sm9831266b.60.2026.04.27.14.59.01
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:59:01 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so16199789a12.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:59:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8eBOf/CLpFzWYLTvX13ZSJxccJqGTWHcvIWugDSiGF/a4HjdUhCzpMmKBCcl0l0Oi48oV//nPfUx0=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
