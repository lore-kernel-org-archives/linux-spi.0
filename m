From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH v2 0/5] SPI OF bindings and mpc5200-spi
	driver
Date: Wed, 02 Jul 2008 19:02:52 -0600
Message-ID: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I think I've addressed all the comments I've received.  This series
adds OpenFirmware device tree bindings for SPI devices.  SPI master
drivers which make use of of_spi.c can retrieve the set of spi
devices from the device tree and automatically create them.

This series depends on previously posted patch:
"spi: Change modalias from a pointer to a character array"

 Documentation/powerpc/booting-without-of.txt |   60 +++
 drivers/of/Kconfig                           |    6 +
 drivers/of/Makefile                          |    1 +
 drivers/of/of_spi.c                          |   88 ++++
 drivers/spi/Kconfig                          |    8 +
 drivers/spi/Makefile                         |    1 +
 drivers/spi/mpc52xx_spi.c                    |  595 ++++++++++++++++++++++++++
 drivers/spi/spi.c                            |  141 +++++--
 include/linux/of_spi.h                       |   18 +
 include/linux/spi/mpc52xx_spi.h              |   10 +
 include/linux/spi/spi.h                      |   12 +-
 11 files changed, 895 insertions(+), 45 deletions(-)

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
