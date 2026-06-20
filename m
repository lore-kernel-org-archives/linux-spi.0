Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C2B1A6839;
	Sat, 20 Jun 2026 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781936617; cv=none; b=kzau/BgJfD9ic0XKIeTUD4YyacRJjm0o9JPtkRFpLAUwUeezycg7mbqcgXAoCkRHlTkU6JXTs/xwS7pesFuW778o3IKxpSV69oraRgaOOPGS9XyFpPMN709rDB/TtP+HkayPDZgRGp0IUOXVshPxl7bK7zm4zzU7lI4prRtIk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781936617; c=relaxed/simple;
	bh=5bu9I08ZUuF5kSQjy516cYVA9gaiA2UeYrGJq3GvJls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKgnNjDAa1Zadumy2IlLuMs+qVv5PT1pvdMdjImwCjxaHUUB7dYYdPcarvRxmdYxsI3/GJZxTS3Y5XHUT/jU92sQ77FwFo9SgLWYIvYFfu4fGxgZvv/ivYDwzBxhb1YehIVkjhsp5k+sfarFBJjqELMj2P+4cA7Xbhe7AG4nrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=YjMF5tHq; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="YjMF5tHq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=JSpFgV9vze6NzxWv7sBTl3aOrJeNhaz31em0Ltb/XOg=; b=YjMF5tHqf+RJPNkEaHwlaLfufu
	nx9EM/X128U1AlQFofuBYY6QszUHNmjmlL8S2dgpir2vOWISmPkBy0xmam93Zo/csenHD2kcM1qsC
	wkM+nqxzdA4CiPWa64gEeJoznUhVW4UXF6WuhT9utJa44L9WH+cdxge/uTQvzi6+bEa246QpqjOwU
	kpAT/gzwfCSRh37Tx8D+5J2lH7d8lMYLpA8F3IqcVJcvHmuCCNU/boSbmsLpFAQssKOi/WgYulvHw
	SE1Zeg7WNtwmPKctvyjIgJEliXOZ6L2GGaMZ1yvpyjAlQIdsctk5DNoqMhxq6YiH0GCeBiINeZSbE
	yxCFTMtA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wap75-000000006gB-1STs;
	Sat, 20 Jun 2026 08:23:31 +0200
Date: Sat, 20 Jun 2026 08:23:30 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Zhengyu He <hezhy472013@gmail.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Wei Fu <wefu@redhat.com>, Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: add QSPI support for K3
 Pico-ITX
Message-ID: <ajYx4oI7SpNs5aT5@aurel32.net>
Mail-Followup-To: Zhengyu He <hezhy472013@gmail.com>,
	Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Wei Fu <wefu@redhat.com>, Cody Kang <cody.kang.hk@outlook.com>
References: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com>
 <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-2-52bce26e5fd8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-2-52bce26e5fd8@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2026-05-21 22:44, Zhengyu He wrote:
> Add K3 QSPI controller node into k3.dtsi, and add related pinmux
> configuration.
> 
> Enable QSPI on Pico-ITX board, and describe the NOR flash which wires
> to it.
> 
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

Thanks for the patchset.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
