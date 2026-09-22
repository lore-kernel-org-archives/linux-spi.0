Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9175519B0
	for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088426; cv=none; b=cxXos5tSeOZePdl43qIvNCX4+rPkHM/n2Xu6LNlgpN4qJh5WoZKr5zK5gYlpMOcx56VYILU0ZHZCc2gKvRBRTk3beoH6r7ZG4v+3hH6kWXvu82O7RpzpOliG7YCsaZ/rW+KXqBRey7gYBEzmpRyjwqNZd+KOsfd7WthcOqppUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088426; c=relaxed/simple;
	bh=TbMap+l+wNqfvepdi7vbGTkwx8Z99cmqTQcYec/WyyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhAQY8N5oxR6Ymhrs0fFAyuLNpMwfp7ro25rMRwgaVuxZzzo9DKXYMhoF2LiMvSuXhP64m2sOO42WWTwfl7jcg0DUY4val5SFYZcrnEnA5qH5/AOBS0AHzXU0xB24ack2sufYBp1Zu9pJ9uwbUBz83EOMJUX+/FrSoIYaAuk+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7e8a17839so884969e0c.1
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 07:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088423; x=1790693223;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ORXCKUXvqBYFLFFEeuhhJimDvmfdPp/J+FHZ+N9LIhQ=;
        b=zWbEHr36C/hy1TOh9gLnBmWlaldhpReg268Wcq26e2AETgdsSFErzDOhpSYm3XUCid
         RcoZJi7/5YrY4ehaD2zhKApF57cF9yRF8a5xyY3m3W3OifP7fk0i0yjqiGDXElK1cqGe
         LiHwp9EDoRRh+9JMb8tu5msdZu6bvJGkfEhSS5uFD+f9khN88lXcF2u9nrA2a+JQXN7u
         O9mx2G00azxSRqJPmTp73Xun3J7zIpHiBE3fjPgukhWXaRChI6bg8BKvendar9wsCMyf
         MfY9k1YjVPTuSJtQk6jNTN8WhsGD7P3uxo1y0Y1nu3A5JX80m/T36vvLKU5Lb4OSZtmJ
         GCtA==
X-Forwarded-Encrypted: i=1; AKwUvBy7gPtogg2aycKJymCIOQXYgnHrNQx2fev/ZLw8kAjvTYbRyyXxt3++q7GFstVI0PEjjYwFkyUlcog=@vger.kernel.org
X-Gm-Message-State: AFuF++lJXRM9O5BGiMl2WHoeZxDlfXxDc/rVv53I2WqQCAIa3smWpbPR
	wpda2Op5Z2AehmDnkf2zM5Mjr9RCozLRcFlhfjr2fDljkAAT++y/DRs5pa7MC7mG
X-Gm-Gg: AYBFou2ac5SOl5/IGvk1iWezRl0bc5pitEET2UtKBGp+T5AQiYQjw2RBu11YfZOM6Qi
	mP91mLxFh07KFwyzdb5WN0HOUDVNhZ8v7hYp7ER6IMGU77Y84V2M7dDmfdPPBituyUeDCQPfz5/
	0RcZHnxT8t6XAmIgJ4UmH90d3jNGRPrkzqxO6VPj4PzUwpvMlj/45WQpDQeIYIckFgp7qUk85Aj
	lRJd5TJvD0k4ftWJdFYNFwHBJnUfPmS/70HdZ92GNrVz1y0TetNGl+E1rar/g0KaCYgUU+sWQsw
	EOwlQScQW/qI56UADI9+ByI7UI3jAz4KgBZAt3MKqWv0N19thPDLF/oHpsGOHl3QFYKfy3g15LE
	OoQfKswuEIZn8IUMzPkqh58ipejYj0norxJ//Qz6fpqjYBY87CnNEbGJY0oG/LATQLvFK0jqR/p
	U7zI5vXDuqRyYC58FX7T4wVNlID/Omee/wmjOlHxIiO54FzHW6ywxkFhNVH62GBoGTUKwYXgX1P
	MeGvprfUkEQ8h77mHGsBpOoinPTSBtlT6rj
X-Received: by 2002:a05:6122:d10:b0:5c9:a5be:7b4e with SMTP id 71dfb90a1353d-5c9e349c332mr3106804e0c.5.1790088422955;
        Tue, 22 Sep 2026 07:47:02 -0700 (PDT)
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com. [74.125.227.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850db87356sm1874056241.13.2026.09.22.07.47.02
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 07:47:02 -0700 (PDT)
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e194227so1721320e0c.1
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 07:47:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxKx+CG8WhOJ1dkxUj7fEmjZ3KfCMXgsvQLzTQx4l5GDIGEDWNcoMOmgqTMnpwpSw19tgOKNpbOWRU=@vger.kernel.org
X-Received: by 2002:a05:6122:401b:b0:5c9:a5be:7b52 with SMTP id
 71dfb90a1353d-5c9e35f60cbmr3362802e0c.9.1790088421919; Tue, 22 Sep 2026
 07:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20260921195943.107247-1-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 16:46:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGwQXvtLeQZ3KfO0giAhyEBgWSLqmxqx=7yqGqMr+hDw@mail.gmail.com>
X-Gm-Features: AclHuK_aPQ1jP2rNsXJ9Dmp5IiCiZiuxKDlIrtLLHY5NeT02sngfHtGGckkuD78
Message-ID: <CAMuHMdUGwQXvtLeQZ3KfO0giAhyEBgWSLqmxqx=7yqGqMr+hDw@mail.gmail.com>
Subject: Re: [PATCH] spi: rspi: Fix DMA mode when the DMA controller is built
 as a module
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: broonie@kernel.org, geert+renesas@glider.be, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ovidiu,

On Mon, 21 Sept 2026 at 22:00, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> On the Renesas RZ/G2L platform, the RSPI driver falls back to PIO mode
> instead of using DMA when the DMA controller driver is built as a module
> (CONFIG_RZ_DMAC=m):
>
>     renesas_spi 1004b000.spi: dma_request_slave_channel_compat failed
>     renesas_spi 1004b000.spi: DMA not available, using PIO
>
> The driver requests DMA channels through dma_request_slave_channel_compat()
> which returns either a valid pointer or NULL and cannot handle
> -EPROBE_DEFER. If the DMA controller has not probed yet, the driver falls
> back to PIO directly.
>
> Fix this by replacing the dma_request_slave_channel_compat() call with a
> regular dma_request_chan() call. dma_request_slave_channel_compat() is
> always passed a NULL fn_param in all code paths, so it actually behaves
> like a plain dma_request_chan() call.
>
> Fixes: e825b8dd2b36 ("spi: rspi: Add DT support to DMA setup")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Thanks for your patch!

> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1355,6 +1339,11 @@ static int rspi_probe(struct platform_device *pdev)
>         }
>
>         ret = rspi_request_dma(&pdev->dev, ctlr, res);
> +       if (ret == -EPROBE_DEFER) {
> +               dev_err_probe(&pdev->dev, ret,
> +                             "failed to request DMA channels\n");
> +               goto error2;

Doesn't this make the probe fail if the DMA driver is not available
at all?

> +       }
>         if (ret < 0)
>                 dev_warn(&pdev->dev, "DMA not available, using PIO\n");

The driver still falls back to PIO in case of a missing "dmas"
property, right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
