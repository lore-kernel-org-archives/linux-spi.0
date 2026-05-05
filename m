Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDF30E0E5
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972362; cv=none; b=hpR7TF3jyCvE1CmWFn2MXDJ+l0SHvddp3C5pPsbA8MJd6/ZumxDmdrxc7LHifn4r2A5Zhxo3iC26SqODHDRXqw2YSK+V3wGseIazN4UA944jC2lblhrOBft49HWLY9QGtDx8gNNJu2fARRsZig3Zk5H/2KnmceUJulaM1ukgP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972362; c=relaxed/simple;
	bh=6utuRugFuQW1QzxEpH4tYse1O0Bv/QojIYP6k9RXbaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzum9fCISfkD8j5qUSrb/hDRAZip8alAQ1NXCd5SiI6C3CzHiNcsYPmcYypEaM5Xub8Q+BGeysXHm25KciucFgwmwLiDxGhVs6/ZGnDKCDOpf5IcmZ7MbEfTlUX3bAfDXoMOcyzi9PNOnmbhnvcQA27YbiSRtFORnIzCWsPBqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiOJ5WFu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiOJ5WFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B27BC2BCB4
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 09:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777972362;
	bh=6utuRugFuQW1QzxEpH4tYse1O0Bv/QojIYP6k9RXbaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FiOJ5WFuYxzoZOtAPJtZYLVYv3d/0r0djeBDWEV9tTOMNM0OWqyqcMxQBMfgIZvsM
	 LunS88fz4cG/iDukAdBJXK42uWduAcVcz/wDj0Zj3MTnHQIGVyDS6KuSyk7YGRisgZ
	 fENVPipTmeg+9Zjxf2j+PTOu4i+/llQi5x+4uaDBs8sq2JOb5Eh5+7IaX6z4H51hCz
	 SJj9/VSmQHk7Zz29uYfNWlIoyZJJdkYIbTrTJvvGNQQUHmWcfl2bGvFpOcnV+k/0T0
	 ENuhO5S7Fy5ljDjBdJWImMxy9GxwhGLslJHGI+/DrHJW5aqDrXiqmuypepcZllCrsp
	 XWz49rj/FoBSw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38def541b0bso47668511fa.1
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2026 02:12:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Wmd8jg0jVNCr+mW+1OHNykIfcGLTeFraoRSTbA8d7Up6zYr40OW/Huf7SEqBuNBFlJqaIvxGWc5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0za8gej7nuUMxQRGnm+5hVDBbNgbtTeP3wmO62n51rTa8TAkr
	PPB7fu2yYXK7IolkrkBobwVd00EGX4J+XviPpTxYAFn5bT610Kz4fIhiM+KgmlAXvcl3H5L8eRh
	VazrsKvDK2XV1e+MVfKZRnEipMDjX+Nk=
X-Received: by 2002:a2e:b88f:0:b0:38e:2822:a264 with SMTP id
 38308e7fff4ca-393b4aab764mr10128231fa.12.1777972360829; Tue, 05 May 2026
 02:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505072909.618363-1-johan@kernel.org> <20260505072909.618363-4-johan@kernel.org>
In-Reply-To: <20260505072909.618363-4-johan@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 11:12:28 +0200
X-Gmail-Original-Message-ID: <CAD++jLkFNw6eO4ex1h9-G8LE6YCwCdnZu3df6zb0DnyzCfS9bw@mail.gmail.com>
X-Gm-Features: AVHnY4K6utr00A_9H0oWh3u0b7g-amWyCLCP2_uZfn-dnvX6aO9ueGg_xOKC2EQ
Message-ID: <CAD++jLkFNw6eO4ex1h9-G8LE6YCwCdnZu3df6zb0DnyzCfS9bw@mail.gmail.com>
Subject: Re: [PATCH 03/20] spi: pl022: switch to managed controller allocation
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 9:29=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:

> Switch to device managed controller allocation to simplify error
> handling and to avoid having to take another reference during
> deregistration.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
