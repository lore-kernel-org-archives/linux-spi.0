Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1B34EF1C
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171855; cv=none; b=SYR7iU03tZG94MmjHTBiCPNfj1PZ9Y+44ktlxTxUMy/Nn14t9hyf+uCdDsZMxoCRa/nnHHIqrmnLljvLfPco/nYppZDiwoZ7TkM613orHjp7A4sSj0eEoKHt6w/cEri5k1doE5fsFzKRJNCWtDIJf/TGYdECO1Mu3SCi/1lCsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171855; c=relaxed/simple;
	bh=6gYqmZjlIbK+gPex3tBu/8cgozPF06E1IvkrFktqKlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PShU+OPb0xg4e4MavxdciWa6yHOz0AFS/BvFVe6G0DJ4QbL+dGzQVJVi9r5pM4ufwdMh9EtOtkMlTkTU7qV9wenYrsHXN2Th7XoDx5PwsIW1BZFjiSGyKhuv1k1HZ2qPGIlGXNVFG+u9vtLblKgUf8aK4MYXjq8rC6zs1U+cP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbQ9T1br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbQ9T1br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49959C2BCB2
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171855;
	bh=6gYqmZjlIbK+gPex3tBu/8cgozPF06E1IvkrFktqKlI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=nbQ9T1brX9pJKz/vtQvzXAHLIkpTRia1JMbtBRynw8i66J8Dei8l3IqWHz8dSITHw
	 ri0b/ikLIuh6Ob4ShoqE62TspoBVlMbSueThvUXz9fL/PpRxIVDV5Z7p/G8XblbWjI
	 KqjTca6LrNli4ZHBkzQEEUtKetGu/CWsaJy6blSPJPmt8ocI3uK4J/Z8opAlSdo0jp
	 X7BcVfkAhksgUaydIxDCgVYbMBYhU2KhaXT/g+TEpSTqyRRY21T6tc+EaJ80LHs1Mi
	 IPgpNeIT1PVpIt7F5vfvra3yj66lB2P0bIsvZIEaJoG/93rJ5xAZn+7GIs5QoqxTWN
	 ypt5XRGDz6WqA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a439f9b43so26487761fa.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 12:44:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+ef4zgOzKFar06uMyxo6YdeTsj5atvPFsZVpRgNCFpOEKoEwp60fKmlhLMxrM6fVIc3IDrnnE61A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHCRaqxtL88Sx5MvsKnpbrabWlzpsohmVCEgUKym4MWrQofFw
	wX5RaCS1Lca64ELZP3wQNhSNjgncI3W8Alf6vPlVL9rWc7zTXS7u4oj6Di8emAy7mdhkcsWn60E
	VfEUAp7DR/lnTcqSvgrH88bVcKB+6s7Q=
X-Received: by 2002:a2e:8804:0:b0:38a:29e9:d29f with SMTP id
 38308e7fff4ca-38a40d6c579mr38932071fa.35.1773171853511; Tue, 10 Mar 2026
 12:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302153559.3199783-1-wens@kernel.org> <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
 <f3ed7b81-4e43-4baa-8a56-b18fa7f56436@sirena.org.uk>
In-Reply-To: <f3ed7b81-4e43-4baa-8a56-b18fa7f56436@sirena.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 11 Mar 2026 03:44:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v65TyEkirWpfynKnSCiuOAyTW1FZQyXncnTFEHGGOQr_Fw@mail.gmail.com>
X-Gm-Features: AaiRm51nLv5COwibdiI9vPOV_lAA38Sg7w2SopLeh4Y8wY_dnKu78qEnGgK1HgI
Message-ID: <CAGb2v65TyEkirWpfynKnSCiuOAyTW1FZQyXncnTFEHGGOQr_Fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
To: Mark Brown <broonie@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Mar 11, 2026 at 03:41:07AM +0800, Chen-Yu Tsai wrote:
>
> > [1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer So=
Cs
> >       commit: e2f93f45d38f7b6dacb44203cfc7bb5d7e287b8e
>
> I'd have expected to take this one?

Normally you merge patches pretty quickly, so I thought maybe you weren't
going to take this one.

I can back it out if you want to take it through the SPI tree.


Thanks
ChenYu
