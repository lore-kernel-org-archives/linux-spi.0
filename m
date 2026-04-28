Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D63876C4
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368650; cv=none; b=Wkd4fP/Er0/BEjNPW274w4srq2/EI88CNoSk31E7pKe/+/uUnfKIIhW/JzTMpcpxzhEqC3p+n5SPUPy7YNmuhle7AIPK1wJkiJEyE4dpCkXIyruaMrtM1bG7uXrYk2/veGPoKFMahmbTkzKZsbTuRGw5YAsdnca8MLD15M8MRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368650; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjCV00Bi3eJ2BfoaW4VXSr0qXr3GdIxLV60mJk8h4g8HXZsiq+7kIodRxCMaFMAoniEZ4q5yPMzmOrcNVe1LXz3LEPqqSD2X4Kv3piS1RBDr7aEFPfR6xuPPBiT9fcVtGsPu2QmtHvfvXGy0oHoC5elfTy5CZ1jdVV5ytsQuzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b886fc047d5so2002724066b.3
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 02:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368647; x=1777973447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=HYq9tdlkowsCrRvIlhp+Tzswf1YjnFRbOjoK7QztrwiAtUD1dcdfVwI5oN+tHmuBe9
         ZSnqEUN8OWzRxcMxWgVhwCN3pVWh5l5vivbsQj7MM+4uwC/N1h0Z0tVR+gPlpfk8/hpk
         J/ONCCnTdBSu1cdtI4nihHc3Rivsrjj+8g+YwrmoFqfBFbTdI5VV2uDzEH9q/q+1ludP
         L1JqiPkd13uedE0wod0N/55Wob08DGBMGYjKisbY2SDQ81onBtOfmPRUWZxHLlylHAiK
         97nG8+EHvLwRRxev8/Cq35ULJUVzR6EbhN9fMoqT5u3iWPoOut0lwgXO/5FTZV2Vaq8Y
         SZfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+WCHuougn0BS/2PpdISO8VW7Wr99INIx21HiTIlmDRs9PGjs5gMTzwrNYjCpPd9VVovc+A8LUNtVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5atDLKyNoQBHC0s4dAYmBSVLvOFuM0sSHzQa2aCc4wWVdyVLz
	sMatd/w9+QwGS83cKG2HaKjLvG7QBWdXaQ7TWKG0EmIcrjn9QlHQSjveaZtqM/MdvC0=
X-Gm-Gg: AeBDievkg6wJeDRz/mcHuQCIKmMqvTUBSWK/6SOjcbFH1g5GrBiuX9C4tK0NtJ6HwuZ
	9qbfTQ40b1KeX9ZkV2UU0L961xn5RSvZvPBEVLmgR+lUWOuTvjHu3Bd8MXhxLSW5S0ddlfXzMVw
	Ok/WlgmJcwxLk8dxKtC8AmqNNvx+5v6CMgOke3DXC8flFB34PqEO7cdd46qBP5xIgMrGDjQSsd2
	QHcn6QKWF60P/6pb8MLg5GPbNCHUsMkJ28q2Wxq+lwbCnqALFVhYaLcYLi//4/aeaMY+z1Mgbuu
	4gCimSu06/6x+sJsb8ycYAm0Fo3nI6cKT2hd+9zihDSizapTS0XpnmVc4REed0Wd8Sx2yQk/axL
	M4QKEyazO8iJTcjIzite1GRWNeSKd7569s35gyle1GP5zdE/vLCMaA0hMc/pIv29cq7pSLzbpcQ
	MXjh0OFD+rvqrDncAa0z5cPCGNfSppkzgvjBLRWo7zrW36cVVl+nobtYaAjy5EyOMScBaCkPQ=
X-Received: by 2002:a17:907:1c29:b0:ba7:4cd9:ca12 with SMTP id a640c23a62f3a-bb8026bd340mr132733966b.13.1777368646756;
        Tue, 28 Apr 2026 02:30:46 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b2adc0fsm71995866b.29.2026.04.28.02.30.46
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:30:46 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso15350034a12.1
        for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 02:30:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/XXWpmSNHQWH//ji2maIWAZJtbd5tovmIFwrvG/l2JvnljsgTOsOqfj2vZcC/VPUGURZJlT5+X1qE=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
