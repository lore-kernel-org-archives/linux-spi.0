Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794487845;
	b=02iG3zFQJsnW/o/rGhFL6yquNNBIS9sk6atrngvGssZUsdCudxfAEdTksJt8IxVG9zyV
	 nMFigR8REguAwpyCFI/+MSY5jasTQHfM8nheqHX0anA5weVwiJ7zD5sSwSK8h2UItu3+M
	 mUPWX1WiDg3R0HZiOpYK+AV2EhkszlNHWSb/fRpAKptLck+t5UZiY03Y5cUhJl4/JDEcD
	 JOEUeQHnuLbFmCWkIh1QPVhdfiuxmA+2rygT8UN4W9kNlZbzFibTjIh6p9fJW/LHz7RZF
	 EUTjnSMV6iV/RY3/zneuNnmm8YepkcwMmFdXpBuwWtF3h1fGz7YVFLUL7yTyCCHnD6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ifj6UiXfbSJBfBSvReqtUSI9DQmeGitKOnO0xdeombg=;
	b=I/NNLbkLR2/BGEhczL2Mm67o4uo0cOU2ika1CV3ipJmC4eCGHVJTTkxcixvH5Gl1ZnQx
	 /PVp5/ZXMX5B3uun5000YlrerAsoYrhzTvGgFUq13mgGOXqhwSfOmWPmZkFwnyGPJ+vfm
	 W7bb7mtYjJ4O+WX7jJtqqftz/xdL+Qr6x0uwxx1wtn3asx3NjFEHeHc0ek1/d0FMcn1La
	 bdyefR5LJ8il3qRh0GX07gdyhQBapviRqmemBilHEIaR6194PxHntiwTK1v+dvRm6dID4
	 EFW83FgCzFK0SdUqfHxu+Woxs2H91jqSchkyU1TfZKWaUVzIyuXhOyGmNTrFH2gVOCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egsq4o7R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D5606A32A
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 12:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D50D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egsq4o7R
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3acec6677so6269522c88.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 04:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794487844; cv=none;
        d=google.com; s=arc-20260327;
        b=p5QM/2PvmsNCWQY6NLuxK2w46dFIWVXuWLH6luQmBIDv7Qko6Rxs4cxixV9Rr70EvJ
         qd9bOGMQ2yojKDFdZBKxjAxkxTCTHFyZdjJyf1btz5ov9SFUOg/HJ3GKcAHtv3q0Nnti
         8iCvoIqoMft9XFtVq6Bs1I7SGTqkRmIg1bC31XFrZDifjHdjgu8d32Ob9zkF3+8UqLL5
         +pRWH+cw7hWvOCNyKXlYUg65N+JgOKO08DPaqzkKpTGLZIJkJhZ3nFZi8TgMMiaQHe5H
         XZCBlX2p/VRmyb+HPHm7AkdNfz6H3B9U7xn9nRmH+hOpngkR4QgatNJXyKg13PhIj/bN
         BwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ifj6UiXfbSJBfBSvReqtUSI9DQmeGitKOnO0xdeombg=;
        fh=6gYjsQLUiYfKjdiQKARdSnLQjYELOoPw/yCo88ttzrg=;
        b=jLs9IUc4WQ1R3gfhjggR83WbZtU++01UuZm9SS7zQgMmwt8KsPfNWrgDPqyItAITSI
         CGuDM8LwHelprVDOYrzUYryGxiNbx+Cj10Uk4ajcc9Q5bS08KU7czmtfR7M9T7IUd4Iy
         VYnWtjTXWfKzJ8yPZeQ1iVY7ZgJkmNNpNtZlhUmYLfvj1wEz/t4xLFbdg8MTlJGnMjt5
         TX2j+4oPQQqKFZw/QZ+NeQRaj5uUiGxLWr4652qrBLeVFizl04gdOQwdMqW+4TQBnZxb
         Tlcp55Pq8eJPJ5pZ/b1NNlzGndpJbooGhanYS1+NjHPVNpnW14cxSQavmKqy8bABlIo6
         T13w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794487844; x=1795092644; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ifj6UiXfbSJBfBSvReqtUSI9DQmeGitKOnO0xdeombg=;
        b=Egsq4o7RUxtUqWQP0xuRF09bumu/ZWKK+RAmetdjLraeVC9iDjE2oV/svQD3s63ecM
         jSkyQCUqb/gBQn6e5xnUvjeTC8TunvGusUJ9Qz1XNH+KBsvbNofaDEYpM+ZcrKraXed4
         S0MEORv5Yf7xMoVonS1t9RUXDyOks1qLIwbpZJAGppHdHUO0f5uybz9wFn5G+vxQEOe6
         MTIrffxOwVnSTw7bdJvFXwrLNAGwyqIv737Ifm34T4A34pJ2Z8q9I0fSEWmbnY2Dlnhm
         q8pk/2vqILVZrhorV2G3vKwnfnmmEMdkVi6FSu9wFdl652Y3jdg82jUhO+y7vg+Q/XIj
         iMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487844; x=1795092644;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ifj6UiXfbSJBfBSvReqtUSI9DQmeGitKOnO0xdeombg=;
        b=Lp2UkWHtg4RxSEB8a+WRtWDKTXt5C8XLoclTLjbSa+gZG0e6vrrLKGZSqe2LT/Q088
         AVLDq6luKHUvL4spuSAWPaI8hmGvR9XJ/1UMu/KcyXTxAN+Zgb+NA/Ks+LksLd1Tkw4G
         oMSkqKY0GODJYf4CnhRmwGHAonMTF4vx6lvmuf70bOHrCJNCuTpgJ15CJW3wVfT21d+D
         U543BbjrW6/7RwW+2f2Rnm4bftGoeMVm+qV8VyJc6PhRybLrI5hZGM6NaqprK4ig6v/y
         FmC3WzuX44LsHkJQ6nYuWPGv73RKZL3AtEWGmw3SA71TgtOZCAL+aZq54M3xiJ1uPb8M
         3tAw==
X-Forwarded-Encrypted: i=1; AL+hErEvfjGh60OZgAL4Wl9VG/TRRP0uOu0OyhxmaMoz2deaGQShOKZer49YD3MKZqrJEm5A/kD7lWVJrXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1Xbip5LzKZVcxHfRupL9TbAXSYcVM4KunIIs+ABgPxSe22yaE
	tU0pcK1c8L5CP3Q1oikx7aU7pbXHueGwaNOFItU7tGvoCEruFMYB3easUvxreXCBt2kafFOXJXp
	8cbh1OsvIxmokLp9jaOhs8kW3sSLcwr0=
X-Gm-Gg: AYBFou39dbmkyPtuQOBQWl7Ue1bMnk5mSxfbMki9EwFe9V58OksegIstj+BI27ztvIA
	CCx1fB27hQ8j44/Vwc4eNVdJVG/K9H+ysBZAVpYjRh9+fnbhsYd8mE/WTaoMjqGfJDGRFySqyYl
	OvjGDrEN+pgE0HtGmn8KYLZwnLatErg+fEuJNQhJSh5ItToVXOdwiJxaf/FPR39eLanli5Brrzv
	73tMinJvEmV1Xmm5FQoqYKKVTIea7NeAqBKB82Nl3c1eSmPJCMttXa7pnVnjWu6W9FrWexjyKdr
	vuxu0nQCHMwXmwSaUlMrIEiNQAA9ZQB4IIv8iJdVoQoIZgBVIQpLE9OC/W6c+OgcoIfgn/G1AqN
	yuXH7wH9RUO75keExDsuik4etUtEX72Jqf+SXOg==
X-Received: by 2002:a05:7022:285:20b0:143:8860:afa1 with SMTP id
 a92af1059eb24-1b3c036c2cbmr5206179c88.46.1794487843798; Thu, 12 Nov 2026
 04:50:43 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com>
In-Reply-To: <20261110-spi-runtime-pm-fix-v1-1-8601ebb2f6a8@collabora.com>
From: Alexander Shiyan <eagle.alexander923@gmail.com>
Date: Thu, 12 Nov 2026 15:50:31 +0300
X-Gm-Features: AclHuK9YSfZpEJ-wscqvwDM5JwyJ270P-Q2k4wqitCYhbsGJfgD_snqVmQhs_tc
Message-ID: <CAP1tNvQY3wzyXrXJmJ+MpdT5S2gSK5r91qA2rWtRW-NtN1QEnA@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix runtime PM imbalance on pump transfer message error
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Mark Hasemeyer <markhas@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[root@diasom-evb ~]# rtcwake -s 15 -v -m freeze
rtcwake: assuming RTC uses UTC ...
Using UTC time.
        delta   = 39
        tzone   = 0
        tzname  = UTC
        systime = 1773421897, (UTC) Fri Mar 13 17:11:37 2026
        rtctime = 1773421858, (UTC) Fri Mar 13 17:10:58 2026
alarm 0, sys_time 1773421897, rtc_time 1773421858, seconds 15
rtcwake: wakeup from "freeze" using /dev/rtc0 at Fri Mar 13 17:11:14 2026
suspend mode: freeze; suspending system
[  195.026100] PM: suspend entry (s2idle)
[  195.026582] Filesystems sync: 0.000 seconds
[  195.031059] Freezing user space processes
[  195.032653] Freezing user space processes completed (elapsed 0.001 seconds)
[  195.033266] OOM killer disabled.
[  195.033547] Freezing remaining freezable tasks
[  195.049016] Freezing remaining freezable tasks completed (elapsed
0.015 seconds)
[  195.318497] xhci-hcd xhci-hcd.3.auto: xHC error in resume, USBSTS
0x401, Reinit
[  195.319141] usb usb3: root hub lost power or was reset
[  195.319588] usb usb4: root hub lost power or was reset
[  195.321839] usb usb8: root hub lost power or was reset
[  195.324626] usb usb7: root hub lost power or was reset
[  195.338354] xhci-hcd xhci-hcd.0.auto: xHC error in resume, USBSTS
0x401, Reinit
[  195.338996] usb usb1: root hub lost power or was reset
[  195.339443] usb usb2: root hub lost power or was reset
[  195.354495] xhci-hcd xhci-hcd.4.auto: xHC error in resume, USBSTS
0x401, Reinit
[  195.355136] usb usb5: root hub lost power or was reset
[  195.355584] usb usb6: root hub lost power or was reset
[  195.359476] rk_gmac-dwmac fe1c0000.ethernet: init for RGMII_RXID
[  195.384855] dwmac4: Master AXI performs any burst length
[  195.387322] rk_gmac-dwmac fe1c0000.ethernet end3: No Safety
Features support found
[  195.389691] rk_gmac-dwmac fe1c0000.ethernet end3: IEEE 1588-2008
Advanced Timestamp supported
[  195.392178] rk_gmac-dwmac fe1c0000.ethernet end3: configuring for
phy/rgmii-rxid link mode
[  195.442885] r8169 0004:41:00.0 end1: Link is Down
[  195.484890] r8169 0002:21:00.0 end0: Link is Down
[  195.490337] rk_gmac-dwmac fe1b0000.ethernet: init for RGMII_RXID
[  195.522987] dwmac4: Master AXI performs any burst length
[  195.524320] rk_gmac-dwmac fe1b0000.ethernet end2: No Safety
Features support found
[  195.526697] rk_gmac-dwmac fe1b0000.ethernet end2: IEEE 1588-2008
Advanced Timestamp supported
[  195.529185] rk_gmac-dwmac fe1b0000.ethernet end2: configuring for
phy/rgmii-rxid link mode
[  195.656869] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  195.760866] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  195.864875] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  195.968867] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  196.072873] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  196.073408] hdmi-audio-codec hdmi-audio-codec.9.auto: HDMI: Unknown
ELD version 0
[  196.176872] dwhdmiqp-rockchip fdea0000.hdmi: i2c read timed out
[  196.518457] OOM killer enabled.
[  196.518736] Restarting tasks: Starting
[  196.519279] pcieport 0000:00:00.0: no suspend buffer for LTR; ASPM
issues possible after resume
[  196.522351] Restarting tasks: Done
[  196.522832] random: crng reseeded on system resumption
[  196.523321] PM: suspend exit
[root@diasom-evb ~]# [  196.534793] mmc_host mmc1: Bus speed =
400000Hz (req 400000Hz, actual 400000HZ div = 0)
[  196.697114] mmc_host mmc1: Bus speed = 148500000Hz (req
150000000Hz, actual 148500000HZ div = 0)
[  197.068697] dwmmc_rockchip fe2c0000.mmc: Successfully tuned phase to 208

[root@diasom-evb ~]#

So,
Tested-by: Alexander Shiyan <eagle.alexander923@gmail.com>

>
> The current SPI message pumping code may drop the runtime PM twice when
> an SPI message cannot be sent:
>
> spi_master spi2: noqueue transfer failed
> rockchip-spi feb20000.spi: Runtime PM usage count underflow!
>
> Fix the problem by always keeping the runtime PM count increased when
> exiting __spi_pump_transfer_message(), as the caller handles decreasing
> it.
>
> Note, that the function already keeps the RPM usage counter increased
> for the error paths following after the prepare_transfer_hardware step.
>
> Cc: stable@vger.kernel.org
> Fixes: bef4a48f4ef7 ("spi: Fix null dereference on suspend")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> I noticed this with RK3588 system suspend/resume, which uses SPI based
> PMIC and runs into SPI transmission problems when the PM domain driver
> tries to disable regulators required by e.g. NPU or GPU domain. I've not
> yet checked too closely, but suspect Heiko's atomic SPI transmission
> support series might also help with fixing the actual failure.
>
> My patch is not really a v2, but Alexander Shiyan probably ran into the
> same issue before and came up with a way different patch and rationale:
>
> https://lore.kernel.org/linux-rockchip/20260806191854.922530-1-eagle.alexander923@gmail.com/
> ---
>  drivers/spi/spi.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ce257b3ec530..4d9c5d026ff6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1967,7 +1967,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
>         if (!was_busy && ctlr->auto_runtime_pm) {
>                 ret = pm_runtime_get_sync(ctlr->dev.parent);
>                 if (ret < 0) {
> -                       pm_runtime_put_noidle(ctlr->dev.parent);
>                         dev_err(&ctlr->dev, "Failed to power device: %d\n",
>                                 ret);
>
> @@ -1988,9 +1987,6 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
>                                 "failed to prepare transfer hardware: %d\n",
>                                 ret);
>
> -                       if (ctlr->auto_runtime_pm)
> -                               pm_runtime_put(ctlr->dev.parent);
> -
>                         msg->status = ret;
>                         spi_finalize_current_message(ctlr);
>
>
> ---
> base-commit: 059518f775baecc9803fc97787bd0b17558f8047
> change-id: 20261110-spi-runtime-pm-fix-529325c25582
>
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
>
