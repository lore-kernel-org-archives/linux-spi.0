Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EEC2DA759
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290823; cv=none; b=NMW6TO8DF9CVI71BqwXUyglHOVuzvRbX0KwRrO8AL6SOitZPGTl2NpaKPiXBryVvbtyPeANRghGb2a0sj4XGc80W/hxhJTWuO3nbP3lDwRYaGQ8SSq3WLZAN4kWP0+VtSZnP6YzL4dne3BgzYVlh/EYH3vE+X5TB0uB9mNUkQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290823; c=relaxed/simple;
	bh=6I3TCajsnbPhvopolFVK3KO9pDXc1m1XrVrTJSIDMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0cgJQvf4tHniACjE1NBr12Gan6asOQI4undIAaBhU3393ItA4ErALk9bmOXwBZxKHs1blF7lpVzWeGkxwf0mkHQXWWVH8HfABc9X7re+RIc5EpTYW4Tf6rhShO9x7v0sDeNh30qPyI1j97LqSNq8CTcgnJWmgpZxDSJ332L27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIw+qtLG; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIw+qtLG"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12a71ade78cso614444c88.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290821; x=1774895621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=tIw+qtLG94A2vyctJ1nrIkpgQyY6GdyXSxudWeaEhia18nDKP7H2BlmAo+bzO1ezIi
         SZroA2JPns9tsiLeMtLDEP0iBAiDMhPuwY94Ch9vwu5Nb7kzxQKSjlDb4Uno3JOQoPva
         3p2OdOAudQkBOZaHWSaWAPNRZn/OsnD3dJKCN14jNHAD4DaXu3hF0f2dE6vn9ewGTpKy
         D711seWX5f00wu6/sVlnQL1F3p+/WbV/GJbZo+cZEXwy8JMK+t8PCfvRA9LLH51zU9st
         LzGjDoaxrG7NJQ86D9iUasPVzjiFa5zJR7vWcUGVKZIzLnsmNHxMwJgLz8UkPqUu8jAo
         9G9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290821; x=1774895621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnYjc2faOHjkbaG+X0+KOSaQNDxXMdAftkLY6+CZb5k=;
        b=acQkZgfK9M0MbPM2nr72HbHltkNiBJ181M3cMCsESk+uhp7aggQMEU0wlR3rmUz1b+
         tMrDu1nb0AJdHX9xY3TXbrUtPoHLSCWoBZdUvhdSIkGJXeX7dO/QK+kDfG3aH/wN9jNu
         VuRFsz4kp+klU7ZriSYTnJhlOPZsGq52XP87IbXc+AxsJwCWmbV3p6qIW6clC4WBiwQZ
         2/778TLMdJMuR8SHR7j+IVdKbneWumf5pqmrZl4ryCXI76QdiomnZGUaV+8A65z42xVN
         zTEGyBoguU3sfq5Ezo85rkiKfmWN6ie2vCNMt+j8ash2YlTutaAKFXyF8g0G15T8pH6z
         TW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoj5vnRTmpitphwq/tSjzYz7YdIHJdLdzV51WsPK4IBf+aMKkKJHsmhrxqnsCbCl5J6GnoAPnsAgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJb9wuxLlpTaXeHa/opxG0SOYi3PbnY8SYqz/oW+LgivdbOJW
	VCEG9twBy8WDuSSiOy/ZqeUjZjINH4lAR1at6Wxittt2DcEtSyLkrKA4
X-Gm-Gg: ATEYQzyE0au84sEMaHw0DjClcZOomcz+WmcY2fGj3TJazrOPUM3Y49wjLSZoDwqD13C
	WOQX3rQNLUE8jumKfAnsowFGs9t1e+g0NVRBzkkG+XPSDI/F5E0zy1GcTqOXdhMYs4eVIxIvU2k
	/o6UvvN93YWz2CcRxM6w89tMrPGKFiJ4GuXJFWLChoL77aCy42l3BXoJD1RGgfC+vkXLhI61RRg
	c0D1o70DbMJm2DDgFjHUesm3r9J827n+EQ85FGZtTB+FMXnhtz3zqtP8cs+gSx8eeawfrVodZUM
	sKSsM/svVKEdu7dxXtAYSSXa69oS8KDZwGW+DV0L87NB1uqlqSTxEhIhm1WKLBkhvPTCfJ6NLAR
	Mkk4HhqWFbRia/c39dWsSG1tRs9dzz4E2pZUctaZTjNXzm3IwHfeaOIf3JYmjswBp6SEM/275Gd
	1DF8M8oUeDoD+95ChbD+1IavIP/Ni9I5I8ZIb3Ci/QS7UZ9Rds/djxNR71wEHdf23k
X-Received: by 2002:a05:7022:4199:b0:12a:6c7e:bef2 with SMTP id a92af1059eb24-12a72671ad6mr6133919c88.7.1774290821078;
        Mon, 23 Mar 2026 11:33:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733d199asm9391030c88.4.2026.03.23.11.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:33:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:33:36 -0700
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
Message-ID: <acGGWTmSMuc5h3Od@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>

On Mon, Mar 23, 2026 at 08:59:52AM +0000, Russell King (Oracle) wrote:
> On Sun, Mar 22, 2026 at 10:17:15PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 03:54:09AM +0100, Andrew Lunn wrote:
> > > > -	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
> > > > +	d = class_find_device_by_fwnode(&mdio_bus_class,
> > > > +					of_fwnode_handle(mdio_bus_np));
> > > 
> > > When you look at this, why is it better?
> > 
> > I think we should move as much as possible towards firmware-agnostic
> > APIs and use fwnode_handle instead of device_node or software_node or
> > ACPI companion. To discourage this I think we better remove
> > firmware-specific APIs where we have firmware-agnostic ones and
> > eventually clean up drivers that use OF- or ACPI-specific APIs.
> 
> Basically, no. This is wrong.
> 
> It may sound like a good goal, but there's an underlying issue. This
> goal assumes that the firmware description in OF and ACPI are
> indentical.

If they are different then drivers will make allowance for this, like
I2C core or SPI core does. But most of the modern drivers use
firmware-agnostic APIs (device_property_*()).

ACPI has allowance for device tree properties (via PRP0001 HID
entries), and drivers should work with them.

> 
> Sure, looking up devices by fwnode handle makes sense, but looking up
> anything that is described in firmware is not suitable for this kind
> of conversion, because in doing so, you effectively "port" the DT
> bindings to ACPI, and it may not be suitable for ACPI.
> 
> So, please don't make wholesale changes that transfer the DT bindings
> into ACPI.
> 

I am not "transferring" anything, but I want to make sure the code works
even if we augment OF with software nodes or if DT properties are used
in ACPI.

Thanks.

-- 
Dmitry
