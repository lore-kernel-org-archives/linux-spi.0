Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1664332EA0
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294541; cv=none; b=qLJ+Kw9cPKeEChmhRya1KDMimA4234fOJAVAAtOqObB9hDcXtMVWHRtmsBnBC9aNtVgLjb8YbAa3VrAwTVDTeUP6gA4G4qlT1tKJK2+PInia3c2rpbO5x9cO2Jw5k/71RoffRDldx6L9VIr0rNJnl4lKYBLnSsQeXwroQvVMluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294541; c=relaxed/simple;
	bh=kvZQfR6Ka8WnuKuT7mVazzZOQdLKZWJfub3aSBzO8AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2aRnqOJhBiLNLc3X3IQINeCgi+y1ABNX5bEiUMP9gCv7nn97pzFlXO+IqE5sq+MZmg0ZSykus8MFMNxEI6szeQHDOXmYPiO57bJqimQS6tA/V1IsyI0CrnCOCgaj4HDdRAmwlEIibu0mCpZ1PlfZw8HnQz4k8RuC7XsI+pOdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gER+PnsK; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gER+PnsK"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a747e7b2fso1066280c88.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294535; x=1774899335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsALcZ16tevmJ3ng05DYY6tY5JjgfE8hJRfdYF/sgZQ=;
        b=gER+PnsKerawqjr5zJOkKJ7vn7s58hrCHWcIoAhdjFt27DESMOLN3wTgXJhso3fpuw
         1oIvt7jwneWdajfhCwQDqxinICvxzdiLJJ/5pAuM8lzo8lJojssSseVj/Z+yYJb5ihRg
         inRz9ss6IPHd9r3dxgf4WL074mJb4Lm88olwtJtapzoFF22VtIJyuyr7hwvnGOHdnONy
         tEjrM6FVCh8Dtwy/P/cERijF+kdULjB1cPZoMXGhxXfatDide14gpc/ZqCDTHyxuym8S
         Z8C9QKkA8aT4bmERGg+MrjyS3lFoEcRuZG3AcARhSroaURJIFk3Gp4VEaPbydmm9/Djo
         tYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294535; x=1774899335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsALcZ16tevmJ3ng05DYY6tY5JjgfE8hJRfdYF/sgZQ=;
        b=I2dXqYL91wUPcArrYhrNvAv91Ld6WKbOUT++tcTzasBScuWpxC4x7Hzw7qoJCJCPqt
         qb/S0NkgKqom48x6Uk2QtkjpMAGuJN5HgtP+gAaKx6MhDqv5fTQwJ5UWFRfSMFagkxlr
         bnC3VCNCmwsVjVzsMloJsgkB4IWPci2CmvS88mMK1H/T5mwqsLQlxtmjYUgm4IP8a10t
         xAdWXXjZMyerA8+p9+Bxiy8obt1YwjC6hyOChM6NFiXsP9xxLVvqlgxLVphjq2fdQljr
         PIkQp52/uYzrMRUPSs325ZywhUzqhWwFQlTL4L4pc7YFXLmBK6wxkWNUM3+BBM6B4E/6
         zFUw==
X-Forwarded-Encrypted: i=1; AJvYcCVA+WIG6V1LJJiV2qzJ9wVOTtNQ2w/2lI7TUUM9cCdSRZTa+l+G9FvEQSPNF73X5JRP7c8lRKqoAz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYIBtS2ccX0WSmRLHQNUd/YEtCnfhVD6gGT6Njc9iqWyHLg2S
	bnpufHsFScT9Bj2QXbT+tKQQcNFL2Fyp3cMLhvjuBKVyaBqgEiYDmxH9
X-Gm-Gg: ATEYQzx3roQN/jFO+5T8yO1dbfQmt5cs4u+9zTItpVuPRFz3rRngnvjbKrN5l2FEO3l
	RpSNUeP+w7PV6nNVbms6DzvLgVQCOQN7F68Av2uwKxU+Gb2ElMC9H6tQJugQ/OVASwB8cyEP0Yw
	WlCAnf6ognXXg2Zs2R6BXm90EK0Hby5ggYPD0tBKjFycytgSFHi7Uf9w9FaWXxLLnMNEb7q6ezG
	RadRyHZleyDHbmKHJp00Zt2KtFuHrbq4dHN0F27zEly0nqUBEn7VmIp/fW+zVkLQAswb77b2lKj
	rRgH31T+e75PNYGyb8d5Tm1/A+sILBUbM3h7ZaVIHf/rB+4WDhj0Kvnue21kMRaqUecSGsqjB16
	22n0sqVd5d1DL7kwNIGhjfw4Poyx7a1lA/ZDiG+kQp+JQmAYCL9xaj+QcmAfjDY5GpQWsRYcNxd
	UjfgkK0RlVdOqjrn7PiwmyjROI6bdO6E2X/MxLsfWj02QoPWmKbT3AJq6cg337Wf4M
X-Received: by 2002:a05:7022:6981:b0:12a:6ab7:3f9e with SMTP id a92af1059eb24-12a72671127mr5823640c88.10.1774294535335;
        Mon, 23 Mar 2026 12:35:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17d1ddsm12967046eec.11.2026.03.23.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:35:34 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:35:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGTaZcF6GwkmC03@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
 <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acGI4PI3MHML9Pce@shell.armlinux.org.uk>

On Mon, Mar 23, 2026 at 06:39:28PM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 23, 2026 at 11:33:36AM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> > > On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > > > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > > > +					of_fwnode_handle(mdio_bus_np));
> > > > > 
> > > > > When you look at this, why is it better?
> > > > 
> > > > I think we should move as much as possible towards firmware-agnostic
> > > > APIs and use fwnode_handle instead of device_node or software_node or
> > > > ACPI companion. To discourage this I think we better remove
> > > > firmware-specific APIs where we have firmware-agnostic ones and
> > > > eventually clean up drivers that use OF- or ACPI-specific APIs.
> > > 
> > > Basically, no. This is wrong.
> > > 
> > > It may sound like a good goal, but there's an underlying issue. This
> > > goal assumes that the firmware description in OF and ACPI are
> > > indentical.
> > 
> > If they are different then drivers will make allowance for this, like
> > I2C core or SPI core does. But most of the modern drivers use
> > firmware-agnostic APIs (device_property_*()).
> 
> What is appropriate is up to the standards bodies responsible for
> the firmware. ACPI has a separate body, and we can't just dump
> the structure we use for networking into ACPI. So no, you can't
> just switch to firmware-agnostic APIs for networking.

So I believe there is a difference between deciding:

1. What schema is being used on a particular system - it may be
OF-compatible, or ACPI compatible one, and ACPI may support
OF-compatible schemes for certain subsystems or individual devices, and

2. What is the API to access the properties.

There is no harm to use device_property_read_*() universally as well as 
not having OF-specific APIs at the driver core level. What matters is
schema matches the system type.

> 
> For infrastructure where we lookup stuff by some kind of firmware
> node, I have no problem with converting that to fwnode APIs,
> because that doesn't transfer the DT description into other
> firmwares without prior agreement of the appropriate firmware
> standards bodies.
> 
> This is not "foreign territory" - ACPI in general doesn't want to
> describe e.g. the individual components of a network card, unlike
> DT.

I think we actually broadly agree? What you are arguing against is
saying that OF schema is guaranteed to work on ACPI systems and vice
versa, but I am not saying that (although for some things it may). But
still most OF schema can be handled by generic APIs (either
device_property_read_*() or fwnode ones).

Thanks.

-- 
Dmitry
