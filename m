Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535441;
	b=Tb3XGn66+EcxL6Jlw7UqMukhtFx+NvJM9gqk5wMWaxnwotqU55fbSo9SLsTLjCnSpcKC
	 6xvNi79xJucrU6gWlTjcOZ5x1Im3Zz8TqKqj6CPSKF1sNant8yqa+qaGyn1CsGzR3yRDI
	 NhNYdfsdDOmfc1kHuhxOljWeUoNQOPhJNf6PUMRWtkzccl1HoDscfqm4n1Z8lqdbTL0Pl
	 0b/LAtJygPKccsBNjGgY3Sn/03lKdwbA+HCaGdnubbXiIzSfhfECxM6eMKYyB9a9XtRZY
	 xW2fHaG+04Q3Qb5J8wuKFBcqZJDkcQUBt+lQYUjV9PiE9h0IJLjzr+hidbPNiQoe5Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wWFnZq52aFemWQVU3FO+zhaaA536TzrUBXysLMQ8ZIs=;
	b=0ISUizMQCHDksivSe57M0dIWPv7MjmYZrc1oM4LMwISjL2w3YXxr5bsFZuW/HjF2JCpc
	 UHht+neY5b/FAmvaK+/33X69IhbPa3xhxjmj67r1Hl07OjANsY6UvNKt/5vRFIxNI2hzi
	 uaCIXSBX2iPr8Lfoz8ttyQlzXWmMXRk9EhjDH/YAoQjXXPuZpq4hZ0C9OJuM7NLkSIKc+
	 GUtvnnPUu7M95guRAlLP37xP7MVla9d+E8K1vMV44OXGc1piIItWNozx+G9YNa3hIr0/A
	 GDD5LstqcqQkZshrSaEWhmcXi7WHMig8cpmRNyqLR5ra5P1wpbLRoAdo10ikqo71iEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMB6mQqi;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95C606A31C
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 02:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA95C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BMB6mQqi
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so195749a12.0
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 18:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794535440; x=1795140240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWFnZq52aFemWQVU3FO+zhaaA536TzrUBXysLMQ8ZIs=;
        b=BMB6mQqiU8XZyLGttiYm+BgN+XIa3PrzLesPOBrlse/tuC/C7gpSQFSgin3wisf1NF
         gjgYWMEZOFmKG37Xm0lHMpR/iurFJGKNJLYx4YvoF9kOb464jYs9Duw2odYr/RQyhHqV
         7wsBEceliVfWR9j2KmOPdPgTkgTXujdpylU74hb0stYosEA4ZSXCEu+kl9MOwgGgOBTV
         UlQSiPLCVbGJ2RPWwpC49o91WwYRSLKdubxlTQ4g2rhbNaDCb+IeDB9uw6IStNXDBL9q
         6ZAXob9bEDIfO7cRepJ9DiVyIY5u39TmnpNtZb11K64GnveUajfDtfz8OSr39kkKUx3o
         hJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794535440; x=1795140240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWFnZq52aFemWQVU3FO+zhaaA536TzrUBXysLMQ8ZIs=;
        b=LzYQiDQczgwegsVNP5l6a7yMadCXiGtV6d+ur6r9wMlAgW8LBCteViQavP03rq+Wuu
         E5pGj95hgNjeJ3DMb/rs66NVzYjblnSiUT1dsFRjDoDc3GBwAQc9fZeuiHI6QtSJNV2n
         8Kv+zPf5zdEQjE039w9ZgBT3M2SbXr+hQo+2cYMx5opd1HY3FfkNigJvnGvZF6qolN6B
         OFz6A5SMbNMZxd7vRESYoj5ww+8VRAUowMqNxcBUkE4ImyNDSbBxN5pCRdm8azqjqtcz
         E/M7W2dQmRGNjAGev7MENzMq9pB5kF2KLB17GDRu/lDwogHa6hJfoQuWGP31cOYxWaAs
         mD5w==
X-Gm-Message-State: APuU4Z+7OI+5oKLoyix3F/GmTPNVp572ufLDkttwUfLa3P3mMpcgOuPX
	ng3XwigNkqKaikbm887t/ktMooJA7AjLoUlqO5jZrmA0r4DCehTzFX2g
X-Gm-Gg: AYBFou0Ztg1LTU6U0KaV0Rg+kAvACpWN0KNHtrsDxDjQIRlS25LABdBCefQdeganr3O
	ojU7kQWXaOlm4WcGie2Gw6ZBGqGW+tS0uXnlZDVT4DAPFbTctY1uUvYrp0jTFUE3NedrTOK3nNN
	ZhFwPxytrKwOMt1sfv/IkAZ/LOi8b22+b22SBMSQivw3jHA09zd2gdlqIwXhOKUViamDAuYEpj2
	krx4u2AwLEb8DW9+2l7eRpY/zE49uoGeRl+6/q/sHOSM8IonvjYzp4E5QRQQWFGQtsRaLAySEcZ
	wdZgdsNmB+f+8iFTGTVqLHUIPlCShGrR24h6psADq6ldTHbHa81J2rpyGsXhxwv8MS4bbrmBsj1
	iWy166FEe1XwdYNXsaz2QcZ+ub57GoPr7Wsqp0e9iBXSZ8psn+GfxBDpIM3PLCXR5V3dD/mz98R
	b1a14vj5cRRhgvw2gUKNXnG9nz3EMAElUlqO3QmTEajfc2+5FXNX0A7NHoiTXfe1D7cTy1hmAqv
	0CZImL8i8v3C+db9iing2o+Kotukw40kJ14EDLryf10RXU0CApfW/guY5Qx1SGY2q144OsUdV9i
	FKuZSiVGFJ9SmuyOQ7nFcJ3NRN4+qpliV117TFJJRgdDQwX1q/LWLlTc3RlNG+TJOcuMt8eDOk6
	F6rXQM4Vz9QbAv5HkHKwK7k6Pj0D/OftoT4+W32fHvfdEEa5/iWzfLhBDP0MXLC5RgUaIRSKbHX
	A1xVLEXlEQHFvVrsR5DU2zxrncZmQQzy2rlvu6MgQGTcUEZY2Qh+JuxVwmldR+cpkqsUng
X-Received: by 2002:a17:90b:3806:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3b1b0b53ad8mr680033a91.50.1794535439670;
        Thu, 12 Nov 2026 18:03:59 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm7167618a91.7.2026.11.12.18.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:03:59 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v3 0/2] spi: unoptimize message when queuing it fails
Date: Fri, 13 Nov 2026 02:03:50 +0000
Message-ID: <20261113020352.1741295-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

spi_async() and spi_sync() optimize a message before they queue it. If
queuing fails, the message is never finalized, so the split transfers
and the controller's optimize state leak and the message stays marked
as optimized. This happens with -EBUSY while another device holds
spi_bus_lock() (for example mmc_spi), with a stopped queue, and with an
error from a legacy transfer() callback. Patch 1 unoptimizes the message
on those error paths, and patch 2 adds KUnit tests for them.

Tested with KUnit using --kunitconfig=drivers/spi on ARCH=um and on
x86_64 under QEMU: the 7 new cases and the 4 existing DMA cases pass
with patch 1, and the 3 queue error cases fail without it. Not tested
on hardware.

Changes in v3:
- Rebased on spi/for-7.5.
- Patch 2: include drivers/spi/tests unconditionally from
  drivers/spi/Makefile instead of adding a second conditional line, as
  you suggested.
- Patch 2: add the test to the existing drivers/spi/.kunitconfig, which
  also runs the DMA tests, instead of adding a new one.

Changes in v2:
- Split out of the v1 14-patch series, as David suggested.
- Patch 1: added David's Reviewed-by.
- Patch 2: inject errors through the fake controller's transfer()
  callback instead of mem_ops, use designated initializers, and trim
  the comments.
- Moved the AI assistance note from an Assisted-by tag into the commit
  message.

v2: https://lore.kernel.org/linux-spi/20261103224753.3610049-1-jctchan@gmail.com/
v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

Walkthrough of the bug and the tests:
https://gist.github.com/joectchan/9a14b5e6facb75058ebc5a6ff1757131

Please consider this patch series for the next merge window.

Thanks,
Joseph

Joseph CT Chan (2):
  spi: unoptimize message when queuing it fails
  spi: add KUnit tests for message optimize state on queue errors

 drivers/spi/.kunitconfig           |   1 +
 drivers/spi/Kconfig                |  13 ++
 drivers/spi/Makefile               |   2 +-
 drivers/spi/spi.c                  |   7 +
 drivers/spi/tests/Makefile         |   1 +
 drivers/spi/tests/spi-core-kunit.c | 262 +++++++++++++++++++++++++++++
 6 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spi/tests/spi-core-kunit.c


base-commit: 281521f809f6a6ff406d082293faf1ed3bbfd949
-- 
2.56.0.506.g506a7eabc5-goog

