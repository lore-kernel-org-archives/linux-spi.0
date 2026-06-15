Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B68298CAB;
	Mon, 15 Jun 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562003; cv=none; b=llykMQgxmvJWEBLIEj11U58treyX1RogCR7d3FxdFSiTnMrMwbrkZWrAQUPe8UtFpU7aM6QOpR4CA3bFnA8tXrD5ZTQ5e9qXlJaL59IyS1O1FS4UVKvF8t8jmC1s7ZvXZrbUKmYA6xJM37se8yqGwqFVfj36D6ePQBmXmFR2eUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562003; c=relaxed/simple;
	bh=JDEqnZn52hZmi3gZV5sDDioiTbJ2eh0scnxmG5HJgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhkQ0D7bRo13zHJq/LinV4bR7ycUtmIBnYm0mtpMMuM1AnIjJC1iDkWPP32Lx+L0VviEA1qyq6bHr+UbR/lP0eKYdOtV7ArpnTfhEkB+ZNvnM8+JQubKS183KDBjqJmq7NNtCOi0eBnNXndUqJlRR5zeqUd4db+aknKg0XBqX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgjGGgCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgjGGgCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53191F000E9;
	Mon, 15 Jun 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562002;
	bh=S59B5iEoxKxgkxdni1SOgQkhWceDxo41odxPzintQYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IgjGGgCwGb9apO5vEyKF+mFUUEMZfld7DrO0NMECnlbzN2jUAglxV2fsBKnaYaBNz
	 wx+EMp5Wgo+Vfd2W9g2GHRoNEEfWqVEftyDuCkWtFKwhmKJf2i9pgFDzn38y0ouMQW
	 8Z8bYzdoMfqFzPK3aq/bDx9e8wBKUMcV1DCzulGaiyQS3IiZChDo4DaX738FB8uAdD
	 i6U5bSwCkF/yHD2PL5bG7J9ONO242nx3ltTOgJbGHX9GnKjEMi7TpWTKWupUIEM/Ye
	 egS+VxeMHeKRd+kGtKnU40kYHbnTGgT8aEk3pMP9qMW6t/cVSUl8+hAAQBeqsPNvs0
	 x0VaivFmaZPnw==
Date: Mon, 15 Jun 2026 17:19:58 -0500
From: Rob Herring <robh@kernel.org>
To: Ninad Naik <ninadnaik07@gmail.com>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	david.daney@cavium.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	me@brighamcampbell.com, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] spi: dt-bindings: octeon: Convert to DT schema
Message-ID: <20260615221958.GA1821217-robh@kernel.org>
References: <20260613192233.2229933-1-ninadnaik07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613192233.2229933-1-ninadnaik07@gmail.com>

On Sun, Jun 14, 2026 at 12:52:33AM +0530, Ninad Naik wrote:
> Convert octeon-3010 to DT schema
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
> ---
> Changes in v2:
> - Change the maintainer from Mark Brown to David Daney.
> - Use soc node wrapper instead of root node in the example to handle
> address-cells and size-cells requirements.
> - Remove interrupt controller provider from the example.
> 
>  .../bindings/spi/cavium,octeon-3010-spi.yaml  | 61 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi-octeon.txt    | 33 ----------
>  2 files changed, 61 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-octeon.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
> new file mode 100644
> index 000000000000..e35e661d0a58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cavium,octeon-3010-spi.yaml
> @@ -0,0 +1,61 @@
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
> +  - David Daney <david.daney@cavium.com>

David doesn't seem to be active and I'm pretty sure this email doesn't 
work any more. Just put me if there is no one else.

Rob
