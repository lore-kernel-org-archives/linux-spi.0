Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFD3FD12A
	for <linux-spi@vger.kernel.org>; Wed, 16 Sep 2026 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593878; cv=none; b=rlD7mNEOF5gzBqduTE9DgLMeXL+UuMjFdtI2mSv8RKMV5f5zFSvV0BwTAI1WrF04fSnuj6YsTVmnA325hsYYL3Ln0BxRMOYDBg6YQJNCeFxXJzwnNV3bAXScarl/Orhhhwp8HX9TZspkwvznL6Z+m63UBkxCQ0Rwaagdc8KKUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593878; c=relaxed/simple;
	bh=W2j8a4jZDPmkymjfN1hItBmWKFDdSwH3LXIvlxtLS7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWYj47suIqUxYn1FOd+geHP6IXyvGzUoCR+tVILBHWAaz7o5UuR79IRSsQCr2DdUekQuvsy1cIUT8fV/ss0pa5U+Sy89ycHkVVXQX4sGKyFL+jGgHF55LcoF24fHnPBdeXGKw1gFnG2UOati486pfKTKYYmEAMIlezMrgf1BMPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com; spf=pass smtp.mailfrom=jimenezcarrero.com; dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b=LQYOZaaU; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b="LQYOZaaU"
X-Envelope-To: linux-spi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W2j8a4jZDPmkymjfN1hItBmWKFDdSwH3LXIvlxtLS7E=;
 c=simple/simple; d=jimenezcarrero.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789593849; v=1; x=1790198649;
 b=LQYOZaaUV1A77d9PHytdeBHsAZaWaCBKA/RABbsa+jghYQCRrUs67t8cYBx/n5SWj8oo+3SV
 +tTyDqkj2gHZIuIW7ccMYVG9IFYwfaXg7nas5spKiTSyDsvhS9jlZHPJVXF2fKO/Nm/kLXFRYT/
 HzKgYRmHF7tx3HPClX3W9CDNzYWKnhtOmuvV3kpYXZofkjI4hlu8Q3d5yG5XcQmU+53BWIQsXwS
 4N0E+SJxnttYWqQGlON2v3GVH+yAP7HjcxSjLvT2nVgHZE7072ocXj5ZWWV3uIGjvZ9CM+5tnzM
 sq4tbd7QCNtE5RPa2IEG0b8XpmApzdcdVUyJdpwqAQIzg==
X-Envelope-To: linux-spi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 11e736fe78460d70;
	Wed, 16 Sep 2026 21:24:08 +0000
X-Mizu-Trace-ID: 11e736fe78460d70
X-Migadu-Flow: FLOW_OUT
From: Juan Jimenez Carrero <juan@jimenezcarrero.com>
To: khalilst@gmail.com
Cc: khalil@rentman.nl,
	rf@opensource.cirrus.com,
	broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr
Subject: Re: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Wed, 16 Sep 2026 23:23:55 +0200
Message-ID: <20260916212355.7216-1-juan@jimenezcarrero.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901192625.1497791-1-khalil@rentman.nl>
References: <20260901192625.1497791-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 21:26:22 +0200, Khalil wrote:
> v3 of the patch series fixing dual CS35L56 amplifiers on HP laptops

Following up on my earlier reply, where I had only run the earlier
gist version: I have now tested v3 on the same machine.

  HP EliteBook 8 G1i 14 inch, DMI board 8D8A, SKU D75TQET#ABE
  BIOS X91 Ver. 01.05.02
  2x Cirrus Logic CS35L54 Rev B0 OTP4 fw:3.4.4, ACPI HID CSC3554
  Kernel: linux-omarchy 7.2.5 (v7.2.5 plus the patch set of Omarchy,
  an Arch-based distribution)

What was tested: 2/3 and 3/3, built out of tree as modules against
that kernel's headers. The distribution kernel carries a sound
backport that also touches serial-multi-instantiate.c; 2/3 applies on
top of it with --fuzz=0.

1/3 was not applied, because CONFIG_SPI=y there. Looking at why the
result still worked: on this path 2/3 installs the descriptor in
ctlr->cs_gpiods and never presets spi->cs_gpiod, spi_alloc_device()
zero-allocates, and __spi_add_device() is the only place the device's
cs_gpiod is assigned. So the new check in 1/3 is always true here and
does not change behaviour on this platform. I may be missing a case
where 2/3 relies on it, but on this machine 2/3 + 3/3 alone were
sufficient.

Log from reloading the modules at runtime:

  Serial bus multi instantiate pseudo device driver CSC3554:00: Applying CS GPIO quirk for HP EliteBook 8 G1i 16 inch
  Serial bus multi instantiate pseudo device driver CSC3554:00: Extending num_chipselect from 1 to 2 for CS1
  Serial bus multi instantiate pseudo device driver CSC3554:00: Acquired CS GPIO for CS1 from ACPI GpioIo[0]
  Serial bus multi instantiate pseudo device driver CSC3554:00: Installed GPIO CS on controller for CS1
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.0: DSP system name: '103C8D8F', amp name: 'AMP1'
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.1: DSP system name: '103C8D8F', amp name: 'AMP2'
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.0: Calibration applied
  cs35l56-hda spi1-CSC3554:00-cs35l54-hda.1: Calibration applied

A cold boot shows the same quirk, GPIO, AMP1/AMP2 and calibration
lines. Both amplifiers bind to the codec and the internal speakers
play in stereo.

One small note on the quirk table: the entry's .ident is "HP EliteBook
8 G1i 16 inch", but this 14 inch model reports the same DMI board name
8D8A (and has CS35L54 rather than CS35L56 amplifiers), so it matches
too. Only the label is narrower than the match.

I'll send Tested-by on 2/3 and 3/3 individually, since 1/3 was not part
of what I ran. The offer to test HP's fixed BIOS still stands.

Juan Jimenez Carrero
