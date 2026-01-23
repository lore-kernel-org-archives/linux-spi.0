Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9C2EC0BF
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200721; cv=none; b=IvFZ0O8NdFyJVippJysnO2ofvFnWzHkkWP+NJv5pB1bZUTa2S3pm/qvY3Ym1w47HGS4bM9p1rQSoWm8j8wOOJjSp1UAMIayRyx9lifGTbr1ZyyFK5QM7CFlVdbUxxZ5Ax9T218V5+VwJmj/c7l7p72Qbbd4JHEXJgYEnNjTbXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200721; c=relaxed/simple;
	bh=2ITiRI1w/MWVnLrF7ChgAdh4IV7A2BJGVXCIwtt1T3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=krK6s8VyJYzfKVsK7xi5fQ0PBdDIH9zwsC7OyJ+Tm+AYBzqU9OUc0EQdf8c4ya2smYo2kL17/X3LuJD9L8wrcCrHvQMIRKDz0oUD5etbEIRn/YYp5fkvN/cJ4GYDHGZpDLVbUiKv6zk8TzxlSeBiiToYZ4eb641RQmlRA1pGq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eSNmbFaz; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eSNmbFaz"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4045ccdd239so783453fac.2
        for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 12:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200717; x=1769805517; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6useoQdQxMlj4eG6EhLxMtnBIsZqLDPhN8NL6rAPI0=;
        b=eSNmbFaz59iI4H/OsqkCsGyysFb2eGmBLOq894xP+LAG67aiVusheh2eGod7UgwZNY
         mHgnELiliCC+qCEifX4LFSqfSVcXtRmHT/ryy+EHnDWHHIEdBtgBs0X2DlVKmErj8pmr
         kkp4RfP4Qz4LswYGr1vCYaU1bDdd/0e+CNqgbPWgIsQJHAg2zrr3pWoI35uyBDwpVBfh
         RNBQiNuobud80k1Ljhwv2zayC/6FCTfNSdDDOlq+gBdOcgF25dBsUQL4ar9FeEh25vVg
         y344jxhhaSDAKgfQobMxFEUfGYp7x1o5gRGdHOwzREBRB/kg+ntFNNYBH2rUDiAiaJp2
         v/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200717; x=1769805517;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6useoQdQxMlj4eG6EhLxMtnBIsZqLDPhN8NL6rAPI0=;
        b=j5Bbn4M9s1xLyzjEzcyXS08jz1FiBdBMQYxNOA+v6zROXmnwQ/T89aBmIJU2t4EHcd
         d4+J4aOGf7VNb/1wCCrBDi73CvASdoUfCu7VkjEu3oBnxgIGTmLDPRxUBeZoZdSsRmYj
         DITvfFeHICk7Hq4vvVHdaK6m0ess4Rzh+AmhPR0JYCIXfadU8FA2zFzrlpjfNka/z4B6
         LZTifrDnQ0cGjJ1A7LarTO2Kg4IgdkG6/5GsjChv94jVLkfs1iTWIxOvu/QXTJPgOXhW
         cYA/3EpP3hoyBTY3KI9N7FVaXhMPORvUelo6koIoRe052K4FY1OCDityY5qjNKeIrWIs
         wlVw==
X-Forwarded-Encrypted: i=1; AJvYcCUTlGashEGDtlG2baCImBfXK6qK86pjZ71fL0Blcax6XI9LcW+/jMUrevUkYle8Ekltr0puh7hN0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3A3uX5bZNvl0404acPDeKtUjuqqv0ZO3CneWyckjL2L3Og6D
	zPNjZDeaKTLKg/G7uhjljan/WubsT5ZrHQhkQcMtwVRUNnOEgMRVofQobvdXIOEd9ms=
X-Gm-Gg: AZuq6aIvnEj/m4HCkV5Dp+XNIrkP1uaO2xFxTj2KSzfkNKx2WixtRADuSzU63qyzeIP
	apiXsoKyXJYPb0XdyP5HknvD4JOs3f7jBx8der6sdTA2ucM3iuwfp6rj8zk3alyRuLUDi3HalIe
	d77eR/5nyc1k2xDKmlpQD/DITJgbMoM/gVBTsrl1b9rsQxTIFavdREvWRVYFppjjgOibm8ybSY+
	X2WFtIx+CHTCqMiUn+H40vEUp9NmR5fi4pnys/olS2Z99vNWYcYDbpYVVwlWjmFPx9qK13tsIOX
	vnv+5FSNO0Sg+2EXG0vxx2tqvLHBdGgVMcGB4Rwd18PbbZiZUTGdMrWB1QDGH9KGtPP6vYlIXOl
	OiUXl5NCJeOS3RNrED7GLul7PSGINILPajYc8q3LDev7ry9i4PQi/Zv7MBODmioP9LUPQ0NEHHW
	C+iZi8F9jboN0J1g==
X-Received: by 2002:a05:6870:8197:b0:3e8:8e57:a7a9 with SMTP id 586e51a60fabf-408ab88339bmr1936769fac.52.1769200717074;
        Fri, 23 Jan 2026 12:38:37 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6 0/9] spi: add multi-lane support
Date: Fri, 23 Jan 2026 14:37:23 -0600
Message-Id: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QyWrDMBQF0F8xWletnqZYWfU/SheyhkYQD5Vk4
 xD875UdSkoxXl7BPe+iO0ouBpfQubqj6KaQQt+VIF8qZC66+3I42JIRJVSQGgROQ8DaWtyO1xx
 wMyacxmHoY8bQMGGJMIJ7iUp/iM6HebM/Ph85uu+xnMiPR9To5LDp2zbkc3UN3Tjjzs35rdUpu
 4jW0iWk3Mfbtm+CrbVOAQL8YMoEmGBKVG2AWumFf2/07Rqa6F7LuQ2e6BMDcjrCaMFqrahUjAG
 3agdjT4wSOMJYwRh3RJwUWFezHYz/wUAdYbxgwIU1ghJubL2DiV9MEgB6hIn1z5Tw3BPlZaP/Y
 cuy/ACPuZDtLgIAAA==
X-Change-ID: 20250815-spi-add-multi-bus-support-1b35d05c54f6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6619; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2ITiRI1w/MWVnLrF7ChgAdh4IV7A2BJGVXCIwtt1T3M=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDKL73CIOsn58LqcbK3deetT/7mqe52pTixdh9X4+lb8b
 43JzN3QyWjMwsDIxSArpsjyRuLmvCS+5mtzbmTMgBnEygQyhYGLUwAmIibG/k9xV8jTao/ml4nX
 HG8ILrYoOWLxwb2Zf/EudaM0/h8/1h2xUjz84LDaFA+OmCUffFKa5UNqTB92zj7Sd0FtWZZzNtf
 6og4/pnCWI6VHVfI8f9qHWs3uTvV+PVm2ITp4tssdmT1OuV4fnD0aunr3Pt+4wcftvXPpf/l29v
 UF7/4FL9jKL/Xu7eHWwuoTTzdkCvu567MXb/Xet0Vq/9rljad4Y3O2JGkaLIjWLJOOTPwXWv5nW
 VLRsZyLPxYHpGuHVsgd7rxzNL2uxFZu301VZ/N8pQcNknKl+W5bO3Rj/7RuVTv3Vp133tclstPP
 frdTkct+4xe/hv8ym1xm4g4Pe7fD31d0GLyyEal79ckHAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This series is adding support for SPI controllers and peripherals that
have multiple SPI data lanes (data lanes being independent sets of
SDI/SDO lines, each with their own serializer/deserializer).

This series covers this specific use case:

+--------------+    +---------+
| SPI          |    | SPI     |
| Controller   |    | ADC     |
|              |    |         |
|          CS0 |--->| CS      |
|         SCLK |--->| SCLK    |
|          SDO |--->| SDI     |
|         SDI0 |<---| SDOA    |
|         SDI1 |<---| SDOB    |
|         SDI2 |<---| SDOC    |
|         SDI3 |<---| SDOD    |
+--------------+     +--------+

The ADC is a simultaneous sampling ADC that can convert 4 samples at the
same time. It has 4 data output lines (SDOA-D) that each contain the
data of one of the 4 channels. So it requires a SPI controller with 4
separate deserializers in order to receive all of the information at the
same time.

This should also work for the use case in [1] as well. (Some of the
patches in this series were already submitted there). In that case the
SPI controller is used kind of like it is two separate SPI controllers,
each with its own chip select, clock, and data lines.

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-1-sean.anderson@linux.dev/

The DT bindings are a fairly straight-forward mapping of which pins on
the peripheral are connected to which pins on the controller. The SPI
core code parses this and makes the information available to drivers.
When a peripheral driver sees that multiple data lanes are wired up, it
can chose to use them when sending messages.

The SPI message API is a bit higher-level than just specifying the
number of data lines for a SPI transfer though. I did some research on
other SPI controllers that have this feature. They tend to be the kind
meant for connecting to two flash memory chips at the same time but can
be used more generically as well. They generally have the option to
either use one lane at a time (Sean's use case), or can mirror the same
data on multiple lanes (no users of this yet) or can perform striping
of a single data FIFO/DMA stream to/from the two lanes (our use case).

For now, the API assumes that if you want to do mirror/striping, then
you want to use all available data lanes. Otherwise, it just uses the
first data lane for "normal" SPI transfers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Maintainer coordination:

Jonathan has requested an immutable branch from the SPI tree containing
the SPI patches from this series (all but the last two patches) so that
he can pick up the IIO patches.

Given the timing in the release cycle, if the SPI bits make it into the
next merge window, then an immutable branch won't be necessary and we
will pick up the IIO patches after -rc1.

Changes in v6:
- Addressed several review comments in the "spi: support controllers
  with multiple data lanes" patch.
- Fixed some typos in the documentation patch.
- Link to v5: https://lore.kernel.org/r/20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com

Changes in v5:
- Fixed up affected dt-bindings for a new SPI controller that was added
  recently.
- Made some clarification and fixes in the documentation in several
  places.
- Fixed parsing of mapping properties.
- Link to v4: https://lore.kernel.org/r/20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com

Changes in v4:
- New patch to change spi-{rx,tx}-bus-width to array. This will cover
  most use cases.
- Split data-lanes property into spi-{rx,tx}-lane-map. These properties
  are now only needed for special cases instead of being the primary
  property for multi-lane support.
- Didn't pick up Rob's acks since all DT bindings are significantly changed.
- Rework other code to accommodate the above changes.
- New documentation patch.
- Link to v3: https://lore.kernel.org/r/20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com

Changes in v3:
- Use existing data-lanes devicetree property name instead of creating a
  new one.
- Renamed "buses" to "lanes" everywhere to match the devicetree property
  name.
- Clarified bindings description about how to specify data lanes.
- Link to v2: https://lore.kernel.org/r/20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com

Changes in v2:
- Renamed devicetree property spi-buses to spi-data-buses. (Driver code
  was already using spi->data_buses, so it matches).
- Fixed a small bug in the AXI ADC driver changes.
- Moved one line of code in the ADC driver changes.
- Link to v1: https://lore.kernel.org/r/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com

---
David Lechner (9):
      spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
      spi: dt-bindings: add spi-{tx,rx}-lane-map properties
      spi: support controllers with multiple data lanes
      spi: add multi_lane_mode field to struct spi_transfer
      spi: Documentation: add page on multi-lane support
      spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
      spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
      dt-bindings: iio: adc: adi,ad7380: add spi-rx-bus-width property
      iio: adc: ad7380: add support for multiple SPI lanes

 .../bindings/display/panel/sitronix,st7789v.yaml   |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  42 +++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  23 +++
 .../bindings/spi/adi,axi-spi-engine.yaml           |  15 ++
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   6 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   6 +-
 .../bindings/spi/andestech,ae350-spi.yaml          |   6 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   6 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  40 +++-
 Documentation/spi/index.rst                        |   1 +
 Documentation/spi/multiple-data-lanes.rst          | 217 +++++++++++++++++++++
 drivers/iio/adc/ad7380.c                           |  51 +++--
 drivers/spi/spi-axi-spi-engine.c                   | 145 +++++++++++++-
 drivers/spi/spi.c                                  | 144 +++++++++++++-
 include/linux/spi/spi.h                            |  30 +++
 16 files changed, 702 insertions(+), 40 deletions(-)
---
base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

