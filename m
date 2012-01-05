From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [GIT PULL] spi changes for v3.3
Date: Wed, 4 Jan 2012 21:43:51 -0700
Message-ID: <CACxGe6u_jVHnZhwvg_-+gDGBKnOpuwUnoTErCGUJ_pHhBgnS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Here are the spi changes I've got queued for 3.3.  Primarily driver
changes with one core spi bug fix.

There is a signed tag for this commit: spi-for-linus-20120104

The following changes since commit 805a6af8dba5dfdd35ec35dc52ec0122400b2610:

  Linux 3.2 (2012-01-04 15:55:44 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 spi/merge

Grant Likely (1):
      Merge branch 'spi/next' (early part) into spi/merge

Laurent Pinchart (1):
      spi: Fix device unregistration when unregistering the bus master

Shubhrajyoti D (3):
      spi/omap: Use a workqueue per omap2_mcspi controller
      spi/omap: call pm_runtime_disable in error path and remove
      spi/omap: Correct the error path

Tomoya MORINAGA (2):
      spi-topcliff-pch: Support new device LAPIS Semiconductor ML7831 IOH
      spi-topcliff-pch: Change company name OKI SEMICONDUCTOR to LAPIS
Semiconductor

 drivers/spi/Kconfig            |    6 ++--
 drivers/spi/spi-omap2-mcspi.c  |   51 +++++++++++++++++++++++++---------------
 drivers/spi/spi-topcliff-pch.c |   13 ++++++----
 drivers/spi/spi.c              |    2 +-
 4 files changed, 44 insertions(+), 28 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
