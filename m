Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F43DDDD8
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221113; cv=none; b=ClltdjC/eOJnwhwEO6BxXpuxxmth6TZkZZ7OgMN/nylD9eCpR+NN7X6jTuVo78d1NoWkeZTd6QznwHxG/wsWnfOSpferBGCRJ2cpSdLkXsDurQrPjwcd4eXhOMu7lJrUb74G8VYQplqvBN6Q7nJgs8ESWtZ0YrZSPFdftY35Vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221113; c=relaxed/simple;
	bh=01GKf65j/jScrwoKQ+C2Gxr6oYYNcBqF+y3kaUEjbLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2Xyc/I9hTRF5wm7cBifkxgbBbgoxqjDoN8E0NxtcE+OCgSWxeIThV7eHOhYluLjaXuIrv2AdfB9CEydEWhEaybMTG8OQLgcj9+mofMQcIFTPvSFJci5rvrZviPRefbz+T1+F4O2TjISAnY5VIu6Ddnq4IyJUJSO9LaPXl0tzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF3vSz27; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF3vSz27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F8BC2BCB0
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221112;
	bh=01GKf65j/jScrwoKQ+C2Gxr6oYYNcBqF+y3kaUEjbLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MF3vSz279c7gxTZF7NgmWXEwUO6gRL13DHvShsuI2CRziUEddwspHwDaaJCHkRV8i
	 1e8zOtRrOs0iqe9JzaJ68RtW/nQ1cvGHa1wiWmmW48FlI7kwj/kEddAkxcXjR1yDzp
	 SJIQlrnxZuj6GGfdBmJRR8x1vTwehdyhvu4FbSRfBaZTFT8aPShUh3ZNLiLOPgRB95
	 yQdLMmafhM6TBUlKOPZylVs34PzLhbNs5nvhVRvc3stp3hfCZaU9UkVuxIOh1zjH1Z
	 +6oVrXcP7tP8GQ//avpnN2ZW+fNxiu/UD5Y1l3+K74rROfInQkbqpAvv3i0u6ejBkK
	 xqNFoTovsi7HQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79800183233so11822527b3.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 02:25:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrA1BTu8MFC2W+dn+hxnm6Kq65/iIj1HeGbhYkz/u1uOa0fBVSlma1X+DqJ2ZvGxxyfUKM3CY28M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04WnfNjR2r+WUl8ty9sEni3z5gN4EGxYly4hyRkNrW/IDNHrM
	fqy2ZTcv/5jBS82NghBycofmt6JoJUVBQCfbXtI6oZxDt62V4kdVdLtnRoc/t2mVXSRpu/gsvVo
	7hWbbgUmjU3Tia0VKjAzbS1RzpkpYvPQ=
X-Received: by 2002:a05:690c:6d84:b0:794:f400:2bfb with SMTP id
 00721157ae682-79917f593b5mr14822137b3.26.1773221111798; Wed, 11 Mar 2026
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310075539.11701-1-wsa+renesas@sang-engineering.com> <20260310075539.11701-16-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260310075539.11701-16-wsa+renesas@sang-engineering.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:24:59 +0100
X-Gmail-Original-Message-ID: <CAD++jLkoWCcBvB4G-2EDYU4kezPhVF6943TY6PmK5ooGwruLzA@mail.gmail.com>
X-Gm-Features: AaiRm52-5ccgCpLSKuxxaehFi73jWhXjY0Lv_AX860GJVRZU0Kw14nXERH-rf2Y
Message-ID: <CAD++jLkoWCcBvB4G-2EDYU4kezPhVF6943TY6PmK5ooGwruLzA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] hwspinlock/treewide: refactor consumer.h from
 public header
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:56=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Factor out the entries only needed for consumers from the generic public
> header. This allows for a clean separation between providers and
> consumers. Also remove contact field in favor of MAINTAINERS entries.
> Fix the users, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> # for IIO
> Acked-by: Lee Jones <lee@kernel.org> # for MFD

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
