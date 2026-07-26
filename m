Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B135C181
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062156; cv=none; b=sbLkv+Wq6eVivOEtieThAMGY3VZgn0aeLz0JrW62sJjH8G8LejKv1MTlhiGnNHRMLsV/XhkSwoQzfnWf2g//ha9ywNHpHY6tLwQqYtDKbKc0Me6ElBECxQI/CDMT1rRtWG4OLTn1YzKxWAKMf5njaj4fKoknXbBfErf3zVy3ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062156; c=relaxed/simple;
	bh=M+Vu4cRpIMQHfugoF63KNOvGVy9PGz1OJMvs0R11CG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBnOgihQNHOfbWshAeJMuNIqDsi3FXSs+WiTw7QYUssCMDP8Dwfxt7YknlxPCKA37NDEL/I0jG6H4lPKbI0dM9eQoZIZRcpUWsWwVYU1tgDLlyWs/kEpfD6h/XuJxXqDxQAY4h9MgllcLQSncvDkui2xJGU9PnydhorHicYjaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so1028382a34.2
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 03:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062151; x=1785666951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r5WlHwA8oA2RvyaPhBL6aXKI/6RszyoEP/Z/bWJtOFU=;
        b=mhLxkXbev6hRW1xFcCpSeYgT+C3lilshe6NmVyrAj3w7V8cz0MtEpvFizbF3DCZ2CT
         yPM0L9NnfD9egEn6JkVPVGki5+mQpyhXBvfE75paTxAGF24ch6kmPcXbbcXX/cKpquMc
         5AnyQM3T85xFJ/TQSdT21dZ8uWYk6Olq+v5AuG+XZbn+5RzVq99Hpl30YKI3aOhAV0BK
         5o7Z4VZZLGoLP8/x+/vwfqfjuc7ogG+gHQfvloHfKWLWtTTIxkgWhUjFSzz7g3vYogBA
         msFAeWSHuQd5b5iwPi/v4Y8/gB6oRR7oAJbTbfz5HClnEVoQ+bY+d5rHl8APJDkPURPM
         WUew==
X-Forwarded-Encrypted: i=1; AHgh+RqqlhxQ1iPUQhle1WCERY8ZgdW3XmjlrOOrhg48I5860xX9sN2p3iQA2xOlBlc5cbceEm4KoUYXu9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9RRRK9aB1kr9uRQtjOXhgrjteUYTUnymbvQoNGJAGcGwT3Ky
	VBeOaSwkvEBzaN7Y7Qg/fUPkpSIAdxSE5nqfOL4ZcFikGbEZBdwcC4a01+/InTYUpQ==
X-Gm-Gg: AR+sD12QWubXgldcqi7owYaolwehJGpDl1lMTkc8Vj2BWqoWueS8JhcYVKqR8Q35VZV
	vCwYE56u+9uqSDs+M2JBQ8ihiq/gtDloI+v41xda7NVO+RcX82QOEyofhuIFU1DJw+mnWHi7HaV
	jX+dy6n1RwwdMXhq5YpGk+yZU+a8zspXIiKRh34tmO4WHEYVM+5dIphrcAkfOQ4Tfg9PuBllltf
	ALXovXN3vDLgqKwP6wQk+o8ZyU1CxeTYvigKUA0TUFJ5hVgZW6ZvJ1Y8Y0luyZzF6Q8cPZ7IDnT
	7cB4ZjF06zFknqFfhKiMifDY9o8PptWM7WvMKaHpKXVcuqjE0UtpjPKTROc7VvKhiyKZdx+x/fB
	S34RezM8xMSHDbpu5Tk3KyQgIou04ya4rYRThtyzg4xNx2B9SrSYtO1DCCGMd70lJVeAdntOw11
	Y3RtAd2rOHJIc28EqK0b3JRJLNeI9VuSgJx3ehKZMpLwHC7MCCh6Prv3mkfQKqFT0KudPs9gRoi
	h/b/ZOnurs=
X-Received: by 2002:a05:6830:82b8:b0:7e9:c8e3:4473 with SMTP id 46e09a7af769-7ee78d5acffmr4413942a34.16.1785062151467;
        Sun, 26 Jul 2026 03:35:51 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29db283dsm9991103a34.3.2026.07.26.03.35.50
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 03:35:51 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ab015de764so367800eaf.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 03:35:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqGFKY/NdtgMu8JXR+QyhbMfSODx+lYmwCqJKmgIfkvdHmL0NSXboHcAS4QP1JYNx41CTegqYACkbo=@vger.kernel.org
X-Received: by 2002:a05:6820:1c96:b0:6a1:4347:8ff1 with SMTP id
 006d021491bc7-6aaff9a5acemr3595412eaf.38.1785062150696; Sun, 26 Jul 2026
 03:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-3-fourdollars@debian.org> <862b86bb-6c7d-487c-b790-fa5d5a5217b2@sirena.org.uk>
In-Reply-To: <862b86bb-6c7d-487c-b790-fa5d5a5217b2@sirena.org.uk>
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Date: Sun, 26 Jul 2026 18:35:38 +0800
X-Gmail-Original-Message-ID: <CAAT15mNJRmkJ4fi4gymMXHCMQ+0=fNOV+HLw1T0r3VpqeGT9OA@mail.gmail.com>
X-Gm-Features: AUfX_mw7ir5Ox5ZC24FajjkO2Ca-90Uoe83WqcIQY__elW4XN7H4XnpkwcBwMeo
Message-ID: <CAAT15mNJRmkJ4fi4gymMXHCMQ+0=fNOV+HLw1T0r3VpqeGT9OA@mail.gmail.com>
Subject: Re: [PATCH v16 2/7] spi: pxa2xx: introduce suspended flag for
 interrupt synchronization
To: Mark Brown <broonie@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Thanks for the sharp observation and the suggestion!

On Tue, Jul 21, 2026 at 1:18=E2=80=AFAM Mark Brown <broonie@debian.org> wro=
te:
>
> On Tue, Jul 21, 2026 at 12:21:11AM +0800, Shih-Yuan Lee wrote:
> > When a shared interrupt line is used, the interrupt handler ssp_int()
> > can be triggered by other devices sharing the line. The handler must
> > ensure it does not access the SSP controller registers via MMIO when
> > the device is powered down or when its clock is gated; otherwise, it
> > will cause PCIe Completion Timeouts and system hangs.
>
> > Currently, ssp_int() guards MMIO access using:
> >     if (pm_runtime_suspended(drv_data->ssp->dev)) return IRQ_NONE;
>
> ...
>
> > Introduce a custom 'suspended' boolean flag in struct driver_data to
> > track the device's suspended state across all PM transitions. Check
> > both 'drv_data->suspended' and '!drv_data->clk_enabled' in ssp_int()
> > to return IRQ_NONE immediately before any MMIO access is attempted.
>
> >  static void pxa2xx_spi_clk_disable(struct driver_data *drv_data)
> >  {
> >       if (drv_data->clk_enabled) {
> > -             clk_disable_unprepare(drv_data->ssp->clk);
> >               drv_data->clk_enabled =3D false;
> > +             clk_disable_unprepare(drv_data->ssp->clk);
> >       }
> >  }
>
> It's probably better to avoid extra changes like this, it makes the
> patch bigger and a bit harder to review.
Agreed. I have dropped the unnecessary diff churn from pxa2xx_spi_clk_disab=
le().
>
> > @@ -743,12 +743,12 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
> >       u32 status;
> >
> >       /*
> > -      * The IRQ might be shared with other peripherals so we must firs=
t
> > -      * check that are we RPM suspended or not. If we are we assume th=
at
> > -      * the IRQ was not for us (we shouldn't be RPM suspended when the
> > -      * interrupt is enabled).
> > +      * The IRQ might be shared with other peripherals or trigger duri=
ng
> > +      * power state transitions. First check if device is suspended or=
 if
> > +      * clock is disabled; if so, return IRQ_NONE immediately to avoid
> > +      * unclocked MMIO reads.
> >        */
> > -     if (pm_runtime_suspended(drv_data->ssp->dev))
> > +     if (drv_data->suspended || !drv_data->clk_enabled)
> >               return IRQ_NONE;
> >
> >       /*
>
> The local flags *must* be racy - I'm not seeing any locking which
> protects them, nor anything that stops something else dropping a runtime
> PM reference and powering things down after we checked here.  There's a
> helper in the power management code pm_runtime_get_if_active() which I
> think is what you want here, it'll tell you if the device is runtime
> suspended and if the device is active it'll ensure nothing else drops
> the last reference while we're running.
That makes total sense. Using pm_runtime_get_if_active() is indeed
much cleaner, atomic, and eliminates the potential race condition
where another CPU drops the runtime PM reference while ssp_int() is
running. It also avoids adding an ad-hoc suspended boolean flag to
struct driver_data.

I will update ssp_int() in the next version to use pm_runtime_get_if_active=
():

    static irqreturn_t ssp_int(int irq, void *dev_id)
    {
        struct driver_data *drv_data =3D dev_id;
        struct device *dev =3D &drv_data->pdev->dev;
        u32 sccr1_reg;
        u32 mask =3D drv_data->mask_sr;
        u32 status;

        /*
         * Ensure the device is active and acquire a PM runtime reference s=
o
         * PM runtime cannot power down the device or gate the clock while
         * ssp_int() is running.
         */
        if (pm_runtime_get_if_active(dev) <=3D 0)
            return IRQ_NONE;

        ...

        pm_runtime_put_autosuspend(dev);
        return IRQ_HANDLED;
    }

Thanks,
Shih-Yuan
