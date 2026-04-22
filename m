Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E41FE451
	for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879740; cv=none; b=THP0j6m9m/WbIGZoN0nq+xNCOYdVATqS8QEwWvMl1RRvX82vLERcOpIvs62z8BY5JJNUp/jBXWvls/Nhe2KvpPeX+6gW8FmLvLulifY1ZTePoGlFJiT1p9yvCAycmvdIJ7ankJ37d9hTnLXatBprAkbVxoSWqvnW12xXz7DQy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879740; c=relaxed/simple;
	bh=PEC67Z72ISCMHUutb9qe1/Y1CIJmRcte33AN4p2R2vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh3h080YlVqwhYKezryZGX/ZlLLLZZ2qPIpyZqNUVh0h4G5xUX96DDnoVZOJUEnFPnMXuQRINBu8VCKjSDMK14AiAUD0rYNEn/X8Vf0ow/rjoXuBKEBoSWiou+SmnRJb7e5uYTUv+z2V5KWP8wtE2vBEzYaMq6KpRV+9nXYhpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e68e4389cso61070321fa.3
        for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 10:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879737; x=1777484537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XycB5P8XTGXaeVGqnVmOVfspQ1laZv9fkJpPGtynpSA=;
        b=fxh1NHhmXDl63bpnwGZ2CmnE+0P5iCmJavaTPQ1ZZgS+6crS59jMHm7gtYWjUFwY/I
         aS7VrsoEhYIZv8hq/vJ5nPQxbLz6W6km2WT4rhYrQNUcZC3TcUf/Umec98qroH34AX7B
         PCDwHCDkmAgPVoGhbpdP/33e9CL6Ixft0wTSLNymzUTNBdDxm2H2YcOMyHtUk7QfMhBm
         HxMekbqma2YbPqmljHWplbnpZpSf8dm936KaC/ygv4phXBVedjAvbebOIDrg8g/ADr+U
         iNeHjSESLgsHhSQEkxnGLu8AXTOm3gHQpZmmKlOmzc2drzY7GOhv6tiSet2iJE6kun05
         cwdA==
X-Forwarded-Encrypted: i=1; AFNElJ+q0AZlR7s9caN04w+R5OaDVQYrfUd/n5jio1gcjkKbk78SPWTDcrO51iPxMLDQhKIIkrPw3pZa6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YztnN9J1q/EHtpkFZ9Wj6PJXZP9Ptb2k6SuO2ASVr7i7XEX8u8s
	wGMH/LazJwGqlkb2HytDNcNaWagxDrkYl0osjZX4AB9d2bohPOtsHFDJ1KitHRzIXuM=
X-Gm-Gg: AeBDietSVofFOohlQR7xLeQLUkvk+Jx/ss36gPayNPm+1IjKpq08Ufkrf65964bEGpM
	vnLEH2Xet+k7cdjGx/184T+SoD6Zt3kMtKwKAUXj4di3YbWBDNA1saNg3XaY5gEUGWoHP5Ku3+E
	IOn7dxigLZF5otjwI2YTauM255oJ+pnHTu/+53PJ1KsRT97/kz/maO7YcnlUI6jlg/tJLstq6dL
	AH7m+d12S1akWQZbd4qJEqngbLXmx+TKYxrh4CQA0J2D0xCx8WeFesTYlFErSqlqExZojWYbgOb
	AmEbY6MfOQqsik1Br2lbwFVv5x6DM7mGUGlPxjjko6pdmM3bjDWrxWaYD2v/j5Q997j1bFWNX4p
	5TEbq6KKIc+op6nUWN5H8ilqNidZ72U69p4A7BwrYjO8IJ5lp1aGJRiR3zY4U4xVCAFTal9v0+T
	EEJb8qz7JtGreaQAFnFFfMPxb7kNqvTICAbkBKwTO8ebExK5JLoIo+nMQdxoNs6J/74Dy5rPc=
X-Received: by 2002:a05:6512:3b91:b0:5a3:fd71:2778 with SMTP id 2adb3069b0e04-5a4172ea5ebmr8823453e87.37.1776879736447;
        Wed, 22 Apr 2026 10:42:16 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e12e0sm4581372e87.51.2026.04.22.10.42.16
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 10:42:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a402b2d102so6614567e87.3
        for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 10:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9iSLUMbYN7FphmvFeljZZxdjv7aMZ8okRAMbm3mFor1cmXENh/pWWwd1UIhRT0u/nZVJ1RSDQMu2U=@vger.kernel.org
X-Received: by 2002:a17:907:7295:b0:ba7:3d21:c136 with SMTP id
 a640c23a62f3a-ba73d3108d8mr812474966b.18.1776879429078; Wed, 22 Apr 2026
 10:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-3-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 19:36:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
X-Gm-Features: AQROBzDRSuCo9KZmmr5oDnyHv4O1KWNwiPD4Dqbl5BIkN4nUOYnL3G8AwjYfgqE
Message-ID: <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

CC Douglas

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote=
:
> From: Saravana Kannan <saravanak@google.com>
>
> When an overlay is applied, if the target device has already probed
> successfully and bound to a device, then some of the fw_devlink logic
> that ran when the device was probed needs to be rerun. This allows newly
> created dangling consumers of the overlayed device tree nodes to be
> moved to become consumers of the target device.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8=
x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-3-saravanak@goo=
gle.com/
> [Herve: Rebase on top of recent kernel]
> [Herve: Add the call to driver_deferred_probe_trigger()]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Tested-by: Kalle Niemi <kaleposti@gmail.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -235,6 +235,79 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +static void fw_devlink_pickup_dangling_consumers(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +
> +       guard(mutex)(&fwnode_link_lock);
> +
> +       fwnode_for_each_available_child_node(dev->fwnode, child)
> +               __fw_devlink_pickup_dangling_consumers(child, dev->fwnode=
);
> +       __fw_devlink_link_to_consumers(dev);
> +}
> +
> +/**
> + * fw_devlink_refresh_fwnode - Recheck the tree under this firmware node
> + * @fwnode: The fwnode under which the fwnode tree has changed
> + *
> + * This function is mainly meant to adjust the supplier/consumer depende=
ncies
> + * after a fwnode tree overlay has occurred.
> + */
> +void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
> +{
> +       struct device *dev;
> +
> +       /*
> +        * Find the closest ancestor fwnode that has been converted to a =
device
> +        * that can bind to a driver (bus device).
> +        */
> +       fwnode_handle_get(fwnode);
> +       do {
> +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)

After commit f72e77c33e4b5657 ("device property: Make modifications
of fwnode "flags" thread safe"), this must be changed to:

    if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))

With this change my DT overlays are working again.

I guess keeping the FWNODE_FLAG_* names, but changing their values
from bit masks to bit numbers was probably not such a good idea,
as it fails to catch missing conversions...

> +                       continue;

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
