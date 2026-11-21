Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293610;
	b=YhCjXmJDQ4rqxuwbaAXe4z6gijnYiGUMyuP26kX+Z53QByESCRRWtiJWLhDRD7x0+oDW
	 p86FX3VLNT1USHT5mYjhhZ+cAazdGopoEBmlUg+K/f643tv7Z2BYK3nogtEqip7KHozYB
	 8KzgWj/L0gGtOq3COqGxMG/4uRfWtxD15k8lbMLUqkwFucaJ1dp/10DuIa6jjvdHzZYA/
	 uegk6qNVZFNQy7VjpphTuC8czPZbonx6YY76o7q5JZdKV89nKMraT51Cg+qzeLw/P8ziw
	 Q2zMtbyWvaTaHnC1U/75Ryfj3RWndpyYiC0P0l1w8aQntYp7+p2vDg6q2d3CcbWy8AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293610;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TBjlLLaSMdptS1qSf1sy2MeZrQefDkAIXeGwS3xNDrU=;
	b=jDOJUyG6vVv2bawNLPSsFio8mgW/gbzGh+XU2iXmLcK6qLsZD90VUl/mhKN37/rumnMo
	 On4RCYQQko16eHVUzD7iQwWt6Q7JL+rWqWtSQtlIRoUYB8/wNcsNzyqs2CREyDLSgS0rT
	 jWC3Co11DxTqmK0zlzDE2OixQLegZGpABBN/UdMvISE2/4ifPqdh+X4RNDfD3zzC2Fsak
	 4nmWWuyhFzVDj1lW0uTSpvx/bMurtVT5Lwt1Qsb6jg3MmhFZ84x37FlH8HA4RpRlnyD/y
	 fk1ogmeWkoX8517NMjv7VA6vdVUiKlQesYbABkxdGsyxFIhdhW1lqxMT3oARVjhNEjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2ICUGWl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC57606A330
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T2ICUGWl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782F71F000D4
	for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 20:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795293610;
	bh=TBjlLLaSMdptS1qSf1sy2MeZrQefDkAIXeGwS3xNDrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T2ICUGWlgRPchPUIQ+snZtdHmoEPJlYmXRuIWM2+7qMxZIlvBCJrzjTXVxZgCIuOS
	 ygV5zB9T/a/BXUUN5D1Ua9irV1wgk8khz2Ed5wJG1l+tw/TKbLFs2TclDlVOHf4keG
	 zhfeOIhuGmJyMd/6QgHDnCggwAPS8flD2uxh8EaQiq+++vVweWsOAru9rbf1EoRT0a
	 YuCQw2jJ+hyvE4IWqe2nF6iVwkTRcIcJMdFwTaulrrTGzVzas9YmEswKX5Olu1Ps+C
	 +nY64hZEYEW9UutqbeW1HSUfdJ1aE/GKm42Nie2xhlgdYGB7LcsoWyOYvc7GGe8Gca
	 /3zyilDJuASkg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so2766903e87.1
        for <linux-spi@vger.kernel.org>; Sat, 21 Nov 2026 12:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEems0NwtVyBxFlNZCdYHwWmO+StptE4aBmBMkfvgiT3cCXrOmwkqlnShLUoBRfjUiL7O6YQ5B5VDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9e5BBILXG15AwI0ORB79CIoPX6AK4QSVPj87W+CByCzJnZYFAV
	W2yhG8kCAmPjS80qoXBHJam7PkK+MSk3ifGCLDy1GY+zuduLFhu3YNJcQzSkkklzQfpS/IfI3ub
	BD1FEGjCQ1P4FuPL3uY7+63xgp88mTro=
X-Received: by 2002:a05:6512:33ca:b0:5c1:57b6:5ffd with SMTP id
 2adb3069b0e04-5c1bc552d9emr2306559e87.0.1795293609072; Sat, 21 Nov 2026
 12:40:09 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112064957.1796975-1-dmitry.torokhov@gmail.com> <20261112064957.1796975-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112064957.1796975-2-dmitry.torokhov@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 21 Nov 2026 21:39:57 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ww5ujTR8rL8htZ6APrbKqD0K+N6J6-LeMZsPSOhUtew@mail.gmail.com>
X-Gm-Features: Aa3M54rUPZzCG9ojMkF6fiFvoquOOcY_PUVJLfl5nrRmYMblL1z9xSrx8VOuWKs
Message-ID: <CAD++jL=ww5ujTR8rL8htZ6APrbKqD0K+N6J6-LeMZsPSOhUtew@mail.gmail.com>
Subject: Re: [PATCH 1/5] Input: ads7846 - drop platform data support
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

> Now that all in-tree board files (including board-nokia770, spitz, and
> db1000) have been converted to Device Tree or software nodes, legacy
> platform data support is no longer needed.
>
> Remove struct ads7846_platform_data and associated callbacks, parse
> device properties directly without allocating a temporary structure,
> and delete the unused header file.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Good riddance!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
