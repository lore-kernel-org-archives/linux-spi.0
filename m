From: Andreas Ziegler <andreas.ziegler@fau.de>
Subject: Re: spi/bcm63xx: fix standard accessors and compile guard
Date: Tue, 13 Oct 2015 21:30:41 +0200
Message-ID: <561D5BE1.2040109@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Valentin Rothberg <rothberg@cs.fau.de>,
	Paul Bolle <pebolle@tiscali.nl>
To: Jonas Gorski <jogo@openwrt.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Jonas,

your patch "spi/bcm63xx: fix standard accessors and compile guard"
showed up as commit 682b5280bf00 in linux-next today (that is,
next-20151013). I noticed it because we (a research group from
Erlangen[0]) are running daily checks on linux-next.

Your commit fixes two #ifdef statements in drivers/spi/spi-bcm63xx.c
which involve CONFIG_CPU_BIG_ENDIAN.

>From the Makefile at drivers/spi/Makefile (line 20), we can see that the
file can only be built when CONFIG_SPI_BCM63XX is set. In the
corresponding Kconfig file (drivers/spi/Kconfig, line 137),
CONFIG_SPI_BCM63XX is defined to depend on CONFIG_BCM63XX. The latter is
defined in arch/mips/Kconfig (line 199), and selects
CONFIG_SYS_SUPPORTS_BIG_ENDIAN (but not CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN).

Finally, CONFIG_CPU_BIG_ENDIAN (at arch/mips/Kconfig, line 1136) depends
on CONFIG_SYS_SUPPORTS_BIG_ENDIAN, which means that if the source file
is to be compiled, CONFIG_CPU_BIG_ENDIAN is the only possible selection
in the endianness choice. Hence, the #ifdefs are unnecessary and could
possibly be removed.

Is this correct, or am I missing something?

Best regards,

Andreas

[0] https://cados.cs.fau.de
