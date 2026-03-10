Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929F3101C0
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155467; cv=none; b=lW2EshSslY5fma7ErwUy8KqNLntNBhs8vUP2Jih1Son+sp5ADDLIPya7vIzD+QLm4UoVQN2j8rHQYBNozF0EMF3XbLN60ID0jcwDjifUajbB7XC9bqSev+RHL0bak6I1Sq7/TjEjjf+23HC1JBHlo2LgGLMmh7nDx/BDmyizAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155467; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CntO8haSgQYhuW9rkOcAsZ7NASso3sKIdzhrQH6PgVIXwmoB4ZZqhRY33Nwy3AmhDsCKH/15+vYbBGnuuVR6tBGNzercFQMCyexm2RH5QYxCxyKC1VRWLf/ORPekEIIskxApFnMKarPuWO+H7wHW3IOmZZdOHJXfqUO5+ij/Y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899f79df682so99497186d6.2
        for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155465; x=1773760265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=OREs+0dqW4xBvX0C+ASC/7nVfSRawBhjUTADPw0sZOEkk1Eex06Dq7cqqHXx+2xZZG
         CLtuVq8dVrdAy8ec41w5x5jWDG5ULsj5TUbQKfSkV7W6yosS/ChpiFHctIhoM1epDzPI
         0E+dSRr5B5qG8ZxoGj7SpCbU559eoeEQaW64nae/TvGNLZRR+les/+0tJnk2SFAy5MwF
         yn9+IoW3KCdaxG5vRYwYon4iHBfWVYqVPITImklyveNAgcJPIfdu+79Gbw9NcDFss6Pe
         UW75acYWS+STeKIs3fUub5nXvAXpMmm8iMM2/J9lO1fLoDm4uFC2/iZxPGfLDaIUoHUn
         MUag==
X-Forwarded-Encrypted: i=1; AJvYcCVji3q+ZR5RsGrd+WwJ1wcRSNmaNN6K+i2wzHQuiceB3/eLRUkp7i9VguxHUqA6dxaPy4sc85CNobw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK2lO5dRPG94OjETBR/UlXgqltHATnSWuxcje84igOunMSdpet
	hNz1W+NOt28kqvJp1PrkMRM2S+/k+tlYAzxx3wgNbxF4NLXksxAUGR80bU2vxlKB
X-Gm-Gg: ATEYQzw5Rtan187h7wa9R9wpbIekesPH0YRXiIdUIvOGPbIU1MUnjQ7fthuCp4Uwuoe
	YZSKz4o5f4j8FkNTLgzp4vvRTtWYnJiyWZfwMazSVbmbnbTy/dMxZ5STLr0ujhRSfs6QyJiV/Yu
	kdAJAX+fy4GEYTA6O6osYmAoedk2P+q1SqBoLc5evmYU/7AsI6tj/zZaudhJBf5HaGoiM9ttcJa
	fcXK5U7tUcwDm2VX90gPzEuSveAffAChJsjwlBUXjwCDq8ljYwtagb7Ee5zfWNvFeowLSvx9DBy
	LKm35N3aJRxWMhDBaqmfFgLgAcpIh3B68897AmTIqU0xmNm5puevK4ZUjeh/5v27mpzsjHrOAyS
	w8W5zssmMZV3n1q+WbT5hitwQ9LzsQarGmdofndvpmQfs1Xlkm0Vyt48eXUUqOav8GmphilBX7e
	0c0z3A14+SnZ7t0AVIWO8/Lc2OhDAy9059kHFZD/eU0O9b2uiiAyYDU03GuFMCDZF5
X-Received: by 2002:a05:6214:e4e:b0:89a:14f6:b51f with SMTP id 6a1803df08f44-89a30c15dc2mr234708186d6.60.1773155464837;
        Tue, 10 Mar 2026 08:11:04 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57bfb0bcsm23326966d6.29.2026.03.10.08.11.04
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:11:04 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506251815a3so116528471cf.0
        for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 08:11:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsJm0R1m1ThRequcJeZx55i8N+eIeiZiftYtJ/R5NCiGQif+379a+A22cVhdy+QazL+WnCPeTF5+g=@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

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
