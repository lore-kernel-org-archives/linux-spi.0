Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374923812C7
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993887; cv=pass; b=EXIdC02B3KPf3zMgkSo/5lC/s8ZXbGPXrw47hZui0zsrpOHTy89IUiBTDvwnuycYA6AG2NCJQNSwdk1dEiM6wEHYWUuU5MRhM0Jd93QY9Ri14occb+XMjjYeKLHTvVPRUZ7ackDMp4CZ/3CsthwB8pCJ5pwst9t+iU/N9TDV8wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993887; c=relaxed/simple;
	bh=uTnougUIG5rsOStz0iODpKJHP4inO0xB8c6yl6xAlyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXhW0kl05gbbWgBmDrJ31YSpeDcD3WpNVwXoEYTpICmA/6jUkpQh+v1HnCIYrcVLrzrKRqD6U2IKcj9In2HPnh+rdYhUKgs6TE2+Tp2P1hL2SbTMxPkSc55ZXhDdnT62/Y04LSR2EmWE22jqR28uuH8HSgH2x87oZXzoET5Hd0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHxne63W; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHxne63W"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so4946565e87.0
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 12:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786993883; cv=none;
        d=google.com; s=arc-20260327;
        b=SouZfsQ6U/JMwE5QbTDRaEVfrJL4uhdr063HScyZVqEoQOl4X3UEKZC9r1jRA5ba0j
         g63GK4bQnjyeRo7IdPpAbz2Gni3wDotOzv7MPKXt+QzyWGfdGLLOsqmuYlC0KYAO1woH
         4Jk8dg4atYy+SzctL4g7gm6kYDOqhaoUZq2Rcu/fhpWzgD3cKgez9E4sFYfMWe5M9OPz
         I35exVQlwLMlfvQyK6xkM8aIOtwTGBqO3Ae6KeswsMCX0XgrtyM+klWya+bmekUYiqxj
         lphzFGhzZ2NWPcvixzllgTB6k5IcM5hTEDwYmiVd6vO53S+sfqEt8lpu7OE9YvXNxAnC
         2PmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
        fh=mbRctZxap1V46xuqad5Ud74ZhQdY6vremG70zVdZyag=;
        b=Ogh9iafMX+34ZO8cfBFMeFJrj+FqdnBLhaFkGr0kAtgOi1N19d4BdSeCBC0PGd9Ks7
         CJAjSRTysHGmIS5hcoHdNHtv4yfdQj5GEna9rXzz3YEZrHz/bhhUB8XS3V1jgTbR3+wP
         gvE+egsKkkV1clu3a1R2VJD/luOm0M5ROitBpbgKGpFI3RSWz3joy/lLNJ2ljd+Hbnjl
         J5EdTR3W1c0UYBe4cyOfhvChiWQK9Bvd9xV62dGZTd3AUlzNYOjtOwzdQsBZWRSuy8nR
         NXjeKOv9Io40rotIMMveW53ajAOJD3eUsJpMBZa7siUEFP5Bf9XwM2OvWAuRz1RmxdQZ
         m6+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786993883; x=1787598683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
        b=jHxne63W0n5Vz5scXxk67+eE/3f3mxoUPN/Kndvck5aKDlgma6uUbWOuMkyH7zdzUL
         GvNL6E7kVhx2gi1RnwbPevdGEvNwrxLwJz+XzBf/swzlCGy0yvpsKUgGiMj0FpM2qPPl
         C0grekBaUPzI0ESDFIm9ZGk4Yo3j3sy/7DHrtL0kr0kgdp4QU1+nmQ+rOkyYmDA+hxXB
         rQHGKbn02EggaRDrTsXr9RRI1rL7lhKvXVf4F2yscXU8HkTVrw2tiTVY4nBdUOycz08Q
         NOzaN+w3flboeNbTvBZfltZi53jdTFWSFI4T41I/TlXAcjAjJlUl+vNiosBdntoBIXow
         Wp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786993883; x=1787598683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
        b=SOwHG8yeMBJtURrNNnZU7OVKcEfV7IlBhKs2AFAih7sc6g+39s8j5GQGrpbAKeg/9K
         DWGhO6o1UP8j69y88BVLd1z0iRHpFdvm5Kc3/Gi4pW42lFzuJz7aY+iQl8kyahoFD46I
         1jLcsUbjuocuakyI7CcnsmDzUoHRGW6rBUvFX8CDbFOJxwzqYqSYoznrecW9E2oT3w71
         KldY5ZZ4mK715S+WiwxrxOxNlgBlk/BUgwCQvg36qDyLMYBeMW0vvcugPCxMqNSXAHO4
         oxkAG/ZWGL1N6NDRtKpAhjFms0X0aPP/5ow2vJsKJAlFW4DZh5wn/4R1XpsluYpGK90G
         Fz/A==
X-Forwarded-Encrypted: i=1; AHgh+RrfZGE4IHm/13WBsBTf0XycE/sfu3ADm4YDSGOOP3SLs6JPqnwBWcp7ZVGzT+1aqnUTkF/BFGvvj08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6LrwrGT6S9z4EYjMeUT5IEzbMlK1bWiIz6DZmhZj44FuMduS
	XepTHqbT1PaWVLCt8ZaTFdiRzHfmjymIkJvgOmNzHuiIqlqkr5yaYXnum3dzLH0tOeftbDaY5mU
	PSZw/8mvg7IAhC71vtbugDHjZZNbyXw4=
X-Gm-Gg: AR+sD103ty99rxbS6PY+eGCBNTz1Knqk1Rlo28KqvVxRngLEMkiGrfTUAXEYeOXQlAp
	WuehS0Q9Bg6TNsGQr09Cx08SV4AUxeUwt7Zol3CTe6XilG5/ofTK6MrBlNFXgvfuDYfxYIAhvxk
	NgzHSECoIfBg2m4fTR+D2svuulW29J6bjU7OZOvz8WZR+2f1ZID0rxBL3sND3ICzyo9BGdv5oGa
	zQKcwQ09sK1u8Oq3UHExtQYHjhIzNK0drmj07JYoiBeyUUqKx15R8qldMA2fsSqR7FqK8WWPkSO
	ivTR7q2Pox8RnM5Qd86+/bDNFEahkKtYUHrfDgRrCrCLVVtThbhNPbh3uwsO3n2RRf4kOSL54WJ
	XY6s/wLpZZqLaZmh6fdiSNo44CoIHeQ==
X-Received: by 2002:a05:6512:2382:b0:5b1:4e5e:559c with SMTP id
 2adb3069b0e04-5b47069e8a9mr442389e87.30.1786993882910; Mon, 17 Aug 2026
 12:11:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com> <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 17 Aug 2026 14:11:11 -0500
X-Gm-Features: AcwNN1VtAz3TzQxDcDRv29ZIlK7LcvZGlrKziZlK_QH60cI6-b_6Gt0v_fcOAnw
Message-ID: <CALHNRZ8F85rJZ4+v+B_jsETeG9cUJWeWSe9vw77AVHcRMasw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
To: webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Mark Brown <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 1:47=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Without dma enabled pio mode is used and flash storage such as the one
> on the p3668 module times out and cannot complete any transfers. In some
> cases, these timeouts cause hangs and cbb faults.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 1d659454a6f9fe..e2ddbc6715d5e8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -923,6 +923,8 @@ spi@3270000 {
>                                  <&bpmp TEGRA194_CLK_QSPI0_PM>;
>                         clock-names =3D "qspi", "qspi_out";
>                         resets =3D <&bpmp TEGRA194_RESET_QSPI0>;
> +                       dmas =3D <&gpcdma 5>, <&gpcdma 5>;
> +                       dma-names =3D "rx", "tx";
>                         status =3D "disabled";
>                 };
>
> @@ -1013,6 +1015,8 @@ spi@3300000 {
>                                  <&bpmp TEGRA194_CLK_QSPI1_PM>;
>                         clock-names =3D "qspi", "qspi_out";
>                         resets =3D <&bpmp TEGRA194_RESET_QSPI1>;
> +                       dmas =3D <&gpcdma 6>, <&gpcdma 6>;
> +                       dma-names =3D "rx", "tx";
>                         status =3D "disabled";
>                 };
>
>
> --
> 2.53.0
>
>

Thierry,

The driver change was picked up some time ago and is part of 7.2. Can
this be picked up for 7.3?

Aaron
