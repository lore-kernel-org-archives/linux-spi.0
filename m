Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB530AD0C
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326330; cv=none; b=tVuYXloS5L/+fqX1is0PxJypABKxtwHIqfMpQXsQczcnIOErxkvMo51knB7Ojp9JIGKELdk6cTdD2iXgeQLooMHBm5T9FmiJuoT13g+szahZ97VLx14htb+pZxt7YUsF7D/jpUM/PiVuyJId5zss/mBNmizAVGrdgfZMc4zCD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326330; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsf9BOwSfmuwAbRKd4nu8kye9CYbxD51UQ2Wah54R67ycu6A9HvGWaBV/GPBasSoH1n7M32/xBPpRv9I1xjASXhi0zxBddDPdZRaoAIqRa2qr6joiHCZF0i7w6BrtFSax5MGbY86xiGr3tswUIyjkomPb6IsoLlQxzyud+55pDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iI5YjZOu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iI5YjZOu"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5632271a12.3
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326327; x=1777931127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=iI5YjZOuDIa5moq0mNrzi2dykU+24K85TvzeZpumgiXYMllofH+5EtkJyWlnvkZy5u
         klt3HrRySQCwgu+OQe4IK+yRfXqDr263KOcQ1RXGkEgsl16EtPNfbt3LiHBr8t3V2u+f
         Yae9jfewIsxH/A6HI0t5DEzIMaVzdneLhBTXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326327; x=1777931127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=W8g1LocB1HWJt1ecSOGTGm81oWkHmKIqNVP8xrkFipRDjrolIvDZhLnM/SJAmfUU+N
         6f8UGe0PfXH7Hgp6Bzqftf0zsT2saYkDYlfbGLGafj+kJ9j+swdJSqc3qymcECU2eb68
         RXkELNWRlhbyeIo90YygVERCKzJOa7jctfArHY/NLkl8LnAoH1X/xyBe1NmKUJ6N9E1D
         5Lc2Y16/xyXRapAJixUUbpkFk3+khP1Cz4j6JD9UF2e4pmSUpGsXH+Wogmp7tgvDbUmd
         m1PJ4PdUKVdf3mFkrL46WD155DqEDD2YRKrf9bWnGb2k1iqSAdWlPLD087/riMcNCtEk
         y5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ8Crn6/AnIgZyoGJO3Jzc5WuoTu9G1P2CkcS4kB4XjIxIrFHwUBc00aP1QtZyW8iUrAYUYI7f1cdXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+V/VrL2w+TE5T1+dOm8SbC8KNei2Q/VGiSEy1PVzRsoYxZal
	nWXpm1L521Ak9u4XhQ3JfEd1bAa8zXVBeLUnwr2SudqS8FHSOBEtKA12X3euLcSY5lpdqglwRhS
	Ve2hPBOtuvA==
X-Gm-Gg: AeBDieujllG66FijehHRvdn2ahV/+D2/n7an6AKSsdJuyIHtvFlhGKxJiofO8t9U+L1
	AXGxQAQeZm9r8TQVPbMM5FU4tkjxjH9phmGyyJUfNN+aWW0hIy41Pq3G45Txh+hF497OwWwCJfy
	85kmezDn8sPBPRXaJpi9wKzlyFnAKAiF36JGzNN+tTItoBsaSjI0kmBuauaFrtxGhMONnqW9MrL
	uY/DikWmVu6Ervw7z6NGmIcdiXOvfSP8BauUThmwsNzuCjRwaR+TDstNPS+76Rn9HVtpY5c5WUc
	gK4ZAij3cDQ8T0TWPFOpsXQg6ozdE2/WpLmv5jSXOWhYIpwQ7FyH/ti9HYKlL6VpPUCYxIE0jYW
	YsmcXz69KeRmeklyugnQ9iia788n/iluEMdU8tJYtd/SqlsEEMtEa4kEZ2yk01Z2ilglRrWJMmQ
	YiS3bJqrNf1JjebEEIxrIWvlVjb3cUJtpPAzgpP+lEacsBvzxyBynpsVgdHZ0VkphXgZ6pTwyae
	0tp92Snrg8=
X-Received: by 2002:a17:907:6d19:b0:ba7:1191:6402 with SMTP id a640c23a62f3a-bb804727ae1mr27533566b.27.1777326327434;
        Mon, 27 Apr 2026 14:45:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c081c40sm9506966b.55.2026.04.27.14.45.27
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:45:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c01854477so696610966b.0
        for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+clVHNymg6pQdD8GYRMYIcV3ylKrPV6CzQPO/6pwvevyoNEPDdVyu3r9AEFj7THALDwc/dqKNqWy0=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
