Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034B837649D
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304459; cv=none; b=nnGjYZ3Sn1uGnuwTHzH4e/D7uKZrC/NQkLkt495UdmLslktwghw/kJ5bbV5wQISocXlMqXNgJWx7pxYADVwtM/WqJ9hmEAo5Vd9e9hmQ424J6nbrWr+IRpBGdY/VO8bTW6LlTu8CJe8oM2WnoBVpwAb/tTgcnyrIQpHBpUdUFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304459; c=relaxed/simple;
	bh=qqUgVu3iIB9dI3QgPpQ/I+hkv8Lf18eczVPIEmNZ104=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlLjoAbW61eV1MVfY674q6KmmiZzqgy0fggoNNv3NrhFW7mi//PTV1mZc5++yv524kBiES8mMyU+YylatGSBYlIhVvXHSupPgCpB1+rzJbLfEXf3XbKfWPNCCHzB69Uy4326wBlZ7xZF3PxCNo7vQeSv1agIznMDl+eCnDL1P5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+SKwuKj; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+SKwuKj"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c0c955a481so4047465eec.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304457; x=1774909257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kzF6SFWkNpwiVT7Tzq/JseNp5uopL7N2rNpwm2glC8=;
        b=G+SKwuKjoYWyLKf8QBIlUiunM/B9ly0uajRi5NpWg7loDqllf8SJ4LJ715Hhu4fpQj
         9pOTFA11serRiqEqRTFAJKW3yUed/hz0+ug/1BMf5gjEzTOT9XRtUywVQe9yEYFuKLrp
         fGY7t8I8clHj93m6jnZdSJxm8jviD2C+6z+gVqJ9VFZwGOUd5KPRAocXPM4bjvGuq/CA
         oaVukfDr5nWmw0YYLZwX01d1qL2DAjl7E6iAftQvBKhcqPREFhYZTDlSQVLGxkihs6Gj
         PUW0kEVTYB8kRHKOD9KCTjW9y+a1un5l/PygVk8Ek70i37H6PRlp50FBVTzI6yLiA9jf
         +cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304457; x=1774909257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kzF6SFWkNpwiVT7Tzq/JseNp5uopL7N2rNpwm2glC8=;
        b=ZORtCibi6FwK61qQkC4JUlt+thFDxqdgowwtsXSPn0bb2hzFlrwMsBQqjIgS5+9YOV
         aSqbw6UngEN19MYnlMxlJMaZsdWxQm55uqf9usBVJLHnc0NsNUK0aDirXZC36GptUQGd
         QblY1zlFLFOJ/eyvb53wq5ncVco/h8SEqb2DJOlwJFUUxB+loNmUsSCm6asDr2VZunNS
         mxLCpo8cJamqX+f214/gvlg5C2Eqk46G9qGmK9ZqTMUYjeaap9pSTQsL7qKmY5MY9jpQ
         ltoOp+nyMkwWh7MakCW+NEJ1NmpMQxyum4bjv8HSIlDmZEVuKqCgM9LG0Vxir2ynd2xF
         8+tg==
X-Forwarded-Encrypted: i=1; AJvYcCWYfTvxJXmztNduXWfIr5RlIHNyl1Ve8tePb95Ls1mhgCzEifAP/O4HLe886Tw9oWP6+UxlfaszW0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBvOc29QhWDtR469rLACwz/q6ViLAQp5s3FnCUNEyFNVjF1GL
	1diAY1oBaz6gMMfmVt+3UInqE+JtEm3INAgQFqUqCdr/6Tor/y1dTS4K
X-Gm-Gg: ATEYQzyFxcRFw01ZkzAy/kfLRR14wuJr3Gg5Vh07DuNYmO58WCCBDCmOGShSFXzPcUJ
	gWP7AuEB2IgAc0T93QRMDa0r1r4WDrEvr77OrJfyyg8s+na38KsQvJ15zdPTuuPDipsQ6XX/N4z
	58yM+NBh4t3jfPCUi3H458XEfBOHz//84AVHolr1Ce9bUiuNdAgoN0BlOnQSzeVVRVSxHES6Zwl
	wXLgr/tMpqp01tjmSvQCfk7jiES6IckdaeDD0IskeBbQphGRBB0R+QRjaoTYtoYsXOE9GzEbhf8
	Kb/kEovtfx/4u6FGdzlSRPzTZDnHwI4BkahiYBN1RORqDFD9RTyQFl9RMw60J1J4j4lUkn9/vyc
	F9DwSLl+610gkxUJCGGOM90Ylh9Q0f/D+Ycafu2pKatuT8ZCtzoCXH8SZJ3wbkV25C+1D+rBSTS
	ekgtYSmq0roEDKEoYp+rXMuw0MrTuxRYMKvFf0kLpy7iZt3ItuRGTu8+xj8PGGCXoT
X-Received: by 2002:a05:693c:3b0b:b0:2be:ca4:e119 with SMTP id 5a478bee46e88-2c1097abc22mr6650334eec.30.1774304457110;
        Mon, 23 Mar 2026 15:20:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm16033079eec.24.2026.03.23.15.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:20:56 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:20:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
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
Message-ID: <acG4hY23zHHCRywx@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
 <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
 <f37684ff-57af-425a-bb18-bd5e8de3bba3@lunn.ch>
 <acG1JNGVBJ2Mf7jC@google.com>
 <f3c51f5d-e001-4a6d-a219-f2e0698f35f9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c51f5d-e001-4a6d-a219-f2e0698f35f9@lunn.ch>

On Mon, Mar 23, 2026 at 11:00:05PM +0100, Andrew Lunn wrote:
> > BTW, why would not we want to push for the unified binding? They are the
> > same pieces of hardware...
> 
> I don't think the ACPI committee would be too happy if i ask them to
> throw away their standard and just use DT.

I meant if we are introducing a new to ACPI schema... Not throwing away
existing one.

> 
> ACPI and DT are different and we just have to accept it.
> 
> Nobody really cares about describing networking hardware in ACPI, so
> there is no need to support it. KISS and keep everything DT.

OK, but even for DT I think we should be using device_property_*() and
fwnode_handle.

If there is an ACPI support for mdio it is perfectly valid to use fwnode
handle on an ACPI system to locate an instance of mdio bus. And
hopefully the caller of this function does not really need to parse
properties itself but will use mdio APIs (mii_bus).

Thanks.

-- 
Dmitry
