Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803113;
	b=Jm5tqqp0zjQG9BuFRCv6v/sI/dRdBes7umJ4swyqyY3yFsuN8wSlWD3+inf79BWlYqJT
	 UzfARxhd9yqVQ5lNx8HLihahFfxeIBvaFBE+K66vrcmn7mSUt5LfS3nTKik4MJoeeIFyH
	 eaOFL0iZUpH3rlg5gCe0XspWK9Yk1fplfZU2Gkpum6zsf+vFChYwDAYQK/NaTxtVY1+bW
	 wOrJWArO5185OCkYdoL8isxm4ACa5TmjHOMlfKsEpmEsMQu8ogFznMu+sF05QGJH2Mq36
	 UmuMNFu4nlPSKWkC6RHvpCjUCurtzTTxUpYD8D/z6nfWPrXNG4D+zC+o44hDPIXwJMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
	b=q/oEKunXTWWRTeTi68l60PghAyKi0EONkIe2rB0NzlLZpXyJIBqUk9QHdTNFZg8rFRZc
	 NZKGr8ydLRB7uStNz+4mHkwOYM4VOXl5wYjUmKpe9AzxlPQZ/VEA2L2S3w0aS3CSOiNWy
	 dUkqlUuGsY0pu/G2bMKYgsPl/T9zVyP6lQInxLzWIgi0bD535ck8GVWbI4oTgcaJzMHND
	 n8LTIsRsIWUyjW7VpX9X+LNwx7ROhVAI9qsHgrS4k2GhMi7WG3/YsNFRmqfBXflNarp2B
	 BadXAI4tS66RfNmnZRGCjrMpRa4SymVAVljsmt3HtgbvbOzLd9WE59SDxpfPx9yW70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WCEhii4W;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06E606A31A
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A06E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WCEhii4W
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so710295a91.3
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803112; x=1793407912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
        b=WCEhii4W5Td/KXJQwYmHo7GyYGOFEKae+BofkfkaGczeRzWgCLgXnThRM6R+YSf5VU
         ZHDsa2q3zYSS9FTAyxq4O9Io5IichFvsQ6BKQd/jnrMQnFq9JWG4sfsyc5aqL7QN3guZ
         pU3YWdXKnZygCAuMdAwlwbUqUOu8hMSg/d9CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803112; x=1793407912;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PqPEXwYn+4RHFltKHPK65Z0DEkdjhotFWC8JsbNnjM=;
        b=vdnaRGZqOrQ45IpZWfLuoIacpX11Lp/l/NWZlj6GHg9MqLnDfFDWXmv12uNybPhTt0
         JNWDi+yw5R63ThLVh8w3DzoYo6z5hChAz651JcX5rCWCgBKC89aUrmw/RQy3MMI5z1wT
         w4lZFoun2XsrkDJRYZOjtNWzcaqNf7Ru9yJN5nlyux74s6jrbWcmMifetQ1NCI27PRbZ
         G2lrBAM3Gfr0y1FlAQUbfL+xYg4Rgkhubrl7GUxDpwEDtPZ3tXNrbtwEdaxTs6akJP3u
         5+Dm8J5FsfYRevcurXfWwV8qaHzD7dlFAiwNVJDR9s1PYT5QQu1RVUyDHx2N6nhRW4at
         wFAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1hux9sESAFMiVMy2r7j5o/G8NV57vzZW/3NnGYlcNI/MnKUHPuQxB2uK/FVlztkDG5VDTFXlnK60=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsmbLFTfNGWHrhwxc0oBz98uTXQG+Kx63DuJQvRoyM7gIbawc3
	qDSjmpO+DdoTrTzHZ6fLvn6RBgdTZl7OdLHCvr1k4PHzlu5REZk/HUBt6VOXOqpo3Q==
X-Gm-Gg: AYBFou3ZHhrgtuVQJ1ATt9i8MkEz+f1TsjcDecGbxz35Jkmy7BX88vYIHtQT9qkpXyE
	HCEvDdGVidGZPts5iQb3cebyeqb1baIU2cyY1ybdDtnNAFfza72ZDn3yexiEm3vGUjOcHkzZkiU
	SJ/n5lsDx/BKr5aiSl3tLEixaQmARiSwRci/63vv1gczhuuLb4J2b+0A8fHh5WYfp9EXKivWVQP
	FUsuJmUxsSPTeeYY9B0HJs9Hswg3YhBJ70LxdntNstVBAeoyeugfm2VZ8sJkmZeBfJRfj8YCHUF
	qLZQhpJ7JheONHawBBRO8a1O4CvOWog0NjAx5K0cxz1hTVJexljIUwcOa4eupS4iPwFY33LflP1
	Z0XJ7WJhtJSqJM+PDHzvlD7JLm79fmYGUiH3/4TeLBjwAToNOb7nUudm5lH7RwJJxAAtnwXhTs/
	7gYzB3QSdYirZRoq1OcYok2Qt39R7DobdwuvjnXu8PcFopvMOq2a/1LpCXPh9KGot99Q3rjTln8
	JgW2c9zNgvcQeVJ6VEpSJeIu4czPGzI1e+ErkRr+92XUjvITjWTy99fgL3buSvDIlWcXO1LSMBh
	Vf9wOHT0j7TryvVi6QaW/AVtWCmRwZHNZboOC/pHBqaOMEFDPt2aG7q0Y176ZTI=
X-Received: by 2002:a17:90b:1a85:b0:3ac:7c4d:8be6 with SMTP id 98e67ed59e1d1-3adead4f66amr712837a91.40.1792803111828;
        Fri, 23 Oct 2026 17:51:51 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:51 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v7 00/11] Add spi-hid transport driver
Date: Sat, 24 Oct 2026 00:51:34 +0000
Message-Id: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABcB3GoC/23PwW7DIAyA4VepOI8JYyCkp73HtAMB03BIUkEbt
 ary7qOdtFZpjr9lf5JvrFBOVNh+d2OZ5lTSNNZoPnbM9248EE+hNpNCGiFB8kJj4OdjOWVyA29
 0NDG0FFpJrN4cM8V0eXjfP7X7VE5Tvj74Ge7TPwkFrqQZuOCgQXdOgo0YvnyfpyGdh88pH9gdm
 +ULINUakBXQEjxZF2O0ZgPAJ6DE+pcZK2BEC15pG1A3G4B6AnVzDagKdFZh0GQ8BdwA9D8A4h3
 QFUCrXBQQHBJtAOYFgDfAVMB3bedUh8FEtwKWZfkFlglPH/IBAAA=
X-Change-ID: 20260212-send-upstream-75f6fd9ed92e
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7277;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=nNYO6idEpLauPqDXQvv90+SC/2ZK0xY5I65cLCsgDHY=;
 b=p5RQ4OcghzWSWrRKttkp/rtck0c6aXEYG3MzjxpNtHszzhiB27lNZRqYb7PduCFSWkS6eaJPk
 WBkVelYEZ2RC7aa/7ItikRTwMfMDpu8adtKg0sVxaLB4oFFVcDaGT7c
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

This series picks up the spi-hid driver work originally started by
Microsoft. The patch breakdown has been modified and the implementation
has been refactored to address upstream feedback and testing issues. We
are submitting this as a new series while keeping the original sign-off
chain to reflect the history.

Same as the original series, there is a change to HID documentation, some
HID core changes to support a SPI device, the SPI HID transport driver,
and HID over SPI Device Tree binding. We have added the HID over SPI ACPI
support, power management, panel follower, and quirks for Ilitek touch
controllers.

Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
		  Dmitry Antipov <dmanti@microsoft.com>
Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gmail.com

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
Changes in v7:
- Drop the error counter sysfs attributes.
- Print error codes in power up/down failure messages.
- Reject an empty report descriptor.
- Check the minimum input report body size instead of max_input_length.
- Clear reset_attempts only after the report descriptor check succeeds.
- Drop pending work flags when the error handler resets the device.
- Don't schedule a reset when GET_FEATURE fails with -ENODEV.
- dt-bindings: drop the address/opcode properties and the "hid-over-spi"
  fallback; the compatible determines them.
- dt-bindings: fix authorship to match the Signed-off-by chain.
- dt-bindings: update maintainer email addresses.
- dt-bindings: drop Rob's Reviewed-by because the binding changed.
- of: use per-compatible match data; match only
  "microsoft,g6-touch-digitizer".
- pm: disable reset_work across suspend.
- pm: check deassert_reset(); schedule recovery on reset timeout.
- pm: skip hid_driver_reset_resume() when the device is not ready.
- pm: log power_down() failure instead of rolling back suspend.
- pm: use dev_err() instead of dev_WARN_ONCE() for a failed device
  descriptor request.
- panel follower: start with reset_work disabled.
- Drop Dale's Tested-by from the OF, PM and panel follower patches
  because they changed since v4.
- Link to v6: https://lore.kernel.org/r/20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org

Changes in v6:
- Take output_lock while reallocating buffers in ll_start()
- Don't drop input reports while a refreshed device probes
- OF: drop mod_devicetable.h, use named initializers, fix alignment
- Move the dt-bindings patch before the OF driver patch
- Drop Tested-by from the documentation and DT binding patches
- Link to v5: https://lore.kernel.org/r/20261009-send-upstream-v5-0-384af01da3ee@chromium.org

Changes in v5:
- Fix request/response races; match GET_FEATURE responses by report ID
- Reset the device on response timeout; wait uninterruptibly
- Validate device descriptor and report lengths; fix buffer sizing
- Honor rtype in raw_request(); fix GET_REPORT off-by-one
- Use hid_safe_input_report(); forward input reports only while open
- Disable IRQ around hid_device teardown; fix a sparse warning
- Use disable_work_sync() for reset_work in remove()
- Cap trace copies at 64 bytes; cacheline-align read approval buffers
- ACPI: select RESET_CONTROLLER, use device_reset_optional()
- OF & DT: read opcodes as u8, use dev_err_probe(), require reg
- PM: cancel reset_work on suspend, wait for reset before
  reset_resume(), fix IRQ imbalance on resume failure
- Panel follower: fix regulator/IRQ imbalance; depend on DRM || !DRM
- Link to v4: https://lore.kernel.org/r/20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org

Changes in v4:
- Extended io_lock scope to protect the shid->hid pointer lifecycle
  against races with the IRQ handler
- Cacheline-aligned DMA buffers, enforced 4-byte alignment
- Added error rollback for failed suspend/resume transitions
- Moved IRQ request to probe with IRQF_NO_AUTOEN (disabled by default)
- DT Bindings & OF Driver:
  - Required a device-specific compatible string in the schema.
  - Added description to explain why opcodes and addresses properties
    need to be defined in the schema
  - Added `spi-peripheral-props.yaml` reference and switched to
    `unevaluatedProperties: false`.
  - Added fallback to default timing parameters in OF driver if match
    data is missing.
- Link to v3: https://lore.kernel.org/r/20260402-send-upstream-v3-0-6091c458d357@chromium.org

Changes in v3:
- Add io_lock init
- Relocate tracepoints to drivers/hid/spi-hid/ and fix tracepoint macros
- Add tracepoints for sync, error handling, reset, and report processing
- Clean up internal includes and fix Makefile CFLAGS
- Add more details in v2 changelog
- Link to v2: https://lore.kernel.org/r/20260324-send-upstream-v2-0-521ce8afff86@chromium.org

Changes in v2:
- Clean up DT bindings: fix formatting and remove timing and flags properties
- Update DT binding example: use a device-specific compatible and drop
  reset_assert
- Simplify ACPI/OF match tables by removing ACPI_PTR/of_match_ptr
- Refactor OF driver to use match data for timing parameters instead
  of DT properties
- Switch to fsleep() for delays in ACPI and OF drivers
- Drop patch 12 as it is vendor specific
- Add a lock to fix input/output concurrency race
- Link to v1: https://lore.kernel.org/r/20260303-send-upstream-v1-0-1515ba218f3d@chromium.org

---
Angela Czubak (2):
      HID: spi-hid: add transport driver skeleton for HID over SPI bus
      HID: spi-hid: add ACPI support for HID over SPI

Dmitry Antipov (1):
      dt-bindings: input: Document hid-over-spi DT schema

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi-hid: add device tree support for HID over SPI

Jingyuan Liang (5):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi-hid: add spi_hid traces
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |   75 +
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   50 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  261 +++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1698 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |  112 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  211 +++
 drivers/hid/spi-hid/spi-hid-trace.h                |  184 +++
 drivers/hid/spi-hid/spi-hid.h                      |   45 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2659 insertions(+), 2 deletions(-)
---
base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

