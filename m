Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA34BE43A
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062397; cv=pass; b=bdxLCPW8fOLulz0XIVy615SRv+K/6abouSTQu/ba+dTwVPQsmc0nBKlRp0AdC5sT/D4HG4MxS59OmtaW5XsD/RZotwVZ5BppOflDM9qw5IP0hj8JVuVnL3TmAz2zsFavcN5EbkOgqe0No50X0tjHf939aP78jT+6CWe+lhXhSUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062397; c=relaxed/simple;
	bh=Vrzrlw6NEH45X35QxpA1RjfO7FaaCToWOrz+oHjjRrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnsBIN7JObrYnt6OTDvD0yr3hLiKRLky4RbGdyNbzxvV8WVAU8mUEPPMXfyXgGSFwYJz8MmluXgSxqXjKCxahqhAwUdbNO2WcvTh2gmxrmzaxa5br390VIyPGuC91+3IJGPQag2cSrJjcORGL4rC/bIQkvKA+76WGmBEbHXOzp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h06Vlcwe; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h06Vlcwe"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb7488033so878983d50.2
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 10:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789062387; cv=none;
        d=google.com; s=arc-20260327;
        b=nJFE/V6xO+gH0pM7kxavOP3MTOasbiV1DAF6yDNldr/cskpMqRHeL5GNbIWo7vC7dJ
         8olrXFiKOYv9QdWuHUbQ7Go21BnMvOK7atbXglt9JtsrNuwjXlWo++kWmo2y5xrImM1f
         uJcDLr+dCJaqpGpUgoHYEwgzmchlsejMnKN8h0BwlbPzfXX0zZwNJ9tHTIyDOB3xjkg3
         fWitQUPs/bKLHCfXkPthXiO9YtibRZEl1Y2vMK8MbtiBpBBGV0T8ZlknaUC2jXU2FvY/
         vDdvashBOeCBGTV/aTDCo9CiBe/WLJnikcFV1mLJtsRIojCRUihDVJbg5SiTEGr4WKVA
         0ehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        fh=q47zGoZgoY4gtYMFzg+Cb15lgHd5QWtScifGxm0ut3A=;
        b=Vfru0kXHjHZiFbRMpj9qrpMk8dZ/Nt6tTPM+mVOYPZU+PYzyeoQB/5uo1pcyFmKTuH
         zLOOvNOaKQVDLcNKkuA7kepUAE7rLWDFPddMkNbWcxSmngTXHWhaSmj9k9dfs6A3MlOH
         OPxMjDEL6sPy2BhOAWHUzRLglLqTY2mcXrcMRYJDmYiCDeuhfN5SmLoaQNc8Jgf1haGe
         iIhjUOp7vA9Yi8F87yR7s99JUY1fJuFTD9jzX4VeGxXH6pZOiIfqw4tP5YiQerTUp5XH
         uzVTKch+P3D/24+maZGmMyrnEntB7YbhYoO01BCCzGte4Iednv+mP9tjk7Hq/bs1l4c6
         v4KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062387; x=1789667187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        b=h06VlcwemGDL3kiY2x5x+cJVYMWT60Ap76jj8I+zLTnmlvVfKDMPq/j1+DkiNwkmA6
         X5ZBjI+zFNcmvYNWbtppC2DSZa38aSf13fWubtC1WUCXpltkpTvQPHQwD8+qHg5QpWQQ
         wGr5KKtpjo6L8aOjZQ0JHzYzcYr/V0tDo65m9cB6iDRyuRpyQ3Bg0/cqwYTXTTCmVWFt
         HO6SJtnNHuTNTw1CEI9tGwGxnyLI9EjJSYtb5zD4/2jXe/+Rzvd8B54ws+IAD7O0eRoL
         Rbn8UP9Z1/DfhQLuTemqnAgEKIdBROIA7gbmjJD9KO41imFtF6QHkgGS0v/KbPLvR1KC
         yzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062387; x=1789667187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4TZTvFeGPOKvIslE4wHXvMYV9kBCW5S/2L+GB2DcDc=;
        b=j2LauhRKFYZZevkxfcSSX/LgTeSiICEVJPICdSOU5H6LOQAncPCbqQGMmpXkO5SSMx
         6/CqbjPUma1S7iLohRxa7jtBU2a0Q3p82KJfy5ylz9X+7Fd1AJ37r2elkkUxcCMwdH8L
         5g6sI4nvnFmbTA2NSSvtYD+l4Kp58JKyqF5I99ygNfDkqkwHFYCkW6afI+i1SBcBcfeX
         v9co+2KTY+7ixzi1AB4B+OeLLv/L+/ei+1SQI2u1zpqCeFH7GOw8rdi+DTsbXd8MA4Vh
         +bwl+JH9ZV9gUPSqPyh0XGHiv0FZp+uoEJibGGUwRhPepgCn2TjlqYSWth2Hs6JcZtOz
         rFGw==
X-Forwarded-Encrypted: i=1; AKwUvByOT/AYn4nKoVbVOqqgUvWpiZFBncXyGo8kRyRP0zUEB1ugYgAO/jJ2weczN0TvXfeFhL9E4DdDFhU=@vger.kernel.org
X-Gm-Message-State: AFuF++kqiqsxxlNAXEo9DCLsBy1sb7p3qjljmXXD4x2h8S4VfUZLecbT
	aE/bEvs/FnhkSjpzVW1gLfV9wHFtjlNUNpGHpYo0wB/0OvXrpYp1SvjLpUJHvWGagmVNpAmC3e/
	IUmYAukJ+CTGbDt9NecALXmUNxk55Fs1HBg9bx+c=
X-Gm-Gg: AYBFou2Y2x/r/5Ou0MS4ZeM+j78KMQdCeJKgsY66QufDqNFzmQ9dgQFDS7eIBBEY9rH
	aONVLyVPZd2screDiFJoM65cpKcCUuK0oy6a7cHZkvLmFfYo59aEa++5Rv7mqLTKMCUkhG+LNfR
	yUDqd0DYAwJtn0h2ZgQ4acDq7oM3q1jyqaggSAyz18pFE3DoH+B/MDuFu0QSKhIy90FJtzMYIBd
	6Saf620KMcOR9C3WKcwutBPhBEe+Z21mL9icJyq+QDOfe2MKT5VoU5dhrK67c/1h155RCxrtwBP
	BTvDFew+DEFDs+NP+uDSn3IlqsFKylRlUksq7yEw14S23dw6XmW1DHXZ+Q==
X-Received: by 2002:a05:690e:2630:b0:671:1256:56f2 with SMTP id
 956f58d0204a3-6712434a30cmr243759d50.0.1789062386241; Thu, 10 Sep 2026
 10:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910113325.717882-1-itai.handler@gmail.com> <8fcad389-8340-4ccb-8ef4-008d826115fa@sirena.org.uk>
In-Reply-To: <8fcad389-8340-4ccb-8ef4-008d826115fa@sirena.org.uk>
From: Itai Handler <itai.handler@gmail.com>
Date: Thu, 10 Sep 2026 20:46:13 +0300
X-Gm-Features: AcwNN1U3FFO8vc3TdnTHV2rTuiD4fh1DFByrqEjK3AblMQ21SxCX7JRhTKfW558
Message-ID: <CAFpOueQ-veAYVWAPTN6_0c9NXCEN24wzV4i2uVuNykWmBy6vfA@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: stop the controller on shutdown
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, michal.simek@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 7:56=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> > +static void zynqmp_qspi_shutdown(struct platform_device *pdev)
> > +{
> > +     struct zynqmp_qspi *xqspi =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     /*
> > +      * Only a runtime suspended controller can be left alone: its clo=
cks
> > +      * are gated, so it cannot be mastering the bus, and its register=
s
> > +      * must not be accessed either.  Any other answer means it may be
> > +      * running and has to be stopped.  In particular, on a kernel bui=
lt
> > +      * without runtime PM this returns -EINVAL, and there the clocks
> > +      * enabled in probe() are never gated at all.
> > +      */
> > +     ret =3D pm_runtime_get_if_in_use(&pdev->dev);
> > +     if (!ret)
> > +             return;
> > +
> > +     zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
>
> What ensures that nothing can start new transactions after this has
> run,

Nothing does, and that is a real hole in v1 - thanks.

Two things narrow it without closing it: device_shutdown() has already
called device_block_probing(), and it walks devices_kset backwards, so
the SPI slaves and the MTD stack above this controller are shut down
before the controller itself. Neither of those stops a late spi_sync()
from anywhere else.

I will fix it in v2 by quiescing through the core first, which is what
this driver's own ->suspend already does:

        ret =3D spi_controller_suspend(xqspi->ctlr);
        if (ret)
                dev_warn(&pdev->dev, "could not stop the queue: %d\n", ret)=
;

        ...
        zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);

spi_controller_suspend() answers both halves: spi_stop_queue() waits for
ctlr->queue to empty and ctlr->busy to clear, and __spi_mark_suspended()
makes every subsequent __spi_sync() return -ESHUTDOWN. It can sleep,
which is fine here - device_shutdown() runs in process context and
already holds device_lock() across the callback.

Unlike ->suspend, shutdown cannot abort on error. If the queue has not
drained after spi_stop_queue()'s ~5 s cap I still want to write
GQSPI_EN, because a controller left mastering the bus into memory the
next kernel is about to reuse is worse than a truncated transfer. So the
return value gets logged rather than propagated.

I did consider making ->shutdown just call the remove path, as
spi-fsl-dspi and spi-bcm2835 do, and it would quiesce correctly here
too since zynqmp_qspi_remove() calls spi_unregister_controller() first.
But it then disables runtime PM, drops both clocks and tears down the
controller and its children, which is a lot more teardown than the
shutdown path needs and none of it stops the hardware any harder.
spi_controller_suspend() is the part that actually answers your
question, so I would rather call just that.

> and if there's any operations in flight will the controller be OK with
> just being stopped like this?

With the quiesce above there should be no message in flight by the time
of the write. For the case where one still is (the -EBUSY path):

- Writing GQSPI_EN_OFST is the driver's existing stop primitive.
  zynqmp_qspi_remove() and zynqmp_qspi_suspend() both do exactly this
  write, so this is not a new way of stopping the hardware, just a new
  caller.

- No controller state has to survive. Whatever runs next reinitialises
  it from scratch: zynqmp_qspi_init_hw() clears the ISR and the DMA
  status, writes GQSPI_EN 0, resets the TX, RX and generic FIFOs, and
  writes GQSPI_QSPIDMA_DST_CTRL_RESET_VAL. A power cycle obviously does
  the same. So a controller stopped mid-operation is recovered by the
  next probe.

- The flash is the part that outlives the write, and stopping the
  controller does not make its state worse. A read is aborted when CS is
  dropped and the chip goes back to idle. A program or erase carries on
  inside the chip whatever the controller does, and the next kernel sees
  WIP and waits for it. Waiting for those belongs above this driver - I
  have a separate patch making spi_nor_shutdown() take the flash lock so
  the upper layer does not walk away from its own operation - and it is
  not something a controller ->shutdown can fix.

The failure this is aimed at is the opposite case, where the controller
is left running with nobody driving it: after a kexec without this patch
GQSPI_EN still reads 1 and QSPIDMA_DST_ADDR still points into the
previous kernel's memory, so the engine keeps writing there while the
new kernel is relocated and started.

I will send v2 with the spi_controller_suspend() call shortly.
