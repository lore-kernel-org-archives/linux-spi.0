Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854539B962
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635399; cv=none; b=uff7IbhVP+tlfzJXHQU70oRjvwGZjimpT4xmvR8zd3sUnrdYZEHt1ggRSlF+DVOJrc9N2Rul6wb1Zyf+SYGYznX3bS43zEdeiYyXFSskPTHtUDKEzTKPMI0cs9SWKLOoKLpO42FxYeZRNHA26rz6qeB9f2uGaxlpIr2yDXgwrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635399; c=relaxed/simple;
	bh=qgkECxzGSpnuq07rnxhj52qCBc/KBJvowuMtgBzyENM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL0NjmYMaZHza7G970eYrfTOAgIxkyWrHIvyHD5MRBWVDVtKbPUVNRoZfl9uqZgkZ0UJSf241jcSYkQQOOqPsUGYx2mcekjFjJgapW2SLwM2sUDnJc6KeNsfLl8nJBo9AsZdXgyH73DZg5IZt5PibAlVc0UNWAMPi2+DNf9sVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-953a26a9abcso1438863241.3
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635397; x=1776240197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSjrs+bZCBNPvbS97WPj5GTT7jaQlR+JpRwd/gT2+Y=;
        b=ejb9moN8uw0ll1gHxrEMKfHJYRdjk9V2hUJp/GQwUaUEwxVZtrBpstBOhFGVGGNpe8
         6Wppg+gMdPaLCpJp0t785HmKbglydu4V5ZFT78Y/HEEW30K6H7553wKsNy0y42po0CU0
         UVbclIbs6zkokNU7H7PzuqZE+nUs1GeUftV3mXDYfEjprYcug97skMcI0miwxA+2k6bP
         aO6LpAU7RUOvHsqVZgb4NLNbj8gizSsTJswcw4PQ1uf0ux0s43JfKgwmtroMhcIdTT/6
         MqynMae+JlfR0gMaWF4LWqsX515lnO7f5yzZOrhKWe83sRzqIMITn+mLEjhLMFWwZmks
         CVkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8aWAqaVPCbIEgZV1ebr3XTc8kgCumIWZVDK1kycfSmlYVpHMUjVyHDm/3S2b+BkqwOg/1NDmmjf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmKfl/xrDYfBGb20AjK7ejM1jphZvdbATUVrfFJCF03u8bT1Y
	ob+zpFrgotm6fedZbNk9BGAc8udliqLRwB1hQ5KhKHDkitpAc0el5WXqMO7yaNhj
X-Gm-Gg: AeBDiesHXQdIWyInHWFX/dkvh8uN6L9ZHsM56SiB16zC099ItXLM1ejHZPk+ZDxavnu
	tCv2kOs4qGbjmLidRapyrEFjvMS4x3FqKQYBnFZgB88+quXkPdkpg4YKYZ1HJtJwUQt935wKyk6
	EvxJ/dcgEZ/P95BMZlJHXinmz2Ii1jeHjWf8gpg1WJLEJpP+R9mBDeYiPnSpUL0z9iIDlEgqiCH
	W1LDp+OMnQzKTIdGEDR+Sr9mbl0Lg8rS/5YSoQDT5DpcBVUW+ns7KiBays7hQSLOA/xnpuReOGw
	XGpIaYfhBGviwjN7dRdxVXgdy03BFBBrzMh7Rpypg+p5ZiVRMbxSz5WHDb03C4hAQspp9eNrDlg
	+1bOJWX8CJMxHetTrDPC4iUh+6RT5IqTS3R/YOCOvQb1tZtIffLXW3RmGyYRTHNm6Oxz4RoKh8S
	3Zn660jOyRlldhg3BqFU4ZfqRGr0cYFdrsy/PdzhnhzhWHnaXE8vIGnq5VVqgp
X-Received: by 2002:a05:6102:3052:b0:607:97ef:4dae with SMTP id ada2fe7eead31-60797ef5323mr1244277137.16.1775635397319;
        Wed, 08 Apr 2026 01:03:17 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb7f08f7sm16390037241.2.2026.04.08.01.03.15
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:03:16 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-604f834349cso2267026137.0
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:03:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkBqmaHUba08AJF5PAVzemrFxI6rX0eIzH0P4IaZNghhxA1ogRidsyw2BAIyt1YgbgMTRkgpZGMxs=@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:607:9b47:81f2 with SMTP id
 ada2fe7eead31-6079b478f09mr649179137.20.1775635395263; Wed, 08 Apr 2026
 01:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-2-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-2-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:03:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
X-Gm-Features: AQROBzDnP0FsdrSe7kiaKBzgO-Rt21-zwjAE4PjirQbwD7WYIqJw4iFM_IJ47Kw
Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
Subject: Re: [PATCH v6 01/27] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote:
> From: Saravana Kannan <saravanak@google.com>
>
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Mark Brown <broonie@kernel.org>

> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>                                  "Failed to setup timing for '%pOF'\n", rd->dn);
>
>                 if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> -                       /*
> -                        * Clear the flag before adding the device so that
> -                        * fw_devlink doesn't skip adding consumers to this
> -                        * device.
> -                        */
> -                       rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                         if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>                                 dev_err(&pdev->dev,
>                                         "Failed to create child device '%pOF'\n",

Note that all these removals no longer apply cleanly due to commit
f72e77c33e4b5657 ("device property: Make modifications of fwnode
"flags" thread safe") in driver-core-next, which is gonna complicate
backporting to stable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
