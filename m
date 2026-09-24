Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1E4252B1
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236115; cv=none; b=YAbbO34aO3+hKGhJjJfGkr3dU6u5mT82et2sm5Mu3iXrqPlklPvgPrHzbe+ahgr98KVMlk6vP3EwVjY4G8NNdlynMLswoItvo5JnM7RZ+uoYZXyzp5btXG6k9xhchN2zVphSelf03Z76v18KNB8wfS+p/qXcp2MSSuED1c7BeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236115; c=relaxed/simple;
	bh=A8WTWhNhNuSxB623cTRdYNlcFkXQibSEnzVrW6erpAI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sV8+01iIHfdpRVia4gji8kPPpSW/s7C1gFiKhBE0Kkkujhxtru2GbasiQ0W6nNVxSBFroMSGvxIRwU4X/kP6UsBTsPCU8I06xR9tIBG5jA2m0RP8ETR6rRAnk8wwzJfCbqFooLepww4JZPs6PFzvJ2zhj2cnO4AQSbJfYh/DGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5HvV/cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5HvV/cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DE11F0089D
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236113;
	bh=fy0+KiYRcsZU/ymaImEymSgtU/XBNCGbs6mGpoeZE6k=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=V5HvV/cppc8WVHeYIUCIXT0ZwvIwN5DV+RLZY47pD8guzaGDfj/dnMoFxRzTTHB0n
	 /38S30rCAnpbGCsd4ksLMB4e2lKDjbDv0+M/tFkBlxKX7dsniGIUsVOYXXUV3WIwXE
	 ZOgalRrjGdyy7odLe9kgx9Xb+uVpOMw+fNPt9s7q70KWLEvPZMRPseT6iYC8meocf7
	 TRAECxi49YbEyKyau2RPZ8iRxs3TXum6k6LuN9Cwo/PsYAUoxYSJeCRgYr4tW1smvl
	 A2qEwYhLCC1/82PR2F5GaoUW5uN9z+0RsK++iwmmyB3d7v9Ut6rUJA77I6tavwLCyg
	 C1mOLaiU65JFg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b76668f4ddso603119e87.1
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 00:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBybCaMqFyABN/8hEIeBcHy+fKg+YAIq66Irc2bIFhXu0HsxyBKu58Qx7Khw3zF5lP2G5bISpc5o1T0=@vger.kernel.org
X-Gm-Message-State: AFuF++l0AeBHxTnMN2HbfLL1tHZ4EUYLiCieIvHR2rQnTzBJSNROzALx
	Y8Jb5w4PkcMCFoQ4WIR8aSogwA22TWIlVTYImgJNVSlXNed+R8FwLDhJWAEV4o+esYHj78W1GHn
	b+NzcEHl3Pv3lG2M+mSBx/7Rb1UzEyTRiZsRJ8bUvIw==
X-Received: by 2002:ac2:4112:0:b0:5b6:10bc:b86a with SMTP id
 2adb3069b0e04-5b8df0e31cfmr327732e87.24.1790236111912; Thu, 24 Sep 2026
 00:48:31 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 00:48:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 00:48:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260923184450.135601-1-2000.costalucas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923184450.135601-1-2000.costalucas@gmail.com>
Date: Thu, 24 Sep 2026 00:48:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeqkCM=QP_mUcGg130UrjnB58S9j636zZqriEqEVdGGXQ@mail.gmail.com>
X-Gm-Features: AclHuK-Z4kbLfsNuY9cD-lwa9fSqwcZM3BY76R7SUB6NbTYvyq7es4e_Zfoq3eY
Message-ID: <CAMRc=MeqkCM=QP_mUcGg130UrjnB58S9j636zZqriEqEVdGGXQ@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
To: Lucas Costa <2000.costalucas@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, bcm-kernel-feedback-list@broadcom.com, 
	linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sep 2026 20:44:50 +0200, Lucas Costa
<2000.costalucas@gmail.com> said:
> of_find_compatible_node() returns a device_node with its reference count
> incremented, but the function bcm2835_spi_setup() uses the ret value
> in the loop to check a condition and never releases it.
>
> Store the returned node and drop it with of_node_put() before breaking
> out of the loop.
>
> Fixes: e19c1272c80a ("spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lucas Costa <2000.costalucas@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 8f8715809c7c..8909757c94e3 100644
> --- a/drivers/spi/spi-bcm2835.c
> +++ b/drivers/spi/spi-bcm2835.c
> @@ -1226,6 +1226,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>  	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
>  	struct bcm2835_spidev *target = spi_get_ctldata(spi);
>  	struct gpiod_lookup_table *lookup __free(kfree) = NULL;
> +	struct device_node *np;
>  	static const char * const pinctrl_compats[] = {
>  		"brcm,bcm2835-gpio",
>  		"brcm,bcm2711-gpio",
> @@ -1297,8 +1298,11 @@ static int bcm2835_spi_setup(struct spi_device *spi)
>  	}
>
>  	for (i = 0; i < ARRAY_SIZE(pinctrl_compats); i++) {
> -		if (of_find_compatible_node(NULL, NULL, pinctrl_compats[i]))
> +		np = of_find_compatible_node(NULL, NULL, pinctrl_compats[i]);
> +		if (np) {
> +			of_node_put(np);
>  			break;
> +		}
>  	}
>
>  	if (i == ARRAY_SIZE(pinctrl_compats))
> --
> 2.43.0
>
>

Just use cleanup.h like so:

	struct device_node *np __free(device_node) = of_find_compatible_node(...);

It's a oneliner this way.

Bart
