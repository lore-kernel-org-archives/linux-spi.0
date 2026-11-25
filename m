Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795637305;
	b=MWX5TccjGlg0YFFOrIrih8FYJLwpRlY9KAhHHF3B+P2JEDKnFnyrEx6nhusOevXNExTZ
	 dAYdiFClt/1/CX/VUbRDKP+GTiRDx3ahT2d2H3lTZ2KzlGrNzsKK5bN9FERBrm+QQT3D9
	 kyQQX0iLiN+ZuYZNXa/0PGFlpDgXUjt5COFdDrnpFDS8b6iZEdQWg9iZz5o3vLyPay5R/
	 6YUbSw3KYWF0viF5xrx47LM7DXUq18Z7ZAZUUXioKOJkxx+OQ3zQIRGTawwj2lv2kqVTC
	 JCZZGpT69dzTjgOwhKikrBjdHBtSQ4NgJAIbVhGbOKOmWlghc+5aeJwPI820DyrXx2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g2sz6a7NAkW2VwlSH0qJO9zVczZnv9QOUY1IGuEHJjs=;
	b=mk1lCXuO5yjdY2NP4V4P41OrS4nNlmgUWWLGlgoLb9Z5pi3ObYSSbUesbxmgtNyHtRU4
	 bcwYVSRiENcPVNGFQo6rftQcSBeWZjRlYTKBjeoNfqcbXO0iY1rnK25b6k5i5eRDs48mO
	 8jhtEtTFTrkzxwLIghyc69Sw80zCpPzrF5L0ht40e7c8s27bC2g+WdX8xXcfP2+24GPxc
	 6E2Zn8kfh7qAbKcLwH6zQ8vEi3yYnQlT+nEO+rN+w0nAEYxFS7O1CKRD5m+0AxUts5B22
	 mglR43j4gtm03/+lElM3TWdm+gFFLaQRa+mpuErCt+fYly0Sb3eLxyvpEw/KxH4Uk7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SzdBUQhC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C897606A32E
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 20:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C897606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SzdBUQhC
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b335eeb340so54945427b3.0
        for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 12:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795637304; cv=none;
        d=google.com; s=arc-20260327;
        b=rnXbqH53qXpfjqjO8320tic8FqJCLv5ptjhsQaRHqbfApb40k/gJtNjFWrcd44kWVx
         gVz8wUhfazPeIPyCjJdPOiokw9/msAC30T8aJa/87eDpe1XXG0hgqp2f2w2xOugQII2Q
         Khtv7PATymY7zpGzahnABK5LjzeGltIuePSITN8h+7qG5/76ei8xAEFUcIq/VZPpqoEF
         HBGq77V/9Y6kcUmdgfPZIVGXAv+HTbLBgw++rfSGa2gbJ31H/s728vyWxXeaVXGqZB7c
         QdVUthCesqG6moXjTEjlSTI4K/h5udqKW0WkVQPStJ5h0nHp1QwpyjAnw/+ZCF/g4SYQ
         okHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2sz6a7NAkW2VwlSH0qJO9zVczZnv9QOUY1IGuEHJjs=;
        fh=v8KzLmS93L7QPOAhJTjw807zrr8mOuwmAZ39ChwhpQc=;
        b=EjiUHD1IK4M/O/oSRDDQBdWb44FgQvFWEaRjfo8w0hVA5vCN3Ne+G9GVDxKSZPQ0g2
         eyUow9imHF75P3/4c4XP72e42qSfXOQHO12UxwwVYYa7k+UyxOKRZoEUZ8owOG1/XvrG
         hH2H75ns5KkaE9KuPdKHff61rT9xiwQOr0I6GvpQPJQvGyQp6Ud7QgV4JS680gUFqTbj
         jYPtxLw/zOIHlOmR/v0ETu62VfSUMzGVpUcUZZxP2UQi5ZjDnd3+06WowURYGu7LWtAp
         8XrVjA0u9eZvc0xHHuBEzQ8SqhMUerNNz09ehyEC09xHyQPJoWZgpMadlSEmaunj23Bb
         o0kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795637304; x=1796242104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g2sz6a7NAkW2VwlSH0qJO9zVczZnv9QOUY1IGuEHJjs=;
        b=SzdBUQhCJqf2b1xmvJdwUTWJRZqYk8KZJTkab1RKCRDByJ/NCF6dGEABYYhrJyGV0u
         RMhn7tlV7TQ0o34p1ttPmZotWI9864QWO4eP7vDQVFFJleUA7H52mGQqkyeswywPh4Q+
         1d/rizLBhCX5iHzBOJxpBmKS9LxW4eNRG1gd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795637304; x=1796242104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2sz6a7NAkW2VwlSH0qJO9zVczZnv9QOUY1IGuEHJjs=;
        b=OL7Y1cL6LL9Uf4uG8ONQ0CDuHQCqNoAlnwvg3LmEdlBpAFrAAgfCH1ByKyLKFHqoBq
         q9KGdN4mcqXu7Xkhe2C0lOqv0ivQzJs7xWXeofsc++uY3KdkpY5XM89VJMXb/mi7xm5E
         eQITMxv7H7LopuYQrDxKCFymc5oEXdEeL/kee0gLKdskqCKpE8myPkYM21w67jFW6Bgf
         o1MJCpnvqhH2oae45vXVet/ayGLbL9I1sjMW5wh2eWIgooT+O9bKdf/aGd6Pr7zjN5nA
         BcNrGL0f8N7BdimB6dKqwHZGgxIZhOQdVcdOVJ6fP+QVBukHqsNk9weuJevcW5qZXQN4
         we9A==
X-Forwarded-Encrypted: i=1; AL+hErFGPdBZcihkSlPlz6e8aJCr2eky9rIdGCsVKl1VwYNJCukqWdR1w71Dhz9VKn44AXP3889vDsq6FvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JVva4Uk29gNo/A4A6gI0DYsMYFPtunleprLhHvXU0DtAWWKEC
	lHsAzrMiGEq/YW82bB0BILnBnZBcK6IMvHGVja+71b9PtbuY5FZLDXa/bJXO/9peqeGO8FnRYr+
	RYEGOMqqDiE64pmdJDfdkt9Lgzpwg0/JIFiHb9mz4
X-Gm-Gg: AZFdTZcEDglZ0gONPgzr8IgcNKjMIatfZKQEH0RCqKf2ABvXq2ffvYvrbFbt50qF9lT
	PnGReb1o2Fpeq7+8tqK4qf6Ii4CzrarjJgN12OqEaQz/zHJeWg7FB44lWa/+/YiLk+4XVbozwep
	+pPXZpJF6w2t+sj4Ou1SiVQSKSDsN8I/Zrjq1TBXGTmdTXcXFWaw3EKKdQ4b1SyWO0HekAimvg3
	8kj6o3wJXkY5KIpQdA3cSvAS4j1lYDtm5mTQNe5d/s1p9jP7JvAojNM/T9VuiGHk13twht5zHuc
	yCqZvYwnnhDTv8hexNxVlFoEeWAd4OBuXpRltZHTGdLqQyqLTJi2TZ0yiQSHSFlgw0IXl94n3Sv
	/Yo0L589mH7IdXpl8w302y+LH/NrccSsnZl9z66ID+77WAxAnYdk7X5hAp5LwztdFmiQx
X-Received: by 2002:a05:690e:128f:b0:67d:c8a9:c607 with SMTP id
 956f58d0204a3-67df447fee9mr7204157d50.58.1795637303877; Wed, 25 Nov 2026
 12:08:23 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 25 Nov 2026 12:08:12 -0800
X-Gm-Features: Aa3M54oC0J4hEvF8nL8DG0lKyvPdcHpLfWm3L9Zu9MgNC1XuuWU_i9PXhdfqRu4
Message-ID: <CAEe3GZEWAApD0ZvQX4J5Uo8aajEtpVzg6JsGLqB8GKNv6ug06Q@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Add spi-hid transport driver
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
	Jarrett Schultz <jaschultz@microsoft.com>, Dmitry Antipov <dmanti@microsoft.com>, 
	Angela Czubak <acz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin,

Gentle ping on this series. The DT binding has been reviewed by Rob and
Conor, and I've replied to the outstanding bot review comments.

Please let me know if you have any further feedback, or if there's
anything I can do to help move this forward.

Thanks,
Jingyuan

On Fri, Oct 23, 2026 at 5:51=E2=80=AFPM Jingyuan Liang <jingyliang@chromium=
.org> wrote:
>
> This series picks up the spi-hid driver work originally started by
> Microsoft. The patch breakdown has been modified and the implementation
> has been refactored to address upstream feedback and testing issues. We
> are submitting this as a new series while keeping the original sign-off
> chain to reflect the history.
>
> Same as the original series, there is a change to HID documentation, some
> HID core changes to support a SPI device, the SPI HID transport driver,
> and HID over SPI Device Tree binding. We have added the HID over SPI ACPI
> support, power management, panel follower, and quirks for Ilitek touch
> controllers.
>
> Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
>                   Dmitry Antipov <dmanti@microsoft.com>
> Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gmai=
l.com
>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
> Changes in v7:
> - Drop the error counter sysfs attributes.
> - Print error codes in power up/down failure messages.
> - Reject an empty report descriptor.
> - Check the minimum input report body size instead of max_input_length.
> - Clear reset_attempts only after the report descriptor check succeeds.
> - Drop pending work flags when the error handler resets the device.
> - Don't schedule a reset when GET_FEATURE fails with -ENODEV.
> - dt-bindings: drop the address/opcode properties and the "hid-over-spi"
>   fallback; the compatible determines them.
> - dt-bindings: fix authorship to match the Signed-off-by chain.
> - dt-bindings: update maintainer email addresses.
> - dt-bindings: drop Rob's Reviewed-by because the binding changed.
> - of: use per-compatible match data; match only
>   "microsoft,g6-touch-digitizer".
> - pm: disable reset_work across suspend.
> - pm: check deassert_reset(); schedule recovery on reset timeout.
> - pm: skip hid_driver_reset_resume() when the device is not ready.
> - pm: log power_down() failure instead of rolling back suspend.
> - pm: use dev_err() instead of dev_WARN_ONCE() for a failed device
>   descriptor request.
> - panel follower: start with reset_work disabled.
> - Drop Dale's Tested-by from the OF, PM and panel follower patches
>   because they changed since v4.
> - Link to v6: https://lore.kernel.org/r/20261019-send-upstream-v6-0-cb9ba=
4b3d6fa@chromium.org
>
> Changes in v6:
> - Take output_lock while reallocating buffers in ll_start()
> - Don't drop input reports while a refreshed device probes
> - OF: drop mod_devicetable.h, use named initializers, fix alignment
> - Move the dt-bindings patch before the OF driver patch
> - Drop Tested-by from the documentation and DT binding patches
> - Link to v5: https://lore.kernel.org/r/20261009-send-upstream-v5-0-384af=
01da3ee@chromium.org
>
> Changes in v5:
> - Fix request/response races; match GET_FEATURE responses by report ID
> - Reset the device on response timeout; wait uninterruptibly
> - Validate device descriptor and report lengths; fix buffer sizing
> - Honor rtype in raw_request(); fix GET_REPORT off-by-one
> - Use hid_safe_input_report(); forward input reports only while open
> - Disable IRQ around hid_device teardown; fix a sparse warning
> - Use disable_work_sync() for reset_work in remove()
> - Cap trace copies at 64 bytes; cacheline-align read approval buffers
> - ACPI: select RESET_CONTROLLER, use device_reset_optional()
> - OF & DT: read opcodes as u8, use dev_err_probe(), require reg
> - PM: cancel reset_work on suspend, wait for reset before
>   reset_resume(), fix IRQ imbalance on resume failure
> - Panel follower: fix regulator/IRQ imbalance; depend on DRM || !DRM
> - Link to v4: https://lore.kernel.org/r/20260609-send-upstream-v4-0-b843d=
5e6ced3@chromium.org
>
> Changes in v4:
> - Extended io_lock scope to protect the shid->hid pointer lifecycle
>   against races with the IRQ handler
> - Cacheline-aligned DMA buffers, enforced 4-byte alignment
> - Added error rollback for failed suspend/resume transitions
> - Moved IRQ request to probe with IRQF_NO_AUTOEN (disabled by default)
> - DT Bindings & OF Driver:
>   - Required a device-specific compatible string in the schema.
>   - Added description to explain why opcodes and addresses properties
>     need to be defined in the schema
>   - Added `spi-peripheral-props.yaml` reference and switched to
>     `unevaluatedProperties: false`.
>   - Added fallback to default timing parameters in OF driver if match
>     data is missing.
> - Link to v3: https://lore.kernel.org/r/20260402-send-upstream-v3-0-6091c=
458d357@chromium.org
>
> Changes in v3:
> - Add io_lock init
> - Relocate tracepoints to drivers/hid/spi-hid/ and fix tracepoint macros
> - Add tracepoints for sync, error handling, reset, and report processing
> - Clean up internal includes and fix Makefile CFLAGS
> - Add more details in v2 changelog
> - Link to v2: https://lore.kernel.org/r/20260324-send-upstream-v2-0-521ce=
8afff86@chromium.org
>
> Changes in v2:
> - Clean up DT bindings: fix formatting and remove timing and flags proper=
ties
> - Update DT binding example: use a device-specific compatible and drop
>   reset_assert
> - Simplify ACPI/OF match tables by removing ACPI_PTR/of_match_ptr
> - Refactor OF driver to use match data for timing parameters instead
>   of DT properties
> - Switch to fsleep() for delays in ACPI and OF drivers
> - Drop patch 12 as it is vendor specific
> - Add a lock to fix input/output concurrency race
> - Link to v1: https://lore.kernel.org/r/20260303-send-upstream-v1-0-1515b=
a218f3d@chromium.org
>
> ---
> Angela Czubak (2):
>       HID: spi-hid: add transport driver skeleton for HID over SPI bus
>       HID: spi-hid: add ACPI support for HID over SPI
>
> Dmitry Antipov (1):
>       dt-bindings: input: Document hid-over-spi DT schema
>
> Jarrett Schultz (3):
>       Documentation: Correction in HID output_report callback description=
.
>       HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
>       HID: spi-hid: add device tree support for HID over SPI
>
> Jingyuan Liang (5):
>       HID: spi-hid: add spi-hid driver HID layer
>       HID: spi-hid: add HID SPI protocol implementation
>       HID: spi-hid: add spi_hid traces
>       HID: spi-hid: add power management implementation
>       HID: spi-hid: add panel follower support
>
>  .../devicetree/bindings/input/hid-over-spi.yaml    |   75 +
>  Documentation/hid/hid-transport.rst                |    4 +-
>  drivers/hid/Kconfig                                |    2 +
>  drivers/hid/Makefile                               |    2 +
>  drivers/hid/hid-core.c                             |    3 +
>  drivers/hid/spi-hid/Kconfig                        |   50 +
>  drivers/hid/spi-hid/Makefile                       |   12 +
>  drivers/hid/spi-hid/spi-hid-acpi.c                 |  261 +++
>  drivers/hid/spi-hid/spi-hid-core.c                 | 1698 ++++++++++++++=
++++++
>  drivers/hid/spi-hid/spi-hid-core.h                 |  112 ++
>  drivers/hid/spi-hid/spi-hid-of.c                   |  211 +++
>  drivers/hid/spi-hid/spi-hid-trace.h                |  184 +++
>  drivers/hid/spi-hid/spi-hid.h                      |   45 +
>  include/linux/hid.h                                |    2 +
>  14 files changed, 2659 insertions(+), 2 deletions(-)
> ---
> base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
> change-id: 20260212-send-upstream-75f6fd9ed92e
>
> Best regards,
> --
> Jingyuan Liang <jingyliang@chromium.org>
>
