Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF021303C93
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861899; cv=pass; b=SqrSfG1Jgrj6gfxShgk8gn5GDNlqdbtGDHsnQu5m1zWqXw/H2EJmAD53MACMW44OWrTOzZv+fnkQCD8kKYTkwE/hpvpkOIkZwb+5+JmBNYKqWh66FWeRmNZ4rmJrnhPiI45Bf2bvHCrCnkvnQl7ofFHAGsp6hz01Cqo24C2l6L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861899; c=relaxed/simple;
	bh=d5zCa3ysNLijKNaGOI7tuajauNFQ8GHfuuwERS7PUF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUtrEeD9TQbRRpjAf2bcyAsAb+e9DxLmPmkX4BVE8fohck9zLPysQuxAwVvjuE1tjGBbNEJ7jgvRqdB/Swdlgq1IvwyQoXRppdpkPvKXuQufy+YqsuB//czZQf71IoVya2822HglEi87DukvWRRKX3PTuKL3l3dMYEJZedqAKbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bez0+ejt; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bez0+ejt"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f86167d39so567861566b.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 07:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771861896; cv=none;
        d=google.com; s=arc-20240605;
        b=C0Bpa5Iwar+9mg5G8sxgGB5qeiOFBYyzAtT4smRwTnoKfhX+Srr2mb7i/FQLotiJB/
         6IY14XcV1MA9Dz98yK/bM/WbWaug1Bm2cmjSopj8OfH9D+A9WCP7EvnbHRjHte9SqE9h
         pHPSpXZRz44Yx9+JOB0TKN0A8jXEiBO50C/v+m4Kcm88BYdM2QIz1/Vz29zrogNSqpHe
         SBCZ1PJWHTZq+9hLnmCa9kR0tvcRTYZuoTY+hHXEZ8uKLnkJUDqrWI1io8fR5H+YeEOS
         LeSh9Oxn5lUvS303TYM9AZx/W7mpHOV8k7yIjBArRPhuhyKgYWTgbTYiDG42OF4Kr40z
         k9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        fh=YdQc98udEoy6jzoIxtezefwKgactw71lXYI0DM6FF5s=;
        b=MRa+iupfsltzFpC+YLLH3qouXQkPIJt8QUMsqUjGiW58hYI9rB3kFzmdL8iAalQbXC
         KoYVxVkaoeI5Wi0vlAU7Syf0zGBea2W5Ke3AxY6Fe6Q5XV83gthn7bz7Vwlch/ILMZdI
         wIaDKr7vcniZtoMNy3lD/h/69aXElTe7llQKyi7CiSxiCW81S0fpaKmdMx94d/ttWTkP
         Wmp24940QBsXiGYm5N7s6IoTSB17fmK8ntdwiHIZc2w4P6rVAm0Kvh/UAP/ZYwQWC9jL
         tQXi0Hiru5m95RKbiSpsR4bUiqEGUdrnW5icM4iPS6DbY81lXQ3QL1S6TlurGKW9+Val
         UMkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771861896; x=1772466696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=Bez0+ejtvpYWPD6Kti1bkjLrHh/4ih0eYIM0CLxjHJVlyC5lHQHjEKF0CNkHaDuEqj
         cX2cnDEAf7qRrLs8/C3MibBqjq4NnO55kbXTfuH8/Nxx6jwnOMpahcd+BT6S/CdCi1JH
         KUJtx0cspJycQjPwSfacE7jXqTjOKa2T5ILFwWyAwyTfTP05EQrGoHDnILUdu9FWad3o
         qbEmW4NoUFk3SaZ6xWr4LES3oxs34gzL9jKWeuyFPeI3DkWSJDZv4Gpd6GKXlNwQMJpf
         nVxvrZuxvOrPFJhe7ZUNsnwKzjKRrU4q7YjLGxGI51cWL7miac2P1Y9+lB0iWh/Q5Nv6
         YUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861896; x=1772466696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npGY86N71VPo4TOfv73Omx9yZ3z0Eb9N82/SaZDWxbc=;
        b=t567Q7KGQnI3OcF4iopyQWYoIkPt0yxm2MsQEzNUUTHjjOsYpcALZXdaB9CHP+qYfC
         rVT/GtrWNYvfZaE75wn3cWWfP/4KnQaTGjDDqRkThrdvGxNqiveZZpDPaadRsHuwYSdB
         y6kpN7LgMxFfCmMfSrTNXOQBpai8bY7ZfOOZ3rl5HFdmpurC1GqZt4F3hy8vGWiZof1z
         2Mh/BHLsPJcL4iJiIRpie0b5pLdqFzSEQP3EOjifCerOH+cX280JB1sTDgi2SngZvyjR
         J48yPIgpw8PUD6s1CZdvcAgtrpaS5ODQeOXA+zocsPRqD4A++5WIlQUtGb+rh/tuQerE
         rLYA==
X-Forwarded-Encrypted: i=1; AJvYcCVC2bwF5Yj0l0W7Yn5faugpaEx9zUSnbnyY+0CsrfYIHQ8rbnSRklGXcBM2zHH5EArj9tIjF0Xhx7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQ1lE8vEF6po5zbOx7BYg06p1e/2is8SZZyx6In0tf+oQz2u+
	O3hLPLy7EaFFlMnVO8Qv9m58i/vYET+UI9BBTxXQo1PSoGwgA18ZzKWK1oH9CQ7UyrnRb6dtkps
	3fhYdBw8E0/mW5eUxxbJ47dsGsWwBoEk=
X-Gm-Gg: AZuq6aIt70VchkwC8Qs7iDTo3cHQl+IFFuI6qD7evVkIVCB3tLhzOYwh+CweylXIymz
	rtjR455y03GcSnNwa1uz9Fr0RDburNz6djJrTi2zo+BtJW4jeIyVnDv+2lpKzJZcltwaOVZ5zA/
	OFvAIChUfRho7rPMMIuN5O3IbJ19b0fBLIGT/GNJ+nYLcVUyfDmg1LkmUSzz96xY/3N6QrkrfLG
	LMZeuQ/jILynhbtseMfQJaelNr41jF51BZhS4cr/OotKtnlsRlP2NtqRPsI27ELR0kVQHE6jSkw
	kOlVcbB5HF9G2ORO+yS0eVa9O8dq99NOS1zrDAymZANOnJyCfXqf8iLcHHLuTSC1V3yP5Xy9Cbn
	3PxVi2RI=
X-Received: by 2002:a17:906:5ad6:b0:b8f:e424:ae56 with SMTP id
 a640c23a62f3a-b9081badd6emr413937066b.44.1771861895691; Mon, 23 Feb 2026
 07:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 23 Feb 2026 17:50:59 +0200
X-Gm-Features: AaiRm51McMZohKyigNQFIbQDImiJ8vF_g2F0DjapyVKPe6Rkgx4x17MorqEdw1M
Message-ID: <CAHp75VeWD5A0r7-Uayyte1ZXXxdhLixd+z_y0xNeki0N+Ro=jQ@mail.gmail.com>
Subject: Re: [PATCH 0/37] PCI/MSI: Enforce explicit IRQ vector management by
 removing devres auto-free
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Even Xu <even.xu@intel.com>, 
	Xinpeng Sun <xinpeng.sun@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Vinod Koul <vkoul@kernel.org>, Lee Jones <lee@kernel.org>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
	Karol Wachowski <karol.wachowski@linux.intel.com>, Min Ma <mamin506@gmail.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Andreas Noever <andreas.noever@gmail.com>, 
	Mika Westerberg <westeri@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Will Deacon <will@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Tian Tao <tiantao6@hisilicon.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Antoine Tenart <atenart@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Raag Jadav <raag.jadav@intel.com>, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Robert Richter <rric@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-i3c@lists.infradead.org, dmaengine@vger.kernel.org, 
	Philipp Stanner <phasta@kernel.org>, netdev@vger.kernel.org, nic_swsd@realtek.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-cxl@vger.kernel.org, linux-crypto@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
	mhi@lists.linux.dev, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:32=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> This patch series addresses a long-standing design issue in the PCI/MSI
> subsystem where the implicit, automatic management of IRQ vectors by
> the devres framework conflicts with explicit driver cleanup, creating
> ambiguity and potential resource management bugs.
>
> =3D=3D=3D=3D The Problem: Implicit vs. Explicit Management =3D=3D=3D=3D
> Historically, `pcim_enable_device()` not only manages standard PCI resour=
ces
> (BARs) via devres but also implicitly triggers automatic IRQ vector manag=
ement
> by setting a flag that registers `pcim_msi_release()` as a cleanup action=
.
>
> This creates an ambiguous ownership model. Many drivers follow a pattern =
of:
> 1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
> 2. Also calling `pci_free_irq_vectors()` in their error paths or remove r=
outines.
>
> When such a driver also uses `pcim_enable_device()`, the devres framework=
 may
> attempt to free the IRQ vectors a second time upon device release, leadin=
g to
> a double-free. Analysis of the tree shows this hazardous pattern exists w=
idely,
> while 35 other drivers correctly rely solely on the implicit cleanup.

Is this confirmed? What I read from the cover letter, this series was
only compile-tested, so how can you prove the problem exists in the
first place?

> =3D=3D=3D=3D The Solution: Making Management Explicit =3D=3D=3D=3D
> This series enforces a clear, predictable model:
> 1.  New Managed API (Patch 1/37): Introduces pcim_alloc_irq_vectors() and
>     pcim_alloc_irq_vectors_affinity(). Drivers that desire devres-managed=
 IRQ
>     vectors should use these functions, which set the is_msi_managed flag=
 and
>     ensure automatic cleanup.
> 2.  Patches 2 through 36 convert each driver that uses pcim_enable_device=
() alongside
>     pci_alloc_irq_vectors() and relies on devres for IRQ vector cleanup t=
o instead
>     make an explicit call to pcim_alloc_irq_vectors().
> 3.  Core Change (Patch 37/37): With the former cleanup, now modifies pcim=
_setup_msi_release()
>     to check only the is_msi_managed flag. This decouples automatic IRQ c=
leanup from
>     pcim_enable_device(). IRQ vectors allocated via pci_alloc_irq_vectors=
*()
>     are now solely the driver's responsibility to free with pci_free_irq_=
vectors().
>
> With these changes, we clear ownership model: Explicit resource managemen=
t eliminates
> ambiguity and follows the "principle of least surprise." New drivers choo=
se one model and
> be consistent.
> - Use `pci_alloc_irq_vectors()` + `pci_free_irq_vectors()` for explicit c=
ontrol.
> - Use `pcim_alloc_irq_vectors()` for devres-managed, automatic cleanup.

Have you checked previous attempts? Why is your series better than those?

> =3D=3D=3D=3D Testing And Review =3D=3D=3D=3D
> 1. This series is only compiled test with allmodconfig.
> 2. Given the substantial size of this patch series, I have structured the=
 mailing
>    to facilitate efficient review. The cover letter, the first patch and =
the last one will be sent
>    to all relevant mailing lists and key maintainers to ensure broad visi=
bility and
>    initial feedback on the overall approach. The remaining subsystem-spec=
ific patches
>    will be sent only to the respective subsystem maintainers and their as=
sociated
>    mailing lists, reducing noise.

--=20
With Best Regards,
Andy Shevchenko
