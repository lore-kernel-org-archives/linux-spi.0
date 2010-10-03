From: Grant Likely <grant.likely@secretlab.ca>
Subject: [git pull] SPI bug fixes for 2.6.36
Date: Sat, 2 Oct 2010 21:26:58 -0600
Message-ID: <AANLkTimgKWoFt8Kd3DCG20Mpkib54ePPiiGbabVvrYuU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Roel Kluin <roel.kluin@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Some spi bug fixes for 2.6.36

The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:
  Linus Torvalds (1):
        Linux 2.6.36-rc6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge-spi

Roel Kluin (1):
      spi: spi-gpio.c tests SPI_MASTER_NO_RX bit twice, but not SPI_MASTER_NO_TX

christophe leroy (1):
      spi/mpc8xxx: fix buffer overrun on large transfers

 drivers/spi/spi_gpio.c    |    2 +-
 drivers/spi/spi_mpc8xxx.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
