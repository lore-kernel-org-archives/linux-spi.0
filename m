Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E859327EC7C
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053774; cv=none; b=O7BqfyteUVCIXPoKS0wAUX8kMbq/7AONiOJbg2f6zlpuIdy508nPMESWv6q7VYxdqdKzy2WnULcm9jtvD3FbsSfYkeLvOsNpq6cyXLwqREdVPTyYgpC7CUOIJjtLesbUYPO0s3pp5guiqiMXTjz09t/1uGpmeCYcGOa3lh/73n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053774; c=relaxed/simple;
	bh=cBeVYugjf2pCZb2MvgaJbZN8hN71Kllfonxg0KjoOTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWxYFmUNEamb2iz5l0Yild9SJptKy+un6TkumPdmHQBdkqPftDRHonRYETFoGpQ5d58BPLpYZA5QdAy+n5XaQ5DHu7MdunrVqsryTMMLgto5MPzpffSckF84zbw+DxLnmtSEjvgp4/hCkcXhOcAqMClKb9WeJ50+0ddkSB52GCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ebd88be784so1281180a34.2
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 01:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785053770; x=1785658570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3/Czl+COk9w01pROEOZpbCYgsdFmFL2CocMf8Tbq88=;
        b=YK1x5/Y76RN6fq1wM8Ji9zmrbOnboROUxpTVNNiubhZwYMsuH4mG16UkzYz22rZ3iT
         wpLs/RQ3fDgETEUnuoQiAAzwc7u4ZZbl7KzGRS6amMGrmeZvX2g5c04cZpEqMqSulMpb
         cv/JulfkRHyW7Zx9wRN3end4siDlk5xzhuz4y6B/HBLVN6SfBdjfXSo3G82C/JFOlg6H
         oNkXYLKkk7bNCFI0kEgPHZ5zgzTW3K8QbvXwPgHdb7fkyjCgYK7TDLsNDrS1OvvWSQqT
         FntbSozQs7UGR0VeaFqxLdyFGCISN9H7PbujwT7KF4YARrXReWr8usnmEXcipp+o4AfG
         UgYA==
X-Forwarded-Encrypted: i=1; AHgh+RrX2oovaA2JKIvnQB2gNbU6IAb68ugwr8goqMo9zUYH+hgVl9VGfiv8JSJEMEA4JpTSKjk3Vk9x5Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIo0A0eHV4N8gdxu51sLASZWahHTpG0V1uQamxl8JyGfWsYHUY
	bk2iKu5xG2XWc9+uuSi6phyLRiRSg+870cOpHSfkpukU8gjiktmyOU5DKG+WWj5dXg==
X-Gm-Gg: AR+sD12OThxmVbEsZypqzqMGINcEQwAaw/SEUInoCjHGTGMQDrHLpNGSA7XuMwTK+kI
	kzlYdQdV8NBBvpikk4X92D4EX7Rupbx1ZxFyWtLlgjU++vtjVZA8bIJrpp3QyTiXxIP+Qf4i0+r
	XleAFl1HZb6hA26SLXx0YqACS0a/n3bWcoTTgmEM6BspuJBA3UkhUGJXAp+RfCp9uVQ7gPXEyjg
	qsCNpMzJhl5DqRSiaJcY5IZ5SiPoaW4BjOH7YnSVmLkNWwjRLQZFerj67jika8DXW+TQo+eNrCd
	Hu/4jtwzMw1yzhnqQIa5A2dI4XrXULvjrvng4NxuDnhV3BqTv5dUhpUzTVurTerSQtwomZdiL3q
	86p6m3pmtcxdb2pHQnjL4/LrwAwciBbSWJevoTkrbcTS3Kvi7b9ZU+ZDkTii1o8v3rUz9thep/v
	/uifCXfSYL7rIeBsnnyiLAlpYQXJmPJrsV0ManHP5m/V8YwfSV8KN2dChJiTSlwT4aU0QNu7kL
X-Received: by 2002:a05:6830:2b27:b0:7ee:41ca:e7b0 with SMTP id 46e09a7af769-7ee78bc8a63mr3990369a34.14.1785053770430;
        Sun, 26 Jul 2026 01:16:10 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29a8d094sm9962859a34.0.2026.07.26.01.16.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 01:16:09 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ab04bbcc8fso455141eaf.1
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 01:16:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro4zSfph5bbQOQkgCttGMTcSjVUapCwi6wnpEEBQ178Um6KtkHu3m2pYVO1x7ZqA5VqpoQk3dJRwhU=@vger.kernel.org
X-Received: by 2002:a05:6820:1a07:b0:6a3:94bc:bdcf with SMTP id
 006d021491bc7-6aaffa23c8dmr3588711eaf.57.1785053768456; Sun, 26 Jul 2026
 01:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-2-fourdollars@debian.org> <al51g77Zsdr3OyBS@ashevche-desk.local>
In-Reply-To: <al51g77Zsdr3OyBS@ashevche-desk.local>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 16:15:57 +0800
X-Gmail-Original-Message-ID: <CAAT15mNscX3-PChHGZ3iE+sHHted74Mo+dP=x_rfeAuu77w_Tw@mail.gmail.com>
X-Gm-Features: AUfX_mwSSUq4mpHdPGRdERx0wviVImIOJ13XOXAQfqWnzyGYCfq9MB5T7xI5qTE
Message-ID: <CAAT15mNscX3-PChHGZ3iE+sHHted74Mo+dP=x_rfeAuu77w_Tw@mail.gmail.com>
Subject: Re: [PATCH v16 1/7] spi: pxa2xx: introduce clock enable and disable
 helper functions
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

  Thanks for the detailed review comments.

On Tue, Jul 21, 2026 at 3:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 12:21:10AM +0800, Shih-Yuan Lee wrote:
> > The driver disables the clock during PM runtime suspend, PM system
> > suspend, and device unbinding (remove). It also disables the clock
> > on various error unwinding paths in pxa2xx_spi_probe().
> >
> > However, if the clock is already disabled (for example, if the device i=
s
> > already runtime-suspended during driver unbinding), calling the common
> > clock framework's clk_disable_unprepare() again leads to clock prepare/=
enable
> > count underflows, generating kernel warnings.
>
> Any real life example here?
Yes, a concrete real-world scenario occurs during sysfs driver
unbinding while the device is in PM runtime suspend:

  1. When the system is idle, PM runtime suspends the controller,
disabling the clock (clk_disable_unprepare()).
  2. If the user unbinds the driver via sysfs:
   echo 0000:00:15.4 > /sys/bus/pci/drivers/pxa2xx_spi_pci/unbind
  pxa2xx_spi_remove() is invoked.
  3. Without clk_enabled tracking, pxa2xx_spi_remove() unconditionally
calls clk_disable_unprepare() a second time on the already disabled
clock.
  4. This triggers a Common Clock Framework (CCF) underflow warning:
  WARN_ON(clk->enable_count =3D=3D 0)

A similar underflow occurs if pxa2xx_spi_probe() fails and executes
error unwinding after disabling the clock.
>
> > Introduce pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() helper
> > functions that track the clock enable state using a new 'clk_enabled'
> > boolean flag in struct driver_data.
> >
> > This ensures clk_disable_unprepare() is called only when the clock is
> > active, preventing clock underflows during suspend transitions and unbi=
nd.
> > It also allows the probe function to safely unwind resource allocations
> > without triggering clock underflows.
>
> ...
>
> Same issue, I have no cover letter in my mailbox. Please, slow down and c=
heck
> your email setup. Something is wrong.
Duly noted. I will check my git send-email configuration and ensure the
cover letter is properly sent as the thread root.
>
> ...
>
> > +static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
> > +{
> > +     int ret;
> > +
> > +     if (drv_data->clk_enabled)
> > +             return 0;
> > +
> > +     ret =3D clk_prepare_enable(drv_data->ssp->clk);
>
> > +     if (ret =3D=3D 0)
> > +             drv_data->clk_enabled =3D true;
> > +
> > +     return ret;
>
> Use usual pattern
>
>         if (ret)
>                 return ret;
>
>         ...
>         return 0;
>
> > +}
Will update in the next version to follow the standard guard pattern:

    static int pxa2xx_spi_clk_enable(struct driver_data *drv_data)
    {
        int ret;

        if (drv_data->clk_enabled)
            return 0;

        ret =3D clk_prepare_enable(drv_data->ssp->clk);
        if (ret)
            return ret;

        drv_data->clk_enabled =3D true;
        return 0;
    }
>
> > +static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
> > +{
> > +     if (drv_data->clk_enabled) {
>
>         if (!drv_data->clk_enabled)
>                 return;
>
> > +             clk_disable_unprepare(drv_data->ssp->clk);
> > +             drv_data->clk_enabled =3D false;
> > +     }
> > +}
Will update in the next version to use early return:

    static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
    {
        if (!drv_data->clk_enabled)
            return;

        drv_data->clk_enabled =3D false;
        clk_disable_unprepare(drv_data->ssp->clk);
    }
>
> ...
>
> > struct driver_data {
>
> >       void __iomem *lpss_base;
> >
> > +     bool clk_enabled;
>
> How is this protected against simultaneously called enable/disable on dif=
ferent
> CPUs?
pxa2xx_spi_clk_enable() and pxa2xx_spi_clk_disable() are only invoked
within serialized contexts:

  1. Driver probe() / remove() paths (serialized by bus locks).
  2. PM Runtime callbacks (serialized by dev->power.lock in PM core).
  3. System suspend / resume callbacks (serialized by PM subsystem).

They are never called concurrently from asynchronous contexts or worker thr=
eads.
>
> >       /* Optional slave FIFO ready signal */
> >       struct gpio_desc *gpiod_ready;
> >  };
>
> Whenever you add the field, check with `pahole` that the layout is optima=
l.
Thanks for pointing out pahole. Checked with pahole: bool clk_enabled;
is placed immediately after bool suspended; in struct driver_data.
Since both are 1-byte booleans, clk_enabled fits into the existing
struct padding byte, resulting in zero additional hole padding and keeping
the total struct size unchanged.

Thanks,
Shih-Yuan
