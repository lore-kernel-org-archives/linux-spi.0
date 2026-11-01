Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550750;
	b=LK4e/6c+0WNZPBnMjnoNTEgVc0n6/cA/n2xelAFTLGm5/t0nJJQZnR8Qct88XRYqQsKl
	 n4kc8rj/qet/ilsQiVxYNwAyiBmT7rRyvLQNyR4KbHIcZN6n0VbRtLJfRFjKqFs24dpp9
	 mdstndoSUt61jEBjv34LFHDplsyAhz7sc6bwWXivkTpqazWTit32D/reMIk88K4IMJ9ij
	 gIEvxPS8MONg+zxOURs28WjnAYNe7N2d3x9ITRe2jQ6Nh9KzlR9BqgRCvw9r7SUHj+E3D
	 wHi18DpBzv/1im17U1zJSMAncQ1/DRh0r7xy90OZbQDBFWkK4KolIDPAfSy7dNIuFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pWzxgbjKNpMXGkW9+BnmkVuFK1d9dvUrcDp7sCmIJDE=;
	b=5eqajwi895LgzbUFL1/ZnmhFPb9axCGaESqWLEB6bQi0872ohe8eiv7T61Y9ZVTKH07J
	 usT0OrzfExxwpUoS0bIw4aSVdVy+ib8SF2i6R4T6ALSS3EhJ9ei43g8q2FbxIPaDqmNIw
	 IJm/a2gHVl/J/l/8nm24k1L00WzHZmqgW3bQJ24RDvOpD03DnfRRGHgI9FcGNbgACaTxh
	 zDwqIuw9gIyV6+DaNKNQKKKdBYCVSmYJ7+QRQ3DsR90MfnvP85Cu0VLw5ZQkRSjhOODGm
	 I0bj0G5U8dJT99hx/gip0UODaAUfNVV/0uLXbzMtx/oiazL6QusQ9BlugzNw0Ape1NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9wY3Amn;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A7606A325
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 16:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887A7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9wY3Amn
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4af520023fdso4042795e9.1
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550748; x=1794155548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pWzxgbjKNpMXGkW9+BnmkVuFK1d9dvUrcDp7sCmIJDE=;
        b=b9wY3AmndmZIq6zJqGeZrN11osTzAGmJxvb3jZM/eg+mGoAMjhz68p8uKkzEybUVx8
         2KnAdKQj7huowj0xK939jnQzFsJoh6d72bAfwikMJy1J910DfRS9HkcoevwfkegI8y/b
         2QRardbLYI0VEfXAQc/7EhhozA0JuUHRCR5tZmjfj/WsrwHZCulwq98vLmfC9ot3xSNm
         GEilI+GCTKe87/M32YC80EymLXzFoYjqUBMQX1QgBd4Fz9x8+ulESWGOrOsfCo0i8g4j
         qBHaXzNLnCh+iy/flodlbxC6WVVcbjuzGGEulnAISfYd5LSVu8vh1E0TcYhzkA1KnGfy
         xvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550748; x=1794155548;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pWzxgbjKNpMXGkW9+BnmkVuFK1d9dvUrcDp7sCmIJDE=;
        b=2sdwFb8j6PTDCVVokePzJ2ZzqjUfVqpRtqrZ5pKBBMnl1p5ftvSL/lZ+p6M7JkIr4B
         Guhi7zCZ6xqe1bO0aTaOPhdpCuV/VPbMptZIe9ZyWqhE0gVKq8nJmdQwkO9Ox+ybVEo8
         BXIIUan7Bv2gCwqX6gw2x+GdXFOv3vH+/ayIyu/F9Cc7WZAcfb28vcJFYGEbXL1KU/vR
         /PL6pEstRwScCxTVKaOxEcsurKkoGxfGDw+NiEmcgZdrN0rtJUw7QzrZBMCzl+Db/mJU
         N9nUn2b2+lgpfxVl1IL+NMATzlCJDtk4HN4dSO4Vx+9dR9fxiZ/CfKi5uecaRr8Os2gB
         20vw==
X-Forwarded-Encrypted: i=1; AKwUvBwhqy+vo87vj7/RkXPP65t1u6GNZDSCTmBRFhae6LL17D5lH+/sMyYWoexzF2VtSb09ZKDUiVUcWos=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkJRGfrtxb/mkfycOr5qj8S1ouCzUo5VfGr68iYu8QTachufH6
	he7gk+mqiZ5zNOLPLXcwgNyVcHNNG9PZz8wL1rJf7CcXKH/xxnLl9y57
X-Gm-Gg: AYBFou0zKa0HXvVBCeXQfEQkxCn+t4ULkvPpoVUMsZT+gCxEZBu4sVlLoCvlN2G4BYj
	dCzAJZ2AY6hEvDHvjP+wViRLuqDLWGnnOOablwfokgnA1iHjINZ94LHwxoSYbT+51GagxCYoZe1
	5RxDY9SHqUR1hF2SGMgy6aHyODNPyvCslyJCBbewWGsVp9EQjHTWDgO5ZyJu1P9QMARycEoK2wp
	ChkhAA6qooHH++v42pLKu6SpKEPvua8mi0SOF2FiWucjY2b+VdFVSuaefyrnrdq3orZpe9Mmc2d
	sKmTQ/ZFUAdFsW9anfuBSw1JL76tQU7IPWoGzTpUghUc77SbPrFwWdRlIvJHu4TU4d0jRvKEASy
	0TlvS2q/nnZBLnTJCIIynHMXsNSFCzr4Tnb01jqrubLtS4SNw8QyJ2MS15ypQAFcn+e3VmUT8BN
	2pHZRW95oNHB7vSSUXFdE42Bwdw3NuCTllOjfQ/r42A+VQcGLoQO8hG6pnyQYLEnbKG1Y/YC5Pw
	+9Fl5yd+OPRdp98CgG5CIzmNsbzoHT/OrNgDjOeSrP9uN4o+cZ7lC17P4EVQt7IM0W13vFzepOe
	2sBNoSB15OFMjrgkkTB3lgHeuUeC7qqjACh46KhHKQy5Lfnd5w==
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr152290595e9.0.1793550747757;
        Sun, 01 Nov 2026 08:32:27 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:27 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Itai Handler <itai.handler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org
Subject: [PATCH 5.10.y v2 0/4] spi: spi-zynqmp-gqspi: fix runtime PM, then stop on shutdown
Date: Sun,  1 Nov 2026 18:31:50 +0200
Message-Id: <20261101163154.2274099-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the 5.10.y backport of e922bad8b2d5 ("spi:
spi-zynqmp-gqspi: stop the controller on shutdown"). v1 was dropped
[1]: on 5.10.y its pm_runtime_get_if_in_use() check always returns 0,
so ->shutdown never stops the controller. Rather than give 5.10.y
runtime PM and MMIO logic of its own, v2 first brings the driver's
runtime PM in line with upstream (1-3/4), then applies e922bad8b2d5
as-is (4/4, unchanged from v1).

Why it always returns 0 on 5.10.y
---------------------------------
5.10.y has none of 1-3/4. Its probe() calls
pm_runtime_put_autosuspend() without a matching get, so the usage
count rests at -1. The controller runtime suspends 3s after probe, and
a flash access never resumes it: without auto_runtime_pm, spi-mem
takes no runtime PM reference around an op.

Until 5.10.37 the clocks stayed on regardless, as
zynqmp_qspi_setup_op() enabled them a second time. 24159580abcc, the
5.10.37 backport of c6bdae08012b ("spi: spi-zynqmp-gqspi: fix
clk_enable/disable imbalance issue"), removed that because "pm_runtime
works now"; upstream it was applied directly on top of 1/4, but 5.10.y
took it without 1/4. Since then only probe() and the runtime resume
callback enable the clocks, so flash accesses made more than 3s after
probe run on a controller whose clocks Linux has disabled.

At shutdown, device_shutdown()'s pm_runtime_get_noresume() lifts the
count from -1 to 0, and pm_runtime_get_if_in_use() returns 0 whether
the controller is active or not.

Why 5.10.y lacks the fixes
--------------------------
5.10.198 carried 1/4 and 2/4, line for line as they are here: 2/4 as
19f3d5d13b75, and 1/4 as its Stable-dep-of, 2cdec9c13f81. But
2cdec9c13f81 bears the upstream ID and message of a21fbc42807b, an
earlier commit with the same subject: a one-line change to the probe
error path, dropped in favour of 1/4 when the two branches were merged
for v5.13. Marek reported that 2cdec9c13f81 looked very different from
a21fbc42807b and that it broke a platform for him [2], and 5.10.199
reverted both (1ceaf0d3a883, 649237ccf440). The difference he saw
comes from the label: 2cdec9c13f81's code is that of 58eaa7b2d07d.
What broke was not reported.

Marek, do you remember which platform it was and how it failed? If it
is still around, could you give this series a try?

I could not make this series, or 5.10.198, fail in emulation. Besides
the testing below, I ran both on a full ZynqMP system in QEMU: the PMU
firmware, TF-A and U-Boot of PetaLinux 2021.1 and 2024.2, the QSPI node
with and without its power domain, and a local QEMU change that stalls
the GQSPI while the firmware gates QSPI_REF. Flash reads and writes
across runtime suspend, and unbind and bind, worked with both, and
neither touched the controller while its clock was gated, 4/4's
->shutdown included. v5.10.272 without this series, by contrast, hangs
on its first flash access made more than 3s after probe.

The series
----------
1/4 58eaa7b2d07d makes probe take the reference it drops, and sets
    auto_runtime_pm so that spi-mem resumes the controller around
    every op
2/4 1527b076ae2c makes sure the controller is not runtime suspended
    when the probe error path and remove() disable its clocks by hand
3/4 2219576883e7 undoes autosuspend at driver exit
4/4 e922bad8b2d5 the v1 backport, unchanged

1-3/4 are in 5.15.y and 6.1.y, with no reverts there: 58eaa7b2d07d
since v5.13, 1527b076ae2c since 5.15.135 and 6.1.57, and 2219576883e7
since 5.15.174 and 6.1.120. With them, the runtime PM, clock and
controller (un)registration calls in probe(), remove() and the runtime
PM callbacks are the same as in v7.3, in the same order, bar a
pm_runtime_mark_last_busy() that v7.3's pm_runtime_put_autosuspend()
now makes itself.

Testing
-------
Tested in QEMU only, not on hardware: Xilinx QEMU (xilinx_v2024.2) and
its ZynqMP GQSPI model with an n25q512a11, running v5.10.272 with v1
alone against v5.10.272 with this series.

                                        v1 alone     v2
  usage count after probe                  -1         0
  usage count after unbind and bind        -1         0
  runtime status after a flash read     suspended   active
  GQSPI_EN after "halt -f"                 0x1       0x0

The last row is what e922bad8b2d5 is for: with v1 alone ->shutdown
returns early and leaves the controller enabled. The halt follows a
flash read, with the autosuspend delay raised so that the controller is
still active when ->shutdown runs; GQSPI_EN is then read through the
QEMU monitor. The usage count is read from sysfs, which needs
CONFIG_PM_ADVANCED_DEBUG. v7.3 passes the two checks that do not need
the usage count.

Caveats
-------
- The QEMU GQSPI has fixed clocks and no power domain here, so runtime
  suspend gates nothing: this shows that runtime PM is balanced and
  that ->shutdown now acts. The full-system runs above add the PMU
  firmware and a modelled clock gate, but a model is not silicon: if
  what broke in 5.10.198 depends on the hardware or on that platform's
  firmware, none of this would catch it, hence the question to Marek.

- spi_controller_suspend() in ->shutdown is a no-op on 5.10.y, as the
  controller is not queued. Upstream it also takes the bus lock, and so
  waits for an in-flight spi-mem op; that came with bef4a48f4ef7 ("spi:
  Fix null dereference on suspend", v6.7), which is in 6.1.y but not in
  5.15.y or 5.10.y. 5.10.y's own zynqmp_qspi_suspend() has the same
  gap, so I have left that core change out of this series.

Changes in v2:
- add 1-3/4, so that 4/4 works on 5.10.y as-is
- 4/4 is unchanged

v1: https://lore.kernel.org/stable/20260922140318.668429-1-itai.handler@gmail.com/

[1] https://lore.kernel.org/stable/2026-09-24-daily-reply-0010-re-spi-zynqmp-gqspi-shutdown-5-10-drop@kernel.org/
[2] https://lore.kernel.org/stable/9afe9285-6f46-46d9-bd21-2ea5c4dc43c0@denx.de/

Dinghao Liu (1):
  spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe

Itai Handler (1):
  spi: spi-zynqmp-gqspi: stop the controller on shutdown

Jinjie Ruan (1):
  spi: zynqmp-gqspi: Undo runtime PM changes at driver exit time​

Johan Hovold (1):
  spi: zynqmp-gqspi: fix clock imbalance on probe failure

 drivers/spi/spi-zynqmp-gqspi.c | 60 +++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)


base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
-- 
2.34.1

