Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637230;
	b=YBpkxQeqxVShx/x3XHFJoVUUwH8CJD6HJINZpjmCLdqs/yEdIz/tqYOpPHuM/d6mYyre
	 sqfGUGtMDiazuirmmA7KY25P5sEVtypDoKrr/X8tK+QNhA9IyYyYHOvm05PDtZYqorv0M
	 CYUK8Ae9gqREVx+VZWRg9f8jNfeUkoDuDmWgNo5xht0i83NksxQP9V+9PmsPiRAs74zkU
	 Q9A1maWdYX9jKf5oyghHrpDEKKVj/z62+zrAwb4V2wt2RgCDVGf5yzR+9hVT/Imfew3+c
	 D9Di9FWmHzjEXuWo5JZ5hCrqTxWvuFh22IOP1XTLyIbDpKnsztkygB/GoHpyvHerUPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ytwymmuk/+/FWQeKubl2n1EQYHNLGEexxBc9kzacS5Y=;
	b=A6iqM4ckD7vkD1OklIakpIRTZ45+qZP26OG79cJC6WrDpux2gPfbbgfUsuCSGdYmZxs5
	 bBBtIdGWC5s0/jXIvTHHAYlOphbWbXdoSW3k3L0+Pm8/or1VLMnHsD3YQPDTkHbtlhjY+
	 +3HrjHlFW6VSBYgC1b1OYGaI/vBl1jzu1CQIH8wcywBkM+qygTU16r6dx8lq7xGLUPFup
	 Vc4nryge0SdU0lWqCi7yH+cUWTjLLUtcKC0lXSmEBz1ACCRAqVetPn6KW5zIcsybYV1kx
	 EjZZV1eRwOa+r1er6/NoiU34Nly+6t6yhKEne7XmdUZV1LubUR89Q1kf1e1a2T+O+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkyKETUf;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF760A0C88
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 16:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1FF760A0C88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nkyKETUf
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so1621567b3a.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637229; x=1794242029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ytwymmuk/+/FWQeKubl2n1EQYHNLGEexxBc9kzacS5Y=;
        b=nkyKETUfClmhfffk24cmzuaSsCjYUUk6Kf38h0k8FO1mA46T8jm/8eKlezMLL99Bzf
         Sbg17NV5vBOnltGaLDSBaie0pc+BI6645RDQuGgi70ua0dOW9ilpHF8FUrQfFKM8nVS8
         8qtZiKzkIwUmYGEWSHu1wovVsy3KzAvgIQEkw5fO0krcKL53NCAtwnix/QNZnvkuVU3L
         6piVicSL1AhkSCnfr4Ic5X0N7kFGtfWHT7Uc0AQxNyx15/shYDDR8P7ddDM88rOG7Y7O
         qkz7l3EcXIvYfDaMylo86QLp8Fj6oU9z+ufGgEC37ePMFTJIREVdLa76881mc0SYqdpE
         6vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637229; x=1794242029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ytwymmuk/+/FWQeKubl2n1EQYHNLGEexxBc9kzacS5Y=;
        b=Ylkq8kQdX1d61JCMkPuNTlhY0d59Jd59HQdvNgNWWIOB3cp8cZLjhWRPvMK0mB7pzb
         xI2jSx4LLB7zG31+JVf6UvXxVWUtLV2zgaeMfP1VJXlOzTWJRNYb2ZgDy0H5OC0BwIrd
         4GUq2FcndgAS4jqWns+VpGky3UbiH1SBsJl9pN/mKwzRc+LbSzOrf2PqeG37j35SXdDz
         BWHnLtUMmaSarMeZrUnO0I+uBic3qH1vLiVamcWRKkRKBOtXE+BnDLsn5Rl1OWhAisVo
         43oc2qaJCIv7fTAbh5UgnIFPQGtPO0QuWJdABj0THCOCCCP9xyyKa4pOMDV4pdi5KQJt
         Z91A==
X-Forwarded-Encrypted: i=1; AKwUvBxpCe4ZVR7OnkeoK0/WqdkVyTS7U+A1A4HqLc+VH7NcUWquj5HEpC49cKN88DrWzK3bIs43s/14L9c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUiDvaIsEQ09wcA0gu93ntJAzWnWcGPLZeXMzHCB0UEipoMbPz
	3HHdEV3ddCM/wXKXs/pFefugEuySFiTTs4fQMZnEe6Dh4ZJYHH6zWd3B
X-Gm-Gg: AYBFou0ruDngrk2jfnFJbajxWPY+/pK3eDiq+xF3jIn69BPArdCD/3rlFHN1pJiFvid
	zinQ8Doy4Tezwdl8xVWiV1zs5IWkdIoeBNhhSY2Rx+HsRV7oGY/0RvxzpTozesqbayFOvYAJkC1
	UMwXtFu/2oiFCdytbm5Y5OFOIXZqtBH+uUfUy45QXhqrMXZ76Zote/wols17tl6ekDFtORyo6zw
	7YXAtI+BpV08vEP6OwZcI8RZO5YfpOOgozXf7iB+31FYjT/SYHx51qVm+5WGRoXjGTDCn2t1H4w
	nn3yMapr0iLJoAkpFJloJ5uQ0XHyMiuaHrDnp7QJdoisV0JyFhCxS0xJhB2MaesXZB9FWMrEiep
	e2rw4XbVFqqlOioi/MMW24clpUp7AHR82/RRUfdn7v2c+4QQOmAu8O3SazfUDypEcyhQ4M/jSej
	JUvKvNQ9ipdAvLgVL3O8MupiUQEn1EGkYO10PvuJ2F4mDbLA4Ca0BLKwpSQCZXv7AbJZWhSPJOG
	9EQLFG75ssluxGOB6tiukGIp1tMNYKHDAlhO/aS1xL0bQa8aBz08QcKOew3xTYeZLuZvTB/JUYn
	U/1gBx6hE3g1vwxL4wJqs5wW3x62OYyjVoNkdqLbK51gf1iQs2/cZL2HaAnO59Xd1wBODUUrKvm
	kX9eZvtu7h/jokdibH9t1pTR/z8+ApjqCG+pDMAg2ipit9qzHslwBBD7LG1Ychpe6RXt01hRQCR
	j4B9+suqpSo1NbYPvpB9J6gNyL9aXkApwWAGOZA9SXeweUjnpQxgk=
X-Received: by 2002:a05:6a00:6ca8:b0:8a0:92e5:8856 with SMTP id d2e1a72fcca58-8a9bdbd06a6mr6775380b3a.5.1793637228935;
        Mon, 02 Nov 2026 08:33:48 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:47 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH 00/14] spi: spi-mux, core, ti-qspi: error handling, delay fixes, KUnit tests, and lock context annotations
Date: Mon,  2 Nov 2026 16:30:09 +0000
Message-ID: <20261102163023.2574632-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joseph CT Chan <josephctchan@google.com>

Hi Mark,

This series fixes four categories of error-handling and configuration
propagation bugs across the SPI core, spi-mux, and spi-ti-qspi
(Patches 1-6), adds three KUnit test suites on ARCH=um with detailed
inline comments explaining the expected vs. broken states at each
assertion (Patches 7-9), and enables Clang compile-time lock context
analysis across the SPI subsystem (Patches 10-14).

Detailed line-by-line code walkthroughs of the four bug mechanisms and
the three KUnit test suites are also available at:
https://gist.github.com/joectchan/9a14b5e6facb75058ebc5a6ff1757131

Overview of the Bugs Fixed (Patches 1-6)
========================================

1. SPI core leaks message optimize state when queuing fails (Patch 1):
   spi_async() and __spi_sync() call spi_maybe_optimize_message() before
   attempting to queue the message. Optimizing a message can allocate
   split transfers on msg->resources (via spi_split_transfers_maxsize())
   and controller state in msg->opt_state (such as compiled command
   programs in spi-axi-spi-engine), and sets msg->optimized = true.
   Normally spi_finalize_current_message() unoptimizes the message after
   it runs, but when queuing fails (-EBUSY when another driver such as
   mmc_spi holds spi_bus_lock(), -ESHUTDOWN when the queue is stopped,
   or -ENOTSUPP when ctlr->transfer is NULL), the message was never
   queued and is never finalized. Patch 1 calls
   spi_maybe_unoptimize_message() on the queue failure paths in
   spi_async() and __spi_sync(), while preserving caller pre-optimized
   messages (msg->pre_optimized == true).

2. spi-mux leaks the mux semaphore on parent spi_setup() failure and
   ignores live spi_setup() updates from the active child (Patches 2-3):
   - In spi_mux_select(), mux_control_select() acquires the mux
     semaphore before calling spi_setup(priv->spi). If parent
     spi_setup() fails, spi_mux_select() returned the error with the mux
     semaphore still held and priv->current_cs already set to the failed
     child's chip select. Patch 2 resets priv->current_cs =
     SPI_MUX_NO_CS and calls mux_control_deselect(priv->mux) when
     spi_setup(priv->spi) fails.
   - When the currently selected child updates its mode (for example
     mmc_spi flipping SPI_CS_HIGH), max_speed_hz, bits_per_word, or
     delays and calls spi_setup(), spi_mux_setup() left priv->current_cs
     unchanged, so the next transfer on that child hit the
     priv->current_cs == spi_get_chipselect(spi, 0) early return in
     spi_mux_select() and ran with stale parent settings. Patch 3 resets
     priv->current_cs = SPI_MUX_NO_CS in spi_mux_setup().

3. Early errors in spi-mux and spi-ti-qspi skip
   spi_finalize_current_message() and hang callers (Patches 4-5):
   - spi-mux sets ctlr->must_async = true and
     ctlr->defer_optimize_message = true, so every child spi_sync()
     sleeps in wait_for_completion(&done) while validation is deferred
     to the parent spi_async(priv->spi, m) call inside
     spi_mux_transfer_one_message(). When spi_mux_select() failed (e.g.
     an I2C mux NACK or parent spi_setup() error) or parent spi_async()
     failed synchronously (e.g. -EBUSY while the parent bus is locked,
     or -EINVAL when parent __spi_validate() rejects an odd-length
     16-bit transfer), spi_mux_transfer_one_message() returned the error
     without finalizing the message. Because spi_mux_complete_cb() never
     ran, the child caller slept forever holding mux_ctlr->bus_lock_mutex
     and, on parent spi_async() failure, leaked the mux semaphore and
     left msg->spi, msg->complete, and msg->context overwritten. Patch 4
     finalizes the message on spi_mux_select() failure and invokes
     spi_mux_complete_cb(priv) on parent spi_async() failure.
   - In spi-ti-qspi, when qspi_transfer_msg() failed (such as
     ti_qspi_poll_wc() timing out with -ETIMEDOUT),
     ti_qspi_start_transfer_one() unlocked list_lock and returned early
     without writing QSPI_INVAL, updating m->status, or calling
     spi_finalize_current_message(host). That left noqueue spi_sync()
     returning stale -EINPROGRESS with msg->optimized leaked and caused
     queued spi_async() callers to hang. Patch 5 breaks out of the loop
     on error so the common epilogue writes QSPI_INVAL, records status,
     and finalizes the message.

4. spi-mux drops child chip-select and word delays (Patch 6):
   spi_mux_select() copied max_speed_hz, mode, and bits_per_word to
   priv->spi, but dropped cs_setup, cs_hold, cs_inactive, and
   word_delay. Because the SPI core and parent controller read all four
   delays from priv->spi after m->spi is rewritten, child device delays
   were ignored. Patch 6 saves the mux device's own delays at probe,
   merges each child CS delay with the mux's delay (taking the longer of
   the two so both timing requirements are met), forwards word_delay,
   and restores the mux's original delays via devm on unbind.

Overview of the KUnit Suites (Patches 7-9)
==========================================

All three KUnit suites run on User-Mode Linux (ARCH=um) without physical
hardware and include detailed inline comments at each assertion
documenting both the expected patched behavior and the broken unpatched
behavior:

  python3 tools/testing/kunit/kunit.py run \
    --arch=um --kunitconfig=drivers/spi/tests

- Patch 7 (spi_core_optimize, drivers/spi/tests/spi-core-kunit.c):
  7 parameterized cases testing spi_async() and spi_sync() queue errors
  (-EBUSY on a locked bus, -ESHUTDOWN on a suspended controller, and
  -ENOTSUPP on a mem_ops-only controller) with max_transfer_size = 2
  splitting a 4-byte transfer into two 2-byte transfers on
  msg.resources. Verifies that core-optimized messages are unoptimized
  on queue failure, caller pre-optimized messages are preserved, and
  messages can be reused after transient errors clear.

- Patch 8 (spi_ti_qspi, drivers/spi/tests/spi-ti-qspi-kunit.c):
  Uses logic_iomem emulated MMIO at 0x30000000 on ARCH=um to withhold
  QSPI_WC on QSPI_SPI_STATUS_REG (0x4c), forcing ti_qspi_poll_wc() to
  time out with -ETIMEDOUT. Verifies that both noqueue spi_sync() and
  queued spi_async() return -ETIMEDOUT, unoptimize the message, write
  QSPI_INVAL to QSPI_SPI_CMD_REG (0x48), and recover cleanly on the next
  transfer.

- Patch 9 (spi_mux, drivers/spi/tests/spi-mux-kunit.c +
  kunit_spi_mux.dtso):
  Applies a Device Tree overlay registering a fake mux_chip, a fake
  parent spi_controller, the real spi-mux driver, and two child SPI
  devices across 9 test executions: 4 forwarding error cases
  (bus_locked, rejects_odd_len, select_fails, parent_setup_fails), 4 CS
  delay merge cases (longer, tie, sck_zero, sck_set), and a 4-phase
  settings lifecycle test covering live child spi_setup(), channel
  switching, and driver unbind/re-attach delay restoration.

On unmodified upstream master (c339f4010dea), running the 3 suites
produces 13 failures and 4 passing baseline guard cases (with bounded
timeouts so none of the unfinalized message bugs hang the test runner).
With Patches 1-6 applied, all 17 test cases pass.

Lock Context Analysis (Patches 10-14)
=====================================

Patches 10-14 (by Bart Van Assche) split spi_write_then_read(), add
Clang thread-safety and lock context annotations (__acquires,
__releases, __cond_acquires, __must_hold, __must_not_hold, and
__guarded_by) for bus_lock_mutex and spi-mem, and enable
CONTEXT_ANALYSIS := y in drivers/spi/Makefile and
drivers/spi/tests/Makefile with zero warnings under Clang 23
(CONFIG_WARN_CONTEXT_ANALYSIS=y).

Please consider this patch series for the next merge window.

Thanks,
Joseph

Bart Van Assche (5):
  spi: Split spi_write_then_read()
  spi: Add lock context annotations for bus_lock_mutex
  spi: spi-mem: Add lock context annotations
  spi: microchip-core-qspi: Add lock context annotations
  spi: Enable lock context analysis

Joseph CT Chan (9):
  spi: unoptimize message when queuing it fails
  spi: spi-mux: release mux when parent setup fails
  spi: spi-mux: re-apply settings after child calls spi_setup()
  spi: spi-mux: finalize message when forwarding fails
  spi: spi-ti-qspi: finalize message on transfer error
  spi: spi-mux: pass child CS and word delays to the parent
  spi: add KUnit tests for message optimize state on queue errors
  spi: spi-ti-qspi: add KUnit tests for transfer error finalization
  spi: spi-mux: add KUnit tests for forwarding errors and settings

 drivers/spi/Kconfig                   |  39 ++
 drivers/spi/Makefile                  |   5 +
 drivers/spi/spi-mem.c                 |   4 +
 drivers/spi/spi-microchip-core-qspi.c |   6 +
 drivers/spi/spi-mux.c                 | 124 +++++-
 drivers/spi/spi-ti-qspi.c             |   4 +-
 drivers/spi/spi.c                     | 107 +++--
 drivers/spi/tests/.kunitconfig        |  12 +
 drivers/spi/tests/Makefile            |   6 +
 drivers/spi/tests/kunit_spi_mux.dtso  |  42 ++
 drivers/spi/tests/spi-core-kunit.c    | 308 ++++++++++++++
 drivers/spi/tests/spi-mux-kunit.c     | 581 ++++++++++++++++++++++++++
 drivers/spi/tests/spi-ti-qspi-kunit.c | 225 ++++++++++
 include/linux/spi/spi.h               |  12 +-
 14 files changed, 1423 insertions(+), 52 deletions(-)
 create mode 100644 drivers/spi/tests/.kunitconfig
 create mode 100644 drivers/spi/tests/kunit_spi_mux.dtso
 create mode 100644 drivers/spi/tests/spi-core-kunit.c
 create mode 100644 drivers/spi/tests/spi-mux-kunit.c
 create mode 100644 drivers/spi/tests/spi-ti-qspi-kunit.c


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.56.0.317.g454f8302e1-goog
