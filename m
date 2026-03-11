Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D93382E8
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236795; cv=none; b=gTR/gHJxcfX9tX4GzUr/y+PRD5nYjOf3Yq+dZWard3MnIQqqpNWkc+3fXpbCvjcIqyUTyxvo6MXWDFfZ2PapYilojvIk1sSlvExDPCLBli4zpwCGj2N4dr5tm7kmR0kXYjy8rq4emn4+kae9C9ZgpXkY4PnsyHEKr70IYo4fcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236795; c=relaxed/simple;
	bh=5xYUudxznhB/9gI0iYC0XCpk27j9+cjg1Iajg5XCHoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUdOBijQV3m8fY63dtA7s8/01KrQZX88TEy/G/Wt/WdmZCH+oYjjxgtXC7XZEii293T/6McjIhAuhJ5jIhXRqe6CGbMCK/hJfCsosxpFe01wUL/WzpoSMfr6fkIXCFqS4Txmflndm8KK9LhcsIHeN7xgwLeFAB4b9A7+zs6JcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509134ab2d2so33407511cf.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 06:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236791; x=1773841591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cArsbpNTjSz4s4xSJeS/zGPEDFrbSvYY3oJhygDvULo=;
        b=XSRNhkCr9rKN5jCvk/H1sqBWyUBH3YE+TMYtUW2wIIf7XxR6hoQDe267fCLaFQ9C13
         poYv7yK9lAF+nvrE7TtSlEm/Yo7PFlxQQee6ycKUBrbMI5cTCRQmiac/iXjnC2nMFW8Z
         /7z5Z8zYz9e6fZqA1nj6lEdpyh+q2LMYJzv5nTEwSne9mjSY5yu9GX27469InIpM9O7N
         8hRbzCoKngGRAtH12GCYFF4tUlJC2f5ahlcCimVlceGi1GR0SHjtb4rAsiOHarIRXulD
         9bGJQO4Dto0R0l8CMIMbK9cWtyAqsUDejC73m2mWM1lLMX+o2AgvnKUIjCnMJiJaxfu0
         4Z7w==
X-Forwarded-Encrypted: i=1; AJvYcCXs3uI+Y5eltr/MLljX7GWLrtPTOiWz0oKZgdnOJjliujrIM61ucjwwjjGsCwxb0ml9zX53B6PVTTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvJGh/z1lgBVDPfNdYmIFvUNsfEyAtYmhDlCu8avhhmi3I5YH
	wWaEgFiyrtiv38JWKoU/66S/fsm6qAIUUTvRPovOERdPxchCNiJHwi+b/zswmj8M
X-Gm-Gg: ATEYQzyWrW6b69UaW/ETlEiWcu2MphgzILjtfuXjXg5AJ04K1LYll00RQpUBJXcDxtG
	TX7/LkpnkRXWuoYx8CBJNZKmcBlI8ln44nbVc7jHu7oOemI7GctkB+MdigOzh8RHjP2UIA9VEY6
	LxxVhUTZF4CjdXNxAoZVybcLiBw3w055UsF4dumiKytZyGJnZKjh6bUUe22WlGhH9x4W9vkTgMA
	WXVIXMkNj0CiXkg44RpMw0G7+uLCvx3CTftnoHzZ3wdWFr7o/6i5PzF+CGtCzQd03VDUfkIEzEA
	Ti2cAbxyX8+KmpaKFLOPFEaEsdS14Kutvue+MTN3NTAs8WaG1ZU0IioVdZFjTD+Vu8CSjnAl4EX
	RWjn4VXRFK7x2lKBgm5v1KDdA0paMQ4pujUOa2XW2g0+BqYJbYhqMy1lurQ/ZCcfGLJv7pZqzyI
	nyZKdgXgENyg0yXkjV8z0xvy5QK0unvrVT8jqD0008z4WE2G8a+fdqtT+yzv+pGKsO
X-Received: by 2002:ac8:7e85:0:b0:509:f36:496d with SMTP id d75a77b69052e-50939fc63camr29107061cf.33.1773236791113;
        Wed, 11 Mar 2026 06:46:31 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0ea844sm14499511cf.17.2026.03.11.06.46.30
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:46:30 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ca01dc7d40so1422096885a.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 06:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyb6U109MLMVSYEXu4+76a9cCjv5VmV+Hf9JBDuQuZDTvYNChWQq/CS6v+Jx8EB86akwfnRZothXU=@vger.kernel.org
X-Received: by 2002:a05:6102:162c:b0:5f5:2e63:f574 with SMTP id
 ada2fe7eead31-601defb72a6mr1104622137.29.1773236445414; Wed, 11 Mar 2026
 06:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com> <20260205-schneider-6-19-rc1-qspi-v5-4-843632b3c674@bootlin.com>
In-Reply-To: <20260205-schneider-6-19-rc1-qspi-v5-4-843632b3c674@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:40:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVcwnYyN56Ktee0wR=oT3oMoZ=5KD=5RF4Bq2ohueJNiQ@mail.gmail.com>
X-Gm-Features: AaiRm509ZGDpwutdpDixUlMdHUAqZXZJALvV2NTJJn7lmkLWEJoaky0AqQwCh4s
Message-ID: <CAMuHMdVcwnYyN56Ktee0wR=oT3oMoZ=5KD=5RF4Bq2ohueJNiQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ARM: dts: r9a06g032: Describe the QSPI controller
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Feb 2026 at 19:10, Miquel Raynal (Schneider Electric)
<miquel.raynal@bootlin.com> wrote:
> Add a node describing the QSPI controller.
> There are 2 clocks feeding this controller:
> - one for the reference clock
> - one that feeds both the ahb and the apb interfaces
> As the binding expect either the ref clock, or all three (ref, ahb and
> apb) clocks, it makes sense to provide the same clock twice.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>

Thanks, will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
