Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D43CB2C7
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584801; cv=none; b=jN2GSphUcGYCEf/0tWLR0O6l2hFiS4l4q6nSZygNmxLkn4gZWjvEGHhqf9JD3Tw1BGqwe5KNreEyYpqD2axwKnvu2wlCSyl6CjgeV8A2i428kbJsjN+/OmL4RDNio8dnwhl3CigC3JdVXcZO7WYxZUBVToIbmp+wYba1ub1YeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584801; c=relaxed/simple;
	bh=Nj1qlIpON3VaMJM8UbfjiD8khDpWPWvFN1Ci3Mk1V50=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AMviCZqVeHyzoo/YceevwsQRl/eEw5JzqUuGX2O11OiOddiIo1NwvQ2zbvGMOjZh2bM4sqo9vLEzeXjSMQnJ/fpxLMT2DqUXu162aDD0NGhcBpfe9cotaVfgk3W7Sqh7C+E/ruSJ1sNFmszSrtpflb1fj9MuU76o6qSWvpJkcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LAyaa34E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LAyaa34E"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e61ac64ec3so1681775ad.2
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584798; x=1792189598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FUz1DD2WLXF8FMCF65KzWxeNZSEe/yJbWO0PR68AnX4=;
        b=LAyaa34EJdvWYlMTFjxZMKlgEtHOeBEsJfmGT7npnHodGoSWTmK/XYZVa7CXL+qIs3
         DlogidZogBIdrAR9Q8ofeigrh0zJLaT3IBGSouQcLLrm+stEKfNb6cQTWD8naTe5O9LD
         mF/unoJvj/AU1mRHJZnvhpMc03BQWOSeX4iX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584798; x=1792189598;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FUz1DD2WLXF8FMCF65KzWxeNZSEe/yJbWO0PR68AnX4=;
        b=bmE3/X/4wvYgo++rmwsbfue6cqesm/apqc5uzrtfi1kFoVi39EuBoNpAGIWMciuZIa
         3HLSVvbW1bzkwSO+XiwjzCflQ3GgrtPDKDRFTHiJxy1Im78YrOhS9YjuLrEMbCrPqL6u
         +Mk78iOCawWOU/7MTggVeo3IbnqVwkUSLVTHRDH8DhfkFffR/IpwY8Eq4sAxdKcZ8jBd
         BjTHW1f3wZBaY5BYhCXj1J8m6y+aYAw1Cgruwq1u2S1VyndKM+QgIBYT0gdZ/f32PpXr
         iRqSN4+Zw/Eb9bvprA4syLoA4MHV15v2/7+aHCzdaelnS4Jsc2Mjkmj7rkRKPklpZ5K3
         5e5w==
X-Forwarded-Encrypted: i=1; AKwUvByxwSxhm+W2hZFKf/MgMRaOg4W8KPZszWJ38nXHsHOFjdT9yJzMWaF7WhEiFcENjfkSEfb2/PHRCfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhx/A9jcqTIxt5YYXZoQKT48W0lAC4v5+ECRIKK6rcRnRLBM9S
	KrrY15N+l8pwfxl9Oazu6JbHJCf/+MzddNwZ2IyPzBKuw2vCB4emMiVdcMmIUljTKI+bYFttXV2
	QDm2rug==
X-Gm-Gg: AYBFou3o1+BV53i/dpIir1ZmcQzgedNuRY6n1XYlkjYpdJzRIofdIAICKBwDEmUitY5
	o/dgcbkjEe9tbyzcnR7azr0vDSARrwjYRqH2c3QODxOIq8YA+9H20sZjYpUUBLvkkLNX7Lspbor
	Bf/XyH5WbIvcL1MUOKg0aiidFE9mpSzf9w7mQxdgSYATQn1xMXr9kb3MyFhEZWN7qvmoyH8tmiT
	Mbd5BboAtLe9b0vanqTw8XU3jqGhvXa+sk+k767+XrA4F4SP5xUzylT030CbDZ32AHlgAVYdZWG
	rnUjwck0sSDl6c+DsYZfFx7vw8SVdHy51PYEu65w/aTM2TNdpktC5Pzfj6Nzbgt4LhvYBOuVNPF
	PnDi66XTqSM1Vo3mcJgJ+kxlh8Q3CvpHiIrAIJVpKhxO9qLqsZTY622/eKaH6suYou3xjxebCpo
	HgdoI8/FQHtuTF/JVZizAykAJ7vhia1WwqYoLo2GigZC8L0mtAkF4TZnkhcaZxTTcy7xSFto+ZU
	b2myel4ErqhNhGUeLWuGq1HQ6iZHv3b2GVVvI8CwnojiaQZ58nOmptLvI9AIu+0i1dEa3wQ6nuD
X-Received: by 2002:a17:903:22d2:b0:2e2:c283:354f with SMTP id d9443c01a7336-2e842abfe53mr30774615ad.28.1791584798347;
        Fri, 09 Oct 2026 15:26:38 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:37 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v5 00/11] Add spi-hid transport driver
Date: Fri, 09 Oct 2026 22:25:25 +0000
Message-Id: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZpyWoC/23PSw7CIBCA4asY1mJgeEhdeQ/josJgWfQRUKIxv
 buoixrS5T+Z+ZJ5kYQxYCKHzYtEzCGFcSihthtiu3a4Ig2uNAEGmgEHmnBw9D6lW8S2p3vltXc
 NugaQlJspog+Pr3c6l+5Cuo3x+eUz/0x/kmCikjKnjHLF1aUFbrxwR9vFsQ/3fjfGK/lgGf4Ak
 DUABVDALZrWe2/0CiAWQLL6lywKoFnDrVTGCbVfAeQClM0akAW4GCmcQm3RiQqY5/kNc2Ls0nA
 BAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=5428;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Nj1qlIpON3VaMJM8UbfjiD8khDpWPWvFN1Ci3Mk1V50=;
 b=etJd3b3UVqagUxqvjiTG6zOPQhMZq5oZ2SbYUYzjkoeHHWcPQb1WlCN+9PEKh/Wi8HCO2T+1x
 O6h+agGpXM0BUSCGRCXk1lARzHY3remF5IYc9vlS0ExrdTDgSttfctW
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

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi-hid: add device tree support for HID over SPI

Jingyuan Liang (6):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi-hid: add spi_hid traces
      dt-bindings: input: Document hid-over-spi DT schema
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |  130 ++
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   50 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  262 +++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1754 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |  118 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  243 +++
 drivers/hid/spi-hid/spi-hid-trace.h                |  184 ++
 drivers/hid/spi-hid/spi-hid.h                      |   46 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2810 insertions(+), 2 deletions(-)
---
base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

