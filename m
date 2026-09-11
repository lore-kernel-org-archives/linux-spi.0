Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670546D566
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117832; cv=none; b=sSMRQXWj5rOyBTl2TMQTx/DGhoWo7KlXhkybZTaBbTd5WHljJ/B+kBG9PZrsHF5blVy62lBTfGYQI7L6y2MTMlrPCKnj81hPkb5+f28caP3bMz2MT5zhvMgKRiHAD4iwh4dza6fs70VBGQxaatRN8ur5ZfmrcwvJnExY/jL1SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117832; c=relaxed/simple;
	bh=1UiFqdha0Je3xR9CoEQZhVfy8k5gYLDEkjsNuoazTlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOJZKyC7Os19AmYw8qVGkJxPxD3Qk+kaL4ebRJSOQPFUA3+MLZlsmgmv9n+Qse5xQp+eb8dLy/cBAC/bMIRN6vJXKJjXg75ewqzwitPw2usBqPdLWBE4RK5U8OQQ5ybbMmIqfQPeC3VdlTIx9Pxn1GbC2IbhCvCKi7pwmSq9I/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com; spf=pass smtp.mailfrom=jimenezcarrero.com; dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b=NfcQZ8DX; arc=none smtp.client-ip=91.218.175.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b="NfcQZ8DX"
X-Envelope-To: linux-spi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1UiFqdha0Je3xR9CoEQZhVfy8k5gYLDEkjsNuoazTlU=;
 c=simple/simple; d=jimenezcarrero.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789117826; v=1; x=1789722626;
 b=NfcQZ8DX7jkgP757F3iNU2vI/J0SIjry/c1fsQ2Yl0z9QYKMzHnf/P33Z1xZ/vyENtoqBqJm
 uyJHqFjk60RB2KyjlULGwkAblkXn3rjePW251YiqQekWcLI6+SDA8nHnECADEw2Tb38GSbBFYA1
 pRfiTgWE2LgVyfU8pxVY4iuEYi0OXscScEeQkhdLCsrbUmp9RDOHJIlcwZYY+wU8ryuVpAtmtG8
 d3sB48oLN+VJQ3jCd9MhT9O4Az1MmNAiMQ/8lMr0XgqXRu5TeQhGvwntvSUO8R+e2KrS3aly+vk
 grU0laXQjP485SWT0pbWsbmDcIVndwmXxGzPcqNd9Cmzg==
X-Envelope-To: linux-spi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a8b86de78718f879;
	Fri, 11 Sep 2026 09:10:23 +0000
X-Mizu-Trace-ID: a8b86de78718f879
X-Migadu-Flow: FLOW_OUT
From: Juan Jimenez Carrero <juan@jimenezcarrero.com>
To: rf@opensource.cirrus.com
Cc: khalil@rentman.nl,
	broonie@kernel.org,
	hansg@kernel.org,
	linux-spi@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	patches@opensource.cirrus.com,
	khalilst@gmail.com,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Fri, 11 Sep 2026 11:10:11 +0200
Message-ID: <20260911091011.76333-1-juan@jimenezcarrero.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <dad5e839-4932-4ae3-86d8-a3c2f4ce07d7@opensource.cirrus.com>
References: <dad5e839-4932-4ae3-86d8-a3c2f4ce07d7@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 03/09/2026 10:21 am, Richard Fitzgerald wrote:
> HP told us they have a BIOS with the cs-gpios fixed, and they can make
> that available early if you post a support request for it.
>
> Can you test that new BIOS? It would avoid the messy SPI workarounds.

I have affected hardware. I could raise a support request and
test that BIOS, if a second machine doing so is useful:

  HP EliteBook 8 G1i 14 inch, SKU D75TQET#ABE
  BIOS X91 Ver. 01.05.02, 05/03/2026
  Intel Core Ultra 5 238V (Lunar Lake-M)
  SPI controller 8086:a827 (LPSS_CNL_SSP via tgl_spi_info)
  Realtek ALC245, SSID 103c:8d8f
  2x Cirrus Logic CS35L54 Rev B0 OTP4 fw:3.4.4, ACPI HID CSC3554

This is the CS35L54 variant rather than CS35L56, so it may be a useful
extra data point either way. The DSDT defect is identical:

  Scope (_SB.PC00.SPI0)
  {
      Name (_DSD, Package (0x02)
      {
          ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package (0x01)
          {
              Package (0x02) { "cs-gpios", Package (0x01) { Zero } }
          }
      })
  }

while GSPK._CRS declares SpiSerialBusV2 with DeviceSelection 0x0000 and
0x0001, plus a GpioIo for the CS1 line.

One difference from the cover letter's description: on this machine
neither amplifier is instantiated on a stock kernel, not only the
second. spi_add_device() rejects CS1 and serial-multi-instantiate then
unwinds the whole set:

  pxa2xx-spi pxa2xx-spi.3: cs1 >= max 1
  spi_master spi1: error -EINVAL: failed to add SPI device CSC3554:00 from ACPI
  Serial bus multi instantiate pseudo device driver CSC3554:00: probe with
    driver Serial bus multi instantiate pseudo device driver failed with error -22

For reference, the LPSS capability register on this board reads
caps[0xfc] = 0x220, so CS_EN (bits 12:9) is 0x1 and ffz() yields
num_chipselect = 1, while ACPI describes two chip selects. The TYPE
field of the same register reads 2 (LPSS_DEV_SPI), so the read itself
is valid. (Obtained with a dev_info() added to spi-pxa2xx.c; the
register is not reachable from userspace with CONFIG_IO_STRICT_DEVMEM)

I have run the earlier two-patch version from your gist
(serial-multi-instantiate + spi-pxa2xx), built out-of-tree as a DKMS
module against 7.1.9. With those applied both amplifiers probe, load
firmware and calibration, and bind to the codec. Internal speakers work
across a cold boot:

  serial-multi-instantiate CSC3554:00: Increasing num_chipselect from 1 to 2 for CS1
  serial-multi-instantiate CSC3554:00: Got CS GPIO for amp CS1
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.0: DSP system name: '103C8D8F', amp name: 'AMP1'
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.1: DSP system name: '103C8D8F', amp name: 'AMP2'
  snd_hda_codec_alc269 ehdaudio0D0: bound spi1-CSC3554:00-cs35l54-hda.0
  snd_hda_codec_alc269 ehdaudio0D0: bound spi1-CSC3554:00-cs35l54-hda.1
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.0: Calibration applied
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.1: Calibration applied

I have not tested v3, so I am deliberately not offering a Tested-by for
it. I can test v3, the new BIOS or both on this machine (whichever is
more useful).

Juan Jimenez Carrero
