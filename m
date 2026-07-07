Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670A3B6C0A;
	Tue,  7 Jul 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421800; cv=none; b=fvGzOyPsMUrv/pfX4wYdOX9Fqyc/Ji/Tiu4DOxj3GXoNVH2vzmmedjpT5W/LfyoXfTNLqTA4sPHSW/mKEV2gjxsM0oVHWxiSaWKzmaiox4sCV9Os0OMRVfJJrPtEWNqEOqejlaPT51bgbCKMvj+PjtnqCM73sEUVFS1L2mArtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421800; c=relaxed/simple;
	bh=WwHQN6VM47AmJxyALgzvhcdaNYITjm41qFy4TxKV4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqbtqca2sAmdZgtLky+ERj1Ui/Tt6rAnNX3TOD+bpvgdip4ga2bQ17PzV9cv04QHKHAaJvDlml5pMcBdrXT5jtOz7otOfL6kRJpqbAEfcBUH+zu/fGPAuPcvdUuEenpjdvEc4UDmWb31wEINQAN/bM9nSUr9rbMpRok6RzqQYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNYyDyjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNYyDyjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC531F000E9;
	Tue,  7 Jul 2026 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421799;
	bh=HlQHk4Tx7tHsYHXnfZWzQb7mDrScjAeO0+K90dIpLek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UNYyDyjnm3qVRvq7KqL6v/ExtKS8+AXsBomw2Xit4eO97aY+OJq/g1zNuGj3I/nku
	 Hy2krPzWLY7lcaI/xGZqslPu8jg9mjXtY3I3/WQJ/bX/ibf6jYfdGoaYt9mhO9jH72
	 8BYFvapowIXApXj1Agw/v+GmSdu8kFV6i16waZJppsDXFw0KQ0OnY0a2NKirgRwYhn
	 uzhkDm1jq7sqi+SvSI2ie5z0obarh9WxUxoYT78nLU8ZqRw/7nB/WvKhWL2vxXJZpX
	 rwAkQrpoGN1FIo8vBKM5Qcc9yDOjnDeHWPiLuY8eKHIGeNGQTSZSZZyXcyEG1XpPzu
	 +h23g4UlHd/Sw==
Date: Tue, 7 Jul 2026 10:56:36 +0000
From: Yixun Lan <dlan@kernel.org>
To: Zhengyu He <hezhy472013@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Wei Fu <wefu@redhat.com>, Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: add QSPI support for K3
 Pico-ITX
Message-ID: <20260707105636-GKH35811@kernel.org>
References: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
 <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-2-52bce26e5fd8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-2-52bce26e5fd8@gmail.com>

Hi Zhengyu,

since I'm requesting some changes, so along with the title, suggest
riscv: dts: spacemit: k3: Add QSPI support for Pico-ITX board

On 22:44 Thu 21 May     , Zhengyu He wrote:
> Add K3 QSPI controller node into k3.dtsi, and add related pinmux
> configuration.
It's obvious..
> 
> Enable QSPI on Pico-ITX board, and describe the NOR flash which wires
> to it.
> 
How about combine above and simplify
Enable QSPI with proper pinmux on Pico-ITX board, and describe the NOR flash
 which wires to it.

> Signed-off-by: Cody Kang <cody.kang.hk@outlook.com>
> Signed-off-by: Zhengyu He <hezhy472013@gmail.com>
> ---
> Changes in v2:
> - Add "spacemit,k1-qspi" fallback to the K3 QSPI compatible.
> - Reordered Signed-off-by trailers.
> ---
>  arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 58 ++++++++++++++++++++++++++++
>  arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi | 21 ++++++++++
>  arch/riscv/boot/dts/spacemit/k3.dtsi         | 17 ++++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> index b89c1521e664..e90e17895bb2 100644
> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> @@ -200,6 +200,64 @@ phy0: phy@1 {
>  	};
>  };
>  
> +&pinctrl {
> +	qspi-cfg {
as you've already defined te label, which make it possible to reduce one indention

&qspi_cfg {
 ..
}

> +		qspi-pins {
> +			power-source = <1800>;
> +		};
> +
> +		qspi-cs0-pins {
> +			power-source = <1800>;
> +		};
> +	};
> +};
> +

-- 
Yixun Lan (dlan)
