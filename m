Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B311C861D
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000417; cv=pass; b=KHi82xkRv7zcIvqb4w+/7iE9c78uJz4gBlwb0XgrszvT5d3v0EyGylXbRtVDlb/9X2F7a2nQOsSDXaFTvjP8X/7U5sDVU3tez+cI0uZwiBAxiGRN9Vt/BwbIHxQhkuoa8wjax+tcYGReu9RYOOTkV+AGxGIL0iTZZq+35ay/SxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000417; c=relaxed/simple;
	bh=GXIy6gSbpOTJRqSeamJKRx1h5JwdDdsFgaIbjpNTZ6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oMqZw23rI+igtC4vqaBovSSKB2QSLvcVDLOlP1JZT3+WbShbgrgXgkM5HfXZunvTbdBFMuWrPdf9OccTZj7KE5MgO7HD1KiaqwnNPCbsXA1XFGkNTm0pNGa1NjWQayqC3QLNA1CZjNiB9dKbgEiZCrDz0HQfDGlBZBZYmTMPnlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=JYc4VjRP; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="JYc4VjRP"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c7991578c2so2947402e0c.3
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2026 17:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789000414; cv=none;
        d=google.com; s=arc-20260327;
        b=DfGjGxuPtVfUUDi3qZitpfwV6UAN6SHZ3CKmFIFNNejFFt/8e+oCePFWL0eWbo6J3D
         Nazde/fThJieUTrLvk1tBqhkx5gIlxK2CiDgAZZehf/xOlEo+GOpc4ByYvVTG7l/n9ti
         39H7mi38xAG6BWTaZqCsNn+/arF0Gk+hGJgdGQ6TSPDeXFOZzkEA0ALnNmw2e9HHuiAK
         THDSS+owXFoarpRIqNp9YHePyJrV2EPNcLj2I/CWl6gdxqRsi8JCQq8ZkC5Q/4/1V+t0
         qiFzUGy1Y5iRTLUvMSTzsyyW+mbp7coGNxErAThplS/efmXq9YwqgHhviN1wLvjL8YR1
         e+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rS6b2cKMe+pTuGEWnp7nts32PRJnBz9LYO+E6vFdj2g=;
        fh=bxnLb+6p9Jw723dlCX+IvuN8LLf7rDeOL2aR5F22WVU=;
        b=jsWm/wkvGt7bdK67dZ9Z/kNa/rIscTCoiYFGM6J3K7eE4+XEP31GueDjfmql0FmhyR
         4vS8nsMggguqUNLPaiAvmyG7bpQ7raA/E5ueIgtU4hIh9xcDI8s9WXq7YYtZY7pA+BpL
         w+lEwU10zywXJBhPDUur/hlHjUvNzvyG5NMmoS+CDPdpolYrn+6ttWx7om7LNnPlx047
         2bNIEgHwvKbDeisz59ppZVgyJtXgYgAsPTzi7zpaQcWBGFdw8XAC0p2jlyV8gyPDsvOs
         Jt+BLcIVw7QfFYztHGlXQHKOoJaILT055DkkvgCKEV0PQhSzhNArHW9I/NGUsU39/7wV
         NVGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789000414; x=1789605214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rS6b2cKMe+pTuGEWnp7nts32PRJnBz9LYO+E6vFdj2g=;
        b=JYc4VjRP1/tO/tlmLm76ZQgSHSGgaowrkTVX0kw4vDdA6oZaCgkBbSB4prG8tjQHq1
         184gvAvBgc9JzJjquM7dXaXKztUSFdLTic2VsmHWl2rdWgHR0uLYYBdGiYYnykgjZhPj
         zA/WvPOBjUadJQE2T1mbvi/mSR/H+EyAoScqZB3dhmvNPKUcuhVBkXUjFbHhFYgjyq5E
         oXyMDZ+tacEYt4DzQE/7BeXHhOaity8oeytq+BXPZ1p8Vu0llC9GkggMbFqTzrf3arXX
         2m9ze3XHawQlJhQfPww0bFW8dWZLfWKSySmwP2Wu8XjQT4+5gClC9tPOH4EGS6oTwu8n
         Q4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789000414; x=1789605214;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rS6b2cKMe+pTuGEWnp7nts32PRJnBz9LYO+E6vFdj2g=;
        b=QpnagLklO1XQVnVp1hp6bJILY89FGl/lj9Af9mE+kCtr7bBgMcmO1JRhBDPUW1j3oS
         Gs/TW0iSoA6b3fwOHZmYb/EbV7OYSeGeHVX5xwjCbriDS8MpeMptZWQbEBNOyZ80QHPo
         MjFhluDU3qJ6HoQjx3zUJtKyjYXMPLXCHnx9ddMZbK0syEIfqm84GC536FKuc0bDSL9f
         /Fwx1Pmfx+t8scUhIF+sLMTg6oiTNxwj4mXILSs5xEEdCzP5gWufkghefE8lqfGhX+Qn
         MLNzArbYjQqz1PII3jM6uLXgC/AGh1AIubCHwfJXb0TWxk8aqpCrmFM2NNC1mtvwAYN7
         TVFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHd2OQkqkOoUPN1rZrynkV+db2jZevHNWNmsdsKO+ywiIMiVkb8lHkxrQE/ZDzCQ3mtf4zhv5Oquc=@vger.kernel.org
X-Gm-Message-State: AFuF++m0XFS19ZG5dpzmbJr+DcStHGicyTZ3KfdntJh+IP3wujpBT/N7
	fGY2bm460sSDGFe3KLE7Fbc5i50PUKNrc9+BDl49SlGj+8QaE6DJQ7//TRZJdtlbrM1n7HNuPBk
	UMF78mRsWuLU/g+0xz0LheX6yAtFcgzssONdVOt/VnPpW6jr73pSZ1trwgfY=
X-Gm-Gg: AYBFou1IZqP9iz41XCtsIZENawHwLexyL+8Ill3/XGq104TeQFGUKoSE8IaKE4PCoI5
	aCqY89xenoYvtCzaCwBtQSlSQegraqqJ7FlXfJKEOeluNKoKnInRjmZ0SbFg9YyWM+WTT6vpKvv
	ZKUCtjxKYi0fziu/1aDnP5OmrH5ZCUPg0IewmALytU676YhM/m+20g1pXQPqVjfhCUWyPbA1yWJ
	TDizwYHEd3OyjGHM8S0XEwxcnL9+uYjRMXRidnSG3wnz5hi3IyWjTVP8aJZWYADKTBZERY6cr6a
	V+iLxPa/RZ3tsC3XvimQphlx+ZiByjCeoSwaIycp2BW1L4+dlgUP0qFxZROUo/5qjIl7MWk32mC
	R2l0tO5OSaj47rlfJnjML7x9pFg65elSXrsRP/pI=
X-Received: by 2002:a05:6122:794:b0:5bd:af82:fd9e with SMTP id
 71dfb90a1353d-5c7ed437367mr18965931e0c.8.1789000412687; Wed, 09 Sep 2026
 17:33:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Wed, 9 Sep 2026 17:33:20 -0700
X-Gm-Features: AcwNN1XPy1pHuYRPh3UqbZNL1bEevW4rwYxwr2q7u0oEbQRUuSDFAy2KfvBn308
Message-ID: <CA+0ovCioY634b646jDcs2cFmg_1q2UMN4wuTQ1V26Gy+Dm_c+A@mail.gmail.com>
Subject: [BUG] UBSAN: shift-out-of-bounds in dln2_spi_probe
To: Mark Brown <broonie@kernel.org>
Cc: Farhad Alemi <falemi@asu.edu>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c9b8e065b161ee1"

--0000000000001c9b8e065b161ee1
Content-Type: text/plain; charset="UTF-8"

Hello,

We are reporting the following crash (reproducer and a proposed patch attached):

Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   50.563179][  T987] usb 3-1: new high-speed USB device number 2
using dummy_hcd
[   50.724668][  T987] usb 3-1: New USB device found, idVendor=a257,
idProduct=2013, bcdDevice= 1.00
[   50.728082][  T987] usb 3-1: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
[   50.757406][  T987] dln2 3-1:1.0: Diolan DLN2 serial 0
[   50.763502][  T987] gpiochip_add_data_with_key: GPIOs 0..-1 (dln2)
failed to register, -22
[   50.763517][  T987] dln2-gpio dln2-gpio.2.auto: failed to add gpio chip: -22
[   50.763525][  T987] dln2-gpio dln2-gpio.2.auto: probe with driver
dln2-gpio failed with error -22
[   50.789064][  T987] ------------[ cut here ]------------
[   50.789071][  T987] UBSAN: shift-out-of-bounds in
drivers/spi/spi-dln2.c:179:15
[   50.789083][  T987] shift exponent 18446744073709543487 is too
large for 64-bit type 'typeof(unsigned long)' (aka 'unsigned long')
[   50.789098][  T987] CPU: 1 UID: 0 PID: 987 Comm: kworker/1:3 Not
tainted 7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   50.789108][  T987] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   50.789114][  T987] Workqueue: usb_hub_wq hub_event
[   50.791092][  T987] Call Trace:
[   50.791098][  T987]  <TASK>
[   50.791106][  T987]  dump_stack_lvl+0xe8/0x150
[   50.791118][  T987]  ubsan_epilogue+0xa/0x30
[   50.791129][  T987]  __ubsan_handle_shift_out_of_bounds+0x385/0x410
[
** replaying previous printk message **
[   50.791149][  T987]  dln2_spi_probe+0x104d/0x13c0
[   50.791165][  T987]  ? __pfx_dln2_spi_probe+0x10/0x10
[   50.791178][  T987]  ? up_write+0x1a5/0x4a0
[   50.791189][  T987]  ? kernfs_put+0x77b/0x7e0
[   50.791200][  T987]  ? acpi_has_method+0x20/0xe0
[   50.791211][  T987]  ? dev_pm_domain_attach+0xbd/0xf0
[   50.791222][  T987]  ? __pfx_dln2_spi_probe+0x10/0x10
[   50.791232][  T987]  platform_probe+0xf9/0x190
[   50.791241][  T987]  ? __pfx_platform_probe+0x10/0x10
[   50.791248][  T987]  really_probe+0x267/0xaf0
[   50.791259][  T987]  __driver_probe_device+0x1e2/0x350
[   50.791269][  T987]  driver_probe_device+0x4f/0x240
[   50.791279][  T987]  __device_attach_driver+0x270/0x410
[   50.791290][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.791301][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.791310][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.791321][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.792223][  T987]  __device_attach+0x2c5/0x450
[   50.792233][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.792243][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.792254][  T987]  device_initial_probe+0xa1/0xd0
[   50.792263][  T987]  bus_probe_device+0x12a/0x220
[   50.792275][  T987]  device_add+0x7ec/0xb90
[   50.792285][  T987]  platform_device_add+0x46a/0x800
[   50.792296][  T987]  ? __asan_memcpy+0x40/0x70
[   50.792311][  T987]  mfd_add_devices+0x125c/0x17c0
[   50.792322][  T987]  ? __dev_printk+0x131/0x190
[   50.792339][  T987]  ? __pfx_mfd_add_devices+0x10/0x10
[   50.792353][  T987]  ? dln2_hw_init+0x25c/0x270
[   50.792362][  T987]  ? __pfx_dln2_hw_init+0x10/0x10
[   50.792374][  T987]  dln2_probe+0xef9/0xfd0
[   50.792383][  T987]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   50.792398][  T987]  ? __pfx_dln2_probe+0x10/0x10
[   50.792406][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.792416][  T987]  ? __pm_runtime_set_status+0x9d4/0xcd0
[   50.792428][  T987]  usb_probe_interface+0x71f/0xe00
[   50.792443][  T987]  ? __pfx_usb_probe_interface+0x10/0x10
[   50.792457][  T987]  ? driver_sysfs_add+0x1fe/0x210
[   50.792466][  T987]  ? __pfx_usb_probe_interface+0x10/0x10
[   50.792475][  T987]  really_probe+0x267/0xaf0
[   50.792486][  T987]  __driver_probe_device+0x1e2/0x350
[   50.792496][  T987]  driver_probe_device+0x4f/0x240
[   50.792506][  T987]  __device_attach_driver+0x270/0x410
[   50.792517][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.792527][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.792536][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.792548][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.792560][  T987]  __device_attach+0x2c5/0x450
[   50.792569][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.792579][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.792590][  T987]  device_initial_probe+0xa1/0xd0
[   50.792599][  T987]  bus_probe_device+0x12a/0x220
[   50.792611][  T987]  device_add+0x7ec/0xb90
[   50.792621][  T987]  usb_set_configuration+0x1a87/0x2110
[   50.792642][  T987]  usb_generic_driver_probe+0x8d/0x150
[   50.792652][  T987]  usb_probe_device+0x1c4/0x3b0
[   50.792664][  T987]  ? __pfx_usb_probe_device+0x10/0x10
[   50.792673][  T987]  really_probe+0x267/0xaf0
[   50.792684][  T987]  __driver_probe_device+0x1e2/0x350
[   50.792694][  T987]  driver_probe_device+0x4f/0x240
[   50.792704][  T987]  __device_attach_driver+0x270/0x410
[   50.792714][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.792724][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.792733][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.792745][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.792756][  T987]  __device_attach+0x2c5/0x450
[   50.792766][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.792776][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.792786][  T987]  device_initial_probe+0xa1/0xd0
[   50.792796][  T987]  bus_probe_device+0x12a/0x220
[   50.792807][  T987]  device_add+0x7ec/0xb90
[   50.792817][  T987]  usb_new_device+0xa14/0x1720
[   50.792830][  T987]  ? __pfx_usb_new_device+0x10/0x10
[   50.792840][  T987]  ? _raw_spin_unlock_irq+0x23/0x50
[   50.792851][  T987]  hub_event+0x2a1c/0x4f30
[   50.792860][  T987]  ? do_raw_spin_unlock+0xf5/0x200
[   50.792888][  T987]  ? __pfx_hub_event+0x10/0x10
[   50.792901][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.792913][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.792923][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.792935][  T987]  process_scheduled_works+0xc99/0x1900
[   50.792959][  T987]  ? __pfx_process_scheduled_works+0x10/0x10
[   50.792973][  T987]  ? assign_work+0x3d5/0x5e0
[   50.792987][  T987]  worker_thread+0xa53/0xfc0
[   50.793006][  T987]  kthread+0x38b/0x480
[   50.793015][  T987]  ? __pfx_worker_thread+0x10/0x10
[   50.793022][  T987]  ? __pfx_kthread+0x10/0x10
[   50.793031][  T987]  ret_from_fork+0x514/0xb70
[   50.793042][  T987]  ? __pfx_ret_from_fork+0x10/0x10
[   50.793086][  T987]  ? __switch_to+0xc79/0x1410
[   50.793096][  T987]  ? __pfx_kthread+0x10/0x10
[   50.793106][  T987]  ret_from_fork_asm+0x1a/0x30
[   50.793123][  T987]  </TASK>
[   50.800603][  T987] ---[ end trace ]---
[   50.800625][  T987] Kernel panic - not syncing: UBSAN: panic_on_warn set ...
[   50.853815][  T987] CPU: 1 UID: 0 PID: 987 Comm: kworker/1:3 Not
tainted 7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   50.854873][  T987] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   50.855914][  T987] Workqueue: usb_hub_wq hub_event
[   50.856422][  T987] Call Trace:
[   50.856764][  T987]  <TASK>
[   50.857132][  T987]  vpanic+0x56d/0xa60
[   50.857549][  T987]  ? __pfx_vpanic+0x10/0x10
[   50.858014][  T987]  ? irqentry_exit+0x218/0x760
[   50.858498][  T987]  panic+0xc5/0xd0
[   50.858872][  T987]  ? __pfx_panic+0x10/0x10
[   50.859323][  T987]  ? __pfx__printk+0x10/0x10
[   50.859785][  T987]  check_panic_on_warn+0x89/0xb0
[   50.860298][  T987]  __ubsan_handle_shift_out_of_bounds+0x385/0x410
[   50.860938][  T987]  dln2_spi_probe+0x104d/0x13c0
[   50.861434][  T987]  ? __pfx_dln2_spi_probe+0x10/0x10
[   50.861950][  T987]  ? up_write+0x1a5/0x4a0
[   50.862387][  T987]  ? kernfs_put+0x77b/0x7e0
[   50.862841][  T987]  ? acpi_has_method+0x20/0xe0
[   50.863325][  T987]  ? dev_pm_domain_attach+0xbd/0xf0
[   50.863841][  T987]  ? __pfx_dln2_spi_probe+0x10/0x10
[   50.864370][  T987]  platform_probe+0xf9/0x190
[   50.864838][  T987]  ? __pfx_platform_probe+0x10/0x10
[   50.865355][  T987]  really_probe+0x267/0xaf0
[   50.865868][  T987]  __driver_probe_device+0x1e2/0x350
[   50.866498][  T987]  driver_probe_device+0x4f/0x240
[   50.867121][  T987]  __device_attach_driver+0x270/0x410
[   50.867757][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.868376][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.868990][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.869559][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.870253][  T987]  __device_attach+0x2c5/0x450
[   50.870822][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.871465][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.872043][  T987]  device_initial_probe+0xa1/0xd0
[   50.872619][  T987]  bus_probe_device+0x12a/0x220
[   50.873137][  T987]  device_add+0x7ec/0xb90
[   50.873595][  T987]  platform_device_add+0x46a/0x800
[   50.874110][  T987]  ? __asan_memcpy+0x40/0x70
[   50.874573][  T987]  mfd_add_devices+0x125c/0x17c0
[   50.875072][  T987]  ? __dev_printk+0x131/0x190
[   50.875546][  T987]  ? __pfx_mfd_add_devices+0x10/0x10
[   50.876076][  T987]  ? dln2_hw_init+0x25c/0x270
[   50.876543][  T987]  ? __pfx_dln2_hw_init+0x10/0x10
[   50.877172][  T987]  dln2_probe+0xef9/0xfd0
[   50.877622][  T987]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   50.878200][  T987]  ? __pfx_dln2_probe+0x10/0x10
[   50.878718][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.879294][  T987]  ? __pm_runtime_set_status+0x9d4/0xcd0
[   50.879850][  T987]  usb_probe_interface+0x71f/0xe00
[   50.880399][  T987]  ? __pfx_usb_probe_interface+0x10/0x10
[   50.880986][  T987]  ? driver_sysfs_add+0x1fe/0x210
[   50.881526][  T987]  ? __pfx_usb_probe_interface+0x10/0x10
[   50.882095][  T987]  really_probe+0x267/0xaf0
[   50.882548][  T987]  __driver_probe_device+0x1e2/0x350
[   50.883073][  T987]  driver_probe_device+0x4f/0x240
[   50.883573][  T987]  __device_attach_driver+0x270/0x410
[   50.884141][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.884656][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.885280][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.885833][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.886446][  T987]  __device_attach+0x2c5/0x450
[   50.886950][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.887564][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.888047][  T987]  device_initial_probe+0xa1/0xd0
[   50.888568][  T987]  bus_probe_device+0x12a/0x220
[   50.889062][  T987]  device_add+0x7ec/0xb90
[   50.889499][  T987]  usb_set_configuration+0x1a87/0x2110
[   50.890070][  T987]  usb_generic_driver_probe+0x8d/0x150
[   50.890610][  T987]  usb_probe_device+0x1c4/0x3b0
[   50.891161][  T987]  ? __pfx_usb_probe_device+0x10/0x10
[   50.891711][  T987]  really_probe+0x267/0xaf0
[   50.892200][  T987]  __driver_probe_device+0x1e2/0x350
[   50.892750][  T987]  driver_probe_device+0x4f/0x240
[   50.893307][  T987]  __device_attach_driver+0x270/0x410
[   50.893839][  T987]  bus_for_each_drv+0x258/0x2f0
[   50.894328][  T987]  ? __pfx___device_attach_driver+0x10/0x10
[   50.894910][  T987]  ? __pfx_bus_for_each_drv+0x10/0x10
[   50.895450][  T987]  ? _raw_spin_unlock_irqrestore+0x4c/0x80
[   50.896027][  T987]  __device_attach+0x2c5/0x450
[   50.896514][  T987]  ? __pfx___device_attach+0x10/0x10
[   50.897117][  T987]  ? _raw_spin_unlock+0x28/0x50
[   50.897603][  T987]  device_initial_probe+0xa1/0xd0
[   50.898107][  T987]  bus_probe_device+0x12a/0x220
[   50.898591][  T987]  device_add+0x7ec/0xb90
[   50.899061][  T987]  usb_new_device+0xa14/0x1720
[   50.899569][  T987]  ? __pfx_usb_new_device+0x10/0x10
[   50.900123][  T987]  ? _raw_spin_unlock_irq+0x23/0x50
[   50.900638][  T987]  hub_event+0x2a1c/0x4f30
[   50.901089][  T987]  ? do_raw_spin_unlock+0xf5/0x200
[   50.901613][  T987]  ? __pfx_hub_event+0x10/0x10
[   50.902109][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.902674][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.903247][  T987]  ? process_scheduled_works+0x94e/0x1900
[   50.903810][  T987]  process_scheduled_works+0xc99/0x1900
[   50.904376][  T987]  ? __pfx_process_scheduled_works+0x10/0x10
[   50.904968][  T987]  ? assign_work+0x3d5/0x5e0
[   50.905442][  T987]  worker_thread+0xa53/0xfc0
[   50.905917][  T987]  kthread+0x38b/0x480
[   50.906331][  T987]  ? __pfx_worker_thread+0x10/0x10
[   50.906838][  T987]  ? __pfx_kthread+0x10/0x10
[   50.907416][  T987]  ret_from_fork+0x514/0xb70
[   50.907877][  T987]  ? __pfx_ret_from_fork+0x10/0x10
[   50.908401][  T987]  ? __switch_to+0xc79/0x1410
[   50.908858][  T987]  ? __pfx_kthread+0x10/0x10
[   50.909334][  T987]  ret_from_fork_asm+0x1a/0x30
[   50.909818][  T987]  </TASK>
[   50.910402][  T987] Kernel Offset: disabled
[   50.910950][  T987] Rebooting in 86400 seconds..

Regards,
SEFCOM Lab @ ASU

--0000000000001c9b8e065b161ee1
Content-Type: application/octet-stream; name="213.patch"
Content-Disposition: attachment; filename="213.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtusdmfu0>
X-Attachment-Id: f_mtusdmfu0

LS0tIGEvZHJpdmVycy9zcGkvc3BpLWRsbjIuYworKysgYi9kcml2ZXJzL3NwaS9zcGktZGxuMi5j
CkBAIC03MCw3ICs3MCw5IEBACiAjZGVmaW5lIERMTjJfU1BJX0dFVF9NSU5fREVMQVlfQkVUV0VF
Tl9GUkFNRVMJRExOMl9TUElfQ01EKDB4NEIpCiAjZGVmaW5lIERMTjJfU1BJX0dFVF9NQVhfREVM
QVlfQkVUV0VFTl9GUkFNRVMJRExOMl9TUElfQ01EKDB4NEMpCgogI2RlZmluZSBETE4yX1NQSV9N
QVhfWEZFUl9TSVpFCQkJMjU2CisvKiBUaGUgQ1MgYml0bWFzayBpcyBjYXJyaWVkIGluIGEgdTgg
b24gdGhlIHdpcmUsIHNvIDggbGluZXMgaXMgdGhlIGNlaWxpbmcuICovCisjZGVmaW5lIERMTjJf
U1BJX01BWF9DUwkJCQk4CiAjZGVmaW5lIERMTjJfU1BJX0JVRl9TSVpFCQkJKERMTjJfU1BJX01B
WF9YRkVSX1NJWkUgKyAxNikKICNkZWZpbmUgRExOMl9TUElfQVRUUl9MRUFWRV9TU19MT1cJCUJJ
VCgwKQogI2RlZmluZSBETE4yX1RSQU5TRkVSU19XQUlUX0NPTVBMRVRFCQkxCkBAIC0yMDAsNyAr
MjAyLDkgQEAgc3RhdGljIGludCBkbG4yX3NwaV9nZXRfY3NfbnVtKHN0cnVjdCBkbG4yX3NwaSAq
ZGxuMiwgdTE2ICpjc19udW0pCiAJaWYgKHJ4X2xlbiA8IHNpemVvZihyeCkpCiAJCXJldHVybiAt
RVBST1RPOwoKIAkqY3NfbnVtID0gbGUxNl90b19jcHUocnguY3NfY291bnQpOworCWlmICgqY3Nf
bnVtID09IDAgfHwgKmNzX251bSA+IERMTjJfU1BJX01BWF9DUykKKwkJcmV0dXJuIC1FUFJPVE87
CgogCWRldl9kYmcoJmRsbjItPnBkZXYtPmRldiwgImNzX251bSA9ICVkXG4iLCAqY3NfbnVtKTsK
Cg==
--0000000000001c9b8e065b161ee1
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtusdmg91>
X-Attachment-Id: f_mtusdmg91

LyoKICogUmVwcm9kdWNlciBmb3IgMjEzLXVic2FuLXNoaWZ0LW91dC1vZi1ib3VuZHMtaW4tZGxu
Mi1zcGktcHJvYmUKICovCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPGRpcmVudC5oPgoj
aW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvaW9j
dGwuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8bGludXgvdXNiL2NoOS5oPgojaW5j
bHVkZSA8bGludXgvdXNiL3Jhd19nYWRnZXQuaD4KCiNkZWZpbmUgRVAwX01BWF9UUkFOU0ZFUiAg
NDA5NgojZGVmaW5lIEJVTEtfTUFYX1RSQU5TRkVSIDUxMgoKLyogRExOMiBwcm90b2NvbCwgZHJp
dmVycy9tZmQvZGxuMi5jICovCiNkZWZpbmUgRExOMl9IQU5ETEVfQ1RSTAkxCiNkZWZpbmUgRExO
Ml9IQU5ETEVfU1BJCQk0CiNkZWZpbmUgRExOMl9SRVNQT05TRV9IRUFERVJfTEVOIDEwCS8qIGRs
bjJfaGVhZGVye3NpemUsaWQsZWNobyxoYW5kbGV9ICsgX19sZTE2IHJlc3VsdCAqLwojZGVmaW5l
IENNRF9HRVRfREVWSUNFX1ZFUgkweDAwMzAKI2RlZmluZSBETE4yX0hXX0lECQkweDIwMAkvKiBk
bG4yX2NoZWNrX2h3KCkgcmVqZWN0cyBhbnkgb3RoZXIgaWQgKi8KI2RlZmluZSBTUElfR0VUX1NT
X0NPVU5UCTB4MDI0NAoKLyoKICogVGhlIGNoaXAtc2VsZWN0IGNvdW50IHdlIHJlcG9ydCBhcyB0
aGUgZGV2aWNlLiBkbG4yX3NwaV9jc19lbmFibGVfYWxsKCkKICogKGRyaXZlcnMvc3BpL3NwaS1k
bG4yLmM6MTc5KSBkb2VzIEdFTk1BU0sobnVtX2NoaXBzZWxlY3QgLSAxLCAwKSwgd2hpY2gKICog
ZXhwYW5kcyB0byB+MFVMID4+IChCSVRTX1BFUl9MT05HIC0gMSAtIDgxOTIpLiBUaGF0IHNoaWZ0
IGNvdW50IGlzCiAqIDY0IC0gMSAtIDgxOTIgPSAtODEyOSwgaS5lLiAxODQ0Njc0NDA3MzcwOTU0
MzQ4NyBhcyBhbiB1bnNpZ25lZCBsb25nLAogKiB3aGljaCBpcyB0aGUgZXhwb25lbnQgVUJTQU4g
cmVwb3J0cy4gTm90aGluZyBpbiB0aGUgZHJpdmVyIGJvdW5kcyB0aGlzCiAqIGFnYWluc3QgQklU
U19QRVJfTE9ORy4KICovCiNkZWZpbmUgQkFEX0NISVBTRUxFQ1RfQ09VTlQgODE5MwoKc3RhdGlj
IGludCByYXdfZ2FkZ2V0X2ZkID0gLTE7CnN0YXRpYyBpbnQgYnVsa19pbl9lcF9oYW5kbGUgPSAt
MSwgYnVsa19vdXRfZXBfaGFuZGxlID0gLTE7CnN0YXRpYyB2b2xhdGlsZSBpbnQgcmVzcG9uc2Vf
dGhyZWFkX3N0YXJ0ZWQ7CgpzdGF0aWMgdm9pZCBwdXRfbGUxNihfX3U4ICpwLCB1bnNpZ25lZCB2
KSB7IHBbMF0gPSB2OyBwWzFdID0gdiA+PiA4OyB9CnN0YXRpYyB2b2lkIHB1dF9sZTMyKF9fdTgg
KnAsIHVuc2lnbmVkIHYpCnsKCXBbMF0gPSB2OyBwWzFdID0gdiA+PiA4OyBwWzJdID0gdiA+PiAx
NjsgcFszXSA9IHYgPj4gMjQ7Cn0KCi8qIGRlc2NyaXB0b3JzIG9mIHRoZSBlbXVsYXRlZCBEaW9s
YW4gRExOLTIgKi8Kc3RhdGljIHN0cnVjdCB1c2JfZGV2aWNlX2Rlc2NyaXB0b3IgZGV2aWNlX2Rl
c2NyaXB0b3IgPSB7CgkuYkxlbmd0aCA9IHNpemVvZihzdHJ1Y3QgdXNiX2RldmljZV9kZXNjcmlw
dG9yKSwKCS5iRGVzY3JpcHRvclR5cGUgPSBVU0JfRFRfREVWSUNFLAoJLmJjZFVTQiA9IDB4MDIw
MCwKCS5iTWF4UGFja2V0U2l6ZTAgPSA2NCwKCS5pZFZlbmRvciA9IDB4YTI1NywJLyogdGhlIGRs
bjIgdXNiX2RldmljZV9pZDogRGlvbGFuICovCgkuaWRQcm9kdWN0ID0gMHgyMDEzLAkvKiBETE4t
MiAqLwoJLmJjZERldmljZSA9IDB4MDEwMCwKCS5iTnVtQ29uZmlndXJhdGlvbnMgPSAxLAp9OwoK
I2RlZmluZSBMRTE2KHYpICgodikgJiAweGZmKSwgKCgodikgPj4gOCkgJiAweGZmKQpzdGF0aWMg
Y29uc3QgX191OCBjb25maWd1cmF0aW9uX2Rlc2NyaXB0b3JbXSA9IHsKCTksIFVTQl9EVF9DT05G
SUcsIExFMTYoOSArIDkgKyA3ICsgNyksIDEsIDEsIDAsIDB4ODAsIDB4MzIsCgkvKiBpbnRlcmZh
Y2UgMCwgdmVuZG9yIHNwZWNpZmljLCAyIGVuZHBvaW50cyAqLwoJOSwgVVNCX0RUX0lOVEVSRkFD
RSwgMCwgMCwgMiwgMHhmZiwgMHgwMCwgMHgwMCwgMCwKCS8qIEVQIDB4ODEgYnVsayBJTiAgKi8K
CTcsIFVTQl9EVF9FTkRQT0lOVCwgMHg4MSwgVVNCX0VORFBPSU5UX1hGRVJfQlVMSywgTEUxNihC
VUxLX01BWF9UUkFOU0ZFUiksIDAsCgkvKiBFUCAweDAyIGJ1bGsgT1VUICovCgk3LCBVU0JfRFRf
RU5EUE9JTlQsIDB4MDIsIFVTQl9FTkRQT0lOVF9YRkVSX0JVTEssIExFMTYoQlVMS19NQVhfVFJB
TlNGRVIpLCAwLAp9OwoKc3RhdGljIHN0cnVjdCB1c2JfZW5kcG9pbnRfZGVzY3JpcHRvciBidWxr
X2luX2VwX2Rlc2NyaXB0b3IgPSB7CgkuYkxlbmd0aCA9IFVTQl9EVF9FTkRQT0lOVF9TSVpFLAoJ
LmJEZXNjcmlwdG9yVHlwZSA9IFVTQl9EVF9FTkRQT0lOVCwKCS5iRW5kcG9pbnRBZGRyZXNzID0g
MHg4MSwKCS5ibUF0dHJpYnV0ZXMgPSBVU0JfRU5EUE9JTlRfWEZFUl9CVUxLLAoJLndNYXhQYWNr
ZXRTaXplID0gQlVMS19NQVhfVFJBTlNGRVIsCn07CnN0YXRpYyBzdHJ1Y3QgdXNiX2VuZHBvaW50
X2Rlc2NyaXB0b3IgYnVsa19vdXRfZXBfZGVzY3JpcHRvciA9IHsKCS5iTGVuZ3RoID0gVVNCX0RU
X0VORFBPSU5UX1NJWkUsCgkuYkRlc2NyaXB0b3JUeXBlID0gVVNCX0RUX0VORFBPSU5ULAoJLmJF
bmRwb2ludEFkZHJlc3MgPSAweDAyLAoJLmJtQXR0cmlidXRlcyA9IFVTQl9FTkRQT0lOVF9YRkVS
X0JVTEssCgkud01heFBhY2tldFNpemUgPSBCVUxLX01BWF9UUkFOU0ZFUiwKfTsKCi8qCiAqIEFu
c3dlciB0aGUgdHdvIGRsbjIgcmVxdWVzdHMgdGhhdCBnYXRlIHByb2JlOiB0aGUgaGFyZHdhcmUg
aWQsIGFuZCB0aGUKICogY2hpcC1zZWxlY3QgY291bnQgdGhhdCBjYXJyaWVzIHRoZSBwb2lzb25l
ZCB2YWx1ZS4gRXZlcnl0aGluZyBlbHNlIGdldHMgYQogKiB6ZXJvIHBheWxvYWQsIHdoaWNoIGV2
ZXJ5IHJlbWFpbmluZyBkbG4yIGNlbGwgdHJlYXRzIGFzIGEgYmVuaWduIGFuc3dlci4KICovCnN0
YXRpYyB2b2lkICpkbG4yX3Jlc3BvbnNlX3RocmVhZCh2b2lkICp1bnVzZWQpCnsKCV9fdTggcmVx
dWVzdF9idWZmZXJbc2l6ZW9mKHN0cnVjdCB1c2JfcmF3X2VwX2lvKSArIEJVTEtfTUFYX1RSQU5T
RkVSXTsKCV9fdTggcmVzcG9uc2VfYnVmZmVyW3NpemVvZihzdHJ1Y3QgdXNiX3Jhd19lcF9pbykg
KyBCVUxLX01BWF9UUkFOU0ZFUl07CglzdHJ1Y3QgdXNiX3Jhd19lcF9pbyAqcmVxdWVzdCA9ICh2
b2lkICopcmVxdWVzdF9idWZmZXI7CglzdHJ1Y3QgdXNiX3Jhd19lcF9pbyAqcmVzcG9uc2UgPSAo
dm9pZCAqKXJlc3BvbnNlX2J1ZmZlcjsKCWNvbnN0IHVuc2lnbmVkIHBheWxvYWRfbGVuID0gNjQ7
CgoJZm9yICg7OykgewoJCXVuc2lnbmVkIGlkLCBlY2hvLCBoYW5kbGU7CgkJX191OCAqcGF5bG9h
ZDsKCQlpbnQgbjsKCgkJcmVxdWVzdC0+ZXAgPSBidWxrX291dF9lcF9oYW5kbGU7CgkJcmVxdWVz
dC0+ZmxhZ3MgPSAwOwoJCXJlcXVlc3QtPmxlbmd0aCA9IEJVTEtfTUFYX1RSQU5TRkVSOwoJCW4g
PSBpb2N0bChyYXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX0VQX1JFQUQsIHJlcXVlc3QpOwoJ
CWlmIChuIDwgMCkgewoJCQlpZiAoZXJybm8gPT0gRUlOVFIgfHwgZXJybm8gPT0gRUJVU1kpCgkJ
CQljb250aW51ZTsKCQkJcmV0dXJuIHVudXNlZDsKCQl9CgkJaWYgKG4gPCA4KQoJCQljb250aW51
ZTsKCQlpZCAgICAgPSByZXF1ZXN0LT5kYXRhWzJdIHwgKHJlcXVlc3QtPmRhdGFbM10gPDwgOCk7
CgkJZWNobyAgID0gcmVxdWVzdC0+ZGF0YVs0XSB8IChyZXF1ZXN0LT5kYXRhWzVdIDw8IDgpOwoJ
CWhhbmRsZSA9IHJlcXVlc3QtPmRhdGFbNl0gfCAocmVxdWVzdC0+ZGF0YVs3XSA8PCA4KTsKCgkJ
bWVtc2V0KHJlc3BvbnNlX2J1ZmZlciwgMCwgc2l6ZW9mKHJlc3BvbnNlX2J1ZmZlcikpOwoJCXBh
eWxvYWQgPSByZXNwb25zZS0+ZGF0YSArIERMTjJfUkVTUE9OU0VfSEVBREVSX0xFTjsKCQlpZiAo
aGFuZGxlID09IERMTjJfSEFORExFX0NUUkwgJiYgaWQgPT0gQ01EX0dFVF9ERVZJQ0VfVkVSKQoJ
CQlwdXRfbGUzMihwYXlsb2FkLCBETE4yX0hXX0lEKTsKCQllbHNlIGlmIChoYW5kbGUgPT0gRExO
Ml9IQU5ETEVfU1BJICYmIGlkID09IFNQSV9HRVRfU1NfQ09VTlQpCgkJCXB1dF9sZTE2KHBheWxv
YWQsIEJBRF9DSElQU0VMRUNUX0NPVU5UKTsKCgkJLyogZGxuMl9yeCgpIGRyb3BzIHRoZSByZXNw
b25zZSB1bmxlc3MgaGRyLnNpemUgPT0gYWN0dWFsX2xlbmd0aC4gKi8KCQlwdXRfbGUxNihyZXNw
b25zZS0+ZGF0YSArIDAsIERMTjJfUkVTUE9OU0VfSEVBREVSX0xFTiArIHBheWxvYWRfbGVuKTsK
CQlwdXRfbGUxNihyZXNwb25zZS0+ZGF0YSArIDIsIGlkKTsKCQlwdXRfbGUxNihyZXNwb25zZS0+
ZGF0YSArIDQsIGVjaG8pOwoJCXB1dF9sZTE2KHJlc3BvbnNlLT5kYXRhICsgNiwgaGFuZGxlKTsK
CQkvKiByZXNwb25zZS0+ZGF0YSArIDggaXMgX19sZTE2IHJlc3VsdCwgYWxyZWFkeSAwID09IHN1
Y2Nlc3MgKi8KCgkJcmVzcG9uc2UtPmVwID0gYnVsa19pbl9lcF9oYW5kbGU7CgkJcmVzcG9uc2Ut
PmZsYWdzID0gMDsKCQlyZXNwb25zZS0+bGVuZ3RoID0gRExOMl9SRVNQT05TRV9IRUFERVJfTEVO
ICsgcGF5bG9hZF9sZW47CgkJaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9FUF9X
UklURSwgcmVzcG9uc2UpOwoJfQoJcmV0dXJuIHVudXNlZDsKfQoKc3RhdGljIHZvaWQgaGFuZGxl
X2VwMF9jb250cm9sKGNvbnN0IHN0cnVjdCB1c2JfY3RybHJlcXVlc3QgKmN0cmwpCnsKCV9fdTgg
YnVmZmVyW3NpemVvZihzdHJ1Y3QgdXNiX3Jhd19lcF9pbykgKyBFUDBfTUFYX1RSQU5TRkVSXTsK
CXN0cnVjdCB1c2JfcmF3X2VwX2lvICppbyA9ICh2b2lkICopYnVmZmVyOwoJaW50IGxlbiA9IC0x
OwoKCWlmICgoY3RybC0+YlJlcXVlc3RUeXBlICYgVVNCX1RZUEVfTUFTSykgPT0gVVNCX1RZUEVf
U1RBTkRBUkQpIHsKCQlzd2l0Y2ggKGN0cmwtPmJSZXF1ZXN0KSB7CgkJY2FzZSBVU0JfUkVRX0dF
VF9ERVNDUklQVE9SOgoJCQlpZiAoKGN0cmwtPndWYWx1ZSA+PiA4KSA9PSBVU0JfRFRfREVWSUNF
KSB7CgkJCQlsZW4gPSBzaXplb2YoZGV2aWNlX2Rlc2NyaXB0b3IpOwoJCQkJbWVtY3B5KGlvLT5k
YXRhLCAmZGV2aWNlX2Rlc2NyaXB0b3IsIGxlbik7CgkJCX0gZWxzZSBpZiAoKGN0cmwtPndWYWx1
ZSA+PiA4KSA9PSBVU0JfRFRfQ09ORklHKSB7CgkJCQlsZW4gPSBzaXplb2YoY29uZmlndXJhdGlv
bl9kZXNjcmlwdG9yKTsKCQkJCW1lbWNweShpby0+ZGF0YSwgY29uZmlndXJhdGlvbl9kZXNjcmlw
dG9yLCBsZW4pOwoJCQl9CgkJCWJyZWFrOwoJCWNhc2UgVVNCX1JFUV9TRVRfQ09ORklHVVJBVElP
TjogewoJCQlwdGhyZWFkX3QgcmVzcG9uc2VfdGhyZWFkOwoKCQkJaW9jdGwocmF3X2dhZGdldF9m
ZCwgVVNCX1JBV19JT0NUTF9DT05GSUdVUkUsIDApOwoJCQlidWxrX2luX2VwX2hhbmRsZSA9IGlv
Y3RsKHJhd19nYWRnZXRfZmQsCgkJCQkJCSAgVVNCX1JBV19JT0NUTF9FUF9FTkFCTEUsCgkJCQkJ
CSAgJmJ1bGtfaW5fZXBfZGVzY3JpcHRvcik7CgkJCWJ1bGtfb3V0X2VwX2hhbmRsZSA9IGlvY3Rs
KHJhd19nYWRnZXRfZmQsCgkJCQkJCSAgIFVTQl9SQVdfSU9DVExfRVBfRU5BQkxFLAoJCQkJCQkg
ICAmYnVsa19vdXRfZXBfZGVzY3JpcHRvcik7CgkJCWlmIChidWxrX2luX2VwX2hhbmRsZSA+PSAw
ICYmIGJ1bGtfb3V0X2VwX2hhbmRsZSA+PSAwICYmCgkJCSAgICAhcmVzcG9uc2VfdGhyZWFkX3N0
YXJ0ZWQpIHsKCQkJCXJlc3BvbnNlX3RocmVhZF9zdGFydGVkID0gMTsKCQkJCXB0aHJlYWRfY3Jl
YXRlKCZyZXNwb25zZV90aHJlYWQsIE5VTEwsCgkJCQkJICAgICAgIGRsbjJfcmVzcG9uc2VfdGhy
ZWFkLCBOVUxMKTsKCQkJfQoJCQlsZW4gPSAwOwoJCQlicmVhazsKCQl9CgkJfQoJfQoKCWlmIChs
ZW4gPCAwKSB7CgkJaW9jdGwocmF3X2dhZGdldF9mZCwgVVNCX1JBV19JT0NUTF9FUDBfU1RBTEws
IDApOwoJCXJldHVybjsKCX0KCWlvLT5lcCA9IDA7Cglpby0+ZmxhZ3MgPSAwOwoJaW8tPmxlbmd0
aCA9IGxlbiA8IGN0cmwtPndMZW5ndGggPyBsZW4gOiBjdHJsLT53TGVuZ3RoOwoKCS8qIHJhdy1n
YWRnZXQgbGF0Y2hlcyB0aGUgZGlyZWN0aW9uIHBlciBzZXR1cCBwYWNrZXQ6IGEgemVyby1sZW5n
dGgKCSAqIHJlcXVlc3QgaXMgYW4gT1VUIG5vIG1hdHRlciB3aGF0IGJSZXF1ZXN0VHlwZSBzYXlz
LCBhbmQgdGhlIG9wcG9zaXRlCgkgKiBpb2N0bCByZXR1cm5zIEVCVVNZLiAqLwoJaWYgKGN0cmwt
PmJSZXF1ZXN0VHlwZSAmIFVTQl9ESVJfSU4gJiYgY3RybC0+d0xlbmd0aCkKCQlpb2N0bChyYXdf
Z2FkZ2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX0VQMF9XUklURSwgaW8pOwoJZWxzZQoJCWlvY3RsKHJh
d19nYWRnZXRfZmQsIFVTQl9SQVdfSU9DVExfRVAwX1JFQUQsIGlvKTsKfQoKaW50IG1haW4odm9p
ZCkKewoJX191OCBldmVudF9idWZmZXJbc2l6ZW9mKHN0cnVjdCB1c2JfcmF3X2V2ZW50KSArIEVQ
MF9NQVhfVFJBTlNGRVJdOwoJc3RydWN0IHVzYl9yYXdfZXZlbnQgKmV2ZW50ID0gKHZvaWQgKill
dmVudF9idWZmZXI7CglzdHJ1Y3QgdXNiX3Jhd19pbml0IGluaXQ7CglzdHJ1Y3QgZGlyZW50ICp1
ZGNfZW50cnk7CglESVIgKnVkY19kaXI7CgljaGFyICp1ZGNfaW5kZXg7CgoJLyogZHVtbXlfaGNk
IG51bWJlcnMgaXRzIFVEQ3MsIHNvIHRoZSBuYW1lIG11c3QgYmUgZGlzY292ZXJlZDoKCSAqIGRl
dmljZSAiZHVtbXlfdWRjLjIiIGJlbG9uZ3MgdG8gZHJpdmVyICJkdW1teV91ZGMiLiAqLwoJdWRj
X2RpciA9IG9wZW5kaXIoIi9zeXMvY2xhc3MvdWRjIik7Cgl3aGlsZSAodWRjX2RpciAmJiAodWRj
X2VudHJ5ID0gcmVhZGRpcih1ZGNfZGlyKSkgJiYgdWRjX2VudHJ5LT5kX25hbWVbMF0gPT0gJy4n
KQoJCTsKCWlmICghdWRjX2RpciB8fCAhdWRjX2VudHJ5KSB7CgkJZnByaW50ZihzdGRlcnIsICJu
byBVREMgaW4gL3N5cy9jbGFzcy91ZGNcbiIpOwoJCXJldHVybiAxOwoJfQoJbWVtc2V0KCZpbml0
LCAwLCBzaXplb2YoaW5pdCkpOwoJc25wcmludGYoKGNoYXIgKilpbml0LmRldmljZV9uYW1lLCBV
RENfTkFNRV9MRU5HVEhfTUFYLCAiJXMiLCB1ZGNfZW50cnktPmRfbmFtZSk7CglzbnByaW50Zigo
Y2hhciAqKWluaXQuZHJpdmVyX25hbWUsIFVEQ19OQU1FX0xFTkdUSF9NQVgsICIlcyIsIHVkY19l
bnRyeS0+ZF9uYW1lKTsKCWNsb3NlZGlyKHVkY19kaXIpOwoJdWRjX2luZGV4ID0gc3RycmNocigo
Y2hhciAqKWluaXQuZHJpdmVyX25hbWUsICcuJyk7CglpZiAodWRjX2luZGV4KQoJCSp1ZGNfaW5k
ZXggPSAwOwoJaW5pdC5zcGVlZCA9IFVTQl9TUEVFRF9ISUdIOwoKCXJhd19nYWRnZXRfZmQgPSBv
cGVuKCIvZGV2L3Jhdy1nYWRnZXQiLCBPX1JEV1IpOwoJaWYgKHJhd19nYWRnZXRfZmQgPCAwKSB7
CgkJcGVycm9yKCIvZGV2L3Jhdy1nYWRnZXQiKTsKCQlyZXR1cm4gMTsKCX0KCWlmIChpb2N0bChy
YXdfZ2FkZ2V0X2ZkLCBVU0JfUkFXX0lPQ1RMX0lOSVQsICZpbml0KSA8IDApIHsKCQlwZXJyb3Io
IlVTQl9SQVdfSU9DVExfSU5JVCIpOwoJCXJldHVybiAxOwoJfQoJLyogUlVOIG11c3QgcHJlY2Vk
ZSBFVkVOVF9GRVRDSDogdGhlIGRldmljZSBoYXMgdG8gYmUgaW4KCSAqIFNUQVRFX0RFVl9SVU5O
SU5HIG9yIHRoZSBmZXRjaCByZXR1cm5zIC1FSU5WQUwuICovCglpZiAoaW9jdGwocmF3X2dhZGdl
dF9mZCwgVVNCX1JBV19JT0NUTF9SVU4sIDApIDwgMCkgewoJCXBlcnJvcigiVVNCX1JBV19JT0NU
TF9SVU4iKTsKCQlyZXR1cm4gMTsKCX0KCglmb3IgKDs7KSB7CgkJZXZlbnQtPnR5cGUgPSAwOwoJ
CWV2ZW50LT5sZW5ndGggPSBFUDBfTUFYX1RSQU5TRkVSOwoJCWlmIChpb2N0bChyYXdfZ2FkZ2V0
X2ZkLCBVU0JfUkFXX0lPQ1RMX0VWRU5UX0ZFVENILCBldmVudCkgPCAwKSB7CgkJCWlmIChlcnJu
byA9PSBFSU5UUikKCQkJCWNvbnRpbnVlOwoJCQlwZXJyb3IoIlVTQl9SQVdfSU9DVExfRVZFTlRf
RkVUQ0giKTsKCQkJcmV0dXJuIDE7CgkJfQoJCWlmIChldmVudC0+dHlwZSA9PSBVU0JfUkFXX0VW
RU5UX0NPTlRST0wpCgkJCWhhbmRsZV9lcDBfY29udHJvbCgoc3RydWN0IHVzYl9jdHJscmVxdWVz
dCAqKWV2ZW50LT5kYXRhKTsKCX0KCXJldHVybiAwOwp9Cg==
--0000000000001c9b8e065b161ee1--
