Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F136215F;
	Fri, 16 Oct 2026 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792188131; cv=none; b=UfMZLtqrzq3gHC+N0+cjH9iszRmIhyjjeNIXHEi6ibDzu49aeQ7d2YeHWJN0VWIiQkxuud7m92PVn3iONU6Ak7S21sS+Bd7e6vTFbCssCzdWUoZu+27o/KuRFECCDlwrpIhAjbaiQ+hYnAaVrQoGz/yc+E2tWuHESTTW25Haiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792188131; c=relaxed/simple;
	bh=VI5dCAsatWzoRzLT1eMR8XekoLKZftli9MyIrQXdlss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgofnrLV47Sxb0t991yGjB5gkMXan9pmzAuwukuxTyHzT/sfQ15MhvAlM6cycTuXuDN5LsEkKa/qhUTSFk49wBP1s8Er6+BJa2viPzqjnkvWuGJMFyE1t3lXpu82Tu8qp8grTVyRNurapTzBqDJB1v4y8qHbP0w9Gj83bc/j6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AME6LfYr; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AME6LfYr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEC0D106052;
	Sat, 17 Oct 2026 00:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792188123;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=bWnUf4jwakYkYIidTWKbDn//BfJM3tm/DiHDz5Kf5tg=;
	b=AME6LfYri7zVQmP6TAydlVYRrZ8Fux7U5wGhInUacI/fYgIQkQwhL4qjmB4slW1ROXVMxQ
	q2uhH5shCEljmEXA0hduc2d0rdAjPwxHbDTYM2Bictwfljrg+dU8ZiG2nwLmsCrbDSAfik
	/jao6qBl8BXVlucf7hB1ITdIGz3T36fIp+LadazCVG9BDG0LvV2lAgJytCkMZQbLWmF1NB
	ZdV0QrtGU0DvABR6gIi/tXgrCcoVas9EE15gZ8DktP5dN9frhtdSu08ZbLC9Bu2ayxEEx+
	Gw/2m1d7xzLrK/n9Gq+ICLqCSPl/1ctHZz3rd2UIbj03umdr2PC7h42GEW1ShQ==
Message-ID: <e7095176-44b8-4838-8443-2e515d34cb25@nabladev.com>
Date: Sat, 17 Oct 2026 00:01:55 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: spi: Add separate binding for
 dh,dhcom-board
To: Frank.Li@oss.nxp.com,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: imx@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Frank Li <Frank.Li@nxp.com>, Ashish Yadav <ashish.yadav@infineon.com>,
 Colin Huang <u8813345@gmail.com>, Sanman Pradhan <psanman@juniper.net>,
 Thorsten Blum <blum@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>,
 Eddie James <eajames@linux.ibm.com>,
 Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT"
 <kernel@dh-electronics.com>, open list <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/16/26 10:57 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
> which are not permitted by the trivial-devices schema. Move it to a
> dedicated binding file that references spi-peripheral-props.yaml and
> explicitly allows those SPI mode properties.
> 
> Fixes below CHECK_DTBS warnings:
>    arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: '^pinctrl-[0-9]+$'
>          from schema $id: http://devicetree.org/schemas/trivial-devices.yaml

How come this did not trigger until now ?

> Assisted-by: LLM
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++++++++
>   .../devicetree/bindings/trivial-devices.yaml  |  2 -
>   2 files changed, 46 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> new file mode 100644
> index 0000000000000..ed213cbe9b04c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DH electronics GmbH on-board CPLD trivial SPI device

This does not look quite right, since compatible this is used only on:

arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts

        model = "DH electronics i.MX6ULL DHCOR on maveo box";
        compatible = "marantec,imx6ull-dhcor-maveo-box", 
"dh,imx6ull-dhcor-som",

So the whole

        spidev@0 {
                compatible = "dh,dhcom-board";
                reg = <0>;
                spi-cpha;
                spi-cpol;
                spi-max-frequency = <54000000>;
        };

Should probably use a different compatible.

Christoph, what device is this on this board ?

(and this change should only be applied with RB from Christoph, I do not 
have the hardware so I cannot tell what it really is)

> +maintainers:
> +  - Marek Vasut <marex@denx.de>

@nabladev.com

> +  - Frank Li <Frank.Li@nxp.com>
> +
> +allOf:
> +  - $ref: spi-peripheral-props.yaml
> +
> +properties:
> +  compatible:
> +    const: dh,dhcom-board
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true

Wouldn't it make more sense to allow those properties for trivial SPI 
devices in general ?

[...]
