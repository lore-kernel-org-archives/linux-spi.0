From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v1 0/3] spi: mpc512x: increase throughput, use subsystem queue
Date: Mon,  3 Jun 2013 14:03:48 +0200
Message-ID: <1370261031-28572-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dzu-ynQEQJNshbs@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This change set modifies the MPC512x PSC SPI master driver:
- it increases SPI throughput by eliminating delays in the inner RX/TX
  routine during iteration over the transfer's data, and reducing delays
  at the very end of a transfer -- while the conditions for as well as
  the handling of previously handled exceptional situations are kept
- it makes the SPI master switch to the common subsystem's logic to
  queue messages between the callers' emission and the master's
  transmission (and drops the master's private queue mechanism)

Gerhard Sittig (3):
  spi: mpc512x: minor prep before feature change
  spi: mpc512x: improve throughput in the RX/TX func
  spi: mpc512x: use the SPI subsystem's message queue

 drivers/spi/spi-mpc512x-psc.c |  341 ++++++++++++++++++++++-------------------
 1 file changed, 186 insertions(+), 155 deletions(-)


known issue:

the first patch raises a checkpatch warning because it merely renames
variables but keeps the code path and the existing diagnostics message
in place

a subsequent change in the second patch rephrases the RX/TX routine's
code path and changes the diagnostics message for that condition to
something which doesn't have the checkpatch issue (keeps the user
visible text on one line) and thus passes the test

  WARNING: quoted string split across lines
  #113: FILE: drivers/spi/spi-mpc512x-psc.c:193:
			  dev_warn(&spi->dev, "expected %d bytes in rx fifo "
  +				 "but got %d\n", txcount, rxcount);

  total: 0 errors, 1 warnings, 130 lines checked

-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
