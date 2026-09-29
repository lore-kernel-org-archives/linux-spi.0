Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744036B918
	for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666304; cv=none; b=tZo/JXxsZsQAxkOvoZ5IVS+yxTg62z+QtVjPR8YFu6POBjY0+Mp0SF4vdeQdCfqZQtbb8l7ERuU0GbASuWS1PRk9C91rHNyaluqXpKxCU0xGEaKUULUieKMUTIEq7SfiVIAliWfScW0JOovGNsuOL8dUScAzVN1cyuebQMJBmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666304; c=relaxed/simple;
	bh=QJnK+hiTvlC+rNNX506wVat7FuReEWPSNNtyFaDcZZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4GS/TwNDKxqIfqyn9N05NexI8x9n2bFhWgufU7en58WQtUfTVrgKAwRTXZcsQ74Y/G2iXZnj8lPKJD3m0fyMtwrEz7XNC4FOJPjQQhij4/bOYiolcDEaqxyFdPjzF+1CatPeuNofZJYwm4SPuiKa885gJF2s+F7WMBCA3TnR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c83be8db39so2442699e0c.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666301; x=1791271101;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=urkJD58hMoHePd0JRK9qieDP4sEy8iL733/oAqpv72A=;
        b=XTroE2rBsoyfHrfIzU/5z+sQHHnzGZzjdtcyz2pUf7OkzZqYp4AVLf+jlogPToE0X9
         JGw/73tKJ7JQ1uVJ+lkaQBHq8biz0VcOR6KRDeJE5+kUlTejzQP2WIarCgWQhhKR61Ac
         9BvHHSteIY+hEmJ4j1IQEyw4fjIT3epxw+LVt5quGrJ6TVzp9VkJz43eSurcy1qOIonJ
         6Xl7SxEW35U7pWWjtD/vRPwSo15bwu4p69XI4WPXzL0Ht4I4HroBwpsY9+6WxU4QdqSW
         Va2V70xlz+JjqMAZ4vbWPEoXxM+pbtPeDLDNypcexx4Cn10cAO3yKpzV/6ZQGMlWX08e
         V71w==
X-Forwarded-Encrypted: i=1; AKwUvByPnccrlG8sKD7TAjcD6MrqEgqJ7IKlYunaVTduqcgXg1OzIKtjvLNAJR14XVaEaP9d3UIXcm9eBGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL83qEWHWniRMeuEJB5XHc2vbbufa3JhKd4OADtT7AUwhsl8hjH
	xskHdbatBzJo0/Gm6zrNCi2C6HT78NA9O2oyJbUQsyyQMOEQIu7zhFo5LLavoUr9DAI=
X-Gm-Gg: AYBFou15philttGD970xl2J5XnpKCQbvIBIcsYSuIF7d8Aw5ZcVw2CGYK+KtFjt95GS
	RK3HosmdVgMM+1e53Yu8ooTFlcfG8KVIwEl8MJ4aE6VHQfZJLqhtYJo+cWm0kOGA+67ipBcxyIW
	tw4laYp107nxEtOrEhE6dTt+avHX914VegqKndvdknGeBeJEPvPCtJJq1JdFiaI+94YN3UyrNMs
	by5c68crWvmDm3GRCYHQwczbOD6z2WAyvwB9b6dKeIi5lJM52Q5HUpq7qiqnpWWX8Ps2zQgofTS
	/BjuZ03uRZAIVtrPpXEST7fbVQAg/9lTXzqT6dZ9cMZP2pQ7AJNRA3WIc0k/vEF5YK75p+4GGn5
	aqkLT/xajG9rRYJPds8y3GoCcJkOhdTiTMAd/MAPfKiQeoFDoMgddIhJ6lRzYQDuVciXR2Qg/Ad
	KTUj0peVhejAZrSdshZBYl4jVzvaIkCLp7c5VWvo6/Ym4wKkge1XdUfEPo3bItRy8quymKImCce
	HkFL4DUW9sEGwTu687ECMhpmWKok01rzEbl
X-Received: by 2002:a05:6122:d24:b0:5c6:6189:c756 with SMTP id 71dfb90a1353d-5cb09027e5bmr7252551e0c.2.1790666300899;
        Tue, 29 Sep 2026 00:18:20 -0700 (PDT)
Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com. [74.125.227.39])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cfe5f4fa4fsm7613278e0c.1.2026.09.29.00.18.20
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 00:18:20 -0700 (PDT)
Received: by mail-vs2-f39.google.com with SMTP id ada2fe7eead31-7b2907c2e8fso1894171137.1
        for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 00:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxIw9Y9m6YY0IBwwquVHyhEkUwutSfy8RY7eNzVwr3OOS4XQAcQnl3wkrjkuCxWhGpKF2c2O+W1OP8=@vger.kernel.org
X-Received: by 2002:a05:6102:8096:b0:7a1:f7d2:e81a with SMTP id
 ada2fe7eead31-7af1e6ef2f8mr5696434137.19.1790666300095; Tue, 29 Sep 2026
 00:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
 <CAMuHMdUGwQXvtLeQZ3KfO0giAhyEBgWSLqmxqx=7yqGqMr+hDw@mail.gmail.com> <OSCPR01MB1276943F1EAC14670506E6DF5D3822@OSCPR01MB12769.jpnprd01.prod.outlook.com>
In-Reply-To: <OSCPR01MB1276943F1EAC14670506E6DF5D3822@OSCPR01MB12769.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Sep 2026 09:18:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWoQuPv=pVOpvY45_3p0hS2Xq34RYTkhEahA65RMb2nxw@mail.gmail.com>
X-Gm-Features: AclHuK9Q5JzW_HuTZFfkVo6R7FOP85PvaDuB-wCgnkQCGgceBABngBZwKKdNjU4
Message-ID: <CAMuHMdWoQuPv=pVOpvY45_3p0hS2Xq34RYTkhEahA65RMb2nxw@mail.gmail.com>
Subject: Re: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is built
 as a module
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ovidiu,

On Wed, 23 Sept 2026 at 13:07, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> > On Mon, 21 Sept 2026 at 22:00, Ovidiu Panait
> > <ovidiu.panait.rb@renesas.com> wrote:
> > > On the Renesas RZ/G2L platform, the RSPI driver falls back to PIO mode
> > > instead of using DMA when the DMA controller driver is built as a module
> > > (CONFIG_RZ_DMAC=m):
> > >
> > >     renesas_spi 1004b000.spi: dma_request_slave_channel_compat failed
> > >     renesas_spi 1004b000.spi: DMA not available, using PIO
> > >
> > > The driver requests DMA channels through
> > dma_request_slave_channel_compat()
> > > which returns either a valid pointer or NULL and cannot handle
> > > -EPROBE_DEFER. If the DMA controller has not probed yet, the driver
> > falls
> > > back to PIO directly.
> > >
> > > Fix this by replacing the dma_request_slave_channel_compat() call with a
> > > regular dma_request_chan() call. dma_request_slave_channel_compat() is
> > > always passed a NULL fn_param in all code paths, so it actually behaves
> > > like a plain dma_request_chan() call.
> > >
> > > Fixes: e825b8dd2b36 ("spi: rspi: Add DT support to DMA setup")
> > > Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/spi/spi-rspi.c
> > > +++ b/drivers/spi/spi-rspi.c
> > > @@ -1355,6 +1339,11 @@ static int rspi_probe(struct platform_device
> > *pdev)
> > >         }
> > >
> > >         ret = rspi_request_dma(&pdev->dev, ctlr, res);
> > > +       if (ret == -EPROBE_DEFER) {
> > > +               dev_err_probe(&pdev->dev, ret,
> > > +                             "failed to request DMA channels\n");
> > > +               goto error2;
> >
> > Doesn't this make the probe fail if the DMA driver is not available
> > at all?
>
> Yes, if the "dmas" property is present but the DMA driver is not available
> at all, the probe will keep deferring. This matches other drivers I checked
> (spi-rzv2h-rspi, spi-rockchip, spi-bcm2835, etc).

IMHO that is bad, as it means the driver won't work at all if the DMAC
driver is not available...

> > > +       }
> > >         if (ret < 0)
> > >                 dev_warn(&pdev->dev, "DMA not available, using PIO\n");
> >
> > The driver still falls back to PIO in case of a missing "dmas"
> > property, right?
> >
>
> Yes, without "dmas", the driver still falls back to PIO.

But that's hardware description, so the "dmas" property will be
present anyway, regardless of the availability of the DMAC driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
