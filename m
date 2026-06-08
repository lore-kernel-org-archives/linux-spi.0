Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE23CCFDB;
	Mon,  8 Jun 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929182; cv=none; b=gOk85ewWutPO2GenUw0b9YWU7l6Q/RTwhj7G34Y8ia4eXk+mxMjRsEAim1+4ZV0IGNj3yK0rrlDeZ9YzUOSXy9l3+292V6n/uCpUN83hCONpfFzAZMbXb7fMkQ23XP9UFSLBdu3ET6hmHUoGW7TQsmWkpgwdDBif5r6B8GSFcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929182; c=relaxed/simple;
	bh=Pr9eqaJY5GiRXhXqVcRp8krosz9a6kRtEH7xau+kdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt4g+TMEfZkdBB5WSXaxlNDgCzkiI8pVyfXpUXXJEZsc2tF0ARPMZTfvYcoxp9phO6j+n5Gj723RJzCoY9tY+Z+Rh6s5w34gixlYjuTHO+I+ddgwDB7zr0UhKpuqorZkNDDkfzNiM8Da+LB6XfTQe64cwUfzDBdNAwwNhnbT2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyWRvOt5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyWRvOt5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AA81F00893;
	Mon,  8 Jun 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780929180;
	bh=aDE4Pibswk5HFQAZoTvPpolcswnIs7t/D7Mgu2GT9FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyWRvOt5WmS6vhlBqHoEsC1V57CsT8zNavt5c1XkEHNxn12IXAGsqKVnwOegxSoPf
	 CYTuDBr0xmv61PoNlL9Wlwm4zozkTtSp69PJV6F5P4JbEZsTNDW+44Imkgdko3IgKY
	 GzGXhGfEGNgVi3behteNn0b8NMKFG74jxm2uh/oHowx7pG0oTawkwXOI4WfXT/7fXF
	 wjC5IEzyE+cKpArncg1oxGm5ma/a2Uv7vAGsEP77ZM3JXs/whSUmvG8WMPOypLjNf9
	 gf4Qv73mQ43/Tbgr+pRR/yOyj1s0P175X35gV/zwjadCBtmVhGV/TUAFTfXuanz62W
	 KoNfbQcb/Fy3Q==
Date: Mon, 8 Jun 2026 09:32:59 -0500
From: Rob Herring <robh@kernel.org>
To: Ninad Naik <ninadnaik07@gmail.com>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
Subject: Re: [PATCH] spi: dt-bindings: octeon: Convert to DT schema
Message-ID: <20260608143259.GA2569066-robh@kernel.org>
References: <20260607142356.2844008-1-ninadnaik07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607142356.2844008-1-ninadnaik07@gmail.com>

On Sun, Jun 07, 2026 at 07:53:56PM +0530, Ninad Naik wrote:
> Convert octeon-3010 to DT schema
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
> ---
>  .../bindings/spi/cavium,octeon-3010-spi.yaml  | 67 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-octeon.txt    | 33 ---------
>  2 files changed, 67 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
> new file mode 100644
> index 000000000000..3dbbb4f3c104
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/cavium,octeon-3010-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cavium, Inc. OCTEON SoC SPI master controller
> +
> +description:
> +  The Cavium OCTEON SPI controller is an SPI master controller found in
> +  OCTEON SoCs.
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>

This should be someone with this h/w. But there doesn't appear to be any 
OCTEON maintainer. There isn't any .dts using the compatible either. 
Perhaps this driver and binding can just be removed?

> +  compatible:
> +    const: cavium,octeon-3010-spi


> +examples:
> +  - |
> +    / {

Drop. You don't need the root node.

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        intc: interrupt-controller {
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +        };

Drop. Examples don't need providers.

Rob
