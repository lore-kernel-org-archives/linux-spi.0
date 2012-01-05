From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [GIT PULL] gpio changes for 3.3 (plus some random spi and dt stuff)
Date: Wed, 4 Jan 2012 21:34:44 -0700
Message-ID: <CACxGe6sJ8LqQM175zGNmCp4ecn9ZkkWT9gkX7OUyBiB8--TAGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Linus,

Here are the gpio/next changes queued up for 3.3 and which are in
linux-next.  There are a few device tree and spi changes mixed in here
as well. The dt changes are there because they were tested alongside
gpio changes that use them.  The spi changes are there because I'm
stupid and applied them into the wrong branch which I didn't notice
until now when I've got other commits on top of it.  If this bothers
you then I can rebase the branch.

There is a signed tag for this branch: gpio-for-linus-20110104

g.

The following changes since commit 805a6af8dba5dfdd35ec35dc52ec0122400b2610:

  Linux 3.2 (2012-01-04 15:55:44 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 gpio/for-linus-20120104

Chris Blair (3):
      spi/pl022: only enable RX interrupts when TX is complete
      spi/pl022: move device disable to workqueue thread
      spi/pl022: add support for pm_runtime autosuspend

Grant Likely (7):
      gpiolib: output basic details and consolidate gpio device drivers
      gpio/microblaze: Eliminate duplication of of_get_named_gpio_flags()
      gpio/powerpc: Eliminate duplication of of_get_named_gpio_flags()
      of: create of_phandle_args to simplify return of phandle parsing data
      of: Add device tree selftests
      gpio: Add Linus Walleij as gpio co-maintainer
      Merge branch 'pl022' of
git://git.kernel.org/.../linusw/linux-stericsson into gpio/next

Jonas Aaberg (1):
      spi/pl022: fix build warnings

Mark Brown (4):
      gpio: Explicitly index samsung_gpio_cfgs
      gpio: Fix typo in comment in Samsung driver
      gpio: Convert GPIO drivers to module_platform_driver
      gpio: Add decode of WM8994 GPIO configuration

Tomoya MORINAGA (2):
      pch_gpio: Support new device LAPIS Semiconductor ML7831 IOH
      pch_gpio: Change company name OKI SEMICONDUCTOR to LAPIS Semiconductor

Virupax Sadashivpetimath (3):
      spi/pl022: skip default configuration before suspending
      spi/pl022: disable the PL022 block when unused
      spi/pl022: make the chip deselect handling thread safe

 MAINTAINERS                                    |    1 +
 arch/arm/boot/dts/testcases/tests-phandle.dtsi |   37 ++++++
 arch/arm/boot/dts/testcases/tests.dtsi         |    1 +
 arch/arm/boot/dts/versatile-pb.dts             |    2 +
 arch/microblaze/kernel/reset.c                 |   43 +-------
 arch/powerpc/sysdev/qe_lib/gpio.c              |   42 ++------
 drivers/gpio/Kconfig                           |   11 +-
 drivers/gpio/gpio-adp5520.c                    |   12 +--
 drivers/gpio/gpio-adp5588.c                    |    5 +-
 drivers/gpio/gpio-bt8xx.c                      |    3 -
 drivers/gpio/gpio-cs5535.c                     |   14 +--
 drivers/gpio/gpio-da9052.c                     |   12 +--
 drivers/gpio/gpio-generic.c                    |   12 +--
 drivers/gpio/gpio-janz-ttl.c                   |   15 +---
 drivers/gpio/gpio-nomadik.c                    |    4 +-
 drivers/gpio/gpio-pcf857x.c                    |    5 +-
 drivers/gpio/gpio-pch.c                        |    7 +-
 drivers/gpio/gpio-rdc321x.c                    |   13 +--
 drivers/gpio/gpio-samsung.c                    |   31 ++++--
 drivers/gpio/gpio-sch.c                        |   13 +--
 drivers/gpio/gpio-timberdale.c                 |   13 +--
 drivers/gpio/gpio-ucb1400.c                    |   13 +--
 drivers/gpio/gpio-vr41xx.c                     |   13 +--
 drivers/gpio/gpio-vx855.c                      |   12 +--
 drivers/gpio/gpio-wm8994.c                     |   79 +++++++++++++-
 drivers/gpio/gpio-xilinx.c                     |    1 -
 drivers/gpio/gpiolib.c                         |    6 +-
 drivers/of/Kconfig                             |    9 ++
 drivers/of/Makefile                            |    1 +
 drivers/of/base.c                              |  146 ++++++++++++------------
 drivers/of/gpio.c                              |   45 +++----
 drivers/of/selftest.c                          |  139 ++++++++++++++++++++++
 drivers/spi/spi-pl022.c                        |  141 ++++++++++++++---------
 include/asm-generic/gpio.h                     |    6 +-
 include/linux/amba/pl022.h                     |    4 +
 include/linux/of.h                             |   11 ++-
 include/linux/of_gpio.h                        |   10 +-
 37 files changed, 530 insertions(+), 402 deletions(-)
 create mode 100644 arch/arm/boot/dts/testcases/tests-phandle.dtsi
 create mode 100644 arch/arm/boot/dts/testcases/tests.dtsi
 create mode 100644 drivers/of/selftest.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
