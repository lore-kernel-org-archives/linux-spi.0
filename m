From: Takashi YOSHII <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Subject: [PATCH 00/11] ARM: shmobile: koelsch: MSIOF support
Date: Mon, 2 Dec 2013 03:15:57 +0900
Message-ID: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Koelsch board has SPI connected on-board PMIC(r2a11302).
These patches enable spidev interface for it using MSIOF
(Clock-Synchronized Serial Interface with FIFO) module on SoC(r8a7791).
This adds platform device support to Koelsh single-platform.
(dt, -reference, multi-platform support are not included)

Summary of patches:

These are bug fix.
 [PATCH 01/11] pinctrl: sh-pfc: r8a7791: fix msiof groups to follow GROUP
 [PATCH 02/11] spi: spi-sh-msiof: round up div to fix freq calculation

To use CS output function which the HW module has.
 [PATCH 03/11] spi: spi-sh-msiof: let it run even without GPIO
 [PATCH 04/11] spi: spi-sh-msiof: set hi/low Active for HW CS

To support MSIOF variant that TX and RX are not separately controllable.
 [PATCH 05/11] spi: spi-sh-msiof: rx_need_dummy_tx variant
 [PATCH 06/11] spi: spi-sh-msiof: RMDIR1[15:0] may should be zero
 [PATCH 07/11] spi: spi-sh-msiof: RSCR register may absent

r8a7791 part
 [PATCH 08/11] ARM: shmobile: r8a7791: Add MSIOF clocks
 [PATCH 09/11] ARM: shmobile: r8a7791: MSIOF platform device

Koelsh part
 [PATCH 10/11] ARM: shmobile: koelsch: pinctrl map for MSIOF0
 [PATCH 11/11] ARM: shmobile: koelsch: spidev for r2a11302

---

Takashi Yoshii (11):
  pinctrl: sh-pfc: r8a7791: fix msiof groups to follow GROUP
  spi: spi-sh-msiof: round up div to fix freq calculation
  spi: spi-sh-msiof: let it run even without GPIO
  spi: spi-sh-msiof: set hi/low Active for HW CS
  spi: spi-sh-msiof: rx_need_dummy_tx variant
  spi: spi-sh-msiof: RMDIR1[15:0] may should be zero
  spi: spi-sh-msiof: RSCR register may absent
  ARM: shmobile: r8a7791: Add MSIOF clocks
  ARM: shmobile: r8a7791: MSIOF platform device
  ARM: shmobile: koelsch: pinctrl map for MSIOF0
  ARM: shmobile: koelsch: spidev for r2a11302

 arch/arm/mach-shmobile/board-koelsch.c |   20 ++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |    9 ++++++++-
 arch/arm/mach-shmobile/setup-r8a7791.c |   30 ++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c   |   21 +++++++++++++++------
 drivers/spi/spi-sh-msiof.c             |   30 +++++++++++++++++++++---------
 include/linux/spi/sh_msiof.h           |    1 +
 6 files changed, 95 insertions(+), 16 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
