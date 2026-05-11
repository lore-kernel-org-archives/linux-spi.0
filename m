Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5B29B8D0;
	Mon, 11 May 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513630; cv=none; b=aBfVATQc8r+IuExgadxAApUFWx6k1rU/sww7+2J3T6Kms7d1MsMA3uVum8YXWffllXzHxr4FR5Cxm9l4slwZPSQX/8d2duQaliqM9W66NfVOLoQpZ8xPBq01X62olq9v7ekUaZy9vVLS/Sp0/Ge4QkBkaFKeSB2JNN/O0qqBoas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513630; c=relaxed/simple;
	bh=Cb2uoTixGhpbTSaJtBxYWrPbK0ZaCkAAK9XeDGgZuNU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2yGsPrALToUKviNtL098Cki2M3Bu6zjBVziEjo5ol+0WLYn1eeTce1qKD1QUrj5vOGhkpnceL7TVKqq2LXKHo7zVdGHICEWk6HFaxjuQZCLqAu7ikwfZ8cp3mz7rzMxe9r0Uy9wJppAleeYKnwNyCYW2xhCtn73VLUfbPm+JIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id D6C6DC3EEAC9;
	Mon, 11 May 2026 17:28:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D6C6DC3EEAC9
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Schwierzeck
 <daniel.schwierzeck@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>
Subject: MIPS Lantiq VRX268 general Linux SPI timeout
Sender: khalasa@piap.pl
Date: Mon, 11 May 2026 17:28:15 +0200
Message-ID: <m3bjemm0ds.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I finally found some time to investigate SPI issues on my old ADSL
router. This is 500 MHz Lantiq VRX268 MIPS 34Kc (32-bit) with 2 VPEs
(a la hyperthreading). The problem is (happens every few days or so):

spi-nor spi0.4: SPI transfer timed out
spi_master spi0: failed to transfer one message from queue
spi_master spi0: noqueue transfer failed
I/O error, dev mtdblock2, sector 1588 op 0x0:(READ) flags 0x800 phys_seg 14=
 prio class 2

VRX268 (aka VR9) uses the spi-lantiq-ssc.c driver (the router uses
OpenWrt with Linux v6.12, but the current code doesn't seem to have
significant changes).

Using a Saleae analyzer, I captured a general characteristics of the SPI
on this router - the hardware transfers up to 32 bytes in a continuous
burst taking ca. 6.2 us, followed shortly by an IRQ. This seems to work
correctly.

The SPI timeout (in the core drivers/spi/spi.c) is calculated as
2 * (8 * MSEC_PER_SEC * xfer_len / speed_hz) + 200 which simply amounts
to 200 ms with 512-byte transfers (8000 * xfer_len < speed_hz).

A typical sector read operation takes ca. 1 ms (from CS falling edge to
rising edge) and the 200 ms timeout may seem fair. However, this isn't
a very fast CPU, and (probably due to other load, including IRQ-heavy)
the read can take much more time. In a single 20-second dump, I can see
several reads which take more than 100 ms (the timeout didn't fire for
them, though, except for the one). The delay can happen anytime: right
after the 4FAST_READ opcode, after the 4-byte address phase, after the
dummy byte, and after the 512-byte block (just before the ending CS
edge). The IRQ handler is never delayed (much), though.

We have a work queue here:
(probe) spi->wq =3D alloc_ordered_workqueue(dev_name(dev), WQ_MEM_RECLAIM);
        INIT_WORK(&spi->work, lantiq_ssc_bussy_work);

The example failing sector read takes ca 210 ms:
- CS goes down (activation),
- within 55 us the 4READ_FAST opcode is sent and its IRQ is handled,
- lantiq driver signals queue_work(spi->wq, &spi->work);
- I assume the logical CPUs are now busy with other non-SPI tasks so
  lantiq_ssc_bussy_work()->spi_finalize_current_transfer() isn't called yet
- for over 208 ms nothing happens, then the core SPI code aborts the "trans=
fer".
- lantiq_ssc_unprepare_message() calls flush_workqueue(spi->wq)

Example (timeout set to 150 ms, system clock is 100 Hz):
[  234.350000] lantiq_ssc_prepare_message ENTRY
[  234.350000] lantiq_ssc_prepare_message EXIT
[  234.350000] lantiq_ssc_set_cs ENTRY
[  234.350000] lantiq_ssc_set_cs EXIT
[  234.350000] lantiq_ssc_transfer_one ENTRY
[  234.350000] IRQ completed
[  234.350000] lantiq_ssc_transfer_one EXIT
#      190 ms passes here
[  234.540000] spi-nor spi0.4: SPI transfer timed out
[  234.540000] lantiq_ssc_set_cs ENTRY
[  234.540000] lantiq_ssc_set_cs EXIT

It seems everything here works as designed, it's just the slow CPU under
load.

BTW this is not related to any timeout, or error, in the actual hardware dr=
iver.

Now what should we do with this?
a) should we increase the 200 ms timeout? Would it still fail eventually?
b) should the timeout be configurable, maybe by the platform code?
c) some other way?
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
