Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293719;
	b=doEgjLstIEqmP+w+bhzfu8W6F830ZwWckQ0qLhw2S8crmBxJMAg0oJp+2T1pIZNI4b28
	 tf2zCXixYtXkZNXWZ+xQetBhszmHXUXV1jwlNN90VL+GF4qZwHqyzkKN8TbE6aRywN0C9
	 O8mV0icacEPf17268JC3Jn5lR0yI+v730RN+RX/pBTiAuQtYp2yR9wWbldW9gBkjDAg+U
	 WXS1eTfv5zuPZ9kIJZMrkADzGxcOVAQ+rj8Cj9QC/ChSldT8KdQimMSpvDE1pxZDG9z9i
	 Vw2Zo6NwlTApS/PZHLvYYMUewqzH50Q4dLvr8T0VSbTP1Yoglrjf2sPwStAibbQW6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293719;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S0KEtbQt8GRBQii0toPIaQocuYt1n+g/sLHZS8pvKLk=;
	b=ATmD+thbyw3Twb0DqyTQERgwDObaKgGcOYBRNBhtJPT7GrQMSH+G9Ef1Id7Ea+gUsHwe
	 GkVx8KZZsr1dISVp3PGmGDWGsX+w+OTNPhKURMbH+G6gB+wrsjhYuQI57IjdYLXhUodvE
	 qPu6xtisgpSGT/bioc3GF13f8tVoWFYvBNclU8V/D3Id4xF3TvC8GZwmQ80n0Tykevr5E
	 5XDhS8muCD2xBDX2n7IREY4dq2wwpj9lSgTRxziur+LepZj2EtdTaAc/vU+Jz86bcGKyK
	 2b0C/DcwtahtXur9gj2S8lLpCHbSAR0vicZRewBaartb+IE+M3MDzNbT4PwxKOaMfWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzy8D86J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AB606A320
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tzy8D86J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1D61F000EC
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293718;
	bh=S0KEtbQt8GRBQii0toPIaQocuYt1n+g/sLHZS8pvKLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Tzy8D86JZar495yRQAG/65mVNGhyCfKZ5L+iBZCJ6QjFgum36aHL55ANEzOtPPdam
	 I27chwcNdefUyX2zCTZS0nPR7luaQk5V/m+NJgvbO0DmYUlGxykZue07+Lfwz5/x/O
	 Lt1coNjQvqDM+FNVRngzpuYv8VFp+uvQDRkZNOuZ8rSaRp29eXMp53mByE9daw0KRe
	 AkhBeKePK67El9rbzIZkcjp/DpqqLU2UqCuO20+W9HCxpTZwrGWRpiVoKjV0J6PWOC
	 +q2K6mauqv6d+Hsm6J/05vKBfV6s0AVUmo8J5djhkQqYaA53Q5zfi0vNkBePylYU45
	 dQKCQqnJkfkcw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso2508311e87.1
        for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 12:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF7hsOvhVxCUaEnN4Tx24f3ErP7Mb38yKtTmvpRpaG4Ndpwvd9iQudPTD60jmgZC12i11/XSJ2Ac8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NumJfg7/k4dQmsFhK00Gex36QQcn8SH/rJg3GvcK4GW+YO48r
	rtk1i4U0WRMWK3EswzR1IwzsQCOrZS9IuWp8oxRl/Kd8OPYt3YaonFi4FqGYcKSud5fpVyEZlsk
	9Ek7+BTJSo2Q6Z1T/edxqNY60ct9ZX70=
X-Received: by 2002:a05:6512:2c9b:b0:5c1:ace3:12c1 with SMTP id
 2adb3069b0e04-5c1bc575979mr1899458e87.0.1795293717533; Sat, 21 Nov 2026
 12:41:57 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-5-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:41:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLnRGBk=kQ48AiR8nreGH5qqmgPpG9seh9nRdhsoQAO2XA@mail.gmail.com>
X-Gm-Features: Aa3M54rjP1A51PecTmry92kFaSGq6HbI8P0tn6phUpG9qNi3VmLI5ZCflHpwjkw
Message-ID: <CAD++jLnRGBk=kQ48AiR8nreGH5qqmgPpG9seh9nRdhsoQAO2XA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Input: ads7846 - remove unused code
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Mark Featherston <mark@embeddedts.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 7:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Remove the pwrdown_cmd member from struct ads7846_packet, unused since
> commit 6965eece2a89 ("Input: ads7846 - convert to one message").
>
> Also remove the unused REF_OFF macro definition and drop the CS_CHANGE()
> macro along with its sole call in ads7846_read12_ser(), since the
> request structure is allocated with kzalloc_obj() and cs_change is
> already zero.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
